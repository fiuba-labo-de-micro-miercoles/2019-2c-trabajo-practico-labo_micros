#include "avrx.h"
#include "gyro.h"
#include "stepper.h"

#define STEPS_IN_BURST 16
#define THRESHOLD_ACCEL_POSITIVE 300
#define THRESHOLD_ACCEL_NEGATIVE -300

CSEG
.global setup
setup:

	call serial_init
	call i2c_init
	call stepper_init
	ldi r19, LOW(STEPS_IN_BURST)
	ldi r20, HIGH(STEPS_IN_BURST)
	ret

.global loop
loop:

	call get_acceleration
	
	lds r16, ACCEL_X_L_VAL
	lds r17, ACCEL_X_H_VAL


	; comparacion de mayor threshold mayor
	ldi r21, LOW(THRESHOLD_ACCEL_POSITIVE)
	ldi r22, HIGH(THRESHOLD_ACCEL_POSITIVE)
	sub r21, r16
	sbc r22, r17
	; si es mayor que el threshold i.e. el threshold es menor que la acel
	brlt turn_cw ; ir a girar sentido horario

	; sino comparacion de mayorthreshold menor
	ldi r21, LOW(THRESHOLD_ACCEL_NEGATIVE)
	ldi r22, HIGH(THRESHOLD_ACCEL_NEGATIVE)
	sub r21, r16
	sbc r22, r17
	; si es mayor que el threshold i.e. el threshold es menor que la acel
	brlt finish_loop; ir al fin

	; sino girar a la izquierda
	ldi r18, 1
	call stepper_move

	rjmp finish_loop
turn_cw:
	ldi r18, 0
	call stepper_move
finish_loop:

	call mili_delay_100
	ret

;**************
; TURNS
;**************

; 	dir: r18
; 	steps: r20:r19

turn_left:
	ldi r16, 'l'
	call serial_transmit
	ldi r18, 1
	call stepper_move
	ret

turn_right:
	ldi r16, 'r'
	call serial_transmit
	ret
