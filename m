From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 31 Dec 2013 13:00:06 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20131231130006.GW3144@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6431521931171400151=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
 <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
 <20131228011304.GB14188@core.coreip.homeip.net>
In-Reply-To: <20131228011304.GB14188-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org


--===============6431521931171400151==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gYb7txo4D4wAJl1C"
Content-Disposition: inline


--gYb7txo4D4wAJl1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 27, 2013 at 05:13:04PM -0800, Dmitry Torokhov wrote:
> On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
> > =20
> > +Optional properties:
> > + - ts-attached: boolean set this to tell the driver that an actual tou=
chscreen
> > +		is attached and that it should register an input device,
> > +		without this it only registers the builtin temperate sensor
>=20
> I believe the guidance is to avoid describing kernel behavior in DT
> property so I think it should say:
>=20
>  - ts-attached: boolean indicating that an actual touchscreen is
> 		attached to the controller.

Custom properties are also supposed to be prefixed by the vendor prefix.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--gYb7txo4D4wAJl1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSwr/WAAoJEBx+YmzsjxAgVREP/0cS00tQL1OSIrumc7kc7qoL
isG0BabTcOaUFbGv+UCwkLNhru8zGZ0ryhRCNuJ1w+90XFIJyBElnbZmL3rJBzOD
SAfw2jICczVbz+6ujcrY3NiGxAMdXzEgu38QTJYH0h9EkW/P8wCwno+QFJrv//rX
jRqgydYqTX96p4GnMSdektnVzD+808JwjjGBDuMeAmgpeTKEShPnMxJJ59uFspjv
kvu9CpnNZr9J7aPETmp+fEXyquoN+TRB02NoeFkNnhYTNIwYzsiUJ4+0dTtQaWws
2+yxb5FAK9XZKs0Pas3uC0yQkJu9Bq03mFi/7SuTD2r6BCdUFPVc8kv8zALQQcqv
ZhrfY5FQE/TLENmzWjpRT9HheIOv7Zph6uNSF8IZhXlGu4bEnwBorvtLKLtmIXD4
tc44umt9VUJEW6xbymLNxHfqHGJ7w6spyza2otJ3KaNGwXDp//wu9QuMh5lKkzWh
tnfF2TmdjUQQtdpodOop3n3Rr0ZV1Y1BjGnc6AUJrsbx6TvudSfvEYexxL9lQCDT
W8ygfdnudzeqZmeEq6YL/90h0J2aETlOHn/rO4La0m9Bwo6pJjz7okIOKFdpNJdw
mI8IDKfFFwiSPVKSeX+mdJWAo74EwAcvDvM5n+PtYb2rXA0p+jLblzAcRz0zUb6M
dD/h38e/uyHX8R6WSv2W
=k8hh
-----END PGP SIGNATURE-----

--gYb7txo4D4wAJl1C--


--===============6431521931171400151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6431521931171400151==--
