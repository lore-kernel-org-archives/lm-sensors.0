From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 22:14:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Rewritten without using
Message-Id: <1289340866.22931.304.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
In-Reply-To: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2010-11-09 at 04:33 -0500, Davide Rizzo wrote:
> From: Davide Rizzo <elpa.rizzo@gmail.com>
> 
> Rewriting of driver/hwmon/lm95241.c to avoid using macros
> Now it uses SENSOR_DEVICE_ATTR to distinguish similar attr.
> Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com>
> ---
> 
Hi Davide,

this looks much better, and gives me a chance for a more complete
review. Please see below.

Unfortunately, I got hit with the MS Exchange server bug, meaning I can
not apply your patch. So I might still miss something. Next time please
copy lkml - that will give me a chance to retrieve the patch from
patchwork.kernel.org.

Thanks,
Guenter

> --- linux-2.6.37-rc1/drivers/hwmon/lm95241.c    2010-11-01
> 12:54:12.000000000 +0100
> +++ linux-2.6.37-rc1.elpa/drivers/hwmon/lm95241.c    2010-11-09
> 10:00:47.464820382 +0100
> @@ -1,13 +1,9 @@
>  /*
> - * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
> - *             monitoring
> - * Copyright (C) 2008 Davide Rizzo <elpa-rizzo@gmail.com>
> + * Copyright (C) 2008, 2010 Davide Rizzo <elpa.rizzo@gmail.com>
>   *
> - * Based on the max1619 driver. The LM95241 is a sensor chip made by
> National
> - *   Semiconductors.
> - * It reports up to three temperatures (its own plus up to
> - * two external ones). Complete datasheet can be
> - * obtained from National's website at:
> + * The LM95241 is a sensor chip made by National Semiconductors.
> + * It reports up to three temperatures (its own plus up to two
> external ones).
> + * Complete datasheet can be obtained from National's website at:
>   *   http://www.national.com/ds.cgi/LM/LM95241.pdf
>   *
>   * This program is free software; you can redistribute it and/or
> modify
> @@ -36,6 +32,8 @@
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
>  
> +#define DEVNAME "lm95241"
> +
>  static const unsigned short normal_i2c[] = {
>      0x19, 0x2a, 0x2b, I2C_CLIENT_END};
>  
> @@ -79,14 +77,6 @@ static const unsigned short normal_i2c[]
>  #define MANUFACTURER_ID 0x01
>  #define DEFAULT_REVISION 0xA4
>  
> -/* Conversions and various macros */
> -#define TEMP_FROM_REG(val_h, val_l) (((val_h) & 0x80 ? (val_h) -
> 0x100 : \
> -    (val_h)) * 1000 + (val_l) * 1000 / 256)
> -
> -/* Functions declaration */
> -static void lm95241_init_client(struct i2c_client *client);
> -static struct lm95241_data *lm95241_update_device(struct device
> *dev);
> -
>  /* Client data (each client gets its own) */
>  struct lm95241_data {
>      struct device *hwmon_dev;
> @@ -94,29 +84,208 @@ struct lm95241_data {
>      unsigned long last_updated, interval; /* in jiffies */
>      char valid; /* zero until following fields are valid */
>      /* registers values */
> -    u8 local_h, local_l; /* local */
> -    u8 remote1_h, remote1_l; /* remote1 */
> -    u8 remote2_h, remote2_l; /* remote2 */
> +    u8 temp[6];
>      u8 config, model, trutherm;
>  };
>  
> +/* Conversions */
> +static int TempFromReg(u8 val_h, u8 val_l)
> +{
> +    if (val_h & 0x80)
> +        return val_h - 0x100;
> +    return val_h * 1000 + val_l * 1000 / 256;
> +}
> +
> +static const u8 address[] = {

Please use something like lm95241_reg_address. Also, if you move this
array above the definition of struct lm95241_data, you can use
	u8 temp[ARRAY_SIZE(lm95241_reg_address)];
in struct lm95241_data, instead of the hardcoded array size.

> +    LM95241_REG_R_LOCAL_TEMPH,
> +    LM95241_REG_R_LOCAL_TEMPL,
> +    LM95241_REG_R_REMOTE1_TEMPH,
> +    LM95241_REG_R_REMOTE1_TEMPL,
> +    LM95241_REG_R_REMOTE2_TEMPH,
> +    LM95241_REG_R_REMOTE2_TEMPL
> +};
> +

> +static struct lm95241_data *lm95241_update_device(struct device *dev)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +    mutex_lock(&data->update_lock);
> +
> +    if (time_after(jiffies, data->last_updated + data->interval) ||
> +        !data->valid) {
> +        int i;
> +
> +        dev_dbg(&client->dev, "Updating lm95241 data.\n");
> +        for(i = 0; i < 6; i++)

		i < ARRAY_SIZE(data->temp);

> +            data->temp[i] = i2c_smbus_read_byte_data(client,
> +                                 address[i]);
> +        data->last_updated = jiffies;
> +        data->valid = 1;
> +    }
> +
> +    mutex_unlock(&data->update_lock);
> +
> +    return data;
> +}
> +
>  /* Sysfs stuff */
> -#define show_temp(value) \
> -static ssize_t show_##value(struct device *dev, \
> -    struct device_attribute *attr, char *buf) \
> -{ \
> -    struct lm95241_data *data = lm95241_update_device(dev); \
> -    snprintf(buf, PAGE_SIZE - 1, "%d\n", \
> -        TEMP_FROM_REG(data->value##_h, data->value##_l)); \
> -    return strlen(buf); \
> -}
> -show_temp(local);
> -show_temp(remote1);
> -show_temp(remote2);
> +static ssize_t show_input(struct device *dev, struct device_attribute
> *attr,
> +              char *buf)
> +{
> +    struct lm95241_data *data = lm95241_update_device(dev);
>  
> -static ssize_t show_interval(struct device *dev, struct
> device_attribute *attr,
> +    snprintf(buf, PAGE_SIZE - 1, "%d\n",
> +         TempFromReg(data->temp[to_sensor_dev_attr(attr)->index],
> +                 data->temp[to_sensor_dev_attr(attr)->index + 1]));
> +    return strlen(buf);
> +}
> +
> +static SENSOR_DEVICE_ATTR(locale_input, S_IRUGO, show_input, NULL,
> 0);
> +static SENSOR_DEVICE_ATTR(remote1_input, S_IRUGO, show_input, NULL,
> 2);
> +static SENSOR_DEVICE_ATTR(remote2_input, S_IRUGO, show_input, NULL,
> 4);
> +
You renamed all the attributes from the standard ABI (tempX_input) to
something proprietary, which no one will understand. Please stick with
the standard attribute names.

I would suggest to keep all SENSOR_DEVICE_ATTR definitions at a single
place, as it used to be. Makes the code look cleaner (and issues like
attribute renames are easier to catch).

> +static ssize_t show_type(struct device *dev, struct device_attribute
> *attr,
>               char *buf)
>  {
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +    snprintf(buf, PAGE_SIZE - 1,
> +         data->model & to_sensor_dev_attr(attr)->index ? "1\n" : "2
> \n");
> +    return strlen(buf);

Please use 
	return snprintf(...);

> +}
> +
> +static ssize_t set_type(struct device *dev, struct device_attribute
> *attr,
> +            const char *buf, size_t count)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +    unsigned long val;

Add
	u8 mask = to_sensor_dev_attr(attr)->index;

Then you can use it below instead of accessing
to_sensor_dev_attr(attr)->index several times.

> +
> +    if (strict_strtoul(buf, 10, &val) < 0)
> +        return -EINVAL;
> +
Since numbers other than 1 and 2 are invalid, the following would be
better.

	if (val != 1 && val != 2)
		return -EINVAL;

	shift = mask = R1MS_MASK ? TT1_SHIFT : TT2_SHIFT;
	...

> +    if (val = 1 || val = 2) {
> +        int shift = (to_sensor_dev_attr(attr)->index = R1MS_MASK) ?
> +            TT1_SHIFT : TT2_SHIFT;
> +
> +        mutex_lock(&data->update_lock);
> +
> +        data->trutherm &= ~(TT_MASK << shift);
> +        if (val = 1) {
> +            data->model |= to_sensor_dev_attr(attr)->index;
> +            data->trutherm |= (TT_ON << shift);
> +        } else {
> +            data->model &= ~to_sensor_dev_attr(attr)->index;
> +            data->trutherm |= (TT_OFF << shift);
> +        }
> +
> +        data->valid = 0;
> +
> +        i2c_smbus_write_byte_data(client,
> LM95241_REG_RW_REMOTE_MODEL,
> +                      data->model);
> +        i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
> +                      data->trutherm);
> +
> +        mutex_unlock(&data->update_lock);
> +
> +    }
> +    return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(remote1_type, S_IWUSR | S_IRUGO, show_type,
> set_type,
> +              R1MS_MASK);
> +static SENSOR_DEVICE_ATTR(remote2_type, S_IWUSR | S_IRUGO, show_type,
> set_type,
> +              R2MS_MASK);
> +
Move, and fix attribute names.

> +static ssize_t show_min(struct device *dev, struct device_attribute
> *attr,
> +            char *buf)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +    snprintf(buf, PAGE_SIZE - 1,
> +         data->config & to_sensor_dev_attr(attr)->index ?
> +         "-127000\n" : "0\n");
> +    return strlen(buf);

	return snprintf(...);

> +}
> +
> +static ssize_t set_min(struct device *dev, struct device_attribute
> *attr,
> +               const char *buf, size_t count)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +    long val;
> +
> +    if (strict_strtol(buf, 10, &val) < 0)
> +        return -EINVAL;
> +
Is there a valid range, or is it just <0 vs. >= 0 ?
If there is a valid range, it would make sense to check it.

> +    mutex_lock(&data->update_lock);
> +
> +    if (val < 0)
> +        data->config |= to_sensor_dev_attr(attr)->index;
> +    else
> +        data->config &= ~to_sensor_dev_attr(attr)->index;
> +    data->valid = 0;
> +
> +    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
> data->config);
> +
> +    mutex_unlock(&data->update_lock);
> +
> +    return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(remote1_min, S_IWUSR | S_IRUGO, show_min,
> set_min,
> +              R1DF_MASK);
> +static SENSOR_DEVICE_ATTR(remote2_min, S_IWUSR | S_IRUGO, show_min,
> set_min,
> +              R2DF_MASK);
> +
Move, and fix attribute names.

> +static ssize_t show_max(struct device *dev, struct device_attribute
> *attr,
> +            char *buf)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +    snprintf(buf, PAGE_SIZE - 1,
> +         data->config & to_sensor_dev_attr(attr)->index ?
> +         "127000\n" : "255000\n");
> +    return strlen(buf);

	return snprintf(...);

> +}
> +
> +static ssize_t set_max(struct device *dev, struct device_attribute
> *attr,
> +               const char *buf, size_t count)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +    long val;
> +
> +    if (strict_strtol(buf, 10, &val) < 0)
> +        return -EINVAL;
> +
Is there a valid range ? If so, please check it.

