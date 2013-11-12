From: "p. stephen w" <p.stephenwille@gmail.com>
Date: Tue, 12 Nov 2013 03:24:11 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <CADkjvt__Dj099oi2a6RCxv9kx-GaB=dMK-0y993YFYGE7yMcpw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The control provided by the NCT chip would be the BIOS control?
My main concern is noise and the BIOS PWM control was still too noisy.
Plus it seemed to respond to CPU load rather then temp.  The slightest load
ramped up the audible level, then back down as it went to idle.  The result
was a noisy computer that sounded like it was breathing.  My thinking was
that I needed some kind of PWM control with greater range like I got from
Asus AI 3 utility.  This meant controlling it from the OS, and that's how I
got to lm-sensors and fancontrol.  It is overclocked (OC'd), but spends
most of its time idling as it only runs as a web server.  The benefit of
the OC is seen when running windows because then it becomes my development
machine, when on the job.  When its running Linux I'm not concerned about
temps.

Re: temp sources being associated, I did notice what looked like an error.
Sometimes running PWMCONFIG, the file would show an assignment of
fan1_input to pwm2, which is incorrect.  I would confirm the association
from the pwmconfig output, and correct the file, which was fan1_input
controlled by pwm1, and fan2_input controlled by pwm2.  One last item, and
this is likely due to trying to use pwmconfig on the 4pin voltage
controlled fan (thanks Asus), but sometimes the config file would be
incomplete when assigning two sources.  Sometimes after running through the
pwmcofig it would produce this:


FCTEMPS=3Dhwmon3/device/pwm2=3Dhwmon1/device/temp1_input hwmon3/device/pwm1
OR....
FCFANS=3Dhwmon3/device/pwm2=3Dhwmon3/device/fan2_input hwmon3/device/pwm1
What's missing is the last assignment, either temp1_input, or fan1_input.


I'd be happy to re-run the pwmconfig to reproduce this, if it would help.


On Mon, Nov 11, 2013 at 6:37 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/11/2013 04:57 PM, p. stephen w wrote:
>
>> Please see attached.
>> ____________________________________________________________
>> _________________________________
>> I noticed the fancontrol file is using hwmon2, instead of hwmon3, so I r=
an
>> that command using hwmon2 and it has a lot more output.  I've attached it
>> in case  its of interest.
>> Can I set INTERVAL to less than a minute; 0.25, or 0.5?
>>
>>  No idea.
>
>
>  etc/fantcontrol
>> INTERVAL=3D1
>> DEVICEPATH=3Dhwmon1=DEvices/platform/coretemp.0
>> hwmon2=DEvices/platform/nct6775.656
>> DEVNAME=3Dhwmon1=3Dcoretemp hwmon2=3Dnct6791
>> FCTEMPS=3Dhwmon2/device/pwm2=3Dhwmon1/device/temp1_input
>> FCFANS=3D hwmon2/device/pwm2=3Dhwmon2/device/fan2_input
>> MINTEMP=3Dhwmon2/device/pwm2`
>> MAXTEMP=3Dhwmon2/device/pwm2a
>> MINSTART=3Dhwmon2/device/pwm2=150
>> MINSTOP=3Dhwmon2/device/pwm2=3D0
>> MAXPWM=3Dhwmon2/device/pwm2%5
>>
>>
> Yes, obviously the nct6775 driver is hwmon2. No idea why the eee driver
> (hwmon3)
> is instantiated.
>
> Can we take a step back on why you think you need to run fancontrol ...
> you mentioned earlier that the board was "OC'd". I assume that means
> overclocked.
> Why can't you use the automatic fan control provided by the NCT chip ?
> That would provide much better reaction time to temperature changes.
>
> Also, I think something may be wrong in the driver when it comes to
> associating
> temperature sources with pwm controls. Specifically, the pwmX_temp_sel
> values
> should not return 0. I'll have to look into that.
>
> Thanks,
> Guenter
>
>


--=20


_____________________________
Stephen Wille | pstephenwille.com
*new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
