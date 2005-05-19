From: luzik@ds.pg.gda.pl (Maciej Swiniarski)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: Gigabyte-GA-8ST-it87 Randomize reading result
Message-Id: <Pine.LNX.4.44L.0208241235050.5071-100000@piorun.ds.pg.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
temperature any of the sensors is oscillate from -100 to 81
voltage are oscillate too
Only fun speed is correct
Is it problem with my motherboard?
have anybody test lm_sensor  whit the same moderboard

---------------------------
Temperature in my room is 25 C

results wiht 5 sec. step

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.02 V  (min =  +1.53 V, max =  +1.87 V)   ALARM
VCore 2:   +0.78 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
+3.3V:     +1.34 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +1.48 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
+12V:      +7.36 V  (min = +11.36 V, max = +13.80 V)   ALARM
-12V:     -14.78 V  (min = -15.86 V, max = -13.40 V)
-5V:       -4.46 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +3.41 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
VBat:      +0.00 V
fan1:     3040 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +14C  (min =  +20C, max =  +60C)
Temp2/CPU:  -100C  (min =  +20C, max =  +60C) ALARM
Temp3:       +48C  (min =  +20C, max =  +60C)

----------------------------it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.49 V  (min =  +1.53 V, max =  +1.87 V)   ALARM
VCore 2:   +2.12 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
+3.3V:     +4.18 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +3.16 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
+12V:      +8.76 V  (min = +11.36 V, max = +13.80 V)   ALARM
-12V:     -15.86 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -5.33 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +2.17 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
VBat:      +0.00 V
fan1:     3040 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +59C  (min =  +20C, max =  +60C)
Temp2/CPU:  +104C  (min =  +20C, max =  +60C)
Temp3:       +47C  (min =  +20C, max =  +60C)
--------------------------it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.28 V  (min =  +1.53 V, max =  +1.87 V)   ALARM
VCore 2:   +2.48 V  (min =  +2.25 V, max =  +2.75 V)
+3.3V:     +3.80 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +4.08 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
+12V:      +6.00 V  (min = +11.36 V, max = +13.80 V)   ALARM
-12V:     -12.94 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -4.16 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +2.42 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
VBat:      +0.00 V
fan1:     3026 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +44C  (min =  +20C, max =  +60C)
Temp2/CPU:   +59C  (min =  +20C, max =  +60C)
Temp3:       +46C  (min =  +20C, max =  +60C)






