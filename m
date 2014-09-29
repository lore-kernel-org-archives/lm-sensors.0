From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Sep 2014 19:13:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Add support for humidity and power sensors
Message-Id: <20140929191343.GC20189@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1411832985-12619-1-git-send-email-linux@roeck-us.net>
 <5429988D.9060504@kernel.org>
In-Reply-To: <5429988D.9060504@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>

On Mon, Sep 29, 2014 at 06:36:13PM +0100, Jonathan Cameron wrote:
> On 27/09/14 16:49, Guenter Roeck wrote:
> > The iio subsystem supports power and humidity sensors, so it makes sense
> > to support those sensor types in the iio-hwmon bridge as well.
> > 
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Looks good.
> > ---
> > Compile tested only.
> > 
> > Question is if I got the scale conversion correct for power measurements.
> > I _assume_ that iio always reports processed values in milli-units,
> > but I am not entirely sure.
> 
> IIO actually only keeps to milli units where we were copying from hwmom
> back when originally working this stuff out.  Given we have the double
> int32 representation and IIO_TYPE_* we try to keep to the base SI units
> everywhere else. (If we were doing it again today, I'd be advocating
> using base units everywhere for consistency reasons)
> 
What does that mean for the iio-hwmon bridge ? Should I get the base
units (or scaling factors) on a per-sensor basis, or does the above apply
on a per-type basis ? I checked the humidity ABI (which is documented),
and it says that humidity is reported in milli-units.

Thanks,
Guenter

> The only user of IIO_POWER right now is the ade7758 driver in staging.
> I note that hwmon uses micro watts so would imagine that driver
> does as well.  However given the timescale it's probably a driver from the
> big dump from Analog's tree before we'd pinned down a lot of the ABIs
> Lars, don't suppose you'd care to take a look?  The types got added
> by Michael when cleaning the driver up somewhat...
> 
> Also we should really add the relevant ABI docs (once we've agreed the unit!)
> 
> Jonathan
> > 
> >  drivers/hwmon/iio_hwmon.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> > index 14c82da..efc55a9 100644
> > --- a/drivers/hwmon/iio_hwmon.c
> > +++ b/drivers/hwmon/iio_hwmon.c
> > @@ -21,6 +21,8 @@
> >  /**
> >   * struct iio_hwmon_state - device instance state
> >   * @channels:		filled with array of channels from iio
> > + * @scale:		array of multipliers to convert from iio to hwmon
> > + *			resolution
> >   * @num_channels:	number of channels in channels (saves counting twice)
> >   * @hwmon_dev:		associated hwmon device
> >   * @attr_group:	the group of attributes
> > @@ -28,6 +30,7 @@
> >   */
> >  struct iio_hwmon_state {
> >  	struct iio_channel *channels;
> > +	int *scale;
> >  	int num_channels;
> >  	struct device *hwmon_dev;
> >  	struct attribute_group attr_group;
> > @@ -48,13 +51,16 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
> >  	int ret;
> >  	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> >  	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> > +	s64 result_64;
> >  
> >  	ret = iio_read_channel_processed(&state->channels[sattr->index],
> > -					&result);
> > +					 &result);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	return sprintf(buf, "%d\n", result);
> > +	result_64 = (s64)result * state->scale[sattr->index];
> > +
> > +	return sprintf(buf, "%lld\n", result_64);
> >  }
> >  
> >  static int iio_hwmon_probe(struct platform_device *pdev)
> > @@ -63,7 +69,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
> >  	struct iio_hwmon_state *st;
> >  	struct sensor_device_attribute *a;
> >  	int ret, i;
> > -	int in_i = 1, temp_i = 1, curr_i = 1;
> > +	int in_i = 1, temp_i = 1, curr_i = 1, power_i = 1, humidity_i = 1;
> >  	enum iio_chan_type type;
> >  	struct iio_channel *channels;
> >  	const char *name = "iio_hwmon";
> > @@ -94,6 +100,12 @@ static int iio_hwmon_probe(struct platform_device *pdev)
> >  		ret = -ENOMEM;
> >  		goto error_release_channels;
> >  	}
> > +	st->scale = devm_kzalloc(dev, sizeof(*st->scale) * st->num_channels,
> > +				 GFP_KERNEL);
> > +	if (st->scale = NULL) {
> > +		ret = -ENOMEM;
> > +		goto error_release_channels;
> > +	}
> >  
> >  	for (i = 0; i < st->num_channels; i++) {
> >  		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> > @@ -107,6 +119,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
> >  		if (ret < 0)
> >  			goto error_release_channels;
> >  
> > +		st->scale[i] = 1;
> >  		switch (type) {
> >  		case IIO_VOLTAGE:
> >  			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> > @@ -123,6 +136,17 @@ static int iio_hwmon_probe(struct platform_device *pdev)
> >  							  "curr%d_input",
> >  							  curr_i++);
> >  			break;
> > +		case IIO_POWER:
> > +			st->scale[i] = 1000;
> > +			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> > +							  "power%d_input",
> > +							  power_i++);
> > +			break;
> > +		case IIO_HUMIDITYRELATIVE:
> > +			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> > +							  "humidity%d_input",
> > +							  humidity_i++);
> > +			break;
> >  		default:
> >  			ret = -EINVAL;
> >  			goto error_release_channels;
> > 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
