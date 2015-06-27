From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 27 Jun 2015 13:01:34 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <201506271501.34645@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2452112706450574355=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20150428123850.GA8855@kroah.com> <201506271447.16248@pali> <5861345.suUcko3aRb@xps13>
In-Reply-To: <5861345.suUcko3aRb@xps13>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============2452112706450574355==
Content-Type: multipart/signed;
  boundary="nextPart2158192.F57xMo469r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2158192.F57xMo469r
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 June 2015 14:55:40 Gabriele Mazzotta wrote:
> On Saturday 27 June 2015 14:47:16 Pali Roh=C3=A1r wrote:
> > On Saturday 27 June 2015 13:34:30 Gabriele Mazzotta wrote:
> > > Hi Pali,
> > >=20
> > > I've just noticed an issue with this patch. See the comment here
> > > below.
> > >=20
> > > Gabriele
> > >=20
> > > On Wednesday 29 April 2015 13:41:26 Pali Roh=C3=A1r wrote:
> > > > @@ -750,8 +777,8 @@ static int __init i8k_init_hwmon(void)
> > > >=20
> > > >  	if (err >=3D 0)
> > > >  =09
> > > >  		i8k_hwmon_flags |=3D I8K_HWMON_HAVE_FAN2;
> > > >=20
> > > > -	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL,
> > > > "i8k", NULL, -							  i8k_groups);
> > > > +	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL,
> > > > "dell-smm", +							  NULL, i8k_groups);
> > >=20
> > > dell-smm is not a valid name, see
> > > hwmon_device_register_with_groups() for more info (dash not
> > > allowed). Because of this, the driver can't be loaded.
> >=20
> > How it is possible? It worked fine on my tested dell machine...
> >=20
> > And now I see, I probably tested this change with older kernel
> > version (ubuntu/3.13) which did not have that check for invalid
> > characters...
> >=20
> > Renaming dell-smm to dell_smm should fix this problem, right?
>=20
> Yes, everything works just fine with the underscore.

Ok, will you send patch for this small fix?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2158192.F57xMo469r
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWOnq4ACgkQi/DJPQPkQ1J7bQCgsHlXGY4zQhRRnzO+hi6Jc23q
/xwAoIM8T7t908vOKUBuG8M7rDSK56Vx
=Rvqj
-----END PGP SIGNATURE-----

--nextPart2158192.F57xMo469r--


--===============2452112706450574355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2452112706450574355==--
