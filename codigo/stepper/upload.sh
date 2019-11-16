#!/usr/bin/env bash

set -eu

avrdude -p atmega2560 -c avrispmkII -B 0.5 -b 115200 -P /dev/ttyUSB0 -D -U flash:w:test_stepper.hex:i
