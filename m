From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 10 Mar 2016 03:18:56 +0000
Subject: Re: [lm-sensors] [PATCH 01/13] hwmon: convert lm75 to use devm_thermal_zone_of_sensor_register
Message-Id: <56E0E7A0.2080202@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-2-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-2-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>

On 03/09/2016 01:35 PM, Eduardo Valentin wrote:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/lm75.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 0addc84..69166ab 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -77,7 +77,6 @@ static const u8 LM75_REG_TEMP[3] = {
>   struct lm75_data {
>   	struct i2c_client	*client;
>   	struct device		*hwmon_dev;
> -	struct thermal_zone_device	*tz;
>   	struct mutex		update_lock;
>   	u8			orig_conf;
>   	u8			resolution;	/* In bits, between 9 and 12 */
> @@ -306,11 +305,9 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   	if (IS_ERR(data->hwmon_dev))
>   		return PTR_ERR(data->hwmon_dev);
>
> -	data->tz = thermal_zone_of_sensor_register(data->hwmon_dev, 0,
> -						   data->hwmon_dev,
> -						   &lm75_of_thermal_ops);
> -	if (IS_ERR(data->tz))
> -		data->tz = NULL;
> +	devm_thermal_zone_of_sensor_register(data->hwmon_dev, 0,
> +					     data->hwmon_dev,
> +					     &lm75_of_thermal_ops);
>
>   	dev_info(dev, "%s: sensor '%s'\n",
>   		 dev_name(data->hwmon_dev), client->name);
> @@ -322,7 +319,6 @@ static int lm75_remove(struct i2c_client *client)
>   {
>   	struct lm75_data *data = i2c_get_clientdata(client);
>
> -	thermal_zone_of_sensor_unregister(data->hwmon_dev, data->tz);
>   	hwmon_device_unregister(data->hwmon_dev);
>   	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
>   	return 0;
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
