From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 05 Oct 2012 02:55:21 +0000
Subject: Re: [lm-sensors] Temperature reading too high for it87
Message-Id: <20121005025521.GA9695@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
In-Reply-To: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Oct 01, 2012 at 10:56:56PM +0200, Klaus Dahlke wrote:
>=20
> Dear all,
> I just put together a new PC with the following components:
> mainboard: Gigabyte GA-A75M-UD2H, newest BIOS (beta)
> CPU: AMD A8-3850 APU
>=20
> Using lm_sensors, one temperature of the APU via it87 is shown far too hi=
gh. The BIOS/PC Health Status (after reboot) reports basically 34=B0C and 3=
4=B0C which were also the usual temparatures at my old PC when just surfing=
 or doing some office stuff. But for teh new PC lm_sensors shows now for th=
e CPU a temperature of 59=B0C which is about the sum of the first temperatu=
re and the temperature in the case/housing (case has an own thermocouple). =
It is the same behaviour with the kernel module as well as the driver from =
your download page.
>=20
> I would be happy if you could investigate a bit further to get also a cor=
rect temperature reading.
>=20
>=20
> $ sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:         +3.8=B0C  (high =3D +70.0=B0C)
>=20
This is reported by the CPU and a relative value. A number of people have r=
eported
similar low values. I start suspecting that it may have to do with the fact
that thermal control is disabled on your board (which we know because there=
 is
no critical temperature reported), and that the reported temperature is pos=
sibly
relative to the critical temperature, which in turn may be initialized to a=
 much-too-low
value (eg 70 degrees C instead of around 100 degrees C). But someone from A=
MD would have
to confirm that, and/or someone with an AMD board would have to play with i=
t to
confirm if that is really the case.

> it8720-isa-0228
> Adapter: ISA adapter
> in0:          +1.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:          +1.49 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in2:          +3.34 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:          +3.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in4:          +3.09 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in5:          +2.13 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in6:          +2.13 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> 5VSB:         +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> Vbat:      +3.07 V =20
> fan1:        1115 RPM  (min =3D   10 RPM)
> fan2:        1147 RPM  (min =3D    0 RPM)
> fan3:           0 RPM  (min =3D    0 RPM)
> temp1:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermistor
> temp2:        +59.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermistor
> temp3:        +13.0=B0C  (low  =3D +127.0=B0C, high =3D +70.0=B0C)  senso=
r =3D thermistor

Those temperature values are as reported to the chip by the hardware. Depen=
ding
on the board and the actual sensors, the reported value can differ from the=
 real
temperature. Unfortunately, that is board specific, and compensation would
depend on information from the board vendor. The chip has registers to
compensate for that, but there is no guarantee that those registers are
initialized by the BIOS, and the it87 Linux driver does not support writing=
 them.

On the other side, it may well be possible that _some_ component runs a bit
hotter than others on your board, and that temp2 reports such a temperature.
I see that, for example, with the PCH chip on one of my Intel boards. But u=
nless
you run your computer in a fridge, 13=B0C is really a bit on the low side ;=
).

Only idea I have would be to adjust the raw readings in your sensors.conf f=
ile
to something you think is reasonable.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
