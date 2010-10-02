From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 02 Oct 2010 18:32:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for
Message-Id: <20101002203250.773e1c3a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 17 Sep 2010 21:01:48 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> This patch depends on the function reordering patch submitted earlier.
> 
>  drivers/hwmon/lm90.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 84 insertions(+), 5 deletions(-)

I was about to test this patch on my ADM1032 evaluation board, and
suddenly realized that my new motherboard lacks a parallel port. Bummer.

> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 302d9eb..569f6be 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -104,6 +104,13 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
>  	max6646, w83l771, max6696 };
>  
>  /*
> + * Maximum supported conversion rate register values per chip.
> + * If multiple register values reflect the fastest supported conversion rate,
> + * provide the lower value.
> + */
> +static u8 max_convrates[] = { 9, 10, 9, 9, 8, 8, 10, 7, 6, 8, 6 };

Should be const. Anyway I don't like this approach, as the order here
has to be the same as the order of enum chips or everything breaks, but
this isn't spelled out anywhere. Remember that you changed that order
not so long ago, it might happen again someday... I think it is overall
too fragile. This is also inconsistent with the way data->alert_alarms
is set in lm90_probe().

I think we want to come up with a unified way to set per-chip
attributes, and stick to it. This could either be done with switch/case
in lm90_probe(), as we already have, or using a chips-indexed array of
property structures.

> +
> +/*
>   * The LM90 registers
>   */
>  
> @@ -201,7 +208,10 @@ struct lm90_data {
>  	int kind;
>  	int flags;
>  
> +	int update_interval;	/* in milliseconds  */

Double space at end of comment.

> +
>  	u8 config_orig;		/* Original configuration register value */
> +	u8 convrate_orig;	/* Original conversion rate */

Might be a good idea to mention in the comment that this is a register
value.

>  	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
>  				/* Upper 8 bits for max6695/96 */
>  
> @@ -325,15 +335,44 @@ static inline void lm90_select_remote_channel(struct i2c_client *client,
>  	}
>  }
>  
> +/* Update Intervals */
> +static const unsigned int update_intervals[] = {
> +	16000, 8000, 4000, 2000, 1000, 500, 250, 125, 62, 31, 15, 7,
> +};

These are 12 values, but the maximum value in max_convrates is 10?

Not sure about the last values, 1000/64 is 15.625 which would rather
round up to 16, and 1000/128 is 7.8125 which would round up to 8.

I'm also not sure if there's really a point in having this array at all,
BTW, given that the values in it can be easily be computed.

Also lacks a reminder of the unit in use, if you decide to keep this
array.

> +
> +/*
> + * Set conversion rate.
> + * client->update_lock must be held when calling this function (unless we are
> + * in detection or initialization steps).
> + */
> +static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
> +			      int interval)

interval is passed as an unsigned int.

> +{
> +	int i;
> +
> +	/* find the nearest update rate from the table */
> +	for (i = 0; i < ARRAY_SIZE(update_intervals) - 1; i++) {
> +		if (interval >= update_intervals[i]
> +		    || i >= max_convrates[data->kind])

This algorithm doesn't actually give you the nearest update rate. It
gives you the immediately lesser supported value. To get the nearest
supported value, you would have to compare with (update_intervals[i] +
update_intervals[i + 1]) / 2. Your current algorithm would give 8000 ms
is the user asks for 15000 ms, while 16000 ms is arguably a better
match.

I would also suggest testing i >= max_convrates[data->kind] first, as a
safety measure.

> +			break;
> +	}
> +	/* if not found, we point to the last entry (lowest update rate) */

I fail to see how this could happen, as i >= max_convrates[data->kind]
will always trigger.

> +
> +	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE, i);
> +	data->update_interval = update_intervals[i];
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
> +	  + msecs_to_jiffies(data->update_interval) + HZ / 10;

We probably want to reconsider this HZ / 10. 100 ms on top of 500 ms
wasn't too noticeable. 100 ms on top of 31 ms or even 16 ms is way too
much.

> +	if (time_after(jiffies, next_update) || !data->valid) {
>  		u8 h, l;
>  		u8 alarms;
>  
> @@ -768,6 +807,35 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute
>  	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
>  }
>  
> +static ssize_t show_update_interval(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm90_data *data = i2c_get_clientdata(client);

This can be simplified to:

	struct lm90_data *data = dev_get_drvdata(dev);

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
> @@ -799,6 +867,9 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
>  /* Raw alarm file for compatibility */
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
> +		   set_update_interval);
> +
>  static struct attribute *lm90_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
> @@ -819,6 +890,7 @@ static struct attribute *lm90_attributes[] = {
>  	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>  	&dev_attr_alarms.attr,
> +	&dev_attr_update_interval.attr,
>  	NULL
>  };
>  
> @@ -1138,14 +1210,19 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
>  
>  static void lm90_init_client(struct i2c_client *client)
>  {
> -	u8 config;
> +	u8 config, convrate;
>  	struct lm90_data *data = i2c_get_clientdata(client);
>  
> +	if (lm90_read_reg(client, LM90_REG_R_CONVRATE, &convrate) < 0) {
> +		dev_warn(&client->dev, "Failed to read convrate register!\n");
> +		convrate = 6;
> +	}
> +	data->convrate_orig = convrate;
> +
>  	/*
>  	 * Start the conversions.
>  	 */
> -	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
> -				  5); /* 2 Hz */
> +	lm90_set_convrate(client, data, 500);	/* 500ms; 2Hz conversion rate */

Why? The only reason why we were setting the conversion rate before was
so that it was in line with the hard-coded cache lifetime. Now that the
rate can be changed dynamically, I'd rather leave the refresh rate
alone, assuming that the chip default or BIOS setting is correct.

>  	if (lm90_read_reg(client, LM90_REG_R_CONFIG1, &config) < 0) {
>  		dev_warn(&client->dev, "Initialization failed!\n");
>  		return;
> @@ -1296,6 +1373,8 @@ static int lm90_remove(struct i2c_client *client)
>  	lm90_remove_files(client, data);
>  
>  	/* Restore initial configuration */
> +	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
> +				  data->convrate_orig);
>  	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
>  				  data->config_orig);
>  


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
