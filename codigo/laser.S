#include "avrx.h"
#include "gyro.h"
#include "stepper.h"

#define SPACE 0x20
#define ENTER '\n'

CSEG
.global setup
setup:

	call serial_init
	call i2c_init
	call stepper_init

	ret

.global loop
loop:
	ldi r19, LOW(STEPS_PER_REV_HALF/2)
	ldi r20, HIGH(STEPS_PER_REV_HALF/2)
	call get_acceleration
	lds r16, ACCEL_X_H_VAL
	tst r16
	brpl positive; es positivo
	call turn_left
	rjmp finish_loop
positive:
	call turn_right
finish_loop:
	call mili_delay_1
	ldi r16, SPACE
	call serial_transmit
	call delay_1
	ret

;**************
; TURNS
;**************

; 	dir: r18
; 	steps: r20:r19

turn_left:
	ldi r16, 'l'
	call serial_transmit
	ldi r18, 0
	call stepper_move
	ret

turn_right:
	ldi r16, 'r'
	call serial_transmit
	ldi r18, 1
	call stepper_move
	ret
