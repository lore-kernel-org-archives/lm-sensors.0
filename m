From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 15:38:58 +0000
Subject: Re: [lm-sensors] does lm-sensors pick up sensors that don't exist?
Message-Id: <20080218163858.1ae90ae8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <fpc320$q83$1@saturn.local.net>
In-Reply-To: <fpc320$q83$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 18 Feb 2008 16:20:21 +0100, Per Jessen wrote:
> Jean Delvare wrote:
>=20
> > Depends on the thermal sensor type. For thermal diodes (or
> > diode-connected transistors) the chip can typically detect if the
> > thermal sensor is missing, and it will report it either explicitly in
> > a status register, or through an arbitrary value (typically -128 or
> > +127).
> >=20
> > For thermistors, what the chip measures is actually a voltage, which
> > is then converted to a temperature value. If the board manufacturer
> > doesn't want to implement a sensor, they will typically wire the input
> > to the ground, which is equivalent to an infinitely high or infinitely
> > low temperature (depending on how the voltage divisor bridge is
> > built), and the chip doesn't have to treat this as a special case.
> > Things get bad when the manufacturer leave the thermal input floating,
> > you will get random temperatures. This is quite possibly what Per is
> > experiencing.
>=20
> Hi Jean
>=20
> if only I was getting random readings, but the readout I'm seeing
> doesn't look random at all - it's typically 80-81, but will increase to
> 86 when I'm stressing the system (the CPU-temp will rise to 62/63 at
> the same time). =20

Well, if it seems to make some sense, it might as well be wired.
However, 80=B0C is rather high, and I would hope that no chip on my
motherboard gets this hot. But depending on the hardware, it might
actually happen.

> I'm currently waiting for the board to be replaced, so I can't tell you
> exactly what lm-sensors says about the type of sensor, but I think it
> said it was "transistor".=20

BTW, you might try switching the sensor type to see if it gives more
sensible results. In theory the BIOS should set the right sensor types
for you, but it doesn't always do so.

> Regardless, I guess I should be ignoring it when Gigabyte says it's not
> there ...

You mean you would trust what the support of a motherboard vendor told
you? Naaaah ;) The sad truth is that most of the time they have no idea
what you are talking about, and come up with the reply that is the most
likely to make you go away.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
