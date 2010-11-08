From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 08 Nov 2010 16:52:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Check validity of input
Message-Id: <20101108165243.GA17902@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101105165629.112e6df5@endymion.delvare>
In-Reply-To: <20101105165629.112e6df5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 08, 2010 at 07:06:00AM -0500, Davide Rizzo wrote:
> Here it is as requested, against linux-2.6.37-rc1 and including Jeans' last modify.
> 
Davide,

Please check Documentation/SubmittingPatches when submitting patches.

Couple of comments below.

> 2010/11/7 Guenter Roeck <guenter.roeck@ericsson.com<mailto:guenter.roeck@ericsson.com>>
> On Sun, Nov 07, 2010 at 04:11:52AM -0500, Davide Rizzo wrote:
> [ ... ]
> 
> > I already rewrote drivers/hwmon/lm95241.c without macro-generated functions, I posted it to the list a long time ago but nobody cared it.
> > Here it is again (including your corrections).
> > Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com<mailto:elpa.rizzo@gmail.com><mailto:elpa.rizzo@gmail.com<mailto:elpa.rizzo@gmail.com>>>
> > ------------------------------------------------
> >
> Would be great if you could provide a patch on top of Jean's version.
> There were other changes in the driver since the initial version which are
> undone by the complete file, plus it has some unnecessary formatting changes
> and whitespace errors.
> 
> Guenter
> 
> 
> 
> --
> All difficult problems have a simple solution. That is wrong. [A. Einstein]

> Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com>
> ---
> Rewritten without macro-generated functions
> 
> --- linux-2.6.37-rc1/drivers/hwmon/lm95241.c	2010-11-01 12:54:12.000000000 +0100
> +++ linux-2.6.37-rc1.elpa/drivers/hwmon/lm95241.c	2010-11-08 12:58:01.124914446 +0100
> @@ -1,13 +1,11 @@
>  /*
> - * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
> - *             monitoring
> - * Copyright (C) 2008 Davide Rizzo <elpa-rizzo@gmail.com>
> + * drivers/hwmon/lm95241.c

This information is redundant and does not provide any value.

>   *
> - * Based on the max1619 driver. The LM95241 is a sensor chip made by National
> - *   Semiconductors.

It is no longer based on the max1619 driver ?

> - * It reports up to three temperatures (its own plus up to
> - * two external ones). Complete datasheet can be
> - * obtained from National's website at:
> + * Copyright (C) 2009 Davide Rizzo <elpa.rizzo@gmail.com>
> + *
Should probably be 2010 or 2008, 2010.

> + * The LM95241 is a sensor chip made by National Semiconductors.
> + * It reports up to three temperatures (its own plus up to two external ones).
> + * Complete datasheet can be obtained from National's website at:
>   *   http://www.national.com/ds.cgi/LM/LM95241.pdf
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -36,6 +34,8 @@
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
>  
> +#define DEVNAME "lm95241"
> +
>  static const unsigned short normal_i2c[] = {
>  	0x19, 0x2a, 0x2b, I2C_CLIENT_END};
>  
> @@ -100,194 +100,36 @@ struct lm95241_data {
>  	u8 config, model, trutherm;
>  };
>  
> -/* Sysfs stuff */
> -#define show_temp(value) \
> -static ssize_t show_##value(struct device *dev, \
> -    struct device_attribute *attr, char *buf) \
> -{ \
> -	struct lm95241_data *data = lm95241_update_device(dev); \
> -	snprintf(buf, PAGE_SIZE - 1, "%d\n", \
> -		TEMP_FROM_REG(data->value##_h, data->value##_l)); \
> -	return strlen(buf); \
> -}
> -show_temp(local);
> -show_temp(remote1);
> -show_temp(remote2);
> -
> +static ssize_t show_input(struct device *dev, struct device_attribute *attr,
> +	char *buf);
>  static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
> -			 char *buf)
> -{
> -	struct lm95241_data *data = lm95241_update_device(dev);
> -
> -	snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->interval / HZ);
> -	return strlen(buf);
> -}
> -
> +	char *buf);

Good idea to fix those alignments. However, please consider using 

static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
			     char *buf)

