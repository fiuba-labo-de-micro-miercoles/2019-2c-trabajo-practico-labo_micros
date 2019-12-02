EESchema Schematic File Version 4
LIBS:laser-nivel-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "Laser Nivel"
Date "2019-12-01"
Rev "1"
Comp "FIUBA"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
NoConn ~ 6900 1450
Text Label 6800 1300 1    60   ~ 0
IOREF
Text Label 6450 1300 1    60   ~ 0
Vin
Text Label 6450 2550 0    60   ~ 0
A0
Text Label 6450 2650 0    60   ~ 0
A1
Text Label 6450 2750 0    60   ~ 0
A2
Text Label 6450 2850 0    60   ~ 0
A3
Text Label 6450 2950 0    60   ~ 0
A4
Text Label 6450 3050 0    60   ~ 0
A5
Text Label 6450 3150 0    60   ~ 0
A6
Text Label 8050 4750 1    60   ~ 0
22
Text Label 7950 4750 1    60   ~ 0
24
Text Label 7850 4750 1    60   ~ 0
26
Text Label 7750 4750 1    60   ~ 0
28
Text Label 7650 4750 1    60   ~ 0
30
Text Label 7550 4750 1    60   ~ 0
32
Text Label 7450 4750 1    60   ~ 0
34
Text Label 7350 4750 1    60   ~ 0
36
Text Label 7250 4750 1    60   ~ 0
38
Text Label 7150 4750 1    60   ~ 0
40
Text Label 7050 4750 1    60   ~ 0
42
Text Label 6950 4750 1    60   ~ 0
44
Text Label 6850 4750 1    60   ~ 0
46
Text Label 6750 4750 1    60   ~ 0
48
Text Label 6650 4750 1    60   ~ 0
50(MISO)
Text Label 6550 4750 1    60   ~ 0
52(SCK)
Text Label 8050 5750 1    60   ~ 0
23
Text Label 7950 5750 1    60   ~ 0
25
Text Label 7850 5750 1    60   ~ 0
27
Text Label 7650 5750 1    60   ~ 0
31
Text Label 7750 5750 1    60   ~ 0
29
Text Label 7550 5750 1    60   ~ 0
33
Text Label 7450 5750 1    60   ~ 0
35
Text Label 7350 5750 1    60   ~ 0
37
Text Label 7250 5750 1    60   ~ 0
39
Text Label 7150 5750 1    60   ~ 0
41
Text Label 7050 5750 1    60   ~ 0
43
Text Label 6950 5750 1    60   ~ 0
45
Text Label 6850 5750 1    60   ~ 0
47
Text Label 6750 5750 1    60   ~ 0
49
Text Label 6650 5850 1    60   ~ 0
51(MOSI)
Text Label 6550 5850 1    60   ~ 0
53(SS)
Text Label 7950 4200 0    60   ~ 0
21(SCL)
Text Label 7950 3700 0    60   ~ 0
16(Tx2)
Text Label 7950 3600 0    60   ~ 0
15(Rx3)
Text Label 7950 3500 0    60   ~ 0
14(Tx3)
Text Label 7950 1650 0    60   ~ 0
13(**)
Text Label 7950 1750 0    60   ~ 0
12(**)
Text Label 7950 1850 0    60   ~ 0
11(**)
Text Label 7950 1950 0    60   ~ 0
10(**)
Text Label 7950 2050 0    60   ~ 0
9(**)
Text Label 7950 2150 0    60   ~ 0
8(**)
Text Label 7950 2550 0    60   ~ 0
7(**)
Text Label 7950 2650 0    60   ~ 0
6(**)
Text Label 7950 2750 0    60   ~ 0
5(**)
Text Label 7950 2850 0    60   ~ 0
4(**)
Text Label 7950 2950 0    60   ~ 0
3(**)
Text Label 7950 3050 0    60   ~ 0
2(**)
Text Label 7950 3150 0    60   ~ 0
1(Tx0)
Text Label 7950 3250 0    60   ~ 0
0(Rx0)
Text Label 7950 1350 0    60   ~ 0
SDA
Text Label 7950 1250 0    60   ~ 0
SCL
Text Label 7950 1450 0    60   ~ 0
AREF
Text Notes 5925 675  0    60   ~ 0
Shield for Arduino Mega Rev 3
Text Notes 8250 1100 0    60   ~ 0
Holes
$Comp
L laser-nivel-rescue:Conn_01x01-Connector_Generic P8
U 1 1 56D70B71
P 8150 750
F 0 "P8" V 8250 750 31  0000 C CNN
F 1 "CONN_01X01" V 8250 750 50  0001 C CNN
F 2 "Socket_Arduino_Mega:Arduino_1pin" H 8150 750 50  0001 C CNN
F 3 "" H 8150 750 50  0000 C CNN
	1    8150 750 
	0    -1   -1   0   
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x01-Connector_Generic P9
U 1 1 56D70C9B
P 8250 750
F 0 "P9" V 8350 750 31  0000 C CNN
F 1 "CONN_01X01" V 8350 750 50  0001 C CNN
F 2 "Socket_Arduino_Mega:Arduino_1pin" H 8250 750 50  0001 C CNN
F 3 "" H 8250 750 50  0000 C CNN
	1    8250 750 
	0    -1   -1   0   
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x01-Connector_Generic P10
U 1 1 56D70CE6
P 8350 750
F 0 "P10" V 8450 750 31  0000 C CNN
F 1 "CONN_01X01" V 8450 750 50  0001 C CNN
F 2 "Socket_Arduino_Mega:Arduino_1pin" H 8350 750 50  0001 C CNN
F 3 "" H 8350 750 50  0000 C CNN
	1    8350 750 
	0    -1   -1   0   
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x01-Connector_Generic P11
U 1 1 56D70D2C
P 8450 750
F 0 "P11" V 8550 750 31  0000 C CNN
F 1 "CONN_01X01" V 8550 750 50  0001 C CNN
F 2 "Socket_Arduino_Mega:Arduino_1pin" H 8450 750 50  0001 C CNN
F 3 "" H 8450 750 50  0000 C CNN
	1    8450 750 
	0    -1   -1   0   
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x01-Connector_Generic P12
U 1 1 56D711A2
P 8550 750
F 0 "P12" V 8650 750 31  0000 C CNN
F 1 "CONN_01X01" V 8650 750 50  0001 C CNN
F 2 "Socket_Arduino_Mega:Arduino_1pin" H 8550 750 50  0001 C CNN
F 3 "" H 8550 750 50  0000 C CNN
	1    8550 750 
	0    -1   -1   0   
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x01-Connector_Generic P13
U 1 1 56D711F0
P 8650 750
F 0 "P13" V 8750 750 31  0000 C CNN
F 1 "CONN_01X01" V 8750 750 50  0001 C CNN
F 2 "Socket_Arduino_Mega:Arduino_1pin" H 8650 750 50  0001 C CNN
F 3 "" H 8650 750 50  0000 C CNN
	1    8650 750 
	0    -1   -1   0   
