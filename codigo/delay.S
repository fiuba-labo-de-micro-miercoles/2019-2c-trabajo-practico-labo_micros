.global delay_1
delay_1:

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
        ret


