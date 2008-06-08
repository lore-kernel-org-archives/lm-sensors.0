From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sun, 08 Jun 2008 20:30:51 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080608223051.3a88d88d@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Now I'm running 2.6.25.5 with both patches (the one changing
excessively large values to 0 and automatic fan control)

------ FAN connected to W83697HG ------
Looking at power and speed signals with an oscilloscope I get:
- slightly above 12V for FAN power
- speed square signal is about 11V at 62.5Hz

Both fan power and fan speed signal show a noise of about 0.1V in saw
shape ( |\|\|\|\ ) at 4kHz.

Changing value for pwm1_enable, pwm1_freq and pwm1 does not influence
the fan at all (no voltage variation, no variation in noise). So this
mainboard does not support FAN control :(

The W83697HG reports a speed of 1750 RPM though I think it's a slightly
high (Sticker on FAN says 1000RPM ... 2500RPM)

Connecting the FAN to the board's (LE-365) power-out connector produces
exactly the same results, thus the noise is generalized for the board's
"12V rail"
------ END ------

Note: after connecting a second (non-controlled) fan to the mainboard
(on second fan connector) the W83697HG stopped reporting the bad values
and did not start reporting them even after disconnecting the second fan
(no system shutdown/reboot during the whole testing)

The second FAN shows the same voltages, just with different frequency
for the speed signal.


------ FAN connected to IT8712F ------
(only speed sensor, power taken directly from system's power supply)

Looking at power and speed signals with an oscilloscope I get:
- slightly above 12V for FAN power
- speed square signal is about 5V at 55Hz

The IT8712F reports a speed of 4600 RPM though visually FAN does
not spin more quickly. 4600 RPM is definitely too much...

PS: This mainboard (IEI Kino690S) is capable to regulating FAN speed all
its fan connectors
------ END ------


I will look if I can find a way do determine the real fan speed in
order to compare with the values both chips report.
Looks like IT8712F (divisor =3D 2) reports a speed 3 times higher than
W83697HG (divisor =3D 4)

I guess the different voltages seen for both on speed line is due to
different resistors on the chips or the circuit in front of them.

Bruno


On Mon, 02 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 2 Jun 2008 21:09:41 +0200, Bruno Pr=C3=A9mont wrote:
> > On Mon, 02 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > > Is the fan's speed controlled in any way, either by the W83697HG
> > > chip, or maybe it is a self-regulated fan? Just check if the
> > > fan's speed increases with the temperature (i.e. with CPU load).
> >=20
> > Yes, the fan has a built-in thermal sensor and regulates it's speed
> > based on temperature.
> > It's running either at its lowest speed or the speed just above.
>=20
> Note that I've never seen this behavior on self-regulated fans... But
> I guess it depends on the implementation.
>=20
> > > (...)
> > > One patch you may want to apply it this one:
> > >   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.ht=
ml
> > > It will let you switch the W83697HG chip from automatic fan speed
> > > control to manual control and back - might be useful to
> > > investigate the issue you have.
> >=20
> > I will try this one, maybe the board is capable of doing speed
> > control but its not implemented in vanilla driver.
>=20
> It is. The w83627hf driver can do manual fan speed control for a very
> long time. What it is missing is support for automatic fan speed
> control.
>=20
> > Until now setting pwm_enable to any values and changing PWM value
> > did not influence fan speed
>=20
> If setting pwmN_enable to 1 and pwmN to 0 doesn't stop the fan, this
> suggests that your motherboard can't do fan speed control. The easiest
> way to test is by running the "pwmconfig" script. But anyway, you
> would only have been able to slow down the fan, not speed it up, so it
> wouldn't have solved the problem.
>=20
> > > (...)
> > > Filter out very large fan speed values. These can be reported by
> > > the chip when a fan is being controlled at low speed. The
> > > tachometer signal gets too weak and the chip fails to monitor the
> > > speed properly, but unfortunately it reports unreasonably high
> > > values instead of 0 RPM, which is quite confusing.
> >=20
> > I would prefer it to return the last valid speed if that speed is
> > not older than a few seconds though 0 is still better than "out of
> > range".
>=20
> We just can't do that, it would be lying to the user. We can't tell
> the user that his/her fan is spinning at a given speed when it might
> actually be spinning way slower or even be plain stalled.
>=20
> > (...)
> > I will also check fan behavior on IT8712F which is capable of doing
> > PWM control on 3 pin fans (maybe also automatic control, to be
> > checked)
>=20
> The IT8712F can control the fans in both manual and automatic modes,
> but the it87 driver only supports the former. Keep in mind though
> that, just because the chip can do it, a motherboard with this chip
> may not support fan speed control; it all depends on how the
> motherboard is wired.
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
