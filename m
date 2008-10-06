From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 06 Oct 2008 16:26:30 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: w83781d: use new style driver
Message-Id: <20081006182630.32faf4c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CB7FFA.10202@grandegger.com>
In-Reply-To: <48CB7FFA.10202@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Sat, 13 Sep 2008 10:55:22 +0200, Wolfgang Grandegger wrote:
> This patch modifies the w83781d driver to use new style driver binding.
> Substantial code modifications are required to deal with the new
> interface, especially legacy device detection.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/hwmon/w83781d.c |  615 +++++++++++++++++++++---------------------------
>  1 file changed, 278 insertions(+), 337 deletions(-)

Ouch. Once again, that's a very large patch. I did the exact same
conversion for the lm78 driver a few weeks ago:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm78-04-dont-abuse-i2c_client.patch
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm78-05-convert-to-new-style-i2c.patch
The two patches sum up to 238 lines changed. Compare to 615 for your
patch... I know that the w83781d driver is a little more complex but
that doesn't explain all the difference.

I found that moving w83781d_detect(), w83781d_probe(), w83781d_remove()
where w83781d_detect() and w83781d_detach_client() were originally,
and reverting a couple of unrelated cleanups, lowers the count to 400,
which will make the patch way easier to review for me. So, I will be
commenting on that variant of the patch instead of yours.

> --- linux-2.6.27-rc8.orig/drivers/hwmon/w83781d.c	2008-10-06 16:22:19.000000000 +0200
> +++ linux-2.6.27-rc8/drivers/hwmon/w83781d.c	2008-10-06 17:20:56.000000000 +0200
> @@ -209,7 +209,7 @@ DIV_TO_REG(long val, enum chips type)
>  /* For ISA chips, we abuse the i2c_client addr and name fields. We also use
>     the driver field to differentiate between I2C and ISA chips. */

This comment and the one above it can be deleted.

>  struct w83781d_data {
> -	struct i2c_client client;
> +	struct i2c_client *client;
>  	struct device *hwmon_dev;
>  	struct mutex lock;
>  	enum chips type;

This isn't sufficient. Now, ISA devices no longer have a struct
i2c_client to abuse, so they need a couple fields to store the device
name and address. See:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm78-04-dont-abuse-i2c_client.patch
for how I handled that in the lm78 driver. It might help to do the same
kind of preliminary patch for the w83781d driver as well.

> @@ -244,26 +244,15 @@ struct w83781d_data {
>  	u8 vrm;
>  };
>  
> -static struct w83781d_data *w83781d_data_if_isa(void);
> -static int w83781d_alias_detect(struct i2c_client *client, u8 chipid);
> -
> -static int w83781d_attach_adapter(struct i2c_adapter *adapter);
> -static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
> -static int w83781d_detach_client(struct i2c_client *client);
> +static int w83781d_read_value_i2c(struct i2c_client *client, u16 reg);
> +static int w83781d_write_value_i2c(struct i2c_client *client, u16 reg, u16 value);
> +static int w83781d_alias_detect(struct i2c_client *client);
>  
>  static int w83781d_read_value(struct w83781d_data *data, u16 reg);
>  static int w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value);
>  static struct w83781d_data *w83781d_update_device(struct device *dev);
>  static void w83781d_init_device(struct device *dev);
>  
> -static struct i2c_driver w83781d_driver = {
> -	.driver = {
> -		.name = "w83781d",
> -	},
> -	.attach_adapter = w83781d_attach_adapter,
> -	.detach_client = w83781d_detach_client,
> -};
> -
>  /* following are the sysfs callback functions */
>  #define show_in_reg(reg) \
>  static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
> @@ -825,46 +814,16 @@ static SENSOR_DEVICE_ATTR(temp2_type, S_
>  static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
>  	show_sensor, store_sensor, 2);
>  
> -/* This function is called when:
> -     * w83781d_driver is inserted (when this module is loaded), for each
> -       available adapter
> -     * when a new adapter is inserted (and w83781d_driver is still present)
> -   We block updates of the ISA device to minimize the risk of concurrent
> -   access to the same W83781D chip through different interfaces. */
> -static int
> -w83781d_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	struct w83781d_data *data = w83781d_data_if_isa();
> -	int err;
> -
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -
> -	if (data)
> -		mutex_lock(&data->update_lock);
> -	err = i2c_probe(adapter, &addr_data, w83781d_detect);
> -	if (data)
> -		mutex_unlock(&data->update_lock);
> -	return err;
> -}

