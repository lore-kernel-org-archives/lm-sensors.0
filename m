From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 24 Feb 2015 19:21:55 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/8] thermal: Provide stub for thermal_of_cooling_device_register() funct
Message-Id: <20150224192153.GH3448@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7654642438736868245=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-2-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424254056-5904-2-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============7654642438736868245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 11:07:29AM +0100, Lukasz Majewski wrote:
> Odroid U3 fan can work without being registered as OF cooling device
> (with CONFIG_THERMAL_OF disabled).
> In this situation it can be controlled via PWM entry at
> /sys/class/hwmon/hwmon0/pwm1.
>=20
> Therefore, the thermal_of_cooling_device_register() function needs a stub
> to allow clean compilation.


I've just applied a patch on this same matter from Nishanth Menon [1].
Can you please check if his patch is enough for you?

[1] -
https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git=
/commit/?h=3Dfixes&id=3D12ca7188468ee29c4e717f73db4bf43c90954fc7


>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> Changes for v3:
> - Provide stub declaration when CONFIG_THERMAL is not set
> Changes for v4:
> - None
> ---
>  include/linux/thermal.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index fc52e30..eacf2de 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -293,6 +293,20 @@ struct thermal_trip {
>  };
> =20
>  /* Function declarations */
> +#ifdef CONFIG_THERMAL
> +struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np,
> +				   char *type, void *devdata,
> +				   const struct thermal_cooling_device_ops *);
> +#else
> +static inline struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np,
> +				   char *type, void *devdata,
> +				   const struct thermal_cooling_device_ops *ops)
> +{
> +	return NULL;
> +}
> +#endif
>  #ifdef CONFIG_THERMAL_OF
>  struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
> @@ -328,9 +342,6 @@ void thermal_zone_device_update(struct thermal_zone_d=
evice *);
> =20
>  struct thermal_cooling_device *thermal_cooling_device_register(char *, v=
oid *,
>  		const struct thermal_cooling_device_ops *);
> -struct thermal_cooling_device *
> -thermal_of_cooling_device_register(struct device_node *np, char *, void =
*,
> -				   const struct thermal_cooling_device_ops *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *na=
me);
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long =
*temp);
> --=20
> 2.0.0.rc2
>=20

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7M9JAAoJEMLUO4d9pOJWFSMH/R+mWWsAlavMW/k1jl96Zfhg
Q/1L/t7qI3S4wINkeFSi9O/DmW0FpYvpERNIWcNrLy7OQfr37EfvPU3VTfj1ZOud
dnA0Xl5ow26yQLig6MEHKmhHV+/pJsUseQZ0a/5/NgfkDwni4UPLhShUKnpf5jpy
W+/tV82qKK7WJt46ibWtRHM/sv8dAMmhnvIKkAyGvLUYv6osBa2tpCPZdJZct0+b
ZfkM7+m9fSX63IPD3muZ6yZx8SjrBJyb+mTbJAWKAusDnZzBYTxNlnm/tuJdArSC
7nR8DtPbXpBtgB1ubLn1sZcegtE+ElhltnZxe8xdoOBuWCe+IkWPXB0/tJgb+sk=
=jx5d
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--


--===============7654642438736868245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7654642438736868245==--
