#include "avrx.h"
#include "stepper.h"

#define PIN_0 3
#define PIN_1 4
#define PIN_2 5
#define PIN_3 6

DSEG
STEP_NUM: BYTE 1

CSEG

ROT_TABLE: DB (1<<PIN_0), (1<<PIN_1), (1<<PIN_2), (1<<PIN_3)

.global setup
setup:
	; config 2,3,4,5 digital pins
	; mapping:
	;  - IN1 -> pin 6: PORTH[3]
	;  - IN2 -> pin 7: PORTH[4]
	;  - IN3 -> pin 8: PORTH[5]
	;  - IN4 -> pin 9: PORTH[6]
	; in output mode

	ldi r16, (1<<PIN_0)|(1<<PIN_1)|(1<<PIN_2)|(1<<PIN_3)
	sts DDRH, r16

	ldi r16, 0x0
	sts STEP_NUM, r16

	ret

.global loop
loop:

	; runs two loops:
	; one in the CW mode,
	; and the other in CCW mode
	
	ldi r18, CW_MODE
	rcall rotate_loop
	call delay_1

	ldi r18, CCW_MODE
	rcall rotate_loop 
	call delay_1

	ret

;-------------------------------
;
;   void rotate_loop(bool dir);
; 	dir: r18
;
rotate_loop:
	; max iteration
	ldi r17, 0xFF

forloop:
	rcall one_step
	call mili_delay_2

	dec r17
	brne forloop

	ret

;----------------------------------
;--- make one step of the motor ---
;----------------------------------
;
;   void one_step(bool dir);
; 	dir: r18
;
one_step:

	push r17

	lds r17, STEP_NUM

	tst r18
	breq ccw_rot

	mov r16, r17
	
	rjmp finish

ccw_rot:

	ldi r16, 0x03
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

	andi r17, 0x03

	sts STEP_NUM, r17
	
	pop r17

	ret

