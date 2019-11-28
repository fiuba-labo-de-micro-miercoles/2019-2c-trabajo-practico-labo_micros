
/********************************/
/*     Delay util functions     */
/********************************/

;----------------------------------;
; Description:                     ;
;   - makes a 'delay' of 1 second  ;
;                                  ;
; void delay_1(void);              ;
;----------------------------------;

.global delay_1
delay_1:

	push r16
	push r17
	push r18

        ldi r16, 60
startLoop3:
        ldi r17, 255
startLoop2:
        ldi r18, 255
startLoop1:
        dec r18
        brne startLoop1
outWhile1:        
        dec r17
        brne startLoop2
outWhile2:
        dec r16
        brne startLoop3
outWhile3:

	pop r18
	pop r17
	pop r16

	ret

;---------------------------------------;
; Description:                          ;
;   - makes a 'delay' of 1 mili second  ;
;                                       ;
; void mili_delay_1(void);              ;
;---------------------------------------;

.global mili_delay_1
mili_delay_1:

	push r16
	push r17
	push r18

        ldi r16, 2
startLoop3m:
        ldi r17, 51
startLoop2m:
        ldi r18, 51
startLoop1m:
        dec r18
        brne startLoop1m
outWhile1m:        
        dec r17
        brne startLoop2m
outWhile2m:
        dec r16
        brne startLoop3m
outWhile3m:

	pop r18
	pop r17
	pop r16

	ret

;-----------------------------------------;
; Description:                            ;
;   - makes a 'delay' of 100 mili second  ;
;                                         ;
; void mili_delay_100(void);              ;
;-----------------------------------------;

.global mili_delay_100
mili_delay_100:

	push r16
	push r17
	push r18

        ldi r16, 200
startLoop3m100:
        ldi r17, 51
startLoop2m100:
        ldi r18, 51
startLoop1m100:
        dec r18
        brne startLoop1m
outWhile1m100:        
        dec r17
        brne startLoop2m
outWhile2m100:
        dec r16
        brne startLoop3m
outWhile3m100:

	pop r18
	pop r17
	pop r16

	ret

