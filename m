From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Oct 2007 08:48:07 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf push nr+1 offset into
Message-Id: <20071014104807.234f2367@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121903r766b4b2ei69c81afab3c1e323@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121903r766b4b2ei69c81afab3c1e323@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jim,

On Fri, 12 Oct 2007 20:03:26 -0600, Jim Cromie wrote:
> patch changes 2 macros to incorporate the +1, and drops the +1 from
> all the callers.
> This also allows a 'reroll' of an expanded loop, and adjusting indexes
> and loop limits
> on another.
>=20
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/hwmon/w83627hf.c |   22 +++++++++++-----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>=20
> this gives a small shrink : 22 bytes on i686
>   12850    2652      36   15538    3cb2 hwmon-hf-1/drivers/hwmon/w83627hf=
.ko
>   12818    2652      36   15506    3c92 hwmon-hf-2/drivers/hwmon/w83627hf=
.ko

Review:

> --- hwmon-hf-1/drivers/hwmon/w83627hf.c	2007-10-12 17:42:11.000000000 -06=
00
> +++ hwmon-hf-2/drivers/hwmon/w83627hf.c	2007-10-12 18:03:23.000000000 -06=
00
> @@ -170,8 +170,8 @@ superio_exit(void)
>  #define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
>  					   (0x550 + (nr) - 7))
> =20
> -#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
> -#define W83781D_REG_FAN(nr) (0x27 + (nr))
> +#define W83781D_REG_FAN_MIN(nr) (0x3b + (nr))
> +#define W83781D_REG_FAN(nr) (0x28 + (nr))

Here again, please rename these W83627HF_* while you're here. Maybe
also tab-align the definitions for readability. I would also appreciate
a comment giving the valid values of nr, just to clear up any possible
confusion.

> =20
>  #define W83781D_REG_TEMP2_CONFIG 0x152
>  #define W83781D_REG_TEMP3_CONFIG 0x252
> @@ -581,7 +581,7 @@ store_fan_min(struct device *dev, struct
> =20
>  	mutex_lock(&data->update_lock);
>  	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
> -	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1),
> +	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr),
>  			     data->fan_min[nr]);
> =20
>  	mutex_unlock(&data->update_lock);
> @@ -823,7 +823,7 @@ store_fan_div(struct device *dev, struct
> =20
>  	/* Restore fan_min */
>  	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
> -	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]=
);
> +	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr), data->fan_min[nr]);
> =20
>  	mutex_unlock(&data->update_lock);
>  	return count;
> @@ -1149,7 +1149,7 @@ static int __devinit w83627hf_probe(stru
>  	struct w83627hf_sio_data *sio_data =3D dev->platform_data;
>  	struct w83627hf_data *data;
>  	struct resource *res;
> -	int err;
> +	int err, i;
> =20
>  	static const char *names[] =3D {
>  		"w83627hf",
> @@ -1183,9 +1183,9 @@ static int __devinit w83627hf_probe(stru
>  	w83627hf_init_device(pdev);
> =20
>  	/* A few vars need to be filled upon startup */
> -	data->fan_min[0] =3D w83627hf_read_value(data, W83781D_REG_FAN_MIN(1));
> -	data->fan_min[1] =3D w83627hf_read_value(data, W83781D_REG_FAN_MIN(2));
> -	data->fan_min[2] =3D w83627hf_read_value(data, W83781D_REG_FAN_MIN(3));
> +	for (i =3D 0; i <=3D 2; i++)
> +		data->fan_min[i] > +			w83627hf_read_value(data, W83781D_REG_FAN_MIN(i=
));

At this point your patch conflicts with one I sent a few days ago:
hwmon: (w83627hf) Fix setting fan min right after driver load
http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommitdi=
ff;h=C09c5184a26158da32801e89d5849d774605f0dd

Please make sure you have this patch applied on your local tree before
regenerating and resending your patch.

> =20
>  	/* Register common device attributes */
>  	if ((err =3D sysfs_create_group(&dev->kobj, &w83627hf_group)))
> @@ -1544,10 +1544,10 @@ static struct w83627hf_data *w83627hf_up
>  			    w83627hf_read_value(data,
>  					       W83781D_REG_IN_MAX(i));
>  		}
> -		for (i =3D 1; i <=3D 3; i++) {
> -			data->fan[i - 1] > +		for (i =3D 0; i <=3D 2; i++) {
> +			data->fan[i] >  			    w83627hf_read_value(data, W83781D_REG_FAN(i));
> -			data->fan_min[i - 1] > +			data->fan_min[i] >  			    w83627hf_read_v=
alue(data,
>  					       W83781D_REG_FAN_MIN(i));
>  		}

Rest looks OK and testing is OK as well.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
