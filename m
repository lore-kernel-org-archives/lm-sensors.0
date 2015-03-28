From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 28 Mar 2015 21:55:35 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <201503282255.35773@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2152805927007309127=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com> <1427538255-10860-3-git-send-email-pali.rohar@gmail.com> <1427540660.2334.14.camel@x220>
In-Reply-To: <1427540660.2334.14.camel@x220>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============2152805927007309127==
Content-Type: multipart/signed;
  boundary="nextPart2190338.NqD38WEMED";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2190338.NqD38WEMED
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 March 2015 12:04:20 Paul Bolle wrote:
> On Sat, 2015-03-28 at 11:24 +0100, Pali Roh=C3=A1r wrote:
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1703,6 +1703,17 @@ config SENSORS_ULTRA45
> >=20
> >  	  This driver provides support for the Ultra45 workstation
> >  	  environmental sensors.
> >=20
> > +config SENSORS_DELL_SMM
> > +	tristate "Dell laptop SMM BIOS hwmon driver"
> > +	depends ON X86
>=20
> How did this past your testing?
>=20

Hello,

I have tested compilation only with out of tree make command with=20
manual CONFIG_SENSORS_DELL_SMM and CONFIG_I8K options.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2190338.NqD38WEMED
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUXI1cACgkQi/DJPQPkQ1LoJACgsCIoj3UYHSHfeGwJbzgGwiZ5
kzsAoMAX6XjbYIhNlhbK6yvbeV7BOXie
=mGaB
-----END PGP SIGNATURE-----

--nextPart2190338.NqD38WEMED--


--===============2152805927007309127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2152805927007309127==--
