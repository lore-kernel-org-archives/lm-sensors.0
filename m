From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: wrong cpu temp
Message-Id: <001201c33f14$0ee832a0$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, now i'm running sensors but shows wrong temperature.

    with 'modprobe it87' show:
it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.69 V  (min =  +1.53 V, max =  +1.87 V)
VCore 2:   +1.31 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
+3.3V:     +6.78 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +5.04 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.40 V  (min = +11.36 V, max = +13.80 V)
-12V:     -12.56 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -8.05 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +5.11 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +0.00 V
fan1:     4411 RPM  (min = 3000 RPM, div = 2)
fan2:     3750 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +40?C  (min =  +20?C, max =  +60?C)
Temp2/CPU:   +89?C  (min =  +20?C, max =  +60?C) ALARM
Temp3:       -55?C  (min =  +20?C, max =  +60?C)


and with 'modprobe it87 temp_type=0x290' tha i think is the correct parameter for my it87. show negative number

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.69 V  (min =  +1.53 V, max =  +1.87 V)
VCore 2:   +1.32 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
+3.3V:     +6.78 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +5.02 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.48 V  (min = +11.36 V, max = +13.80 V)
-12V:     -10.56 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -7.84 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +5.11 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +0.00 V
fan1:     4411 RPM  (min = 3000 RPM, div = 2)
fan2:     3750 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +40?C  (min =  +20?C, max =  +60?C)
Temp2/CPU:   -55?C  (min =  +20?C, max =  +60?C)
Temp3:       -55?C  (min =  +20?C, max =  +60?C)



the temp of motherboard is well, the mb is a gigabyte GA-7VAXP-A Ultra with KT400A and vt8235 with it8705f chip.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030630/4577983b/attachment.html
