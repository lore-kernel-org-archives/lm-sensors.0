From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 20:52:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Convert to a new-style
Message-Id: <487E5F9A.2070905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716173112.3f419ffd@hyperion.delvare>
In-Reply-To: <20080716173112.3f419ffd-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Jean Delvare wrote:
> The new-style max6650 driver implements the optional detect() callback
> to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Hans J. Koch <hjk@linutronix.de>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



> ---
>  drivers/hwmon/max6650.c |  102 +++++++++++++++++++++--------------------------
>  1 file changed, 47 insertions(+), 55 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/max6650.c	2008-07-12 09:20:29.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/max6650.c	2008-07-12 10:27:13.000000000 +0200
> @@ -104,22 +104,34 @@ I2C_CLIENT_INSMOD_1(max6650);
>  
>  #define DIV_FROM_REG(reg) (1 << (reg & 7))
>  
> -static int max6650_attach_adapter(struct i2c_adapter *adapter);
> -static int max6650_detect(struct i2c_adapter *adapter, int address, int kind);
> +static int max6650_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id);
> +static int max6650_detect(struct i2c_client *client, int kind,
> +			  struct i2c_board_info *info);
>  static int max6650_init_client(struct i2c_client *client);
> -static int max6650_detach_client(struct i2c_client *client);
> +static int max6650_remove(struct i2c_client *client);
>  static struct max6650_data *max6650_update_device(struct device *dev);
>  
>  /*
>   * Driver data (common to all clients)
>   */
>  
> +static const struct i2c_device_id max6650_id[] = {
> +	{ "max6650", max6650 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max6650_id);
> +
>  static struct i2c_driver max6650_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "max6650",
>  	},
> -	.attach_adapter	= max6650_attach_adapter,
> -	.detach_client	= max6650_detach_client,
> +	.probe		= max6650_probe,
> +	.remove		= max6650_remove,
> +	.id_table	= max6650_id,
> +	.detect		= max6650_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  /*
> @@ -128,7 +140,6 @@ static struct i2c_driver max6650_driver 
>  
>  struct max6650_data
>  {
> -	struct i2c_client client;
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  	char valid; /* zero until following fields are valid */
> @@ -437,47 +448,21 @@ static struct attribute_group max6650_at
>   * Real code
>   */
>  
> -static int max6650_attach_adapter(struct i2c_adapter *adapter)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int max6650_detect(struct i2c_client *client, int kind,
> +			  struct i2c_board_info *info)
>  {
> -	if (!(adapter->class & I2C_CLASS_HWMON)) {
> -		dev_dbg(&adapter->dev,
> -			"FATAL: max6650_attach_adapter class HWMON not set\n");
> -		return 0;
> -	}
> -
> -	return i2c_probe(adapter, &addr_data, max6650_detect);
> -}
> -
> -/*
> - * The following function does more than just detection. If detection
> - * succeeds, it also registers the new chip.
> - */
> -
> -static int max6650_detect(struct i2c_adapter *adapter, int address, int kind)
> -{
> -	struct i2c_client *client;
> -	struct max6650_data *data;
> -	int err = -ENODEV;
> +	struct i2c_adapter *adapter = client->adapter;
> +	int address = client->addr;
>  
>  	dev_dbg(&adapter->dev, "max6650_detect called, kind = %d\n", kind);
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>  		dev_dbg(&adapter->dev, "max6650: I2C bus doesn't support "
>  					"byte read mode, skipping.\n");
> -		return 0;
> -	}
> -
> -	if (!(data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL))) {
> -		dev_err(&adapter->dev, "max6650: out of memory.\n");
> -		return -ENOMEM;
> +		return -ENODEV;
>  	}
>  
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	client->adapter = adapter;
> -	client->driver = &max6650_driver;
> -
>  	/*
>  	 * Now we do the remaining detection. A negative kind means that
>  	 * the driver was loaded with no force parameter (default), so we
> @@ -501,28 +486,40 @@ static int max6650_detect(struct i2c_ada
>  	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_COUNT) & 0xFC))) {
>  		dev_dbg(&adapter->dev,
>  			"max6650: detection failed at 0x%02x.\n", address);
> -		goto err_free;
> +		return -ENODEV;
>  	}
>  
>  	dev_info(&adapter->dev, "max6650: chip found at 0x%02x.\n", address);
>  
> -	strlcpy(client->name, "max6650", I2C_NAME_SIZE);
> -	mutex_init(&data->update_lock);
> +	strlcpy(info->type, "max6650", I2C_NAME_SIZE);
>  
> -	if ((err = i2c_attach_client(client))) {
> -		dev_err(&adapter->dev, "max6650: failed to attach client.\n");
> -		goto err_free;
> +	return 0;
> +}
> +
> +static int max6650_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct max6650_data *data;
> +	int err;
> +
> +	if (!(data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL))) {
> +		dev_err(&client->dev, "out of memory.\n");
> +		return -ENOMEM;
>  	}
>  
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +
>  	/*
>  	 * Initialize the max6650 chip
>  	 */
> -	if (max6650_init_client(client))
> -		goto err_detach;
> +	err = max6650_init_client(client);
> +	if (err)
> +		goto err_free;
>  
>  	err = sysfs_create_group(&client->dev.kobj, &max6650_attr_grp);
>  	if (err)
> -		goto err_detach;
> +		goto err_free;
>  
>  	data->hwmon_dev = hwmon_device_register(&client->dev);
>  	if (!IS_ERR(data->hwmon_dev))
> @@ -531,24 +528,19 @@ static int max6650_detect(struct i2c_ada
>  	err = PTR_ERR(data->hwmon_dev);
>  	dev_err(&client->dev, "error registering hwmon device.\n");
>  	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
> -err_detach:
> -	i2c_detach_client(client);
>  err_free:
>  	kfree(data);
>  	return err;
>  }
>  
> -static int max6650_detach_client(struct i2c_client *client)
> +static int max6650_remove(struct i2c_client *client)
>  {
>  	struct max6650_data *data = i2c_get_clientdata(client);
> -	int err;
>  
>  	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
>  	hwmon_device_unregister(data->hwmon_dev);
> -	err = i2c_detach_client(client);
> -	if (!err)
> -		kfree(data);
> -	return err;
> +	kfree(data);
> +	return 0;
>  }
>  
>  static int max6650_init_client(struct i2c_client *client)
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
