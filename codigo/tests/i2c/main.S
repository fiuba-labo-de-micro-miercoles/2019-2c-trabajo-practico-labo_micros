#include <avr/io.h>
#include <avr/interrupt.h>

// Directives
#define CSEG .text
#define DSEG .data
#define DB .byte
#define BYTE .space
#define ORG .org

// Operators
#define LOW(x) lo8(x)
#define HIGH(x) hi8(x)

;-------------------------------------------------------------------------
; Definiciones de los registros y constantes del MCU
;-------------------------------------------------------------------------
; CLOCK DEL SISTEMA = 16MHz

/////////////////////
//  Register bits  //
/////////////////////
//
// TWCR bits
#define TWINT 7
#define TWEA 6
#define TWSTA 5
#define TWSTO 4
#define TWWC 3
#define TWEN 2
#define TWIE 0

// TWSR bits
#define TWPS0 0
#define TWPS1 1

;-------------------------------------------------------------------------
; CODIGOS ESTADO DE I2C
;-------------------------------------------------------------------------

#define TWI_STATUS_MASK	0xF8

; Copiado de la hoja de datos del ATmega163, pag.96 y 97.
; 
;***** General Master status codes *****
#define	START 0x08	; START has been transmitted
#define	REP_START 0x10	; Repeated START has been transmitted


;***** Master Transmitter status codes *****
#define	MT_SLA_ACK		0x18	; SLA+W has been transmitted and ACK received
#define	MT_SLA_NACK		0x20	; SLA+W has been transmitted and NACK received
#define	MT_DATA_ACK		0x28	; Data byte has been transmitted and ACK received
#define	MT_DATA_NACK	0x30	; Data has been transmitted and NACK received
#define	MT_ARB_LOST		0x38	; Arbitration lost in SLA+W or data bytes


;***** Master Receiver status codes *****
#define	MR_ARB_LOST		0x38	; Arbitration lost in SLA+R or NACK bit
#define	MR_SLA_ACK		0x40	; SLA+R has been transmitted and ACK received
#define	MR_SLA_NACK		0x48	; SLA+R has been transmitted and NACK received
#define	MR_DATA_ACK		0x50	; Data byte has been received and ACK returned
#define	MR_DATA_NACK	0x58	; Data byte has been received and NACK returned


;***** Slave Transmitter status codes *****
#define	ST_SLA_ACK		0xA8	; Own SLA+R has been received and ACK returned
#define	ST_DATA_ACK		0xB8	; Data byte has been transmitted and ACK received
#define	ST_DATA_NACK		0xC0	; Data byte has been transmitted an NACK received

#define	ST_LAST_DATA		0xC8	; Last byte in I2DR has been transmitted
					; (TWEA = '0'), ACK has been received
#define	ST_ARB_LOST_SLA_ACK	0xB0 	; Arbitration lost in SLA+R/W as Master. Own
					; SLA+W has been received and ACK returned.


;***** Slave Receiver status codes *****
#define	SR_GCALL_ACK		0x70	; General call has been received and ACK returned
#define	SR_SLA_ACK		0x60	; SLA+R has been received and ACK returned
#define	SR_GCALL_DATA_ACK 	0x90	; Previously addressed with General Call. Data
					; byte has been received and ACK returned.
#define	SR_DATA_ACK		0x80	; Previously addressed with own SLA+W. Data byte
					; has been received and ACK returned.
#define	SR_STOP			0xA0	; A STOP or repeated START condition has been
					; received while still addressed as a slave.

#define	SR_GCALL_DATA_NACK 	0x98	; Previously addressed with General Call. Data
					; byte has been received and NACK returned.
#define	SR_DATA_NACK		0x88	; Previously addressed with own SLA+W. Data byte
					; has been received and NACK returned.

#define	SR_ARB_LOST_SLA_ACK 	0x68 	; Arbitration lost in SLA+R/W as Master. Own
					; SLA+R has been received and ACK returned
#define	SR_ARB_LOST_GCALL_ACK 	0x78	; Arbitration lost in SLA+R/W as Master. General
					; call has been received and ACK returned

;***** Miscellanous States *****
#define	BUS_ERROR		0x00	; Bus error due to illegal START or STOP condition.
#define	NO_INFO			0xF8	; No relevant state information, TWINT = '0'

;-------------------------------------------------------------------------
; PERIFERICOS
;-------------------------------------------------------------------------
; LED  en B.7 (prende con 1)
;
; MPU6050 conectado x I2C con circuito conversor de nivel de 5V a 3.3V
; 110100(AD0), y AD0=0 (dir. de esclavo del MPU)
#define MPU_I2C_ADDR 0b1101000	