$EndComp
NoConn ~ 8150 950 
NoConn ~ 8250 950 
NoConn ~ 8350 950 
NoConn ~ 8450 950 
NoConn ~ 8550 950 
NoConn ~ 8650 950 
$Comp
L laser-nivel-rescue:Conn_01x08-Connector_Generic P2
U 1 1 56D71773
P 7100 1750
F 0 "P2" H 7100 2150 50  0000 C CNN
F 1 "Power" V 7200 1750 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_1x08" H 7100 1750 50  0001 C CNN
F 3 "" H 7100 1750 50  0000 C CNN
	1    7100 1750
	1    0    0    -1  
$EndComp
Text Notes 7200 1450 0    60   ~ 0
1
$Comp
L laser-nivel-rescue:+3V3-power #PWR01
U 1 1 56D71AA9
P 6650 1300
F 0 "#PWR01" H 6650 1150 50  0001 C CNN
F 1 "+3.3V" V 6650 1550 50  0000 C CNN
F 2 "" H 6650 1300 50  0000 C CNN
F 3 "" H 6650 1300 50  0000 C CNN
	1    6650 1300
	1    0    0    -1  
$EndComp
Text Label 6150 1650 0    60   ~ 0
Reset
$Comp
L laser-nivel-rescue:+5V-power #PWR02
U 1 1 56D71D10
P 6550 1150
F 0 "#PWR02" H 6550 1000 50  0001 C CNN
F 1 "+5V" V 6550 1350 50  0000 C CNN
F 2 "" H 6550 1150 50  0000 C CNN
F 3 "" H 6550 1150 50  0000 C CNN
	1    6550 1150
	1    0    0    -1  
