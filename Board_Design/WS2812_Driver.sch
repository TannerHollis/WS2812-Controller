EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "WS2812 Controller"
Date ""
Rev "A0"
Comp "Offset Power, LLC."
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L WS2812_Driver:ICE40UL1K-SWG16ITR1K U3
U 1 1 61AB0097
P 8225 2900
F 0 "U3" H 8225 3865 50  0000 C CNN
F 1 "ICE40UL640-SWG16ITR1K" H 8225 3774 50  0000 C CNN
F 2 "WS2812_Driver:BGA16N35P4X4_140X140X49N" H 7625 3725 50  0001 L BNN
F 3 "" H 8225 2900 50  0001 L BNN
	1    8225 2900
	1    0    0    -1  
$EndComp
$Comp
L WS2812_Driver:TLV7111225DSER U2
U 1 1 61AB140C
P 3500 6200
F 0 "U2" H 3500 6475 50  0000 C CNN
F 1 "TLV7111225DSER" H 3500 6384 50  0000 C CNN
F 2 "Package_SON:WSON-6_1.5x1.5mm_P0.5mm" H 3450 6200 50  0001 C CNN
F 3 "" H 3450 6200 50  0001 C CNN
	1    3500 6200
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR0101
U 1 1 61AB1EE9
P 4125 5925
F 0 "#PWR0101" H 4125 5775 50  0001 C CNN
F 1 "+1V2" H 4140 6098 50  0000 C CNN
F 2 "" H 4125 5925 50  0001 C CNN
F 3 "" H 4125 5925 50  0001 C CNN
	1    4125 5925
	1    0    0    -1  
$EndComp
$Comp
L power:+2V5 #PWR0102
U 1 1 61AB22D0
P 4400 5925
F 0 "#PWR0102" H 4400 5775 50  0001 C CNN
F 1 "+2V5" H 4415 6098 50  0000 C CNN
F 2 "" H 4400 5925 50  0001 C CNN
F 3 "" H 4400 5925 50  0001 C CNN
	1    4400 5925
	1    0    0    -1  
$EndComp
Wire Wire Line
	4125 5925 4125 6150
Wire Wire Line
	4125 6150 3975 6150
Wire Wire Line
	4400 5925 4400 6250
Wire Wire Line
	4400 6250 3875 6250
$Comp
L power:GND #PWR0103
U 1 1 61AB2A9F
P 3500 6850
F 0 "#PWR0103" H 3500 6600 50  0001 C CNN
F 1 "GND" H 3505 6677 50  0000 C CNN
F 2 "" H 3500 6850 50  0001 C CNN
F 3 "" H 3500 6850 50  0001 C CNN
	1    3500 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 6850 3500 6500
$Comp
L power:+3.3V #PWR0104
U 1 1 61AB33A6
P 2625 5925
F 0 "#PWR0104" H 2625 5775 50  0001 C CNN
F 1 "+3.3V" H 2640 6098 50  0000 C CNN
F 2 "" H 2625 5925 50  0001 C CNN
F 3 "" H 2625 5925 50  0001 C CNN
	1    2625 5925
	1    0    0    -1  
$EndComp
Wire Wire Line
	2625 5925 2625 6150
Wire Wire Line
	2625 6150 3125 6150
$Comp
L Device:R R1
U 1 1 61AB3E81
P 2900 6550
F 0 "R1" H 2970 6596 50  0000 L CNN
F 1 "10K" H 2970 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2830 6550 50  0001 C CNN
F 3 "~" H 2900 6550 50  0001 C CNN
	1    2900 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 6400 2900 6350
Wire Wire Line
	2900 6350 3125 6350
Wire Wire Line
	3125 6250 2900 6250
Wire Wire Line
	2900 6250 2900 6350
Connection ~ 2900 6350
$Comp
L power:GND #PWR0105
U 1 1 61AB48A1
P 2775 6850
F 0 "#PWR0105" H 2775 6600 50  0001 C CNN
F 1 "GND" H 2780 6677 50  0000 C CNN
F 2 "" H 2775 6850 50  0001 C CNN
F 3 "" H 2775 6850 50  0001 C CNN
	1    2775 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2775 6850 2775 6800
$Comp
L Device:C C1
U 1 1 61AB502D
P 2625 6525
F 0 "C1" H 2740 6571 50  0000 L CNN
F 1 "1U" H 2740 6480 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2663 6375 50  0001 C CNN
F 3 "~" H 2625 6525 50  0001 C CNN
	1    2625 6525
	1    0    0    -1  
$EndComp
Wire Wire Line
	2625 6375 2625 6150
