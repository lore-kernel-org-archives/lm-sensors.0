From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: RFC: adm9240 documentation and introducing myself
Message-Id: <tqgo21thqjk57b1hn3he7srfoi81b3sjaf@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

My first porting project: I'm looking to complete Michiel Rook's
port of the ADM9240, DS1780 and LM81 sensor chip module.  

I have produced this reference document as part of building my 
knowledge of the lmsensors system and the current driver.

This also a whitespace mangle test, comments?

Cheers,
Grant.

diff -ruN linux-2.6.11-mm1/Documentation/i2c/chips/adm9240.txt linux-2.6.11-mm1-p2x/Documentation/i2c/chips/adm9240.txt
--- linux-2.6.11-mm1/Documentation/i2c/chips/adm9240.txt	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.11-mm1-p2x/Documentation/i2c/chips/adm9240.txt	2005-03-07 22:36:43.000000000 +1100
@@ -0,0 +1,282 @@
+ADM9240, DS1780 and LM81 Sensor chips
+``````````````````````````````````````
+References
+~~~~~~~~~~
+Analog Devices, Inc. (1998) ADM9240 REV.O (Uppercase 'o')
+<http://www.analog.com/en/prod/0,,766_825_ADM9240%2C00.html>
+
+Maxim Integrated Products (1999) DS1780 CPU Peripheral Monitor
+<http://pdfserv.maxim-ic.com/en/ds/DS1780.pdf>
+(Dallas Semiconductor is now Maxim.)
+
+National Semiconductor Corporation (2002) LM81
+<http://www.national.com/ds.cgi/LM/LM81.pdf>
+
+Temperature-to-Digital Converter
+`````````````````````````````````
+9 bit 2's complement chip temperature: Signed 8-bit -40 to +125'C 
+plus 0.5'C LSB.
+
+No mention of any read order for temperature, but since the data is 
+split with LSB as a separate read the driver may report the wrong 
+LSB if reading the two registers cross a measurement cycle update.
+
+Temperature Limits
+```````````````````
+Temperature comparison is against the 8-bit signed reading.  Three 
+interrupt modes may be defined:
+
+Default Repetitive mode:
+  INT asserted each temperature conversion cycle while temp > Temp Hi Limit
+
+One time mode:
+  INT asserted when temp crosses Temp Hi Limit or Temp Low Limit
+
+Comparator mode:
+  INT asserted while temp > Temp Hi Limit
+
+LM81 extended mode
+```````````````````
+LM81 includes an extended mode where chip temperature may be read as a 
+signed 12 bit value.  The amd9240 driver does not support this feature.
+
+Monitor Cycle Time
+```````````````````
+ADM9240
+~~~~~~~
+Monitoring cycle approx 311us for temp + volts, independent fan speed 
+monitoring cycle depends on fan speed.
+
+DS1780
+~~~~~~
+Montioring cycle approx once per second includes fan speed.
+
+LM81
+~~~~
+Montioring cycle approx once each 400ms includes fan speed.
+
+Analog Output
+``````````````
+Range: 0 - 1.25V output for 0 - 255 setting, may be used to drive external 
+amplifier for fan speed control.  Analog output defaults to maximum value 
+on startup.
+
+Fan RPM-to-Digital Converter
+`````````````````````````````
+ADM9240 has two fan speed counters.
+
+Full scale count: 255, nominal fan speeds are:
+
+     Divisor	RPM   Fan Count	 70% Alarm
+	1	8800	153	   219
+	2	4400	153	   219
+	4	2200	153	   219
+	8	1100	153	   219
+
+Fan Speed Measurement
+~~~~~~~~~~~~~~~~~~~~~
+The period of the fan revolution is measured by gating an on-chip 22.5 kHz 
+clock an 8-bit counter for two periods of the fan tacho output.  
+
+The accumulated count is inversely proportional to the fan speed.
+
+The count is calculated by the equation:
+
+rpm = (22.5 x 10^3 x 60) / (count x divisor)
+    = 1350000 / (count x divisor)  where divisor is 1, 2, 4 or 8.
+
+The slow fan speed alarm is asserted when the fan revolution period rises 
+beyond the limit value.  Fan speed limit value is also scaled by the 
+divisor setting for fan speed measurement.
+
+Chassis Intrusion
+``````````````````
+Digital I/O. An active high input from an external circuit that latches 
+a Chassis Intrusion event. This line can go high without any clamping 
+action regardless of the powered state of the ADM9240. 
+
+The ADM9240 provides an internal open drain on this line, and may output 
+a 20 ms active low pulse to reset the external Chassis Intrusion Latch.
+
+Example: Intel SE440BX-2 expects the intrusion switch to be normally closed,
+but monitors chassis intrusion only while AC power is applied.
+
+Voltage measurement
+````````````````````
+ADM9240 / DS1780 / LM81 internally scale six voltage inputs.
+
+	addr		label		 nominal	maximum
+					   mV		  mV
+	0x20		+2.5V		  2500		 3320
+	0x21		Vccp1		  2700		 3600
+	0x22		+3.3V		  3300		 4380
+	0x23		+5V		  5000		 6640
+	0x24		+12V		 12000		15940
+	0x25		Vccp2		  2700		 3600
+
+The reading is an unsigned 8-bit value, nominal voltage measurement is 
+repesented by a reading of 192, being 3/4 of the measurement range.
+
+The sensor voltage pins may be used to measure negative voltages with 
+addition of external voltage divider from a positive reference to the 
+measured negative voltage.  In this case the driver reports an inverse 
+representation of the measured voltage that will require scaling by 
+the userland readout program.
+
+I2C Interface Address
+``````````````````````
+address: 001011xy
+
+Address lines A1 (x) and A0 (y) have pulldown resistors, so the chip 
+is initially found at one of these i2c addresses: 0x2c, 0x2d. 0x2e or 
+0x2f depending on mainboard wiring and/or multiple chips.  Part of the 
+chip address may be changed by software
+
+Addressing
+```````````
+Address pointer is part of I2C message
+
+Addr	Function		Notes
+----	----------------------- ---------------------------------------------
+0x15	Test Register		do not write to this register
+0x19	Analog Output		rw -- set to 255 max value on reset
+0x20	+2.5V			ro 0..255 (192 for nominal V)
+0x21	+Vccp1			\
+0x22	+3.3V			 |
+0x23	+5.0V			  > As above
+0x24	+12V			 |
+0x25	Vccp2			/
+0x26	Reserved
+0x27	Temperature Reading	ro 2's comp -40 to +125'C
+0x28	Fan1 Reading		ro 1350000 / (rpm x divisor)
+0x29	Fan2 Reading		ro 1350000 / (rpm x divisor)
+0x2a	Reserved
+0x2b	+2.5V High Limit	rw 0..255 (alarm = reading > limit)
+0x2c	+2.5V Low Limit		rw 0..255 (alarm = reading <= limit)
+0x2d	+Vccp1 High Limit	\
+0x2e	+Vccp1 Low Limit	 |
+0x2f	+3.3V High Limit	 |
+0x30	+3.3V Low Limit		 |
+0x31	+5.0V High Limit	  > As above
+0x32	+5.0V Low Limit		 |
+0x33	+12V High Limit		 |
+0x34	+12V Low Limit		 |
+0x35	Vccp2 High Limit	 |
+0x36	Vccp2 Low Limit		/
+0x37	Reserved
+0x38	Reserved
+0x39	Hot Temp Limit (high)	rw	2's comp -- +127 disables alarm
+0x3a	Hot Temp Hyst. (low)	rw		''	''	''
+0x3b	Fan 1 Count Limit	rw	0..255 (alarm = reading > limit)
+0x3c	Fan 2 Count Limit	rw	   .------------------------
+0x3d	Reserved			__/	adm9240	ds1780	lm81
+0x3e	Company ID Number		ro	0x23	0xda	0x01
+0x3f	Revision/Stepping number	ro	??	??	??
+
+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
+
+Following bits are active high error / mask / control / INT status
+
+Addr	Name			bit	commentary
+----	----------------------- ---	-------------------------------------
+0x40	Configuration Register	0	start (do this after set limits)
+				1	INT enable, don't set this
+				2	Reserved
+				3	Clear INT, stops monitoring cycle
+				4	Reset (armed by 44.7?)
+				5	Reserved
+				6	CI_Reset Clear Chassis Intrusion
+				7	Initialisation to power on values
+
+0x41	INT Status Register 1	0	ro +2.5V error
+				1	ro Vccp1 error
+				2	ro +3.3V error
+				3	ro +5.0V error
+				4	ro Temp error
+				5	Reserved
+				6	Fan1 error
+				7	Fan2 error
+
+0x42	INT Status Register 2	0	+12V error
+				1	Vccp2 error
+				2	Reserved
+				3	Reserved
+				4	Chassis_Error
+				5	Reserved
+				6	Reserved
+				7	Reserved
+
+0x43	INT Mask Register 1	0	+2.5V
+				1	+Vccp1
+				2	+3.3V
+				3	+5.0V
+				4	Temp
+				5	Reserved
+				6	Fan1
+				7	Fan2
+
+0x44	INT Mask Register 2	0	+12V
+				1	Vccp2
+				2	Reserved
+				3	Reserved
+				4	CI
+				5	Reserved
+				6	Reserved
+				7	Reset Enable for Config Reg 40.4
+
+0x45	Compatibility Register		Reserved: initial value = 0	rw
+
+0x46	ChassisIntrusion ClrReg	0-6	Reserved                     __   __
+				7	Clear Chassis Int, output 20ms \_/ 
+
+0x47	VID0-3/Fan Divisor Reg	0-3	CPU Core V-id [3:0]		ro
+	Fan 1 Divisor		4-5	5:4	00	1		rw
+						01	2 **default
+						10	4
+						11	8
+	Fan 2 Divisor		6-7	7:6	00	1		rw
+						01	2 **default
+						10	4
+						11	8
+0x48	Serial Addr Register	0	I2C hardware addr 0 -------.	ro
+				1	I2C hardware addr 1 ------.|	ro
+				2-6	Chip firmware addr 0010 11??	rw
+				7	                   '------------ro
+
+0x49	VID4 Register		0	V-id 4				ro
+				1-7	Reserved			rw
+
+0x4B	Temp Config Register	0-1	1:0	00	repetitive INT	rw
+						01	one time INT
+						10	comparator mode
+						11	repetitive INT
+				2-6	Reserved			rw
+	Temp reading		7	LSB (0.5'C)			ro
+
+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
+LM81 only
+~~~~~~~~~
+0x4C	lm81 ext mode reg 1	0	enable extended mode and interrupts
+	LOW Int mask		1	prevents LOW propagating to INT
+	T_CRIT_A Int Mode	2-3	3:2	00	repetitive INT  rw
+						01	one time INT
+						10	comparator mode
+						11	repetitive INT
+	T_CRIT_A Int Enable	4	1 = enabled
+	T_CRIT_A Int Polarity	5	0 = active lo, 1 = active hi
+	T_CRIT_A Int Disable	6	prevents T_CRIT_A propagating to INT
+	T_CRIT_A Int Status	7	T_CRIT_A INT has occurred 
+
+0x4D	lm81 ext mode reg 2	0-2	Hysteresis Offset Value [1]
+				3	Enable 12-bit temperature resolution
+				4-7	Temp least significant nybble [2]
+
+Not implemented in this driver.
+
+[1] 3 bit value where lsb = 1'C
+
+[2] bit 0x4d.7 is same as 0x4b.7, so read 0x27 to hi byte, 0x4d to lo byte 
+and shift right by 4 with sign extension for 12 bit 2's complement temp.
+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
+### Compiled by Grant Coady 2005-03-07 <gcoady@gmail.com>
+### Disclaimer: when in doubt, refer to cited references.
