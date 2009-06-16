From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Jun 2009 08:10:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: Add driver tmp421 for TI's
Message-Id: <20090616101027.19432ba1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090615074320.GB4667@ubuntu>
In-Reply-To: <20090615074320.GB4667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Jun 2009 09:58:31 +0200, Andre Prendel wrote:
> On Mon, Jun 15, 2009 at 10:52:24PM +0200, Jean Delvare wrote:
> > On Mon, 15 Jun 2009 09:43:20 +0200, Andre Prendel wrote:
> > > +static int temp_from_s16(s16 reg)
> > > +{
> > > +	int temp = reg;
> > > +
> > > +	return (temp * 1000 + 128) / 256;
> > > +}
> > > +
> > > +static int temp_from_u16(u16 reg)
> > > +{
> > > +	int temp = reg;
> > > +
> > > +	/* Add offset for extended temperature range. */
> > > +	temp -= 64 * 256;
> > > +
> > > +	return (temp * 1000 + 128) / 256;
> > > +}
> > > +
> > > +static ssize_t show_temp_value(struct device *dev,
> > > +			       struct device_attribute *devattr, char *buf)
> > > +{
> > > +	int index = to_sensor_dev_attr(devattr)->index;
> > > +	struct tmp421_data *data = tmp421_update_device(dev);
> > > +	int temp;
> > > +
> > > +	if (data->config & TMP421_CONFIG_RANGE)
> > > +		temp = temp_from_u16(data->temp[index]);
> > > +	else
> > > +		temp = temp_from_s16(data->temp[index]);
> > 
> > This lacks protection: you have no guarantee that data->config and
> > data->temp[index] belong to the same read cycle.
> 
> The *data pointer comes from tmp421_update_device(dev). So this should
> be from the same cycle, shouldn't be. I don't know how to
> protect. Hardware access is protected in tmp421_update_device(). Maybe
> I misunderstood something.

You can have concurrent accesses to the sysfs attribute files. Let's
say you have two files being accessed, the first access when the cache
is still valid (tmp421_update_device is a no-op) and the second when
the cache just wore off and needs to be refreshed (tmp421_update_device
reads from registers).

The first access will test data->config based on the cached value. At
this point, the second access could cause the cache to be refreshed. I
agree this is all highly unlikely, but in theory this could still
happen. Then the first access will use data->temp[index], from the
refreshed cache. If data->config changed meanwhile, then you just
called the wrong conversion function for the temperature value.

It's pretty easy to fix:

	mutex_lock(&data->update_lock);
	if (data->config & TMP421_CONFIG_RANGE)
		temp = temp_from_u16(data->temp[index]);
	else
		temp = temp_from_s16(data->temp[index]);
	mutex_unlock(&data->update_lock);

This is sufficient to prevent a cache update while you're using the
cached values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
