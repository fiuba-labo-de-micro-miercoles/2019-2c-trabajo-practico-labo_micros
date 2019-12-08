#include "avrx.h"

#define STEPS_IN_BURST 8

#define THRESHOLD_ACCEL_POSITIVE 300
#define THRESHOLD_ACCEL_NEGATIVE -300

#define SLEEP_EN 0x1
#define IDLE_MODE 0x0

#define PRESCALE        0b00000011
#define ONLY_OVERFLOW   0b00000001

CSEG

;--------------------------------;
;              SETUP             ;
; Description:                   ;
;   Function that gets executed  ;
;   once the microcontroller is  ;
;   turned on                    ;
;                                ;
; void setup(void)               ;
;--------------------------------;

.global setup
setup:

	call i2c_init
	call stepper_init

	; enables sleep mode and sets it
	; in "idle-mode" for later
	ldi r16, (IDLE_MODE | SLEEP_EN)
	out _SFR_IO_ADDR(SMCR), r16	

	ldi r16, PRESCALE
	sts TCCR1B, r16; start timer

	ldi r16, ONLY_OVERFLOW
	sts TIMSK1, r16 

	sei ; enable interruptions

	ret 

;--------------------------------;
;              LOOP              ;
; Description:                   ;
;   Function that gets executed  ;
;   constantly after the setup   ;
;                                ;
; void loop(void)                ;
;--------------------------------;

.global loop
loop:
	sleep
	ret

;-------------------------------;
;   INTER HANDLER TIMER1 OVF    ;
; Description:                  ;
;   Handler of timer1 overflow  ;
;   interruption. It reads      ;
;   from the accelerometer and  ;
;   turns the stepper to        ;
;   correct the deviation       ;
;   measured                    ;
;                               ;
; void timer1_ovf_vect(void)    ;
;-------------------------------;

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

	; sino comparacion con el threshold menor
	ldi r21, LOW(THRESHOLD_ACCEL_NEGATIVE)
	ldi r22, HIGH(THRESHOLD_ACCEL_NEGATIVE)
	sub r21, r16
	sbc r22, r17
	; si es mayor que el threshold i.e. el threshold es menor que la acel
	brlt finish_handler; ir al fin

	; sino girar a la izquierda
	ldi r18, 1
	call stepper_move

	rjmp finish_handler

turn_cw:

	ldi r18, 0
	call stepper_move

finish_handler:

	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r17
	pop r16

	reti

