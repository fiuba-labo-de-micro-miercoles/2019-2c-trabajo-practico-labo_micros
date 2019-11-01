#include "gyro.h"

;------------------------------
;----   Get Acceleration  -----
;------------------------------

.global get_acceleration
get_acceleration:

	call i2c_start

	ldi r16, ACCEL_ADDR
	call i2c_connect

	ldi r17, MORE_BYTES
	call i2c_read
	mov ACCEL_X_H, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov ACCEL_X_L, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov ACCEL_Y_H, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov ACCEL_Y_L, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov ACCEL_Z_H, r16

	ldi r17, STOP
	call i2c_read
	mov ACCEL_Z_L, r16

	call i2c_end

	ret

;--------------------------
;----   Get Rotation  -----
;--------------------------

.global get_rotation
get_rotation:

	call i2c_start

	ldi r16, GYRO_ADDR
	call i2c_connect

	ldi r17, MORE_BYTES
	call i2c_read
	mov GYRO_X_H, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov GYRO_X_L, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov GYRO_Y_H, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov GYRO_Y_L, r16

	ldi r17, MORE_BYTES
	call i2c_read
	mov GYRO_Z_H, r16

	ldi r17, STOP
	call i2c_read
	mov GYRO_Z_L, r16

	call i2c_end

	ret

