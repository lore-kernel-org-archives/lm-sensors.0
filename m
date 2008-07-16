From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 16 Jul 2008 20:54:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smsc47m192) Convert to a new-style
Message-Id: <487E6018.5010106@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716173219.35ae9ff3@hyperion.delvare>
In-Reply-To: <20080716173219.35ae9ff3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Hartmut Rick <linux-b/THyiajkxVQ8441yD4n9A@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Jean Delvare wrote:
> The new-style smsc47m192 driver implements the optional detect()
> callback to cover the use cases of the legacy driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Hartmut Rick <linux@rick.claranet.de>

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



> ---
>  drivers/hwmon/smsc47m192.c |  102 +++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 56 deletions(-)
> 
> --- linux-2.6.26-rc9.orig/drivers/hwmon/smsc47m192.c	2008-07-12 09:20:29.000000000 +0200
> +++ linux-2.6.26-rc9/drivers/hwmon/smsc47m192.c	2008-07-12 10:27:12.000000000 +0200
> @@ -96,7 +96,6 @@ static inline int TEMP_FROM_REG(s8 val)
>  }
>  
>  struct smsc47m192_data {
> -	struct i2c_client client;
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  	char valid;		/* !=0 if following fields are valid */
> @@ -114,18 +113,29 @@ struct smsc47m192_data {
>  	u8 vrm;
>  };
>  
> -static int smsc47m192_attach_adapter(struct i2c_adapter *adapter);
> -static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
> -		int kind);
> -static int smsc47m192_detach_client(struct i2c_client *client);
> +static int smsc47m192_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id);
> +static int smsc47m192_detect(struct i2c_client *client, int kind,
> +			     struct i2c_board_info *info);
> +static int smsc47m192_remove(struct i2c_client *client);
>  static struct smsc47m192_data *smsc47m192_update_device(struct device *dev);
>  
> +static const struct i2c_device_id smsc47m192_id[] = {
> +	{ "smsc47m192", smsc47m192 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, smsc47m192_id);
> +
>  static struct i2c_driver smsc47m192_driver = {
> +	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "smsc47m192",
>  	},
> -	.attach_adapter	= smsc47m192_attach_adapter,
> -	.detach_client	= smsc47m192_detach_client,
> +	.probe		= smsc47m192_probe,
> +	.remove		= smsc47m192_remove,
> +	.id_table	= smsc47m192_id,
> +	.detect		= smsc47m192_detect,
> +	.address_data	= &addr_data,
>  };
>  
>  /* Voltages */
> @@ -440,17 +450,6 @@ static const struct attribute_group smsc
>  	.attrs = smsc47m192_attributes_in4,
>  };
>  
> -/* This function is called when:
> -    * smsc47m192_driver is inserted (when this module is loaded), for each
> -      available adapter
> -    * when a new adapter is inserted (and smsc47m192_driver is still present) */
> -static int smsc47m192_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, smsc47m192_detect);
> -}
> -
>  static void smsc47m192_init_client(struct i2c_client *client)
>  {
>  	int i;
> @@ -481,31 +480,15 @@ static void smsc47m192_init_client(struc
>  	}
>  }
>  
> -/* This function is called by i2c_probe */
> -static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
> -		int kind)
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int smsc47m192_detect(struct i2c_client *client, int kind,
> +			     struct i2c_board_info *info)
>  {
> -	struct i2c_client *client;
> -	struct smsc47m192_data *data;
> -	int err = 0;
> -	int version, config;
> +	struct i2c_adapter *adapter = client->adapter;
> +	int version;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> -		goto exit;
> -
> -	if (!(data = kzalloc(sizeof(struct smsc47m192_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	client->adapter = adapter;
> -	client->driver = &smsc47m192_driver;
> -
> -	if (kind = 0)
> -		kind = smsc47m192;
> +		return -ENODEV;
>  
>  	/* Detection criteria from sensors_detect script */
>  	if (kind < 0) {
> @@ -523,26 +506,39 @@ static int smsc47m192_detect(struct i2c_
>  		} else {
>  			dev_dbg(&adapter->dev,
>  				"SMSC47M192 detection failed at 0x%02x\n",
> -				address);
> -			goto exit_free;
> +				client->addr);
> +			return -ENODEV;
>  		}
>  	}
>  
> -	/* Fill in the remaining client fields and put into the global list */
> -	strlcpy(client->name, "smsc47m192", I2C_NAME_SIZE);
> +	strlcpy(info->type, "smsc47m192", I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static int smsc47m192_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct smsc47m192_data *data;
> +	int config;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct smsc47m192_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
>  	data->vrm = vid_which_vrm();
>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_free;
> -
>  	/* Initialize the SMSC47M192 chip */
>  	smsc47m192_init_client(client);
>  
>  	/* Register sysfs hooks */
>  	if ((err = sysfs_create_group(&client->dev.kobj, &smsc47m192_group)))
> -		goto exit_detach;
> +		goto exit_free;
>  
>  	/* Pin 110 is either in4 (+12V) or VID4 */
>  	config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
> @@ -563,26 +559,20 @@ static int smsc47m192_detect(struct i2c_
>  exit_remove_files:
>  	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
>  	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
> -exit_detach:
> -	i2c_detach_client(client);
>  exit_free:
>  	kfree(data);
>  exit:
>  	return err;
>  }
>  
> -static int smsc47m192_detach_client(struct i2c_client *client)
> +static int smsc47m192_remove(struct i2c_client *client)
>  {
>  	struct smsc47m192_data *data = i2c_get_clientdata(client);
> -	int err;
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
>  	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
>  
> -	if ((err = i2c_detach_client(client)))
> -		return err;
> -
>  	kfree(data);
>  
>  	return 0;
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
