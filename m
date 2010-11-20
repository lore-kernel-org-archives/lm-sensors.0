From: Alexandros Diamantidis <adia@hellug.gr>
Date: Sat, 20 Nov 2010 16:14:18 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101120161418.GA1856@hellug.gr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

* Jean Delvare [2010-11-15 12:00]:
> > echo 0 > pwm[123], which should have stopped the fans, right?
>=20
> Could you please:
>=20
> * Try again after disabling Q-Fan in the BIOS. Maybe I missed an
>   initialization step for the manual mode.
[...]

Hello Jean!

First of all, I'd like a clarification, because I may be wasting your
time: I just did a few web searches about fan control, and some articles
I read indicated that to control fan speeds, you need fans with four
wires (one of which carries the PWM signal). Is this true? If so, that's
what's going on, since all my fans have three wires. The CPU fan header
on the motherboard does have four pins, but the fan only has a
three-wire connector. The other two fan headers have three pins.

So, I did the tests you indicated. First of all, a reminder that the
BIOS only has a CPU Q-Fan setting.

With Q-Fan disabled, after boot, pwm[123]_enable =3D 1, pwm[123] =3D 255.
I tried writing 0, 1 and 2 to pwm?_enable, and a couple of random values to
pwm? in each case. Reading from them, I get back the last values written, w=
ith
no change over time. Fan speeds stay almost constant regardless of CPU
temperature.

With Q-Fan enabled and set to "silent" mode, after boot, pwm1_enable =3D 2,
pwm1 =3D 54, pwm[23]_enable =3D 1, pwm[23] =3D 255. After running the syste=
m at full
load for a few minutes, CPU temperature as reported by it8721 rises from ~3=
0=B0C
to ~42=B0C, but pwm1 always stays 54 (although CPU fan speed did rise a
bit, from ~1550 RPM to ~1610).

In this case, too, values written to pwm[123] stick and don't change over t=
ime,
for pwm[123]_enable set to 0, 1 or 2.

Thanks again!

Alexandros


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
