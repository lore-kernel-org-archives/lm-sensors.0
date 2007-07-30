From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 30 Jul 2007 18:11:39 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver
Message-Id: <20070730181138.GB29140@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2963608990772009167=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070711183825.GP3435@tree.beaverton.ibm.com>
In-Reply-To: <20070711183825.GP3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============2963608990772009167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2007 at 12:11:22AM -0400, Mark M. Hoffman wrote:
> > +	/* Register sysfs hooks */
> > +	for (i =3D 0; i < ARRAY_SIZE(adt7470_attr); i++) {
> > +		err =3D device_create_file(&client->dev,
> > +					 &adt7470_attr[i].dev_attr);
> > +		if (err)
> > +			goto exit_remove;
> > +	}
> > +
>=20
> Please just use sysfs_create_group() here, as seen in many other hwmon dr=
ivers.

I _removed_ the giant static array of struct attribute and the
sysfs_create_group call at Mr. deGoede's suggestion:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020316.html

I'd rather not spend time on busy work re-adding all of that...

(I'll implement the rest of your suggestions and send out another
patch.)

--D

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGrinaa6vRYYgWQuURAgZrAJ9nfHvceciJQ2URsNtd7Iy36LfglQCfS1tq
rpEWdNkgOgp4cIYBxqQCbmk=
=Y0K7
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--


--===============2963608990772009167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2963608990772009167==--
