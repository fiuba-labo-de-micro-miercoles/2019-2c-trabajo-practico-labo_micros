#include "avrx.h"
#include "gyro.h"

#define SPACE 0x20
#define ENTER '\n'

DSEG

.extern ACCEL_X_H_VAL
.extern ACCEL_X_L_VAL
.extern ACCEL_Y_H_VAL
.extern ACCEL_Y_L_VAL
.extern ACCEL_Z_H_VAL
.extern ACCEL_Z_L_VAL

.extern GYRO_X_H_VAL
.extern GYRO_X_L_VAL
.extern GYRO_Y_H_VAL
.extern GYRO_Y_L_VAL
.extern GYRO_Z_H_VAL
.extern GYRO_Z_L_VAL

CSEG
.global setup
setup:

	call serial_init
	call i2c_init

	ret

.global loop
loop:
	ldi r16, 'A'
	call serial_transmit
	call delay_1
	rcall print_accel

	ldi r16, 'G'
	call serial_transmit
	call delay_1
	rcall print_gyro

	ret

;******************
;** ACCELERATION **
;******************

print_accel:

	call get_acceleration

	; X Acceleration
	lds r16, ACCEL_X_H_VAL
	call serial_transmit
	call delay_1

	lds r16, ACCEL_X_L_VAL
	call serial_transmit
	call delay_1
	
	ldi r16, SPACE
	call serial_transmit
	call delay_1
	
	; Y Acceleration
	lds r16, ACCEL_Y_H_VAL
	call serial_transmit
	call delay_1
	
	lds r16, ACCEL_Y_L_VAL
	call serial_transmit
	call delay_1

	ldi r16, SPACE
	call serial_transmit
	call delay_1

	; Z Acceleration
	lds r16, ACCEL_Z_H_VAL
	call serial_transmit
	call delay_1

	lds r16, ACCEL_Z_L_VAL
	call serial_transmit
	call delay_1

	ldi r16, ENTER
	call serial_transmit
	call delay_1

	ret

;**************
;** ROTATION **
;**************

print_gyro:

	call get_rotation

	; X Rotation
	lds r16, GYRO_X_H_VAL
	call serial_transmit
	call delay_1

	lds r16, GYRO_X_L_VAL
	call serial_transmit
	call delay_1

	ldi r16, SPACE
	call serial_transmit
	call delay_1

	; Y Rotation
	lds r16, GYRO_Y_H_VAL
	call serial_transmit
	call delay_1

	lds r16, GYRO_Y_L_VAL
	call serial_transmit
	call delay_1

	ldi r16, SPACE
	call serial_transmit
	call delay_1

	; Z Rotation
	lds r16, GYRO_Z_H_VAL
	call serial_transmit
	call delay_1

	lds r16, GYRO_Z_L_VAL
	call serial_transmit
	call delay_1

	ldi r16, ENTER
	call serial_transmit
	call delay_1

	ret

