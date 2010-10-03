From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Oct 2010 00:50:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for
Message-Id: <20101003005058.GA29454@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101002203250.773e1c3a@endymion.delvare>
In-Reply-To: <20101002203250.773e1c3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Oct 02, 2010 at 02:32:50PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 17 Sep 2010 21:01:48 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > This patch depends on the function reordering patch submitted earlier.
> > 
> >  drivers/hwmon/lm90.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 84 insertions(+), 5 deletions(-)
> 
> I was about to test this patch on my ADM1032 evaluation board, and
> suddenly realized that my new motherboard lacks a parallel port. Bummer.
> 
Good that I have a system with max6696 here, so I could test it.
You might be able to get a usb to parallel port adapter for a few $ (or Euros).
At least if you find one which works with Linux.

> > 
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index 302d9eb..569f6be 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -104,6 +104,13 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
> >  	max6646, w83l771, max6696 };
> >  
> >  /*
> > + * Maximum supported conversion rate register values per chip.
> > + * If multiple register values reflect the fastest supported conversion rate,
> > + * provide the lower value.
> > + */
> > +static u8 max_convrates[] = { 9, 10, 9, 9, 8, 8, 10, 7, 6, 8, 6 };
> 
> Should be const. Anyway I don't like this approach, as the order here
> has to be the same as the order of enum chips or everything breaks, but
> this isn't spelled out anywhere. Remember that you changed that order
> not so long ago, it might happen again someday... I think it is overall
> too fragile. This is also inconsistent with the way data->alert_alarms
> is set in lm90_probe().
> 
Good point.

> I think we want to come up with a unified way to set per-chip
> attributes, and stick to it. This could either be done with switch/case
> in lm90_probe(), as we already have, or using a chips-indexed array of
> property structures.
> 
I had thought about another switch/case in probe, but didn't like it because
it is getting large.

I do like the idea of a chips-indexed structure. That could cover alarms, flags,
and conversion rates.

One patch or two ? Seems to me that adding such a structure should be
done in a separate patch.

> > +
> > +/*
> >   * The LM90 registers
> >   */
> >  
> > @@ -201,7 +208,10 @@ struct lm90_data {
> >  	int kind;
> >  	int flags;
> >  
> > +	int update_interval;	/* in milliseconds  */
> 
> Double space at end of comment.
> 
Fixed.

> > +
> >  	u8 config_orig;		/* Original configuration register value */
> > +	u8 convrate_orig;	/* Original conversion rate */
> 
> Might be a good idea to mention in the comment that this is a register
> value.
> 
Done.

> >  	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
> >  				/* Upper 8 bits for max6695/96 */
> >  
> > @@ -325,15 +335,44 @@ static inline void lm90_select_remote_channel(struct i2c_client *client,
> >  	}
> >  }
> >  
> > +/* Update Intervals */
> > +static const unsigned int update_intervals[] = {
> > +	16000, 8000, 4000, 2000, 1000, 500, 250, 125, 62, 31, 15, 7,
> > +};
> 
> These are 12 values, but the maximum value in max_convrates is 10?
> 
Should have been 11 values (index 0..10).

> Not sure about the last values, 1000/64 is 15.625 which would rather
> round up to 16, and 1000/128 is 7.8125 which would round up to 8.
> 
Ok. Makes more sense when using rounding.

> I'm also not sure if there's really a point in having this array at all,
> BTW, given that the values in it can be easily be computed.
> 
I really just stole the code from adm1031.c after making sure that it works ;).
But it is nice to have it, especially if I use rounding to calculate the value.

> Also lacks a reminder of the unit in use, if you decide to keep this
> array.

Done.

> 
> > +
> > +/*
> > + * Set conversion rate.
> > + * client->update_lock must be held when calling this function (unless we are
> > + * in detection or initialization steps).
> > + */
> > +static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
> > +			      int interval)
> 
> interval is passed as an unsigned int.
> 
Ok.

> > +{
> > +	int i;
> > +
> > +	/* find the nearest update rate from the table */
> > +	for (i = 0; i < ARRAY_SIZE(update_intervals) - 1; i++) {
> > +		if (interval >= update_intervals[i]
> > +		    || i >= max_convrates[data->kind])
> 
> This algorithm doesn't actually give you the nearest update rate. It
> gives you the immediately lesser supported value. To get the nearest
> supported value, you would have to compare with (update_intervals[i] +
> update_intervals[i + 1]) / 2. Your current algorithm would give 8000 ms
> is the user asks for 15000 ms, while 16000 ms is arguably a better
> match.
> 
Good point. I'll use rounding instead. Should be
	update_intervals[i] - update_intervals[i + 1]) / 2
though (-, not +).

This results in the following cutover points.

0..22		--> 10(15.875ms)
23..46		--> 9 (31.75ms)
47..93		--> 8 (62.5ms)
94..187		--> 7 (125ms)
188..374	--> 6 (250ms)
375..749	--> 5 (500ms)
750..1499	--> 4 (1s)
1500..2999	--> 3 (2s)
3000..5999	--> 2 (4s)
6000..11999 	--> 1 (8s)
12000..		--> 0 (16s)

> I would also suggest testing i >= max_convrates[data->kind] first, as a
> safety measure.
> 
Makes sense. Done.

> > +			break;
> > +	}
> > +	/* if not found, we point to the last entry (lowest update rate) */
> 
> I fail to see how this could happen, as i >= max_convrates[data->kind]
> will always trigger.
> 
Good point. I'll remove the comment.

