From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Aug 2008 18:04:35 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-new-driver-ti-tmp401.patch
Message-Id: <20080822200435.301467ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4853E081.1020109@hhs.nl>
In-Reply-To: <4853E081.1020109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 14 Jun 2008 17:15:13 +0200, Hans de Goede wrote:
> Hi All,
> 
> This is a new hwmon driver for TI's TMP401 temperature sensor IC. This driver
> was written on behalf of an embedded systems vendor under the
> linuxdriverproject.
> 
> It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb adapter.
> Which was provided by Till Harbaum, many thanks to him for this!
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

One more thing that was brought to my attention by a friend of mine who
tested your code:

> +static int tmp401_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	int i, err = 0;
> +	struct i2c_client *client;
> +	struct tmp401_data *data;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return 0;
> +
> +	/* OK. For now, we presume we have a valid client. We now create the
> +	 * client structure, even though we cannot fill it completely yet.
> +	 * But it allows us to access i2c_smbus_read_byte_data. */
> +	if (!(data = kzalloc(sizeof(struct tmp401_data), GFP_KERNEL)))
> +		return -ENOMEM;
> +
> +	client = &data->client;
> +	i2c_set_clientdata(client, data);
> +	client->addr = address;
> +	client->adapter = adapter;
> +	client->driver = &tmp401_driver;
> +	mutex_init(&data->update_lock);
> +
> +	/* Detect & Identify the chip */
> +	if (kind <= 0) {
> +		u8 manufacturer_id;
> +		u8 device_id;
> +
> +		manufacturer_id = i2c_smbus_read_byte_data(client,
> +						TMP401_MANUFACTURER_ID_REG);
> +		device_id = i2c_smbus_read_byte_data(client,
> +						TMP401_DEVICE_ID_REG);
> +
> +		if (manufacturer_id != TMP401_MANUFACTURER_ID ||
> +				device_id != TMP401_DEVICE_ID)
> +			goto exit_free;
> +	}
> +

You forgot to set the client name. libsensors will complain...

> +	/* Tell the I2C layer a new client has arrived */
> +	if ((err = i2c_attach_client(client)))
> +		goto exit_free;
> +
> +	/* Initialize the TMP401 chip */
> +	tmp401_init_client(client);
> +
> +	/* Register sysfs hooks */
> +	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++) {
> +		err = device_create_file(&client->dev,
> +					&tmp401_attr[i].dev_attr);
> +		if (err)
> +			goto exit_detach;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		data->hwmon_dev = NULL;
> +		goto exit_detach;
> +	}
> +
> +	printk(KERN_INFO TMP401_NAME ": Detected TI TMP401 chip\n");
> +
> +	return 0;
> +
> +exit_detach:
> +	tmp401_detach_client(client); /* will also free data for us */
> +	return err;
> +
> +exit_free:
> +	kfree(data);
> +	return err;
> +}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
