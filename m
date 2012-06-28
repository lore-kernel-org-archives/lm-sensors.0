From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jun 2012 05:26:04 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120628052604.GB16364@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jun 28, 2012 at 12:23:04AM -0400, Arun Raghavan wrote:
> Fan or winbond ? How can I confirm?
>=20
Please don't top-post.

Fan. I have a system with NCT6775F as well. It shows 649rpm and 1028rpm
right now, with pwm values of 36 and 64.

Can you provide the output of all pwm sysfs attributes ?
Something like "grep . /sys/class/hwmon/hwmonX/device/pwm*" should do it, w=
here
X is the hwmon index for the NCT6775F driver (probably 1 for your system).

Thanks,
Guenter

> On Jun 27, 2012, at 11:53 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> > On Wed, Jun 27, 2012 at 06:18:09PM -0400, Arun Raghavan wrote:
> >> Hi,
> >>=20
> >>> I need to get fairly fine grain control on my CPU fan speed for some
> >>=20
> >>>> experiments, but I am currently unable to set the fan speed below 10=
54
> >>> RPM.
> >>>> pwmconfig confirms the same across the divisor range. Processor is
> >>> i7-2600,
> >>>> motherboard
> >>>>=20
> >>>> I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see th=
at
> >>> the
> >>>> fan speed varies but the min RPM remains 1054.  Info below.
> >>>>=20
> >>> What happens if you write 0 into pwmX ? Also, did you select manual f=
an
> >>> speed
> >>> control ?
> >>>=20
> >>>=20
> >> Writing 0 to pwm2 also keeps it at 1054 RPM. I'm setting pwm2_enable t=
o 1,
> >> isn't that supposed to make it manual? Also, I do see a variation betw=
een
> >> 1054 RM and 2109 RPM (and some steps in between), when I change pwm2. I
> >> can't get it to spin lower than 1054 RPM though.
> >>=20
> > Maybe that is the lowest fan speed supported by this fan ?
> >=20
> > Guenter
> >=20
> >> thanks,
> >> -arun
> >>=20
> >>=20
> >>>> so how would be very helpful.
> >>>>=20
> >>>> thanks,
> >>>> -arun
> >>>>=20
> >>>> root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 > pwm2
> >>>> root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> >>>> coretemp-isa-0000
> >>>> Adapter: ISA adapter
> >>>> Any pointers on whether it is possible to reduce fan speed further, =
and
> >>> if
> >>>> Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C) =
 ALARM (CRIT)
> >>>> Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C) =
 ALARM (CRIT)
> >>>>=20
> >>>> nct6775-isa-0290
> >>>> Adapter: ISA adapter
> >>>> Vcore:         +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> >>>> in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> >>>> +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> >>>> in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> >>>> Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> >>>> fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> >>>> fan2:         2109 RPM  (min =3D    0 RPM, div =3D 128)  ALARM <----
> >>>> fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> >>>> fan4:            0 RPM  (div =3D 128)
> >>>> SYSTIN:        +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  =
ALARM  sensor
> >>>> =3D CPU diode
> >>>> CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D CPU
> >>>> diode
> >>>> AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D
> >>>> thermistor
> >>>> PECI Agent 0:  +45.5=B0C
> >>>> cpu0_vid:     +2.050 V
> >>>> intrusion0:   OK
> >>>>=20
> >>>> root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 > pwm2
> >>>> root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> >>>> coretemp-isa-0000
> >>>> Adapter: ISA adapter
> >>>> Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C) =
 ALARM (CRIT)
> >>>> Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C) =
 ALARM (CRIT)
> >>>>=20
> >>>> nct6775-isa-0290
> >>>> Adapter: ISA adapter
> >>>> Vcore:         +0.85 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> >>>> in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> >>>> +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> >>>> in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> >>>> 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> >>>> Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> >>>> fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> >>>> fan2:         1054 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> >>>> fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> >>>> fan4:            0 RPM  (div =3D 128)
> >>>> SYSTIN:        +30.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  =
ALARM  sensor
> >>>> =3D CPU diode
> >>>> CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D CPU
> >>>> diode
> >>>> AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D
> >>>> thermistor
> >>>> PECI Agent 0:  +44.5=B0C
> >>>> cpu0_vid:     +2.050 V
> >>>> intrusion0:   OK
> >>>=20
> >>>> _______________________________________________
> >>>> lm-sensors mailing list
> >>>> lm-sensors@lm-sensors.org
> >>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >>>=20
> >>>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