ie align with '('. Otherwise there are still two sets of alignments in the code
which doesn't really make it easier to read.

Also,  Idon't think the functions should be moved. As a result, you have to declare 
all functions, since they are used before being defined, plus the diffs get larger
than needed. More on that below.

>  static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
> -			const char *buf, size_t count)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct lm95241_data *data = i2c_get_clientdata(client);
> -
> -	strict_strtol(buf, 10, &data->interval);
> -	data->interval = data->interval * HZ / 1000;
> -
> -	return count;
> -}
> -
> -#define show_type(flag) \
> -static ssize_t show_type##flag(struct device *dev, \
> -				   struct device_attribute *attr, char *buf) \
> -{ \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -	snprintf(buf, PAGE_SIZE - 1, \
> -		data->model & R##flag##MS_MASK ? "1\n" : "2\n"); \
> -	return strlen(buf); \
> -}
> -show_type(1);
> -show_type(2);
> -
> -#define show_min(flag) \
> -static ssize_t show_min##flag(struct device *dev, \
> -    struct device_attribute *attr, char *buf) \
> -{ \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -	snprintf(buf, PAGE_SIZE - 1, \
> -		data->config & R##flag##DF_MASK ?	\
> -		"-127000\n" : "0\n"); \
> -	return strlen(buf); \
> -}
> -show_min(1);
> -show_min(2);
> -
> -#define show_max(flag) \
> -static ssize_t show_max##flag(struct device *dev, \
> -    struct device_attribute *attr, char *buf) \
> -{ \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -	snprintf(buf, PAGE_SIZE - 1, \
> -		data->config & R##flag##DF_MASK ? \
> -		"127000\n" : "255000\n"); \
> -	return strlen(buf); \
> -}
> -show_max(1);
> -show_max(2);
> -
> -#define set_type(flag) \
> -static ssize_t set_type##flag(struct device *dev, \
> -				  struct device_attribute *attr, \
> -				  const char *buf, size_t count) \
> -{ \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -	long val; \
> -	strict_strtol(buf, 10, &val); \
> -\
> -	if ((val = 1) || (val = 2)) { \
> -\
> -		mutex_lock(&data->update_lock); \
> -\
> -		data->trutherm &= ~(TT_MASK << TT##flag##_SHIFT); \
> -		if (val = 1) { \
> -			data->model |= R##flag##MS_MASK; \
> -			data->trutherm |= (TT_ON << TT##flag##_SHIFT); \
> -		} \
> -		else { \
> -			data->model &= ~R##flag##MS_MASK; \
> -			data->trutherm |= (TT_OFF << TT##flag##_SHIFT); \
> -		} \
> -\
> -		data->valid = 0; \
> -\
> -		i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL, \
> -					  data->model); \
> -		i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM, \
> -					  data->trutherm); \
> -\
> -		mutex_unlock(&data->update_lock); \
> -\
> -	} \
> -	return count; \
> -}
> -set_type(1);
> -set_type(2);
> -
> -#define set_min(flag) \
> -static ssize_t set_min##flag(struct device *dev, \
> -	struct device_attribute *devattr, const char *buf, size_t count) \
> -{ \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -	long val; \
> -	strict_strtol(buf, 10, &val); \
> -\
> -	mutex_lock(&data->update_lock); \
> -\
> -	if (val < 0) \
> -		data->config |= R##flag##DF_MASK; \
> -	else \
> -		data->config &= ~R##flag##DF_MASK; \
> -\
> -	data->valid = 0; \
> -\
> -	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
> -		data->config); \
> -\
> -	mutex_unlock(&data->update_lock); \
> -\
> -	return count; \
> -}
> -set_min(1);
> -set_min(2);
> -
> -#define set_max(flag) \
> -static ssize_t set_max##flag(struct device *dev, \
> -	struct device_attribute *devattr, const char *buf, size_t count) \
> -{ \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -	long val; \
> -	strict_strtol(buf, 10, &val); \
> -\
> -	mutex_lock(&data->update_lock); \
> -\
> -	if (val <= 127000) \
> -		data->config |= R##flag##DF_MASK; \
> -	else \
> -		data->config &= ~R##flag##DF_MASK; \
> -\
> -	data->valid = 0; \
> -\
> -	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
> -		data->config); \
> -\
> -	mutex_unlock(&data->update_lock); \
> -\
> -	return count; \
> -}
> -set_max(1);
> -set_max(2);
> -
> -static DEVICE_ATTR(temp1_input, S_IRUGO, show_local, NULL);
> -static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote1, NULL);
> -static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote2, NULL);
> -static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type1, set_type1);
> -static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type2, set_type2);
> -static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min1, set_min1);
> -static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min2, set_min2);
> -static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max1, set_max1);
> -static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max2, set_max2);
> +	const char *buf, size_t count);
> +static ssize_t show_type(struct device *dev, struct device_attribute *attr,
> +	char *buf);
> +static ssize_t show_min(struct device *dev, struct device_attribute *attr,
> +	char *buf);
> +static ssize_t show_max(struct device *dev, struct device_attribute *attr,
> +	char *buf);
> +static ssize_t set_type(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count);
> +static ssize_t set_min(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count);
> +static ssize_t set_max(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count);
> +

