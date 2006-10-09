From: tuharsky@misbb.sk (Mgr. Peter Tuharsky)
Date: Mon, 09 Oct 2006 13:28:52 +0000
Subject: [lm-sensors] Wrong sensors order for MSI K8MM-V (MS7142),
Message-Id: <452A4E94.5040307@misbb.sk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo

I'm posting my experience with sensors in order to make DB more
accurate, so that less experienced users could gain the sensors give
good results automatically, without need of tackling the sensors.conf

This is the result from MSI K8MM-V (MS7142), chipset VIA K8M800-CE + VIA
VT8237R.

-Note the temp3 (probably should be CPU)

-VCore +1.55V is probably suitable for Athlon64 2800+ and the 1.94 is
really out of order

-12V is between the interval limits, however ALARM is signalised. Maybe
MIN and MAX values should be switched!

-CPU temp should be OK if bellow 70C

Please, if You need more info, or am I on wrong address, let me know and
I'll do what I can.



w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.55 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
+12V:     +11.80 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -11.78 V  (min = -10.80 V, max = -13.18 V)       ALARM
V5SB:      +4.95 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.50 V  (min =  +2.40 V, max =  +3.60 V)
CPU Fan:     0 RPM  (min =   -1 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 6750 RPM, div = 2)              ALARM
M/B Temp:    +47?C  (high =    +1?C, hyst =    +0?C)   sensor thermistor   ALARM
CPU Temp:  +52.5?C  (high =   +60?C, hyst =   +55?C)   sensor = thermistor
temp3:     +68.5?C  (high =   +60?C, hyst =   +55?C)   sensor thermistor   ALARM
vid:      -0.025 V  (VRM Version 2.4)
alarms:
beep_enable:
           Sound alarm enabled


