From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jul 2007 16:15:45 +0000
Subject: Re: [lm-sensors] [PATCH] adm1021 dynamic sysfs callbacks added
Message-Id: <20070709181545.479d7bfb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690a7b195e80@wp.pl>
In-Reply-To: <4690a7b195e80@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sun, 08 Jul 2007 11:00:33 +0200, Krzysztof Helt wrote:
> This patch adds dynamic sysfs callback and provides some coding 
> standard cleanups.

Thanks for working on the dynamic sysfs callbacks, this is very needed.

> --- linux-2.6.21.old/drivers/hwmon/adm1021.c	2007-04-26 05:
> 08:32.000000000 +0200
> +++ linux-2.6.21/drivers/hwmon/adm1021.c	2007-07-08 09:48:47.
> 000000000 +0200
> @@ -1,6 +1,6 @@
>  /*
>      adm1021.c - Part of lm_sensors, Linux kernel modules for 
> hardware
> -             monitoring
> +		monitoring
>      Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
> and

Once again your e-mail client wrapped long lines, so I simply can't
apply your patch. Please try again, possibly attaching the patch
instead of inlining it if it doesn't work otherwise.

Secondly, please do not mix unrelated things in a single patch. Using
dynamic sysfs callbacks is one thing, cleaning up indentation, trailing
white space and define names is another one. Please make two different
patches.

>      Philip Edelbrock <phil@netroedge.com>
>  
> @@ -25,6 +25,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/i2c.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  
> @@ -32,11 +33,12 @@
>  /* Addresses to scan */
>  static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
>  					0x29, 0x2a, 0x2b,
> -					0x4c, 0x4d, 0x4e, 
> +					0x4c, 0x4d, 0x4e,
>  					I2C_CLIENT_END };
>  
>  /* Insmod parameters */
> -I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, 
> lm84, gl523sm, mc1066);
> +I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, 
> lm84, gl523sm,
> +			mc1066);
>  
>  /* adm1021 constants specified below */
>  
> @@ -45,8 +47,10 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
>  #define ADM1021_REG_TEMP		0x00
>  #define ADM1021_REG_REMOTE_TEMP		0x01
>  #define ADM1021_REG_STATUS		0x02
> -#define ADM1021_REG_MAN_ID		0x0FE	/* 0x41 = AMD, 0x49 
> = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
> -#define ADM1021_REG_DEV_ID		0x0FF	/* ADM1021 = 0x0X, 
> ADM1023 = 0x3X */
> +/* 0x41 = AD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = 
> Onsemi */
> +#define ADM1021_REG_MAN_ID		0x0FE
> +/* ADM1021 = 0x0X, ADM1023 = 0x3X */
> +#define ADM1021_REG_DEV_ID		0x0FF
>  #define ADM1021_REG_DIE_CODE		0x0FF	/* MAX1617A */
>  /* These use different addresses for reading/writing */
>  #define ADM1021_REG_CONFIG_R		0x03
> @@ -54,11 +58,11 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
>  #define ADM1021_REG_CONV_RATE_R		0x04
>  #define ADM1021_REG_CONV_RATE_W		0x0A
>  /* These are for the ADM1023's additional precision on the 
> remote temp sensor */
> -#define ADM1021_REG_REM_TEMP_PREC	0x010
> -#define ADM1021_REG_REM_OFFSET		0x011
> -#define ADM1021_REG_REM_OFFSET_PREC	0x012
> -#define ADM1021_REG_REM_TOS_PREC	0x013
> -#define ADM1021_REG_REM_THYST_PREC	0x014
> +#define ADM1023_REG_REM_TEMP_PREC	0x010
> +#define ADM1023_REG_REM_OFFSET		0x011
> +#define ADM1023_REG_REM_OFFSET_PREC	0x012
> +#define ADM1023_REG_REM_TOS_PREC	0x013
> +#define ADM1023_REG_REM_THYST_PREC	0x014
>  /* limits */
>  #define ADM1021_REG_TOS_R		0x05
>  #define ADM1021_REG_TOS_W		0x0B
> @@ -71,20 +75,11 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
>  /* write-only */
>  #define ADM1021_REG_ONESHOT		0x0F
>  
> -
> -/* Conversions. Rounding and limit checking is only done on the 
> TO_REG
> -   variants. Note that you should be a bit careful with which 
> arguments
> -   these macros are called: arguments may be evaluated more than 
> once.
> -   Fixing this is just not worth it. */
> -/* Conversions  note: 1021 uses normal integer signed-byte 
> format*/
> -#define TEMP_FROM_REG(val)	(val > 127 ? (val-256)*1000 : 
> val*1000)
> -#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ? 
> (val/1000)+256 : val/1000),0,255))
> -
>  /* Initial values */
>  
> -/* Note: Even though I left the low and high limits named os and 
> hyst, 
> -they don't quite work like a thermostat the way the LM75 does.  
> I.e., 
> -a lower temp than THYST actually triggers an alarm instead of 
> +/* Note: Even though I left the low and high limits named os and 
> hyst,
> +they don't quite work like a thermostat the way the LM75 does.  
> I.e.,
> +a lower temp than THYST actually triggers an alarm instead of
>  clearing it.  Weird, ey?   --Phil  */
>  
>  /* Each client has this additional data */
> @@ -97,28 +92,22 @@ struct adm1021_data {
>  	char valid;		/* !=0 if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
> -	u8	temp_max;	/* Register values */
> -	u8	temp_hyst;
> -	u8	temp_input;
> -	u8	remote_temp_max;
> -	u8	remote_temp_hyst;
> -	u8	remote_temp_input;
> -	u8	alarms;
> -        /* Special values for ADM1023 only */
> -	u8	remote_temp_prec;
> -	u8	remote_temp_os_prec;
> -	u8	remote_temp_hyst_prec;
> -	u8	remote_temp_offset;
> -	u8	remote_temp_offset_prec;
> +	s8 temp_max[2];		/* Register values */
> +	s8 temp_min[2];
> +	s8 temp[2];
> +	u8 alarms;
> +	/* Special values for ADM1023 only */
> +	u8 remote_temp_prec;
> +	u8 remote_temp_os_prec;
> +	u8 remote_temp_hyst_prec;
> +	u8 remote_temp_offset;
> +	u8 remote_temp_offset_prec;
>  };
>  
>  static int adm1021_attach_adapter(struct i2c_adapter *adapter);
>  static int adm1021_detect(struct i2c_adapter *adapter, int 
> address, int kind);
>  static void adm1021_init_client(struct i2c_client *client);
>  static int adm1021_detach_client(struct i2c_client *client);
> -static int adm1021_read_value(struct i2c_client *client, u8 reg)
> ;
> -static int adm1021_write_value(struct i2c_client *client, u8 
> reg,
> -			       u16 value);
>  static struct adm1021_data *adm1021_update_device(struct device 
> *dev);
>  
>  /* (amalysh) read only mode, otherwise any limit's writing 
> confuse BIOS */
> @@ -135,53 +124,89 @@ static struct i2c_driver adm1021_driver 
>  	.detach_client	= adm1021_detach_client,
>  };
>  
> -#define show(value)	\
> -static ssize_t show_##value(struct device *dev, struct 
> device_attribute *attr, char *buf)		\
> -{									\
> -	struct adm1021_data *data = adm1021_update_device(dev);
> 		\
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));
> 	\
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct adm1021_data *data = adm1021_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", 1000 * data->temp[index]);
> +}
> +
> +static ssize_t show_temp_max(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct adm1021_data *data = adm1021_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", 1000 * data->temp_max[index]);
> +}
> +
> +static ssize_t show_temp_min(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct adm1021_data *data = adm1021_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", 1000 * data->temp_min[index]);
>  }
> -show(temp_max);
> -show(temp_hyst);
> -show(temp_input);
> -show(remote_temp_max);
> -show(remote_temp_hyst);
> -show(remote_temp_input);
>  
>  #define show2(value)	\
> -static ssize_t show_##value(struct device *dev, struct 
> device_attribute *attr, char *buf)		\
> +static ssize_t show_##value(struct device *dev,				\
> +			    struct device_attribute *attr,		\
> +			    char *buf)					\
>  {									\
>  	struct adm1021_data *data = adm1021_update_device(dev);
> 		\
>  	return sprintf(buf, "%d\n", data->value);			\
>  }
>  show2(alarms);
>  
> -#define set(value, reg)	\
> -static ssize_t set_##value(struct device *dev, struct 
> device_attribute *attr, const char *buf, size_t count)	\
> -{								\
> -	struct i2c_client *client = to_i2c_client(dev);		\
> -	struct adm1021_data *data = i2c_get_clientdata(client);
> 	\
> -	int temp = simple_strtoul(buf, NULL, 10);		\
> -								\
> -	mutex_lock(&data->update_lock);				\
> -	data->value = TEMP_TO_REG(temp);			\
> -	adm1021_write_value(client, reg, data->value);		\
> -	mutex_unlock(&data->update_lock);			\
> -	return count;						\
> -}
> -set(temp_max, ADM1021_REG_TOS_W);
> -set(temp_hyst, ADM1021_REG_THYST_W);
> -set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
> -set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
> -
> -static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, 
> set_temp_max);
> -static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst, 
> set_temp_hyst);
> -static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
> -static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, 
> show_remote_temp_max, set_remote_temp_max);
> -static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, 
> show_remote_temp_hyst, set_remote_temp_hyst);
> -static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, 
> NULL);
> -static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +static ssize_t set_temp_max(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adm1021_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
>  
> +	mutex_lock(&data->update_lock);
> +	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);
> +	i2c_smbus_write_byte_data(client, ADM1021_REG_TOS_W + 2 * 
> index, temp);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t set_temp_min(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adm1021_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);
> +	i2c_smbus_write_byte_data(client,
> +				  ADM1021_REG_THYST_W + 2 * index, temp);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 
> 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, 
> show_temp_max,
> +			  set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, 
> show_temp_min,
> +			  set_temp_min, 0);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 
> 1);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, 
> show_temp_max,
> +			  set_temp_max, 1);
> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, 
> show_temp_min,
> +			  set_temp_min, 1);
> +static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
>  static int adm1021_attach_adapter(struct i2c_adapter *adapter)
>  {
> @@ -191,12 +216,12 @@ static int adm1021_attach_adapter(struct
>  }
>  
>  static struct attribute *adm1021_attributes[] = {
> -	&dev_attr_temp1_max.attr,
> -	&dev_attr_temp1_min.attr,
> -	&dev_attr_temp1_input.attr,
> -	&dev_attr_temp2_max.attr,
> -	&dev_attr_temp2_min.attr,
> -	&dev_attr_temp2_input.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
>  	&dev_attr_alarms.attr,
>  	NULL
>  };
> @@ -212,15 +237,20 @@ static int adm1021_detect(struct i2c_ada
>  	struct adm1021_data *data;
>  	int err = 0;
>  	const char *type_name = "";
> +	int conv_rate, status, config;
>  
> -	if (!i2c_check_functionality(adapter, 
> I2C_FUNC_SMBUS_BYTE_DATA))
> +	if (!i2c_check_functionality(adapter, 
> I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		pr_debug("adm1021: detect failed, "
> +			 "smbus byte data not supported!\n");
>  		goto error0;
> +	}
>  
>  	/* OK. For now, we presume we have a valid client. We now 
> create the
>  	   client structure, even though we cannot fill it completely 
> yet.
>  	   But it allows us to access adm1021_{read,write}_value. */
>  
>  	if (!(data = kzalloc(sizeof(struct adm1021_data), 
> GFP_KERNEL))) {
> +		pr_debug("adm1021: detect failed, kzalloc failed!\n");
>  		err = -ENOMEM;
>  		goto error0;
>  	}
> @@ -230,13 +260,17 @@ static int adm1021_detect(struct i2c_ada
>  	new_client->addr = address;
>  	new_client->adapter = adapter;
>  	new_client->driver = &adm1021_driver;
> -	new_client->flags = 0;
> +	status = i2c_smbus_read_byte_data(new_client, 
> ADM1021_REG_STATUS);
> +	conv_rate = i2c_smbus_read_byte_data(new_client,
> +					     ADM1021_REG_CONV_RATE_R);
> +	config = i2c_smbus_read_byte_data(new_client, 
> ADM1021_REG_CONFIG_R);
>  
>  	/* Now, we do the remaining detection. */
>  	if (kind < 0) {
> -		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS) 
> & 0x03) != 0x00
> -		 || (adm1021_read_value(new_client, ADM1021_REG_CONFIG_R) 
> & 0x3F) != 0x00
> -		 || (adm1021_read_value(new_client, 
> ADM1021_REG_CONV_RATE_R) & 0xF8) != 0x00) {
> +		if ((status & 0x03) != 0x00 || (config & 0x3F) != 0x00
> +		    || (conv_rate & 0xF8) != 0x00) {
> +			pr_debug("adm1021: detect failed, "
> +				 "chip not detected!\n");
>  			err = -ENODEV;
>  			goto error1;
>  		}
> @@ -244,9 +278,10 @@ static int adm1021_detect(struct i2c_ada
>  
>  	/* Determine the chip type. */
>  	if (kind <= 0) {
> -		i = adm1021_read_value(new_client, ADM1021_REG_MAN_ID);
> +		i = i2c_smbus_read_byte_data(new_client, 
> ADM1021_REG_MAN_ID);
>  		if (i = 0x41)
> -			if ((adm1021_read_value(new_client, 
> ADM1021_REG_DEV_ID) & 0x0F0) = 0x030)
> +			if ((i2c_smbus_read_byte_data(new_client,
> +					ADM1021_REG_DEV_ID) & 0x0F0) = 0x030)
>  				kind = adm1023;
>  			else
>  				kind = adm1021;
> @@ -255,15 +290,16 @@ static int adm1021_detect(struct i2c_ada
>  		else if (i = 0x23)
>  			kind = gl523sm;
>  		else if ((i = 0x4d) &&
> -			 (adm1021_read_value(new_client, ADM1021_REG_DEV_ID) = 
> 0x01))
> +			 (i2c_smbus_read_byte_data(new_client,
> +						   ADM1021_REG_DEV_ID) = 0x01))
>  			kind = max1617a;
>  		else if (i = 0x54)
>  			kind = mc1066;
>  		/* LM84 Mfr ID in a different place, and it has more 
> unused bits */
> -		else if (adm1021_read_value(new_client, 
> ADM1021_REG_CONV_RATE_R) = 0x00
> -		      && (kind = 0 /* skip extra detection */
> -		       || ((adm1021_read_value(new_client, 
> ADM1021_REG_CONFIG_R) & 0x7F) = 0x00
> -			&& (adm1021_read_value(new_client, 
> ADM1021_REG_STATUS) & 0xAB) = 0x00)))
> +		else if (conv_rate = 0x00
> +			 && (kind = 0 /* skip extra detection */
> +			     || ((config & 0x7F) = 0x00
> +				 && (status & 0xAB) = 0x00)))
>  			kind = lm84;
>  		else
>  			kind = max1617;
> @@ -286,11 +322,12 @@ static int adm1021_detect(struct i2c_ada
>  	} else if (kind = mc1066) {
>  		type_name = "mc1066";
>  	}
> +	pr_debug("adm1021: Detected chip %s at adapter %d, address 
> 0x%02x.\n",
> +		 type_name, i2c_adapter_id(adapter), address);
>  
> -	/* Fill in the remaining client fields and put it into the 
> global list */
> +	/* Fill in the remaining client fields */
>  	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
>  	data->type = kind;
> -	data->valid = 0;
>  	mutex_init(&data->update_lock);
>  
>  	/* Tell the I2C layer a new client has arrived */
> @@ -326,10 +363,10 @@ error0:
>  static void adm1021_init_client(struct i2c_client *client)
>  {
>  	/* Enable ADC and disable suspend mode */
> -	adm1021_write_value(client, ADM1021_REG_CONFIG_W,
> -		adm1021_read_value(client, ADM1021_REG_CONFIG_R) & 0xBF)
> ;
> +	i2c_smbus_write_byte_data(client, ADM1021_REG_CONFIG_W,
> +		i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R) & 
> 0xBF);
>  	/* Set Conversion rate to 1/sec (this can be tinkered with) 
> */
> -	adm1021_write_value(client, ADM1021_REG_CONV_RATE_W, 0x04);
> +	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 
> 0x04);
>  }
>  
>  static int adm1021_detach_client(struct i2c_client *client)
> @@ -347,19 +384,6 @@ static int adm1021_detach_client(struct 
>  	return 0;
>  }
>  
> -/* All registers are byte-sized */
> -static int adm1021_read_value(struct i2c_client *client, u8 reg)
> -{
> -	return i2c_smbus_read_byte_data(client, reg);
> -}
> -
> -static int adm1021_write_value(struct i2c_client *client, u8 
> reg, u16 value)
> -{
> -	if (!read_only)
> -		return i2c_smbus_write_byte_data(client, reg, value);
> -	return 0;
> -}
> -
>  static struct adm1021_data *adm1021_update_device(struct device 
> *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -369,21 +393,39 @@ static struct adm1021_data *adm1021_upda
>  
>  	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>  	    || !data->valid) {
> +		int i;
> +
>  		dev_dbg(&client->dev, "Starting adm1021 update\n");
>  
> -		data->temp_input = adm1021_read_value(client, 
> ADM1021_REG_TEMP);
> -		data->temp_max = adm1021_read_value(client, 
> ADM1021_REG_TOS_R);
> -		data->temp_hyst = adm1021_read_value(client, 
> ADM1021_REG_THYST_R);
> -		data->remote_temp_input = adm1021_read_value(client, 
> ADM1021_REG_REMOTE_TEMP);
> -		data->remote_temp_max = adm1021_read_value(client, 
> ADM1021_REG_REMOTE_TOS_R);
> -		data->remote_temp_hyst = adm1021_read_value(client, 
> ADM1021_REG_REMOTE_THYST_R);
> -		data->alarms = adm1021_read_value(client, 
> ADM1021_REG_STATUS) & 0x7c;
> +		for (i = 0; i < 2; i++) {
> +			data->temp[i] = i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_TEMP + i);
> +			data->temp_max[i] > +				i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_TOS_R + 2 * i);
> +			data->temp_min[i] > +				i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_THYST_R + 2 * i);
> +		}
> +		data->alarms > +			i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_STATUS) & 0x7c;
>  		if (data->type = adm1023) {
> -			data->remote_temp_prec = adm1021_read_value(client, 
> ADM1021_REG_REM_TEMP_PREC);
> -			data->remote_temp_os_prec = 
> adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
> -			data->remote_temp_hyst_prec = 
> adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
> -			data->remote_temp_offset = adm1021_read_value(client, 
> ADM1021_REG_REM_OFFSET);
> -			data->remote_temp_offset_prec = 
> adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
> +			data->remote_temp_prec > +				i2c_smbus_read_byte_data(client,
> +						ADM1023_REG_REM_TEMP_PREC);
> +			data->remote_temp_os_prec > +				i2c_smbus_read_byte_data(client,
> +						ADM1023_REG_REM_TOS_PREC);
> +			data->remote_temp_hyst_prec > +				i2c_smbus_read_byte_data(client,
> +						ADM1023_REG_REM_THYST_PREC);
> +			data->remote_temp_offset > +				i2c_smbus_read_byte_data(client,
> +						ADM1023_REG_REM_OFFSET);
> +			data->remote_temp_offset_prec > +				i2c_smbus_read_byte_data(client,
> +						ADM1023_REG_REM_OFFSET_PREC);
>  		}
>  		data->last_updated = jiffies;
>  		data->valid = 1;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
