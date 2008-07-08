From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Jul 2008 13:55:57 +0000
Subject: Re: [lm-sensors] [PATCH] max664x: New driver for Maxim
Message-Id: <20080708155557.50e5da65@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080609111352.GC11300@solarflare.com>
In-Reply-To: <20080609111352.GC11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Tue, 8 Jul 2008 14:13:27 +0100, Ben Hutchings wrote:
> Jean Delvare wrote:
> > Second preliminary note: these chips look suspiciously similar to the
> > LM90, ADM1032 and MAX6657 chips which are supported by the lm90 driver.
> 
> You're right, it is very similar.
> 
> > Are you certain that you need a new driver for them? I've still
> > reviewed your driver, but my feeling is that it may be less work for
> > you to add support for the new chips to the lm90 driver, than to fix
> > your new driver. As far as I can see the only significant difference is
> > the encoding of the temperatures (signed vs. unsigned), and support for
> > that kind of difference has been added to the lm90 driver a few weeks
> > ago.
> 
> There are a few other differences:
> - no remote offset
> - no extended precision for remote limits
> - extended precision for local temperature

According to my notes and
http://jdelvare.pck.nerim.net/sensors/lm90/hwmon-lm90-02-max6657-extra-local-res.patch
http://jdelvare.pck.nerim.net/sensors/lm90/hwmon-lm90-03-max6657-has-no-low-limit-bytes.patch
this is the same as the MAX6657. So we can probably see the MAX6646 as
a MAX6657 using unsigned temperature register values.

> - one-shot conversion and fault queue

All the chips supported by the lm90 driver have one-shot conversion
IIRC (although we don't care), and some of them have a fault queue
(although the driver doesn't make use of this feature.)

> But overall it looks similar enough that it would be easier to update lm90.

OK.

> [...]
> > > +#define TEMP_TO_REG(val) ((val) / 1000)
> > 
> > This lacks proper rounding.
> 
> So should this be
> 	#define TEMP_TO_REG(val) (((val) + 500) / 1000)
> (or a similar expression in an inline function)?

For positive-only temperatures, yes. I see only now that this is also
lacking boundary checks though.

> > > +#define PERIOD_FROM_RATE_REG(val) (16000 >> min_t(int, val, 6))
> > > +#define PERIOD_TO_RATE_REG(val) SENSORS_LIMIT(7 - ffs(val / 250), 0, 6)
> > 
> > Note that in general we try to move away from macros. Using (possibly
> > inline) functions for these conversions is preferred, as it is more
> > readable and lets the compiler do type checks. And less error-prone:
> > your macros lack some parentheses.
>  
> Sorry, I was following the style I saw.

It seems that you've read the lm87 driver which is one of the last
remaining drivers to be cleaned up. Bad luck :(

> [...]
> > > +static ssize_t show_temp_crit_hyst(struct device *dev,
> > > +				   struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct max664x_data *data = max664x_update_device(dev);
> > > +	return sprintf(buf, "%u\n", TEMP_FROM_REG(data->set.temp_overt_hyst));
> > > +}
> > > +
> > > +static ssize_t
> > > +set_temp_crit_hyst(struct device *dev, struct device_attribute *attr,
> > > +		   const char *buf, size_t count)
> > > +{
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct max664x_data *data = i2c_get_clientdata(client);
> > > +	long val = simple_strtol(buf, NULL, 10);
> > > +	u8 reg_val = TEMP_TO_REG(val);
> > > +
> > > +	mutex_lock(&data->update_lock);
> > > +	data->set.temp_overt_hyst = reg_val;
> > > +	i2c_smbus_write_byte_data(client, MAX664X_REG_HYS, reg_val);
> > > +	mutex_unlock(&data->update_lock);
> > > +	return count;
> > > +}
> > 
> > This violates the standard. All temperature values in sysfs should be
> > absolute, not relative.
> 
> So how is hysteresis supposed to be shown?

The driver must compute an absolute temperature based on the delta that
is stored in the register, and the temperature limit this delta applies
to. From the lm90 driver:

static ssize_t show_temphyst(struct device *dev, struct device_attribute *devattr,
			     char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct lm90_data *data = lm90_update_device(dev);
	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index])
		       - TEMP1_FROM_REG(data->temp_hyst));
}

> [...]
> > > +int max664x_read_status(struct i2c_client *client)
> > > +{
> > > +	return i2c_smbus_read_byte_data(client, MAX664X_REG_RSL);
> > > +}
> > > +EXPORT_SYMBOL(max664x_read_status);
> > 
> > I fail to see the point of making this separate from max6646_get_values
> > (or whatever it ends up being called)?
> 
> Because it's read-clear.

But it reasserts itself immediately if the fault condition is still
present, so it doesn't really matter. All Linux hardware monitoring
chips read these status registers together with the other registers.

> [...]
> > > +#define MAX664X_TEMP_INT	0
> > > +#define MAX664X_TEMP_EXT	1
> > 
> > Nice defines... but not used in your driver.
> 
> They should be useful for clients.
> 
> > This raises the question
> > of how useful they are. Not much IMHO, as each channel can be used for
> > something different depending on how the chip is used.
> 
> I don't understand.  One temperature sensor is built into the chip
> (local/internal) and the other must be added (remote/external).

But this doesn't tell you what each temperature channel is measuring.
It depends how the sensor chip is soldered. So all the caller really
knows is that channel 0 corresponds to this and channel 1 corresponds
to that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
