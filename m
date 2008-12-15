From: "=?ISO-8859-1?Q?Ludovic_Leb=E8gue?=" <ludovic@lebegue.org>
Date: Mon, 15 Dec 2008 22:20:03 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <689a35800812151420y3b7b7e33jc7ec60c9fd3319e6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

I compiled and tested the driver.

Here is the kernel log at startup :

Dec 15 23:07:46 xxxx kernel: [82199.773523] f71882fg: Found f8000 chip
at 0xa00, revision 41
Dec 15 23:07:46 xxxx kernel: [82199.773742] f71882fg f71882fg.2560:
Fan: 1 is in duty-cycle mode
Dec 15 23:07:46 xxxx kernel: [82199.773745] f71882fg f71882fg.2560:
Fan: 2 is in duty-cycle mode
Dec 15 23:07:46 xxxx kernel: [82199.773748] f71882fg f71882fg.2560:
Fan: 3 is in duty-cycle mode

Here is the "sensors"  (sensors version 3.0.2 with libsensors version
3.0.2) output :

f8000-isa-0a00
Adapter: ISA adapter
in0:         +1.68 V
in1:         +1.67 V
in2:         +1.64 V
fan1:       1486 RPM
fan2:        894 RPM
fan3:          0 RPM  ALARM
fan4:       34464 RPM
temp1:       +46.0=B0C  (high =3D +70.0=B0C, hyst =3D +60.0=B0C)
temp2:       +41.0=B0C  (high =3D +100.0=B0C, hyst =3D +85.0=B0C)  sensor =
=3D Intel PECI
temp3:       +40.0=B0C  (high =3D +100.0=B0C, hyst =3D +85.0=B0C)

There are only two fans on my computer.
"fan3:          0 RPM  ALARM " seems alright as there is no fan.
"fan4:       34464 RPM" is a bit strange

Voltage indication seems to be divided by two. I guess sensors3.conf
should be modified for f8000 chip.

Regards
Ludovic Leb=E8gue


On Mon, Dec 15, 2008 at 7:03 PM, Chuan-kai Lin <cklin@cs.pdx.edu> wrote:
> On Mon, Dec 15, 2008 at 04:32:09PM +0100, Hans de Goede wrote:
>> I got your email address from Jean Delvare. I'm the f71882fg maintainer
>> and I've been working on adding f8000 support to the f71882fg driver.
>> That work is now finished.
>
> Hi Hans,
>
> Thank you for your great work!  The module builds and loads fine in
> 2.6.27.8 on my Dell Studio Slim 540s desktop computer, and sensors shows
> fan speed, voltage, and temperature measurements.  Very cool!!  I have
> attached two files showing the driver in action:
>
> idle.txt - sysfs contents on an idle system right after bootup
> loaded.txt - sysfs contents + sensors output on a loaded system
>
> Here are some issues I found:
>
>  1. There are only two fans in my system.  The driver reports 0 RPM for
>    the third fan (which sounds right), and some absurdly high RPM for
>    the fourth fan (which sounds wrong).
>
>  2. When the driver loads into the kernel, it reports that there are
>    three fans, and they are all in duty-cycle mode.  However, only the
>    CPU fan (fan2) uses a 4-pin connector; the case fan (fan1) uses a
>    3-pin connector.  I seem to recall that a fan on a 3-pin connector
>    can be controlled through only DC voltage?
>
>  3. The full-speed number seems to record the maximum measured fan speed
>    instead of the maximum possible fan speed.
>
>  4. I cannot change fan speed by altering tempX_auto_pointY_pwm values.
>    However, both the CPU fan and the case fan do speed up when the
>    system gets warm.
>
> I am happy to provide more information to help you diagnose the
> problems.
>
> --
> Chuan-kai Lin
> http://web.cecs.pdx.edu/~cklin/
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
