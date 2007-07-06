From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 06 Jul 2007 07:59:52 +0000
Subject: Re: [lm-sensors] [PATCH] Add LM93 support
Message-Id: <468df6788d938@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704131723.42773.hjk@linutronix.de>
In-Reply-To: <200704131723.42773.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dnia 5-07-2007 o godz. 17:58 Hans-J=FCrgen Koch napisa=B3(a):
> > See also: Documentation/hwmon/sysfs_interface.
>=20
> Quote from there:
>=20
> pwm[1-*]_enable
> 		Switch PWM on and off.
> 		Not always present even if pwmN is.
> 		0: turn off
> 		1: turn on in manual mode
> 		2+: turn on in automatic mode
>=20

I know it is confusing because the 0 means PWM turn off (so
control is off, no fan is off - and no control sets usually fan
to always on). I felt into the same trap with my driver.


> OK, I changed the patch, see below.=20
>=20

A general issue. It seems that the chip uses two's complement
format for temperature values, but you have declared them as u8.
You may try redefine them as s8 and get rid of unneeded castings.

Also, checking for temperature may be more clear after division
(in register values) as values -128 to 127 is more clear (seems
8-bit limit) than -128000 to 127000.

You have never used values returned by lm93_write_[byte|word]
functions - you can make them return no value. Actually, you have
used lm93_write_word function only once - you may replace it with
the call i2c function directly.

I hope it helps improve your driver.

Regards,
Krzysztof
=20

----------------------------------------------------
12 Play Festiwal Gwiazd z gwiazdorsk=B1 obsad=B1! 5-8 lipca w Gda=F1sku!
Wi=EAcej: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Ffe=
stival3.html&sid=1216



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
