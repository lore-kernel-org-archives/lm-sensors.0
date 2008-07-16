From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 20:51:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1619) Convert to a new-style
Message-Id: <487E5F64.9010007@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716173030.43988f36@hyperion.delvare>
In-Reply-To: <20080716173030.43988f36@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Alexey Fisher <fishor@mail.ru>, Linux I2C <i2c@lm-sensors.org>, LM Sensors <lm-sensors@lm-sensors.org>

Jean Delvare wrote:
> The new-style max1619 driver implements the optional detect() callback
> to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Alexey Fisher <fishor@mail.ru>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



> ---
>  drivers/hwmon/max1619.c |  101 ++++++++++++++++++++---------------------------
>  1 file changed, 44 insertions(+), 57 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/max1619.c	2008-07-12 09:20:29.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/max1619.c	2008-07-12 10:27:14.000000000 +0200
> @@ -79,23 +79,34 @@ I2C_CLIENT_INSMOD_1(max1619);
>   * Functions declaration
>   */
>  
> -static int max1619_attach_adapter(struct i2c_adapter *adapter);
> -static int max1619_detect(struct i2c_adapter *adapter, int address,
> -	int kind);
> +static int max1619_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id);
> +static int max1619_detect(struct i2c_client *client, int kind,
> +			  struct i2c_board_info *info);
>  static void max1619_init_client(struct i2c_client *client);
> -static int max1619_detach_client(struct i2c_client *client);
> +static int max1619_remove(struct i2c_client *client);
>  static struct max1619_data *max1619_update_device(struct device *dev);
>  
>  /*
>   * Driver data (common to all clients)
>   */
>  
> +static const struct i2c_device_id max1619_id[] = {
> +	{ "max1619", max1619 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max1619_id);
> +
>  static struct i2c_driver max1619_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "max1619",
>  	},
> -	.attach_adapter	= max1619_attach_adapter,
> -	.detach_client	= max1619_detach_client,
> +	.probe		= max1619_probe,
> +	.remove		= max1619_remove,
> +	.id_table	= max1619_id,
> +	.detect		= max1619_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  /*
> @@ -103,7 +114,6 @@ static struct i2c_driver max1619_driver 
>   */
>  
>  struct max1619_data {
> -	struct i2c_client client;
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  	char valid; /* zero until following fields are valid */
> @@ -208,41 +218,15 @@ static const struct attribute_group max1
>   * Real code
>   */
>  
> -static int max1619_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, max1619_detect);
> -}
> -
> -/*
> - * The following function does more than just detection. If detection
> - * succeeds, it also registers the new chip.
> - */
> -static int max1619_detect(struct i2c_adapter *adapter, int address, int kind)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int max1619_detect(struct i2c_client *new_client, int kind,
> +			  struct i2c_board_info *info)
>  {
> -	struct i2c_client *new_client;
> -	struct max1619_data *data;
> -	int err = 0;
> -	const char *name = "";	
> +	struct i2c_adapter *adapter = new_client->adapter;
>  	u8 reg_config=0, reg_convrate=0, reg_status=0;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> -		goto exit;
> -
> -	if (!(data = kzalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	/* The common I2C client data is placed right before the
> -	   MAX1619-specific data. */
> -	new_client = &data->client;
> -	i2c_set_clientdata(new_client, data);
> -	new_client->addr = address;
> -	new_client->adapter = adapter;
> -	new_client->driver = &max1619_driver;
> -	new_client->flags = 0;
> +		return -ENODEV;
>  
>  	/*
>  	 * Now we do the remaining detection. A negative kind means that
> @@ -265,8 +249,8 @@ static int max1619_detect(struct i2c_ada
>  		 || reg_convrate > 0x07 || (reg_status & 0x61 ) !=0x00) {
>  			dev_dbg(&adapter->dev,
>  				"MAX1619 detection failed at 0x%02x.\n",
> -				address);
> -			goto exit_free;
> +				new_client->addr);
> +			return -ENODEV;
>  		}
>  	}
>  
> @@ -285,28 +269,37 @@ static int max1619_detect(struct i2c_ada
>  			dev_info(&adapter->dev,
>  			    "Unsupported chip (man_id=0x%02X, "
>  			    "chip_id=0x%02X).\n", man_id, chip_id);
> -			goto exit_free;
> +			return -ENODEV;
>  		}
>  	}
>  
> -	if (kind = max1619)
> -		name = "max1619";
> +	strlcpy(info->type, "max1619", I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static int max1619_probe(struct i2c_client *new_client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct max1619_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct max1619_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
>  
> -	/* We can fill in the remaining client fields */
> -	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> +	i2c_set_clientdata(new_client, data);
>  	data->valid = 0;
>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(new_client)))
> -		goto exit_free;
> -
>  	/* Initialize the MAX1619 chip */
>  	max1619_init_client(new_client);
>  
>  	/* Register sysfs hooks */
>  	if ((err = sysfs_create_group(&new_client->dev.kobj, &max1619_group)))
> -		goto exit_detach;
> +		goto exit_free;
>  
>  	data->hwmon_dev = hwmon_device_register(&new_client->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
> @@ -318,8 +311,6 @@ static int max1619_detect(struct i2c_ada
>  
>  exit_remove_files:
>  	sysfs_remove_group(&new_client->dev.kobj, &max1619_group);
> -exit_detach:
> -	i2c_detach_client(new_client);
>  exit_free:
>  	kfree(data);
>  exit:
> @@ -341,17 +332,13 @@ static void max1619_init_client(struct i
>  					  config & 0xBF); /* run */
>  }
>  
> -static int max1619_detach_client(struct i2c_client *client)
> +static int max1619_remove(struct i2c_client *client)
>  {
>  	struct max1619_data *data = i2c_get_clientdata(client);
> -	int err;
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &max1619_group);
>  
> -	if ((err = i2c_detach_client(client)))
> -		return err;
> -
>  	kfree(data);
>  	return 0;
>  }
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
