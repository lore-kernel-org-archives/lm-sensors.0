From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 20 Apr 2014 11:53:19 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/3] hwmon: (lm77) Drop function macros
Message-Id: <20140420135319.1189908a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397711134-10501-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397711134-10501-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 16 Apr 2014 22:05:33 -0700, Guenter Roeck wrote:
> Function macros make the code harder to read and increase code size,
> so drop them.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Fix subject line
>     End last entry of enum temp_index with comma.
>     Also add t_num_entries for number of entries,
>     Use 'static u8 temp_regs[]' array to index registers.
>     and include t_hyst in the enum (and in the temp array).
>     In the register update function, use loop to read
>     all registers.
>     Drop some comments with little or no value.
>     Unify set_temp and set_temp_crit.
> 
>  drivers/hwmon/lm77.c |  192 +++++++++++++++++++++-----------------------------
>  1 file changed, 79 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index 4cd8a513..69f5873 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -43,17 +43,30 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
>  #define LM77_REG_TEMP_MIN	0x04
>  #define LM77_REG_TEMP_MAX	0x05
>  
> +enum temp_index {
> +	t_input = 0,
> +	t_crit,
> +	t_min,
> +	t_max,
> +	t_hyst,
> +	t_num_temp,

Sorry if I become annoying with that, but you don't need the comma
here, as nothing can be added after t_num_temp by definition.

> +};
> +
> +static u8 temp_regs[] = {

You could use [t_num_temp] to guarantee that the size of this array
matches the size of lm77_data.temp. The code in lm77_update_device
assumes that this is the case. You could also declare this array const.

> +	[t_input] = LM77_REG_TEMP,
> +	[t_min] = LM77_REG_TEMP_MIN,
> +	[t_max] = LM77_REG_TEMP_MAX,
> +	[t_crit] = LM77_REG_TEMP_CRIT,
> +	[t_hyst] = LM77_REG_TEMP_HYST,
> +};
> +
>  /* Each client has this additional data */
>  struct lm77_data {
>  	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
>  	char			valid;
>  	unsigned long		last_updated;	/* In jiffies */
> -	int			temp_input;	/* Temperatures */
> -	int			temp_crit;
> -	int			temp_min;
> -	int			temp_max;
> -	int			temp_hyst;
> +	int			temp[t_num_temp];/* index using temp_index */
>  	u8			alarms;
>  };
>  
> @@ -100,27 +113,18 @@ static struct lm77_data *lm77_update_device(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm77_data *data = i2c_get_clientdata(client);
> +	int i;
>  
>  	mutex_lock(&data->update_lock);
>  
>  	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>  	    || !data->valid) {
>  		dev_dbg(&client->dev, "Starting lm77 update\n");
> -		data->temp_input > -			LM77_TEMP_FROM_REG(lm77_read_value(client,
> -							   LM77_REG_TEMP));
> -		data->temp_hyst > -			LM77_TEMP_FROM_REG(lm77_read_value(client,
> -							   LM77_REG_TEMP_HYST));
> -		data->temp_crit > -			LM77_TEMP_FROM_REG(lm77_read_value(client,
> -							   LM77_REG_TEMP_CRIT));
> -		data->temp_min > -			LM77_TEMP_FROM_REG(lm77_read_value(client,
> -							   LM77_REG_TEMP_MIN));
> -		data->temp_max > -			LM77_TEMP_FROM_REG(lm77_read_value(client,
> -							   LM77_REG_TEMP_MAX));
> +		for (i = 0; i < t_num_temp; i++) {
> +			data->temp[i] > +			  LM77_TEMP_FROM_REG(lm77_read_value(client,
> +							     temp_regs[i]));
> +		}
>  		data->alarms >  			lm77_read_value(client, LM77_REG_TEMP) & 0x0007;
>  		data->last_updated = jiffies;
> @@ -134,95 +138,64 @@ static struct lm77_data *lm77_update_device(struct device *dev)
>  
>  /* sysfs stuff */
>  
> -/* read routines for temperature limits */
> -#define show(value)	\
> -static ssize_t show_##value(struct device *dev,			\
> -			    struct device_attribute *attr,	\
> -			    char *buf)				\
> -{								\
> -	struct lm77_data *data = lm77_update_device(dev);	\
> -	return sprintf(buf, "%d\n", data->value);		\
> -}
> -
> -show(temp_input);
> -show(temp_crit);
> -show(temp_min);
> -show(temp_max);
> -
> -/* read routines for hysteresis values */
> -static ssize_t show_temp_crit_hyst(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> +static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
>  {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm77_data *data = lm77_update_device(dev);
> -	return sprintf(buf, "%d\n", data->temp_crit - data->temp_hyst);
> -}
> -static ssize_t show_temp_min_hyst(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	struct lm77_data *data = lm77_update_device(dev);
> -	return sprintf(buf, "%d\n", data->temp_min + data->temp_hyst);

There was a "+" here...

> +
> +	return sprintf(buf, "%d\n", data->temp[attr->index]);
>  }
> -static ssize_t show_temp_max_hyst(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> +
> +static ssize_t show_temp_hyst(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
>  {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm77_data *data = lm77_update_device(dev);
> -	return sprintf(buf, "%d\n", data->temp_max - data->temp_hyst);

... and a "-" here. Your new code has...

> -}
>  
> -/* write routines */
> -#define set(value, reg)	\
> -static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
> -			   const char *buf, size_t count)		\
> -{									\
> -	struct i2c_client *client = to_i2c_client(dev);			\
> -	struct lm77_data *data = i2c_get_clientdata(client);		\
> -	long val;							\
> -	int err = kstrtol(buf, 10, &val);				\
> -	if (err)							\
> -		return err;						\
> -									\
> -	mutex_lock(&data->update_lock);					\
> -	data->value = val;						\
> -	lm77_write_value(client, reg, LM77_TEMP_TO_REG(data->value));	\
> -	mutex_unlock(&data->update_lock);				\
> -	return count;							\
> +	return sprintf(buf, "%d\n",
> +		       data->temp[attr->index] - data->temp[t_hyst]);

... "-" for everyone. This breaks temp1_min_hyst!

You did not notice (and neither did I during my first review), most
probably because temp[1-*]_min_hyst is NOT part of the standard sysfs
API. It's not listed in Documentation/hwmon/sysfs-interface and not
supported by libsensors (and thus can't be supported by "sensors"
either.)

I think we should add this attribute to the standard sysfs API, it is
already implemented by the adt7x10, lm77 and lm92 drivers. And while
we're at it, we could also add temp[1-*]_lcrit_hyst for consistency,
even though no driver appears to implement it yet.

I have patches ready, I'll post them later today for review.

>  }
>  
> -set(temp_min, LM77_REG_TEMP_MIN);
> -set(temp_max, LM77_REG_TEMP_MAX);
> -
> -/*
> - * hysteresis is stored as a relative value on the chip, so it has to be
> - * converted first
> - */
> -static ssize_t set_temp_crit_hyst(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> +static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
>  {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm77_data *data = i2c_get_clientdata(client);
> -	unsigned long val;
> -	int err;
> +	int nr = attr->index;
> +	int err, oldhyst;
> +	long val;
>  
> -	err = kstrtoul(buf, 10, &val);
> +	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp_hyst = data->temp_crit - val;
> -	lm77_write_value(client, LM77_REG_TEMP_HYST,
> -			 LM77_TEMP_TO_REG(data->temp_hyst));
> +	/* preserve hysteresis when setting T_crit */
> +	if (nr = t_crit)
> +		oldhyst = data->temp[nr] - data->temp[t_hyst];
> +	data->temp[nr] = val;
> +	lm77_write_value(client, temp_regs[nr], LM77_TEMP_TO_REG(val));
> +	if (nr = t_crit) {

You could save this comparison by writing the new hysteresis value
first. I think this is acceptable as you can't write both values as the
exact same time anyway, so no matter the order, the hysteresis value
will be wrong/unexpected for a short period of time between the two
writes.

As a side note, I don't think it is such a good idea to preserve the
(absolute) hysteresis value here. I understand we are following the
principle of least surprise, and I may even be the one who requested
that this "feature" is implemented. However, while it does make some
sense for relative, non-shared hysteresis registers, for a shared
relative hysteresis register, this code may actually cause more
confusion than it helps, as it will unexpectedly change the hysteresis
value of the the min and max limits.

In the end the only way to get proper results in all cases is to set
the critical limit first and only then the hysteresis limit. If you do
it the other way around, there is no guarantee that the temporary
hysteresis value can be stored in the chip [1]. So we might as well just
document that (both in the driver's documentation and in
sensors.conf(5)) and get rid of the extra code. I agree this change is
beyond the scope of your patch set though.

[1] This could be fixed by storing the desired hysteresis value in the
driver, but I am not saying we should do it.

> +		data->temp[t_hyst] = data->temp[nr] - oldhyst;
> +		lm77_write_value(client, LM77_REG_TEMP_HYST,
> +				 LM77_TEMP_TO_REG(data->temp[t_hyst]));
> +	}
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
>  
> -/* preserve hysteresis when setting T_crit */
> -static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
> +/*
> + * hysteresis is stored as a relative value on the chip, so it has to be
> + * converted first.
> + */
> +static ssize_t set_temp_hyst(struct device *dev,
> +			     struct device_attribute *devattr,
>  			     const char *buf, size_t count)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm77_data *data = i2c_get_clientdata(client);
> -	int oldcrithyst;
>  	unsigned long val;
>  	int err;
>  
> @@ -231,13 +204,9 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> -	oldcrithyst = data->temp_crit - data->temp_hyst;
> -	data->temp_crit = val;
> -	data->temp_hyst = data->temp_crit - oldcrithyst;
> -	lm77_write_value(client, LM77_REG_TEMP_CRIT,
> -			 LM77_TEMP_TO_REG(data->temp_crit));
> +	data->temp[t_hyst] = data->temp[t_crit] - val;
>  	lm77_write_value(client, LM77_REG_TEMP_HYST,
> -			 LM77_TEMP_TO_REG(data->temp_hyst));
> +			 LM77_TEMP_TO_REG(data->temp[t_hyst]));
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -250,34 +219,31 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
>  }
>  
> -static DEVICE_ATTR(temp1_input, S_IRUGO,
> -		   show_temp_input, NULL);
> -static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
> -		   show_temp_crit, set_temp_crit);
> -static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
> -		   show_temp_min, set_temp_min);
> -static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
> -		   show_temp_max, set_temp_max);
> -
> -static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
> -		   show_temp_crit_hyst, set_temp_crit_hyst);
> -static DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
> -		   show_temp_min_hyst, NULL);
> -static DEVICE_ATTR(temp1_max_hyst, S_IRUGO,
> -		   show_temp_max_hyst, NULL);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp, set_temp,
> +			  t_crit);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
> +			  t_min);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
> +			  t_max);
> +
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst,
> +			  set_temp_hyst, t_crit);
> +static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_temp_hyst, NULL, t_min);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, t_max);
>  
>  static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
>  static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
>  
>  static struct attribute *lm77_attributes[] = {
> -	&dev_attr_temp1_input.attr,
> -	&dev_attr_temp1_crit.attr,
> -	&dev_attr_temp1_min.attr,
> -	&dev_attr_temp1_max.attr,
> -	&dev_attr_temp1_crit_hyst.attr,
> -	&dev_attr_temp1_min_hyst.attr,
> -	&dev_attr_temp1_max_hyst.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>  	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
