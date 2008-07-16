From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 18:30:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm93) Convert to a new-style i2c
Message-Id: <487E3E5B.6020807@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716172952.07fd7fc7@hyperion.delvare>
In-Reply-To: <20080716172952.07fd7fc7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Eric J. Bowersox" <ericb@aspsys.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Carsten Emde <cbe@osadl.org>, Linux I2C <i2c@lm-sensors.org>, LM Sensors <lm-sensors@lm-sensors.org>

Jean Delvare wrote:
> The new-style lm93 driver implements the optional detect() callback
> to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Cc: Eric J. Bowersox <ericb@aspsys.com>
> Cc: Carsten Emde <cbe@osadl.org>
> Cc: Hans J. Koch <hjk@linutronix.de>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



> ---
>  drivers/hwmon/lm93.c |  126 +++++++++++++++++++++++---------------------------
>  1 file changed, 60 insertions(+), 66 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/lm93.c	2008-07-12 09:20:29.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/lm93.c	2008-07-12 10:27:15.000000000 +0200
> @@ -200,7 +200,6 @@ struct block1_t {
>   * Client-specific data
>   */
>  struct lm93_data {
> -	struct i2c_client client;
>  	struct device *hwmon_dev;
>  
>  	struct mutex update_lock;
> @@ -2501,45 +2500,14 @@ static void lm93_init_client(struct i2c_
>  		 "chip to signal ready!\n");
>  }
>  
> -static int lm93_detect(struct i2c_adapter *adapter, int address, int kind)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int lm93_detect(struct i2c_client *client, int kind,
> +		       struct i2c_board_info *info)
>  {
> -	struct lm93_data *data;
> -	struct i2c_client *client;
> -
> -	int err = -ENODEV, func;
> -	void (*update)(struct lm93_data *, struct i2c_client *);
> -
> -	/* choose update routine based on bus capabilities */
> -	func = i2c_get_functionality(adapter);
> -	if ( ((LM93_SMBUS_FUNC_FULL & func) = LM93_SMBUS_FUNC_FULL) &&
> -			(!disable_block) ) {
> -		dev_dbg(&adapter->dev,"using SMBus block data transactions\n");
> -		update = lm93_update_client_full;
> -	} else if ((LM93_SMBUS_FUNC_MIN & func) = LM93_SMBUS_FUNC_MIN) {
> -		dev_dbg(&adapter->dev,"disabled SMBus block data "
> -			"transactions\n");
> -		update = lm93_update_client_min;
> -	} else {
> -		dev_dbg(&adapter->dev,"detect failed, "
> -			"smbus byte and/or word data not supported!\n");
> -		goto err_out;
> -	}
> +	struct i2c_adapter *adapter = client->adapter;
>  
> -	/* OK. For now, we presume we have a valid client. We now create the
> -	   client structure, even though we cannot fill it completely yet.
> -	   But it allows us to access lm78_{read,write}_value. */
> -
> -	if ( !(data = kzalloc(sizeof(struct lm93_data), GFP_KERNEL))) {
> -		dev_dbg(&adapter->dev,"out of memory!\n");
> -		err = -ENOMEM;
> -		goto err_out;
> -	}
> -
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	client->adapter = adapter;
> -	client->driver = &lm93_driver;
> +	if (!i2c_check_functionality(adapter, LM93_SMBUS_FUNC_MIN))
> +		return -ENODEV;
>  
>  	/* detection */
>  	if (kind < 0) {
> @@ -2548,7 +2516,7 @@ static int lm93_detect(struct i2c_adapte
>  		if (mfr != 0x01) {
>  			dev_dbg(&adapter->dev,"detect failed, "
>  				"bad manufacturer id 0x%02x!\n", mfr);
> -			goto err_free;
> +			return -ENODEV;
>  		}
>  	}
>  
> @@ -2563,31 +2531,61 @@ static int lm93_detect(struct i2c_adapte
>  			if (kind = 0)
>  				dev_dbg(&adapter->dev,
>  					"(ignored 'force' parameter)\n");
> -			goto err_free;
> +			return -ENODEV;
>  		}
>  	}
>  
> -	/* fill in remaining client fields */
> -	strlcpy(client->name, "lm93", I2C_NAME_SIZE);
> +	strlcpy(info->type, "lm93", I2C_NAME_SIZE);
>  	dev_dbg(&adapter->dev,"loading %s at %d,0x%02x\n",
>  		client->name, i2c_adapter_id(client->adapter),
>  		client->addr);
>  
> +	return 0;
> +}
> +
> +static int lm93_probe(struct i2c_client *client,
> +		      const struct i2c_device_id *id)
> +{
> +	struct lm93_data *data;
> +	int err, func;
> +	void (*update)(struct lm93_data *, struct i2c_client *);
> +
> +	/* choose update routine based on bus capabilities */
> +	func = i2c_get_functionality(client->adapter);
> +	if (((LM93_SMBUS_FUNC_FULL & func) = LM93_SMBUS_FUNC_FULL) &&
> +			(!disable_block)) {
> +		dev_dbg(&client->dev, "using SMBus block data transactions\n");
> +		update = lm93_update_client_full;
> +	} else if ((LM93_SMBUS_FUNC_MIN & func) = LM93_SMBUS_FUNC_MIN) {
> +		dev_dbg(&client->dev, "disabled SMBus block data "
> +			"transactions\n");
> +		update = lm93_update_client_min;
> +	} else {
> +		dev_dbg(&client->dev, "detect failed, "
> +			"smbus byte and/or word data not supported!\n");
> +		err = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	data = kzalloc(sizeof(struct lm93_data), GFP_KERNEL);
> +	if (!data) {
> +		dev_dbg(&client->dev, "out of memory!\n");
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	i2c_set_clientdata(client, data);
> +
>  	/* housekeeping */
>  	data->valid = 0;
>  	data->update = update;
>  	mutex_init(&data->update_lock);
>  
> -	/* tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(client)))
> -		goto err_free;
> -
>  	/* initialize the chip */
>  	lm93_init_client(client);
>  
>  	err = sysfs_create_group(&client->dev.kobj, &lm93_attr_grp);
>  	if (err)
> -		goto err_detach;
> +		goto err_free;
>  
>  	/* Register hwmon driver class */
>  	data->hwmon_dev = hwmon_device_register(&client->dev);
> @@ -2597,43 +2595,39 @@ static int lm93_detect(struct i2c_adapte
>  	err = PTR_ERR(data->hwmon_dev);
>  	dev_err(&client->dev, "error registering hwmon device.\n");
>  	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
> -err_detach:
> -	i2c_detach_client(client);
>  err_free:
>  	kfree(data);
>  err_out:
>  	return err;
>  }
>  
> -/* This function is called when:
> -     * lm93_driver is inserted (when this module is loaded), for each
> -       available adapter
> -     * when a new adapter is inserted (and lm93_driver is still present) */
> -static int lm93_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	return i2c_probe(adapter, &addr_data, lm93_detect);
> -}
> -
> -static int lm93_detach_client(struct i2c_client *client)
> +static int lm93_remove(struct i2c_client *client)
>  {
>  	struct lm93_data *data = i2c_get_clientdata(client);
> -	int err = 0;
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
>  
> -	err = i2c_detach_client(client);
> -	if (!err)
> -		kfree(data);
> -	return err;
> +	kfree(data);
> +	return 0;
>  }
>  
> +static const struct i2c_device_id lm93_id[] = {
> +	{ "lm93", lm93 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lm93_id);
> +
>  static struct i2c_driver lm93_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "lm93",
>  	},
> -	.attach_adapter	= lm93_attach_adapter,
> -	.detach_client	= lm93_detach_client,
> +	.probe		= lm93_probe,
> +	.remove		= lm93_remove,
> +	.id_table	= lm93_id,
> +	.detect		= lm93_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  static int __init lm93_init(void)
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
