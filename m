From: David Anderson <davea42@earthlink.net>
Date: Sat, 29 Jan 2011 18:53:15 +0000
Subject: [lm-sensors] W83795AG on SuperMicro 7046T-NTR+ board
Message-Id: <4D44621B.40506@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Supermicro support supplied the following info
on the Winbond W83795AG on SuperMicro 7046T-NTR+ board

Bus Type = SMBus
One W83795AG

Windbond W83795AG, Slave Address=0x2f (0x5E in 8-Bit format)
==============================Fan1 Fan Speed, Offset 0x2e		RPM = 84375/Data
Fan2 Fan Speed, Offset 0x2f		RPM = 84375/Data
Fan3 Fan Speed, Offset 0x30		RPM = 84375/Data
Fan4 Fan Speed, Offset 0x31		RPM = 84375/Data
Fan5 Fan Speed, Offset 0x32		RPM = 84375/Data
Fan6 Fan Speed, Offset 0x33		RPM = 84375/Data
Fan7 Fan Speed, Offset 0x34		RPM = 84375/Data
Fan8 Fan Speed, Offset 0x35		RPM = 84375/Data
Fan9 Fan Speed, Offset 0x36		RPM = 84375/Data
CPU1 Voltage, Offset 0x11		Voltage = Data* 0.008
CPU2 Voltage, Offset 0x10		Voltage = Data* 0.008
+1.5V Voltage, Offset 0x12		Voltage = Data* 0.008
+5V Voltage, Offset 0x13		Voltage = Data* 0.008 * (40/10)
+12V Voltage, Offset 0x14		Voltage = Data* 0.008/ (10./66.2)
+5VSB Voltage, Offset 0x15		Voltage = Data* 0.008 * (40/10)
CPU1 DIMM Voltage, Offset 0x17		Voltage = Data* 0.008
CPU2 DIMM Voltage, Offset 0x16		Voltage = Data* 0.008
+3.3V Voltage, Offset 0x1c		Voltage = Data* 0.024
+3.3VSB Voltage, Offset 0x1d		Voltage = Data* 0.024
VBAT Voltage, Offset 0x1e		Voltage = Data* 0.024
CPU1 Temperature, Offset 0x26		Temperature = Data
CPU2 Temperature, Offset 0x27		Temperature = Data
System Temperature, Offset 0x1f		Temperature = Data
Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40	1 = Bad, 0 = Good
			(Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)


Power Supply Failure, GP21(From W83527HG)		1 = Good, 0 = Bad


I don't yet understand how to use this info though. Ubuntu 10.10.

-- 
Free as in lawsuit.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
