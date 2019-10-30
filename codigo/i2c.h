#ifndef I2C_H
#define I2C_H

// Mask STATUS CODE
#define STAT_CODE 0xF8

// Start code
#define START 0x08

// Slave Address in HIGH mode
#define SLA 0x69
// Slave Address + Master mode: Read
// SLA_R
#define SLA_R (SLA + 0)

// SLA_R_ACK code
#define SLA_R_ACK 0x40

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
