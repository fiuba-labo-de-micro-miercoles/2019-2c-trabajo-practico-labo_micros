#include "avrx.h"
#include "i2c.h"
#include "gyro.h"

/****************************************/
/*   MPU-6050 Gyroscope/Accelerometer   */
/****************************************/

DSEG

.global ACCEL_X_H_VAL
ACCEL_X_H_VAL: BYTE 1
.global ACCEL_X_L_VAL
ACCEL_X_L_VAL: BYTE 1
.global ACCEL_Y_H_VAL
ACCEL_Y_H_VAL: BYTE 1
.global ACCEL_Y_L_VAL
ACCEL_Y_L_VAL: BYTE 1
.global ACCEL_Z_H_VAL
ACCEL_Z_H_VAL: BYTE 1
.global ACCEL_Z_L_VAL
ACCEL_Z_L_VAL: BYTE 1

.global GYRO_X_H_VAL
GYRO_X_H_VAL: BYTE 1
.global GYRO_X_L_VAL
GYRO_X_L_VAL: BYTE 1
.global GYRO_Y_H_VAL
GYRO_Y_H_VAL: BYTE 1
.global GYRO_Y_L_VAL
GYRO_Y_L_VAL: BYTE 1
.global GYRO_Z_H_VAL
GYRO_Z_H_VAL: BYTE 1
.global GYRO_Z_L_VAL
GYRO_Z_L_VAL: BYTE 1

CSEG

;-----------------------------------;
; Description:                      ;
;   - gets acceleration and stores  ;
;     them into global variables    ;
;                                   ;
; void get_acceleration(void);      ;
;-----------------------------------;

.global get_acceleration
get_acceleration:

	call i2c_start

	ldi r16, ACCEL_ADDR
	call i2c_connect

	call i2c_init_read

	ldi r17, MORE_BYTES
	call i2c_read
	sts ACCEL_X_H_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts ACCEL_X_L_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts ACCEL_Y_H_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts ACCEL_Y_L_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts ACCEL_Z_H_VAL, r16

	ldi r17, STOP
	call i2c_read
	sts ACCEL_Z_L_VAL, r16

	call i2c_end

	ret

;--------------------------------------;
; Description:                         ;
;   - gets rotation speeds and stores  ;
;     them into global variables       ;
;                                      ;
; void get_rotation(void);             ;
;--------------------------------------;

.global get_rotation
get_rotation:

	call i2c_start

	ldi r16, GYRO_ADDR
	call i2c_connect

	call i2c_init_read

	ldi r17, MORE_BYTES
	call i2c_read
	sts GYRO_X_H_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts GYRO_X_L_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts GYRO_Y_H_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts GYRO_Y_L_VAL, r16

	ldi r17, MORE_BYTES
	call i2c_read
	sts GYRO_Z_H_VAL, r16

	ldi r17, STOP
	call i2c_read
	sts GYRO_Z_L_VAL, r16

	call i2c_end

	ret

