#include "avrx.h"
/***********************************************/
/* AUTOLEVELING LASER                          */
/* CODE TO BE EXECUTED IN ATMEGA2056 AT 16MHZ  */
/***********************************************/
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

here:
	call loop
	rjmp here

