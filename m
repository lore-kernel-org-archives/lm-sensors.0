From: oe@hentges.net (Matthias Hentges)
Date: Wed, 06 Sep 2006 11:53:58 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems	w/
Message-Id: <1157543638.8827.6.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Dienstag, den 05.09.2006, 18:20 +0200 schrieb Jean Delvare:
> David, Matthias,
> 
> > Nice to get some feedback on w83627ehf. The datasheet documents only 4
> > RPM sensors, but 5 pwm outputs. That's if your motherboard uses the
> > standard w83627ehf without any additional electronics.
> 
> No, that's the other way around. 5 RPM sensors, 4 PWM output.
> 
> > Can you disconnect one fan at a time while in the BIOS readings and
> > verify that each is independent of all other fans? I wonder if the
> > BIOS is actually getting 5 independent RPM readings.
> 
> The number of readings in the BIOS matches the number of fan monitoring
> inputs of the chip - looks clear enough to me.

Indeed, here's what the BIOS looks like:
http://hentges.net/tmp/photos/p5w%20dh%20deluxe/hwmon/

> > Also, is there some way (a different OS, or in the BIOS) that you can
> > actually control each of the fans independently? I'm looking for more
> > info on your motherboard, but there is the possibility that the two
> > CHA fans and the two PWR fans are actually hard-wired together.
> 
> This is my conclusion as well. The PWM outputs wiring is decided by the
> motherboard maker, and they may use the same PWM output for several
> fans. Given that there are only 4 PWM outputs they actually had little
> choice for at least two fans. It makes sense to me to control related
> fans with a single command too.

Looks like you are right, SpeedFan on the "other" OS behaves exactly
like lm-sensors.
both CHA and both PWR fans can only be controlled together :\

> > Can you provide a listing of the sysfs files exported by the driver on
> > your system?

The listing is attached.

>  The w83627ehf pins for fans 4 and 5 can be programmed as
> > general purpose I/O, and the driver detects whether you have 3, 4, or
> > 5 fan pins configured. (The setting is read, but not changed.) So...do
> > you have pwm4 and pwm5 in your sysfs?
> 
> Matthias, can you please provide a dump of your chip (isadump 0x295
> 0x296) at init time, before loading the w83627ehf driver?

The dump is attached. It was taken before loading any modules
(init=/bin/sh).

> I'd try forcing the driver to use all 5 fan inputs. Just run "isaset
> 0x295 0x296 0x47 0x05 0x05" before loading the w83627ehf driver, and
> see what happens. It's supposed to be the default, but...

I tried it, no success :\ I still only get 4 fans.

> Maybe our heuristics to detect the use of the pins are not correct,
> although they are simple enough and look OK to me. Or maybe the Asus
> BIOS isn't configuring the chip properly (that'd be odd as they need
> proper setup for displaying the values themselves.)
> 
-- 
Matthias 'CoreDump' Hentges 

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 00 2b 3f 33 c0 9b c0 9b 3c 3c 01 01 
10: 01 5e 70 00 00 01 01 3c 43 17 00 00 57 00 00 d3 
20: 8f ef d3 d3 d5 cb cc 27 ad 89 a9 da 00 f7 fe ff 
30: 7f 57 ed 1f fd f9 fe bf df 3c 37 0f 78 0f 0a 55 
40: 03 fa af de ff ff 00 f4 2d ff 00 c4 98 95 06 a3 
50: e4 1f 59 96 3a 39 3d 3d ff ff ff ff ff ff ff ff 
60: 04 ff 03 21 f0 f0 3c ff 01 ff 01 ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: 04 ff 04 ff 00 2b 3f 33 c0 9b c0 9b 3c 3c 01 01 
90: 01 5e 70 00 00 01 01 3c 43 17 00 00 57 00 00 d3 
a0: 8f ef d3 d3 d5 cb cc 27 ad 89 a9 da 00 f7 fe ff 
b0: 7f 57 ed 1f fd f9 fe bf df 3c 37 0f 78 0f 0a 55 
c0: 03 00 00 de ff ff 00 f4 2d ff 00 c4 98 95 06 a3 
d0: e4 1f 59 96 3a 39 3d 3d ff ff ff ff ff ff ff ff 
e0: 04 ff 03 21 f0 f0 3c ff 01 ff 01 ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
-------------- next part --------------
bus
driver
fan1_alarm
fan1_div
fan1_input
fan1_min
fan2_alarm
fan2_div
fan2_input
fan2_min
fan3_alarm
fan3_div
fan3_input
fan3_min
fan4_alarm
fan4_div
fan4_input
fan4_min
hwmon:hwmon0
in0_alarm
in0_input
in0_max
in0_min
in1_alarm
in1_input
in1_max
in1_min
in2_alarm
in2_input
in2_max
in2_min
in3_alarm
in3_input
in3_max
in3_min
in4_alarm
in4_input
in4_max
in4_min
in5_alarm
in5_input
in5_max
in5_min
in6_alarm
in6_input
in6_max
in6_min
in7_alarm
in7_input
in7_max
in7_min
in8_alarm
in8_input
in8_max
in8_min
in9_alarm
in9_input
in9_max
in9_min
name
power
pwm1
pwm1_enable
pwm1_min_output
pwm1_mode
pwm1_stop_time
pwm1_target
pwm1_tolerance
pwm2
pwm2_enable
pwm2_min_output
pwm2_mode
pwm2_stop_time
pwm2_target
pwm2_tolerance
pwm3
pwm3_enable
pwm3_min_output
pwm3_mode
pwm3_stop_time
pwm3_target
pwm3_tolerance
pwm4
pwm4_enable
pwm4_min_output
pwm4_mode
pwm4_stop_time
pwm4_target
pwm4_tolerance
subsystem
temp1_alarm
temp1_input
temp1_max
temp1_max_hyst
temp2_alarm
temp2_input
temp2_max
temp2_max_hyst
temp3_alarm
temp3_input
temp3_max
temp3_max_hyst
uevent
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/33bd7775/attachment.bin 
