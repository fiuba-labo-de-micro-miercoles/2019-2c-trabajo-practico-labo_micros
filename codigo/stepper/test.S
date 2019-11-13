#include "avrx.h"
#include "stepper.h"

#define PIN_2 4
#define PIN_3 5
#define PIN_4 5
#define PIN_5 3

CSEG

.global setup
setup:

	; config 2,3,4,5 digital pins
	; mapping:
	;  - pin 2: PORTE[4]
	;  - pin 3: PORTE[5]
	;  - pin 4: PORTG[5]
	;  - pin 5: PORTE[3]
	; in output mode

	ldi r16, (1<<PIN_2)|(1<<PIN_3)|(1<<PIN_5)
	out _SFR_IO_ADDR(DDRE), r16

	sbi _SFR_IO_ADDR(DDRG), PIN_4

	ret

.global loop
loop:

	; runs two loops:
	; one in the CW mode,
	; and the other in CCW mode
	
	ldi r16, 0x1
	rcall rotate_loop 
	call delay_1

	ldi r16, 0x0
	rcall rotate_loop 
	call delay_1

	ret

rotate_loop:
	; max iteration
	ldi r17, STEPS_PER_REV_HALF

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
; 	dir: r16
;
one_step:

	tst r16
	brne ccw_rot

	
	
	rjmp finish	

ccw_rot:



finish:
	ret

