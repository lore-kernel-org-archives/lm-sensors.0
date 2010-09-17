From: Brent Clark <brentgclark@gmail.com>
Date: Fri, 17 Sep 2010 15:11:16 +0000
Subject: [lm-sensors] lmsensor not happy
Message-Id: <4C938514.5010804@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To whom it may concern

I just started using Nagios'es check_sensor and immediately I started 
getting an error.

The CPU shows the tempreture is all fine, but there appears to be an 
additional sensor showing that somethings up.

Would anyone know what this is and where I could possible look.

Brent


root@chs-bac01:/usr/lib/nagios/plugins# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +40.0\ufffdC  (high = +74.0\ufffdC, crit = +100.0\ufffdC)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +30.0\ufffdC  (high = +74.0\ufffdC, crit = +100.0\ufffdC)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +36.0\ufffdC  (high = +74.0\ufffdC, crit = +100.0\ufffdC)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +37.0\ufffdC  (high = +74.0\ufffdC, crit = +100.0\ufffdC)

w83627dhg-isa-0290
Adapter: ISA adapter
VCore:       +1.14 V  (min =  +0.00 V, max =  +1.74 V)
in1:        +10.77 V  (min =  +1.80 V, max =  +3.80 V)   ALARM
AVCC:        +3.34 V  (min =  +0.13 V, max =  +3.26 V)   ALARM
3VCC:        +3.34 V  (min =  +0.08 V, max =  +0.51 V)   ALARM
in4:         +1.83 V  (min =  +0.81 V, max =  +0.04 V)   ALARM
in5:         +1.25 V  (min =  +1.22 V, max =  +0.55 V)   ALARM
in6:         +0.31 V  (min =  +0.10 V, max =  +0.49 V)
VSB:         +3.31 V  (min =  +2.22 V, max =  +2.21 V)   ALARM
VBAT:        +3.25 V  (min =  +2.08 V, max =  +0.21 V)   ALARM
Case Fan:   2033 RPM  (min = 1259 RPM, div = 8)
CPU Fan:    1061 RPM  (min = 2636 RPM, div = 8)  ALARM
Aux Fan:       0 RPM  (min =    0 RPM, div = 128)  ALARM
fan4:          0 RPM  (min = 10546 RPM, div = 128)  ALARM
fan5:          0 RPM  (min = 10546 RPM, div = 128)  ALARM
Sys Temp:    +52.0\ufffdC  (high = +30.0\ufffdC, hyst = +64.0\ufffdC)  
sensor = diode
CPU Temp:    +20.0\ufffdC  (high = +80.0\ufffdC, hyst = +75.0\ufffdC)  
sensor = diode
AUX Temp:   +127.0\ufffdC  (high = +80.0\ufffdC, hyst = +75.0\ufffdC)  
ALARM  sensor = thermistor
cpu0_vid:   +2.050 V

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
