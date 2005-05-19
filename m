From: lourens@rainbowdesert.net (Lourens Veen)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <200407221213.00965.lourens@rainbowdesert.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I recently got an ASRock K7S8X mainboard, using the SiS 746FX 
chipset. I'm using vanilla Linux 2.4.26, i2c-2.8.7 and 
lm_sensors-2.8.7. The sensors detect script detected a W83697HF 
chip on the ISA bus through a SiS 85C503 ISA bridge. I have the 
i2c-core, i2c-sis645, i2c-isa and i2c-proc modules loaded, as well 
as the w83627hf module. An EEPROM which seems related to my RAM was 
also detected, as was the SiS 5595, which is commonly misdetected I 
read, and I've ignored the latter two.

This seems to work, but only partially. Here are my current values:

root@nova:~# sensors
w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.74 V  (min =  +1.71 V, max =  +1.89 V)
+3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.87 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +11.32 V  (min = +10.83 V, max = +13.19 V)
-12V:      +0.56 V  (min = -13.16 V, max = -10.90 V)
-5V:       +1.84 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.54 V  (min =  +4.74 V, max =  +5.24 V)
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     2755 RPM  (min = 135000 RPM, div = 2)
fan2:        0 RPM  (min =   -1 RPM, div = 2)
temp1:       +49 C  (high =   +68 C, hyst =   -94 C)   sensor = 
PII/Celeron diode
temp2:     +43.5 C  (high =  +120 C, hyst =  +120 C)   sensor = 
PII/Celeron diode
alarms:
beep_enable:
          Sound alarm enabled

The positive values seem to be alright. -12V and -5V obviously 
aren't. Fan1 (the CPU fan) seems to be okay, but Fan2 (case fan) 
gives 0 rpm, even though it is actually running. Temperature 
readings do work.

If anyone could shed any light on this I'd love to hear. Are the 
negative voltages simply not connected? Perhaps fan2 is not the 
case fan? Or is the hardware broken?

Please CC me, as I'm not on the list.

Thanks in advance,

Lourens
-- 
GPG public key: http://home.student.utwente.nl/l.e.veen/lourens.key

