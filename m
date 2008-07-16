From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 18:17:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7470) Convert to a new-style
Message-Id: <487E3B4C.1010705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716163337.72604b28@hyperion.delvare>
In-Reply-To: <20080716163337.72604b28-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Jean Delvare wrote:
> The new-style adt7470 driver implements the optional detect() callback
> to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Darrick J. Wong <djwong@us.ibm.com>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans




> ---
>  drivers/hwmon/adt7470.c |  100 ++++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 52 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/adt7470.c	2008-07-12 09:20:30.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/adt7470.c	2008-07-12 10:27:29.000000000 +0200
> @@ -138,7 +138,6 @@ I2C_CLIENT_INSMOD_1(adt7470);
>  #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
>  
>  struct adt7470_data {
> -	struct i2c_client	client;
>  	struct device		*hwmon_dev;
>  	struct attribute_group	attrs;
>  	struct mutex		lock;
> @@ -164,16 +163,28 @@ struct adt7470_data {
>  	u8			pwm_auto_temp[ADT7470_PWM_COUNT];
>  };
>  
> -static int adt7470_attach_adapter(struct i2c_adapter *adapter);
> -static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind);
> -static int adt7470_detach_client(struct i2c_client *client);
> +static int adt7470_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id);
> +static int adt7470_detect(struct i2c_client *client, int kind,
> +			  struct i2c_board_info *info);
> +static int adt7470_remove(struct i2c_client *client);
> +
> +static const struct i2c_device_id adt7470_id[] = {
> +	{ "adt7470", adt7470 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, adt7470_id);
>  
>  static struct i2c_driver adt7470_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "adt7470",
>  	},
> -	.attach_adapter	= adt7470_attach_adapter,
> -	.detach_client	= adt7470_detach_client,
> +	.probe		= adt7470_probe,
> +	.remove		= adt7470_remove,
> +	.id_table	= adt7470_id,
> +	.detect		= adt7470_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  /*
> @@ -1004,64 +1015,52 @@ static struct attribute *adt7470_attr[] 
>  	NULL
>  };
>  
> -static int adt7470_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, adt7470_detect);
> -}
> -
> -static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int adt7470_detect(struct i2c_client *client, int kind,
> +			  struct i2c_board_info *info)
>  {
> -	struct i2c_client *client;
> -	struct adt7470_data *data;
> -	int err = 0;
> +	struct i2c_adapter *adapter = client->adapter;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> -		goto exit;
> -
> -	if (!(data = kzalloc(sizeof(struct adt7470_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	client = &data->client;
> -	client->addr = address;
> -	client->adapter = adapter;
> -	client->driver = &adt7470_driver;
> -
> -	i2c_set_clientdata(client, data);
> -
> -	mutex_init(&data->lock);
> +		return -ENODEV;
>  
>  	if (kind <= 0) {
>  		int vendor, device, revision;
>  
>  		vendor = i2c_smbus_read_byte_data(client, ADT7470_REG_VENDOR);
> -		if (vendor != ADT7470_VENDOR) {
> -			err = -ENODEV;
> -			goto exit_free;
> -		}
> +		if (vendor != ADT7470_VENDOR)
> +			return -ENODEV;
>  
>  		device = i2c_smbus_read_byte_data(client, ADT7470_REG_DEVICE);
> -		if (device != ADT7470_DEVICE) {
> -			err = -ENODEV;
> -			goto exit_free;
> -		}
> +		if (device != ADT7470_DEVICE)
> +			return -ENODEV;
>  
>  		revision = i2c_smbus_read_byte_data(client,
>  						    ADT7470_REG_REVISION);
> -		if (revision != ADT7470_REVISION) {
> -			err = -ENODEV;
> -			goto exit_free;
> -		}
> +		if (revision != ADT7470_REVISION)
> +			return -ENODEV;
>  	} else
>  		dev_dbg(&adapter->dev, "detection forced\n");
>  
> -	strlcpy(client->name, "adt7470", I2C_NAME_SIZE);
> +	strlcpy(info->type, "adt7470", I2C_NAME_SIZE);
>  
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_free;
> +	return 0;
> +}
> +
> +static int adt7470_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct adt7470_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct adt7470_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->lock);
>  
>  	dev_info(&client->dev, "%s chip found\n", client->name);
>  
> @@ -1071,7 +1070,7 @@ static int adt7470_detect(struct i2c_ada
>  	/* Register sysfs hooks */
>  	data->attrs.attrs = adt7470_attr;
>  	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
> -		goto exit_detach;
> +		goto exit_free;
>  
>  	data->hwmon_dev = hwmon_device_register(&client->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
> @@ -1083,21 +1082,18 @@ static int adt7470_detect(struct i2c_ada
>  
>  exit_remove:
>  	sysfs_remove_group(&client->dev.kobj, &data->attrs);
> -exit_detach:
> -	i2c_detach_client(client);
>  exit_free:
>  	kfree(data);
>  exit:
>  	return err;
>  }
>  
> -static int adt7470_detach_client(struct i2c_client *client)
> +static int adt7470_remove(struct i2c_client *client)
>  {
>  	struct adt7470_data *data = i2c_get_clientdata(client);
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &data->attrs);
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
