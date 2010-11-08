From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 08 Nov 2010 22:54:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Check validity of input
Message-Id: <20101108225400.GA25988@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101105165629.112e6df5@endymion.delvare>
In-Reply-To: <20101105165629.112e6df5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 08, 2010 at 01:22:38PM -0500, Davide Rizzo wrote:
> Here it is again, including your corrections.
> Please note that most of the function declarations cannot be omitted.
> 
Part of the reasons for suggesting to look at the SubmittingPatches
file were rules #2, #7, and #11/#15. Specifically, not to use attachments
and to use an appropriate subject. It isn't really a good idea to attach 
this exchange to a different subject.

Anyway, this is getting worse, not better. I dislike the notion of using 
the attribute address to distinguish sensors (which is causing the requirement
for forward declarations). I prefer the more common method of using SENSOR_DEVICE_ATTR 
and passing the register offset or some other means of distinguishing sensors 
to the function. For example, one could use an array instead of separate variable 
names to identify the sensors in lm95241_data, and then simply index the sensors
using SENSOR_DEVICE_ATTR.

But maybe that is just my personal view. Jean, any comments from your side ?

Guenter

> --
> All difficult problems have a simple solution. That is wrong. [A. Einstein]

> Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com>
> ---
> Rewritten without macro-generated functions
> 
> --- linux-2.6.37-rc1/drivers/hwmon/lm95241.c	2010-11-01 12:54:12.000000000 +0100
> +++ linux-2.6.37-rc1.elpa/drivers/hwmon/lm95241.c	2010-11-08 19:16:35.873755269 +0100
> @@ -1,13 +1,9 @@
>  /*
> - * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
> - *             monitoring
> - * Copyright (C) 2008 Davide Rizzo <elpa-rizzo@gmail.com>
> + * Copyright (C) 2008, 2010 Davide Rizzo <elpa.rizzo@gmail.com>
>   *
> - * Based on the max1619 driver. The LM95241 is a sensor chip made by National
> - *   Semiconductors.
> - * It reports up to three temperatures (its own plus up to
> - * two external ones). Complete datasheet can be
> - * obtained from National's website at:
> + * The LM95241 is a sensor chip made by National Semiconductors.
> + * It reports up to three temperatures (its own plus up to two external ones).
> + * Complete datasheet can be obtained from National's website at:
>   *   http://www.national.com/ds.cgi/LM/LM95241.pdf
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -36,6 +32,8 @@
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
>  
> +#define DEVNAME "lm95241"
> +
>  static const unsigned short normal_i2c[] = {
>  	0x19, 0x2a, 0x2b, I2C_CLIENT_END};
>  
> @@ -83,10 +81,6 @@ static const unsigned short normal_i2c[]
>  #define TEMP_FROM_REG(val_h, val_l) (((val_h) & 0x80 ? (val_h) - 0x100 : \
>      (val_h)) * 1000 + (val_l) * 1000 / 256)
>  
> -/* Functions declaration */
> -static void lm95241_init_client(struct i2c_client *client);
> -static struct lm95241_data *lm95241_update_device(struct device *dev);
> -
>  /* Client data (each client gets its own) */
>  struct lm95241_data {
>  	struct device *hwmon_dev;
> @@ -100,23 +94,254 @@ struct lm95241_data {
>  	u8 config, model, trutherm;
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
> +static struct lm95241_data *lm95241_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + data->interval) ||
> +	    !data->valid) {
> +		dev_dbg(&client->dev, "Updating lm95241 data.\n");
> +		data->local_h > +			i2c_smbus_read_byte_data(client,
> +						 LM95241_REG_R_LOCAL_TEMPH);
> +		data->local_l > +			i2c_smbus_read_byte_data(client,
> +						 LM95241_REG_R_LOCAL_TEMPL);
> +		data->remote1_h > +			i2c_smbus_read_byte_data(client,
> +						 LM95241_REG_R_REMOTE1_TEMPH);
> +		data->remote1_l > +			i2c_smbus_read_byte_data(client,
> +						 LM95241_REG_R_REMOTE1_TEMPL);
> +		data->remote2_h > +			i2c_smbus_read_byte_data(client,
> +						 LM95241_REG_R_REMOTE2_TEMPH);
> +		data->remote2_l > +			i2c_smbus_read_byte_data(client,
> +						 LM95241_REG_R_REMOTE2_TEMPL);
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static ssize_t show_input(struct device *dev, struct device_attribute *attr,
> +			  char *buf);
> +
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL);
> +static DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL);
> +static DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL);
> +
>  /* Sysfs stuff */
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
> +static ssize_t show_input(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct lm95241_data *data = lm95241_update_device(dev);
> +	int value;
>  
> -static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
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
> +static ssize_t show_type(struct device *dev, struct device_attribute *attr,
> +			 char *buf);
> +static ssize_t set_type(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count);
> +
> +static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
> +static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type);
> +
> +static ssize_t show_type(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
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
> +static ssize_t set_type(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +	unsigned long val;
> +
> +	if (strict_strtoul(buf, 10, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val = 1 || val = 2) {
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
> +static ssize_t show_min(struct device *dev, struct device_attribute *attr,
> +			char *buf);
> +static ssize_t set_min(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count);
> +
> +static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min);
> +static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min);
> +
> +static ssize_t show_min(struct device *dev, struct device_attribute *attr,
> +			char *buf)
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
> +static ssize_t set_min(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
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
> +static ssize_t show_max(struct device *dev, struct device_attribute *attr,
> +			char *buf);
> +static ssize_t set_max(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count);
> +
> +static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max);
> +static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max);
> +
> +static ssize_t show_max(struct device *dev, struct device_attribute *attr,
> +			char *buf)
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
> +static ssize_t set_max(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
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
> +static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
>  	struct lm95241_data *data = lm95241_update_device(dev);
>  
>  	snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->interval / HZ);
> @@ -124,168 +349,20 @@ static ssize_t show_interval(struct devi
>  }
>  
>  static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
> -			const char *buf, size_t count)
> +			    const char *buf, size_t count)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm95241_data *data = i2c_get_clientdata(client);
> +	unsigned long val;
> +
> +	if (strict_strtoul(buf, 10, &val) < 0)
> +		return -EINVAL;
>  
> -	strict_strtol(buf, 10, &data->interval);
> -	data->interval = data->interval * HZ / 1000;
> +	data->interval = val * HZ / 1000;
>  
>  	return count;
>  }
>  
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
>  static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
>  		   set_interval);
>  
> @@ -322,7 +399,7 @@ static int lm95241_detect(struct i2c_cli
>  	     = MANUFACTURER_ID)
>  	 && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
>  	     >= DEFAULT_REVISION)) {
> -		name = "lm95241";
> +		name = DEVNAME;
>  	} else {
>  		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
>  			address);
> @@ -334,6 +411,26 @@ static int lm95241_detect(struct i2c_cli
>  	return 0;
>  }
>  
> +static void lm95241_init_client(struct i2c_client *client)
> +{
> +	struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +	data->interval = HZ;    /* 1 sec default */
> +	data->valid = 0;
> +	data->config = CFG_CR0076;
> +	data->model = 0;
> +	data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
> +
> +	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
> +				  data->config);
> +	i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,
> +				  R1FE_MASK | R2FE_MASK);
> +	i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
> +				  data->trutherm);
> +	i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
> +				  data->model);
> +}
> +
>  static int lm95241_probe(struct i2c_client *new_client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -373,26 +470,6 @@ exit:
>  	return err;
>  }
>  
> -static void lm95241_init_client(struct i2c_client *client)
> -{
> -	struct lm95241_data *data = i2c_get_clientdata(client);
> -
> -	data->interval = HZ;    /* 1 sec default */
> -	data->valid = 0;
> -	data->config = CFG_CR0076;
> -	data->model = 0;
> -	data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
> -
> -	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
> -				  data->config);
> -	i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,
> -				  R1FE_MASK | R2FE_MASK);
> -	i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
> -				  data->trutherm);
> -	i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
> -				  data->model);
> -}
> -
>  static int lm95241_remove(struct i2c_client *client)
>  {
>  	struct lm95241_data *data = i2c_get_clientdata(client);
> @@ -404,46 +481,9 @@ static int lm95241_remove(struct i2c_cli
>  	return 0;
>  }
>  
> -static struct lm95241_data *lm95241_update_device(struct device *dev)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct lm95241_data *data = i2c_get_clientdata(client);
> -
> -	mutex_lock(&data->update_lock);
> -
> -	if (time_after(jiffies, data->last_updated + data->interval) ||
> -	    !data->valid) {
> -		dev_dbg(&client->dev, "Updating lm95241 data.\n");
> -		data->local_h > -			i2c_smbus_read_byte_data(client,
> -						 LM95241_REG_R_LOCAL_TEMPH);
> -		data->local_l > -			i2c_smbus_read_byte_data(client,
> -						 LM95241_REG_R_LOCAL_TEMPL);
> -		data->remote1_h > -			i2c_smbus_read_byte_data(client,
> -						 LM95241_REG_R_REMOTE1_TEMPH);
> -		data->remote1_l > -			i2c_smbus_read_byte_data(client,
> -						 LM95241_REG_R_REMOTE1_TEMPL);
> -		data->remote2_h > -			i2c_smbus_read_byte_data(client,
> -						 LM95241_REG_R_REMOTE2_TEMPH);
> -		data->remote2_l > -			i2c_smbus_read_byte_data(client,
> -						 LM95241_REG_R_REMOTE2_TEMPL);
> -		data->last_updated = jiffies;
> -		data->valid = 1;
> -	}
> -
> -	mutex_unlock(&data->update_lock);
> -
> -	return data;
> -}
> -
>  /* Driver data (common to all clients) */
>  static const struct i2c_device_id lm95241_id[] = {
> -	{ "lm95241", 0 },
> +	{ DEVNAME, 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm95241_id);
> @@ -451,7 +491,7 @@ MODULE_DEVICE_TABLE(i2c, lm95241_id);
>  static struct i2c_driver lm95241_driver = {
>  	.class		= I2C_CLASS_HWMON,
>  	.driver = {
> -		.name   = "lm95241",
> +		.name   = DEVNAME,
>  	},
>  	.probe		= lm95241_probe,
>  	.remove		= lm95241_remove,
> @@ -470,9 +510,10 @@ static void __exit sensors_lm95241_exit(
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
