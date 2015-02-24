From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 24 Feb 2015 19:21:11 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/8] thermal: Provide stub for thermal_cdev_update() function
Message-Id: <20150224192109.GG3448@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2730318764562901271=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-3-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424254056-5904-3-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============2730318764562901271==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 11:07:30AM +0100, Lukasz Majewski wrote:
> Odroid U3 fan can work without being registered as OF cooling device
> (with CONFIG_THERMAL{_OF|} disabled).
> In this situation it can be controlled via PWM entry at
> /sys/class/hwmon/hwmon0/pwm1.
>=20
> Therefore, the thermal_cdev_update() function needs a stub
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
> - New patch
> Changes for v3:
> - thermal_cdev_update() now depends on CONFIG_THERMAL flag
> Changes for v4:
> - None
> ---
>  include/linux/thermal.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index eacf2de..25382e6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -298,6 +298,7 @@ struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np,
>  				   char *type, void *devdata,
>  				   const struct thermal_cooling_device_ops *);
> +void thermal_cdev_update(struct thermal_cooling_device *);
>  #else
>  static inline struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np,
> @@ -306,6 +307,9 @@ thermal_of_cooling_device_register(struct device_node=
 *np,
>  {
>  	return NULL;
>  }
> +static inline void thermal_cdev_update(struct thermal_cooling_device *cd=
ev)
> +{
> +}
>  #endif
>  #ifdef CONFIG_THERMAL_OF
>  struct thermal_zone_device *
> @@ -349,7 +353,6 @@ int thermal_zone_get_temp(struct thermal_zone_device =
*tz, unsigned long *temp);
>  int get_tz_trend(struct thermal_zone_device *, int);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device=
 *,
>  		struct thermal_cooling_device *, int);
> -void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
> =20
>  #ifdef CONFIG_NET
> --=20
> 2.0.0.rc2
>=20

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7M8aAAoJEMLUO4d9pOJW8k4H/jEF+Q+GzlaavuULZiqwHnyU
Zzl4V4x/LhdTTUlmZD5VttjW+1YUTiYu/DFOss9RHiXGYRwiUJWypztt3SxtbC0x
q4qdNxEd+6k0zE7c+9xTgBfiE+0MtdKxijUCMEG55XWvZO3IJuNLeNDIA6mU2gkD
fQr0Hda1GTaLINcwJef/9V+K1lYCgi87d1HZ0BFeRmib5CJ5V1sco+oSmeax5J1U
IwN1OKG5BB3sO6bQEyFpcBwIjKe3b1JorLu4Ib32F7ZxED04EcOktJ4wKmHNH7XT
vmCqPpRX0t3c8tntIJxAkIgwEdWKvViDZXFJbclgTY83ZON7F0HVjimRihnU7dM=
=YtLR
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--


--===============2730318764562901271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2730318764562901271==--
