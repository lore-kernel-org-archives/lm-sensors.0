From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Oct 2008 08:58:34 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Expose Operating System Key in
Message-Id: <20081015105834.342a85bc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1223318477-25365-1-git-send-email-agraf@suse.de>
In-Reply-To: <1223318477-25365-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Alexander,

I don't know a thing about the applesmc driver, so just a few random
comments. Nicolas being the maintainer of this driver, his approval is
needed before your patch can go upstream anyway.

On Mon,  6 Oct 2008 20:41:17 +0200, Alexander Graf wrote:
> The AppleSMC is used for various tasks. It allows control over fans,
> the backlight, invokes the acceleration interrupt and stores a key,
> that is used to decrypt binaries on Mac OS X.
>=20
> This key is necessary to receive when virtualizing Mac OS X, but
> may not be distributed due to copyright restrictions.
>=20
> This patch makes reading this key easy by exporting it via sysfs.
>=20
> Signed-off-by: Alexander Graf <agraf@suse.de>
> Cc: Nicolas Boichat <nicolas@boichat.ch>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Ren=E9 Rebe <rene@exactcode.de>
> ---
>  drivers/hwmon/applesmc.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index b06b8e0..655e217 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -61,6 +61,9 @@
>  #define LIGHT_SENSOR_RIGHT_KEY	"ALV1" /* r-o {alv (6 bytes) */
>  #define BACKLIGHT_KEY		"LKSB" /* w-o {lkb (2 bytes) */
> =20
> +#define OSK0_KEY		"OSK0" /* r-o ascii (32 bytes) */
> +#define OSK1_KEY		"OSK1" /* r-o ascii (32 bytes) */
> +
>  #define CLAMSHELL_KEY		"MSLD" /* r-o ui8 (unused) */
> =20
>  #define MOTION_SENSOR_X_KEY	"MO_X" /* r-o sp78 (2 bytes) */
> @@ -548,6 +551,31 @@ out:
>  		return snprintf(sysfsbuf, PAGE_SIZE, "(%d,%d)\n", left, right);
>  }
> =20
> +static ssize_t applesmc_osk_show(struct device *dev,
> +				struct device_attribute *attr, char *sysfsbuf)
> +{
> +	int ret;
> +	u8 osk0[33];
> +	u8 osk1[33];
> +
> +	osk0[32] =3D '\0';
> +	osk1[32] =3D '\0';
> +
> +	mutex_lock(&applesmc_lock);
> +
> +	ret =3D applesmc_read_key(OSK0_KEY, osk0, 32);
> +	if (ret)
> +		goto out;
> +	ret =3D applesmc_read_key(OSK1_KEY, osk1, 32);
> +
> +out:
> +	mutex_unlock(&applesmc_lock);
> +	if (ret)
> +		return ret;
> +	else
> +		return snprintf(sysfsbuf, PAGE_SIZE, "%s%s\n", osk0, osk1);
> +}
> +
>  /* Displays degree Celsius * 1000 */
>  static ssize_t applesmc_show_temperature(struct device *dev,
>  			struct device_attribute *devattr, char *sysfsbuf)
> @@ -935,6 +963,7 @@ static const struct attribute_group accelerometer_att=
ributes_group >  	{ .attrs =3D accelerometer_attributes };
> =20
>  static DEVICE_ATTR(light, 0444, applesmc_light_show, NULL);
> +static DEVICE_ATTR(osk, 0444, applesmc_osk_show, NULL);

If this key "may not be distributed due to copyright restrictions" then
is is OK to expose it to all users? Shouldn't the mode be 0440 or even
0400?

> =20
>  static DEVICE_ATTR(key_count, 0444, applesmc_key_count_show, NULL);
>  static DEVICE_ATTR(key_at_index, 0644,
> @@ -1386,6 +1415,10 @@ static int __init applesmc_init(void)
>  			goto out_light_wq;
>  	}
> =20
> +	ret =3D sysfs_create_file(&pdev->dev.kobj, &dev_attr_osk.attr);
> +	if (ret)
> +		goto out_osk;
> +

The applesmc driver cleanly removes all the sysfs files it created in
case of error and at removal time. So you must do the same for this new
file you're introducing.

>  	hwmon_dev =3D hwmon_device_register(&pdev->dev);
>  	if (IS_ERR(hwmon_dev)) {
>  		ret =3D PTR_ERR(hwmon_dev);
> @@ -1397,6 +1430,7 @@ static int __init applesmc_init(void)
>  	return 0;
> =20
>  out_light_ledclass:
> +out_osk:
>  	if (applesmc_light)
>  		led_classdev_unregister(&applesmc_backlight);
>  out_light_wq:


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
