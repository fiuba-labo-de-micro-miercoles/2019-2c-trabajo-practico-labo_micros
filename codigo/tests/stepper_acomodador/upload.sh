#!/usr/bin/env bash

set -eu

PORT=$1

avrdude -p atmega2560 -c avrispmkII -B 0.5 -b 115200 -P $PORT -D -U flash:w:test.hex:i
