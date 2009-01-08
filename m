From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Jan 2009 12:08:40 +0000
Subject: Re: [lm-sensors] Error getting sensor data: w83627ehf/#34
Message-Id: <20090108130840.67259c94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4958C1F3.9020108@tobias.preclik.de>
In-Reply-To: <4958C1F3.9020108@tobias.preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Tobias,

On Mon, 29 Dec 2008 13:26:27 +0100, Tobias Preclik wrote:
> Hello,
>=20
> i encountered a problem running sensord. I am running version 2.10.7 and
> have a w83627ehf sensor chip on my P4V800D-X Asus mainboard. The kernel
> is a Gentoo Linux kernel version 2.6.27. The syslog states the following:
>=20
> sensord started
> Chip: w83627ehf-isa-0290
> Adapter: ISA adapter
>   Case Fan: 0 RPM (min =3D 0 RPM, div =3D 128)
>   CPU Fan: 2481 RPM (min =3D 0 RPM, div =3D 4)
>   Aux Fan: 0 RPM (min =3D 0 RPM, div =3D 128)
> Error getting sensor data: w83627ehf/#34: Can't access procfs/sysfs file
> sensord failed (23)
>=20
> As I understand it I am supposed to add "#34" to the ignore list in the
> corresponding chip section in /etc/sensors.conf. However this does not
> fix the problem. The sensors tool does not complain btw:

This #34 is the libsensors feature number for the feature which is
causing trouble. You can't use it in sensors.conf, as sensors.conf
wants feature names, not numbers. From lib/chips.h:

#define SENSORS_W83627EHF_FAN4		34 /* R  */

So the problem is with fan4. If you want to ignore something, that
would be fan4. I am not certain whether this is enough to make sensord
happy though. Try adding:

   ignore fan4

to the w83627ehf configuration section and see if it helps.

The cause of the problem is that the w83627ehf driver in Linux 2.6
hides some inputs when the chip is configured to use the pins in
question for other functions. The idea is to make the configuration
easier. sensord in lm-sensors 2 isn't smart enough to cope with
possibly missing inputs though, thus the error.

> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.59 V  (min =3D  +0.00 V, max =3D  +1.85 V)
> in1:      +12.04 V  (min =3D  +1.80 V, max =3D  +0.00 V) ALARM
> AVCC:      +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> 3VCC:      +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> in4:       +1.32 V  (min =3D  +0.01 V, max =3D  +0.00 V) ALARM
> in5:       +1.71 V  (min =3D  +0.26 V, max =3D  +0.06 V) ALARM
> in6:       +4.28 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> VSB:       +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> VBAT:      +3.28 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> in9:       +1.26 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
> Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 128) ALARM
> CPU Fan:  2463 RPM  (min =3D    0 RPM, div =3D 4) ALARM
> Aux Fan:     0 RPM  (min =3D    0 RPM, div =3D 128) ALARM
> fan5:        0 RPM  (min =3D    0 RPM, div =3D 128)
> Sys Temp:    +27=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)  [thermist=
or] ALARM
> CPU Temp:   +9.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  [CPU diod=
e ]
> AUX Temp:  +77.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  [thermist=
or]
>=20
>=20
> How can I fix this?

This is all solved in lm-sensors 3, if you can upgrade. The changes
required are too intrusive to be ported back to lm-sensors 2.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
