#ifndef I2C_H
#define I2C_H

// Default MPU 6050 address
#define MPU_6050_DEF_ADDR 0x68

// Mask STATUS CODE
#define STAT_CODE_MASK 0xF8

///////////////////////////////////
//      General status code      //
///////////////////////////////////
//
// Start code
#define START 0x08
// Repeated Start
#define REP_START 0x10

/////////////////////////////////////////
//    Master Transmitter status code   //
/////////////////////////////////////////
// 
// SLA+W transmitted and ACK received
#define SLA_W_ACK 0x18
// SLA+W transmitted and NACK received
#define SLA_W_NACK 0x20
// Data byte transmitted and ACK received
#define DATA_SEND_ACK 0x28
// Data byte transmitted and NACK received
#define DATA_SEND_NACK 0x30

/////////////////////////////////////////
//     Master Receiver status code     //
/////////////////////////////////////////
// 
// SLA+R transmitted and ACK received
#define SLA_R_ACK 0x40
// SLA+R transmitted and NACK received
#define SLA_R_NACK 0x48
// Data byte received and ACK returned
#define DATA_RECV_ACK 0x50
// Data byte returned and NACK returned
#define DATA_RECV_NACK 0x58

////////////////////////
//    Slave Address   //
////////////////////////
//
// Slave Address in LOW mode (AD0=0)
#define SLA MPU_6050_DEF_ADDR
// Slave Address + Master mode: write
// SLA_W
#define SLA_W (SLA<<1 + 0)
// Slave Address + Master mode: Read
// SLA_R
#define SLA_R (SLA<<1 + 1)

/////////////////////
//  Register bits  //
/////////////////////
//
// TWCR bits
#define TWINT 7
#define TWEA 6
#define TWSTA 5
#define TWSTO 4
#define TWWC 3
#define TWEN 2
#define TWIE 0

// TWSR bits
#define TWPS0 0
#define TWPS1 1

#endif // I2C_H
