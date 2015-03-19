From: Dan Moinescu <dan@moinescu.net>
Date: Thu, 19 Mar 2015 15:44:40 +0000
Subject: [lm-sensors] Report: fan control for IT8620E
Message-Id: <CAKkLDw6p8auatr7YNMM5aO0v=qA8bkXpznLPwbh0PBo8Z8dpiQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello all,

Here's a report on how I managed to control the CPU fan on a
motherboard with the IT8620E chip, as suggested by the lm-sensors
wiki: `you can try loading the it87 driver with force_id=3D0x8728 and
see how it goes. If you do, please report, including the output of
"sensors"`.

First, a quick word on the hardware used. The motherboard is a
Gigabyte GA-B85M-DS3H
(http://www.gigabyte.com/products/product-page.aspx?pid=3D4731)  and the
CPU cooler is an Arctic Cooling Alpine 11 Plus
(http://www.arctic.ac/eu_en/alpine-11-plus.html)
According to the cooler's technical data, the fan can run at speeds
between 500 - 2,000 RPM. However, the BIOS/EFI/UEFI (whatever the
proper name is nowadays) would not let me set the PWM value to less
than 70, which produces a fan speed of about 1300 RPM (too noisy for
my taste).
So below is a description of what I did to bring the fan to minimum
speed. This was done strictly by trial and error; I do not claim this
is the only (or the best) method, it just works for me.

sensors-detect reported "Found unknown chip with ID 0x8620".
I inserted the it87 module as directed by the wiki page:
modprobe it87 force_id=3D0x8728
After this I tried pwmconfig, but it didn't succeed in controlling the
fan (it brought it up to full speed and left it in that state). So
then I tried a manual approach.

Inserting the module creates a directory inside /sys, such as
/sys/devices/platform/it87.2608/:
    sysdir=3D$(find /sys/ -name it87.\* -type d)
Controlling the fans is possible by modifying various files (mainly
pwm1) inside that directory.

The first step is to modify the value inside pwm1_enable from 2 to 1.
This is needed because if pwm1_enable is left at its initial value
(2), pwm1 cannot be changed (attempting to do that produces a "Device
or resource busy" error).
    echo 1 > $sysdir/pwm1_enable

Next the desired pwm value can be written into $sysdir/pwm1. Anything
from 0-8 puts the fan at full speed, and 9 puts it to around 1600 RPM.
Values from 10-255 seem to act as actual pwm values. Initial value was
70 (the value set in BIOS).
    echo 10 > $sysdir/pwm1

This set the fan speed to around 600 RPM, which was a lot better but
still above minimum.
It turned out that the speed can be reduced further by changing the
value in the pwm1_freq file from the initial 46875 to a value less
than 35157:
    echo 35000 >$sysdir/pwm1_freq
After this, the fan speed was reduced to about 470 RPM.

Every time the system wakes up from sleep, all 3 files (pwm1_enable,
pwm1, pwm1_freq) get restored to their initial values, so they need to
be re-written.
In the absence of fancontrol functionality, I wrote a small script
that presumably emulates fancontrol behaviour - it monitors the
temperature output of "sensors" and sets the pwm1 value accordingly.

Hope this helps.
Regards,
Dan.

$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +27.8=B0C  (crit =3D +105.0=B0C)
temp2:        +29.8=B0C  (crit =3D +105.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +40.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 0:         +37.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 1:         +39.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

it8728-isa-0a30
Adapter: ISA adapter
in0:          +0.04 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +2.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.00 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in3:          +2.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in4:          +0.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.73 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.54 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.36 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +2.95 V
fan1:         469 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
fan5:           0 RPM  (min =3D    0 RPM)
temp1:        +37.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp2:       -128.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D disabled
temp3:        +31.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D Intel PECI
intrusion0:  ALARM

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
