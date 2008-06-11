From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Jun 2008 15:59:28 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080611175928.7830f501@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bruno,

On Sun, 8 Jun 2008 22:30:51 +0200, Bruno Pr=E9mont wrote:
> Now I'm running 2.6.25.5 with both patches (the one changing
> excessively large values to 0 and automatic fan control)
>=20
> ------ FAN connected to W83697HG ------
> Looking at power and speed signals with an oscilloscope I get:
> - slightly above 12V for FAN power
> - speed square signal is about 11V at 62.5Hz
>=20
> Both fan power and fan speed signal show a noise of about 0.1V in saw
> shape ( |\|\|\|\ ) at 4kHz.
>=20
> Changing value for pwm1_enable, pwm1_freq and pwm1 does not influence
> the fan at all (no voltage variation, no variation in noise). So this
> mainboard does not support FAN control :(
>=20
> The W83697HG reports a speed of 1750 RPM though I think it's a slightly
> high (Sticker on FAN says 1000RPM ... 2500RPM)

Most fans emit two pulses per revolution, so 62.5 Hz means 1875 RPM.
1750 RPM isn't too far away, so I'd say it's correct.

> Connecting the FAN to the board's (LE-365) power-out connector produces
> exactly the same results, thus the noise is generalized for the board's
> "12V rail"
> ------ END ------
>=20
> Note: after connecting a second (non-controlled) fan to the mainboard
> (on second fan connector) the W83697HG stopped reporting the bad values
> and did not start reporting them even after disconnecting the second fan
> (no system shutdown/reboot during the whole testing)
>=20
> The second FAN shows the same voltages, just with different frequency
> for the speed signal.
>=20
>=20
> ------ FAN connected to IT8712F ------
> (only speed sensor, power taken directly from system's power supply)
>=20
> Looking at power and speed signals with an oscilloscope I get:
> - slightly above 12V for FAN power
> - speed square signal is about 5V at 55Hz
>=20
> The IT8712F reports a speed of 4600 RPM though visually FAN does
> not spin more quickly. 4600 RPM is definitely too much...

I don't think you can judge the speed of a fan by just looking at it
(if you are a human being.) Your hears will tell you more than your
eyes about a fan's speed.

55 Hz would be 1650 RPM. If the IT8712F reports 4600 RPM then it's
indeed certainly wrong. Can you check what speed is reported in the
BIOS? Please also test with another fan if you can. I'd like to know if
that's a problem with this specific fan (in which case there's probably
not much we can do) or not. I suspect not (see below.)

>=20
> PS: This mainboard (IEI Kino690S) is capable to regulating FAN speed all
> its fan connectors
> ------ END ------
>=20
>=20
> I will look if I can find a way do determine the real fan speed in
> order to compare with the values both chips report.
> Looks like IT8712F (divisor =3D 2) reports a speed 3 times higher than
> W83697HG (divisor =3D 4)

Please remember that the divisor value does _not_ divide the speed
value. It only affects the range of measurable values. For a fan that
could run as slow as 1000 RPM, you want to set the divider to 8.

> I guess the different voltages seen for both on speed line is due to
> different resistors on the chips or the circuit in front of them.

Can you tell us what revision of the IT8712F you have? The it87 driver
will write it to the kernel log when you load it. I would also like a
dump of the chip (using isadump).

Recent IT8712F chips have 16-bit tachometer registers, but the it87
driver doesn't support this mode for that chip yet. We received a patch
adding support for that 4 months ago:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2008-February/022460.html
I reviewed it, it needed some more work, but the author never followed
up. If you need this, I guess we'll have to revive it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
