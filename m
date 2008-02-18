From: Per Jessen <per@computer.org>
Date: Mon, 18 Feb 2008 15:20:21 +0000
Subject: Re: [lm-sensors] does lm-sensors pick up sensors that don't exist?
Message-Id: <fpc7nl$qpm$1@saturn.local.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <fpc320$q83$1@saturn.local.net>
In-Reply-To: <fpc320$q83$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Depends on the thermal sensor type. For thermal diodes (or
> diode-connected transistors) the chip can typically detect if the
> thermal sensor is missing, and it will report it either explicitly in
> a status register, or through an arbitrary value (typically -128 or
> +127).
>=20
> For thermistors, what the chip measures is actually a voltage, which
> is then converted to a temperature value. If the board manufacturer
> doesn't want to implement a sensor, they will typically wire the input
> to the ground, which is equivalent to an infinitely high or infinitely
> low temperature (depending on how the voltage divisor bridge is
> built), and the chip doesn't have to treat this as a special case.
> Things get bad when the manufacturer leave the thermal input floating,
> you will get random temperatures. This is quite possibly what Per is
> experiencing.

Hi Jean

if only I was getting random readings, but the readout I'm seeing
doesn't look random at all - it's typically 80-81, but will increase to
86 when I'm stressing the system (the CPU-temp will rise to 62/63 at
the same time). =20

I'm currently waiting for the board to be replaced, so I can't tell you
exactly what lm-sensors says about the type of sensor, but I think it
said it was "transistor".=20

Regardless, I guess I should be ignoring it when Gigabyte says it's not
there ...



/Per Jessen, Z=C3=BCrich


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