> +    mutex_lock(&data->update_lock);
> +
> +    if (val <= 127000)
> +        data->config |= to_sensor_dev_attr(attr)->index;
> +    else
> +        data->config &= ~to_sensor_dev_attr(attr)->index;
> +    data->valid = 0;
> +
> +    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
> data->config);
> +
> +    mutex_unlock(&data->update_lock);
> +
> +    return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(remote1_max, S_IWUSR | S_IRUGO, show_max,
> set_max,
> +              R1DF_MASK);
> +static SENSOR_DEVICE_ATTR(remote2_max, S_IWUSR | S_IRUGO, show_max,
> set_max,
> +              R2DF_MASK);
> +
Move, and fix attribute names.

> +static ssize_t show_interval(struct device *dev, struct
> device_attribute *attr,
> +                 char *buf)
> +{
>      struct lm95241_data *data = lm95241_update_device(dev);
>  
>      snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->interval /
> HZ);

	return snprintf(...);

> @@ -124,181 +293,33 @@ static ssize_t show_interval(struct devi
>  }
>  
>  static ssize_t set_interval(struct device *dev, struct
> device_attribute *attr,
> -            const char *buf, size_t count)
> +                const char *buf, size_t count)
>  {
>      struct i2c_client *client = to_i2c_client(dev);
>      struct lm95241_data *data = i2c_get_clientdata(client);
> +    unsigned long val;
> +
> +    if (strict_strtoul(buf, 10, &val) < 0)
> +        return -EINVAL;
>  
> -    strict_strtol(buf, 10, &data->interval);
> -    data->interval = data->interval * HZ / 1000;
> +    data->interval = val * HZ / 1000;
>  
>      return count;
>  }
>  
> -#define show_type(flag) \
> -static ssize_t show_type##flag(struct device *dev, \
> -                   struct device_attribute *attr, char *buf) \
> -{ \
> -    struct i2c_client *client = to_i2c_client(dev); \
> -    struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -    snprintf(buf, PAGE_SIZE - 1, \
> -        data->model & R##flag##MS_MASK ? "1\n" : "2\n"); \
> -    return strlen(buf); \
> -}
> -show_type(1);
> -show_type(2);
> -
> -#define show_min(flag) \
> -static ssize_t show_min##flag(struct device *dev, \
> -    struct device_attribute *attr, char *buf) \
> -{ \
> -    struct i2c_client *client = to_i2c_client(dev); \
> -    struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -    snprintf(buf, PAGE_SIZE - 1, \
> -        data->config & R##flag##DF_MASK ?    \
> -        "-127000\n" : "0\n"); \
> -    return strlen(buf); \
> -}
> -show_min(1);
> -show_min(2);
> -
> -#define show_max(flag) \
> -static ssize_t show_max##flag(struct device *dev, \
> -    struct device_attribute *attr, char *buf) \
> -{ \
> -    struct i2c_client *client = to_i2c_client(dev); \
> -    struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -    snprintf(buf, PAGE_SIZE - 1, \
> -        data->config & R##flag##DF_MASK ? \
> -        "127000\n" : "255000\n"); \
> -    return strlen(buf); \
> -}
> -show_max(1);
> -show_max(2);
> -
> -#define set_type(flag) \
> -static ssize_t set_type##flag(struct device *dev, \
> -                  struct device_attribute *attr, \
> -                  const char *buf, size_t count) \
> -{ \
> -    struct i2c_client *client = to_i2c_client(dev); \
> -    struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -    long val; \
> -    strict_strtol(buf, 10, &val); \
> -\
> -    if ((val = 1) || (val = 2)) { \
> -\
> -        mutex_lock(&data->update_lock); \
> -\
> -        data->trutherm &= ~(TT_MASK << TT##flag##_SHIFT); \
> -        if (val = 1) { \
> -            data->model |= R##flag##MS_MASK; \
> -            data->trutherm |= (TT_ON << TT##flag##_SHIFT); \
> -        } \
> -        else { \
> -            data->model &= ~R##flag##MS_MASK; \
> -            data->trutherm |= (TT_OFF << TT##flag##_SHIFT); \
> -        } \
> -\
> -        data->valid = 0; \
> -\
> -        i2c_smbus_write_byte_data(client,
> LM95241_REG_RW_REMOTE_MODEL, \
> -                      data->model); \
> -        i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM, \
> -                      data->trutherm); \
> -\
> -        mutex_unlock(&data->update_lock); \
> -\
> -    } \
> -    return count; \
> -}
> -set_type(1);
> -set_type(2);
> -
> -#define set_min(flag) \
> -static ssize_t set_min##flag(struct device *dev, \
> -    struct device_attribute *devattr, const char *buf, size_t count)
> \
> -{ \
> -    struct i2c_client *client = to_i2c_client(dev); \
> -    struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -    long val; \
> -    strict_strtol(buf, 10, &val); \
> -\
> -    mutex_lock(&data->update_lock); \
> -\
> -    if (val < 0) \
> -        data->config |= R##flag##DF_MASK; \
> -    else \
> -        data->config &= ~R##flag##DF_MASK; \
> -\
> -    data->valid = 0; \
> -\
> -    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
> -        data->config); \
> -\
> -    mutex_unlock(&data->update_lock); \
> -\
> -    return count; \
> -}
> -set_min(1);
> -set_min(2);
> -
> -#define set_max(flag) \
> -static ssize_t set_max##flag(struct device *dev, \
> -    struct device_attribute *devattr, const char *buf, size_t count)
> \
> -{ \
> -    struct i2c_client *client = to_i2c_client(dev); \
> -    struct lm95241_data *data = i2c_get_clientdata(client); \
> -\
> -    long val; \
> -    strict_strtol(buf, 10, &val); \
> -\
> -    mutex_lock(&data->update_lock); \
> -\
> -    if (val <= 127000) \
> -        data->config |= R##flag##DF_MASK; \
> -    else \
> -        data->config &= ~R##flag##DF_MASK; \
> -\
> -    data->valid = 0; \
> -\
> -    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
> -        data->config); \
> -\
> -    mutex_unlock(&data->update_lock); \
> -\
> -    return count; \
> -}
> -set_max(1);
> -set_max(2);
> -
> -static DEVICE_ATTR(temp1_input, S_IRUGO, show_local, NULL);
> -static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote1, NULL);
> -static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote2, NULL);
> -static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type1,
> set_type1);
> -static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type2,
> set_type2);
> -static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min1,
> set_min1);
> -static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min2,
> set_min2);
> -static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max1,
> set_max1);
> -static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max2,
> set_max2);
>  static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
>             set_interval);
>  
>  static struct attribute *lm95241_attributes[] = {
> -    &dev_attr_temp1_input.attr,
> -    &dev_attr_temp2_input.attr,
> -    &dev_attr_temp3_input.attr,
> -    &dev_attr_temp2_type.attr,
> -    &dev_attr_temp3_type.attr,
> -    &dev_attr_temp2_min.attr,
> -    &dev_attr_temp3_min.attr,
> -    &dev_attr_temp2_max.attr,
> -    &dev_attr_temp3_max.attr,
> +    &sensor_dev_attr_locale_input.dev_attr.attr,
> +    &sensor_dev_attr_remote1_input.dev_attr.attr,
> +    &sensor_dev_attr_remote2_input.dev_attr.attr,
> +    &sensor_dev_attr_remote1_type.dev_attr.attr,
> +    &sensor_dev_attr_remote2_type.dev_attr.attr,
> +    &sensor_dev_attr_remote1_min.dev_attr.attr,
> +    &sensor_dev_attr_remote2_min.dev_attr.attr,
> +    &sensor_dev_attr_remote1_max.dev_attr.attr,
> +    &sensor_dev_attr_remote2_max.dev_attr.attr,
>      &dev_attr_update_interval.attr,
>      NULL
>  };
> @@ -322,7 +343,7 @@ static int lm95241_detect(struct i2c_cli
>           = MANUFACTURER_ID)
>       && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
>           >= DEFAULT_REVISION)) {
> -        name = "lm95241";
> +        name = DEVNAME;
>      } else {
>          dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x
> \n",
>              address);
> @@ -334,6 +355,26 @@ static int lm95241_detect(struct i2c_cli
>      return 0;
>  }
>  
> +static void lm95241_init_client(struct i2c_client *client)
> +{
> +    struct lm95241_data *data = i2c_get_clientdata(client);
> +
> +    data->interval = HZ;    /* 1 sec default */
> +    data->valid = 0;
> +    data->config = CFG_CR0076;
> +    data->model = 0;
> +    data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
> +
> +    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
> +                  data->config);
> +    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,
> +                  R1FE_MASK | R2FE_MASK);
> +    i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
> +                  data->trutherm);
> +    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
> +                  data->model);
> +}
> +
>  static int lm95241_probe(struct i2c_client *new_client,
>               const struct i2c_device_id *id)
>  {
> @@ -373,26 +414,6 @@ exit:
>      return err;
>  }
>  
> -static void lm95241_init_client(struct i2c_client *client)
> -{
> -    struct lm95241_data *data = i2c_get_clientdata(client);
> -
> -    data->interval = HZ;    /* 1 sec default */
> -    data->valid = 0;
> -    data->config = CFG_CR0076;
> -    data->model = 0;
> -    data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
> -
> -    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
> -                  data->config);
> -    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,
> -                  R1FE_MASK | R2FE_MASK);
> -    i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
> -                  data->trutherm);
> -    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
> -                  data->model);
> -}
> -
>  static int lm95241_remove(struct i2c_client *client)
>  {
>      struct lm95241_data *data = i2c_get_clientdata(client);
> @@ -404,46 +425,9 @@ static int lm95241_remove(struct i2c_cli
>      return 0;
>  }
>  
> -static struct lm95241_data *lm95241_update_device(struct device *dev)
> -{
> -    struct i2c_client *client = to_i2c_client(dev);
> -    struct lm95241_data *data = i2c_get_clientdata(client);
> -
> -    mutex_lock(&data->update_lock);
> -
> -    if (time_after(jiffies, data->last_updated + data->interval) ||
> -        !data->valid) {
> -        dev_dbg(&client->dev, "Updating lm95241 data.\n");
> -        data->local_h > -            i2c_smbus_read_byte_data(client,
> -                         LM95241_REG_R_LOCAL_TEMPH);
> -        data->local_l > -            i2c_smbus_read_byte_data(client,
> -                         LM95241_REG_R_LOCAL_TEMPL);
> -        data->remote1_h > -            i2c_smbus_read_byte_data(client,
> -                         LM95241_REG_R_REMOTE1_TEMPH);
> -        data->remote1_l > -            i2c_smbus_read_byte_data(client,
> -                         LM95241_REG_R_REMOTE1_TEMPL);
> -        data->remote2_h > -            i2c_smbus_read_byte_data(client,
> -                         LM95241_REG_R_REMOTE2_TEMPH);
> -        data->remote2_l > -            i2c_smbus_read_byte_data(client,
> -                         LM95241_REG_R_REMOTE2_TEMPL);
> -        data->last_updated = jiffies;
> -        data->valid = 1;
> -    }
> -
> -    mutex_unlock(&data->update_lock);
> -
> -    return data;
> -}
> -
>  /* Driver data (common to all clients) */
>  static const struct i2c_device_id lm95241_id[] = {
> -    { "lm95241", 0 },
> +    { DEVNAME, 0 },
>      { }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm95241_id);
> @@ -451,7 +435,7 @@ MODULE_DEVICE_TABLE(i2c, lm95241_id);
>  static struct i2c_driver lm95241_driver = {
>      .class        = I2C_CLASS_HWMON,
>      .driver = {
> -        .name   = "lm95241",
> +        .name   = DEVNAME,
>      },
>      .probe        = lm95241_probe,
>      .remove        = lm95241_remove,
> @@ -470,9 +454,10 @@ static void __exit sensors_lm95241_exit(
>      i2c_del_driver(&lm95241_driver);
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
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