Connection ~ 2625 6150
Wire Wire Line
	2625 6675 2625 6800
Wire Wire Line
	2625 6800 2775 6800
Wire Wire Line
	2900 6800 2900 6700
Connection ~ 2775 6800
Wire Wire Line
	2775 6800 2900 6800
$Comp
L Device:C C3
U 1 1 61AB5DB8
P 3975 6600
F 0 "C3" H 4090 6646 50  0000 L CNN
F 1 "1U" H 4090 6555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4013 6450 50  0001 C CNN
F 3 "~" H 3975 6600 50  0001 C CNN
	1    3975 6600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 61AB69A8
P 4400 6600
F 0 "C4" H 4515 6646 50  0000 L CNN
F 1 "1U" H 4515 6555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4438 6450 50  0001 C CNN
F 3 "~" H 4400 6600 50  0001 C CNN
	1    4400 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3975 6450 3975 6150
Connection ~ 3975 6150
Wire Wire Line
	3975 6150 3875 6150
Wire Wire Line
	4400 6250 4400 6450
Connection ~ 4400 6250
$Comp
L power:GND #PWR0106
U 1 1 61AB7749
P 4200 6850
F 0 "#PWR0106" H 4200 6600 50  0001 C CNN
F 1 "GND" H 4205 6677 50  0000 C CNN
F 2 "" H 4200 6850 50  0001 C CNN
F 3 "" H 4200 6850 50  0001 C CNN
	1    4200 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 6850 4200 6825
Wire Wire Line
	4200 6825 3975 6825
Wire Wire Line
	3975 6825 3975 6750
Wire Wire Line
	4200 6825 4400 6825
Wire Wire Line
	4400 6825 4400 6750
Connection ~ 4200 6825
$Comp
L power:+1V2 #PWR0107
U 1 1 61AB9EB0
P 9375 1825
F 0 "#PWR0107" H 9375 1675 50  0001 C CNN
F 1 "+1V2" H 9390 1998 50  0000 C CNN
F 2 "" H 9375 1825 50  0001 C CNN
F 3 "" H 9375 1825 50  0001 C CNN
	1    9375 1825
	1    0    0    -1  
$EndComp
$Comp
L power:+2V5 #PWR0108
U 1 1 61AB9EB6
P 9650 1825
F 0 "#PWR0108" H 9650 1675 50  0001 C CNN
F 1 "+2V5" H 9665 1998 50  0000 C CNN
F 2 "" H 9650 1825 50  0001 C CNN
F 3 "" H 9650 1825 50  0001 C CNN
	1    9650 1825
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0109
U 1 1 61ABA943
P 9925 1825
F 0 "#PWR0109" H 9925 1675 50  0001 C CNN
F 1 "+3.3V" H 9940 1998 50  0000 C CNN
F 2 "" H 9925 1825 50  0001 C CNN
F 3 "" H 9925 1825 50  0001 C CNN
	1    9925 1825
	1    0    0    -1  
$EndComp
Wire Wire Line
	9375 2200 9225 2200
Wire Wire Line
	9375 1825 9375 2200
Wire Wire Line
	9650 2300 9225 2300
Wire Wire Line
	9650 1825 9650 2300
Wire Wire Line
	9225 2400 9925 2400
Wire Wire Line
	9925 2400 9925 1825
$Comp
L Device:R R2
U 1 1 61ABBEF7
P 6725 3675
F 0 "R2" H 6795 3721 50  0000 L CNN
F 1 "10K" H 6795 3630 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6655 3675 50  0001 C CNN
F 3 "~" H 6725 3675 50  0001 C CNN
	1    6725 3675
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 61ABC828
P 7000 3675
F 0 "R3" H 7070 3721 50  0000 L CNN
F 1 "10K" H 7070 3630 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6930 3675 50  0001 C CNN
F 3 "~" H 7000 3675 50  0001 C CNN
	1    7000 3675
	1    0    0    -1  
$EndComp
Wire Wire Line
	6725 3525 6725 3200
Wire Wire Line
	6725 3200 7225 3200
$Comp
L power:+3.3V #PWR0110
U 1 1 61ABD137
P 6850 3975
F 0 "#PWR0110" H 6850 3825 50  0001 C CNN
F 1 "+3.3V" H 6865 4148 50  0000 C CNN
F 2 "" H 6850 3975 50  0001 C CNN
F 3 "" H 6850 3975 50  0001 C CNN
	1    6850 3975
	-1   0    0    1   
$EndComp
Wire Wire Line
	6850 3975 6850 3925
Wire Wire Line
	7000 3300 7225 3300
Wire Wire Line
	7000 3825 7000 3925
