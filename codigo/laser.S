#include "avrx.h"
#include "gyro.h"

.global setup
setup:

	call serial_init
	call i2c_init

	ret

.global loop
loop:
	;******************
	;** ACCELERATION **
	;******************

	call get_acceleration

	; X Acceleration
	mov r16, ACCEL_X_H
	call serial_transmit
	mov r16, ACCEL_X_L
	call serial_transmit
	mov r16, '\n'

	; Y Acceleration
	mov r16, ACCEL_Y_H
	call serial_transmit
	mov r16, ACCEL_Y_L
	call serial_transmit
	mov r16, '\n'

	; Z Acceleration
	mov r16, ACCEL_Z_H
	call serial_transmit
	mov r16, ACCEL_Z_L
	call serial_transmit
	mov r16, '\n'

	;**************
	;** ROTATION **
	;**************

	call get_rotation

	; X Rotation
	mov r16, GYRO_X_H
	call serial_transmit
	mov r16, GYRO_X_L
	call serial_transmit
	mov r16, '\n'

	; Y Rotation
	mov r16, GYRO_Y_H
	call serial_transmit
	mov r16, GYRO_Y_L
	call serial_transmit
	mov r16, '\n'

	; Z Rotation
	mov r16, GYRO_Z_H
	call serial_transmit
	mov r16, GYRO_Z_L
	call serial_transmit
	mov r16, '\n'

	call delay_1
	
	ret

