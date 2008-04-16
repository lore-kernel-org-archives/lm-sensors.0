From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Wed, 16 Apr 2008 13:49:47 +0000
Subject: Re: [lm-sensors] lm75: Convert to new-style I2C driver
Message-Id: <200804161550.05773.laurentp@cse-semaphore.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9044375582209653960=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
In-Reply-To: <200804161434.54335.laurentp@cse-semaphore.com>
To: lm-sensors@vger.kernel.org

--===============9044375582209653960==
Content-Type: multipart/signed; boundary="nextPart10698173.sreR2GeHI9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart10698173.sreR2GeHI9
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jean,

On Wednesday 16 April 2008 15:30, Jean Delvare wrote:
> Hi Laurent,
>=20
> On Wed, 16 Apr 2008 14:34:53 +0200, Laurent Pinchart wrote:
> > This patch converts the lm75 driver into a new-style I2C driver.
> >=20
> > Signed-off-by: Laurent Pinchart=20
<laurent@pclaurent.belgium.cse-semaphore.com>
> > ---
> >  drivers/hwmon/lm75.c |  292=20
+++++++++++++++++++++-----------------------------
> >  1 files changed, 124 insertions(+), 168 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > index d7a22a5..7c17611 100644
> > --- a/drivers/hwmon/lm75.c
> > +++ b/drivers/hwmon/lm75.c
> > @@ -29,14 +29,6 @@
> >  #include <linux/mutex.h>
> >  #include "lm75.h"
> > =20
> > -
> > -/* Addresses to scan */
> > -static const unsigned short normal_i2c[] =3D { 0x48, 0x49, 0x4a, 0x4b,=
=20
0x4c,
> > -					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> > -
> > -/* Insmod parameters */
> > -I2C_CLIENT_INSMOD_1(lm75);
> > -
>=20
> What about all the (PC) systems where the LM75 devices were probed
> successfully so far? You're breaking them!
>=20
> Adding support for new-style devices is fine. Dropping support for
> legacy devices is not. Please see the f75375s driver for an example of
> driver supporting both legacy and new-style i2c devices.

Sorry. Is there any plan to support new-style device drivers for PC hardwar=
e=20
in the future ?

> Note that David Brownell (Cc'd) had been working on this back in
> September 2007:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.ht=
ml
> Unfortunately he never got around to addressing all my comments, so his
> patch didn't go anywhere. Maybe you can work with David on getting
> something in shape that would be suitable for upstream submission.

Ok. David, do you plan to resubmit your patch ?

> >  /* Many LM75 constants specified below */
> > =20
> >  /* The LM75 registers */
> > @@ -49,34 +41,61 @@ static const u8 LM75_REG_TEMP[3] =3D {
> > =20
> >  /* Each client has this additional data */
> >  struct lm75_data {
> > -	struct i2c_client	client;
> > -	struct device *hwmon_dev;
> > -	struct mutex		update_lock;
> > -	char			valid;		/* !=3D0 if following fields are valid */
> > -	unsigned long		last_updated;	/* In jiffies */
> > -	u16			temp[3];	/* Register values,
> > -						   0 =3D input
> > -						   1 =3D max
> > -						   2 =3D hyst */
> > +	struct device	*hwmon_dev;
> > +	struct mutex	update_lock;
> > +	char		valid;		/* !=3D0 if following fields are valid */
> > +	unsigned long	last_updated;	/* In jiffies */
> > +	u16		temp[3];	/* Register values,
> > +					   0 =3D input
> > +					   1 =3D max
> > +					   2 =3D hyst */
> >  };
>=20
> And please do NOT mix coding style cleanups with real code changes.
> Each patch should do just one thing, so that it is easy to test and
> review.

Ok.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart10698173.sreR2GeHI9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBgQN8y9gWxC9vpcRAqqkAJ9kmxyaIqOPlrVAs7Gz4TLV7xvrFgCdH32T
yRSlCFTTAjZwSBhFJWluj/U=
=8wxh
-----END PGP SIGNATURE-----

--nextPart10698173.sreR2GeHI9--


--===============9044375582209653960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9044375582209653960==--
