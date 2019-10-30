#include "avrx.h"

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

	call setup
	call loop

here: rjmp here

