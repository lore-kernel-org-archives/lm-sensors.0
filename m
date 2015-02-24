From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 24 Feb 2015 19:25:21 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/8] Documentation: dts: Documentation entry to explain how to use PWM FA
Message-Id: <20150224192520.GI3448@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5567079599865925830=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-4-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424254056-5904-4-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============5567079599865925830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 11:07:31AM +0100, Lukasz Majewski wrote:
> Explanation of several properties, which allow PWM fan working as a cooli=
ng
> device, have been embraced in this commit.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - Rename cooling-pwm-values to cooling-levels
> - Remove default-pulse-width property and stick to default hwmon policy
> Changes for v3:
> - Changing commit title from "hwmon: dts: Doc:" to "Documentation: dts"
> - Remove unnecessary properties
> - Set maximal cooling level to 230 instead of 255
> Changes for v4:
> - None
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 20 +++++++++++++++=
+++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Docume=
ntation/devicetree/bindings/hwmon/pwm-fan.txt
> index 610757c..d53fe0c 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -3,10 +3,30 @@ Bindings for a fan connected to the PWM lines
>  Required properties:
>  - compatible	: "pwm-fan"
>  - pwms		: the PWM that is used to control the PWM fan
> +- cooling-levels      : PWM duty cycle values in a range from 0 to 255
> +			which correspond to thermal cooling states
> +
> +Thorough description of the following bindings:
> +		cooling-min-state =3D <0>;
> +		cooling-max-state =3D <3>;
> +		#cooling-cells =3D <2>;
> +		thermal-zone {
> +			cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				     trip =3D <&cpu_alert1>;
> +				     cooling-device =3D <&fan0 0 1>;
> +				};
> +			};
> +		};

I am fine if you leave the reference to thermal.txt biding description,
but I would prefer if you move the above lines to a proper example section.

> +
> +for PWM FAN used as cooling device can be found at:
> +./Documentation/devicetree/bindings/thermal/thermal.txt
> =20
>  Example:
>  	pwm-fan {
>  		compatible =3D "pwm-fan";
>  		status =3D "okay";
>  		pwms =3D <&pwm 0 10000 0>;
> +		cooling-levels =3D <0 102 170 230>;
>  	};
> --=20
> 2.0.0.rc2
>=20

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7NAWAAoJEMLUO4d9pOJWCAIH/0f3Y2wm25mlIgWvVB1zPEyD
357D2o77MaVTOrsHBB4qZ39/xZczRM2+MJkj4J2jS1Jc5vvdeRdJ9eRHsoxwTvma
0Prhw8dBHi7yzBLYefeBtsVuraHc3P6V8QXQhhnBgF0W4PIXT749KWoXPXc55f+q
E1sk3Hp4TBm5SinUescBz+vktBglHYTmn/4RAW/ieZJmc5U4CwJ1bh692GNesONK
E3jYbiuLjm9VbI5erVoZeF3MACMiulLpalZegBRmgl8izSq/OZpchXI7UnLa5Uxu
ZccUBJLDXxMQRYOOvufaaA4WoEAMQvt0vN415+ragHYsuvqGHlqF6/BEIagylVM=
=2ODY
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--


--===============5567079599865925830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5567079599865925830==--
