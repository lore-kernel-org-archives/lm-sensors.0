From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 25 Feb 2015 14:29:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <20150225142924.GX1509@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2520511298926332891=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
 <20150223143416.GT1509@kw.sim.vm.gnt> <54EB3C84.30503@roeck-us.net>
 <20150225111430.GV1509@kw.sim.vm.gnt>
 <20150225135015.GA17992@lunn.ch>
In-Reply-To: <20150225135015.GA17992@lunn.ch>
To: linux-arm-kernel@lists.infradead.org


--===============2520511298926332891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="89VDYHnQ8ukgENkm"
Content-Disposition: inline


--89VDYHnQ8ukgENkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 02:50:15PM +0100, Andrew Lunn wrote:
> > Handle the GPIO fan alarm feature from the fan controller driver don't
> > look good either to me. This alarm mechanism is not a part of the fan
> > controller itself but rather something apart. Also I am afraid that the
> > result would really look like a hack.
>=20
> Hi Simon
>=20
> It sounds like you need to extract the alarm code from gpio-fan into a
> little library. Then put a wrapper around it to make a gpio-fan-alarm
> driver.

Hi Andrew,

Yes, I am working on that. I'll come back with some patches based on
this approach.

Simon

--89VDYHnQ8ukgENkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTt3EQACgkQgtp0PDeOcDrxqwCfTt0LiF7j8jWKBjt6tiA+zXu5
IdEAmgKKL9t2tPl8mpNZkeIByoXR3kO6
=5WfB
-----END PGP SIGNATURE-----

--89VDYHnQ8ukgENkm--


--===============2520511298926332891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2520511298926332891==--
