From: rolf@winmutt.com (Rolf)
Date: Wed, 10 Aug 2005 00:55:08 +0000
Subject: [lm-sensors] decode-dimm
Message-Id: <42F9340C.5080802@winmutt.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I get this error when running decode-dimms.pl :

ls: /proc/sys/dev/sensors/: No such file or directory
Number of SDRAM DIMMs detected and decoded      0

This is with 2.6.12-gentoo-r6 and sensors version 2.9.1 with libsensors 
version 2.9.1

I am trying to find serial numbers for memory, will be using this @ work 
with our existing debian systems for inventory and asset control without 
opening the box.

This is the output of sensors :

 sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.60 V  (min =  +1.52 V, max =  +1.68 V)       ALARM
VCore 2:   +2.61 V  (min =  +1.52 V, max =  +1.68 V)
+3.3V:     +3.26 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.08 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.92 V  (min = +10.82 V, max = +13.19 V)
-12V:      -7.10 V  (min = -13.18 V, max = -10.80 V)
-5V:       -2.64 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.54 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.01 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     4753 RPM  (min =    0 RPM, div = 2)
fan2:     4753 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min =    0 RPM, div = 2)
temp1:       +46 C  (high =    -1 C, hyst =   -11 C)   sensor = thermistor
temp2:     +47.0 C  (high =  +100 C, hyst =   +95 C)   sensor = thermistor
temp3:     +46.0 C  (high =  +100 C, hyst =   +95 C)   sensor = thermistor
vid:      +1.600 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-52
Adapter: SMBus nForce2 adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

