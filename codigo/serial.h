#ifndef SERIAL_H
#define SERIAL_H

#define BAUD_RATE 103

// UCSR0A bits 
#define U2X 1

// UCSR0B bits
#define UMSEL1 7
#define UMSEL0 6
#define UPM1 5
#define UPM0 4
#define USBS 3
#define UCSZ1 2
#define UCSZ0 1

// UCSR0C bits
#define RXCIE 7
#define UDRIE 5
#define RXEN 4
#define TXEN 3

#endif // SERIAL_H
