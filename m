From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 06 Jan 2014 11:00:25 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20140106110025.GQ3144@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8485953158507616494=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1388506852-3548-1-git-send-email-hdegoede@redhat.com>
 <1388506852-3548-3-git-send-email-hdegoede@redhat.com>
 <52C84665.5070203@roeck-us.net>
In-Reply-To: <52C84665.5070203-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


--===============8485953158507616494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cnn+CxJy/uys8v1I"
Content-Disposition: inline


--cnn+CxJy/uys8v1I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Sat, Jan 04, 2014 at 09:35:33AM -0800, Guenter Roeck wrote:
> On 12/31/2013 08:20 AM, Hans de Goede wrote:
> >The sun4i resisitive touchscreen controller also comes with a built-in
> >temperature sensor. This commit adds support for it.
> >
> >This commit also introduces a new "ts-attached" device-tree property,
> >when this is not set, the input part of the driver won't register. This =
way
> >the internal temperature sensor can be used to measure the SoC temperatu=
re
> >independent of there actually being a touchscreen attached to the contro=
ller.
> >
> >Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Couple of minor comments below, though no need to resubmit unless someone=
 else has comments.
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>=20
> >---
> >  .../bindings/input/touchscreen/sun4i.txt           |   5 +
> >  drivers/input/touchscreen/sun4i-ts.c               | 140 +++++++++++++=
+++-----
> >  2 files changed, 114 insertions(+), 31 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.t=
xt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> >index e45927e..6bac67b 100644
> >--- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> >+++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> >@@ -6,10 +6,15 @@ Required properties:
> >   - reg: mmio address range of the chip
> >   - interrupts: interrupt to which the chip is connected
> >
> >+Optional properties:
> >+ - allwinner,ts-attached: boolean indicating that an actual touchscreen=
 is
> >+			  attached to the controller
> >+
> Brr. While I understand that you were asked to do this, I don't
> really see the benefit of another "allwinner" here. As if this
> wasn't implied by the "compatible" property.

It's actually the ePAPR that recommends this.

Section 6.1.1, General Principles

"
Some recommended practices includes:
[..]
  5. If new properties are needed by the binding, the recommended
     format for property names is: =E2=80=9C<company>,<property-name>=E2=80=
=9D, where
     <company> is an OUI or short unique string like a stock ticker
     that identifies the creator of the binding.
"

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--cnn+CxJy/uys8v1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSyozJAAoJEBx+YmzsjxAgjU0P/RIYTx1rAGb1hvM+wlF73kIS
nebYQNz7z9/KJbmgqCPF2XRC1NQmL3t2//evAgVrQ9jTqzW6USJ0Erw17YZswWl8
nPgL35OqRAxdqOFOug1VMxX3EW2+Q6Khi6VSz4Cg9G17K64nsgkIO4a40OUIaEOS
XdVvdygoNJCN7HO9WxMMe9vbrib2qMZ+UjrO6+YLUK91rQkZB22vWj0/EblUEwj9
GgCQT3pibzS+AG2xq8GQ4RJJc3bE5GO3BQ6mP/xazI1KOip0cGxanMqYgjhmfPR2
dGSb+6rvAZSkkQaXsDj6uVOZu2KtOSqTGXYYcHeFzBJcvHJ7nr6PbRiNucOsDtlG
G1wX4m+94eQMPNtYC4/55Av/TICfF/icZ9Rx2Dz50Uom3Z7QgxbJ1S5oXKdX5j/h
qe+52Olpp2/G320SrdaMt/7Zt7g2t/GJw9G6GY1KuGwoHrQwAlLLkVy6l4ja6dKF
+QryIOjH9J64bvsjPhM5VxCeFpCVxJByjC8pPx6Dbco6QNfPwADVLz5g0hTw1HAY
7ZWXFEwPCkLdJmKc8ZQVwM65AQx5eB6eQBJ+o21KFTK0G8BS68Q1d+mxFwkIlnKP
8ZI+atbPNXiJgOv15aUcpCqc9Vbk4rLzztXex3t1fm/spVJz66If1WXjbLZ/Ugzf
bmswACwgVxopKv4zA8To
=SFGh
-----END PGP SIGNATURE-----

--cnn+CxJy/uys8v1I--


--===============8485953158507616494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8485953158507616494==--
