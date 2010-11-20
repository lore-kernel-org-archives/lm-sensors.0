From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Nov 2010 21:38:24 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101120223824.002cf8bc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alexandros,

On Sat, 20 Nov 2010 18:14:18 +0200, Alexandros Diamantidis wrote:
> * Jean Delvare [2010-11-15 12:00]:
> > > echo 0 > pwm[123], which should have stopped the fans, right?
> >=20
> > Could you please:
> >=20
> > * Try again after disabling Q-Fan in the BIOS. Maybe I missed an
> >   initialization step for the manual mode.
> [...]
>=20
> Hello Jean!
>=20
> First of all, I'd like a clarification, because I may be wasting your
> time: I just did a few web searches about fan control, and some articles
> I read indicated that to control fan speeds, you need fans with four
> wires (one of which carries the PWM signal). Is this true? If so, that's
> what's going on, since all my fans have three wires. The CPU fan header
> on the motherboard does have four pins, but the fan only has a
> three-wire connector. The other two fan headers have three pins.

Things aren't that simple. It is perfectly possible to control a 3-wire
fan. People have been doing that for the last decade successfully. In
fact it even works with 2-wire fans.

What is true is that 4-wire fans are better at monitoring and
controlling the fan at the same time. With 3-wire fans, it was somewhat
difficult to monitor the fan when it's running at low speed (low duty
cycle or low DC). Some chips have advanced circuitry but this helps
only to some point. With 4-wire fans, the power and the control are on
different wires, which means that the monitoring signal (which goes on
a separate wire too) always has the same strength.

But the most important thing is that 3-wire and 4-wire fans aren't
controlled the same way, so it is important that the monitoring/control
chip and the motherboard agree on the number of pins. Some motherboards
have jumpers to decide whether fans have 3-wire or 4-wire are in use. I
guess that some boards could have BIOS options instead. If you have a
4-wire fan header and no option to claim you're using a 3-wire fan on
it, I guess the board assumes you're using a 4-wire fan, and a 3-wire
fan can't be controlled. It might be spelled out explicitly in the user
manual.

> So, I did the tests you indicated. First of all, a reminder that the
> BIOS only has a CPU Q-Fan setting.
>=20
> With Q-Fan disabled, after boot, pwm[123]_enable =3D 1, pwm[123] =3D 255.
> I tried writing 0, 1 and 2 to pwm?_enable, and a couple of random values =
to
> pwm? in each case. Reading from them, I get back the last values written,=
 with
> no change over time. Fan speeds stay almost constant regardless of CPU
> temperature.

At least this suggests that my patch isn't completely broken. But given
the above, I also start doubting that you can actually test it with
your current hardware.

> With Q-Fan enabled and set to "silent" mode, after boot, pwm1_enable =3D =
2,
> pwm1 =3D 54, pwm[23]_enable =3D 1, pwm[23] =3D 255. After running the sys=
tem at full

This means that PWM1 is used to control the CPU fan on your board.

> load for a few minutes, CPU temperature as reported by it8721 rises from =
~30=B0C
> to ~42=B0C, but pwm1 always stays 54 (although CPU fan speed did rise a
> bit, from ~1550 RPM to ~1610).

The fact that the pwm1 value sticks to 54 suggests that the device did
not change the fan output despite the temperature increase. We'd have
to check the exact automatic control settings. You can provide a
register dump of your chip if you want me to take a look:

# rmmod it87
# isadump 0x295 0x296

You may want to try a different Q-fan profile, maybe it will react
faster to temperature changes. This would change the value of pwm1, but
probably not the actual fan speed as long as you don't have a 4-wire fan.

> In this case, too, values written to pwm[123] stick and don't change over=
 time,
> for pwm[123]_enable set to 0, 1 or 2.

OK, thanks for the tests.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