It would be better to move DEVICE_ATTR, lm95241_attributes, and lm95241_group
after the actual functions. Then you don't need the static declarations above.

> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL);
> +static DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL);
> +static DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL);
> +static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
> +static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type);
> +static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min);
> +static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min);
> +static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max);
> +static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max);
>  static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
> -		   set_interval);
> +	set_interval);
>  
>  static struct attribute *lm95241_attributes[] = {
>  	&dev_attr_temp1_input.attr,
> @@ -307,6 +149,207 @@ static const struct attribute_group lm95
>  	.attrs = lm95241_attributes,
>  };
>  
> +/* Conversions */
> +static int TempFromReg(u8 val_h, u8 val_l)
> +{
> +	if (val_h & 0x80)
> +		return val_h - 0x100;
> +	return val_h * 1000 + val_l * 1000 / 256;
> +}
> +
> +/* Sysfs stuff */
> +static ssize_t show_input(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	struct lm95241_data *data = lm95241_update_device(dev);
> +	int value;
> +
> +	if (attr = &dev_attr_temp1_input)
> +		value = TempFromReg(data->local_h, data->local_l);
> +	else if (attr = &dev_attr_temp2_input)
> +		value = TempFromReg(data->remote1_h, data->remote1_l);
> +	else
> +		value = TempFromReg(data->remote2_h, data->remote2_l);
> +	snprintf(buf, PAGE_SIZE - 1, "%d\n", value);
> +	return strlen(buf);
> +}
> +
> +static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	struct lm95241_data *data = lm95241_update_device(dev);
> +
> +	snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->interval / HZ);
> +	return strlen(buf);
> +}
> +
> +static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +	unsigned long val;
> +
> +	if (strict_strtol(buf, 10, &val) < 0)
> +		return -EINVAL;
> +
> +	data->interval = val * HZ / 1000;
> +
This accepts negative intervals and converts it to some large positive number.
You might want to use strict_strtoul() instead.

