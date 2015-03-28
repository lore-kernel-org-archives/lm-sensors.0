From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 28 Mar 2015 22:04:51 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <201503282304.51310@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3325668235484869605=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com> <1427538255-10860-3-git-send-email-pali.rohar@gmail.com> <5516B953.2050203@roeck-us.net>
In-Reply-To: <5516B953.2050203@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============3325668235484869605==
Content-Type: multipart/signed;
  boundary="nextPart13356021.KEEz1AC5Ij";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart13356021.KEEz1AC5Ij
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 March 2015 15:23:15 Guenter Roeck wrote:
> > +	---help---
> > +	  This hwmon driver adds support for reporting temperature
> > of different +	  sensors and controls the fans on Dell
> > laptops via System Management +	  Mode provided by Dell
> > BIOS.
> > +
> > +	  When option I8K is also enabled this driver provides
> > legacy /proc/i8k +	  userspace interface for i8kutils
> > package.
> > +
>=20
> Please add this in alphabetic order.
>=20

ok

> >   if ACPI
> >  =20
> >   comment "ACPI drivers"
> >=20
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 1c3e458..9eec614 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -155,7 +155,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+=3D
> > w83l785ts.o
> >=20
> >   obj-$(CONFIG_SENSORS_W83L786NG)	+=3D w83l786ng.o
> >   obj-$(CONFIG_SENSORS_WM831X)	+=3D wm831x-hwmon.o
> >   obj-$(CONFIG_SENSORS_WM8350)	+=3D wm8350-hwmon.o
> >=20
> > -obj-$(CONFIG_I8K)		+=3D dell-smm-hwmon.o
> > +obj-$(CONFIG_SENSORS_DELL_SMM)	+=3D dell-smm-hwmon.o
>=20
> Same here.
>=20

ok

> > -	proc_i8k =3D proc_create("i8k", 0, NULL, &i8k_fops);
> > -	if (!proc_i8k)
> > +	if (!proc_create("i8k", 0, NULL, &i8k_fops))
> >=20
> >   		return -ENOENT;
>=20
> I would prefer not to fail here but report a warning.
> This is no longer a fatal condition.
>=20

ok, no problem

>=20
> Can you move all the conditional functions and global
> variables together under a single #ifdef ? That should
> include functions to create the proc entries, and shim
> functions for the same if I8K is not configured.
>=20

ok, I will move procfs code to one location.

> Also, the #ifdef would not cover the case where I8K is
> configured as module (there is no reason to force it to
> bool). You should use "#if IS_ENABLED(CONFIG_I8K)" instead.
>=20

I think that setting CONFIG_I8K to tristate (Y/M/N) does not make=20
sense... CONFIG_I8K just control if /proc/i8k will be compiled=20
into dell-smm-hwmon or not.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart13356021.KEEz1AC5Ij
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUXJYMACgkQi/DJPQPkQ1LsuwCeJegL/f5AfGCW/yViwLQ89NVf
h54An1acWVrFzNEgXZ3b/Tma6NqBNDlW
=6Ule
-----END PGP SIGNATURE-----

--nextPart13356021.KEEz1AC5Ij--


--===============3325668235484869605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3325668235484869605==--
