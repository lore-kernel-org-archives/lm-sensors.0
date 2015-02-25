From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 25 Feb 2015 18:24:51 +0000
Subject: Re: [lm-sensors] [PATCH v5 6/6] hwmon: pwm-fan: Code for using PWM FAN as a cooling device
Message-Id: <20150225182449.GA2306@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8851930867121854011=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-7-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424878462-15511-7-git-send-email-l.majewski@samsung.com>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============8851930867121854011==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Lukasz,

On Wed, Feb 25, 2015 at 04:34:22PM +0100, Lukasz Majewski wrote:
> The PWM FAN device can now be used as a thermal cooling device. Necessary
> infrastructure has been added in this commit.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - Replace pwm_fan_cooling_states with pwm_fan_cooling_levels
> - Update ctx->pwm_fan_state when correct data from device tree is availab=
le
> - Using therma_cdev_update() when thermal is ready for controlling the fan
> Changes for v3:
> - Rename patch heading
> - pwm_fan_of_get_cooling_data() now returns -EINVAL when no "cooling-leve=
ls"
>   property defined
> - register of cooling device only when proper cooling data is present
> Changes for v4:
> - None
> Changes for v5:
> - Check for IS_ENABLED(CONFIG_THERMAL) has been added to prevent from
>   executing thermal_* specific functions
> ---
>  drivers/hwmon/pwm-fan.c | 83 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index e6ed353..2c1a8f0 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/sysfs.h>
> +#include <linux/thermal.h>
> =20
>  #define MAX_PWM 255
> =20
> @@ -68,6 +69,17 @@ exit_set_pwm_err:
>  	return ret;
>  }
> =20
> +static void pwm_fan_update_state(struct pwm_fan_ctx *ctx, unsigned long =
pwm)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ctx->pwm_fan_max_state; ++i)
> +		if (pwm < ctx->pwm_fan_cooling_levels[i + 1])
> +			break;
> +
> +	ctx->pwm_fan_state =3D i;
> +}
> +
>  static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
>  		       const char *buf, size_t count)
>  {
> @@ -82,6 +94,7 @@ static ssize_t set_pwm(struct device *dev, struct devic=
e_attribute *attr,
>  	if (ret)
>  		return ret;
> =20
> +	pwm_fan_update_state(ctx, pwm);
>  	return count;
>  }
> =20
> @@ -103,6 +116,59 @@ static struct attribute *pwm_fan_attrs[] =3D {
> =20
>  ATTRIBUTE_GROUPS(pwm_fan);
> =20
> +/* thermal cooling device callbacks */
> +static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
> +				 unsigned long *state)
> +{
> +	struct pwm_fan_ctx *ctx =3D cdev->devdata;
> +

Why this call back is the only one you didn't add a check for ctx =3D=3D
NULL?

> +	*state =3D ctx->pwm_fan_max_state;
> +
> +	return 0;
> +}
> +
> +static int pwm_fan_get_cur_state(struct thermal_cooling_device *cdev,
> +				 unsigned long *state)
> +{
> +	struct pwm_fan_ctx *ctx =3D cdev->devdata;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	*state =3D ctx->pwm_fan_state;
> +
> +	return 0;
> +}
> +
> +static int
> +pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long=
 state)
> +{
> +	struct pwm_fan_ctx *ctx =3D cdev->devdata;
> +	int ret;
> +
> +	if (!ctx || (state > ctx->pwm_fan_max_state))
> +		return -EINVAL;
> +
> +	if (state =3D=3D ctx->pwm_fan_state)
> +		return 0;
> +
> +	ret =3D __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
> +	if (ret) {
> +		dev_err(&cdev->device, "Cannot set pwm!\n");
> +		return ret;
> +	}
> +
> +	ctx->pwm_fan_state =3D state;
> +
> +	return ret;
> +}
> +
> +static const struct thermal_cooling_device_ops pwm_fan_cooling_ops =3D {
> +	.get_max_state =3D pwm_fan_get_max_state,
> +	.get_cur_state =3D pwm_fan_get_cur_state,
> +	.set_cur_state =3D pwm_fan_set_cur_state,
> +};
> +
>  int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *=
ctx)
>  {
>  	struct device_node *np =3D dev->of_node;
> @@ -145,8 +211,9 @@ int pwm_fan_of_get_cooling_data(struct device *dev, s=
truct pwm_fan_ctx *ctx)
> =20
>  static int pwm_fan_probe(struct platform_device *pdev)
>  {
> -	struct device *hwmon;
> +	struct thermal_cooling_device *cdev;
>  	struct pwm_fan_ctx *ctx;
> +	struct device *hwmon;
>  	int duty_cycle;
>  	int ret;
> =20
> @@ -193,6 +260,20 @@ static int pwm_fan_probe(struct platform_device *pde=
v)
>  	if (ret)
>  		return ret;
> =20
> +	ctx->pwm_fan_state =3D ctx->pwm_fan_max_state;
> +	if (IS_ENABLED(CONFIG_THERMAL)) {
> +		cdev =3D thermal_of_cooling_device_register(pdev->dev.of_node,
> +							  "pwm-fan", ctx,
> +							  &pwm_fan_cooling_ops);


I know this is a PITA, but thermal subsystem still does not use devm
based helpers. That means, you need to be old school and unregister the
device yourself.

Please add the cdev to ctx structure:
+		ctx->cdev =3D cdev;

and add a call for:
	thermal_cooling_device_unregister(ctx->cdev);

in static int pwm_fan_remove(struct platform_device *pdev)


despite the above two minor issues, you may add my
Acked-by: Eduardo Valentin <edubezval@gmail.com>

> +		if (IS_ERR(cdev)) {
> +			dev_err(&pdev->dev,
> +				"Failed to register pwm-fan as cooling device");
> +			pwm_disable(ctx->pwm);
> +			return PTR_ERR(cdev);
> +		}
> +		thermal_cdev_update(cdev);
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.0.0.rc2
>=20

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hNoAAoJEMLUO4d9pOJW6GkH/3S/Tygk7teSdp3qo+TpLAXj
QRlcKAxPCJ6eBivA1ZgujhGtx4/Pg9kZpKCbYLgO6zLsvwHzRmSEQATrq5ojjm9G
8Jz97P0bMiF9WTXB5NPCMz5eJfPge9zxzltnJV91rxQx0WzBZYyBaZo4OSwUt54l
K8OkFxz/qWhGMRznmeHiqMHFnr5Fml5K0Zk1JACofFNxuwv6Q7SJNbHYdqZXwFcW
2/8nu/eM3U23+sBZKIbIfOe0sfgZ9hM39PYWF5lUThX9ott+86oBRCkIEHli6lkw
zyVrGM4SBrA+jR2y5uQa6y2TQ54lGJXItzfSPKGoUXpVwVO3kCByALBkBnGlWcA=
=X2x7
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


--===============8851930867121854011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8851930867121854011==--
