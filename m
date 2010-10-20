From: Simon Guinot <simon@sequanux.org>
Date: Wed, 20 Oct 2010 00:19:13 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101020001913.GI29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2053354672319848080=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287525825.9690.313.camel@groeck-laptop>
In-Reply-To: <1287525825.9690.313.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org


--===============2053354672319848080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Oct 19, 2010 at 03:03:45PM -0700, Guenter Roeck wrote:
> Hi Simon,
>=20
> one more comment ...
>=20
> On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> [ ... ]
> > +static int __devinit
> > +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *=
alarm)
> > +{
>=20
> __devinit and __devexit can cause problems if this driver is built into
> the kernel, but the underlying i2c master driver is built as module.

I am not sure I understand this. Are you talking about a I2C GPIO
expander ? or about the hwmon registration process ?

For the first case, no I2C mean no GPIOs and the gpio-fan initialization
will fail (because no GPIO chip available). There is nothing wrong with
freeing the useless init functions.

For the second case, let me know...

Not really related, but there is too much __devinit and __devexit
declarations in the first patch version. Thanks to the compiler, all
this functions are inlined in the good place.

>=20
> So please remove __devinit and __devexit.

I will if you tell me why :)

Thanks,

Simon

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky+NYEACgkQgtp0PDeOcDoIHQCcDGZVUVGKmUcgwLD/11TvBUp2
BtwAoJ49BXqossvIT45ZBbwOrE0dthUj
=RtSL
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--


--===============2053354672319848080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2053354672319848080==--