You can't just get rid of this function. You still need to hold the ISA
device mutex during I2C detection. This part must go in function
w83781d_detect(). See for example:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm78-05-convert-to-new-style-i2c.patch

> -
>  /* Assumes that adapter is of I2C, not ISA variety.
>   * OTHERWISE DON'T CALL THIS
>   */
>  static int
> -w83781d_detect_subclients(struct i2c_adapter *adapter, int address, int kind,
> -		struct i2c_client *new_client)
> +w83781d_detect_subclients(struct i2c_client *new_client)

Note: that's the kind of change that could have been done in a
preliminary patch. Small incremental patches make testing and review
way easier.

>  {
> -	int i, val1 = 0, id;
> -	int err;
> -	const char *client_name = "";
>  	struct w83781d_data *data = i2c_get_clientdata(new_client);
> -
> -	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
> -	if (!(data->lm75[0])) {
> -		err = -ENOMEM;
> -		goto ERROR_SC_0;
> -	}
> +	struct i2c_adapter *adapter = new_client->adapter;
> +	int i, val1 = 0, id, err;
> +	int address = new_client->addr;
>  
>  	id = i2c_adapter_id(adapter);
>  
> @@ -876,31 +835,39 @@ w83781d_detect_subclients(struct i2c_ada
>  					"address %d; must be 0x48-0x4f\n",
>  					force_subclients[i]);
>  				err = -EINVAL;
> -				goto ERROR_SC_1;
> +				goto ERROR_SC_0;
>  			}
>  		}
>  		w83781d_write_value(data, W83781D_REG_I2C_SUBADDR,
>  				(force_subclients[2] & 0x07) |
>  				((force_subclients[3] & 0x07) << 4));
> -		data->lm75[0]->addr = force_subclients[2];
> +		data->lm75[0] = i2c_new_dummy(adapter, force_subclients[2]);
>  	} else {
>  		val1 = w83781d_read_value(data, W83781D_REG_I2C_SUBADDR);
> -		data->lm75[0]->addr = 0x48 + (val1 & 0x07);
> +		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val1 & 0x07));
> +	}
> +	if (!data->lm75[0]) {
> +		dev_err(&new_client->dev,
> +			"subclient 0 registration failed\n");

For debugging/support purposes, it might be useful to mention in the
message which address was tried. For example, the asb100 driver does
the following:

		dev_err(&client->dev, "subclient %d registration "
			"at address 0x%x failed.\n", 1, sc_addr[0]);

It would also be good to be consistent with that driver and number the
subclients 1 and 2 rather than 0 and 1.

> +		err = -ENOMEM;
> +		goto ERROR_SC_0;
>  	}
>  
> -	if (kind != w83783s) {
> -		data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
> -		if (!(data->lm75[1])) {
> +	if (data->type != w83783s) {
> +		if (force_subclients[0] = id &&
> +		    force_subclients[1] = address)
> +			data->lm75[1] > +				i2c_new_dummy(adapter, force_subclients[3]);
> +		else
> +			data->lm75[1] > +				i2c_new_dummy(adapter,
> +					      0x48 + ((val1 >> 4) & 0x07));
> +		if (!data->lm75[1]) {
> +			dev_err(&new_client->dev,
> +				"subclient 1 registration failed\n");
>  			err = -ENOMEM;
>  			goto ERROR_SC_1;
>  		}
> -
> -		if (force_subclients[0] = id &&
> -		    force_subclients[1] = address) {
> -			data->lm75[1]->addr = force_subclients[3];
> -		} else {
> -			data->lm75[1]->addr = 0x48 + ((val1 >> 4) & 0x07);
> -		}
>  		if (data->lm75[0]->addr = data->lm75[1]->addr) {
>  			dev_err(&new_client->dev,
>  			       "Duplicate addresses 0x%x for subclients.\n",
> @@ -909,45 +876,13 @@ w83781d_detect_subclients(struct i2c_ada
>  			goto ERROR_SC_2;
>  		}
>  	}
> -
> -	if (kind = w83781d)
> -		client_name = "w83781d subclient";
> -	else if (kind = w83782d)
> -		client_name = "w83782d subclient";
> -	else if (kind = w83783s)
> -		client_name = "w83783s subclient";
> -	else if (kind = as99127f)
> -		client_name = "as99127f subclient";
> -
> -	for (i = 0; i <= 1; i++) {
> -		/* store all data in w83781d */
> -		i2c_set_clientdata(data->lm75[i], NULL);
> -		data->lm75[i]->adapter = adapter;
> -		data->lm75[i]->driver = &w83781d_driver;
> -		data->lm75[i]->flags = 0;
> -		strlcpy(data->lm75[i]->name, client_name,
> -			I2C_NAME_SIZE);
> -		if ((err = i2c_attach_client(data->lm75[i]))) {
> -			dev_err(&new_client->dev, "Subclient %d "
> -				"registration at address 0x%x "
> -				"failed.\n", i, data->lm75[i]->addr);
> -			if (i = 1)
> -				goto ERROR_SC_3;
> -			goto ERROR_SC_2;
> -		}
> -		if (kind = w83783s)
> -			break;
> -	}
> -
>  	return 0;
>  
> -/* Undo inits in case of errors */
> -ERROR_SC_3:
> -	i2c_detach_client(data->lm75[0]);
> +	/* Undo inits in case of errors */
>  ERROR_SC_2:
> -	kfree(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[1]);
>  ERROR_SC_1:
> -	kfree(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[0]);
>  ERROR_SC_0:
>  	return err;
>  }
> @@ -1114,87 +1049,63 @@ w83781d_create_files(struct device *dev,
>  	return 0;
>  }
>  
> +/* Return 0 if detection is successful, -ENODEV otherwise */
>  static int
> -w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
> +w83781d_detect(struct i2c_client *client, int kind,
> +	       struct i2c_board_info *info)
>  {
>  	int val1 = 0, val2;
> -	struct i2c_client *client;
> -	struct device *dev;
> -	struct w83781d_data *data;
> -	int err;
> +	struct i2c_adapter *adapter = client->adapter;
> +	int address = client->addr;
>  	const char *client_name = "";
>  	enum vendor { winbond, asus } vendid;
>  
> -	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> -		err = -EINVAL;
> -		goto ERROR1;
> -	}
> -
> -	/* OK. For now, we presume we have a valid client. We now create the
> -	   client structure, even though we cannot fill it completely yet.
> -	   But it allows us to access w83781d_{read,write}_value. */
> -
> -	if (!(data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto ERROR1;
> -	}
> -
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	mutex_init(&data->lock);
> -	client->adapter = adapter;
> -	client->driver = &w83781d_driver;
> -	dev = &client->dev;
> -
> -	/* Now, we do the remaining detection. */
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
>  
>  	/* The w8378?d may be stuck in some other bank than bank 0. This may
>  	   make reading other information impossible. Specify a force=... or
>  	   force_*=... parameter, and the Winbond will be reset to the right
>  	   bank. */
>  	if (kind < 0) {
> -		if (w83781d_read_value(data, W83781D_REG_CONFIG) & 0x80) {
> +		if (w83781d_read_value_i2c(client, W83781D_REG_CONFIG) & 0x80) {

You are right that calling w83781d_read_value() in this detection
function isn't correct, however calling w83781d_read_value_i2c() is no
better. By definition, in a detection function, we don't know if the
device we are accessing is ours or not. So we should only use standard
i2c_smbus_read_byte_data() calls at this point. This is the best way to
guarantee that we only issue read transactions to the chip.

One advantage is that you no longer have to change the prototype of
function w83781d_read_value_i2c(), so smaller patch.

>  			dev_dbg(&adapter->dev, "Detection of w83781d chip "
>  				"failed at step 3\n");
> -			err = -ENODEV;
> -			goto ERROR2;
> +			return -ENODEV;
>  		}
> -		val1 = w83781d_read_value(data, W83781D_REG_BANK);
> -		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
> +		val1 = w83781d_read_value_i2c(client, W83781D_REG_BANK);
> +		val2 = w83781d_read_value_i2c(client, W83781D_REG_CHIPMAN);
>  		/* Check for Winbond or Asus ID if in bank 0 */
>  		if ((!(val1 & 0x07)) &&
>  		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
>  		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
>  			dev_dbg(&adapter->dev, "Detection of w83781d chip "
>  				"failed at step 4\n");
> -			err = -ENODEV;
> -			goto ERROR2;
> +			return -ENODEV;
>  		}
>  		/* If Winbond SMBus, check address at 0x48.
>  		   Asus doesn't support, except for as99127f rev.2 */
>  		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
>  		    ((val1 & 0x80) && (val2 = 0x5c))) {
> -			if (w83781d_read_value
> -			    (data, W83781D_REG_I2C_ADDR) != address) {
> +			if (w83781d_read_value_i2c
> +			    (client, W83781D_REG_I2C_ADDR) != address) {
>  				dev_dbg(&adapter->dev, "Detection of w83781d "
>  					"chip failed at step 5\n");
> -				err = -ENODEV;
> -				goto ERROR2;
> +				return -ENODEV;
>  			}
>  		}
>  	}
>  
>  	/* We have either had a force parameter, or we have already detected the
>  	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
> -	w83781d_write_value(data, W83781D_REG_BANK,
> -			    (w83781d_read_value(data, W83781D_REG_BANK)
> -			     & 0x78) | 0x80);
> +	w83781d_write_value_i2c(client, W83781D_REG_BANK,
> +		(w83781d_read_value_i2c(client, W83781D_REG_BANK)
> +		 & 0x78) | 0x80);

Should be i2c_smbus_write_byte_data().

>  
>  	/* Determine the chip type. */
>  	if (kind <= 0) {
>  		/* get vendor ID */
> -		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
> +		val2 = w83781d_read_value_i2c(client, W83781D_REG_CHIPMAN);

Should be i2c_smbus_read_byte_data(), and again below.

>  		if (val2 = 0x5c)
>  			vendid = winbond;
>  		else if (val2 = 0x12)
> @@ -1202,11 +1113,10 @@ w83781d_detect(struct i2c_adapter *adapt
>  		else {
>  			dev_dbg(&adapter->dev, "w83781d chip vendor is "
>  				"neither Winbond nor Asus\n");
> -			err = -ENODEV;
> -			goto ERROR2;
> +			return -ENODEV;
>  		}
>  
> -		val1 = w83781d_read_value(data, W83781D_REG_WCHIPID);
> +		val1 = w83781d_read_value_i2c(client, W83781D_REG_WCHIPID);
>  		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
>  			kind = w83781d;
>  		else if (val1 = 0x30 && vendid = winbond)
> @@ -1220,16 +1130,7 @@ w83781d_detect(struct i2c_adapter *adapt
>  				dev_warn(&adapter->dev, "Ignoring 'force' "
>  					 "parameter for unknown chip at "
>  					 "address 0x%02x\n", address);
> -			err = -EINVAL;
> -			goto ERROR2;
> -		}
> -
> -		if ((kind = w83781d || kind = w83782d)
> -		 && w83781d_alias_detect(client, val1)) {
> -			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
> -				"be the same as ISA device\n", address);
> -			err = -ENODEV;
> -			goto ERROR2;
> +			return -ENODEV;

Why did you move this to the probe() function? In the lm78 driver I
left it in the detect() function. It can be discussed where it better
fits (both have their advantages) but we need to be consistent across
drivers. And leaving it here avoids a number of changes across the
driver.

>  		}
>  	}
>  
> @@ -1241,89 +1142,115 @@ w83781d_detect(struct i2c_adapter *adapt
>  		client_name = "w83783s";
>  	} else if (kind = as99127f) {
>  		client_name = "as99127f";
> -	}
> +	} else
> +		return -ENODEV;

This can't actually happen.

>  
>  	/* Fill in the remaining client fields and put into the global list */

This comment most go away, it no longer applies.

> -	strlcpy(client->name, client_name, I2C_NAME_SIZE);
> -	data->type = kind;
> +	strlcpy(info->type, client_name, I2C_NAME_SIZE);
>  
> -	/* Tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(client)))
> -		goto ERROR2;
> +	return 0;
> +}
> +
> +static int
> +w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	struct device *dev = &client->dev;
> +	struct w83781d_data *data;
> +	int err;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		err = -EINVAL;
> +		goto ERROR1;
> +	}

This test was already done in the detect() function, so no point in
doing it again.

> +
> +	data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto ERROR1;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->lock);
> +	mutex_init(&data->update_lock);
> +
> +	data->type = id->driver_data;
> +	data->client = client;
> +
> +	if ((data->type = w83781d || data->type = w83782d) &&
> +	    w83781d_alias_detect(client)) {
> +		dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
> +			"be the same as ISA device\n", client->addr);
> +		err = -ENODEV;
> +		goto ERROR1;
> +	}
>  
>  	/* attach secondary i2c lm75-like clients */
> -	if ((err = w83781d_detect_subclients(adapter, address,
> -			kind, client)))
> -		goto ERROR3;
> +	err = w83781d_detect_subclients(client);
> +	if (err)
> +		goto ERROR2;
>  
>  	/* Initialize the chip */
>  	w83781d_init_device(dev);
>  
>  	/* Register sysfs hooks */
> -	err = w83781d_create_files(dev, kind, 0);
> +	err = w83781d_create_files(dev, data->type, 0);
>  	if (err)
> -		goto ERROR4;
> +		goto ERROR3;
>  
>  	data->hwmon_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		err = PTR_ERR(data->hwmon_dev);
> -		goto ERROR4;
> +		goto ERROR3;
>  	}
>  
> +	dev_info(&client->dev, "%s: sensor '%s'\n",
> +		 data->hwmon_dev->bus_id, client->name);

No other driver does this. If we were to do that, this would go in the
common hwmon code, not in each and every driver.

> +
>  	return 0;
>  
> -ERROR4:
> +ERROR3:

You can keep this one named ERROR4 to minimize the changes. Ideally
these labels should be renamed to something better anyway (but not in
this patch.)

>  	sysfs_remove_group(&dev->kobj, &w83781d_group);
>  	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
>  
> -	if (data->lm75[1]) {
> -		i2c_detach_client(data->lm75[1]);
> -		kfree(data->lm75[1]);
> -	}
> -	if (data->lm75[0]) {
> -		i2c_detach_client(data->lm75[0]);
> -		kfree(data->lm75[0]);
> -	}
> -ERROR3:
> -	i2c_detach_client(client);
> +	if (data->lm75[1])

You obviously mean data->lm75[0];

> +		i2c_unregister_device(data->lm75[0]);
> +	if (data->lm75[1])
> +		i2c_unregister_device(data->lm75[1]);
>  ERROR2:
> +	i2c_set_clientdata(client, NULL);
>  	kfree(data);
>  ERROR1:
>  	return err;
>  }
>  
>  static int
> -w83781d_detach_client(struct i2c_client *client)
> +w83781d_remove(struct i2c_client *client)
>  {
>  	struct w83781d_data *data = i2c_get_clientdata(client);
> -	int err;
> +	struct device *dev = &client->dev;
>  
> -	/* main client */
> -	if (data) {
> -		hwmon_device_unregister(data->hwmon_dev);
> -		sysfs_remove_group(&client->dev.kobj, &w83781d_group);
> -		sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
> -	}
> +	hwmon_device_unregister(data->hwmon_dev);
>  
> -	if ((err = i2c_detach_client(client)))
> -		return err;
> +	sysfs_remove_group(&dev->kobj, &w83781d_group);
> +	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
>  
> -	/* main client */
> -	if (data)
> -		kfree(data);
> +	if (data->lm75[1])

Here again you mean data->lm75[0];

> +		i2c_unregister_device(data->lm75[0]);
> +	if (data->lm75[1])
> +		i2c_unregister_device(data->lm75[1]);
>  
> -	/* subclient */
> -	else
> -		kfree(client);
> +	i2c_set_clientdata(client, NULL);
> +	kfree(data);
>  
>  	return 0;
>  }
>  
>  static int
> -w83781d_read_value_i2c(struct w83781d_data *data, u16 reg)
> +w83781d_read_value_i2c(struct i2c_client *client, u16 reg)
>  {
> -	struct i2c_client *client = &data->client;
> -	int res, bank;
> +	struct w83781d_data *data = i2c_get_clientdata(client);
> +	int res = 0, bank;
>  	struct i2c_client *cl;
>  
>  	bank = (reg >> 8) & 0x0f;
> @@ -1333,7 +1260,7 @@ w83781d_read_value_i2c(struct w83781d_da
>  					  bank);
>  	if (bank = 0 || bank > 2) {
>  		res = i2c_smbus_read_byte_data(client, reg & 0xff);
> -	} else {
> +	} else if (data) {

This change is not needed. You should never call this function before
the client data is set.

>  		/* switch to subclient */
>  		cl = data->lm75[bank - 1];
>  		/* convert from ISA to LM75 I2C addresses */
> @@ -1360,9 +1287,9 @@ w83781d_read_value_i2c(struct w83781d_da
>  }
>  
>  static int
> -w83781d_write_value_i2c(struct w83781d_data *data, u16 reg, u16 value)
> +w83781d_write_value_i2c(struct i2c_client *client, u16 reg, u16 value)
>  {
> -	struct i2c_client *client = &data->client;
> +	struct w83781d_data *data = i2c_get_clientdata(client);
>  	int bank;
>  	struct i2c_client *cl;
>  
> @@ -1374,7 +1301,7 @@ w83781d_write_value_i2c(struct w83781d_d
>  	if (bank = 0 || bank > 2) {
>  		i2c_smbus_write_byte_data(client, reg & 0xff,
>  					  value & 0xff);
> -	} else {
> +	} else if (data) {

Same here.

>  		/* switch to subclient */
>  		cl = data->lm75[bank - 1];
>  		/* convert from ISA to LM75 I2C addresses */
> @@ -1499,7 +1426,7 @@ w83781d_init_device(struct device *dev)
>  static struct w83781d_data *w83781d_update_device(struct device *dev)
>  {
>  	struct w83781d_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = &data->client;
> +	struct i2c_client *client = data->client;
>  	int i;
>  
>  	mutex_lock(&data->update_lock);
> @@ -1612,6 +1539,30 @@ static struct w83781d_data *w83781d_upda
>  	return data;
>  }
>  
> +static const struct i2c_device_id w83781d_ids[] = {
> +	{ "w83781d", w83781d, },
> +	{ "w83782d", w83782d, },
> +	{ "w83783s", w83783s, },
> +	{ "as99127f", as99127f },
> +	{ /* LIST END */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, w83781d_ids);
> +
> +static struct i2c_driver w83781d_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "w83781d",
> +	},
> +	.probe		= w83781d_probe,
> +	.remove		= w83781d_remove,
> +	.id_table	= w83781d_ids,
> +	.detect		= w83781d_detect,
> +	.address_data	= &addr_data,
> +};
> +
> +/*
> + * ISA related code
> + */
>  #ifdef CONFIG_ISA
>  
>  /* ISA device, if found */
> @@ -1625,19 +1576,15 @@ static ssize_t
>  show_name(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
>  	struct w83781d_data *data = dev_get_drvdata(dev);
> -	return sprintf(buf, "%s\n", data->client.name);
> +	return sprintf(buf, "%s\n", data->client->name);
>  }
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

This won't work. ISA devices do not have data->client, so this will
crash. You need to add data->name for ISA devices.

>  
> -static struct w83781d_data *w83781d_data_if_isa(void)
> -{
> -	return pdev ? platform_get_drvdata(pdev) : NULL;
> -}
> -
>  /* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
> -static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
> +static int w83781d_alias_detect(struct i2c_client *client)
>  {
>  	struct w83781d_data *i2c, *isa;
> +	u8 chipid;
>  	int i;
>  
>  	if (!pdev)	/* No ISA chip */
> @@ -1648,6 +1595,7 @@ static int w83781d_alias_detect(struct i
>  
>  	if (w83781d_read_value(isa, W83781D_REG_I2C_ADDR) != client->addr)
>  		return 0;	/* Address doesn't match */
> +	chipid = w83781d_read_value(i2c, W83781D_REG_WCHIPID);
>  	if (w83781d_read_value(isa, W83781D_REG_WCHIPID) != chipid)
>  		return 0;	/* Chip type doesn't match */
>  
> @@ -1671,7 +1619,7 @@ static int w83781d_alias_detect(struct i
>  static int
>  w83781d_read_value_isa(struct w83781d_data *data, u16 reg)
>  {
> -	struct i2c_client *client = &data->client;
> +	struct i2c_client *client = data->client;
>  	int word_sized, res;
>  
>  	word_sized = (((reg & 0xff00) = 0x100)
> @@ -1705,7 +1653,7 @@ w83781d_read_value_isa(struct w83781d_da
>  static void
>  w83781d_write_value_isa(struct w83781d_data *data, u16 reg, u16 value)
>  {
> -	struct i2c_client *client = &data->client;
> +	struct i2c_client *client = data->client;
>  	int word_sized;
>  
>  	word_sized = (((reg & 0xff00) = 0x100)
> @@ -1742,12 +1690,12 @@ w83781d_write_value_isa(struct w83781d_d
>  static int
>  w83781d_read_value(struct w83781d_data *data, u16 reg)
>  {
> -	struct i2c_client *client = &data->client;
> +	struct i2c_client *client = data->client;
>  	int res;
>  
>  	mutex_lock(&data->lock);
>  	if (client->driver)
> -		res = w83781d_read_value_i2c(data, reg);
> +		res = w83781d_read_value_i2c(client, reg);
>  	else
>  		res = w83781d_read_value_isa(data, reg);
>  	mutex_unlock(&data->lock);
> @@ -1757,11 +1705,11 @@ w83781d_read_value(struct w83781d_data *
>  static int
>  w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
>  {
> -	struct i2c_client *client = &data->client;
> +	struct i2c_client *client = data->client;
>  
>  	mutex_lock(&data->lock);
>  	if (client->driver)
> -		w83781d_write_value_i2c(data, reg, value);
> +		w83781d_write_value_i2c(client, reg, value);
>  	else
>  		w83781d_write_value_isa(data, reg, value);
>  	mutex_unlock(&data->lock);
> @@ -1790,8 +1738,8 @@ w83781d_isa_probe(struct platform_device
>  		goto exit_release_region;
>  	}
>  	mutex_init(&data->lock);
> -	data->client.addr = res->start;
> -	i2c_set_clientdata(&data->client, data);
> +	data->client->addr = res->start;

This won't work either.

> +	i2c_set_clientdata(data->client, data);

Don't even think of it ;)

>  	platform_set_drvdata(pdev, data);
>  
>  	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
> @@ -1804,7 +1752,7 @@ w83781d_isa_probe(struct platform_device
>  		data->type = w83781d;
>  		name = "w83781d";
>  	}
> -	strlcpy(data->client.name, name, I2C_NAME_SIZE);
> +	strlcpy(data->client->name, name, I2C_NAME_SIZE);
>  
>  	/* Initialize the W83781D chip */
>  	w83781d_init_device(&pdev->dev);
> @@ -1846,7 +1794,7 @@ w83781d_isa_remove(struct platform_devic
>  	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
>  	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
>  	device_remove_file(&pdev->dev, &dev_attr_name);
> -	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
> +	release_region(data->client->addr + W83781D_ADDR_REG_OFFSET, 2);
>  	kfree(data);
>  
>  	return 0;
> @@ -2030,13 +1978,8 @@ w83781d_isa_unregister(void)
>  }
>  #else /* !CONFIG_ISA */
>  
> -static struct w83781d_data *w83781d_data_if_isa(void)
> -{
> -	return NULL;
> -}
> -
>  static int
> -w83781d_alias_detect(struct i2c_client *client, u8 chipid)
> +w83781d_alias_detect(struct i2c_client *client)
>  {
>  	return 0;
>  }
> @@ -2044,10 +1987,11 @@ w83781d_alias_detect(struct i2c_client *
>  static int
>  w83781d_read_value(struct w83781d_data *data, u16 reg)
>  {
> +	struct i2c_client *client = data->client;
>  	int res;
>  
>  	mutex_lock(&data->lock);
> -	res = w83781d_read_value_i2c(data, reg);
> +	res = w83781d_read_value_i2c(client, reg);
>  	mutex_unlock(&data->lock);
>  
>  	return res;
> @@ -2056,8 +2000,10 @@ w83781d_read_value(struct w83781d_data *
>  static int
>  w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
>  {
> +	struct i2c_client *client = data->client;
> +
>  	mutex_lock(&data->lock);
> -	w83781d_write_value_i2c(data, reg, value);
> +	w83781d_write_value_i2c(client, reg, value);
>  	mutex_unlock(&data->lock);
>  
>  	return 0;
> @@ -2092,9 +2038,9 @@ sensors_w83781d_init(void)
>  
>  	return 0;
>  
> - exit_unreg_isa:
> +exit_unreg_isa:
>  	w83781d_isa_unregister();
> - exit:
> +exit:

Useless changes, please revert.

>  	return res;
>  }
>  

Please let me know how you want to proceed from here. Do you want to
rework this patch and post an update (one or more patches)? Or do you
prefer that I make all the updates myself, and then you test and review
the patch?

My current set of patches for the w83781d driver is here:
http://jdelvare.pck.nerim.net/sensors/w83781d/

Any patch update you send should apply on top of that. Also, the first
3 patches need to be tested, reviewed and acked before I can push them
upstream. Can you please help me with this? Ideally I would like to get
all the w83781d patches sorted out quickly so that they can spend some
time in linux-next and then be sent to Linus during the 2.6.28 merge
window.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
