From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Nov 2014 14:17:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) put chip into shutdown mode on shutdown
Message-Id: <545B830F.2020002@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1415282432-3256-1-git-send-email-michael.thalmeier@hale.at>
In-Reply-To: <1415282432-3256-1-git-send-email-michael.thalmeier@hale.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Thalmeier <michael.thalmeier@hale.at>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11/06/2014 06:00 AM, Michael Thalmeier wrote:
> In addition to going into shutdown mode on suspend also go into shutdown mode
> on system shutdown. This way we can save a few mA when the main CPU is powered
> off and the lm75 is still powered but not used any more.
>
You can do this in a more comprehensive way using SIMPLE_DEV_PM_OPS.

Guenter

> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>   drivers/hwmon/lm75.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 7ec5ccd..d860af9 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -433,10 +433,10 @@ static int lm75_detect(struct i2c_client *new_client,
>   }
>
>   #ifdef CONFIG_PM
> -static int lm75_suspend(struct device *dev)
> +
> +static int _lm75_shutdown(struct i2c_client *client)
>   {
>   	int status;
> -	struct i2c_client *client = to_i2c_client(dev);
>   	status = lm75_read_value(client, LM75_REG_CONF);
>   	if (status < 0) {
>   		dev_dbg(&client->dev, "Can't read config? %d\n", status);
> @@ -447,6 +447,18 @@ static int lm75_suspend(struct device *dev)
>   	return 0;
>   }
>
> +static void lm75_shutdown(struct i2c_client *client)
> +{
> +	_lm75_shutdown(client);
> +}
> +
> +static int lm75_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return _lm75_shutdown(client);
> +}
> +
>   static int lm75_resume(struct device *dev)
>   {
>   	int status;
> @@ -466,8 +478,10 @@ static const struct dev_pm_ops lm75_dev_pm_ops = {
>   	.resume		= lm75_resume,
>   };
>   #define LM75_DEV_PM_OPS (&lm75_dev_pm_ops)
> +#define LM75_SHUTDOWN_OP lm75_shutdown
>   #else
>   #define LM75_DEV_PM_OPS NULL
> +#define LM75_SHUTDOWN_OP NULL
>   #endif /* CONFIG_PM */
>
>   static struct i2c_driver lm75_driver = {
> @@ -478,6 +492,7 @@ static struct i2c_driver lm75_driver = {
>   	},
>   	.probe		= lm75_probe,
>   	.remove		= lm75_remove,
> +	.shutdown	= LM75_SHUTDOWN_OP,
>   	.id_table	= lm75_ids,
>   	.detect		= lm75_detect,
>   	.address_list	= normal_i2c,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
