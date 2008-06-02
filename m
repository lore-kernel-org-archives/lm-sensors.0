From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Jun 2008 19:35:23 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080602213523.29f1547f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 2 Jun 2008 21:09:41 +0200, Bruno Pr=E9mont wrote:
> On Mon, 02 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > Is the fan's speed controlled in any way, either by the W83697HG chip,
> > or maybe it is a self-regulated fan? Just check if the fan's speed
> > increases with the temperature (i.e. with CPU load).
>=20
> Yes, the fan has a built-in thermal sensor and regulates it's speed
> based on temperature.
> It's running either at its lowest speed or the speed just above.

Note that I've never seen this behavior on self-regulated fans... But I
guess it depends on the implementation.

> > (...)
> > One patch you may want to apply it this one:
> >   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html
> > It will let you switch the W83697HG chip from automatic fan speed
> > control to manual control and back - might be useful to investigate
> > the issue you have.
>=20
> I will try this one, maybe the board is capable of doing speed control
> but its not implemented in vanilla driver.

It is. The w83627hf driver can do manual fan speed control for a very
long time. What it is missing is support for automatic fan speed
control.

> Until now setting pwm_enable to any values and changing PWM value did
> not influence fan speed

If setting pwmN_enable to 1 and pwmN to 0 doesn't stop the fan, this
suggests that your motherboard can't do fan speed control. The easiest
way to test is by running the "pwmconfig" script. But anyway, you would
only have been able to slow down the fan, not speed it up, so it
wouldn't have solved the problem.

> > (...)
> > Filter out very large fan speed values. These can be reported by the
> > chip when a fan is being controlled at low speed. The tachometer
> > signal gets too weak and the chip fails to monitor the speed properly,
> > but unfortunately it reports unreasonably high values instead of 0
> > RPM, which is quite confusing.
>=20
> I would prefer it to return the last valid speed if that speed is not
> older than a few seconds though 0 is still better than "out of range".

We just can't do that, it would be lying to the user. We can't tell the
user that his/her fan is spinning at a given speed when it might
actually be spinning way slower or even be plain stalled.

> (...)
> I will also check fan behavior on IT8712F which is capable of doing PWM
> control on 3 pin fans (maybe also automatic control, to be checked)

The IT8712F can control the fans in both manual and automatic modes,
but the it87 driver only supports the former. Keep in mind though that,
just because the chip can do it, a motherboard with this chip may not
support fan speed control; it all depends on how the motherboard is
wired.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
