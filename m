From: Simon Guinot <simon@sequanux.org>
Date: Wed, 20 Oct 2010 07:59:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101020075931.GJ29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8027408199305893448=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287525825.9690.313.camel@groeck-laptop>
	<20101020001913.GI29120@kw.sim.vm.gnt>
	<1287535826.9690.358.camel@groeck-laptop>
In-Reply-To: <1287535826.9690.358.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org


--===============8027408199305893448==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Oct 19, 2010 at 05:50:26PM -0700, Guenter Roeck wrote:
> Hi Simon,
>=20
> On Tue, 2010-10-19 at 20:19 -0400, Simon Guinot wrote:
> > Hi Guenter,
> >=20
> > On Tue, Oct 19, 2010 at 03:03:45PM -0700, Guenter Roeck wrote:
> > > Hi Simon,
> > >=20
> > > one more comment ...
> > >=20
> > > On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > > [ ... ]
> > > > +static int __devinit
> > > > +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_ala=
rm *alarm)
> > > > +{
> > >=20
> > > __devinit and __devexit can cause problems if this driver is built in=
to
> > > the kernel, but the underlying i2c master driver is built as module.
> >=20
> > I am not sure I understand this. Are you talking about a I2C GPIO
> > expander ? or about the hwmon registration process ?
>=20
> Not related to I2C specifically, since you don't use I2C. No idea why I
> mentioned I2C, really. Probably because I had I2C in my mind.

gpio-fan could use I2C implicitly if the GPIOs are provided by a GPIO
I2C expander.

>=20
> Anyway, there are gpio drivers which can be loaded and unloaded. GPIO
> pin(s) on one of those could point to the gpio-fan driver. If gpio-fan
> is built into the kernel, but the underlying gpio driver is built as
> module, loading the gpio driver might cause the gpio-fan probe function
> to be called - but that function no longer exists if it is tagged as
> __devinit.

IMHO, the gpio-fan probe function will be called anyway if a "gpio-fan"
platform device is available. If the needed GPIOs are not registered at
this time, gpio_request() will fail and the gpio-fan probe function will
exit.

Later, even if the GPIOs are registered (via gpiochip_add()), this will
not trigger a gpio-fan probe.

>=20
> Browsing through the gpio code, it seems the problem doesn't really
> exist, since the above scenario does not happen (unless I am missing
> something, of course). Also, other drivers using gpio calls also use
> __devinit and __devexit. So just ignore what I said.

Ok.

Thanks,

Simon

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky+oWMACgkQgtp0PDeOcDr/DACdEUNJLDAOZMttRChr4qX6yP2m
jKYAni/a1v8gmllONnVSLPD0Hr6bnLJ7
=vhll
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--


--===============8027408199305893448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8027408199305893448==--
