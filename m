From: Wolfram Sang <w.sang@pengutronix.de>
Date: Sat, 06 Feb 2010 14:38:08 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: add driver for ADT7411 voltage &
Message-Id: <20100206143808.GA28107@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0585022237273910333=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
To: lm-sensors@vger.kernel.org


--===============0585022237273910333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You can have reading vdd from sysfs also update the cache, but then you
> should also read data->ref_is_vdd at the same time. If the user is
> going to always read all the values at once then this is the most
> efficient approach.

Yup. Just if not, then we will have another useless read (reading adc_ref_v=
dd
when we always want to know vdd) as on embedded boards, sysfs is often used
directly. Also, I can't factor out the caching-routine, as show_input() nee=
ds
vdd only if adc_ref_vdd is set. Adding a force_flag for always reading vdd =
to a
factored out function seems a bit too complex for that case to me. I think =
I'll
leave it at the current state: show_input() does the caching, show_vdd() al=
ways
reads from the chip. We might end up reading vdd twice within a second. Wel=
l,
it shouldn't hurt that much.

> > I hate this driver, it makes me look pretty stupid :/
>=20
> Naah ;) Stupid developers are the ones who let me review their driver
> code and then refuse to fix the problems I have found. As long as your
> driver ends up upstream, you're doing the right thing!

I am quite positive it will end upstream at the end; still, I'd like to have
spared you from those obvious flaws. Can't be helped, I'll try harder next
time and buy a couple of brown paper bags ;)

> OK, thanks. Remember that you can also do preliminary testing using
> i2c-stub + a dump of the chip.

I haven't forgotten, just some effects of the configuration bits can't be
tested with that method. And as I still have that board set up...

Have a nice weekend!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkttftAACgkQD27XaX1/VRt3jgCgsu5EL9ve/DmueKTXbSgjW3Yx
tn0AoMIMN0zBTtEWvsW+KqW0G2Deb88D
=q+sY
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


--===============0585022237273910333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0585022237273910333==--
