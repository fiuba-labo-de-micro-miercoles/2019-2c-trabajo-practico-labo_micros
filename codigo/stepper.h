#ifndef STEPPER_H
#define STEPPER_H

#define MAX_SEQ 8

// Used pins
#define PIN_0 3
#define PIN_1 4
#define PIN_2 5
#define PIN_3 6

// Direction
#define CW_MODE 0x1
#define CCW_MODE 0x0

// Steps
#define STEPS_PER_REV 4096
#define STEPS_PER_REV_HALF 2048
#define STEPS_PER_REV_QUAR 1024
#define STEPS_PER_REV_OCTA 512
#define STEPS_PER_REV_SIXT 256

#endif // STEPPER_H
