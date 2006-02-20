From: condor@stz-bg.com (Condor)
Date: Mon, 20 Feb 2006 06:45:32 +0000
Subject: [lm-sensors] QDI Platinix 2E/333 chip w83627hf-isa-0290 incorect
Message-Id: <200602200845.32417.condor@stz-bg.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

i use lm_sensors 2.10.0 and i have problems:

lsmod:
----
i2c_i801                8588  0
eepro100               27280  0
w83627hf               22800  0
hwmon_vid               3072  1 w83627hf
hwmon                   3204  1 w83627hf
eeprom                  6416  0
i2c_isa                 4480  1 w83627hf
i2c_core               17664  4 i2c_i801,w83627hf,eeprom,i2c_isa
----

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.47 V  (min =  +1.41 V, max =  +1.55 V)
VCore 2:   +4.08 V  (min =  +1.41 V, max =  +1.55 V)       ALARM
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.13 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.22 V  (min = +10.82 V, max = +13.19 V)
-12V:     -11.95 V  (min = -13.18 V, max = -10.80 V)
-5V:       +2.84 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.51 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
VBat:      +3.23 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 168750 RPM, div = 8)              ALARM
fan2:     3183 RPM  (min =   -1 RPM, div = 8)              ALARM
fan3:        0 RPM  (min = 168750 RPM, div = 8)              ALARM
temp1:       +34?C  (high =    +0?C, hyst =    +1?C)   sensor = thermistor   
ALARM
temp2:     +45.0?C  (high =   +75?C, hyst =   +70?C)   sensor = diode           
(beep)
temp3:     +57.0?C  (high =   +75?C, hyst =   +70?C)   sensor = thermistor      
vid:      +1.475 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm enabled

Do any body can say me how i fix these ALARM's because this is impossible i to 
have +4.08V for VCore 2 that the max is +1.55V and anothers ALARM's

Regards,
John

