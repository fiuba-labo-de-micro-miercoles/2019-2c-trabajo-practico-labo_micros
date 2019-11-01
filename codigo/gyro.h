#ifndef GYRO_H
#define GYRO_H

// More bytes
#define MORE_BYTES 0x1
// Stop: no more bytes needed
#define STOP 0x0

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
#define ACCEL_X_H r17
#define ACCEL_X_L r18
#define ACCEL_Y_H r19
#define ACCEL_Y_L r20
#define ACCEL_Z_H r21
#define ACCEL_Z_L r22

//////////////////////////////////
//      Gyroscope Registers     //
//////////////////////////////////
//
#define GYRO_X_H r17
#define GYRO_X_L r18
#define GYRO_Y_H r19
#define GYRO_Y_L r20
#define GYRO_Z_H r21
#define GYRO_Z_L r22

#endif // GYRO_H