> > +
> > +	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE, i);
> > +	data->update_interval = update_intervals[i];
> > +}
> > +
> >  static struct lm90_data *lm90_update_device(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> >  	struct lm90_data *data = i2c_get_clientdata(client);
> > +	unsigned long next_update;
> >  
> >  	mutex_lock(&data->update_lock);
> >  
> > -	if (time_after(jiffies, data->last_updated + HZ / 2 + HZ / 10)
> > -	 || !data->valid) {
> > +	next_update = data->last_updated
> > +	  + msecs_to_jiffies(data->update_interval) + HZ / 10;
> 
> We probably want to reconsider this HZ / 10. 100 ms on top of 500 ms
> wasn't too noticeable. 100 ms on top of 31 ms or even 16 ms is way too
> much.
> 
How about the following ?

	next_update = data->last_updated +
		msecs_to_jiffies(data->update_interval + data->update_interval / 8)

I used /8 to avoid a divide operation. The old constant was 20% above
the update interval. This is 12.5% above. Should still be ok, even for HZ0.

> > +	if (time_after(jiffies, next_update) || !data->valid) {
> >  		u8 h, l;
> >  		u8 alarms;
> >  
> > @@ -768,6 +807,35 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute
> >  	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
> >  }
> >  
> > +static ssize_t show_update_interval(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct lm90_data *data = i2c_get_clientdata(client);
> 
> This can be simplified to:
> 
> 	struct lm90_data *data = dev_get_drvdata(dev);
> 
Done.

> > +
> > +	return sprintf(buf, "%u\n", data->update_interval);
> > +}
> > +
> > +static ssize_t set_update_interval(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct lm90_data *data = i2c_get_clientdata(client);
> > +	unsigned long val;
> > +	int err;
> > +
> > +	err = strict_strtoul(buf, 10, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	mutex_lock(&data->update_lock);
> > +	lm90_set_convrate(client, data, val);
> > +	mutex_unlock(&data->update_lock);
> > +
> > +	return count;
> > +}
> > +
> >  static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp11, NULL, 0, 4);
> >  static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp11, NULL, 0, 0);
> >  static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp8,
> > @@ -799,6 +867,9 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
> >  /* Raw alarm file for compatibility */
> >  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> >  
> > +static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
> > +		   set_update_interval);
> > +
> >  static struct attribute *lm90_attributes[] = {
> >  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> >  	&sensor_dev_attr_temp2_input.dev_attr.attr,
> > @@ -819,6 +890,7 @@ static struct attribute *lm90_attributes[] = {
> >  	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> >  	&dev_attr_alarms.attr,
> > +	&dev_attr_update_interval.attr,
> >  	NULL
> >  };
> >  
> > @@ -1138,14 +1210,19 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
> >  
> >  static void lm90_init_client(struct i2c_client *client)
> >  {
> > -	u8 config;
> > +	u8 config, convrate;
> >  	struct lm90_data *data = i2c_get_clientdata(client);
> >  
> > +	if (lm90_read_reg(client, LM90_REG_R_CONVRATE, &convrate) < 0) {
> > +		dev_warn(&client->dev, "Failed to read convrate register!\n");
> > +		convrate = 6;
> > +	}
> > +	data->convrate_orig = convrate;
> > +
> >  	/*
> >  	 * Start the conversions.
> >  	 */
> > -	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
> > -				  5); /* 2 Hz */
> > +	lm90_set_convrate(client, data, 500);	/* 500ms; 2Hz conversion rate */
> 
> Why? The only reason why we were setting the conversion rate before was
> so that it was in line with the hard-coded cache lifetime. Now that the
> rate can be changed dynamically, I'd rather leave the refresh rate
> alone, assuming that the chip default or BIOS setting is correct.
> 
I did not want to change driver behavior. At least in embedded systems,
the default tends to be the chip default, which is often not 500ms.
We would change behavior for many systems if we change this.

Thanks a lot for the review!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
