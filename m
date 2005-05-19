From: hans@dipsy.dhs.org (h.mulder)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=813
Message-Id: <3C658B79.5020609@dipsy.dhs.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Testresults,
1)init via bios
2)modprobe w83781d force_w83627hf=0,0x2c 
force_subclients=0,0x2c,0x4a,0x4b force_w83782d=0,0x2d init=0

3) sensors -s;sensors output
w83627hf-i2c-0-2c
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore:     +1.74 V  (min =  +1.71 V, max =  +1.88 V)       ALARM
in1:       +1.69 V  (min =  +1.64 V, max =  +2.04 V)       ALARM
+3.3V:     +3.31 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.84 V  (min =  +4.72 V, max =  +5.24 V)
+12V:      +9.35 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.44 V  (min = -13.21 V, max = -10.90 V)
-5V:       -0.08 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.48 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +2.56 V  (min =  +2.40 V, max =  +3.60 V)
CPU0:     3068 RPM  (min = 1205 RPM, div = 8)
CPU1:        0 RPM  (min = 2481 RPM, div = 8)
fan3:        0 RPM  (min = 7031 RPM, div = 8)
temp1:    +50.0?C   (limit = +100?C, hysteresis = -107?C) sensor = 3904 
transistor
temp2:    +51.5?C   (limit = +80?C, hysteresis = +75?C) sensor = 3904 
transistor
temp3:    +40.5?C   (limit = +80?C, hysteresis = +75?C) sensor = 3904 
transistor
vid:      +1.85 V
alarms:   Chassis intrusion detection
beep_enable:
           Sound alarm enabled

w83782d-i2c-0-2d
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.72 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
VCore 2:   +1.80 V  (min =  +1.74 V, max =  +1.93 V)
+3.3V:     +2.55 V  (min =  +3.11 V, max =  +3.46 V)
+5V:       +4.67 V  (min =  +4.72 V, max =  +5.24 V)
+12V:      +4.67 V  (min = +10.79 V, max = +13.19 V)
-12V:      -2.37 V  (min = -13.21 V, max = -10.90 V)
-5V:       +2.62 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +4.18 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +2.06 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =   -1 RPM, div = 8)
fan2:        0 RPM  (min =   -1 RPM, div = 8)
fanPSU:   5152 RPM  (min = 3000 RPM, div = 2)
temp1:    +56.0?C   (limit = +40?C, hysteresis = +37?C) sensor = 3904 
transistor
temp2:    +54.5?C   (limit = +80?C, hysteresis = +75?C) sensor = 3904 
transistor
temp3:    +60.5?C   (limit = +80?C, hysteresis = +75?C) sensor = 3904 
transistor
vid:      +1.85 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm enabled


Hope it helps.
cu Hans
