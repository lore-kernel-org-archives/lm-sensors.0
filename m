From: Wolfram Sang <w.sang@pengutronix.de>
Date: Sun, 30 May 2010 04:15:07 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100530041507.GA20222@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7912979108715404260=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop> <20100529023401.GB12507@pengutronix.de> <20100529044239.GA19155@ericsson.com> <20100529085301.GA14982@pengutronix.de> <20100529153312.GA20814@ericsson.com> <20100529154741.GB7572@pengutronix.de> <20100529171229.GA21284@ericsson.com>
In-Reply-To: <20100529171229.GA21284-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>


--===============7912979108715404260==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > So, the approach I see (unless I miss something) would be writing an
> > hwmon-I2C-driver named pmbus-devices.c or so which covers the generic
> > functionality and provides some hooks for manufacturer extensions, if t=
hose are
> > necessary? (Altough I'd hope a number of devices would be covered by the
> > generic driver) Makes sense?
> >=20
> That would be one option. It would require either a register() API call, =
or a table
> of supported chips, or a combination of both, to identify how many channe=
ls
> (or pages, in PMBus terminology) per chip are supported and to identify s=
upported
> objects/registers.

I am missing the details here, i.e. what data is needed to describe a device
and is the data static or can it be retrieved/updated at runtime. A decision
between tables[] or register() or both depends probably on that.

> The other option would be to write separate drivers (one for each chip) a=
nd not provide
> a common infrastructure. Not sure if that is a good idea, though; I perso=
nally prefer
> the first option.

Same here. It will be a lot easier to maintain the code dealing with generic
PMBus commands if it is centralized.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwB5ksACgkQD27XaX1/VRvNVgCeK6vA7jE2V22h1xKfDoijKssV
Oa8An2w89vsBd/Anfmrpjk33jyhV2Ujy
=1Xan
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--


--===============7912979108715404260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7912979108715404260==--
