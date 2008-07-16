From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 18:28:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm77) Convert to a new-style i2c
Message-Id: <487E3DCF.3090403@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716164000.6a9f4d9c@hyperion.delvare>
In-Reply-To: <20080716164000.6a9f4d9c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Andras Bali <drewie-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Jean Delvare wrote:
> The new-style lm77 driver implements the optional detect() callback
> to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Andras Bali <drewie@freemail.hu>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans




> ---
>  drivers/hwmon/lm77.c |  102 ++++++++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 57 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/lm77.c	2008-07-12 09:20:29.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/lm77.c	2008-07-12 10:27:19.000000000 +0200
> @@ -52,7 +52,6 @@ I2C_CLIENT_INSMOD_1(lm77);
>  
>  /* Each client has this additional data */
>  struct lm77_data {
> -	struct i2c_client	client;
>  	struct device 		*hwmon_dev;
>  	struct mutex		update_lock;
>  	char			valid;
> @@ -65,23 +64,35 @@ struct lm77_data {
>  	u8			alarms;
>  };
>  
> -static int lm77_attach_adapter(struct i2c_adapter *adapter);
> -static int lm77_detect(struct i2c_adapter *adapter, int address, int kind);
> +static int lm77_probe(struct i2c_client *client,
> +		      const struct i2c_device_id *id);
> +static int lm77_detect(struct i2c_client *client, int kind,
> +		       struct i2c_board_info *info);
>  static void lm77_init_client(struct i2c_client *client);
> -static int lm77_detach_client(struct i2c_client *client);
> +static int lm77_remove(struct i2c_client *client);
>  static u16 lm77_read_value(struct i2c_client *client, u8 reg);
>  static int lm77_write_value(struct i2c_client *client, u8 reg, u16 value);
>  
>  static struct lm77_data *lm77_update_device(struct device *dev);
>  
>  
> +static const struct i2c_device_id lm77_id[] = {
> +	{ "lm77", lm77 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lm77_id);
> +
>  /* This is the driver that will be inserted */
>  static struct i2c_driver lm77_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "lm77",
>  	},
> -	.attach_adapter = lm77_attach_adapter,
> -	.detach_client	= lm77_detach_client,
> +	.probe		= lm77_probe,
> +	.remove		= lm77_remove,
> +	.id_table	= lm77_id,
> +	.detect		= lm77_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  /* straight from the datasheet */
> @@ -215,13 +226,6 @@ static SENSOR_DEVICE_ATTR(temp1_crit_ala
>  static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
>  
> -static int lm77_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, lm77_detect);
> -}
> -
>  static struct attribute *lm77_attributes[] = {
>  	&dev_attr_temp1_input.attr,
>  	&dev_attr_temp1_crit.attr,
> @@ -240,32 +244,15 @@ static const struct attribute_group lm77
>  	.attrs = lm77_attributes,
>  };
>  
> -/* This function is called by i2c_probe */
> -static int lm77_detect(struct i2c_adapter *adapter, int address, int kind)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int lm77_detect(struct i2c_client *new_client, int kind,
> +		       struct i2c_board_info *info)
>  {
> -	struct i2c_client *new_client;
> -	struct lm77_data *data;
> -	int err = 0;
> -	const char *name = "";
> +	struct i2c_adapter *adapter = new_client->adapter;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
> -		goto exit;
> -
> -	/* OK. For now, we presume we have a valid client. We now create the
> -	   client structure, even though we cannot fill it completely yet.
> -	   But it allows us to access lm77_{read,write}_value. */
> -	if (!(data = kzalloc(sizeof(struct lm77_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	new_client = &data->client;
> -	i2c_set_clientdata(new_client, data);
> -	new_client->addr = address;
> -	new_client->adapter = adapter;
> -	new_client->driver = &lm77_driver;
> -	new_client->flags = 0;
> +		return -ENODEV;
>  
>  	/* Here comes the remaining detection.  Since the LM77 has no
>  	   register dedicated to identification, we have to rely on the
> @@ -294,7 +281,7 @@ static int lm77_detect(struct i2c_adapte
>  			    || i2c_smbus_read_word_data(new_client, i + 3) != crit
>  			    || i2c_smbus_read_word_data(new_client, i + 4) != min
>  			    || i2c_smbus_read_word_data(new_client, i + 5) != max)
> -				goto exit_free;
> +				return -ENODEV;
>  
>  		/* sign bits */
>  		if (((cur & 0x00f0) != 0xf0 && (cur & 0x00f0) != 0x0)
> @@ -302,51 +289,55 @@ static int lm77_detect(struct i2c_adapte
>  		    || ((crit & 0x00f0) != 0xf0 && (crit & 0x00f0) != 0x0)
>  		    || ((min & 0x00f0) != 0xf0 && (min & 0x00f0) != 0x0)
>  		    || ((max & 0x00f0) != 0xf0 && (max & 0x00f0) != 0x0))
> -			goto exit_free;
> +			return -ENODEV;
>  
>  		/* unused bits */
>  		if (conf & 0xe0)
> -			goto exit_free;
> +			return -ENODEV;
>  
>  		/* 0x06 and 0x07 return the last read value */
>  		cur = i2c_smbus_read_word_data(new_client, 0);
>  		if (i2c_smbus_read_word_data(new_client, 6) != cur
>  		    || i2c_smbus_read_word_data(new_client, 7) != cur)
> -			goto exit_free;
> +			return -ENODEV;
>  		hyst = i2c_smbus_read_word_data(new_client, 2);
>  		if (i2c_smbus_read_word_data(new_client, 6) != hyst
>  		    || i2c_smbus_read_word_data(new_client, 7) != hyst)
> -			goto exit_free;
> +			return -ENODEV;
>  		min = i2c_smbus_read_word_data(new_client, 4);
>  		if (i2c_smbus_read_word_data(new_client, 6) != min
>  		    || i2c_smbus_read_word_data(new_client, 7) != min)
> -			goto exit_free;
> +			return -ENODEV;
>  
>  	}
>  
> -	/* Determine the chip type - only one kind supported! */
> -	if (kind <= 0)
> -		kind = lm77;
> +	strlcpy(info->type, "lm77", I2C_NAME_SIZE);
>  
> -	if (kind = lm77) {
> -		name = "lm77";
> +	return 0;
> +}
> +
> +static int lm77_probe(struct i2c_client *new_client,
> +		      const struct i2c_device_id *id)
> +{
> +	struct lm77_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct lm77_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
>  	}
>  
> -	/* Fill in the remaining client fields and put it into the global list */
> -	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> +	i2c_set_clientdata(new_client, data);
>  	data->valid = 0;
>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(new_client)))
> -		goto exit_free;
> -
>  	/* Initialize the LM77 chip */
>  	lm77_init_client(new_client);
>  
>  	/* Register sysfs hooks */
>  	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm77_group)))
> -		goto exit_detach;
> +		goto exit_free;
>  
>  	data->hwmon_dev = hwmon_device_register(&new_client->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
> @@ -358,20 +349,17 @@ static int lm77_detect(struct i2c_adapte
>  
>  exit_remove:
>  	sysfs_remove_group(&new_client->dev.kobj, &lm77_group);
> -exit_detach:
> -	i2c_detach_client(new_client);
>  exit_free:
>  	kfree(data);
>  exit:
>  	return err;
>  }
>  
> -static int lm77_detach_client(struct i2c_client *client)
> +static int lm77_remove(struct i2c_client *client)
>  {
>  	struct lm77_data *data = i2c_get_clientdata(client);
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &lm77_group);
> -	i2c_detach_client(client);
>  	kfree(data);
>  	return 0;
>  }
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
