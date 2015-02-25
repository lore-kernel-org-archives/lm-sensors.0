From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 25 Feb 2015 18:49:17 +0000
Subject: Re: [lm-sensors] [PATCH v5 3/6] ARM: dts: Add properties to use pwm-fan device as a cooling device i
Message-Id: <20150225184914.GF2306@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1280661543961879850=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-4-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424878462-15511-4-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============1280661543961879850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 04:34:19PM +0100, Lukasz Majewski wrote:
> With those bindings it is possible to use pwm-fan device available in
> Odroid U3 as a cooling device.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
> Changes for v2:
> - Rename cooling-pwm-values property to cooling-levels
> Changes for v3:
> - Change patch's topic to "ARM dts"
> - Reduce maximal cooling-level to 230 from 255
> Changes for v4:
> - None
> Changes for v5:
> - None
> ---
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 33 +++++++++++++++++++++++++=
+++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dt=
s/exynos4412-odroidu3.dts
> index 4c04837..abcfa3c 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -32,9 +32,40 @@
>  		};
>  	};
> =20
> -	pwm-fan {
> +	fan0: pwm-fan {
>  		compatible =3D "pwm-fan";
>  		pwms =3D <&pwm 0 10000 0>;
> +		cooling-min-state =3D <0>;
> +		cooling-max-state =3D <3>;
> +		#cooling-cells =3D <2>;
> +		cooling-levels =3D <0 102 170 230>;
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				     trip =3D <&cpu_alert1>;
> +				     cooling-device =3D <&cpu0 7 7>;
> +				};
> +				map1 {
> +				     trip =3D <&cpu_alert2>;
> +				     cooling-device =3D <&cpu0 13 13>;
> +				};
> +				map2 {
> +				     trip =3D <&cpu_alert0>;
> +				     cooling-device =3D <&fan0 0 1>;
> +				};
> +				map3 {
> +				     trip =3D <&cpu_alert1>;
> +				     cooling-device =3D <&fan0 1 2>;
> +				};
> +				map4 {
> +				     trip =3D <&cpu_alert2>;
> +				     cooling-device =3D <&fan0 2 3>;
> +				};
> +			};
> +		};
>  	};
>  };
> =20
> --=20
> 2.0.0.rc2
>=20

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hkjAAoJEMLUO4d9pOJWiKMIAJjWBv/CyV5+Zi5W8+cbna4P
kqlNOKLVit8KArv7/oIsd1A546GmHjlr9e+Si+VrIoaTy6VR2bmb7xnbne2iBjxM
npc/iy93Fm4kFgtrhE2AkArR62pVVBRln8OcxVRtJSgUWdzNWORmIgTiu20iF96U
F1i+9Evy7z9+qsUwS8+e5WvAI/+82upbwwb7yKjQg6KbHOfEk4idDQHzm/nNJJR/
BXARxmzpUlPW68tyn1M6sMt6l6P8qW7O+T5HwAaSXLhYs3F6aXB1/vRmGVSkTWJP
ufMNpraa+MtLkM/Z2aQt1lKHSqIborsiZ96nPDdbfSqsdLWO+SNNVNyqxUA0bKs=
=JciM
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--


--===============1280661543961879850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1280661543961879850==--
