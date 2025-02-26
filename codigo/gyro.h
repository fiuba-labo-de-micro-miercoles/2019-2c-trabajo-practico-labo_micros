#ifndef GYRO_H
#define GYRO_H

// Acceleration Address register
// to start reading
#define ACCEL_ADDR 0x3B

// Gyroscope Address register
// to start reading
#define GYRO_ADDR 0x43

/////////////////////////////////////
//      Acceleration Registers     //
/////////////////////////////////////
//
#define ACCEL_X_H r18
#define ACCEL_X_L r19
#define ACCEL_Y_H r20
#define ACCEL_Y_L r21
#define ACCEL_Z_H r22
#define ACCEL_Z_L r23

//////////////////////////////////
//      Gyroscope Registers     //
//////////////////////////////////
//
#define GYRO_X_H r18
#define GYRO_X_L r19
#define GYRO_Y_H r20
#define GYRO_Y_L r21
#define GYRO_Z_H r22
#define GYRO_Z_L r23

#endif // GYRO_H
