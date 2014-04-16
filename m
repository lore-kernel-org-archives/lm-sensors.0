From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 16 Apr 2014 08:27:21 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: lm77: Drop function macros
Message-Id: <20140416102721.5e371f59@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397322118-4275-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397322118-4275-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

First of all, the format of the subject line is inconsistent with what
all other patches have.

On Sat, 12 Apr 2014 10:01:57 -0700, Guenter Roeck wrote:
> Function macros make the code harder to read and increase code size,
> so drop them.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm77.c |  155 +++++++++++++++++++++++---------------------------
>  1 file changed, 71 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index 2e0918e..b792898 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -43,16 +43,20 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
>  #define LM77_REG_TEMP_MIN	0x04
>  #define LM77_REG_TEMP_MAX	0x05
>  
> +enum temp_index {
> +	t_input = 0,
> +	t_crit,
> +	t_min,
> +	t_max

A trailing comma would be good to have, in case we ever need to add a
value to this enum.

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
> +	int			temp[4];	/* index using temp_index */
>  	int			temp_hyst;
>  	u8			alarms;
>  };
> @@ -106,19 +110,19 @@ static struct lm77_data *lm77_update_device(struct device *dev)
>  	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>  	    || !data->valid) {
>  		dev_dbg(&client->dev, "Starting lm77 update\n");
> -		data->temp_input > +		data->temp[t_input] >  			LM77_TEMP_FROM_REG(lm77_read_value(client,
>  							   LM77_REG_TEMP));
>  		data->temp_hyst >  			LM77_TEMP_FROM_REG(lm77_read_value(client,
>  							   LM77_REG_TEMP_HYST));
> -		data->temp_crit > +		data->temp[t_crit] >  			LM77_TEMP_FROM_REG(lm77_read_value(client,
>  							   LM77_REG_TEMP_CRIT));
> -		data->temp_min > +		data->temp[t_min] >  			LM77_TEMP_FROM_REG(lm77_read_value(client,
>  							   LM77_REG_TEMP_MIN));
> -		data->temp_max > +		data->temp[t_max] >  			LM77_TEMP_FROM_REG(lm77_read_value(client,
>  							   LM77_REG_TEMP_MAX));
>  		data->alarms > @@ -135,70 +139,56 @@ static struct lm77_data *lm77_update_device(struct device *dev)
>  /* sysfs stuff */
>  
>  /* read routines for temperature limits */

The use of plural here no longer makes sense.

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
> +
> +	return sprintf(buf, "%d\n", data->temp[attr->index]);
>  }
> -static ssize_t show_temp_max_hyst(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> +
> +/* read routines for hysteresis values */

Same here. I'm not sure these comments are really needed anyway, they
do not add much value.

> +static ssize_t show_temp_hyst(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
>  {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm77_data *data = lm77_update_device(dev);
> -	return sprintf(buf, "%d\n", data->temp_max - data->temp_hyst);
> +	return sprintf(buf, "%d\n", data->temp[attr->index] - data->temp_hyst);
>  }
>  
>  /* write routines */
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
> -}
> +static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm77_data *data = i2c_get_clientdata(client);
> +	int reg, err;
> +	long val;
>  
> -set(temp_min, LM77_REG_TEMP_MIN);
> -set(temp_max, LM77_REG_TEMP_MAX);
> +	err = kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	reg = attr->index = t_min ? LM77_REG_TEMP_MIN : LM77_REG_TEMP_MAX;
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp[attr->index] = val;
> +	lm77_write_value(client, reg, LM77_TEMP_TO_REG(val));
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
>  
>  /*
>   * hysteresis is stored as a relative value on the chip, so it has to be
>   * converted first
>   */
> -static ssize_t set_temp_crit_hyst(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> +static ssize_t set_temp_hyst(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     const char *buf, size_t count)
>  {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm77_data *data = i2c_get_clientdata(client);
>  	unsigned long val;
> @@ -209,7 +199,7 @@ static ssize_t set_temp_crit_hyst(struct device *dev,
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp_hyst = data->temp_crit - val;
> +	data->temp_hyst = data->temp[attr->index] - val;
>  	lm77_write_value(client, LM77_REG_TEMP_HYST,
>  			 LM77_TEMP_TO_REG(data->temp_hyst));
>  	mutex_unlock(&data->update_lock);
> @@ -231,11 +221,11 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> -	oldcrithyst = data->temp_crit - data->temp_hyst;
> -	data->temp_crit = val;
> -	data->temp_hyst = data->temp_crit - oldcrithyst;
> +	oldcrithyst = data->temp[t_crit] - data->temp_hyst;
> +	data->temp[t_crit] = val;
> +	data->temp_hyst = data->temp[t_crit] - oldcrithyst;
>  	lm77_write_value(client, LM77_REG_TEMP_CRIT,
> -			 LM77_TEMP_TO_REG(data->temp_crit));
> +			 LM77_TEMP_TO_REG(data->temp[t_crit]));
>  	lm77_write_value(client, LM77_REG_TEMP_HYST,
>  			 LM77_TEMP_TO_REG(data->temp_hyst));
>  	mutex_unlock(&data->update_lock);

set_temp is mostly a special case of set_temp_crit where you don't
adjust the hysteresis value. Don't you think it would make sense to
have a single set function for all 3 limits?

> @@ -250,34 +240,31 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
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
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
> +			  set_temp_crit, t_crit);
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

All the rest looks good.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
