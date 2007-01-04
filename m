From: nromer@arcmailtech.com (Noah Romer)
Date: Thu, 04 Jan 2007 01:01:08 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <200701031701.08165.nromer@arcmailtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Support at SuperMicro provided a list of offsets for the sensors on the 
x7dbe+, but they don't look like a complete match with the settings in 
sensors.conf from lm_sensors 2.10.1 . If I can get these to play nice, the 
only other thing I'll need is a released kernel with the w83793 driver in it.

Bus Type = SMBus
One W83793G, One W83792D

Windbond W83793G, Slave Address=0x2f (0x5E in 8-Bit format)
==============================Fan1 Fan Speed, Offset 0x23, 0x24
Fan2 Fan Speed, Offset 0x25, 0x26
Fan3 Fan Speed, Offset 0x27, 0x28
Fan4 Fan Speed, Offset 0x29, 0x2a
Fan5 Fan Speed, Offset 0x2b, 0x2c
Fan6 Fan Speed, Offset 0x2d, 0x2e
Fan7/CPU1 Fan Speed, Offset 0x2f, 0x30
Fan8/CPU2 Fan Speed, Offset 0x31, 0x32
CPU1 Core Voltage, Offset 0x10          
CPU2 Core Voltage, Offset 0x11
-12V Voltage, Offset 0x14
+1.5V Voltage, Offset 0x15
+3.3V Voltage, Offset 0x16
+12V Voltage, Offset 0x17
+5V Voltage, Offset 0x18
5Vsb Voltage, Offset 0x19
Battery Voltage, Offset 0x1a
CPU1 CoreA (PECI Agent1) Temperature, Offset 0x1c
CPU1 CoreB (PECI Agent2) Temperature, Offset 0x1d
CPU2 CoreA (PECI Agent3) Temperature, Offset 0x1e
CPU1 CoreB (PECI Agent4) Temperature, Offset 0x1f
System Temperature, Offset 0x20


Windbond W83792D, Slave Address=0x2e (0x5C in 8-Bit format)
==============================Chassis Intrusion, Offset 0xaa, BitMask 0x20


Power Supply Failure, GP11

-- 
Noah Romer <nromer at arcmailtech.com>
GPG Key Fingerprint: 944E C2F8 EBEC BCC7 EEA9  9381 1B21 0098 CC8D 45BA