$EndComp
$Comp
L laser-nivel-rescue:GND-power #PWR03
U 1 1 56D721E6
P 6800 2250
F 0 "#PWR03" H 6800 2000 50  0001 C CNN
F 1 "GND" H 6800 2100 50  0000 C CNN
F 2 "" H 6800 2250 50  0000 C CNN
F 3 "" H 6800 2250 50  0000 C CNN
	1    6800 2250
	1    0    0    -1  
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x10-Connector_Generic P5
U 1 1 56D72368
P 7500 1650
F 0 "P5" H 7500 2150 50  0000 C CNN
F 1 "PWM" V 7600 1650 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_1x10" H 7500 1650 50  0001 C CNN
F 3 "" H 7500 1650 50  0000 C CNN
	1    7500 1650
	-1   0    0    -1  
$EndComp
$Comp
L laser-nivel-rescue:GND-power #PWR04
U 1 1 56D72A3D
P 7800 2250
F 0 "#PWR04" H 7800 2000 50  0001 C CNN
F 1 "GND" H 7800 2100 50  0000 C CNN
F 2 "" H 7800 2250 50  0000 C CNN
F 3 "" H 7800 2250 50  0000 C CNN
	1    7800 2250
	1    0    0    -1  
$EndComp
$Comp
L laser-nivel-rescue:Conn_01x08-Connector_Generic P6
U 1 1 56D734D0
P 7500 2850
F 0 "P6" H 7500 3250 50  0000 C CNN
F 1 "PWM" V 7600 2850 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_1x08" H 7500 2850 50  0001 C CNN
F 3 "" H 7500 2850 50  0000 C CNN
	1    7500 2850
	-1   0    0    -1  
$EndComp
$Comp
L laser-nivel-rescue:Conn_02x18_Odd_Even-Connector_Generic P1
U 1 1 56D743B5
P 7250 5150
F 0 "P1" H 7250 6100 50  0000 C CNN
F 1 "Digital" V 7250 5150 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_2x18" H 7250 4100 50  0001 C CNN
F 3 "" H 7250 4100 50  0000 C CNN
	1    7250 5150
	0    -1   1    0   
$EndComp
Wire Wire Line
	6650 1300 6650 1350
Wire Wire Line
	6800 1550 6800 1300
Wire Wire Line
	6900 1550 6800 1550
Wire Notes Line
	8000 1100 8000 600 
Wire Notes Line
	8750 1100 8000 1100
Wire Notes Line
	7400 750  7400 575 
Wire Notes Line
	5900 750  7400 750 
Wire Wire Line
	6650 1750 6900 1750
Wire Wire Line
	6550 1150 6550 1850
Wire Wire Line
	6550 1850 6900 1850
Wire Wire Line
	6900 2150 6450 2150
Wire Wire Line
	6450 2150 6450 2000
Wire Wire Line
	6150 1650 6900 1650
Wire Wire Line
	6900 1950 6800 1950
Wire Wire Line
	6800 1950 6800 2050
Wire Wire Line
	6800 2050 6800 2250
Wire Wire Line
	6900 2050 6800 2050
Connection ~ 6800 2050
Wire Wire Line
	7700 1450 7950 1450
Wire Wire Line
	7700 1650 7950 1650
Wire Wire Line
	7950 1750 7700 1750
Wire Wire Line
	7700 1850 7950 1850
Wire Wire Line
	7700 1950 7950 1950
Wire Wire Line
	7800 2250 7800 1550
Wire Wire Line
	7800 1550 7700 1550
Wire Wire Line
	6900 2550 6450 2550
Wire Wire Line
	6450 2650 6900 2650
Wire Wire Line
	6900 2750 6450 2750
Wire Wire Line
	6450 2850 6900 2850
Wire Wire Line
	6900 2950 6450 2950
Wire Wire Line
	6450 3050 6900 3050
Wire Wire Line
	6900 3150 6450 3150
Wire Wire Line
	7950 2750 7700 2750
Wire Wire Line
	7700 2850 7950 2850
Wire Wire Line
	7950 2950 7700 2950
Wire Wire Line
	7700 3050 7950 3050
Wire Wire Line
	7950 3150 7700 3150
Wire Wire Line
	7700 3250 7950 3250
Wire Wire Line
	7950 3500 7700 3500
Wire Wire Line
	7700 3600 7950 3600
Wire Wire Line
	7950 3700 7700 3700
Wire Wire Line
	7700 4200 7950 4200
Wire Wire Line
	8050 4950 8050 4750
Wire Wire Line
	7950 4950 7950 4750
Wire Wire Line
	7850 4950 7850 4750
Wire Wire Line
	7750 4950 7750 4750
Wire Wire Line
	7650 4950 7650 4750
Wire Wire Line
	7550 4950 7550 4750
Wire Wire Line
	7450 4950 7450 4750
Wire Wire Line
	7350 4950 7350 4750
Wire Wire Line
	7250 4950 7250 4750
