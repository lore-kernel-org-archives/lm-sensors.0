From: timothy.covell@ashavan.org (Timothy Covell)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: LM Sensors problems
Message-Id: <200201241947.g0OJlOL06323@home.ashavan.org.>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C50B879.3A62166B@paradyne.com>
In-Reply-To: <3C50B879.3A62166B@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi.  I've had a couple problems, one somewhat serious
when using lm sensors.


System A:  Duron 800 MHz on KT133A MoBo
Sensors output: attached file: sensors.out
Modules:

i2c-voodoo3             2720   0 (unused)
i2c-algo-bit            6880   2 [i2c-voodoo3]
eeprom                  3056   0 (unused)
via686a                 8256   0 (unused)
lm80                    5216   0 (unused)
sensors                 6320   0 [eeprom via686a lm80]
i2c-isa                 1136   0 (unused)
i2c-viapro              3856   0 (unused)
i2c-core               12832   0 [i2c-algo-bit eeprom via686a lm80 sensors 
i2c-isa i2c-viapro]


Problem 1: CPU/System temperatures should be swapped

Problem 2: When running "lvcool" to try to cool better, the
sensors program hangs after printing out data and only a
reboot will kill cpu hogging "zombie".

Problem 3: lm80 data is completely meaningless and all backwards


System B: Via C3 on VT82C694X based MoBo.

Problem: Output is meaningless, see attached file gauss.sensors.out



Thanks.

-- 
timothy.covell@ashavan.org.
-------------- next part --------------
lm80-i2c-0-2d
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
+5V:       +4.26 V  (min =  +4.84 V, max =  +0.00 V)   ALARM
VTT:       +1.47 V  (min =  +2.31 V, max =  +1.51 V)   ALARM
+3.3V:     +2.33 V  (min =  +3.96 V, max =  +3.28 V)   
+Vcore:    +0.00 V  (min =  +3.27 V, max =  +2.74 V)   
+12V:     +13.01 V  (min = +10.80 V, max = +11.43 V)   ALARM
-12V:      -8.42 V  (min =  -9.74 V, max =  -7.66 V)   
-5V:       -3.19 V  (min =  -3.97 V, max =  -2.74 V)   ALARM
fan1:     10629 RPM  (min = 6000 RPM, div = 1)          
fan2:     12980 RPM  (min = 6000 RPM, div = 1)          
temp:     +127.00 ?C (hot:limit =  +6?C,  hysteresis =  +5?C) ALARM
         (os: limit =  +6?C,  hysteresis =  +5?C) ALARM
alarms:   Board temperature input (a LM75 perhaps?)    ALARM
alarms:   Chassis intrusion detection                  ALARM

via686a-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU core:  +1.59 V  (min =  +1.79 V, max =  +2.18 V)   
+2.5V:     +0.00 V  (min =  +2.24 V, max =  +2.74 V)   
I/O:       +3.27 V  (min =  +2.95 V, max =  +3.62 V)   
+5V:       +4.82 V  (min =  +4.47 V, max =  +5.49 V)   
+12V:     +11.68 V  (min = +12.52 V, max = +10.25 V)   
CPU Fan:  6490 RPM  (min = 135000 RPM, div = 2)          
P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)          
SYS Temp: +39.3?C   (limit = -59?C, hysteresis = -61?C) 
CPU Temp: +32.4?C   (limit = -71?C, hysteresis = +86?C) 
SBr Temp: +25.3?C   (limit = +50?C, hysteresis = +60?C) 

eeprom-i2c-0-50
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        256

eeprom-i2c-0-51
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        256

eeprom-i2c-2-50
Adapter: I2C Voodoo3/Banshee adapter
Algorithm: Bit-shift algorithm

-------------- next part --------------
lm80-i2c-0-2d
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
+5V:       +3.61 V  (min =  +4.84 V, max =  +0.00 V)   ALARM
VTT:       +1.39 V  (min =  +1.71 V, max =  +1.51 V)   ALARM
+3.3V:     +2.40 V  (min =  +2.97 V, max =  +3.63 V)   ALARM
+Vcore:    +3.11 V  (min =  +2.52 V, max =  +3.08 V)   ALARM
+12V:     +13.33 V  (min = +10.80 V, max = +13.20 V)   ALARM
-12V:      -5.09 V  (min =  -6.79 V, max =  -4.71 V)   
-5V:       -1.67 V  (min =  -2.50 V, max =  -1.28 V)   
fan1:     10546 RPM  (min = 6000 RPM, div = 1)          
fan2:       -1 RPM  (min = 6783 RPM, div = 1)          
temp:     -128.00 ?C (hot:limit =  +6?C,  hysteresis =  +5?C) ALARM
         (os: limit = -73?C,  hysteresis =  +5?C) ALARM
alarms:   Board temperature input (a LM75 perhaps?)    ALARM
alarms:   Chassis intrusion detection                  ALARM

eeprom-i2c-0-52
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        128

via686a-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU core:  +1.64 V  (min =  +1.79 V, max =  +2.18 V)   
+2.5V:     +2.50 V  (min =  +2.48 V, max =  +2.03 V)   
I/O:       +3.35 V  (min =  +3.32 V, max =  +2.71 V)   
+5V:       +4.99 V  (min =  +5.17 V, max =  +4.23 V)   
+12V:     +11.80 V  (min = +12.52 V, max = +10.25 V)   
CPU Fan:     0 RPM  (min = 135000 RPM, div = 2)          
P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)          
SYS Temp: +27.6?C   (limit = +50?C, hysteresis = -61?C) 
CPU Temp: +28.8?C   (limit = +50?C, hysteresis = +60?C) 
SBr Temp: +22.5?C   (limit = +50?C, hysteresis = +60?C) 
