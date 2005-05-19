From: ender@debian.org (David =?iso-8859-1?q?Mart=EDnez=20Moreno?=)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Message-Id: <200401291227.15413.ender@debian.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10752464532256@kroah.com> <200401281408.34364.ender@debian.org> <20040128232320.GA10657@kroah.com>
In-Reply-To: <20040128232320.GA10657@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 29 de Enero de 2004 00:23, Greg KH escribi?:
> On Wed, Jan 28, 2004 at 02:08:34PM +0100, David Mart?nez Moreno wrote:
> > El Mi?rcoles, 28 de Enero de 2004 00:34, Greg KH escribi?:
> > > +			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
> > > +				" Defaulting to LM85.\n", verstep);
> >
> > 	Hello, Greg.
> >
> > 	Just noticed, please s,recgonized,recognized,g all over the file.
>
> Care to send me a spelling fix patch?

	Sure, it's only a small thing in return for all that Linux has given to me.

	Following patch fixes two typos and a missing full stop. Applies cleanly
against 2.6.2-rc2 + i2c patches you just submitted.

- --- kernel-2.6.x/drivers/i2c/chips/lm85.c.orig	2004-01-29 12:18:49.000000=
000 +0100
+++ kernel-2.6.x/drivers/i2c/chips/lm85.c	2004-01-29 12:21:01.000000000 +01=
00
@@ -816,7 +816,7 @@
 			kind =3D lm85b ;
 		} else if( company =3D LM85_COMPANY_NATIONAL
 		    && (verstep & 0xf0) =3D LM85_VERSTEP_GENERIC ) {
- -			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to LM85.\n", verstep);
 			kind =3D any_chip ;
 		} else if( company =3D LM85_COMPANY_ANALOG_DEV
@@ -827,7 +827,7 @@
 			kind =3D adt7463 ;
 		} else if( company =3D LM85_COMPANY_ANALOG_DEV
 		    && (verstep & 0xf0) =3D LM85_VERSTEP_GENERIC ) {
- -			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to ADM1027.\n", verstep);
 			kind =3D adm1027 ;
 		} else if( kind =3D 0 && (verstep & 0xf0) =3D 0x60) {
@@ -1204,7 +1204,7 @@
=20
 /* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
  * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
- - *     post 2.7.0 CVS changes
+ *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schu=
bert-While <margitsw@t-online.de>");

- --=20
Non. Je suis la belette de personne.
		-- Am?lie (Le fabuleux destin d'Am?lie Poulain)
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGO4TWs/EhA1iABsRAp19AKDVl5+vuHOh3m0f0GamlAKn/6pdTwCg1IMF
dsbE2UzjeJ2YfB+bk5Cu1GE=DApv
-----END PGP SIGNATURE-----

