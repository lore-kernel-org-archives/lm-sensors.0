From: Casper Gripenberg <casper.gripenberg@kotiportti.fi>
Date: Sat, 29 Dec 2007 21:07:51 +0000
Subject: Re: [lm-sensors] w83627dhg chip - stopping fan rotation?
Message-Id: <4776B727.8020708@kotiportti.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <4776AD53.5030600@assembler.cz>
In-Reply-To: <4776AD53.5030600@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Perhaps you have still some kind of automatic mode maybe. What does
> cat pwm?_enable print?

If I enable Asus Q-Fan (automatic fan control) from the
BIOS then pwm?_enable prints 2. If I disable it then it
prints 1.

> echo 1 > pwm1_enable will switch it to manual mode.

Ok. I tried this both with automatic control enabled in
the BIOS and disabled. And then I tried again to echo
0 into pwm[1-4] with either mode. Nothing :(

> You need to set there manual mode first. Imho you can try first with=20
> pwmconfig script which is doing that for you. Addtitionally you may=20
> check documentation for the chip in kernel Documentation/hwmon/w83627ehf
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dbl=
ob;f=3DDocumentation/hwmon/w83627ehf;h=CCc2bcb610686aaf44a0d38c5f67db44e898=
5e82;hb=3DHEAD=20

Thanks for the link. Seems the one that comes with my distro
(Ubuntu 7.10) was a bit outdated.

I also have files called pwm?_mode, which are not explained
in the docs. I'm guessing these set either DC or pulse control
of the fan output. I tried modifying the values here too (either
0 or 1 was accepted). Didn't help either :-/

Anything else I could try?

Thanks.

Casper

Btw. with ASUS Q-Fan enabled the fans do spin down, so at
least the Q-Fan thing is working. But manual control not..





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
