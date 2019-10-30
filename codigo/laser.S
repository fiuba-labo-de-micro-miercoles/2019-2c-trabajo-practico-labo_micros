#include "avrx.h"

.global setup
setup:

	call init_serial
	call init_i2c

	ret

.global loop
loop:
	ldi r16, 'a'
	
	call transmit
	
	call delay_1
	
	rjmp loop

