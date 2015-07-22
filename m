From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jul 2015 16:36:23 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: lm92: Add devicetree support
Message-Id: <55AFC687.9020007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437582620-2294-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1437582620-2294-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?windows-1252?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On 07/22/2015 09:30 AM, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---

i2c drivers do not need explicit devicetree support.

Guenter

>   drivers/hwmon/lm92.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index cfaf70b..a1e10cd 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -44,6 +44,7 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/mutex.h>
> +#include <linux/of.h>
>   #include <linux/jiffies.h>
>
>   /*
> @@ -386,6 +387,13 @@ static int lm92_probe(struct i2c_client *new_client,
>    * Module and driver stuff
>    */
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id lm92_of_match[] = {
> +	{ .compatible = "national,lm92", },
> +};
> +MODULE_DEVICE_TABLE(of, lm92_of_match);
> +#endif
> +
>   static const struct i2c_device_id lm92_id[] = {
>   	{ "lm92", 0 },
>   	/* max6635 could be added here */
> @@ -397,6 +405,7 @@ static struct i2c_driver lm92_driver = {
>   	.class		= I2C_CLASS_HWMON,
>   	.driver = {
>   		.name	= "lm92",
> +		.of_match_table = of_match_ptr(lm92_of_match),
>   	},
>   	.probe		= lm92_probe,
>   	.id_table	= lm92_id,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