Wire Wire Line
	7000 3925 6850 3925
Wire Wire Line
	6725 3925 6725 3825
Connection ~ 6850 3925
Wire Wire Line
	6850 3925 6725 3925
$Comp
L power:GND #PWR0111
U 1 1 61ABFC21
P 9500 3800
F 0 "#PWR0111" H 9500 3550 50  0001 C CNN
F 1 "GND" H 9505 3627 50  0000 C CNN
F 2 "" H 9500 3800 50  0001 C CNN
F 3 "" H 9500 3800 50  0001 C CNN
	1    9500 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 3800 9500 3600
Wire Wire Line
	9500 3600 9225 3600
Wire Wire Line
	9225 3500 9500 3500
Wire Wire Line
	9500 3500 9500 3600
Connection ~ 9500 3600
Text GLabel 9375 3000 2    50   Input ~ 0
SPI_MOSI
Wire Wire Line
	9375 3000 9225 3000
Text GLabel 9375 3100 2    37   Input ~ 0
~RESET~
Wire Wire Line
	9375 3100 9225 3100
Text GLabel 9375 2800 2    37   Input ~ 0
~CS~
Wire Wire Line
	9375 2800 9225 2800
Text GLabel 9375 2700 2    50   Input ~ 0
SPI_CLK
Wire Wire Line
	9375 2700 9225 2700
Text GLabel 9375 2900 2    50   Input ~ 0
SPI_MISO
Wire Wire Line
	9375 2900 9225 2900
Text GLabel 7050 3000 0    50   Input ~ 0
LED_OUT-SPI_CS_PRGM
Wire Wire Line
	7050 3000 7225 3000
Text GLabel 7050 2900 0    50   Input ~ 0
SPI_CLK_PRGM
Wire Wire Line
	7050 2900 7225 2900
Text GLabel 7050 2800 0    50   Input ~ 0
SPI_MOSI_PGRM
Wire Wire Line
	7050 2800 7225 2800
Text GLabel 7050 2700 0    50   Input ~ 0
SPI_MISO_PRGM
Wire Wire Line
	7050 2700 7225 2700
$Comp
L Connector:TestPoint J3
U 1 1 61AD2A20
P 3950 1975
F 0 "J3" V 3904 2163 50  0000 L CNN
F 1 "5Vout" V 3995 2163 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_3.0x3.0mm_Drill1.5mm" H 4150 1975 50  0001 C CNN
F 3 "~" H 4150 1975 50  0001 C CNN
	1    3950 1975
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint J4
U 1 1 61AD38DF
P 3950 2175
F 0 "J4" V 3904 2363 50  0000 L CNN
F 1 "DOUT" V 3995 2363 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_3.0x3.0mm_Drill1.5mm" H 4150 2175 50  0001 C CNN
F 3 "~" H 4150 2175 50  0001 C CNN
	1    3950 2175
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint J5
U 1 1 61AD48E6
P 3950 2375
F 0 "J5" V 3904 2563 50  0000 L CNN
F 1 "GNDout" V 3995 2563 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_3.0x3.0mm_Drill1.5mm" H 4150 2375 50  0001 C CNN
F 3 "~" H 4150 2375 50  0001 C CNN
	1    3950 2375
	0    1    1    0   
$EndComp
$Comp
L WS2812_Driver:74LVC1T45Z6-7 U1
U 1 1 61AD6B0A
P 3450 3825
F 0 "U1" H 3450 4312 60  0000 C CNN
F 1 "74LVC1T45Z6-7" H 3450 4206 60  0000 C CNN
F 2 "WS2812_Driver:74LVC1T45Z6-7" H 3450 4225 60  0001 C CNN
F 3 "" H 3450 3900 60  0000 C CNN
	1    3450 3825
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 61AD75CD
P 3450 4600
F 0 "#PWR0112" H 3450 4350 50  0001 C CNN
F 1 "GND" H 3455 4427 50  0000 C CNN
F 2 "" H 3450 4600 50  0001 C CNN
F 3 "" H 3450 4600 50  0001 C CNN
	1    3450 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 4600 3450 4425
$Comp
L power:+3.3V #PWR0113
U 1 1 61AD923A
P 2400 3400
F 0 "#PWR0113" H 2400 3250 50  0001 C CNN
F 1 "+3.3V" H 2415 3573 50  0000 C CNN
F 2 "" H 2400 3400 50  0001 C CNN
F 3 "" H 2400 3400 50  0001 C CNN
	1    2400 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 3400 2400 3625
Wire Wire Line
	2400 3625 2650 3625
Wire Wire Line
	4500 3400 4500 3625
