#include "avrx.h"

.global setup
setup:

	call serial_init
	call i2c_init

	call i2c_start

	ret

.global loop
loop:
	ldi r16, 'a'
	
	call serial_transmit
	
	call delay_1
	
	ret

