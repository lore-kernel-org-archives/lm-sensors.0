From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Nov 2013 07:57:54 +0000
Subject: Re: [lm-sensors] coretemp readings are static/constant
Message-Id: <20131119085754.40f8ecb5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20131119T072701-70@post.gmane.org>
In-Reply-To: <loom.20131119T072701-70@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Tom,

On Tue, 19 Nov 2013 06:28:53 +0000 (UTC), Tom Metro wrote:
> Running:
>=20
> % sensors -v
> sensors version 3.3.1 with libsensors version 3.3.1
>=20
> on Ubuntu 12.04 on an Acer Aspire 8930G laptop with:
>=20
> % cat /proc/cpuinfo | fgrep name
> model name	: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
> model name	: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
>=20
> and I see:
>=20
> % sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +38.0=B0C  (crit =3D +106.0=B0C)
> temp2:        +48.0=B0C  (crit =3D +106.0=B0C)
> temp3:        +48.0=B0C  (crit =3D +106.0=B0C)
> temp4:        +43.0=B0C  (crit =3D +106.0=B0C)
>=20
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:        +49.0=B0C  (high =3D +100.0=B0C, crit =3D +110.0=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +33.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
> Core 1:       +33.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>=20
> The values reported by coretemp are always 33000 millidegrees:
>=20
> % sudo cat /sys/devices/platform/coretemp.0/temp2_input
> 33000
>=20
> as observed over the course of a week. I have not tried to intentionally
> stress the CPU, but had assumed that if it was reading real values, I wou=
ld
> have seen some variation.
>=20
> However, I read in the FAQ:
> http://lm-sensors.org/wiki/FAQ/Chapter3#coretempreturnsunrealisticvalues
>=20
>   It isn't really returning degrees Celsius. At high temperatures, the=20
>   (small) thermal margin is almost expressed in degrees Celsius, but at l=
ow=20
>   temperature, the (high) thermal margin is no longer expressed in actual=
=20
>   degrees Celsius. So, if the temperature value reported by coretemp is=20
>   unrealistically low, all it means is that you are far away from the=20
>   critical limit so your systems are running totally fine and cool...
>=20
> So does that mean it is expected to see a constant (to 5 decimal places)
> value, until the cores heat up beyond some threshold? (If so, I'll add th=
is
> to the FAQ.)

Don't get fooled by the 5 decimal places, all drivers return values in
millidegrees Celsius regardless of their accuracy and resolution. The
coretemp resolution is 1 degree so you'll always see 000 as the last 3
digits.

You should really stress the CPU and see what happens. With really good
cooling and no CPU load at all, it is possible for temperatures to stay
stable within one degree Celsius.

Another possibility is that this particular incarnation of the sensors
do not report values below 33=B0C. We know these sensors have poor
accuracy at low temperatures, maybe Intel decided to not expose too low
values to make them look plausible. In that case you'd see 33=B0C most of
the time, as a floor measurement, with temperature peaks on high CPU
load.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
