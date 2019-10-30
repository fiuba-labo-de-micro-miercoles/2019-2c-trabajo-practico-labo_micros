#include "avrx.h"
#include "i2c.h"

.global i2c_init
i2c_init:

	; it uses the TWI:
	; Two Wire Interface
	
	; pre-scaler
	ldi r16, (0<<TWPS1)|(1<<TWPS0)
	sts TWSR, r16

	; sets bit-rate
	ldi r16, 0x47
	sts TWBR, r16

	; enables the TWI
	; interface
	ldi r16, (1<<TWEN)|(0<<TWIE)
	sts TWCR, r16

	ret

.global i2c_start
i2c_start:

	; sends the START request
	; to receive data from slave
	ldi r16, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	; to indicate START condition
	; has been transmited
wait_start:
	lds r16, TWCR
	sbrs r16, TWINT
	rjmp wait_start

	; check TWI status register
	; to verify START status
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE
	cpi r16, START
	brne error

	; loads SLA_R into TWDR
	; and clears TWINT in TWCR
	; register to start transmission
	; of address
	ldi r16, SLA_R
	sts TWDR, r16
	ldi r16, (1<<TWINT)|(1<<TWEN)
	sts TWCR, r16

	; waits TWINT flag set
	; to indicate SLA_R
	; has been transmited
	; and the ACK has been received
wait_sla_r:
	lds r16, TWCR
	sbrs r16, TWINT
	rjmp wait_sla_r

	; check TWI status register
	; to verify SLA_R ACK received,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE
	cpi r16, SLA_R_ACK
	brne error

	ret

.global i2c_receive
i2c_receive:

	; returns value in
	; r17 register
	lds r17, TWDR

	; check TWI status register
	; to verify correction in
	; byte received and ACK send,
	; goto error otherwise
	lds r16, TWSR
	andi r16, STAT_CODE
	cpi r16, DATA_RECV_ACK
	brne error

	ret

; error jump code
; loops for ever
error: rjmp error