Wire Wire Line
	4500 3625 4125 3625
$Comp
L Connector:TestPoint J1
U 1 1 61ADDD8D
P 2650 1975
F 0 "J1" V 2845 2047 50  0000 C CNN
F 1 "5Vin" V 2754 2047 50  0000 C CNN
F 2 "TestPoint:TestPoint_THTPad_3.0x3.0mm_Drill1.5mm" H 2850 1975 50  0001 C CNN
F 3 "~" H 2850 1975 50  0001 C CNN
	1    2650 1975
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint J2
U 1 1 61ADE73D
P 2650 2375
F 0 "J2" V 2845 2447 50  0000 C CNN
F 1 "GNDin" V 2754 2447 50  0000 C CNN
F 2 "TestPoint:TestPoint_THTPad_3.0x3.0mm_Drill1.5mm" H 2850 2375 50  0001 C CNN
F 3 "~" H 2850 2375 50  0001 C CNN
	1    2650 2375
	0    -1   -1   0   
$EndComp
Text GLabel 2525 3825 0    50   Input ~ 0
LED_OUT-SPI_CS_PRGM
Wire Wire Line
	2525 3825 2775 3825
Wire Wire Line
	2650 3625 2650 4025
Wire Wire Line
	2650 4025 2775 4025
Connection ~ 2650 3625
Wire Wire Line
	2650 3625 2775 3625
Text GLabel 4325 3825 2    50   Input ~ 0
LED_OUT
Wire Wire Line
	4325 3825 4125 3825
Text GLabel 3825 2175 0    50   Input ~ 0
LED_OUT
Wire Wire Line
	3825 2175 3950 2175
$Comp
L power:+5V #PWR0115
U 1 1 61AE5C35
P 3075 1800
F 0 "#PWR0115" H 3075 1650 50  0001 C CNN
F 1 "+5V" H 3090 1973 50  0000 C CNN
F 2 "" H 3075 1800 50  0001 C CNN
F 3 "" H 3075 1800 50  0001 C CNN
	1    3075 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3075 1800 3075 1975
Wire Wire Line
	3075 1975 2650 1975
Wire Wire Line
	3075 1975 3950 1975
Connection ~ 3075 1975
Wire Wire Line
	2650 2375 3075 2375
$Comp
L power:GND #PWR0116
U 1 1 61AEA031
P 3075 2625
F 0 "#PWR0116" H 3075 2375 50  0001 C CNN
F 1 "GND" H 3080 2452 50  0000 C CNN
F 2 "" H 3075 2625 50  0001 C CNN
F 3 "" H 3075 2625 50  0001 C CNN
	1    3075 2625
	1    0    0    -1  
$EndComp
Wire Wire Line
	3075 2375 3075 2625
Connection ~ 3075 2375
Wire Wire Line
	3075 2375 3950 2375
$Comp
L Device:C C2
U 1 1 61AED204
P 3075 2175
F 0 "C2" H 3190 2221 50  0000 L CNN
F 1 "10U" H 3190 2130 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3113 2025 50  0001 C CNN
F 3 "~" H 3075 2175 50  0001 C CNN
	1    3075 2175
	1    0    0    -1  
$EndComp
Wire Wire Line
	3075 2025 3075 1975
Wire Wire Line
	3075 2325 3075 2375
$Comp
L power:+5V #PWR0114
U 1 1 61AF3BB0
P 4500 3400
F 0 "#PWR0114" H 4500 3250 50  0001 C CNN
F 1 "+5V" H 4515 3573 50  0000 C CNN
F 2 "" H 4500 3400 50  0001 C CNN
F 3 "" H 4500 3400 50  0001 C CNN
	1    4500 3400
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint J7
U 1 1 61AF683C
P 9925 5325
F 0 "J7" V 9879 5513 50  0000 L CNN
F 1 "PogoPin" V 9970 5513 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_2.0x2.0mm" H 10125 5325 50  0001 C CNN
F 3 "~" H 10125 5325 50  0001 C CNN
	1    9925 5325
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint J8
U 1 1 61AF6842
P 9925 5525
F 0 "J8" V 9879 5713 50  0000 L CNN
F 1 "PogoPin" V 9970 5713 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_2.0x2.0mm" H 10125 5525 50  0001 C CNN
F 3 "~" H 10125 5525 50  0001 C CNN
	1    9925 5525
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint J9
U 1 1 61AF6848
P 9925 5725
F 0 "J9" V 9879 5913 50  0000 L CNN
F 1 "PogoPin" V 9970 5913 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_2.0x2.0mm" H 10125 5725 50  0001 C CNN
F 3 "~" H 10125 5725 50  0001 C CNN
	1    9925 5725
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint J10
U 1 1 61AF7FD1
P 9925 5925
F 0 "J10" V 9879 6113 50  0000 L CNN
F 1 "PogoPin" V 9970 6113 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_2.0x2.0mm" H 10125 5925 50  0001 C CNN
F 3 "~" H 10125 5925 50  0001 C CNN
	1    9925 5925
	0    1    1    0   
