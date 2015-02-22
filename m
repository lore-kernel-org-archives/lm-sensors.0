From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sun, 22 Feb 2015 17:44:54 +0000
Subject: Re: [lm-sensors] i8k: move driver from char to hwmon
Message-Id: <201502221844.54371@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2555300907653957547=="
List-Id: <lm-sensors.vger.kernel.org>
References: <201502221250.49466@pali> <54EA12DC.1000403@roeck-us.net>
In-Reply-To: <54EA12DC.1000403@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Honeyman <stevenhoneyman@gmail.com>, Jean Delvare <jdelvare@suse.de>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============2555300907653957547==
Content-Type: multipart/signed;
  boundary="nextPart2703939.OgXWp7U8C3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2703939.OgXWp7U8C3
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 22 February 2015 18:33:16 Guenter Roeck wrote:
> On 02/22/2015 03:50 AM, Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > currently i8k driver for DELLDIAG SMM operations (charger,
> > battery, hotkeys, temperature and fan control) supports two
> > interfaces:
> >=20
> > 1) old /proc/i8k char device
> > 2) new hwmon interface
> >=20
> > Driver now lives in char subsystem, but nowadays I think lot
> > of people are interested only in hwmon interface which
> > provides temperature & fan control. Power management and
> > hotkeys support (which is missing in 2) but provided by 1))
> > is already handled by ACPI or input subsystem for new
> > laptops.
> >=20
> > Also name "i8k" is really non intuitive what it means and
> > supports... (I was told it is abbreviation for Inspirion
> > 8000 model which was probably first dell model supported by
> > that DELLDIAG interface). Now driver is used on Vostro,
> > Latitude and also Precision and XPS models. I think at
> > least "dell" should be part of driver name and config
> > option.
> >=20
> > So I have idea for some changes:
> >=20
> > 1) Move driver from char subsystem to hwmon
>=20
> I am ok with this one.
>=20
> > 2) Rename driver from i8k to something like delldiag or
> > dellsmm
>=20
> Might be problematic, as it would break existing
> configurations unless you keep the CONFIG_I8K but rename the
> driver. Driver names are never perfect, so I would just leave
> it as is.
>=20
> > 3) Add new CONFIG_ option to enable/disable /proc/i8k device
> > and compile only hwmon interface support
>=20
> Makes sense. I would suggest to make hwmon suppport the
> default and mandatory if the driver is enabled and add a new
> CONFIG_I8K_PROCIF or similar which should be enabled by
> default.
>=20

What about CONFIG_DELLDIAG (or DELLSMM or CONFIG_SENSORS_*) for=20
mandatory core & hwmon code and (keep existing) CONFIG_I8K for=20
/proc/i8k?

> Are you interested in adding yourself as maintainer for this
> driver ?
>=20

Ok I could. But I do not know how much time will have in future.

> Thanks,
> Guenter

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2703939.OgXWp7U8C3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTqFZYACgkQi/DJPQPkQ1IAngCgqOQ0qztfk+seiZkNe8UmdFbp
4ugAoMNyVIEwIyghbpl6NYgY16TFCxKD
=K87A
-----END PGP SIGNATURE-----

--nextPart2703939.OgXWp7U8C3--


--===============2555300907653957547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2555300907653957547==--
