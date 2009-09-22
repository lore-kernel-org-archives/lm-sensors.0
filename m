From: Rodolfo Giometti <giometti@enneenne.com>
Date: Tue, 22 Sep 2009 08:26:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090922082607.GD17623@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0159882542452902346=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============0159882542452902346==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2009 at 04:49:02PM +0200, Jean Delvare wrote:
> On Fri, 18 Sep 2009 14:09:23 +0200, Rodolfo Giometti wrote:
> > Hi Jean,
> >=20
> > this new proposal patch sounds better to you? :)
> >=20
> > Ciao,
> >=20
> > Rodolfo
> >=20
> > --
> >=20
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 2d50166..bc7058f 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -894,6 +894,7 @@ config SENSORS_W83L786NG
> > =20
> >  config SENSORS_W83627HF
> >  	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
> > +	depends on 83627HF
>=20
> Which doesn't exist, so the driver can't be selected. Obviously you
> meant: depends on MFD_W83627HF.
>=20
> But please also see my discussion with Samuel on depends vs. select.
> I'd prefer that you use select. Especially given that the MFD
> configuration entry is _after_ the hwmon configuration entry in
> Kconfig, I fear that even if users see and select MFD_W83627HF, they
> won't walk back to the W83627HF entry to select it.
>=20
> Samuel, wouldn't it make sense to move the MFD section up in the Device
> Drivers section?
>=20
> Even after fixing this so that I could select the driver, I'm hitting
> build problems:
>=20
>   CC [M]  drivers/hwmon/w83627hf.o
> drivers/hwmon/w83627hf.c: In function ???w83627hf_probe???:
> drivers/hwmon/w83627hf.c:1121: warning: passing argument 1 of ???acpi_che=
ck_resource_conflict??? from incompatible pointer type
> drivers/hwmon/w83627hf.c:1125: error: ???WINB_REGION_SIZE??? undeclared (=
first use in this function)
> drivers/hwmon/w83627hf.c:1125: error: (Each undeclared identifier is repo=
rted only once
> drivers/hwmon/w83627hf.c:1125: error: for each function it appears in.)
> drivers/hwmon/w83627hf.c: In function ???w83627hf_remove???:
> drivers/hwmon/w83627hf.c:1290: error: ???WINB_REGION_SIZE??? undeclared (=
first use in this function)
>=20
> Please build-test your patches before you send them.

Yes, sorry. Fixed.

> >  	select HWMON_VID
> >  	help
> >  	  If you say yes here you get support for the Winbond W836X7 series
> > diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> > index 389150b..4757668 100644
> > --- a/drivers/hwmon/w83627hf.c
> > +++ b/drivers/hwmon/w83627hf.c
> > @@ -51,18 +51,10 @@
> >  #include <linux/mutex.h>
> >  #include <linux/ioport.h>
> >  #include <linux/acpi.h>
> > -#include <asm/io.h>
> > +#include <linux/io.h>
>=20
> As I said before, this change is already upstream, so please don't
> include it in your patch.
>=20
> >  #include "lm75.h"
> > +#include <linux/mfd/w83627hf.h>
>=20
> Global includes must be listed before local ones.

Both fixed.

> I'll go on with the review when you provide a patch I can build.

Ok, thanks.

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq4ih8ACgkQQaTCYNJaVjOH3wCeMA1K/1ufkwd/d/sX7EHklGWm
8T0An09qt0eG0lBUbXLJ04aPe5UNDtOf
=qGZL
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--


--===============0159882542452902346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0159882542452902346==--
