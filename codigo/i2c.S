#include "avrx.h"
#include "i2c.h"

/******************************/
/*      TWI-I2C Protocol      */
/******************************/

DSEG
WHO_AM_I_ADDR: BYTE 1

CSEG

;--------------------------------------------;
; Description:                               ;
;   - Starts the connection with             ;
;     the MPU-6050 device and ask it         ;
;     to receive the WHO_AM_I value,         ;
;     and checks if the value is correct.    ;
;     It also, enables the sensors, because  ;
;     by default, they come in sleep-mode.   ;
;                                            ;
; void i2c_init(void);                       ;
;--------------------------------------------;

.global i2c_init
i2c_init:

	; it uses the TWI:
	; Two Wire Interface
	
	; pre-scaler
	ldi r16, (0<<TWPS1)|(0<<TWPS0)
	sts TWSR, r16

	; sets bit-rate
	ldi r16, 0x48
	sts TWBR, r16

	; enables the TWI
	; interface
	ldi r16, (1<<TWEN)|(0<<TWIE)
	sts TWCR, r16

	call i2c_start

	; reads from WHO_AM_I
	; register
	ldi r16, WHO_AM_I_RA
	call i2c_connect

	; check WHO_AM_I
	; received value
	call check_connection

	; enables the sensor
	; by writing the SLEEP-MODE
	; bit (put a zero)
	; into the PWR_MGMT_1 register
	call enable_sensor

	ret

;--------------------------------------------;
; Description:                               ;
;   - Starts the connection with             ;
;     the MPU-6050 device in WRITE mode      ;
;                                            ;
; void i2c_start(void);                      ;
;--------------------------------------------;

.global i2c_start
i2c_start:

	; sends the START request
	; to receive data from slave
	ldi r16, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	call wait_int_i2c

	; check TWI status register
	; to verify START status
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, START
	call check_error

	; loads SLA_W into TWDR
	; and clears TWINT in TWCR
	; register to start transmission
	; of address
	ldi r16, SLA_W
	sts TWDR, r16
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	call wait_int_i2c

	; check TWI status register
	; to verify SLA_W ACK received,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, SLA_W_ACK
	call check_error

	ret

;---------------------------------------------;
; Description:                                ;
;   - Connects with the MPU-6050 device, and  ;
;     tells it which register it's going to   ;
;     read                                    ;
;                                             ;
; void i2c_connect(uint8_t regaddr);          ;
; 	regaddr: r16                          ;
;---------------------------------------------;

.global i2c_connect
i2c_connect:

	; register address comes
	; in r16
	sts TWDR, r16
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	call wait_int_i2c

	; check TWI status register
	; to verify DATA ACK received,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, DATA_SEND_ACK
	call check_error

	; repeats start
	ldi r16, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag
	call wait_int_i2c

	; check TWI status register
	; to verify REPEATED START,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, REP_START
	call check_error

	ret

;------------------------------------------;
; Description:                             ;
;   - Initializes reading protocol, by     ;
;     sending the slave address in         ;
;     READ mode. It should only be called  ;
;     once before start reading bytes      ;
;     from the device.                     ;
;                                          ;
; void i2c_init_read(void);                ;
;------------------------------------------;

.global i2c_init_read
i2c_init_read:

	; loads slave address in read mode
	ldi r16, SLA_R
	sts TWDR, r16
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag
	call wait_int_i2c

	; check TWI status register
	; to verify SLA_R ACK received,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, SLA_R_ACK
	call check_error

	ret

;----------------------------------------------;
; Description:                                 ;
;   - Reads a byte from the device.            ;
;     Depending on the argument 'more'         ;
;     it will send an ACK if 'more' is true    ;
;     or it will send a NACK, if 'more' is     ;
;     false. The argument 'more', stands for   ;
;     more bytes to be read after              ;
;     the current one.                         ;
;                                              ;
; void i2c_read(uint8_t more);                 ;
; 	more: r17                              ;
;----------------------------------------------;

.global i2c_read
i2c_read:
	
	; sends "signal" to slave
	; to read data from it
	ser r16
	sts TWDR, r16

	;*********************************
	; Send ACK or NACK, and wait
	; for it, depending on
	; the amount of bytes to read.
	; For example, if more bytes
	; are going to be read,
	; ACK must be sent, otherwise
	; NACK must be sent.
	;*********************************

	tst r17
	breq stop_read

	ldi r16, (1<<TWINT)|(1<<TWEN)|(1<<TWEA)
	sts TWCR, r16

	; waits TWINT flag
	call wait_int_i2c

	; check TWI status register
	; to verify DATA received
	; with ACK returned,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, DATA_RECV_ACK
	call check_error

	rjmp finish_read

stop_read:
	
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag
	call wait_int_i2c

	; check TWI status register
	; to verify DATA received
	; without ACK returned,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, DATA_RECV_NACK
	call check_error

finish_read:

	; reads the data obtained
	; with the previous transaction
	lds r16, TWDR

	ret

;--------------------------------;
; Description:                   ;
;   - Send the STOP signal.      ;
;                                ;
; void i2c_end(void);            ;
;--------------------------------;

.global i2c_end
i2c_end:

	; sends STOP signal
	ldi r16, (1<<TWINT)|(1<<TWSTO)|(1<<TWEN)
	sts TWCR, r16

	; waits for STOP condition
	; to be executed
wait_stop:
	lds r16, TWCR
	andi r16, (1<<TWSTO)
	brne wait_stop

	ret

;************************
;** Auxiliar Functions **
;************************

;***********************************
;   Enables Sensors by clearing   **
;     the SLEEP-MODE default      **
;***********************************

enable_sensor:

	call i2c_start

	; register address comes
	; in r16
	ldi r16, PWR_MGMT_1_RA
	sts TWDR, r16
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	call wait_int_i2c

	; check TWI status register
	; to verify DATA ACK received,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, DATA_SEND_ACK
	call check_error

	; sends a zero to clear all
	; the bits in that register
	; to make sure that SLEEP-MODE
	; bit is zero
	clr r16
	sts TWDR, r16
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	call wait_int_i2c

	; check TWI status register
	; to verify DATA ACK received,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE_MASK
	cpi r16, DATA_SEND_ACK
	call check_error

	call i2c_end

	ret

;***********************************
;   Verify Slave default Address  **
;***********************************

check_connection:

	call i2c_init_read

	; reads the byte
	ldi r17, STOP
	call i2c_read

	sts WHO_AM_I_ADDR, r16

	call i2c_end

	; compare the value with the
	; default
	lds r16, WHO_AM_I_ADDR
	cpi r16, MPU_6050_DEF_ADDR
	call check_error

	ret

;************************************
;  Loops until TWINT flag is set   **
;************************************

wait_int_i2c:
	lds r16, TWCR
	sbrs r16, TWINT
	rjmp wait_int_i2c
	ret

check_error:
	brne ERROR
	ret

; error jump code
; loops for ever
ERROR: rjmp ERROR

