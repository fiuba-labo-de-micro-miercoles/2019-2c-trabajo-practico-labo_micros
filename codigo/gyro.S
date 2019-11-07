#include "gyro.h"

;------------------------------
;----   Get Acceleration  -----
;------------------------------

.global get_acceleration
get_acceleration:

	ldi ACCEL_X_H, 'A'
	ldi ACCEL_X_L, 'B'
	ldi ACCEL_Y_H, 'C'
	ldi ACCEL_Y_L, 'D'
	ldi ACCEL_Z_H, 'E'
	ldi ACCEL_Z_L, 'F'

	call i2c_start

	ldi r16, ACCEL_ADDR
	call i2c_connect

	call i2c_init_read

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

	ldi GYRO_X_H, 'A'
	ldi GYRO_X_L, 'B'
	ldi GYRO_Y_H, 'C'
	ldi GYRO_Y_L, 'D'
	ldi GYRO_Z_H, 'E'
	ldi GYRO_Z_L, 'F'

	call i2c_start

	ldi r16, GYRO_ADDR
	call i2c_connect

	call i2c_init_read

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

