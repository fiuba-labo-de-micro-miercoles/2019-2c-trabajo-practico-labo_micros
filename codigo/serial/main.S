#include "avrx.h"

#define BAUD_RATE 103

;; UCSR0A bits 
#define U2X 1

;; UCSR0B bits
#define UMSEL1 7
#define UMSEL0 6
#define UPM1 5
#define UPM0 4
#define USBS 3
#define UCSZ1 2
#define UCSZ0 1

;; UCSR0C bits
#define RXCIE 7
#define RXEN 4
#define TXEN 3
#define UDRIE 5

CSEG
	rjmp main

ORG _VECTORS_SIZE
.global main
main:
	; initialize the stack
	; pointer to RAMEND
	ldi r16, HIGH(RAMEND)
	out _SFR_IO_ADDR(SPH), r16
	ldi r16, LOW(RAMEND)
	out _SFR_IO_ADDR(SPL), r16

	; transmition rate
	ldi r16, HIGH(BAUD_RATE)
	sts UBRR0H, r16
	ldi r16, LOW(BAUD_RATE)
	sts UBRR0L, r16
	
	; async mode and full speed
	ldi r16, (1<<U2X)
	sts UCSR0A, r16
	ldi r16, (0<<UMSEL1)|(0<<UMSEL0)|(0<<UPM1)|(0<<UPM0)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)
	sts UCSR0C, r16
	ldi r16, (0<<RXCIE)|(1<<RXEN)|(1<<TXEN)|(0<<UDRIE)
	sts UCSR0B, r16

loop:
	ldi r16, 'a'
	sts UDR0, r16
	rcall delay_1
	rjmp loop

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

here: rjmp here

