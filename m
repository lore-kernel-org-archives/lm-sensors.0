From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 27 Jun 2015 12:47:16 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <201506271447.16248@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8602094398859123257=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20150428123850.GA8855@kroah.com> <1430307686-1734-2-git-send-email-pali.rohar@gmail.com> <3228158.O80YglnvCi@xps13>
In-Reply-To: <3228158.O80YglnvCi@xps13>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============8602094398859123257==
Content-Type: multipart/signed;
  boundary="nextPart4409248.3PGDtQR7TW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4409248.3PGDtQR7TW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 June 2015 13:34:30 Gabriele Mazzotta wrote:
> Hi Pali,
>=20
> I've just noticed an issue with this patch. See the comment here
> below.
>=20
> Gabriele
>=20
> On Wednesday 29 April 2015 13:41:26 Pali Roh=C3=A1r wrote:
> > @@ -750,8 +777,8 @@ static int __init i8k_init_hwmon(void)
> >=20
> >  	if (err >=3D 0)
> >  =09
> >  		i8k_hwmon_flags |=3D I8K_HWMON_HAVE_FAN2;
> >=20
> > -	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL, "i8k",
> > NULL, -							  i8k_groups);
> > +	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL,
> > "dell-smm", +							  NULL, i8k_groups);
>=20
> dell-smm is not a valid name, see hwmon_device_register_with_groups()
> for more info (dash not allowed). Because of this, the driver can't
> be loaded.
>=20

How it is possible? It worked fine on my tested dell machine...

And now I see, I probably tested this change with older kernel version=20
(ubuntu/3.13) which did not have that check for invalid characters...

Renaming dell-smm to dell_smm should fix this problem, right?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4409248.3PGDtQR7TW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWOm1QACgkQi/DJPQPkQ1I1zgCfWdg70G5h5vjbQ5IfqOCz2LNx
nj8AmwXy6f8yeFYnShZE9sW2QAljucVM
=34qb
-----END PGP SIGNATURE-----

--nextPart4409248.3PGDtQR7TW--


--===============8602094398859123257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8602094398859123257==--
