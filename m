From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: wrong temp
Message-Id: <000801c33f19$ebf462e0$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think the correct value is 'temp_type=0x0e' but shows wrong temp in cpu.


it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.69 V  (min =  +1.53 V, max =  +1.87 V)
VCore 2:   +1.32 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
+3.3V:     +6.74 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +4.99 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.52 V  (min = +11.36 V, max = +13.80 V)
-12V:     -10.10 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -5.07 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +5.11 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +0.00 V
fan1:     5400 RPM  (min = 3000 RPM, div = 2)
fan2:     3770 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +42?C  (min =  +20?C, max =  +60?C)
Temp2/CPU:   +89?C  (min =  +20?C, max =  +60?C)
Temp3:       +88?C  (min =  +20?C, max =  +60?C)


when processating '89?' and normal state 88?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030630/97f3ae23/attachment.html
