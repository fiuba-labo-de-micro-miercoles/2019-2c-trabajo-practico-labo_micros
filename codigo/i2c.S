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

	; sends the start request
	; to receive data from slave
	ldi r16, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	sts TWCR, r16

	ret

.global i2c_receive
i2c_receive:

	ret

