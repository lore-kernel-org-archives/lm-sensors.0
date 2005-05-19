From: swsnyder@insightbb.com (Steve Snyder)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Fwd: lmsensors displays video voltage incorrectly
Message-Id: <200209171620.29004.swsnyder@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

One more thing I forgot to mention: the video voltage value is correct in 
the /proc filesystem:

# cat /proc/sys/dev/sensors/w83627hf-isa-0290/vid
1.350

FYI.

----------  Forwarded Message  ----------

Subject: lmsensors displays video voltage incorrectly
Date: Tue, 17 Sep 2002 15:54:59 -0500
From: Steve Snyder <swsnyder@insightbb.com>
To: sensors@stimpy.netroedge.com

Hello.

The video voltage is shown at x10 the actual voltage.

I have seen this behavior with both the 2.6.5 and 2.6.4  versions of
lmsensors, and with 3 different chips (w83781d-isa-0290, w83782d-isa-0290
and w83627hf-isa-0290).

In all permutation of the above software versions and chips, I have been
running Red Hat Linux v7.2 with a stock v2.4.19 kernel  The 'sensors'
program and the sensors.conf in use have been from 2.6.4/2.6.5, not the
files from the RH distribution.

The I2C driver and /proc interface are builtinfo the kernel, while the
i2c-isa and w83781d drivers are loaded as modules.

Below are a couple of examples.  Those 13.50 and 16.500 voltages should
actually be 1.35 and 1.65, respectively.  On a thirm machine (not shown
below) a voltage of 2.0 is displayed as 20.00.  Hmm.  All other reported
values seem reasonable.

Note that this problem is *not* seen with version 2.6.3 of the lmsensors
package.

If there is any aditional info I can provide, please let me know.

Thanks.

----------
# sensors
w83782d-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.68 V  (min =  +4.08 V, max =  +4.08 V)
VCore 2:   +1.68 V  (min =  +4.08 V, max =  +4.08 V)
+3.3V:     +3.45 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.11 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.01 V  (min = +10.79 V, max = +13.11 V)
-12V:     -12.24 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.51 V, max =  -4.51 V)
V5SB:      +5.11 V  (min =  +4.50 V, max =  +5.48 V)              (beep)
VBat:      +3.12 V  (min =  +2.70 V, max =  +3.29 V)              (beep)
fan1:     4927 RPM  (min = 3000 RPM, div = 2)
fan2:     4856 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min =  750 RPM, div = 8)
temp1:     +21.0?C  (limit =  +60?C, hysteresis = +127?C) sensor thermistor
temp2:       +26?C  (limit =  +60?C, hysteresis =  +50?C) sensor thermistor
temp3:       +25?C  (limit =  +60?C, hysteresis =  +50?C) sensor thermistor
vid:      +16.50 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled

----------

# prog/sensors/sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.48 V  (min =  +4.08 V, max =  +4.08 V)
VCore 2:   +3.26 V  (min =  +4.08 V, max =  +4.08 V)
+3.3V:     +3.24 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.80 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.89 V  (min = +10.79 V, max = +13.19 V)
-12V:     -11.62 V  (min = -13.21 V, max = -10.90 V)
-5V:       -2.09 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.31 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.18 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     3443 RPM  (min = 3000 RPM, div = 2)
fan2:     3461 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 1500 RPM, div = 4)
temp1:       +34?C  (limit =  +60?C)                       sensor thermistor
temp2:     +33.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor thermistor
temp3:     +31.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor thermistor
vid:      +13.500 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

----------

-------------------------------------------------------

