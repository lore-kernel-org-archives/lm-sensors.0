From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Aug 2013 08:42:17 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <520359E9.1000600@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <1375944991-29182-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1375944991-29182-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/07/2013 11:56 PM, Wei Ni wrote:
> The device lm90 can be controlled by the vdd rail.
> Adding the power control support to power on/off the vdd rail.
> And make sure that power is enabled before accessing the device.
>
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>   drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index cdff742..306a348 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -89,6 +89,7 @@
>   #include <linux/err.h>
>   #include <linux/mutex.h>
>   #include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
>
>   /*
>    * Addresses to scan
> @@ -302,6 +303,7 @@ static const struct lm90_params lm90_params[] = {
>   struct lm90_data {
>   	struct device *hwmon_dev;
>   	struct mutex update_lock;
> +	struct regulator *lm90_reg;
>   	char valid; /* zero until following fields are valid */
>   	unsigned long last_updated; /* in jiffies */
>   	int kind;
> @@ -1391,6 +1393,32 @@ static void lm90_init_client(struct i2c_client *client)
>   		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
>   }
>
> +static void lm90_power_control(struct i2c_client *client, bool is_enable)
> +{
> +	struct lm90_data *data = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (!data->lm90_reg)
> +		return;
> +
> +	mutex_lock(&data->update_lock);
> +

This is only called during probe and remove, so the mutex is unnecessary.

> +	if (is_enable)
> +		ret = regulator_enable(data->lm90_reg);
> +	else
> +		ret = regulator_disable(data->lm90_reg);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Error in %s rail vdd, error %d\n",
> +			(is_enable) ? "enabling" : "disabling", ret);
> +	else
> +		dev_info(&client->dev, "success in %s rail vdd\n",
> +			 (is_enable) ? "enabling" : "disabling");
> +
which reduces the function to (pretty much unnecessary) messages and an if statement
which you only need because you have the function.

You should just call regulator_enable in probe and regulator_disable in remove.

Guenter

> +	mutex_unlock(&data->update_lock);
> +}
> +
>   static int lm90_probe(struct i2c_client *client,
>   		      const struct i2c_device_id *id)
>   {
> @@ -1406,6 +1434,20 @@ static int lm90_probe(struct i2c_client *client,
>   	i2c_set_clientdata(client, data);
>   	mutex_init(&data->update_lock);
>
> +	data->lm90_reg = regulator_get(&client->dev, "vdd");

You should use devm_regulator_get(). Then you also don't need the call to regulator_put().

> +	if (IS_ERR_OR_NULL(data->lm90_reg)) {

The function never returns NULL except if the regulator subsystem is not configured,
so IS_ERR() is more appropriate.

If the regulator subsystem is not configured, you especially don't need or want
to pollute the log with an error message.

> +		if (PTR_ERR(data->lm90_reg) = -ENODEV)
> +			dev_info(&client->dev,
> +				 "No regulator found for vdd. Assuming vdd is always powered.");
> +		else
> +			dev_warn(&client->dev,
> +				 "Error [%ld] in getting the regulator handle for vdd.\n",
> +				 PTR_ERR(data->lm90_reg));

I consider the messages unnecessary and confusing. You are polluting the log
of pretty much every PC user who has one of the supported chips in the system,
and of everyone else not using regulators for this chip.

> +		data->lm90_reg = NULL;

As pointed out, this is unnecessary, and you should handle -EPROBE_DEFER correctly.

> +	}
> +
> +	lm90_power_control(client, true);
> +
>   	/* Set the device type */
>   	data->kind = id->driver_data;
>   	if (data->kind = adm1032) {
> @@ -1473,6 +1515,10 @@ exit_remove_files:
>   	lm90_remove_files(client, data);
>   exit_restore:
>   	lm90_restore_conf(client, data);
> +	lm90_power_control(client, false);
> +	if (data->lm90_reg)
> +		regulator_put(data->lm90_reg);
> +
>   	return err;
>   }
>
> @@ -1483,6 +1529,9 @@ static int lm90_remove(struct i2c_client *client)
>   	hwmon_device_unregister(data->hwmon_dev);
>   	lm90_remove_files(client, data);
>   	lm90_restore_conf(client, data);
> +	lm90_power_control(client, false);
> +	if (data->lm90_reg)
> +		regulator_put(data->lm90_reg);
>
>   	return 0;
>   }
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
