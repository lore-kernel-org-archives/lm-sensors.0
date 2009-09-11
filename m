From: Rodolfo Giometti <giometti@enneenne.com>
Date: Fri, 11 Sep 2009 07:42:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090911074223.GG26519@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4306177249414632811=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============4306177249414632811==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2009 at 02:56:09PM +0200, Jean Delvare wrote:
> Hi Rodolfo,
>=20
> Don't bother including Frodo L. and Mark S. in the discussions, they
> have left the lm-sensors project years ago.

Ok. I just sent the letter to them in order to inform about my
proposal...

> On Thu, 10 Sep 2009 14:30:10 +0200, Rodolfo Giometti wrote:
> > The file has been splitted up into two parts:
> >=20
> > * drivers/mfd/w83627hf.c         - detects the chip and define proper
> >                                    platform devices into mfd support
> >=20
> > * drivers/hwmon/hwmon-w83627hf.c - implements the driver for hwmon
> >                                    functionality only
> >=20
> > The patch also fixes up some non reentrant code and some C-style issues.
> >=20
> > Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> > ---
> >  drivers/hwmon/Kconfig                          |    2 +-
> >  drivers/hwmon/Makefile                         |    2 +-
> >  drivers/hwmon/{w83627hf.c =3D> hwmon-w83627hf.c} |  373 +++++---------=
----------
>=20
> This name change will break all users of the driver. The sensors-detect
> script points the user to "w83627hf" and typically writes this value to
> an init script or configuration file. The w83627hf driver doesn't
> auto-load (yet) so this is a requirement.
>=20
> Assuming that the hwmon part depends on the MFD part, I'd rather keep
> "w83627hf" as the hwmon part name, and name the new MFD part
> "w83627hf-core" or similar. I agree it's not so nice but at least it
> doesn't break compatibility.

I agree. So I'm going to keep w83627hf name for hwmon part name and
using w83627hf-core for the new MFD part. Then I'll repost my patch.

Thanks for your attention,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqp/18ACgkQQaTCYNJaVjOJLwCgscZdryyznkG/c+3TbCXvj9pa
7CQAniEF5B3DW9JnPlueWO/qPObJjBQs
=oYd9
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--


--===============4306177249414632811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4306177249414632811==--