$EndComp
Text GLabel 9725 5925 0    50   Input ~ 0
LED_OUT-SPI_CS_PRGM
Text GLabel 9725 5725 0    50   Input ~ 0
SPI_CLK_PRGM
Text GLabel 9725 5525 0    50   Input ~ 0
SPI_MOSI_PGRM
Text GLabel 9725 5325 0    50   Input ~ 0
SPI_MISO_PRGM
Wire Wire Line
	9725 5325 9925 5325
Wire Wire Line
	9925 5525 9725 5525
Wire Wire Line
	9725 5725 9925 5725
Wire Wire Line
	9925 5925 9725 5925
$Comp
L Connector_Generic:Conn_02x04_Odd_Even J6
U 1 1 61B091B2
P 7200 5400
F 0 "J6" H 7250 5717 50  0000 C CNN
F 1 "INPUT" H 7250 5626 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x04_P2.54mm_Vertical" H 7200 5400 50  0001 C CNN
F 3 "~" H 7200 5400 50  0001 C CNN
	1    7200 5400
	1    0    0    -1  
$EndComp
Text GLabel 7650 5600 2    50   Input ~ 0
SPI_MOSI
Wire Wire Line
	7650 5500 7500 5500
Text GLabel 6850 5500 0    37   Input ~ 0
~RESET~
Wire Wire Line
	7650 5400 7500 5400
Text GLabel 7650 5500 2    37   Input ~ 0
~CS~
Wire Wire Line
	6850 5500 7000 5500
Text GLabel 6850 5400 0    50   Input ~ 0
SPI_CLK
Wire Wire Line
	6850 5400 7000 5400
Text GLabel 7650 5400 2    50   Input ~ 0
SPI_MISO
Wire Wire Line
	7650 5600 7500 5600
$Comp
L power:+3.3V #PWR0117
U 1 1 61B33582
P 6750 5075
F 0 "#PWR0117" H 6750 4925 50  0001 C CNN
F 1 "+3.3V" H 6765 5248 50  0000 C CNN
F 2 "" H 6750 5075 50  0001 C CNN
F 3 "" H 6750 5075 50  0001 C CNN
	1    6750 5075
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 5075 6750 5300
Wire Wire Line
	6750 5300 7000 5300
$Comp
L power:GND #PWR0118
U 1 1 61B38A83
P 6750 5825
F 0 "#PWR0118" H 6750 5575 50  0001 C CNN
F 1 "GND" H 6755 5652 50  0000 C CNN
F 2 "" H 6750 5825 50  0001 C CNN
F 3 "" H 6750 5825 50  0001 C CNN
	1    6750 5825
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6750 5825 6750 5600
Wire Wire Line
	6750 5600 7000 5600
NoConn ~ 7500 5300
$Comp
L Connector:TestPoint J11
U 1 1 61B77341
P 9925 4900
F 0 "J11" V 9879 5088 50  0000 L CNN
F 1 "PogoPin" V 9970 5088 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_2.0x2.0mm" H 10125 4900 50  0001 C CNN
F 3 "~" H 10125 4900 50  0001 C CNN
	1    9925 4900
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint J12
U 1 1 61B775E1
P 9925 5100
F 0 "J12" V 9879 5288 50  0000 L CNN
F 1 "PogoPin" V 9970 5288 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_2.0x2.0mm" H 10125 5100 50  0001 C CNN
F 3 "~" H 10125 5100 50  0001 C CNN
	1    9925 5100
	0    1    1    0   
$EndComp
Text GLabel 9725 5100 0    50   Input ~ 0
CDONE
Text GLabel 9725 4900 0    50   Input ~ 0
CRESET
Wire Wire Line
	9725 4900 9925 4900
Wire Wire Line
	9925 5100 9725 5100
Text GLabel 6475 3300 0    50   Input ~ 0
CDONE
Text GLabel 6475 3200 0    50   Input ~ 0
CRESET
Wire Wire Line
	6475 3300 7000 3300
Wire Wire Line
	6475 3200 6725 3200
Connection ~ 6725 3200
Connection ~ 7000 3300
Wire Wire Line
	7000 3300 7000 3525
$EndSCHEMATC
