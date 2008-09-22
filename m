From: Rodolfo Giometti <giometti@enneenne.com>
Date: Mon, 22 Sep 2008 14:52:53 +0000
Subject: Re: [lm-sensors] [i2c] support for MAX8821 led charge pump
Message-Id: <20080922145253.GB3948@tekkaman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7601739565631071345=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============7601739565631071345==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2008 at 04:24:08PM +0200, Jean Delvare wrote:
> Hi Rodolfo,
>=20
> On Mon, 22 Sep 2008 15:42:30 +0200, Rodolfo Giometti wrote:
> > This patch adds support for MAXIM MAX8821.
> >=20
> > This chip integrates a charge pump for white LEDs, an audio loudspeaker
> > amplifier, and two low noise LDOs controlled by an I2C control interfac=
e.
> > (...)
>=20
> Wrong mailing list. This clearly has nothing to do with hardware
> monitoring.

Sorry, the device is I2C but it not fixes wery well into any Linux
subsystem so I supposed the main I2C mail list was correct. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI17FFQaTCYNJaVjMRAqycAJ922Ulqu6t7CjtDUGBSSjCllzf1RACfe6Gc
Q9B+e/9GFGWiVQp0n8ZZJXo=
=KZza
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--


--===============7601739565631071345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7601739565631071345==--
