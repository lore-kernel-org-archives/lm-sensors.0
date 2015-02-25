From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 25 Feb 2015 19:11:24 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/6] Documentation: dts: Documentation entry to explain how to use PWM FA
Message-Id: <20150225191123.GA2950@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7774529659350993207=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-2-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424878462-15511-2-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============7774529659350993207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 04:34:17PM +0100, Lukasz Majewski wrote:
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
> Changes for v5:
> - Move thermal-zones description to example section
> - Extending example section
>=20
> ---
>  .../devicetree/bindings/hwmon/pwm-fan.txt          | 25 ++++++++++++++++=
+++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Docume=
ntation/devicetree/bindings/hwmon/pwm-fan.txt
> index 610757c..645251b 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -3,10 +3,33 @@ Bindings for a fan connected to the PWM lines
>  Required properties:
>  - compatible	: "pwm-fan"
>  - pwms		: the PWM that is used to control the PWM fan
> +- cooling-levels      : PWM duty cycle values in a range from 0 to 255
> +			which correspond to thermal cooling states
> =20
>  Example:
> -	pwm-fan {
> +	fan0: pwm-fan {
>  		compatible =3D "pwm-fan";
>  		status =3D "okay";
>  		pwms =3D <&pwm 0 10000 0>;
> +		cooling-levels =3D <0 102 170 230>;
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +		cooling-min-state =3D <0>;
> +		cooling-max-state =3D <3>;
> +		#cooling-cells =3D <2>;
> +		trips {
> +			cpu_alert1: cpu-alert1 {
> +				temperature =3D <100000>; /* millicelsius */
> +				hysteresis =3D <2000>; /* millicelsius */
> +				type =3D "passive";
> +			};
> +		};
> +		cooling-maps {
> +			map0 {
> +			     trip =3D <&cpu_alert1>;
> +			     cooling-device =3D <&fan0 0 1>;
> +			};
> +		};

The above example has two issues:
(1) it is wrong, as the cooling device properties are in the thermal
zone node.
(2) has a misalignment / tabulation

Can you please fix that in your next version too?

>  	};
> --=20
> 2.0.0.rc2
>=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7h5RAAoJEMLUO4d9pOJW3M8IAIfcZq2UgPAy317hFkquG8KQ
+ge+5pVttPu1PSMU6CVy/I2lX0Hm2b5rWedLlLvR6+KTuGWkjjsCWj6Qiz5j/2Cy
sX4tUkZNYKsapaD14TXIHA/e1/tbwgHkqC/grggvsGtN3iiQYYJ+51EmLq0qkYFt
s1u+VjhPlzDdJn93uH5GNLY0W3tPngt3EkYxWmz/4pHofzwlWatOyHGzenv4Cx/f
Qnrb2vEWiBi1/eKurmTwcpe6dfBJLzeMpWkS6m+2JXbokdV0a+Qo4NkYvNg7Sfbl
5HjTdFv9th3tEO7mwhSqZQ1SwnToPhcOC+SCCQikd4sDHfl19Zl5y9G+IWCXL+s=
=m5Ze
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


--===============7774529659350993207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7774529659350993207==--
