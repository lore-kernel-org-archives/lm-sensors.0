From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sun, 11 May 2014 21:04:57 +0000
Subject: Re: [lm-sensors] [PATCH v4 0/2] input: Add new sun4i-ts driver for Allwinner sunxi SoC's rtp control
Message-Id: <20140511210457.GU7047@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8355665772920643030=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1399795586-18919-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1399795586-18919-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org


--===============8355665772920643030==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YSDgblk1kzV93dSz"
Content-Disposition: inline


--YSDgblk1kzV93dSz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, May 11, 2014 at 10:06:24AM +0200, Hans de Goede wrote:
> Hi All,
>=20
> Since Maxime rightfully pointed out an error in my resend of v3, here is =
v4
> with that fixed.
>=20
> Note the second patch which adds hwmon functionality has been reviewed by
> the hwon subsystem maintainer, and the sun?i*.dts changes to enable this
> have already been upstreamed.

For both patches,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--YSDgblk1kzV93dSz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTb+X4AAoJEBx+YmzsjxAgdgIQALhQyVcGDAoLZb0dntVyQJpP
Svw7gqLiPDz6cPEiJC7uW5QQGSv0QMyr67jR6AX9VFkCi9ay05iDTqHsglS7uwzP
My2xvK8Sk8k8HE/VQaLPhkj/maIoXdaRuKD9Yu0SBnr3HEvF0AV9wdjC2eoSrNKK
//pVGfRwfrkqGXf5A6cATTPa24+K0gr+h+Acy8QA1irAJq1mQ417c/KROCCMR4xl
Jfxo0JiU0Rr6uTpnTZ1e7MsXl3IiqLhWoy3MigZ8kgtGpQruUpJLdtYljS591Kwg
24JxTcd/AdYh6Y+g3RRW2uXoQ9a3ZoYwrtruLQvs/IRM6aREIBB+2Upr66SaB/56
+XaUDVL18QN0Gz7PYwWSaTprZijaceCKJzbTMCv/+ZIOcQ/TJBRb6mjebIsxiOjY
kFkmThYoc1AMMzgKAdNyvacW3/vNWi7dZ2lLgsZcWumbK+Th3gUGQdNe06i84z50
QyOqCx7+CZJP4klPQNIaxluIFVt/rx96eN6Kj0R3pCDDC2XdqGvFQ0QUXtFwwZXf
dVVIfaO3E2papwXfa5//Pohxj6gU6Iiv3VdfmDpICOyxUrskCSZKhLYI4vopvlJq
y8la5eSaNSXh+eVq57sX7WP6YJE3+AaKcWkxHvPTOp39aS6nWb6WbJtzBB4d6IRc
XpxfXiLAOVJsPMrwUk+m
=I7Jk
-----END PGP SIGNATURE-----

--YSDgblk1kzV93dSz--


--===============8355665772920643030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8355665772920643030==--
