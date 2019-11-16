; Copiado de la hoja de datos del ATmega163, pag.96 y 97.
; 
;***** General Master status codes *****
.equ	START			=$08	; START has been transmitted
.equ	REP_START		=$10	; Repeated START has been transmitted


;***** Master Transmitter status codes *****
.equ	MT_SLA_ACK		=$18	; SLA+W has been transmitted and ACK received
.equ	MT_SLA_NACK		=$20	; SLA+W has been transmitted and NACK received
.equ	MT_DATA_ACK		=$28	; Data byte has been transmitted and ACK received
.equ	MT_DATA_NACK	=$30	; Data has been transmitted and NACK received
.equ	MT_ARB_LOST		=$38	; Arbitration lost in SLA+W or data bytes


;***** Master Receiver status codes *****
.equ	MR_ARB_LOST		=$38	; Arbitration lost in SLA+R or NACK bit
.equ	MR_SLA_ACK		=$40	; SLA+R has been transmitted and ACK received
.equ	MR_SLA_NACK		=$48	; SLA+R has been transmitted and NACK received
.equ	MR_DATA_ACK		=$50	; Data byte has been received and ACK returned
.equ	MR_DATA_NACK	=$58	; Data byte has been received and NACK returned


;***** Slave Transmitter status codes *****
.equ	ST_SLA_ACK		=0xA8	; Own SLA+R has been received and ACK returned
.equ	ST_DATA_ACK		=0xB8	; Data byte has been transmitted and ACK received
.equ	ST_DATA_NACK	=0xC0	; Data byte has been transmitted an NACK received

.equ	ST_LAST_DATA	=0xC8	; Last byte in I2DR has been transmitted
								; (TWEA = '0'), ACK has been received
.equ	ST_ARB_LOST_SLA_ACK	=$B0; Arbitration lost in SLA+R/W as Master. Own
								; SLA+W has been received and ACK returned.


;***** Slave Receiver status codes *****
.equ	SR_GCALL_ACK	=0x70	; General call has been received and ACK returned
.equ	SR_SLA_ACK		=0x60	; SLA+R has been received and ACK returned
.equ	SR_GCALL_DATA_ACK =0x90	; Previously addressed with General Call. Data
								; byte has been received and ACK returned.
.equ	SR_DATA_ACK		=0x80	; Previously addressed with own SLA+W. Data byte
								; has been received and ACK returned.
.equ	SR_STOP			=0xA0	; A STOP or repeated START condition has been
								; received while still addressed as a slave.

.equ	SR_GCALL_DATA_NACK=0x98	; Previously addressed with General Call. Data
								; byte has been received and NACK returned.
.equ	SR_DATA_NACK	=0x88	; Previously addressed with own SLA+W. Data byte
								; has been received and NACK returned.

.equ	SR_ARB_LOST_SLA_ACK=$68 ; Arbitration lost in SLA+R/W as Master. Own
								; SLA+R has been received and ACK returned
.equ	SR_ARB_LOST_GCALL_ACK =$78
								; Arbitration lost in SLA+R/W as Master. General
								; call has been received and ACK returned



;***** Miscellanous States *****
.equ	BUS_ERROR		=0x00	; Bus error due to illegal START or STOP condition.
.equ	NO_INFO			=$F8	; No relevant state information, TWINT = '0'

