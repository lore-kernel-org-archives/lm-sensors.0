From: kus@free.net (Mikhail Kuzminsky)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: sensors -s & adm1027
Message-Id: <web-77741@free.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

1)  We have: i2c - 2.8.0, lm_sensors - 2.8.0 (RPM's from SuSE Linux 
9.0
for Opteron);
            kernel: 2.4.21-102-smp (x86_64)
            Motherboard: Tyan S2880; /etc/sensors.conf from Tyan 
Website 
               
i2c-amd756 module was wrong in both binary and source RPM's; modprobe
for it says "init_module: no such device".

All other components, including w83781d module w/w83627hf chip
works normally and gives the corresponding sensors results. We want
to use lm_sensors for fan's speeds and temperatures only.

2) I added the string w/pci_device_id to i2c-amd756.c according
ticket# 1481 (and patch final strings starting on line 400
according Daniel Rune Jensen letter form 11 Dec 2003). Now all the 
modules was loaded successfully:
i2c-core
i2c-dev
i2c-proc
i2c-isa
i2c-amd8111
i2c-amd756
lm85
lm75
w83781d
eeprom

sensors-detect works normally. But sensors -s says
"adm1027-i2c-1-2d can't read or write". It looks something like
Ticket#1682 (partially).

But issuing of sensors command gives me reasonable results,
in particular for adm1027 chip (attached below).
Sorry, how I may correct the situation w/sensors -s ?
(I prefer not to going to more recent i2c/lm_sensors releases because
it's necessary to patch 64-bit SuSE kernel :-().

Yours
Mikhail Kuzminsky
Zelinsky Institute of Organic Chemistry
Moscow

results of sensors run are:

adm1027-i2c-1-2d
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
VDD 2.5V:  +2.484 V  (min =  +0.00 V, max =  +3.32 V)
DDR VTT:   +1.251 V  (min =  +0.00 V, max =  +2.99 V)
3VSB:      +3.227 V  (min =  +0.00 V, max =  +4.38 V)
+5 V:     +5.150 V  (min =  +0.00 V, max =  +6.64 V)
+12V:     +12.234 V  (min =  +0.00 V, max = +15.94 V)
chs1 fan:     0 RPM  (min =    0 RPM)
chs2 fan:     0 RPM  (min =    0 RPM)
chs3 fan:     0 RPM  (min =    0 RPM)
CPU2 Temp:+45.25?C  (min = -128?C, max = +127?C)
CPU1 Temp:+44.75?C  (min = -127?C, max = +127?C)

lm75-i2c-1-49
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
temp:      +27.5?C  (limit = +52.0?C, hysteresis = +47.0?C)

lm75-i2c-1-4a
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
temp:      +29.5?C  (limit = +52.0?C, hysteresis = +47.0?C)

eeprom-i2c-1-52
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
Machine name:
Serial number:

eeprom-i2c-1-53
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512

eeprom-i2c-1-54
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512

eeprom-i2c-1-55
Adapter: SMBus AMD75x adapter at 50e0
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 2:   +1.52 V  (min =  +1.42 V, max =  +1.56 V)
VCore 1:   +1.55 V  (min =  +1.42 V, max =  +1.56 V)       ALARM
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
DDR term:  +1.21 V  (min =  +1.08 V, max =  +1.32 V)
+2.5V:     +2.46 V  (min =  +2.75 V, max =  +2.25 V)
CPU H.T.:  +1.20 V  (min =  +1.26 V, max =  +1.13 V)
CPU2 Fan: 3276 RPM  (min = 3000 RPM, div = 2)
CPU1 Fan: 3260 RPM  (min = 3000 RPM, div = 2)
chs4 Fan:    0 RPM  (min = 3000 RPM, div = 2)
VRM1 temp:   +31?C  (limit =  +40?C, hysteresis =  +37?C) sensor = 
3904 transistor
VRM2 temp: +29.5?C  (limit =  +52?C, hysteresis =  +47?C) sensor = 
3904 transistor
VRM3 temp: +32.0?C  (limit =  +52?C, hysteresis =  +47?C) sensor = 
3904 transistor
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm disabled

