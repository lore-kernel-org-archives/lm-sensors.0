From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 11 Jan 2012 22:51:12 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon: (lm63) Add support for update_interval sysfs attribute
Message-Id: <1326322272.2649.107.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, 2012-01-11 at 16:57 -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late review of this one, I wanted to spend some time to
> ensure that the computing code was correct, as it is not trivial.
> 
No problem. Take your time.

> On Mon,  9 Jan 2012 19:42:03 -0800, Guenter Roeck wrote:
> > The update interval is configurable on LM63 and compatibles. Add support for it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/lm63.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 94 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> > index 6370e28..368db01 100644
> > --- a/drivers/hwmon/lm63.c
> > +++ b/drivers/hwmon/lm63.c
> > @@ -61,6 +61,7 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
> >   */
> >  
> >  #define LM63_REG_CONFIG1		0x03
> > +#define LM63_REG_CONVRATE		0x04
> >  #define LM63_REG_CONFIG2		0xBF
> >  #define LM63_REG_CONFIG_FAN		0x4A
> >  
> > @@ -96,6 +97,11 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
> >  #define LM96163_REG_REMOTE_TEMP_U_LSB	0x32
> >  #define LM96163_REG_CONFIG_ENHANCED	0x45
> >  
> > +#define LM63_MAX_CONVRATE		9
> > +
> > +#define LM63_MAX_CONVRATE_HZ		32
> > +#define LM96163_MAX_CONVRATE_HZ		26
> 
> How smart from the manufacturer :/
> 
> > +
> >  /*
> >   * Conversions and various macros
> >   * For tachometer counts, the LM63 uses 16-bit values.
> > @@ -132,6 +138,10 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
> >  				 (val) >= 127000 ? 127 : \
> >  				 ((val) + 500) / 1000)
> >  
> > +#define UPDATE_INTERVAL(max, rate) \
> > +	DIV_ROUND_CLOSEST(10000000, \
> > +			  ((max) * 10000) >> (LM63_MAX_CONVRATE - (rate)))
> 
> I'd prefer an inline function. Macros are evil and this driver already
> have plenty of these.
> 
> I don't quite get the rationale for the 10000, BTW. If you want to
> avoid loss of precision, you'd rather use 2^LM63_MAX_CONVRATE i.e. 512
> as your magic constant. But it would seem even smarter to do things the
> other way around so you don't need such a constant:
> 
> #define UPDATE_INTERVAL(max, rate) \
> 	((1000 << (LM63_MAX_CONVRATE - (rate))) / (max))
> 
> This should be much faster, and also more accurate for slow frequencies.
> 
I'll take your define.

> > +
> >  /*
> >   * Functions declaration
> >   */
> > @@ -183,6 +193,9 @@ struct lm63_data {
> >  	int kind;
> >  	int temp2_offset;
> >  
> > +	int update_interval;	/* in milliseconds */
> > +	int max_convrate_hz;
> > +
> >  	/* registers values */
> >  	u8 config, config_fan;
> >  	u16 fan[2];	/* 0: input
> > @@ -463,6 +476,59 @@ static ssize_t set_temp2_crit_hyst(struct device *dev,
> >  	return count;
> >  }
> >  
> > +/*
> > + * Set conversion rate.
> > + * client->update_lock must be held when calling this function (unless we are
> > + * in detection or initialization steps).
> 
> Nice copy-and-paste but "detection step" obviously doesn't apply here;
> detection wouldn't reconfigure the device.
> 
> > + */
> > +static void lm63_set_convrate(struct i2c_client *client, struct lm63_data *data,
> > +			      unsigned int interval)
> > +{
> > +	int i;
> > +	unsigned int update_interval;
> > +
> > +	/* Shift calculations to avoid rounding errors */
> > +	interval <<= 6;
> 
> This could overflow, at least in theory. You should check for
> 	interval >= (1 << LM63_MAX_CONVRATE) * 1000 / data->max_convrate_hz
> or even more simply and arbitrarily for
> 	interval >= 100000
> and skip the loop in this case. Yes, the lm90 driver suffers from the
> same problem.
> 
For simplicity, I'll bound it in the calling code with SENSORS_LIMIT.
And submit a matching patch for lm90.c.

> > +
> > +	/* find the nearest update rate */
> > +	update_interval = (1 << (LM63_MAX_CONVRATE + 6)) * 1000
> > +	  / data->max_convrate_hz;
> > +	for (i = 0; i < LM63_MAX_CONVRATE; i++, update_interval >>= 1)
> > +		if (interval >= update_interval * 3 / 4)
> > +			break;
> > +
> > +	i2c_smbus_write_byte_data(client, LM63_REG_CONVRATE, i);
> > +	data->update_interval = UPDATE_INTERVAL(data->max_convrate_hz, i);
> > +}
> > +
> > +static ssize_t show_update_interval(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	struct lm63_data *data = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%u\n", data->update_interval);
> > +}
> > +
> > +static ssize_t set_update_interval(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct lm63_data *data = i2c_get_clientdata(client);
> > +	unsigned long val;
> > +	int err;
> > +
> > +	err = kstrtoul(buf, 10, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	mutex_lock(&data->update_lock);
> > +	lm63_set_convrate(client, data, val);
> > +	mutex_unlock(&data->update_lock);
> > +
> > +	return count;
> > +}
> > +
> >  static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
> >  			   char *buf)
> >  {
> > @@ -513,6 +579,9 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
> >  /* Raw alarm file for compatibility */
> >  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> >  
> > +static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
> > +		   set_update_interval);
> > +
> >  static struct attribute *lm63_attributes[] = {
> >  	&dev_attr_pwm1.attr,
> >  	&dev_attr_pwm1_enable.attr,
> > @@ -531,6 +600,7 @@ static struct attribute *lm63_attributes[] = {
> >  	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> >  	&dev_attr_alarms.attr,
> > +	&dev_attr_update_interval.attr,
> >  	NULL
> >  };
> >  
> > @@ -683,6 +753,7 @@ exit:
> >  static void lm63_init_client(struct i2c_client *client)
> >  {
> >  	struct lm63_data *data = i2c_get_clientdata(client);
> > +	u8 convrate;
> >  
> >  	data->config = i2c_smbus_read_byte_data(client, LM63_REG_CONFIG1);
> >  	data->config_fan = i2c_smbus_read_byte_data(client,
> > @@ -701,6 +772,24 @@ static void lm63_init_client(struct i2c_client *client)
> >  	if (data->pwm1_freq = 0)
> >  		data->pwm1_freq = 1;
> >  
> > +	switch (data->kind) {
> > +	case lm63:
> > +	case lm64:
> > +		data->max_convrate_hz = LM63_MAX_CONVRATE_HZ;
> > +		break;
> > +	case lm96163:
> > +		data->max_convrate_hz = LM96163_MAX_CONVRATE_HZ;
> > +		break;
> > +	default:
> > +		BUG();
> > +		break;
> > +	}
> 
> If you'd turn data->type into enum chips, you could remove the default
> statement: gcc would kindly warn if a chip type is omitted.
> 
Done.

> Probably something to be done in all i2c-based hwmon drivers...
> 
Something for the to-do list.

> > +	convrate = i2c_smbus_read_byte_data(client, LM63_REG_CONVRATE);
> > +	if (convrate > LM63_MAX_CONVRATE)
> 
> Might make sense to use unlikely() here, as this isn't supposed to
> happen.
> 
Ok.

> > +		convrate = LM63_MAX_CONVRATE;
> > +	data->update_interval = UPDATE_INTERVAL(data->max_convrate_hz,
> > +						convrate);
> > +
> >  	/*
> >  	 * For LM96163, check if high resolution PWM
> >  	 * and unsigned temperature format is enabled.
> > @@ -744,10 +833,14 @@ static struct lm63_data *lm63_update_device(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> >  	struct lm63_data *data = i2c_get_clientdata(client);
> > +	unsigned long next_update;
> >  
> >  	mutex_lock(&data->update_lock);
> >  
> > -	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> > +	next_update = data->last_updated
> > +	  + msecs_to_jiffies(data->update_interval) + 1;
> > +
> > +	if (time_after(jiffies, next_update) || !data->valid) {
> >  		if (data->config & 0x04) { /* tachometer enabled  */
> >  			/* order matters for fan1_input */
> >  			data->fan[0] = i2c_smbus_read_byte_data(client,
> 
> 
Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
