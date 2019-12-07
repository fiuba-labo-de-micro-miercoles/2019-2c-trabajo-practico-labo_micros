
/********************************/
/*     Delay util functions     */
/********************************/

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
startLoop3:
        ldi r17, 51
startLoop2:
        ldi r18, 51
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
