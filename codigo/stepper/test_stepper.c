#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <util/delay.h>

#include "stepper.h"

#define MAX 4
#define MAX_ITER 255

#define CW_MODE 0x1
#define CCW_MODE 0x0

#define PIN_0 3
#define PIN_1 4
#define PIN_2 5
#define PIN_3 6

unsigned const char rotation[MAX] PROGMEM = {0x08, 0x10, 0x20, 0x04};
static unsigned char STEP_NUM;

void setup(void) {
	DDRH = (1<<PIN_0)|(1<<PIN_1)|(1<<PIN_2)|(1<<PIN_3);
}

void one_step(unsigned char mode) {

	unsigned char byte;
	unsigned char idx, step;

	step = STEP_NUM;

	if (!mode)
		idx = 3 - step;
	else
		idx = step;

	byte = pgm_read_byte(&(rotation[idx]));

	PORTH = byte;

	step++;

	if (step > 4)
		step = 0;

	STEP_NUM = step;
}

void move(unsigned char mode) {

	for (int i = 0; i < MAX_ITER; i++) {
		one_step(mode);
		_delay_ms(2);
	}
}

void loop(void) {

	move(CW_MODE);
	_delay_ms(1000);

	move(CCW_MODE);
	_delay_ms(1000);
}

int main(void) {

	setup();
	
	while (1) {
		loop();
	}
}

