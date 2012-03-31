From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 31 Mar 2012 03:54:42 +0000
Subject: Re: [lm-sensors] [PATCH v2 05/15] hwmon: mark const init data with __initconst instead of __initdata
Message-Id: <20120331035442.GA23851@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120330200358.GV15647@pengutronix.de>
 <1333137905-13809-5-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1333137905-13809-5-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Mar 30, 2012 at 04:04:55PM -0400, Uwe Kleine-K=F6nig wrote:
> As long as there is no other non-const variable marked __initdata in the
> same compilation unit it doesn't hurt. If there were one however
> compilation would fail with
>=20
> 	error: $variablename causes a section type conflict
>=20
> because a section containing const variables is marked read only and so
> cannot contain non-const variables.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: lm-sensors@lm-sensors.org
> ---
> changes since (implicit) v1:
>  - drop wrong changes to drivers/hwmon/w83627hf.c
>=20
>  drivers/hwmon/w83627ehf.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index a25350c..54922ed 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -2619,15 +2619,15 @@ static struct platform_driver w83627ehf_driver =
=3D {
>  static int __init w83627ehf_find(int sioaddr, unsigned short *addr,
>  				 struct w83627ehf_sio_data *sio_data)
>  {
> -	static const char __initdata sio_name_W83627EHF[] =3D "W83627EHF";
> -	static const char __initdata sio_name_W83627EHG[] =3D "W83627EHG";
> -	static const char __initdata sio_name_W83627DHG[] =3D "W83627DHG";
> -	static const char __initdata sio_name_W83627DHG_P[] =3D "W83627DHG-P";
> -	static const char __initdata sio_name_W83627UHG[] =3D "W83627UHG";
> -	static const char __initdata sio_name_W83667HG[] =3D "W83667HG";
> -	static const char __initdata sio_name_W83667HG_B[] =3D "W83667HG-B";
> -	static const char __initdata sio_name_NCT6775[] =3D "NCT6775F";
> -	static const char __initdata sio_name_NCT6776[] =3D "NCT6776F";
> +	static const char sio_name_W83627EHF[] __initconst =3D "W83627EHF";
> +	static const char sio_name_W83627EHG[] __initconst =3D "W83627EHG";
> +	static const char sio_name_W83627DHG[] __initconst =3D "W83627DHG";
> +	static const char sio_name_W83627DHG_P[] __initconst =3D "W83627DHG-P";
> +	static const char sio_name_W83627UHG[] __initconst =3D "W83627UHG";
> +	static const char sio_name_W83667HG[] __initconst =3D "W83667HG";
> +	static const char sio_name_W83667HG_B[] __initconst =3D "W83667HG-B";
> +	static const char sio_name_NCT6775[] __initconst =3D "NCT6775F";
> +	static const char sio_name_NCT6776[] __initconst =3D "NCT6776F";
> =20
Applied.

Just wondering: Why not the following ?

> +	static const char __initconst sio_name_NCT6776[] =3D "NCT6776F";

It does not make a difference in the generated code, and appears to be
less confusing, at least to me.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
