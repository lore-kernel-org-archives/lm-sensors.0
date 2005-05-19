From: bezza@org.ukr.net (Andrew Bezugly)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: cpu temperature discovering problem on w83627hf
Message-Id: <70486737687.20030519114320@org.ukr.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

I have a problem with CPU temperature discovering.

Motherboard - Tyan S2460 Tiger MP AMD 760MP
CPUs - 2 ? AMD Athlon MP 2200+
I/O & SMART@I/O chip - Winbond w83627hf

I  installed lm-sensors-2.7.0 and configured as told in documentation.
And here are results:

[root@peshka sensors]# sensors
w83627hf-i2c-0-2c
Adapter: SMBus AMD766 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.71 V  (min =  +1.56 V, max =  +1.72 V)       ALARM  
VCore 2:   +1.61 V  (min =  +1.56 V, max =  +1.72 V)       ALARM  
+3.3V:     +3.34 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.72 V  (min =  +4.72 V, max =  +5.24 V)       ALARM  
+12V:      +9.58 V  (min = +10.79 V, max = +13.19 V)              
-12V:     -12.03 V  (min = -13.21 V, max = -10.90 V)              
-5V:       -0.24 V  (min =  -5.26 V, max =  -4.76 V)              
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.28 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     4500 RPM  (min = 3000 RPM, div = 2)                     
fan2:     4411 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
temp1:       +46?C  (limit =  +40?C, hysteresis =  +37?C) sensor = 3904 transistor           
temp2:      +0.0?C  (limit =  +80?C, hysteresis =  +75?C) sensor = 3904 transistor           
temp3:      +1.5?C  (limit =  +80?C, hysteresis =  +75?C) sensor = 3904 transistor           
vid:      +1.650 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

Temp1 is probably normal, but the other two  - ???
I have no idea how to cope with it. Could you help?


Thank you.

Ukraine,Kiev,
SDPU(U),
System administrator,
Andrew Bezugly

mailto: bezza@sdpuo.com


