From: pgunreben@lucent.com (Gunreben, Peter (Peter))
Date: Mon, 11 Jul 2005 16:32:27 +0000
Subject: [lm-sensors] sensors.conf for Asus A7M266-D (Dual Athlon MP 1900+)
Message-Id: <FB3C0705909A7E4A9D832D5CD5A4289206D0CF99@ge1884exch001u.de.lucent.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

does anybody have a correct "sensors.conf" for the
Asus A7M266-D (Dual Athlon MP 1900+) board? 
I'm almost sure that the formulas for the following
values are not correct:

-12V
-5V
M/B Temp
CPU Temp
temp3

Here's the output of sensors:
=======8<========as99127f-i2c-0-2d
Adapter: SMBus AMD768 adapter at e4e0
VCore 1:   +1.76 V  (min =  +1.66 V, max =  +1.82 V)
VCore 2:   +1.71 V  (min =  +1.66 V, max =  +1.82 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.00 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.98 V  (min = +10.82 V, max = +13.19 V)
-12V:      -3.18 V  (min = -13.22 V, max = -10.74 V)       ALARM
-5V:       -0.77 V  (min =  -5.25 V, max =  -4.74 V)
fan1:     4720 RPM  (min = 4891 RPM, div = 2)
fan2:     4856 RPM  (min = 4017 RPM, div = 2)
fan3:        0 RPM  (min = 2743 RPM, div = 2)
M/B Temp:    +27??C  (high =  -100??C, hyst =   +64??C)   ALARM
CPU Temp:  +90.0??C  (high =  +190??C, hyst =  +170??C)          (beep)
temp3:     +89.0??C  (high =  +190??C, hyst =  +170??C)
vid:      +1.750 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm enabled
=======8<========
The labels should also be CPU0 Temp, CPU1 Temp
and so on. Is there anyone, who can help?

Thanks,

Peter.


