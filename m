From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 24 Feb 2015 19:37:13 +0000
Subject: Re: [lm-sensors] [PATCH v4 5/8] ARM: dts: Add properties to use pwm-fan device as a cooling device i
Message-Id: <20150224193711.GA353@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0204846075636865673=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-6-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424254056-5904-6-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============0204846075636865673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 11:07:33AM +0100, Lukasz Majewski wrote:
> With those bindings it is possible to use pwm-fan device available in
> Odroid U3 as a cooling device.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - Rename cooling-pwm-values property to cooling-levels
> Changes for v3:
> - Change patch's topic to "ARM dts"
> - Reduce maximal cooling-level to 230 from 255
> Changes for v4:
> - None
> ---
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 33 +++++++++++++++++++++++++=
+++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dt=
s/exynos4412-odroidu3.dts
> index 60bd1e4..3e5df3e 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -32,11 +32,42 @@
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
>  		status =3D "okay";
>  	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {


This thermal zone misses the mandatory properties as per=20
 Documentation/devicetree/bindings/thermal/thermal.txt

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
> +	};
>  };
> =20
>  &pwm {
> --=20
> 2.0.0.rc2
>=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7NLeAAoJEMLUO4d9pOJWPR0H/iwmIou90qFFRLOerb+N8B3U
4vUB/xpRTChTV3Y7MriVzBWsVpVFbqBgvtDcYiXAOQon0sm2TL1x3uSXIFyc0Q5R
YjwuSHHHvgOSJqNXjcAE9LAozko1L6wHUppvQ0+T82uqKoC8/MbEX1VzIxGT4JrT
7QrPMUEtgJcHWWrUHLg+VDpk1dPJ46hLwEqPHhk7jtTR0mNr7IDEPlvWms7docSp
svVn9xW0UGG+PJXX35+uerEdRkVJ3yCH4wX88oiw5IF/UNo8t/jkEK/ksUHp89wc
42jVRtfQrgiLtVCthquS+dPIbmOkDyToLbeTqQwIqZ2iOLGJpv9R2SV9QHQpGx0=
=m1tq
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


--===============0204846075636865673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0204846075636865673==--
