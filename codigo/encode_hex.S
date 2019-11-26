#include "avrx.h"

CSEG
HEX_ENCODING: DB '0','1','2','3','4','5', '6','7','8','9','a','b','c','d','e','f'

;---------------------------------;
; Encodes a single byte to a hex
; ascii digit
; Input: r16 - byte to encode
; Output: r16 - byte encoded
;---------------------------------;
.global encode_hex
encode_hex:
    push ZH
    push ZL
    push r17
    push r0

	ldi ZH, HIGH(HEX_ENCODING)
	ldi ZL, LOW(HEX_ENCODING)

	add ZL, r16
	clr r0
	adc ZH, r0

	lpm r16, Z
    
    pop r0
    pop r17
    pop ZL
    pop ZH

    ret