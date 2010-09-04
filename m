From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Sep 2010 12:23:07 +0000
Subject: Re: [lm-sensors] Config for MSI X58 Pro-E (MS-7522)
Message-Id: <20100904142307.2ce7f47d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C6BFB8A.7060300@mandel.name>
In-Reply-To: <4C6BFB8A.7060300@mandel.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 30 Aug 2010 19:32:57 +0200, Olaf Mandel wrote:
> Am 22.08.2010 16:13, schrieb Jean Delvare:
> > On Sun, 22 Aug 2010 15:13:05 +0200, Olaf Mandel wrote:
> -Snipp-
> >=20
> > The problem is that you compared the Vcore in BIOS, without CPU
> > frequency scaling, with Vcore in sensors, with CPU frequency scaling
> > enabled (as can be seen from the two outputs below.) This isn't fair!
> >=20
> Hi Jean,
>=20
> I have to agree, the previous compute line was wrong.
>=20
> > If you compare with Linux underload instead, you see Vcore (unscaled)
> > at 1.12 V. This is definitely not 35% off compared to the BIOS's report
> > of 1.224 V. To be honest, I would have expected both values to match
> > exactly. I get to suspect that your Linux system is configured to
> > prevent the CPU to enter the highest frequency states, you may want to
> > check this.
> >=20
> That was indeed the case: thermal_throttle was limiting the clock speed.
> I checked the voltage by setting the clock speed manually and it gets at
> least closer.
>=20
> -Snipp-
> >=20
> > Your CPU cooling seems insufficient. A 56=C2=B0C difference between idl=
e and
> > load is very, very much. I'd be worried.
> >=20
> It only gets hot if I run many instances of burnK7. If I just up the
> clock speed, it doesn't get hot.
>=20
> -Snipp-
> > When you have come up with a "final" configuration file, please send it
> > over, and I'll put it on the wiki.
> >=20
>=20
> Ok, it's attached to the mail. It remained nearly unchanged, except for
> the compute lines and the limits you suggested. The two non-trivial
> compute lines are taken from comparison of values (BIOS<->sensors) and
> then searching the nearest simple voltage divider that would work. The
> values are pure guesses!
>=20
> Thank you again for your help!

You're welcome. Thanks for your contribution, I've added it to the wiki:
http://www.lm-sensors.org/wiki/Configurations/MSI/X58-Pro-E

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
