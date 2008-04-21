From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Mon, 21 Apr 2008 11:36:13 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 1/5] lm75: cleanup/reorg
Message-Id: <200804211336.24453.laurentp@cse-semaphore.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4815733000479779312=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161029.23656.david-b@pacbell.net>
In-Reply-To: <200804161029.23656.david-b@pacbell.net>
To: lm-sensors@vger.kernel.org

--===============4815733000479779312==
Content-Type: multipart/signed; boundary="nextPart1346464.YL98Rvsoqa";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1346464.YL98Rvsoqa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 19 April 2008 14:34, Jean Delvare wrote:
> On Fri, 18 Apr 2008 13:49:31 -0700, David Brownell wrote:
> > Updated patch appended.  The second patch needs corresponding
> > fixups; I'll post them after I get any comments on that.
>=20
> Good idea. I hope to have some time for this later today, if Laurent
> doesn't beat me at it.

I work on PowerPC- and I2C-related code during week days only. Sorry for the
delay.

> > Minor cleanup and reorg of the lm75 code.
> >=20
> >  - Kconfig provides a larger list of lm75-compatible chips
> >=20
> >  - A top comment now says what the driver does (!) ... as in, just
> >    what sort of sensor is this??
> >=20
> >  - Section comments now delineate the various sections of the driver:
> >    hwmon attributes, driver binding, register access, module glue.
> >    One driver binding function moved out of the attribute section,
> >    as did the driver struct itself.
> >=20
> >  - Minor tweaks to legacy probe logic:  correct a comment, and
> >    remove a pointless variable.
> >=20
> >  - Whitespace, linelength, and comment fixes.
> >=20
> > This patch should include no functional changes.
> >=20
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> >  drivers/hwmon/Kconfig |   17 ++++++---
> >  drivers/hwmon/lm75.c  |   90=20
++++++++++++++++++++++++++++----------------------
> >  2 files changed, 62 insertions(+), 45 deletions(-)
> >=20
> > --- ngw.orig/drivers/hwmon/Kconfig	2008-04-18 11:16:46.000000000 -0700
> > +++ ngw/drivers/hwmon/Kconfig	2008-04-18 11:24:59.000000000 -0700
> > @@ -380,13 +380,18 @@ config SENSORS_LM75
> >  	tristate "National Semiconductor LM75 and compatibles"
> >  	depends on I2C
> >  	help
> > -	  If you say yes here you get support for National Semiconductor LM75
> > -	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
> > -	  9-bit precision mode), and TelCom (now Microchip) TCN75.
> > +	  If you say yes here you get support for one common type of
> > +	  temperature sensor chip, with models including:
> > =20
> > -	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
> > -	  a force module parameter. The driver will not handle the extra
> > -	  precision anyhow.
> > +		- Dallas Semiconductor DS75 and DS1775
> > +		- Maxim MAX6625 and MAX6626
> > +		- Microchip MCP980x
> > +		- National Semiconductor LM75 and LM75A
>=20
> The LM75A is actually a Philips (NXP) part, not a National
> Semiconductor part.
>=20
> > +		- ST Microelectronics STDS75
> > +		- TelCom (now Microchip) TCN75
> > +		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
> > +
> > +	  Most of these chips will require a "force" module parameter.
> > =20
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called lm75.
>=20
> But anyway, all the rest is correct so
>=20
> Acked-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Laurent Pinchart <laurentp@cse-semaphore.com>

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1346464.YL98Rvsoqa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDHw48y9gWxC9vpcRAqGaAKDRZDq2ZTmertPag+SqCf4cjQNgagCeKwXU
I1sPkrcu0t5LpUE54q53+CM=
=YnGY
-----END PGP SIGNATURE-----

--nextPart1346464.YL98Rvsoqa--


--===============4815733000479779312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4815733000479779312==--
