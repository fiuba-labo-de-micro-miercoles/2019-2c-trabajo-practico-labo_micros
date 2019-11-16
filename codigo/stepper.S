#include "avrx.h"
#include "stepper.h"

#define MAX_SEQ 8

;-----------------------------------
;--- 28BYJ-48 5V - Stepper motor ---
;-----------------------------------

DSEG
STEP_NUM: BYTE 1

CSEG
ROT_TABLE: DB 0x08, 0x18, 0x10, 0x30, 0x20, 0x60, 0x40, 0x48

;---------------------------
;-----   INITIALIZE   ------
;---------------------------
;
;--- void stepper_init(void);
;
.global stepper_init
stepper_init:

	; config digital pins
	; mapping:
	;  - IN1 -> pin 9: PORTH[6]
	;  - IN2 -> pin 8: PORTH[5]
	;  - IN3 -> pin 7: PORTH[4]
	;  - IN4 -> pin 6: PORTH[3]
	; in output mode

	ldi r16, (1<<PIN_0)|(1<<PIN_1)|(1<<PIN_2)|(1<<PIN_3)
	sts DDRH, r16

	ldi r16, 0x0
	sts STEP_NUM, r16

	ret

;----------------------------------------
;--- moves 'steps' in 'dir' direction ---
;----------------------------------------
;
;   void stepper_move(uint8_t dir, uint16_t steps);
; 	dir: r18
; 	steps: r20:r19
;
.global stepper_move
stepper_move:

	push r26
	push r27

	; max iteration
	mov r26, r19
	mov r27, r20 

forloop:
	rcall one_step
	call mili_delay_1

	sbiw r26, 0x1
	brne forloop

	pop r27
	pop r26

	ret

;----------------------------------
;--- make one step of the motor ---
;----------------------------------
;
;   void one_step(uint8_t dir);
; 	dir: r18
;
one_step:

	push r16
	push r17

	lds r17, STEP_NUM

	tst r18
	breq ccw_rot

	mov r16, r17
	
	rjmp finish

ccw_rot:

	ldi r16, MAX_SEQ-1
	sub r16, r17

finish:

	ldi ZH, HIGH(ROT_TABLE)
	ldi ZL, LOW(ROT_TABLE)

	add ZL, r16
	clr r0
	adc ZH, r0

	lpm r16, Z

	sts PORTH, r16

	inc r17

	andi r17, MAX_SEQ-1

	sts STEP_NUM, r17
	
	pop r17
	pop r16

	ret

