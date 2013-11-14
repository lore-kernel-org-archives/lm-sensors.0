From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Nov 2013 12:38:11 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/3] hwmon: (lm90) Add power control
Message-Id: <20131114133811.5ad651a7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381137940-22608-1-git-send-email-wni@nvidia.com>
	<1381137940-22608-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1381137940-22608-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Mon, 7 Oct 2013 17:25:38 +0800, Wei Ni wrote:
> The device lm90 can be controlled by the vcc rail.
> Adding the regulator support to power on/off the vcc rail.
> Enable the "vcc" regulator before accessing the device.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Overall it looks good. I've also tested all the lm90 patches with my
ADM1032 evaluation board and did not notice any regression, so things
are looking good.

Two style comments:

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index cdff742..3f51680 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -89,6 +89,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
>  
>  /*
>   * Addresses to scan
> @@ -302,6 +303,7 @@ static const struct lm90_params lm90_params[] = {
>  struct lm90_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
> +	struct regulator *lm90_reg;

The lm90_ prefix is totally redundant here.

>  	char valid; /* zero until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  	int kind;
> @@ -1397,8 +1399,20 @@ static int lm90_probe(struct i2c_client *client,
>  	struct device *dev = &client->dev;
>  	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
>  	struct lm90_data *data;
> +	struct regulator *reg;

I don't like the use of "reg" as an abbreviation of "regulator",
because "reg" is very commonly used as an abbreviation of "register" in
device drivers, including hwmon drivers, and in particular in the lm90
driver. So this can lead to confusion. I prefer that "regulator" is
spelled out fully, it's not that long and there are a limited number of
occurrences.

>  	int err;
>  
> +	reg = devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	err = regulator_enable(reg);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"Failed to enable regulator: %d\n", err);
> +		return err;
> +	}
> +
>  	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> @@ -1406,6 +1420,8 @@ static int lm90_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
>  
> +	data->lm90_reg = reg;
> +
>  	/* Set the device type */
>  	data->kind = id->driver_data;
>  	if (data->kind = adm1032) {
> @@ -1473,6 +1489,8 @@ exit_remove_files:
>  	lm90_remove_files(client, data);
>  exit_restore:
>  	lm90_restore_conf(client, data);
> +	regulator_disable(data->lm90_reg);
> +
>  	return err;
>  }
>  
> @@ -1483,6 +1501,7 @@ static int lm90_remove(struct i2c_client *client)
>  	hwmon_device_unregister(data->hwmon_dev);
>  	lm90_remove_files(client, data);
>  	lm90_restore_conf(client, data);
> +	regulator_disable(data->lm90_reg);
>  
>  	return 0;
>  }

I'll clean this up myself before submission, no need to resend.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
