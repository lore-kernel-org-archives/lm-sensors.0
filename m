From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Fri, 16 Mar 2007 16:44:32 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703161744.34740.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag, 15. M?rz 2007 21:10 schrieb Jean Delvare:


Jean,
Thank you for your detailed review! Here's the next iteration.

> So please get rid of mode and counttime.

Done.

>
> About module parameters: please don't initialize them to -1 if you
> don't need to. The compiler can optimize static globals which default
> to zero nicely.

Done.

>
> > sysfs files follow the specification as close as possible. I used
> > pwm1_enable=3 for "fan off". There is no other possibility to switch the
> > fan off, setting pwm1_enable to 1 and fan1_target to 0 doesn't turn it
> > off completely.
>
> I don't understand. For one thing, if you know how to turn the fan off,
> then you could do it when fan1_target is set to 0, it's just a matter
> of adding a few more lines of code. For another, fan1_target is related
> to the closed loop mode (pwm1_enable=2) while the fan off mode would
> generally be implemented as part of the open loop mode: pwm1_enable=1
> and pwm1=0. But I see that you don't have a pwm1 file, so... How does
> the open loop mode work at all?

Open loop mode just sets the ouput voltage according to a DAC value (0..255).
If someone needs a defined speed, he's supposed to do the regulator in 
software. It is not influenced by the speed register used in closed loop 
mode. I added a pwm1 file to read/write that DAC value. After doing that, I 
noticed the fan can be brought to full/zero speed by setting pwm1 to 0 or 
255, respectively. That's OK for me.
For pwm1_enable, I only use the well defined values now: 0=off, 1=open loop, 
2=closed loop. If I find the chip in "full on" mode at load time, I change 
mode to open loop and set it to full speed. I hope this always works and 
won't set somebodies board on fire :-)

BTW, meanwhile I'm a bit confused about what pwm1_enable=0 means. Is it "fan 
off" or "PWM off, fan full on"? At the moment, I implemented "fan off", but I 
can easily change that. The other way round would be slightly simpler.

>
> > You mentioned problems compiling my code. Sorry, I can't reproduce this
> > here. It compiles without any warnings. If you still notice problems,
> > please tell me.
>
> The problem is still there, and I explained why. Quoting myself:
> > > I guess you didn't try with debug enabled...
>
> The driver compiles fine with CONFIG_HWMON_DEBUG_CHIP=n, but fails to
> compile with CONFIG_HWMON_DEBUG_CHIP=y. Try it yourself. It's probably
> trivial to fix, too.

It was and it's fixed now.

>
> I see that you still did not fix the problems Corentin Labbe reported
> after his second review [1]. Please do. When someone takes the time to
> review your code - and it's not exactly a fun job - the least you can
> do is take his/her findings into account for the next iteration of the
> driver.

I agree. I started adding his ideas in one tree, then did something else for a 
few days, and started again in a new tree. His fixes got lost on the way. 
Sorry. I added them now.


> > +voltage_12V: 0=5V fan, 1V fan, -1=don't change
>
> This is no longer true as you changed the convention.

fixed.

> > +static struct i2c_driver max6650_driver = {
> > +	.driver = {
> > +		.name	= "max6650",
> > +	},
> > +	.attach_adapter = max6650_attach_adapter,
> > +	.detach_client  = max6650_detach_client
>
> Please add a comma at the end of this line.

fixed.

> > + *
> > + * Assumptions:
> > + *
> > + * 1) The MAX6650/1 is running from its internal 254kHz clock (perhaps
> > + *    this should be made a module parameter).
>
> Well, it is now.

fixed.

> > +
> > +	dev_dbg(dev, "%s called, rpm=%d\n", __FUNCTION__, rpm);
>
> I read lately that the standard notation is __func__ not __FUNCTION.
> Not that this debug line looks particularly interesting anyway.

True. I removed it.

