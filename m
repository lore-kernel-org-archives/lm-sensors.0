From: Simon Guinot <simon@sequanux.org>
Date: Thu, 21 Oct 2010 20:07:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101021200710.GR29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3989054874709928033=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
In-Reply-To: <20101018160830.GB9033@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============3989054874709928033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mjrw6G9AoRBv8oQK"
Content-Disposition: inline


--mjrw6G9AoRBv8oQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Oct 18, 2010 at 09:08:30AM -0700, Guenter Roeck wrote:
> On Sun, Oct 17, 2010 at 11:50:11AM -0400, Simon Guinot wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> >=20
> > This patch adds hwmon support for the GPIO connected fan.
> >=20
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> >=20
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
>=20
> Hi Simon,
>=20
> good start. Bunch of comments inline. Our mailer was nice enough to repla=
ce tabs
> with blanks, thanks to our friends at MicroSomething, so I could not run =
the patch
> through checkpatch.pl. Hope you did that.
>=20
> > ---
> >  drivers/hwmon/Kconfig    |    9 +
> >  drivers/hwmon/Makefile   |    1 +
> >  drivers/hwmon/gpio-fan.c |  508 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/gpio-fan.h |   43 ++++
> >  4 files changed, 561 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/gpio-fan.c
> >  create mode 100644 include/linux/gpio-fan.h
> >=20
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4d4d09b..1dc57c1 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -399,6 +399,15 @@ config SENSORS_GL520SM
> >           This driver can also be built as a module.  If so, the module
> >           will be called gl520sm.
> >=20
> > +config SENSORS_GPIO_FAN
> > +       tristate "GPIO fan"
> > +       depends on GENERIC_GPIO
> > +       help
> > +         If you say yes here you get support for the GPIO connected fa=
n.
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called gpio-fan.
> > +
>=20
> Can you move this up a bit, ahead of SENSORS_FSCHMD ? Trying to stay in s=
equence.

Ok. Let's try to figure out where is the right location :)
After SENSORS_GL520SM or not ?

Thanks,

Simon

--mjrw6G9AoRBv8oQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzAnW4ACgkQgtp0PDeOcDqZogCePctWPBddqVAfCskfaSX8kWMv
GfkAnipmHluML+sr0IoMw77pBn1aa6Ui
=aGli
-----END PGP SIGNATURE-----

--mjrw6G9AoRBv8oQK--


--===============3989054874709928033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3989054874709928033==--
