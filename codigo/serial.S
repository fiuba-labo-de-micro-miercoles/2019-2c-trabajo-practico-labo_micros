#include "avrx.h"
#include "serial.h"

.global serial_init
serial_init:

	; transmission rate
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
	
	ret

.global serial_transmit
serial_transmit:

	// it receives data
	// in r16 register
	sts UDR0, r16

	ret


.global serial_transmit_hex
serial_transmit_hex:
	push r18
	push r17
	push r16
	
	mov r18, r16 ; save input

	andi r16, 0x0F ; Take 4 least significant bits to be codified
	call encode_hex
	mov r17, r16 ; Save in r17 LSBs encoded
	
	mov r16, r18 ; restore input
	lsr r16
	lsr r16
	lsr r16
	lsr r16 ; Take 4 most significant bits to be codified
	call encode_hex


	sts UDR0, r16 ; send most significant hex digit
	call mili_delay_1
	sts UDR0, r17 ; send least significant hex digit


	pop r16
	pop r17
	pop r18

	ret