>
> > +
> > +	mutex_lock(&data->update_lock);
> > +
> > +	rpm = SENSORS_LIMIT(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
>
> You don't need to hold the lock for this instruction.

fixed.

> > +	data->speed  = ktach;
>
> Doubled space.

fixed.

>
> > +
> > +	i2c_smbus_write_byte_data(client, MAX6650_REG_SPEED,  data->speed);
>
> Doubled space.

fixed.


> > +static ssize_t get_enable(struct device *dev, struct device_attribute
> > *devattr, +			 char *buf)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct max6650_data *data = i2c_get_clientdata(client);
>
> You are supposed to call the update function here, otherwise
> data->config may not be valid.

Very true. Fixed.

> > +
> > +	i2c_smbus_write_byte_data(client, MAX6650_REG_CONFIG, data->config);
>
> You shouldn't touch data->config without holding data->update_lock.
> Also, you should read the value of MAX6650_REG_CONFIG from the device
> before changing it, as you are not writing all the bits.

fixed.

> > +static ssize_t get_div(struct device *dev, struct device_attribute
> > *devattr, +			char *buf)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct max6650_data *data = i2c_get_clientdata(client);
>
> Here again you forgot to call the update function.

fixed.

>
> > +
> > +	return sprintf(buf, "%d\n", 1 << data->count);
>
> Why don't you use DIV_FROM_REG?

fixed.

>
> > +}
> > +
> > +static ssize_t set_div(struct device *dev, struct device_attribute
> > *devattr, +			const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct max6650_data *data = i2c_get_clientdata(client);
> > +	int div = simple_strtoul(buf, NULL, 10);
> > +
> > +	switch (div) {
> > +	case 1:
> > +		data->count = 0;
> > +		break;
> > +	case 2:
> > +		data->count = 1;
> > +		break;
> > +	case 4:
> > +		data->count = 2;
> > +		break;
> > +	case 8:
> > +		data->count = 3;
> > +		break;
> > +	default:
> > +		return count;
>
> This returns with success, while you were not able to set the divider
> the user requested! Better return an error (-EINVAL) possibly with a
> message in the logs.

fixed.

>
> > +	}
> > +
> > +	i2c_smbus_write_byte_data(client, MAX6650_REG_COUNT, data->count);
>
> Again the while section should be protected by taking the
> data->update_lock mutex.

I guess you meant the switch section. Fixed.

> > +static struct attribute *max6650_attrs[] = {
> > +	&dev_attr_fan1_input.attr,
> > +	&dev_attr_fan2_input.attr,
> > +	&dev_attr_fan3_input.attr,
> > +	&dev_attr_fan4_input.attr,
> > +	&dev_attr_fan1_target.attr,
> > +	&dev_attr_pwm1_enable.attr,
> > +	&dev_attr_fan1_div.attr,
> > +	NULL,
>
> No comma at the end of this one - it cannot be extended by definition.

True. Fixed.

> > +
> > +static int max6650_attach_adapter(struct i2c_adapter *adapter)
> > +{
> > +	dev_dbg(adapter->dev, "max6650_attach_adapter called for %s\n",
> > +		(char*)&adapter->name);
>
> This is bogus.

Removed.

> > +static int max6650_detect(struct i2c_adapter *adapter, int address, int
> > kind) +{
> > +	struct i2c_client *new_client;
>
> Please rename this to just "client". I know many other drivers do that,
> but it sucks. It's pretty obvious that the client is new.

Done.

>
> > +	struct max6650_data *data;
> > +	int err = -ENODEV;
> > +	const char *name = "";
> > +
> > +	dev_dbg(adapter->dev, "max6650_detect called, kind = %d\n",kind);
>
> Missing space after comma.

Fixed.

>
> > +
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> > +		dev_dbg(adapter->dev, "MAX6650: I2C bus doesn't support byte"
>
> Missing space at the end of the first part of the string.

Fixed.

>
> > +			"read mode, skipping.\n");
> > +		return 0;
> > +	}
> > +
> > +	if (!(data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL))) {
> > +		printk("MAX6650: Out of memory in max6650_detect "
>
> Please either switch to dev_err(&adapter->dev, ...) or at least add
> KERN_ERR before the string.

Used dev_err() instead.

>
> > +			"(new_client).\n");
>
> You are actually trying to allocate "data", not "new_client". But given
> that there's a single allocation in the whole driver anyway...

Simplified the message.

>
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/*
> > +	 * The common I2C client data is placed right before the
> > +	 * max6650-specific data. The max6650-specific data is pointed to by
> > +	 * the data field from the I2C client data.
> > +	 */
>
> Please rip off this useless comment.

Done.

>
> > +
> > +	new_client = &data->client;
> > +	i2c_set_clientdata(new_client, data);
> > +	new_client->addr = address;
> > +	new_client->adapter = adapter;
> > +	new_client->driver = &max6650_driver;
> > +	new_client->flags = 0;
>
> You can omit this one, the kzalloc above already set the flags to 0.

Done.

>
> > +
> > +	/*
> > +	 * Now we do the remaining detection. A negative kind means that
> > +	 * the driver was loaded with no force parameter (default), so we
> > +	 * must both detect and identify the chip (actually there is only
> > +	 * one possible kind of chip for now, max6650). A zero kind means that
> > +	 * the driver was loaded with the force parameter, the detection
> > +	 * step shall be skipped. A positive kind means that the driver
> > +	 * was loaded with the force parameter and a given kind of chip is
> > +	 * requested, so both the detection and the identification steps
> > +	 * are skipped.
> > +	 *
> > +	 * Currently I can find no way to distinguish between a MAX6650 and
> > +	 * a MAX6651. This driver has only been tried on the latter.
> > +	 */
>
> I thought it was on the former?

Sure. Fixed.

>
> > +
> > +	if ((kind < 0)&&
> > +	   (  (i2c_smbus_read_byte_data(new_client,MAX6650_REG_CONFIG) & 0xC0)
> > +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_GPIO_STAT)&
> > 0xE0) +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_ALARM_EN)
> > & 0xE0) +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_ALARM) &
> > 0xE0) +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_COUNT) &
> > 0xFC))) +	{
> > +		dev_dbg(adapter->dev, "max6650.o: max6650 detection failed"
>
> Missing space at the end of the first half, and this is not max6650.o.
> Please format all your debug messages the same way, it's confusing
> otherwise.

Done.

>
> > +			"at 0x%02x.\n", address);
> > +
> > +		goto err_free;
> > +        }
>
> Indentation problem, the line above uses spaces instead of a tabulation.

