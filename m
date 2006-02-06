From: swsnyder@insightbb.com (Steve Snyder)
Date: Mon, 06 Feb 2006 13:59:54 +0000
Subject: [lm-sensors] ISA and PIIX4 both working; which to use?
Message-Id: <200602060859.54544.swsnyder@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the advice of sensors-detect I am using the following modules under 
Fedora Core 4 on my 440BX-based system:

MODULE_0=i2c-piix4
MODULE_1=i2c-isa
MODULE_2=w83781d
MODULE_3=smbus-arp

When I run sensors, I get duplicated output (see below).  I don't need both 
of these sources to be queried and plan to stop using one of them.

Which of these 2 sources is preferred over the other?

Thanks.

------------------------------

w83782d-isa-0290
Adapter: ISA adapter
VCore 1:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
VCore 2:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.47 V  (min =  +3.14 V, max =  +3.46 V)       ALARM
+5V:       +4.95 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +12.10 V  (min = +10.82 V, max = +13.19 V)
-12V:     -12.11 V  (min = -13.18 V, max = -10.88 V)
-5V:       -5.05 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.13 V  (min =  +4.73 V, max =  +5.24 V)              (beep)
VBat:      +3.15 V  (min =  +2.40 V, max =  +3.60 V)              (beep)
fan1:     4720 RPM  (min = 2657 RPM, div = 2)
fan2:     4687 RPM  (min = 2657 RPM, div = 2)
fan3:     1506 RPM  (min =  664 RPM, div = 8)
temp1:       +38?C  (high =  +127?C, hyst =    +0?C)   sensor = thermistor
temp2:     +50.5?C  (high =   +70?C, hyst =   +69?C)   sensor = thermistor
temp3:     +47.5?C  (high =   +70?C, hyst =   +69?C)   sensor = thermistor
vid:      +1.650 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled

w83782d-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 5000
VCore 1:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
VCore 2:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.46 V  (min =  +3.14 V, max =  +3.46 V)       ALARM
+5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +12.10 V  (min = +10.82 V, max = +13.19 V)
-12V:     -12.11 V  (min = -13.18 V, max = -10.88 V)
-5V:       -5.05 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.13 V  (min =  +4.73 V, max =  +5.24 V)              (beep)
VBat:      +3.15 V  (min =  +2.40 V, max =  +3.60 V)              (beep)
fan1:     4720 RPM  (min = 2657 RPM, div = 2)
fan2:     4787 RPM  (min = 2657 RPM, div = 2)
fan3:     1506 RPM  (min =  664 RPM, div = 8)
temp1:       +37?C  (high =  +127?C, hyst =    +0?C)   sensor = thermistor
temp2:     +50.5?C  (high =   +70?C, hyst =   +69?C)   sensor = thermistor
temp3:     +47.0?C  (high =   +70?C, hyst =   +69?C)   sensor = thermistor
vid:      +1.650 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled

