#!/usr/bin/env bash

set -eu

avr-gcc -mmcu=atmega2560 -Os -g test.c -o test
avr-objdump -D -S test > test.asm
avr-objcopy -O ihex test test.hex
rm test

