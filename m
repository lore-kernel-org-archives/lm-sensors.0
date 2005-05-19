From: Herbert.Huber@lrz-muenchen.de (Herbert Huber)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: Ticket 1193
Message-Id: <3E8424F4.125B36AE@lrz-muenchen.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E8413B4.95658DB1@lrz-muenchen.de>
In-Reply-To: <3E8413B4.95658DB1@lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The actual i2c CVS sources still have version 2.7.0 in  i2c.h!
So I chaned this to 2.8.0 CVS to be shure that the i2c modules loaded
are the actual ones.
The oops I've reported in ticket 1193 was caused by the same reason as
explained
and fixed in ticket 1175. So using this patch I can load and unload the
w83627hf.o module without any problems.

So the actual situation is now the following:

Loading all necessary modules and typing sensors -s followed by sensors,

the actual sensors binary doesn't find any sensors at all.
Doing the same using the sensors binary form 2.6.0 I get a reasonable
output:

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.53 V  (min =  +1.37 V, max =  +1.52 V)       ALARM
VCore 2:   +3.23 V  (min =  +1.37 V, max =  +1.52 V)
+3.3V:     +3.32 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.97 V  (min = +10.79 V, max = +13.19 V)
-12V:     -11.41 V  (min = -13.21 V, max = -10.90 V)
-5V:       -3.00 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.39 V  (min =  +4.72 V, max =  +5.24 V)       ALARM
VBat:      +3.05 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     4530 RPM  (min = 3000 RPM, div = 2)
fan2:     3199 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 1500 RPM, div = 4)
temp1:    +36.0?C   (limit = +60?C, hysteresis = +127?C) sensor thermistor

temp2:    +208.0?C   (limit = +60?C, hysteresis = +50?C) sensor thermistor

temp3:    +40.0?C   (limit = +60?C, hysteresis = +50?C) sensor PII/Celeron diode
vid:      +1.45 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled

So does anybody know what's wrong with the newest sensors binary?


Regards,

Herbert
-------------- next part --------------
A non-text attachment was scrubbed...
Name: herbert.huber.17386DEFANGED-vcf
Type: application/octet-stream
Size: 378 bytes
Desc: Visitenkarte f?r Herbert Huber
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030328/870e2035/herbert.huber.obj
