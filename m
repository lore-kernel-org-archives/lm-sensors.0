From: bradley@greystate.com (Bradley Schatz)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <40A042B0.6060907@greystate.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a lm-sensors up and running on 2.6.5 kernel, on a VIA KM266 based 
motherboard. My goal is to get the fan noise down.

Most things appear to be working fine. However, while my BIOS reports 
activity of two fans (rightly), lm-sensors only seems to be finding one.

I have tried fidling with the divider to see if that is an issue but 
still I am missing activity on one fan.

Can anyone suggest some steps I might take to get this fan working?

Thanks,

bradley





it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.92 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
VCore 2:   +1.26 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.88 V  (min = +11.36 V, max = +12.60 V)
-12V:     -14.24 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -7.71 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +5.11 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +0.00 V
fan1:     4963 RPM  (min =    0 RPM, div = 4)
fan2:        0 RPM  (min =    0 RPM, div = 4)
fan3:        0 RPM  (min =    0 RPM, div = 2)
M/B Temp:    +80?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
CPU Temp:    +96?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor
Temp3:      +127?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor

eeprom-i2c-4-50
Adapter: SMBus Via Pro adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

lm90-i2c-4-4c
Adapter: SMBus Via Pro adapter at 0400
M/B Temp:    +59?C  (low  =    +0?C, high =   +70?C)   ALARM
CPU Temp:  +67.6?C  (low  =  +0.0?C, high = +70.0?C)   ALARM
M/B Crit:    +85?C  (hyst =   +75?C)
CPU Crit:   +110?C  (hyst =  +100?C)

