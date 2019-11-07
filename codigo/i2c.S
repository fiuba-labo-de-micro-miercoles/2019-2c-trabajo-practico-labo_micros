#include "avrx.h"
#include "i2c.h"

;-----------------------------
;      TWI-I2C Protocol
;-----------------------------

DSEG
WHO_AM_I_ADDR: BYTE 1

CSEG

;---------------------------
;-----   INITIALIZE   ------
;---------------------------
;
;---- void i2c_init(void);
;
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
	; register: 0x75
	ldi r16, 0x75
	call i2c_connect

	; check WHO_AM_I
	call check_connection

	ret

;************************
;**  START CONNECTION  **
;************************
;
;----- void i2c_start(void);
;
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

;******************
;**  CONNECTION  **
;******************
;
;----- void i2c_connect(regaddr);
;--------- regaddr: r16
;
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

;*****************
;**  READ Byte  **
;*****************
;
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

	; sends "signal" to slave
	; to read data from it
	ser r16
	sts TWDR, r16

	ret

;----- void i2c_read(more);
;---------- more: r17
;
.global i2c_read
i2c_read:

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
	; to verify DATA sent with ACK returned,
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
	; to verify DATA sent without ACK returned,
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

;**********************
;**  END CONNECTION  **
;**********************
;
;----- void i2c_end(void);
;
.global i2c_end
i2c_end:
	; sends STOP signal
	ldi r16, (1<<TWINT)|(1<<TWSTO)|(1<<TWEN)
	sts TWCR, r16

	ret

;************************
;** Auxiliar Functions **
;************************

check_connection:

	;**************************************
	;**  Reads the Slave default Address **
	;**************************************

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