> +	return count;
> +}
> +
> +static ssize_t show_type(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +	if (attr = &dev_attr_temp2_type)
> +		snprintf(buf, PAGE_SIZE - 1,
> +			data->model & R1MS_MASK ? "1\n" : "2\n");
> +	else
> +		snprintf(buf, PAGE_SIZE - 1,
> +			data->model & R2MS_MASK ? "1\n" : "2\n");
> +	return strlen(buf);
> +}
> +
> +static ssize_t show_min(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +	if (attr = &dev_attr_temp2_min)
> +		snprintf(buf, PAGE_SIZE - 1,
> +			data->config & R1DF_MASK ? "-127000\n" : "0\n");
> +	else
> +		snprintf(buf, PAGE_SIZE - 1,
> +			data->config & R2DF_MASK ? "-127000\n" : "0\n");
> +	return strlen(buf);
> +}
> +
> +static ssize_t show_max(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +	if (attr = &dev_attr_temp2_max)
> +		snprintf(buf, PAGE_SIZE - 1,
> +			data->config & R1DF_MASK ? "127000\n" : "255000\n");
> +	else
> +		snprintf(buf, PAGE_SIZE - 1,
> +			data->config & R2DF_MASK ? "127000\n" : "255000\n");
> +	return strlen(buf);
> +}
> +
> +static ssize_t set_type(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +	unsigned long val;
> +
> +	if (strict_strtoul(buf, 10, &val) < 0)
> +		return -EINVAL;
> +
> +	if ((val = 1) || (val = 2)) {

Those extra () are really unnecessary.

> +		int shift;
> +		u8 mask;
> +		if (attr = &dev_attr_temp2_type) {
> +			shift = TT1_SHIFT;
> +			mask = R1MS_MASK;
> +		} else {
> +			shift = TT2_SHIFT;
> +			mask = R2MS_MASK;
> +		}
> +
> +		mutex_lock(&data->update_lock);
> +
> +		data->trutherm &= ~(TT_MASK << shift);
> +		if (val = 1) {
> +			data->model |= mask;
> +			data->trutherm |= (TT_ON << shift);
> +		} else {
> +			data->model &= ~mask;
> +			data->trutherm |= (TT_OFF << shift);
> +		}
> +
> +		data->valid = 0;
> +
> +		i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
> +					  data->model);
> +		i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
> +					  data->trutherm);
> +
> +		mutex_unlock(&data->update_lock);
> +
> +	}
> +	return count;
> +}
> +
> +static ssize_t set_min(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +	long val;
> +	u8 mask;
> +
> +	if (strict_strtol(buf, 10, &val) < 0)
> +		return -EINVAL;
> +
> +	if (attr = &dev_attr_temp2_min)
> +		mask = R1DF_MASK;
> +	else
> +		mask = R2DF_MASK;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (val < 0)
> +		data->config |= mask;
> +	else
> +		data->config &= mask;
> +	data->valid = 0;
> +
> +	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t set_max(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +	long val;
> +	u8 mask;
> +
> +	if (strict_strtol(buf, 10, &val) < 0)
> +		return -EINVAL;
> +
> +	if (attr = &dev_attr_temp2_max)
> +		mask = R1DF_MASK;
> +	else
> +		mask = R2DF_MASK;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (val <= 127000)
> +		data->config |= R1DF_MASK;
> +	else
> +		data->config &= ~R2DF_MASK;
> +	data->valid = 0;
> +
> +	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
>  /* Return 0 if detection is successful, -ENODEV otherwise */
>  static int lm95241_detect(struct i2c_client *new_client,
>  			  struct i2c_board_info *info)
> @@ -322,7 +365,7 @@ static int lm95241_detect(struct i2c_cli
>  	     = MANUFACTURER_ID)
>  	 && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
>  	     >= DEFAULT_REVISION)) {
> -		name = "lm95241";
> +		name = DEVNAME;
>  	} else {
>  		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
>  			address);
> @@ -443,7 +486,7 @@ static struct lm95241_data *lm95241_upda
>  
>  /* Driver data (common to all clients) */
>  static const struct i2c_device_id lm95241_id[] = {
> -	{ "lm95241", 0 },
> +	{ DEVNAME, 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm95241_id);
> @@ -451,7 +494,7 @@ MODULE_DEVICE_TABLE(i2c, lm95241_id);
>  static struct i2c_driver lm95241_driver = {
>  	.class		= I2C_CLASS_HWMON,
>  	.driver = {
> -		.name   = "lm95241",
> +		.name   = DEVNAME,
>  	},
>  	.probe		= lm95241_probe,
>  	.remove		= lm95241_remove,
> @@ -470,9 +513,10 @@ static void __exit sensors_lm95241_exit(
>  	i2c_del_driver(&lm95241_driver);
>  }
>  
> -MODULE_AUTHOR("Davide Rizzo <elpa-rizzo@gmail.com>");
> +MODULE_AUTHOR("Davide Rizzo <elpa.rizzo@gmail.com>");
>  MODULE_DESCRIPTION("LM95241 sensor driver");
>  MODULE_LICENSE("GPL");
>  
>  module_init(sensors_lm95241_init);
>  module_exit(sensors_lm95241_exit);
> +


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
