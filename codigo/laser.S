#include "avrx.h"
#include "gyro.h"

#define SPACE 0x20
#define ENTER '\n'

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
	mov r16, ACCEL_X_H
	call serial_transmit
	call delay_1

	mov r16, ACCEL_X_L
	call serial_transmit
	call delay_1
	
	ldi r16, SPACE
	call serial_transmit
	call delay_1
	
	; Y Acceleration
	mov r16, ACCEL_Y_H
	call serial_transmit
	call delay_1
	
	mov r16, ACCEL_Y_L
	call serial_transmit
	call delay_1

	ldi r16, SPACE
	call serial_transmit
	call delay_1

	; Z Acceleration
	mov r16, ACCEL_Z_H
	call serial_transmit
	call delay_1

	mov r16, ACCEL_Z_L
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
	mov r16, GYRO_X_H
	call serial_transmit
	call delay_1

	mov r16, GYRO_X_L
	call serial_transmit
	call delay_1

	ldi r16, SPACE
	call serial_transmit
	call delay_1

	; Y Rotation
	mov r16, GYRO_Y_H
	call serial_transmit
	call delay_1

	mov r16, GYRO_Y_L
	call serial_transmit
	call delay_1

	ldi r16, SPACE
	call serial_transmit
	call delay_1

	; Z Rotation
	mov r16, GYRO_Z_H
	call serial_transmit
	call delay_1

	mov r16, GYRO_Z_L
	call serial_transmit
	call delay_1

	ldi r16, ENTER
	call serial_transmit
	call delay_1

	ret

