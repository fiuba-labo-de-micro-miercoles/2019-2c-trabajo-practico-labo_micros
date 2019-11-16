#!/usr/bin/env bash

set -eu

avr-gcc -mmcu=atmega2560 -Os -g test_stepper.c -o test_stepper
avr-objdump -D -S test_stepper > test_stepper.asm
avr-objcopy -O ihex test_stepper test_stepper.hex

