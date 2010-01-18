From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jan 2010 16:12:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add driver for ADT7411
Message-Id: <20100118171206.40d99633@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfram,

On Mon, 18 Jan 2010 16:02:57 +0100, Wolfram Sang wrote:
> Hi Jean,
> > It seems to me that you are only using a small subset of the registers
> > defined above. I suggest not defining registers you don't use, as it
> > only makes the code bigger with no benefit. The datasheet of this chip
> > is publicly available, if anybody needs a reference.
> 
> The intention was to spare other people copying this data again, but I get your
> point and agree.
> 
> > Logic seems overly complex. Do you have such an unreliable I2C bus that
> > transient failures are frequent?
> 
> The customer had a very "hostile" environment, so this was needed. It could be
> rated as a special extension and dropped, of course. I saw it in some other
> drivers (lm93) and wasn't sure about the preferred way.

I didn't remember about the lm93 precedent, I admit. Maybe the
contributor had also a hostile environment, I just don't know.

I do remember about the w83l785ts precedent though. That's a different
case, as the problem was with the chip itself. Another chip on the same
bus did not have any problems.

My own position is that, unless the _chip_ itself sometimes doesn't ack
its slave address or somehow fails, there is no reason for the chip
driver to implement retries. If the bus is misbehaving, be it for
hardware or software reasons, then the workaround must go in the bus
driver.

> > > +	u8 lsb_reg = ADT7411_REG_EXT_TEMP_AIN14_LSB + (nr >> 2);
> > > +	u8 lsb_shift = (nr & 0x03) << 1;
> > 
> > "2 * (nr & 0x03)" would be easier to understand.
> 
> Really? Will do, but when it comes to registers and bit positions, I like
> shifting better.

And so do I, but the above shift has nothing to do with bit positions.
The "2 *" is there because you have blocks of 2 bits. If you had blocks
of 3 bits instead, you'd do "3 *". It just happens that "<< 1" is
equivalent to "2 *", but what would be the "<<" equivalent of "3 *"?

The ">>" which has something to do with bit positions is elsewhere, in
adt7411_read_10_bit():

		val = (ret >> lsb_shift) & 3;

> > > +static ssize_t adt7411_set_bit(struct device *dev, struct device_attribute *attr,
> > > +			     const char *buf, size_t count)
> > > +{
> > > +	struct sensor_device_attribute_2 *s_attr2 = to_sensor_dev_attr_2(attr);
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct adt7411_data *data = i2c_get_clientdata(client);
> > > +	int reg, bit, ret;
> > > +	unsigned long val;
> > > +
> > > +	ret = strict_strtoul(buf, 0, &val);
> > > +
> > > +	if (ret || val > 1)
> > > +		return -EINVAL;
> > > +
> > > +	reg = s_attr2->index;
> > > +	bit = s_attr2->nr;
> > > +
> > > +	if (val)
> > > +		data->config[reg] |= bit;
> > > +	else
> > > +		data->config[reg] &= ~bit;
> > > +
> > > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1 + reg,
> > > +		data->config[reg]);
> > > +	return count;
> > > +}
> > 
> > This assumes that nobody else ever changes the configuration registers.
> > That's an unsafe assumption... Not only external users of the chip
> > could (think multi-master I2C setups) but even concurrent users of your
> > own driver could! So you want to read the register value instead of
> > relying on a cached value. And if you want to keep a cache (which
> > doesn't seem terribly needed to me),you also want to protect the
> > read-modify-write operation with a mutex.
> 
> Right, but the mutex is needed for the non-cached I2C-based RMW, too, no?

Err, yes, you're right. I'm no longer sure what I had in mind when I
implied it was not.

> Rest is also accepted, of course. Thanks for the review!

You're welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
