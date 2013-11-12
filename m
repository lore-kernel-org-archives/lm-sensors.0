From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Nov 2013 02:37:37 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <52819471.2070502@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 11/11/2013 04:57 PM, p. stephen w wrote:
> Please see attached.
> _________________________________________________________________________=
____________________
> I noticed the fancontrol file is using hwmon2, instead of hwmon3, so I ran
> that command using hwmon2 and it has a lot more output.  I've attached it
> in case  its of interest.
> Can I set INTERVAL to less than a minute; 0.25, or 0.5?
>
No idea.

> etc/fantcontrol
> INTERVAL=3D1
> DEVICEPATH=3Dhwmon1=DEvices/platform/coretemp.0
> hwmon2=DEvices/platform/nct6775.656
> DEVNAME=3Dhwmon1=3Dcoretemp hwmon2=3Dnct6791
> FCTEMPS=3Dhwmon2/device/pwm2=3Dhwmon1/device/temp1_input
> FCFANS=3D hwmon2/device/pwm2=3Dhwmon2/device/fan2_input
> MINTEMP=3Dhwmon2/device/pwm2`
> MAXTEMP=3Dhwmon2/device/pwm2a
> MINSTART=3Dhwmon2/device/pwm2=150
> MINSTOP=3Dhwmon2/device/pwm2=3D0
> MAXPWM=3Dhwmon2/device/pwm2%5
>

Yes, obviously the nct6775 driver is hwmon2. No idea why the eee driver (hw=
mon3)
is instantiated.

Can we take a step back on why you think you need to run fancontrol ...
you mentioned earlier that the board was "OC'd". I assume that means overcl=
ocked.
Why can't you use the automatic fan control provided by the NCT chip ?
That would provide much better reaction time to temperature changes.

Also, I think something may be wrong in the driver when it comes to associa=
ting
temperature sources with pwm controls. Specifically, the pwmX_temp_sel valu=
es
should not return 0. I'll have to look into that.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