Fixed.

>
> > +
> > +	if (kind <= 0)
> > +		kind = max6650;
> > +
> > +	if (kind = max6650) {
> > +		name = "max6650";
> > +		printk("MAX6650: Chip found at 0x%02x.\n", address);
>
> Missing log level.

Used dev_info() instead.

>
> > +	}
> > +	else {
> > +		printk("MAX6650: Unsupported chip.\n");
>
> Missing log level.

Used dev_info() instead.

>
> > +		goto err_free;
> > +	}
>
> Given that this just cannot happen, and your driver supports only one
> kind anyway, you could simply hardcode the kind and name.

Done.

>
> > +
> > +	/*
> > +	 * OK, we got a valid chip so we can fill in the remaining client
> > +	 * fields.
> > +	 */
> > +
> > +	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> > +	data->valid = 0;
>
> This one too can be omitted.

Done.

>
> > +	mutex_init(&data->update_lock);
> > +
> > +	/*
> > +	 * Tell the I2C layer a new client has arrived.
> > +	 */
> > +
> > +	if ((err = i2c_attach_client(new_client))) {
> > +		dev_dbg(adapter->dev, "max6650.o: Failed attaching client.\n");
> > +		goto err_free;
> > +	}
> > +
> > +	/*
> > +	 * Initialize the max6650 chip
> > +	 */
> > +	if (max6650_init_client(new_client))
> > +		goto err_detach;
> > +
> > +	/* Register sysfs hooks */
> > +	data->class_dev = hwmon_device_register(&new_client->dev);
> > +	if (IS_ERR(data->class_dev)) {
> > +		err = PTR_ERR(data->class_dev);
> > +		goto err_detach;
> > +	}
>
> Please create the files first, and register the class only after that.

Done.

> > +
> > +	hwmon_device_unregister(data->class_dev);
> > +	err = i2c_detach_client(client);
> > +	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
>
> You should remove the files before detaching the client.

Fixed.

>
> > +	kfree(data);
>
> Do not free the memory if you failed to detach the client!

Fixed.

>
> > +	return err;
> > +}
> > +
> > +static int max6650_init_client(struct i2c_client *client)
> > +{
> > +	struct max6650_data *data = i2c_get_clientdata(client);
> > +	const char* mode_strings[4] = {"full-on", "always-off",
> > +					"closed-loop", "open-loop"};
> > +	int config, countreg;
> > +	int err = -ENODEV;
>
> The only errors that can happen here are I/O errors, so that would be
> -EIO.

Fixed.

>
> > +
> > +	mutex_lock(&data->update_lock);
>
> You don't really need to take the mutex here - there's nobody else who
> can access your data at this point.

Fixed.


> > +
> > +	dev_info(&client->dev, "Prescaler is set to %d.\n",
> > +		 DIV_FROM_REG(config) );
>
> This is confusing, you're using DIV_FROM_REG for both the prescaler and
> the counttime. It works more or less by accident...

Right. Fixed.


> > +static struct max6650_data *max6650_update_device(struct device *dev)
> > +{
> > +	int i;
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct max6650_data *data = i2c_get_clientdata(client);
> > +
> > +	mutex_lock(&data->update_lock);
> > +
> > +	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> > +		data->speed = i2c_smbus_read_byte_data(client,
> > +			 			       MAX6650_REG_SPEED);
> > +		data->config = i2c_smbus_read_byte_data(client,
> > +							MAX6650_REG_CONFIG);
> > +		for (i = 0; i < 4; i++) {
> > +			data->tach[i] = i2c_smbus_read_byte_data(client,
> > +								 tach_reg[i]);
> > +		}
> > +		data->count = i2c_smbus_read_byte_data (client,
> > +							MAX6650_REG_COUNT);
>
> Extra space before opening parenthesis.

Fixed.

> > +}
> > +
> > +MODULE_AUTHOR("john.morris at spirentcom.com");
>
> This is more or less your driver now... 

True. There's not much left of the original code. I made myself MODULE_AUTHOR 
and gave credit to the original authors in the heading.

> BTW (I can't remember if I told 
> you already) feel free to add yourself to MAINTAINERS as the maintainer
> for this new driver.

Thank you. Done.

BTW, the patch is against 2.6.21-rc3 now.

Thanks,
Hans

Signed-off-by: Hans J. Koch <hjk at linutronix.de>



-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6650.patch
Type: text/x-diff
Size: 24400 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070316/d60b3806/attachment-0001.bin 
