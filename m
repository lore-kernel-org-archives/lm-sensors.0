From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 16:04:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add driver for ADT7411
Message-Id: <20100121170433.6e2e8751@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Jan 2010 16:45:02 +0100, Wolfram Sang wrote:
> Hi Jean,
> 
> some questions arouse:
> 
> > > +static int __devinit adt7411_probe(struct i2c_client *client,
> > > +				   const struct i2c_device_id *id)
> > > +{
> > > +	int val;
> > > +	struct adt7411_data *data;
> > > +
> > > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> > > +		return -ENODEV;
> > > +
> > > +	val = i2c_smbus_read_byte_data(client, ADT7411_REG_MANUFACTURE_ID);
> > > +	if (val < 0 || val != ADT7411_MANUFACTURE_ID) {
> > > +		dev_err(&client->dev, "Wrong manufacturer ID. Got %d, "
> > > +			"expected %d\n", val, ADT7411_MANUFACTURE_ID);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	val = i2c_smbus_read_byte_data(client, ADT7411_REG_DEVICE_ID);
> > > +	if (val < 0 || val != ADT7411_DEVICE_ID) {
> > > +		dev_err(&client->dev, "Wrong device ID. Got %d, "
> > > +			"expected %d\n", val, ADT7411_DEVICE_ID);
> > > +		return -ENODEV;
> > > +	}
> > 
> > This is the wrong place for this check. Device identification goes into
> > a .detect() function. By the time .probe() is called, you already know
> > what device is there.
> 
> Just came to think of it: That essentially kills all sanity checks for platform
> devices (or static board_infos), or am I wrong? Would it be an idea to call
> detect() for the address in the board_info, or are board_infos considered per
> se correct?

The board info are supposed to be correct, and more trustworthy that
the detect routine. Think of the case where you have fully compatible
devices from different vendors and either one can be present.

The case of "optional" devices has been discussed on this list in the
past. My conclusion (possibly not shared by everyone) was that such
devices did not belong to the board_info and should be instantiated
using i2c_new_detected_device() later. I am ready to revisit this
decision if new cases don't fit, however this won't change the fact
that, by default, I2C devices listed in board_info are assumed to be
present.

> > > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&data->lsb_msb_lock);
> > > +
> > > +	data->config[0] = ADT7411_CFG1_START_MONITOR | ADT7411_CFG1_RESERVED1;
> > > +	data->config[1] = ADT7411_CFG2_ENABLE_SMBUS_TO;
> > > +	data->config[2] = ADT7411_CFG3_RESERVED1 | ADT7411_CFG3_REF_VDD;
> > > +
> > > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG2, ADT7411_CFG2_RESET);
> > > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG2, data->config[1]);
> > > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG3, data->config[2]);
> > > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1, data->config[0]);
> > 
> > This is bad practice. The BIOS/firmware might have setup the chip
> > already. Resetting and then overwriting this configuration is bad. If
> > you want to enforce a specific setup, this is a platform decision and
> > you should provide the initialization data as platform data.
> 
> I assume ORing ADT7411_CFG1_START_MONITOR is OK, though?

Yes it is... but keep in mind that the device might as well have been
left unconfigured then. You should double check that operating the
device in a mode which doesn't match the physical wiring can't do any
hardware damage. If exact configuration is important then I wouldn't
mind making the platform_data for this device mandatory.

> What about
> ADT7411_CFG2_ENABLE_SMBUS_TO (SMBus Timeout)? Is this a user preference or a
> driver trying to keep his bus alive?

I'm not sure. I've never used that myself, I don't really know in which
cases it is desirable and in which case it's not. I leave it to your
judgment.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