Wire Wire Line
	7150 4950 7150 4750
Wire Wire Line
	7050 4950 7050 4750
Wire Wire Line
	6950 4950 6950 4750
Wire Wire Line
	6850 4950 6850 4750
Wire Wire Line
	6750 4950 6750 4750
Wire Wire Line
	6650 4950 6650 4750
Wire Wire Line
	6550 4950 6550 4750
Wire Wire Line
	8050 5450 8050 5750
Wire Wire Line
	7950 5450 7950 5750
Wire Wire Line
	7850 5450 7850 5750
Wire Wire Line
	7750 5450 7750 5750
Wire Wire Line
	7650 5450 7650 5750
Wire Wire Line
	7550 5450 7550 5750
Wire Wire Line
	7450 5450 7450 5750
Wire Wire Line
	7350 5450 7350 5750
Wire Wire Line
	7250 5450 7250 5750
Wire Wire Line
	7150 5450 7150 5750
Wire Wire Line
	7050 5450 7050 5750
Wire Wire Line
	6950 5450 6950 5750
Wire Wire Line
	6850 5450 6850 5750
Wire Wire Line
	6750 5450 6750 5750
Wire Wire Line
	6650 5450 6650 5850
Wire Wire Line
	6550 5450 6550 5850
Wire Wire Line
	6450 4950 6200 4950
$Comp
L laser-nivel-rescue:GND-power #PWR05
U 1 1 56D758F6
P 6200 5850
F 0 "#PWR05" H 6200 5600 50  0001 C CNN
F 1 "GND" H 6200 5700 50  0000 C CNN
F 2 "" H 6200 5850 50  0000 C CNN
F 3 "" H 6200 5850 50  0000 C CNN
	1    6200 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 5450 6200 5450
Connection ~ 6200 5450
Wire Wire Line
	8300 5450 8150 5450
Wire Wire Line
	8300 4950 8150 4950
$Comp
L laser-nivel-rescue:+5V-power #PWR06
U 1 1 56D75AB8
P 8300 4650
F 0 "#PWR06" H 8300 4500 50  0001 C CNN
F 1 "+5V" H 8300 4790 50  0000 C CNN
F 2 "" H 8300 4650 50  0000 C CNN
F 3 "" H 8300 4650 50  0000 C CNN
	1    8300 4650
	1    0    0    -1  
$EndComp
Connection ~ 8300 4950
Wire Wire Line
	8300 4650 8300 4950
Wire Wire Line
	8300 4950 8300 5450
Wire Wire Line
	6200 4950 6200 5450
Wire Wire Line
	6200 5450 6200 5850
Wire Wire Line
	6450 4200 6900 4200
Wire Wire Line
	6900 3700 6450 3700
Wire Wire Line
	6450 3600 6900 3600
Wire Wire Line
	6900 3500 6450 3500
Wire Wire Line
	6450 3250 6900 3250
$Comp
L laser-nivel-rescue:Conn_01x08-Connector_Generic P3
U 1 1 56D72F1C
P 7100 2850
F 0 "P3" H 7100 3250 50  0000 C CNN
F 1 "Analog" V 7200 2850 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_1x08" H 7100 2850 50  0001 C CNN
F 3 "" H 7100 2850 50  0000 C CNN
	1    7100 2850
	1    0    0    -1  
$EndComp
Text Label 6450 4200 0    60   ~ 0
A15
Text Label 6450 3700 0    60   ~ 0
A10
Text Label 6450 3600 0    60   ~ 0
A9
Text Label 6450 3500 0    60   ~ 0
A8
Text Label 6450 3250 0    60   ~ 0
A7
Text Label 6450 3800 0    60   ~ 0
A11
Text Label 6450 3900 0    60   ~ 0
A12
Text Label 6450 4000 0    60   ~ 0
A13
Text Label 6450 4100 0    60   ~ 0
A14
$Comp
L laser-nivel-rescue:Conn_01x08-Connector_Generic P4
U 1 1 56D73A0E
P 7100 3800
F 0 "P4" H 7100 4200 50  0000 C CNN
F 1 "Analog" V 7200 3800 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_1x08" H 7100 3800 50  0001 C CNN
F 3 "" H 7100 3800 50  0000 C CNN
	1    7100 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3800 6900 3800
Wire Wire Line
	6900 3900 6450 3900
Wire Wire Line
	6450 4000 6900 4000
Wire Wire Line
	6900 4100 6450 4100
Wire Wire Line
	7950 4100 7700 4100
Wire Wire Line
	7700 4000 7950 4000
