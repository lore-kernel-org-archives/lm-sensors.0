From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jun 2012 03:53:38 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120628035338.GA16191@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Jun 27, 2012 at 06:18:09PM -0400, Arun Raghavan wrote:
> Hi,
>=20
> > I need to get fairly fine grain control on my CPU fan speed for some
>=20
> > > experiments, but I am currently unable to set the fan speed below 1054
> > RPM.
> > > pwmconfig confirms the same across the divisor range. Processor is
> > i7-2600,
> > > motherboard
> > >
> > > I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see that
> > the
> > > fan speed varies but the min RPM remains 1054.  Info below.
> > >
> > What happens if you write 0 into pwmX ? Also, did you select manual fan
> > speed
> > control ?
> >
> >
> Writing 0 to pwm2 also keeps it at 1054 RPM. I'm setting pwm2_enable to 1,
> isn't that supposed to make it manual? Also, I do see a variation between
> 1054 RM and 2109 RPM (and some steps in between), when I change pwm2. I
> can't get it to spin lower than 1054 RPM though.
>=20
Maybe that is the lowest fan speed supported by this fan ?

Guenter

> thanks,
> -arun
>=20
>=20
> > > so how would be very helpful.
> > >
> > > thanks,
> > > -arun
> > >
> > > root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 > pwm2
> > > root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> > > coretemp-isa-0000
> > > Adapter: ISA adapter
> > > Any pointers on whether it is possible to reduce fan speed further, a=
nd
> > if
> > > Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  =
ALARM (CRIT)
> > > Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  =
ALARM (CRIT)
> > >
> > > nct6775-isa-0290
> > > Adapter: ISA adapter
> > > Vcore:         +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > > in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> > > fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > > fan2:         2109 RPM  (min =3D    0 RPM, div =3D 128)  ALARM <----
> > > fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > > fan4:            0 RPM  (div =3D 128)
> > > SYSTIN:        +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  A=
LARM  sensor
> > > =3D CPU diode
> > > CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  s=
ensor =3D CPU
> > > diode
> > > AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  s=
ensor =3D
> > > thermistor
> > > PECI Agent 0:  +45.5=B0C
> > > cpu0_vid:     +2.050 V
> > > intrusion0:   OK
> > >
> > > root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 > pwm2
> > > root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> > > coretemp-isa-0000
> > > Adapter: ISA adapter
> > > Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  =
ALARM (CRIT)
> > > Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  =
ALARM (CRIT)
> > >
> > > nct6775-isa-0290
> > > Adapter: ISA adapter
> > > Vcore:         +0.85 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > > in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > > 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > > Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> > > fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > > fan2:         1054 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> > > fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > > fan4:            0 RPM  (div =3D 128)
> > > SYSTIN:        +30.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  A=
LARM  sensor
> > > =3D CPU diode
> > > CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  s=
ensor =3D CPU
> > > diode
> > > AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  s=
ensor =3D
> > > thermistor
> > > PECI Agent 0:  +44.5=B0C
> > > cpu0_vid:     +2.050 V
> > > intrusion0:   OK
> >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
