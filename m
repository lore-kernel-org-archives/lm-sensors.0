From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Nov 2011 21:45:43 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE
Message-Id: <20111114224543.0a6fd04d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
In-Reply-To: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 14 Nov 2011 19:14:16 -0200, Gustavo De Nardin (spuk) wrote:
> > On Fri, 2011-11-04 at 00:44 -0400, Frank T. Lofaro Jr. wrote:
> > > This patch allows the ITE 8728 chip to be detected and used.
> > > The chip appears to be compatible with the 8721.
> > >=20
> >=20
> > Can anyone confirm that those chips are actually compatible ?
>=20
> Unlike forcing the other chips' ids, with force_id=3D0x8721 PWM control s=
eems
> to work reasonably, with pwm1_enable=3D1, pwm1=3D0 yields around 1132 RPM=
 on the
> CPU fan, and pwm1=3D255 yields around 3260 RPM.  Should pwm1=3D0 actually=
 stop
> the fan?  I get what (empirically) seem to be consistent logarithmic
> increase in RPM when increasing pwm1 value, anyway.

If this is a 4-wire fan then your results are expected. pwm=3D0 always
stops 3-wire fans (no power -> stopped) but typically 4-wire fans have
a minimum speed (speed control is separate from power.)

> But the sensors values read with 'it87 force_id=3D0x8721' don't seem ok, =
I get
> this (first 'it87 force_id=3D0x8721', then 'asus_atk0110 new_if=3D1', whi=
ch
> seems to provide good readings):
>=20
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +0.95 V  (min =3D  +2.78 V, max =3D  +1.14 V)  ALARM
> in1:          +1.50 V  (min =3D  +0.00 V, max =3D  +3.01 V)
> in2:          +1.88 V  (min =3D  +2.66 V, max =3D  +2.27 V)  ALARM
> in3:          +2.05 V  (min =3D  +2.68 V, max =3D  +0.67 V)  ALARM
> in4:          +2.03 V  (min =3D  +3.04 V, max =3D  +1.42 V)  ALARM
> in5:          +3.05 V  (min =3D  +3.04 V, max =3D  +3.01 V)  ALARM
> in6:          +2.05 V  (min =3D  +2.77 V, max =3D  +1.87 V)  ALARM
> 3VSB:         +6.07 V  (min =3D  +1.10 V, max =3D  +4.56 V)  ALARM
> Vbat:         +3.34 V
> fan1:        3292 RPM  (min =3D   10 RPM)
> fan2:           0 RPM  (min =3D   10 RPM)  ALARM
> fan3:           0 RPM  (min =3D   13 RPM)  ALARM
> temp1:        +33.0=B0C  (low  =3D -65.0=B0C, high =3D -10.0=B0C)  sensor=
 =3D thermistor
> temp2:        +40.0=B0C  (low  =3D -19.0=B0C, high =3D +127.0=B0C)  senso=
r =3D
> thermistor
> temp3:       -128.0=B0C  (low  =3D +119.0=B0C, high =3D  -2.0=B0C)  senso=
r =3D disabled
> intrusion0:  OK
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:      +0.95 V  (min =3D  +0.80 V, max =3D  +1.60 V)
> +3.3V Voltage:      +3.34 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> +5V Voltage:        +5.13 V  (min =3D  +4.50 V, max =3D  +5.50 V)
> +12V Voltage:      +12.11 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU Fan Speed:     3276 RPM  (min =3D  600 RPM)
> Chassis Fan Speed:    0 RPM  (min =3D  600 RPM)
> CPU Temperature:    +33.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:     +40.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

This isn't necessarily bad. It is expected that you need voltage
scaling for the it87 which you don't need for the atk0110 interface.
AFAIK it is also expected that the limits aren't set as the atk0110
interface uses its own software limits (Luca can you please confirm?)

So it's really a matter of finding the right scaling factors. Easiest
way in your case if probably to extract them from the DSDT table. See
http://www.lm-sensors.org/wiki/AsusFormulaHacking for some information
on this. If you provide the DSDT to myself and Luca we should be able
to figure it out.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
