#include "avrx.h"
#include "stepper.h"

#define PIN_6 3
#define PIN_7 4
#define PIN_8 5
#define PIN_9 6

DSEG
STEP_NUM: BYTE 1

CSEG

ROT_TABLE: DB (1<<PIN_6), (1<<PIN_7), (1<<PIN_8), (1<<PIN_9)

.global setup
setup:

	call serial_init

	; config 2,3,4,5 digital pins
	; mapping:
	;  - pin 6: PORTH[3]
	;  - pin 7: PORTH[4]
	;  - pin 8: PORTH[5]
	;  - pin 9: PORTH[6]
	; in output mode

	ldi r16, (1<<PIN_6)|(1<<PIN_7)|(1<<PIN_8)|(1<<PIN_9)
	sts DDRH, r16

	ldi r16, 0x0
	sts STEP_NUM, r16

	ret

.global loop
loop:

	; runs two loops:
	; one in the CW mode,
	; and the other in CCW mode
	
	ldi r18, 0x1
	rcall rotate_loop
	call delay_1

	ldi r18, 0x0
	rcall rotate_loop 
	call delay_1

	ret

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

