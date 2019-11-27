#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <util/delay.h>

// Steps
#define STEPS_PER_REV 4096
#define STEPS_PER_REV_HALF 2048
#define STEPS_PER_REV_QUAR 1024
#define STEPS_PER_REV_OCTA 512
#define STEPS_PER_REV_SIXT 256

#define MAX 8

#define CW_MODE 0x1
#define CCW_MODE 0x0

#define PIN_0 3
#define PIN_1 4
#define PIN_2 5
#define PIN_3 6

const uint8_t rotation[MAX] PROGMEM = {0x08, 0x18, 0x10, 0x30, 0x20, 0x60, 0x40, 0x48};
uint8_t STEP_NUM;

void setup(void) {

	// config digital pins
	// mapping:
	//  - IN1 -> pin 9: PORTH[6]
	//  - IN2 -> pin 8: PORTH[5]
	//  - IN3 -> pin 7: PORTH[4]
	//  - IN4 -> pin 6: PORTH[3]
	// in output mode

	DDRH = (1<<PIN_0)|(1<<PIN_1)|(1<<PIN_2)|(1<<PIN_3);

	STEP_NUM = 0;
}

void one_step(uint8_t mode) {

	uint8_t byte;
	uint8_t idx, step;

	step = STEP_NUM;

	if (!mode)
		idx = 7 - step;
	else
		idx = step;

	byte = pgm_read_byte(&(rotation[idx]));

	PORTH = byte;

	step++;

	if (step == MAX)
		step = 0;

	STEP_NUM = step;
}

void move(uint8_t mode, unsigned int steps) {

	for (int i = 0; i < steps; i++) {
		one_step(mode);
		_delay_ms(1);
	}
}

void loop(void) {

	move(CW_MODE, STEPS_PER_REV_HALF);
	_delay_ms(1000);

	move(CCW_MODE, STEPS_PER_REV_HALF);
	_delay_ms(1000);
}

int main(void) {

	setup();
	
	while (1) {
		loop();
	}
}

