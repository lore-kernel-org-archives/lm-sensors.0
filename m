From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: ADM1031 / ADM1030 Driver
Message-Id: <20040506210135.0876ea41.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083188185.5337.5.camel@megapc>
In-Reply-To: <1083188185.5337.5.camel@megapc>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > 2* Whatever I set the PWM values to, the fans turn, probably to full
> > speed.
>=20
> It would help if you could send me the i2cdump for 2 or 3 values of
> PWM.

First dump, right after loading the driver (fan1_pwm and fan2_pwm read
80 and 0, respectively):

00: 91 7f 00 00 5d 5d e0 00 ff ff 19 1c 19 00 00 00    ??..]]?...???...
10: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
20: 5d 5d 55 50 41 61 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]]UPAaa]]]]]]]]]
30: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 31 41 83    ]]]]]]]]]]]]]1A?

Second dump, after writting 42 to fan1_pwm and 240 to fan2_pwm (fan1_pwm
and fan2_pwm now read 32 and 0, respectively):

00: 91 7f 00 00 5d 5d 4b 00 ff ff 1b 1d 1a 00 00 00    ??..]]K...???...
10: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
20: 5d 5d f2 50 41 61 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]]?PAaa]]]]]]]]]
30: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 31 41 83    ]]]]]]]]]]]]]1A?

Third dump, after writing 180 to fan1_pwm and 12 to fan2_pwm (fan1_pwm
and fan2_pwm now read 176 and 0, respectively):

00: 91 7f 00 00 5d 5d 9d 00 ff ff 1b 1d 1a 00 00 00    ??..]]?...???...
10: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
20: 5d 5d 0b 50 41 61 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]]?PAaa]]]]]]]]]
30: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 31 41 83    ]]]]]]]]]]]]]1A?

Quick diffs reveal (unless I missed something) that only register 0x22
has changed (temperature measurement registers left appart).

0x55 means PWM1=80, PWM2=80 (matches the datasheet default)
0xf2 means PWM12, PWM2$0
0x0b means PWM1=176, PWM2=3D0

Basically, this means that reading is correct for PWM1 but not for PWM2,
and writing is correct for both. The reason why I don't see fan change
speeds is most probably because they are both in automatic mode.

(Hint for PWM2: I think you just need to add parenthesis in
adm1031_update_device at the moment you retrieve the value; the masking
and shifting are probably done in the wrong order; I'm surprised that
gcc didn't warn us.)

(BTW: ADM1031_REG_PWM should be a simple define, not a macro.)

BTW, I don't seem to be able to switch to manual mode. Echoing 0 to
either of fan1_auto_channel or fan2_auto_channel doesnt change the value
returned by these files.

> > 3* Fan speed values don't seem to be correct. They read 1323 (which
> > seems to be the minimal value with divisor =3D 2) and 0, respectively,
> > and never change. Since both fans are running at fast speed, it
> > can't be.
>=20
> Found why fan2 was reading 0 (input not activated.)
>=20
> There are also 2 fan sensors alternatives (Digital or Analog), in the
> eval board there are 2 switches (S1 and S2) that have to be set to
> TACH1 and TACH2 as the default value for measurements is digital.

This is what they are set to on my board.

> So will it be necessary to enable the user controlling the input type,
> by adding a fan_input_type file to control analog / digital input.

There is no provision for that in the sysfs interface for now. I wonder
if anyone will use the analog method. I don't know how reliable it is. I
think I would stick to digital mode for now, and see if someone
complains. But if you want to implement it, just go.

> > Also, your driver doesn't export alarms?
>=20
> Not yet, In order to add that, I'd like to know how it has to work.
>=20
> In the ADM1031, the alarm status register is cleared when read, so
> reading the alarm registers will clear the alarms. I wonder how to
> proceed.

Just export both status registers as a single bitfield and we'll see how
it goes.

> Thanks for your feedbacks,

You're welcome.

--=20
Jean Delvare
http://khali.linux-fr.org/