;-------------------------------------------------------------------------
; SRAM
;-------------------------------------------------------------------------
DSEG
WHO_AM_I: BYTE 1

;-------------------------------------------------------------------------
; CODIGO 
;-------------------------------------------------------------------------
CSEG
	rjmp	main

	ORG	_VECTORS_SIZE

.global main
main:
	; el stack viene inicializado dde. el reset en RAMEND
	sbi		_SFR_IO_ADDR(DDRB), 7		; led es una salida
	cbi		_SFR_IO_ADDR(PORTB), 7		; led off

	; configuro I2C SCL en 100KHz
	ldi		r16, 72		; (16000/100 - 16)/2 = 72 V. hoja del MCU p. 242
	sts		TWBR, r16	; sección 25.4.2 Bit Rate Generator Unit
	lds		r16, TWSR
	andi 		r16, ~((1<<TWPS1)|(1<<TWPS0))
	sts		TWSR, r16	; sólo borra los bits TWPS1-0 del TWSR

	; doy start
	ldi		r16, (1<<TWEN)|(1<<TWSTA)|(1<<TWINT)
	sts		TWCR, r16
	rcall		espero_int_i2c

	; verifico que TWSR == START (VER twi.inc)
	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, START
	brne		X_SIEMPRE_I

	ldi		r16, (MPU_I2C_ADDR<<1)	; cargo dirección de esclavo a ESCRIBIR (LSBit = 0)
	sts		TWDR, r16
	ldi		r16, (1<<TWEN)|(1<<TWINT)
	sts		TWCR, r16				; mando a escribir
	rcall		espero_int_i2c

	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, MT_SLA_ACK			; verifico ACK del esclavo
	brne		X_SIEMPRE
	
	ldi		r16, 0x75	; cargo dirección del registro a leer (WHO_AM_I)
	sts		TWDR, r16
	ldi		r16, (1<<TWEN)|(1<<TWINT)
	sts		TWCR, r16				; mando a escribir
	rcall		espero_int_i2c

	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, MT_DATA_ACK
	brne		X_SIEMPRE
	
	; REPITO START
	ldi		r16, (1<<TWEN)|(1<<TWSTA)|(1<<TWINT)
	sts		TWCR, r16
	rcall		espero_int_i2c
	rjmp		sigo

X_SIEMPRE_I:				; salto intermedio, porque el rjmp no llega hasta el final del código
	rjmp		X_SIEMPRE

sigo:
	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, REP_START
	brne		X_SIEMPRE

	ldi		r16, (MPU_I2C_ADDR<<1)+1	; cargo dirección de esclavo a LEER (LSbit = 1)
	sts		TWDR, r16
	ldi		r16, (1<<TWEN)|(1<<TWINT)
	sts		TWCR, r16				; mando a escribir
	rcall		espero_int_i2c

	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, MR_SLA_ACK
	brne		X_SIEMPRE

	ser		r16
	sts		TWDR, r16
	ldi		r16, (1<<TWINT)|(1<<TWEN)
	sts		TWCR, r16			; mando a LEER UN DATO y NO doy ack (TWEA=0)
	rcall		espero_int_i2c	; para leer más de un dato se envía (1<<TWINT)|(1<<TWEN)|(1<<TWEA)

	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, MR_DATA_NACK		; al leer más de un dato se espera MR_DATA_ACK
	brne		X_SIEMPRE

	lds		r16, TWDR 			; LEO EL DATO (obtenido en la transacción i2c precedente)
	sts		WHO_AM_I, r16			; salvo en variable de SRAM

	ldi		r16, (1<<TWINT)|(1<<TWSTO)|(1<<TWEN)
	sts		TWCR, r16			; doy stop (y el flag de int. no se vuelve a levantar)

	lds		r16, WHO_AM_I
	cpi		r16, 0x68			; verifico la dirección x defecto del MPU6050
	brne		X_SIEMPRE

DEBUG_OK:
	sbi		_SFR_IO_ADDR(PORTB),7		; led on (salió todo bien)

X_SIEMPRE:
	rjmp		X_SIEMPRE

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
espero_int_i2c:
	lds		r16, TWCR
	sbrs		r16, TWINT
	rjmp		espero_int_i2c
	ret

;-------------------------------------------------------------------------
; fin del código
;-------------------------------------------------------------------------