Wire Wire Line
	7950 3900 7700 3900
Wire Wire Line
	7700 3800 7950 3800
$Comp
L laser-nivel-rescue:Conn_01x08-Connector_Generic P7
U 1 1 56D73F2C
P 7500 3800
F 0 "P7" H 7500 4200 50  0000 C CNN
F 1 "Communication" V 7600 3800 50  0000 C CNN
F 2 "Socket_Arduino_Mega:Socket_Strip_Arduino_1x08" H 7500 3800 50  0001 C CNN
F 3 "" H 7500 3800 50  0000 C CNN
	1    7500 3800
	-1   0    0    -1  
$EndComp
Text Label 7950 3800 0    60   ~ 0
17(Rx2)
Text Label 7950 3900 0    60   ~ 0
18(Tx1)
Text Label 7950 4000 0    60   ~ 0
19(Rx1)
Text Label 7950 4100 0    60   ~ 0
20(SDA)
$Sheet
S 1550 950  1850 1250
U 5DE4E463
F0 "giro-acel" 50
F1 "giro-acel.sch" 50
$EndSheet
$Sheet
S 1550 2800 1850 1100
U 5DE53536
F0 "stepper-driver" 50
F1 "stepper-driver.sch" 50
$EndSheet
Text GLabel 5550 1100 0    50   Output ~ 0
5V
Text GLabel 5550 1350 0    50   Output ~ 0
3.3V
Text GLabel 8750 1300 2    50   Output ~ 0
SCL
Text GLabel 8750 1450 2    50   Output ~ 0
SDA
Text GLabel 5550 2000 0    50   Output ~ 0
Vin
Text GLabel 8750 2000 2    50   Output ~ 0
IN1
Text GLabel 8750 2200 2    50   Output ~ 0
IN2
Text GLabel 8750 2400 2    50   Output ~ 0
IN3
Text GLabel 8750 2600 2    50   Output ~ 0
IN4
Wire Wire Line
	5550 1100 5650 1100
Wire Wire Line
	6550 1100 6550 1150
Connection ~ 6550 1150
Wire Wire Line
	5550 1350 6650 1350
Connection ~ 6650 1350
Wire Wire Line
	6650 1350 6650 1750
Wire Wire Line
	5550 2000 6450 2000
Connection ~ 6450 2000
Wire Wire Line
	6450 2000 6450 1300
Wire Wire Line
	8500 1250 8500 1300
Wire Wire Line
	8500 1300 8750 1300
Wire Wire Line
	7550 1250 7700 1250
Connection ~ 7700 1250
Wire Wire Line
	7700 1250 8500 1250
Wire Wire Line
	8450 1350 8450 1450
Wire Wire Line
	8450 1450 8750 1450
Wire Wire Line
	7600 1350 7700 1350
Connection ~ 7700 1350
Wire Wire Line
	7700 1350 8450 1350
Wire Wire Line
	8450 2050 8450 2000
Wire Wire Line
	8450 2000 8750 2000
Wire Wire Line
	7500 2050 7700 2050
Connection ~ 7700 2050
Wire Wire Line
	7700 2050 8450 2050
Wire Wire Line
	8450 2150 8450 2200
Wire Wire Line
	8450 2200 8750 2200
Wire Wire Line
	7550 2150 7700 2150
Connection ~ 7700 2150
Wire Wire Line
	7700 2150 8450 2150
Wire Wire Line
	8450 2550 8450 2400
Wire Wire Line
	8450 2400 8750 2400
Wire Wire Line
	7550 2550 7700 2550
Connection ~ 7700 2550
Wire Wire Line
	7700 2550 8450 2550
Wire Wire Line
	8450 2650 8450 2600
Wire Wire Line
	8450 2600 8750 2600
Wire Wire Line
	7700 2650 8450 2650
$Comp
L Device:Laserdiode_1C2A LD1
U 1 1 5DFE70F9
P 4850 1600
F 0 "LD1" V 4846 1512 50  0000 R CNN
F 1 "Laser-Cruz" V 4755 1512 50  0000 R CNN
F 2 "" H 4750 1575 50  0001 C CNN
F 3 "~" H 4880 1400 50  0001 C CNN
	1    4850 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5650 1100 5650 950 
Wire Wire Line
	5650 950  4850 950 
Wire Wire Line
	4850 950  4850 1400
Connection ~ 5650 1100
Wire Wire Line
	5650 1100 6550 1100
Wire Wire Line
	4850 1900 4850 2250
Wire Wire Line
	4850 2250 6800 2250
Connection ~ 6800 2250
$EndSCHEMATC
