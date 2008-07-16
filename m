From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 18:26:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (fscher) Convert to a new-style i2c
Message-Id: <487E3D4D.20702@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716163539.4149f0e3@hyperion.delvare>
In-Reply-To: <20080716163539.4149f0e3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Reinhard Nissl <rnissl-Mmb7MZpHnFY@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Jean Delvare wrote:
> The new-style fscher driver implements the optional detect() callback
> to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Reinhard Nissl <rnissl@gmx.de>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



> ---
>  drivers/hwmon/fscher.c |   93 +++++++++++++++++++++---------------------------
>  1 file changed, 42 insertions(+), 51 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/fscher.c	2008-07-12 09:20:30.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/fscher.c	2008-07-12 10:27:24.000000000 +0200
> @@ -106,9 +106,11 @@ I2C_CLIENT_INSMOD_1(fscher);
>   * Functions declaration
>   */
>  
> -static int fscher_attach_adapter(struct i2c_adapter *adapter);
> -static int fscher_detect(struct i2c_adapter *adapter, int address, int kind);
> -static int fscher_detach_client(struct i2c_client *client);
> +static int fscher_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id);
> +static int fscher_detect(struct i2c_client *client, int kind,
> +			 struct i2c_board_info *info);
> +static int fscher_remove(struct i2c_client *client);
>  static struct fscher_data *fscher_update_device(struct device *dev);
>  static void fscher_init_client(struct i2c_client *client);
>  
> @@ -119,12 +121,21 @@ static int fscher_write_value(struct i2c
>   * Driver data (common to all clients)
>   */
>   
> +static const struct i2c_device_id fscher_id[] = {
> +	{ "fscher", fscher },
> +	{ }
> +};
> +
>  static struct i2c_driver fscher_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "fscher",
>  	},
> -	.attach_adapter	= fscher_attach_adapter,
> -	.detach_client	= fscher_detach_client,
> +	.probe		= fscher_probe,
> +	.remove		= fscher_remove,
> +	.id_table	= fscher_id,
> +	.detect		= fscher_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  /*
> @@ -132,7 +143,6 @@ static struct i2c_driver fscher_driver >   */
>  
>  struct fscher_data {
> -	struct i2c_client client;
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  	char valid; /* zero until following fields are valid */
> @@ -283,38 +293,14 @@ static const struct attribute_group fsch
>   * Real code
>   */
>  
> -static int fscher_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, fscher_detect);
> -}
> -
> -static int fscher_detect(struct i2c_adapter *adapter, int address, int kind)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int fscher_detect(struct i2c_client *new_client, int kind,
> +			 struct i2c_board_info *info)
>  {
> -	struct i2c_client *new_client;
> -	struct fscher_data *data;
> -	int err = 0;
> +	struct i2c_adapter *adapter = new_client->adapter;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> -		goto exit;
> -
> -	/* OK. For now, we presume we have a valid client. We now create the
> -	 * client structure, even though we cannot fill it completely yet.
> -	 * But it allows us to access i2c_smbus_read_byte_data. */
> -	if (!(data = kzalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -  	}
> -
> -	/* The common I2C client data is placed right before the
> -	 * Hermes-specific data. */
> -	new_client = &data->client;
> -	i2c_set_clientdata(new_client, data);
> -	new_client->addr = address;
> -	new_client->adapter = adapter;
> -	new_client->driver = &fscher_driver;
> -	new_client->flags = 0;
> +		return -ENODEV;
>  
>  	/* Do the remaining detection unless force or force_fscher parameter */
>  	if (kind < 0) {
> @@ -324,24 +310,35 @@ static int fscher_detect(struct i2c_adap
>  		     FSCHER_REG_IDENT_1) != 0x45)	/* 'E' */
>  		 || (i2c_smbus_read_byte_data(new_client,
>  		     FSCHER_REG_IDENT_2) != 0x52))	/* 'R' */
> -			goto exit_free;
> +			return -ENODEV;
> +	}
> +
> +	strlcpy(info->type, "fscher", I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static int fscher_probe(struct i2c_client *new_client,
> +			const struct i2c_device_id *id)
> +{
> +	struct fscher_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct fscher_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
>  	}
>  
> -	/* Fill in the remaining client fields and put it into the
> -	 * global list */
> -	strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
> +	i2c_set_clientdata(new_client, data);
>  	data->valid = 0;
>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(new_client)))
> -		goto exit_free;
> -
>  	fscher_init_client(new_client);
>  
>  	/* Register sysfs hooks */
>  	if ((err = sysfs_create_group(&new_client->dev.kobj, &fscher_group)))
> -		goto exit_detach;
> +		goto exit_free;
>  
>  	data->hwmon_dev = hwmon_device_register(&new_client->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
> @@ -353,25 +350,19 @@ static int fscher_detect(struct i2c_adap
>  
>  exit_remove_files:
>  	sysfs_remove_group(&new_client->dev.kobj, &fscher_group);
> -exit_detach:
> -	i2c_detach_client(new_client);
>  exit_free:
>  	kfree(data);
>  exit:
>  	return err;
>  }
>  
> -static int fscher_detach_client(struct i2c_client *client)
> +static int fscher_remove(struct i2c_client *client)
>  {
>  	struct fscher_data *data = i2c_get_clientdata(client);
> -	int err;
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &fscher_group);
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
