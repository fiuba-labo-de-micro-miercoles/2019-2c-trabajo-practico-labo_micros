#include "avrx.h"
#include "stepper.h"

.global setup
setup:

	call stepper_init
	call serial_init
	ret

.global loop
loop:

	; runs two loops:
	; one in the CW mode,
	; and the other in CCW mode

	ldi r16, 'l'
	call serial_transmit
	ldi r18, CW_MODE
	ldi r19, LOW(STEPS_PER_REV_HALF)
	ldi r20, HIGH(STEPS_PER_REV_HALF)
	call stepper_move
	call delay_1

	ldi r16, 'r'
	call serial_transmit
	ldi r18, CCW_MODE
	ldi r19, LOW(STEPS_PER_REV_HALF)
	ldi r20, HIGH(STEPS_PER_REV_HALF)
	rcall stepper_move
	call delay_1

	ret

