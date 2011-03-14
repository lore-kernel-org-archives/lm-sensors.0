From: "Anders Kullenberg" <akullen@swipnet.se>
Date: Mon, 14 Mar 2011 20:39:19 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <000001cbe287$e555d120$b0017360$@se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
>=20
> Anders,
>=20
> On Sat, 12 Mar 2011 22:39:42 +0100, Anders Kullenberg wrote:
> > Thanks for the quick reply.
>=20
> Please don't top-post.

Sorry for that, now I know how to do it.

>=20
> > I checked the BIOS readings. They are normal, even below 800rpm. I
> have the
> > asus q-fan enabled in the bios that should control fan speeds. I
> tried to
> > disable it, didn't change anything.
> > It is possible to select ACPI 1.0, 2.0 or 3.0 in the bios, any
> > recommendations on that?
>=20
> I'd go for ACPI 2.0 as the best compromise between recentness and
> support level, but in the end it really depends on what the BIOS adds
> in each case, and whether Linux properly supports that yet or not. But
> anyway it probably doesn't matter for the problem at hand.

I switched the setting to ACPI 2.0

>=20
> > The fans are not any special stuff as far as I'm aware. They are
> connected
> > to the motherboard directly, no potentiometers used in the
> installation.
>=20
> OK. Maybe you should send your board's DSDT to Luca for analysis then.

Done.

>=20
> > I found no chip "atk0110-*" section in /etc/sensors3.conf, what
> config is
> > used then, where should I put the compute statements?
>=20
> The ATK0110 usually doesn't need any configuration, as the driver knows
> all the scaling factors and labels. But you are free to add a new
> configuration section for it if you really have to.
>=20
> I'm a little surprised as the M2V isn't a recent board, so it should be
> already supported, or more users would have reported by now. Did you
> look for a BIOS update for your board?

Have the latest bios available from asus homepage.

>=20
> --
> Jean Delvare

Some more info. Don't know if it is of use but I have configured munin to
read the sensor output.
Over the last ~24hour both the fan RPM readings has decreased with ~4000 rpm
in a very stable decrease over time.
During the same period the temp readings have been very stable on the same
level.

Thanks
Anders


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
