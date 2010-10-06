From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Oct 2010 16:07:09 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: (lm90) Add support for
Message-Id: <20101006180709.068553a2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 5 Oct 2010 08:38:28 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm90.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 92 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 1913f8a..520e4a1 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -151,6 +151,10 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
>  #define MAX6659_REG_R_LOCAL_EMERG	0x17
>  #define MAX6659_REG_W_LOCAL_EMERG	0x17
>  
> +#define LM90_DEF_CONVRATE_RVAL	6	/* Def conversion rate register value */
> +#define LM90_MAX_CONVRATE_RVAL	10	/* Max conversion rate register value */

You shouldn't need this, as each device knows its max value. See below.

> +#define LM90_MAX_CONVRATE_MS	16000	/* Maximum conversion rate in ms */
> +
>  /*
>   * Device flags
>   */
> @@ -197,6 +201,7 @@ struct lm90_params {
>  	u32 flags;		/* Capabilities */
>  	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
>  				/* Upper 8 bits for max6695/96 */
> +	u8 max_convrate;	/* Maximum conversion rate register value */
>  };
>  
>  static const struct lm90_params lm90_params[] = {
> @@ -204,48 +209,59 @@ static const struct lm90_params lm90_params[] = {
>  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
>  		  | LM90_HAVE_BROKEN_ALERT,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 10,
>  	},
>  	[adt7461] = {
>  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
>  		  | LM90_HAVE_BROKEN_ALERT,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 10,
>  	},
>  	[lm86] = {
>  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
>  		.alert_alarms = 0x7b,
> +		.max_convrate = 9,
>  	},
>  	[lm90] = {
>  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
>  		.alert_alarms = 0x7b,
> +		.max_convrate = 9,
>  	},
>  	[lm99] = {
>  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
>  		.alert_alarms = 0x7b,
> +		.max_convrate = 9,
>  	},
>  	[max6646] = {
>  		.flags = LM90_HAVE_LOCAL_EXT,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 6,
>  	},
>  	[max6657] = {
>  		.flags = LM90_HAVE_LOCAL_EXT,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 8,
>  	},
>  	[max6659] = {
>  		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 8,
>  	},
>  	[max6680] = {
>  		.flags = LM90_HAVE_OFFSET,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 7,
>  	},
>  	[max6696] = {
>  		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY
>  		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3,
>  		.alert_alarms = 0x187c,
> +		.max_convrate = 6,
>  	},
>  	[w83l771] = {
>  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
>  		.alert_alarms = 0x7c,
> +		.max_convrate = 8,
>  	},
>  };
>  
> @@ -261,9 +277,13 @@ struct lm90_data {
>  	int kind;
>  	u32 flags;
>  
> +	int update_interval;	/* in milliseconds */
> +
>  	u8 config_orig;		/* Original configuration register value */
> +	u8 convrate_orig;	/* Original conversion rate register value */
>  	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
>  				/* Upper 8 bits for max6695/96 */
> +	u8 max_convrate;	/* Maximum conversion rate */
>  
>  	/* registers values */
>  	s8 temp8[8];	/* 0: local low limit
> @@ -385,15 +405,40 @@ static inline void lm90_select_remote_channel(struct i2c_client *client,
>  	}
>  }
>  
> +/*
> + * Set conversion rate.
> + * client->update_lock must be held when calling this function (unless we are
> + * in detection or initialization steps).
> + */
> +static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
> +			      unsigned int interval)
> +{
> +	int i;
> +	unsigned int update_interval;
> +
> +	/* find the nearest update rate */
> +	for (i = 0, update_interval = LM90_MAX_CONVRATE_MS;
> +	     i < LM90_MAX_CONVRATE_RVAL;
> +	     i++, update_interval >>= 1)
> +		if (i >= data->max_convrate
> +		    || interval >= update_interval * 3 / 4)
> +			break;

Why not just:

	for (i = 0, update_interval = LM90_MAX_CONVRATE_MS;
	     i < data->max_convrate;
	     i++, update_interval >>= 1)
		if (interval >= update_interval * 3 / 4)
			break;

The result is the same as far as I can see, and you avoid an arbitrary
constant.

Note that your algorithm always rounds interval down, even when the
closest integer would be up. Proper rounding would need a different
algorithm to avoid accumulating rounding errors, I think.

As it stands, requesting a 21 ms update interval will lead to a 31.250
ms update interval (register value 0x9), reported as 31 ms through
sysfs, while it should preferably lead to a 15.625 ms update interval
(register value 0xa), currently reported as 15 ms but ideally reported
as 16 ms: this is a 7.375 ms error instead of a 8.250 ms error. You may
decide this is unimportant though, I leave it up to you.

> +
> +	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE, i);
> +	data->update_interval = update_interval;
> +}
> +
>  static struct lm90_data *lm90_update_device(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm90_data *data = i2c_get_clientdata(client);
> +	unsigned long next_update;
>  
>  	mutex_lock(&data->update_lock);
>  
> -	if (time_after(jiffies, data->last_updated + HZ / 2 + HZ / 10)
> -	 || !data->valid) {
> +	next_update = data->last_updated
> +	  + msecs_to_jiffies(data->update_interval) + 1;
> +	if (time_after(jiffies, next_update) || !data->valid) {
>  		u8 h, l;
>  		u8 alarms;
>  
> @@ -828,6 +873,34 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute
>  	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
>  }
>  
> +static ssize_t show_update_interval(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct lm90_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", data->update_interval);
> +}
> +
> +static ssize_t set_update_interval(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm90_data *data = i2c_get_clientdata(client);
> +	unsigned long val;
> +	int err;
> +
> +	err = strict_strtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&data->update_lock);
> +	lm90_set_convrate(client, data, val);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
>  static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp11, NULL, 0, 4);
>  static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp11, NULL, 0, 0);
>  static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp8,
> @@ -859,6 +932,9 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
>  /* Raw alarm file for compatibility */
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
> +		   set_update_interval);
> +
>  static struct attribute *lm90_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
> @@ -879,6 +955,7 @@ static struct attribute *lm90_attributes[] = {
>  	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>  	&dev_attr_alarms.attr,
> +	&dev_attr_update_interval.attr,
>  	NULL
>  };
>  
> @@ -1198,14 +1275,19 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
>  
>  static void lm90_init_client(struct i2c_client *client)
>  {
> -	u8 config;
> +	u8 config, convrate;
>  	struct lm90_data *data = i2c_get_clientdata(client);
>  
> +	if (lm90_read_reg(client, LM90_REG_R_CONVRATE, &convrate) < 0) {
> +		dev_warn(&client->dev, "Failed to read convrate register!\n");
> +		convrate = LM90_DEF_CONVRATE_RVAL;
> +	}
> +	data->convrate_orig = convrate;
> +
>  	/*
>  	 * Start the conversions.
>  	 */
> -	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
> -				  5); /* 2 Hz */
> +	lm90_set_convrate(client, data, 500);	/* 500ms; 2Hz conversion rate */
>  	if (lm90_read_reg(client, LM90_REG_R_CONFIG1, &config) < 0) {
>  		dev_warn(&client->dev, "Initialization failed!\n");
>  		return;
> @@ -1266,6 +1348,9 @@ static int lm90_probe(struct i2c_client *new_client,
>  	/* Set chip capabilities */
>  	data->flags = lm90_params[data->kind].flags;
>  
> +	/* Set maximum conversion rate */
> +	data->max_convrate = lm90_params[data->kind].max_convrate;
> +
>  	/* Initialize the LM90 chip */
>  	lm90_init_client(new_client);
>  
> @@ -1327,6 +1412,8 @@ static int lm90_remove(struct i2c_client *client)
>  	lm90_remove_files(client, data);
>  
>  	/* Restore initial configuration */
> +	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
> +				  data->convrate_orig);
>  	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
>  				  data->config_orig);
>  

Except for the implementation details of the algorithm in
lm90_set_convrate(), this patch looks very good to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
