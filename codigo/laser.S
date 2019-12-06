#include "avrx.h"
#include "gyro.h"
#include "stepper.h"

#define STEPS_IN_BURST 16
#define THRESHOLD_ACCEL_POSITIVE 300
#define THRESHOLD_ACCEL_NEGATIVE -300
#define POWER_SAVE_MODE 0b00000001
#define PRESCALE      0b00000011
#define ONLY_OVERFLOW   0b00000001

CSEG
.global setup
setup:

	call serial_init
	call i2c_init
	call stepper_init
	

	ldi r16, POWER_SAVE_MODE ; enable power_save_mode for later
	out _SFR_IO_ADDR(SMCR), r16
	

	ldi r16, PRESCALE
	sts TCCR1B, r16; start timer

	ldi r16, ONLY_OVERFLOW
	sts TIMSK1, r16 
	sei ; enable interruptions

	ret 

.global loop
loop:


	sleep

	ret

.global TIMER1_OVF_vect
TIMER1_OVF_vect:
	
	push r16
	push r17
	push r18
	push r19
	push r20
	push r21
	push r22

	ldi r19, LOW(STEPS_IN_BURST)
	ldi r20, HIGH(STEPS_IN_BURST)

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

	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r17
	pop r16

	reti

