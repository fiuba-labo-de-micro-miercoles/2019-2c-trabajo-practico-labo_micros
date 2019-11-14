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

.global mili_delay_2
mili_delay_2:

	push r16
	push r17
	push r18

        ldi r16, 30
startLoop3m:
        ldi r17, 1
startLoop2m:
        ldi r18, 255
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

