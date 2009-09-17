From: Rodolfo Giometti <giometti@enneenne.com>
Date: Thu, 17 Sep 2009 13:51:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090917135120.GF28227@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5950145843751489367=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============5950145843751489367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2009 at 03:34:50PM +0200, Jean Delvare wrote:
> Hi Rodolfo,
>=20
> On Fri, 11 Sep 2009 17:07:05 +0200, Rodolfo Giometti wrote:
> > The file has been splitted up into two parts:
>=20
> Spelling: split (it's an irregular verb.)
>=20
> >=20
> > * drivers/mfd/w83627hf-core.c      - detects the chip and define proper
> >                                      platform devices into mfd support
> >=20
> > * drivers/hwmon/w83627hf.c         - implements the driver for hwmon
> >                                      functionality only
> >=20
> > The patch also fixes up some non reentrant code and some C-style issues.
>=20
> Sounds wrong. Mixing coding style cleanups with real changes makes
> reviewing much harder. You'll have to move these changes to a separate
> patch I'm afraid.

Ok, I'll repropose a patch.

I prefer propose a patch with real changes only, is that correct even
if checkpatch.pl says no? :)

Thanks,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqyPtgACgkQQaTCYNJaVjPNhwCZAWd/t5rATdK9i9lXT8038iNu
im4AnRVebDz90tGOG0Byfc6tY3J/BfVm
=q0Zs
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--


--===============5950145843751489367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5950145843751489367==--
