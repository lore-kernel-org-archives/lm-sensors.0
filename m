From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 19:00:27 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" on Asrock ION 330 HT
Message-Id: <20110407210027.0915ab11@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201103310124.08484.tomasdeltell@gmx.es>
In-Reply-To: <201103310124.08484.tomasdeltell@gmx.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 07 Apr 2011 19:59:22 +0200, Tom=E0s Deltell Bonell wrote:
> I was using the Guenter's driver. But last night I tried your driver and =

> compiled correctly. This is the result:

These are essentially the same driver, both are based on the kernel
version, with support for new chips added.

>=20
> $ sensors
> w83667hg-isa-0290
> Adapter: ISA adapter
> in0:         +1.14 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:         +0.59 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in2:         +3.42 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in3:         +3.42 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in4:         +1.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in5:         +1.29 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in7:         +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in8:         +3.20 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:          0 RPM  (min =3D    0 RPM, div =3D 1)
> fan2:          0 RPM  (min =3D    0 RPM, div =3D 1)
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 1)
> fan4:          0 RPM  (min =3D    0 RPM, div =3D 1)
> temp1:       +54.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D diode
> temp2:       +53.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> temp3:       +67.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> cpu0_vid:   +0.000 V
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +22.0=B0C  (crit =3D +90.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +31.0=B0C  (crit =3D +90.0=B0C)
>=20
> Temperatures of the new adapter is displayed correctly (in accordance=20
> with the information that BIOS shows)

Great.

> These are the results that should be shown?

You'd get a better output with the latest version of the default
configuration file:
http://www.lm-sensors.org/export/5959/lm-sensors/trunk/etc/sensors.conf.def=
ault

The missing fan speeds is surprising too, as are the divisor values of
1. Maybe the driver will increase them on later reads, and at some
point you get valid fan speed readings? Unless this is a fanless system
of course.

But anyway, these days Guenter's copy of the driver is ahead of mine
for the chip you have, so you should really be using his driver, not
mine, until I merge his code (that's on my to-do list, but has low
priority.)

> There are any plan to include support for these chips on lm-sensors?

Support is already in the upstream kernel.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
