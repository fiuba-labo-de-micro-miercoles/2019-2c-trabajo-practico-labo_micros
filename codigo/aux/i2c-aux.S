/*
 * via_serie.asm
 * Created: 03/10/2017 11:15:10
 * Author: RA
 * driver ch340 en http://sparks.gogo.co.nz/ch340.html
 * Para grabrar la flash del 2560 en el arduino mega:
 *		avrdude -cwiring -pm2560 -PCOM# -b115200 -D -U flash:w:via_serie.hex:i
 */ 
;-------------------------------------------------------------------------
; Definiciones de los registros y constantes del MCU
;-------------------------------------------------------------------------
.include "m2560def.inc"
; CLOCK DEL SISTEMA = 16MHz

;-------------------------------------------------------------------------
; CODIGOS ESTADO DE I2C
;-------------------------------------------------------------------------
.include "twi.inc"
.equ	TWI_STATUS_MASK	= 0xF8

;-------------------------------------------------------------------------
; PERIFERICOS
;-------------------------------------------------------------------------
; LED  en B.7 (prende con 1)
;
; MPU6050 conectado x I2C con circuito conversor de nivel de 5V a 3.3V
.equ MPU_I2C_ADDR	= 0b1101000	; 110100(AD0), y AD0=0 (dir. de esclavo del MPU)

;-------------------------------------------------------------------------
; SRAM
;-------------------------------------------------------------------------
	.dseg
WHO_AM_I:	.byte	1

;-------------------------------------------------------------------------
; CODIGO 
;-------------------------------------------------------------------------
	.cseg
	RJMP	MAIN

	.org	INT_VECTORS_SIZE
MAIN:
	; el stack viene inicializado dde. el reset en RAMEND
	sbi		DDRB, 7		; led es una salida
	cbi		PORTB,7		; led off

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
	sts		TWCR, r16				; mando a LEER UN DATO y NO doy ack (TWEA=0)
	rcall		espero_int_i2c			; para leer más de un dato se envía (1<<TWINT)|(1<<TWEN)|(1<<TWEA)

	lds		r16, TWSR
	andi		r16, TWI_STATUS_MASK
	cpi		r16, MR_DATA_NACK		; al leer más de un dato se espera MR_DATA_ACK
	brne		X_SIEMPRE

	lds		r16, TWDR				; LEO EL DATO (obtenido en la transacción i2c precedente)
	sts		WHO_AM_I, r16			; salvo en variable de SRAM

	ldi		r16, (1<<TWINT)|(1<<TWSTO)|(1<<TWEN)
	sts		TWCR, r16				; doy stop (y el flag de int. no se vuelve a levantar)

	lds		r16, WHO_AM_I
	cpi		r16, 0x68				; verifico la dirección x defecto del MPU6050
	brne		X_SIEMPRE

DEBUG_OK:
	sbi		PORTB,7					; led on (salió todo bien)

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
