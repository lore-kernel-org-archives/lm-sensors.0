From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Apr 2010 15:46:16 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (adm1031) allow setting update
Message-Id: <20100414174616.2320dcfa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270671720-1575-3-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1270671720-1575-3-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 14 Apr 2010 08:36:30 -0700, Ira W. Snyder wrote:
> On Wed, Apr 14, 2010 at 10:46:48AM +0200, Jean Delvare wrote:
> > Here is how I'd do it:
> > 
> > ---
> >  drivers/hwmon/adm1031.c |   68 +++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 66 insertions(+), 2 deletions(-)
> > 
> > --- linux-2.6.34-rc4.orig/drivers/hwmon/adm1031.c	2010-02-25 09:12:22.000000000 +0100
> > +++ linux-2.6.34-rc4/drivers/hwmon/adm1031.c	2010-04-14 10:11:04.000000000 +0200
> > @@ -36,6 +36,7 @@
> >  #define ADM1031_REG_FAN_DIV(nr)		(0x20 + (nr))
> >  #define ADM1031_REG_PWM			(0x22)
> >  #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))
> > +#define ADM1031_REG_FAN_FILTER		(0x23)
> >  
> >  #define ADM1031_REG_TEMP_OFFSET(nr)	(0x0d + (nr))
> >  #define ADM1031_REG_TEMP_MAX(nr)	(0x14 + 4 * (nr))
> > @@ -61,6 +62,9 @@
> >  #define ADM1031_CONF2_TACH2_ENABLE	0x08
> >  #define ADM1031_CONF2_TEMP_ENABLE(chan)	(0x10 << (chan))
> >  
> > +#define ADM1031_UPDATE_RATE_MASK	0x1c
> > +#define ADM1031_UPDATE_RATE_SHIFT	2
> > +
> >  /* Addresses to scan */
> >  static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
> >  
> > @@ -75,6 +79,7 @@ struct adm1031_data {
> >  	int chip_type;
> >  	char valid;		/* !=0 if following fields are valid */
> >  	unsigned long last_updated;	/* In jiffies */
> > +	unsigned int update_rate;	/* In milliseconds */
> >  	/* The chan_select_table contains the possible configurations for
> >  	 * auto fan control.
> >  	 */
> > @@ -738,6 +743,57 @@ static SENSOR_DEVICE_ATTR(temp3_crit_ala
> >  static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 13);
> >  static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
> >  
> > +/* Update Rate */
> > +static const unsigned int update_rates[] = {
> > +	16000, 8000, 4000, 2000, 1000, 500, 250, 125,
> > +};
> > +
> > +static ssize_t show_update_rate(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct adm1031_data *data = i2c_get_clientdata(client);
> > +
> > +	return sprintf(buf, "%u\n", data->update_rate);
> > +}
> > +
> > +static ssize_t set_update_rate(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct adm1031_data *data = i2c_get_clientdata(client);
> > +	unsigned long val;
> > +	int i, err;
> > +	u8 reg;
> > +
> > +	err = strict_strtoul(buf, 10, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	/* find the nearest update rate from the table */
> > +	for (i = 0; i < ARRAY_SIZE(update_rates) - 1; i++) {
> > +		if (val >= update_rates[i])
> > +			break;
> > +	}
> > +	/* if not found, we point to the last entry (lowest update rate) */
> > +
> > +	/* set the new update rate while preserving other settings */
> > +	reg = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
> > +	reg &= ~ADM1031_UPDATE_RATE_MASK;
> > +	reg |= i << ADM1031_UPDATE_RATE_SHIFT;
> > +	adm1031_write_value(client, ADM1031_REG_FAN_FILTER, reg);
> > +
> > +	mutex_lock(&data->update_lock);
> > +	data->update_rate = update_rates[i];
> > +	mutex_unlock(&data->update_lock);
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR(update_rate, S_IRUGO | S_IWUSR, show_update_rate,
> > +		   set_update_rate);
> > +
> >  static struct attribute *adm1031_attributes[] = {
> >  	&sensor_dev_attr_fan1_input.dev_attr.attr,
> >  	&sensor_dev_attr_fan1_div.dev_attr.attr,
> > @@ -774,6 +830,7 @@ static struct attribute *adm1031_attribu
> >  
> >  	&sensor_dev_attr_auto_fan1_min_pwm.dev_attr.attr,
> >  
> > +	&dev_attr_update_rate.attr,
> >  	&dev_attr_alarms.attr,
> >  
> >  	NULL
> > @@ -900,6 +957,7 @@ static void adm1031_init_client(struct i
> >  {
> >  	unsigned int read_val;
> >  	unsigned int mask;
> > +	int i;
> >  	struct adm1031_data *data = i2c_get_clientdata(client);
> >  
> >  	mask = (ADM1031_CONF2_PWM1_ENABLE | ADM1031_CONF2_TACH1_ENABLE);
> > @@ -919,18 +977,24 @@ static void adm1031_init_client(struct i
> >  				ADM1031_CONF1_MONITOR_ENABLE);
> >  	}
> >  
> > +	/* Read the chip's update rate */
> > +	mask = ADM1031_UPDATE_RATE_MASK;
> > +	read_val = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
> > +	i = (read_val & mask) >> ADM1031_UPDATE_RATE_SHIFT;
> > +	data->update_rate = update_rates[i];
> >  }
> >  
> >  static struct adm1031_data *adm1031_update_device(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> >  	struct adm1031_data *data = i2c_get_clientdata(client);
> > +	unsigned long next_update;
> >  	int chan;
> >  
> >  	mutex_lock(&data->update_lock);
> >  
> > -	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> > -	    || !data->valid) {
> > +	next_update = data->last_updated + msecs_to_jiffies(data->update_rate);
> > +	if (time_after(jiffies, next_update) || !data->valid) {
> >  
> >  		dev_dbg(&client->dev, "Starting adm1031 update\n");
> >  		for (chan = 0;
> > 
> > 
> > This looks nice enough to me. What do you think?
> > 
> 
> This is much better than my patch. I tested it on my board, and it works
> exactly as expected. You've got my Reviewed-by and Tested-by on this
> patch.
> 
> If you'd like, I'm happy to generate a v2 patch series rolling the name
> and update_rate attributes into a "General Attributes" section in the
> documentation, as well as using this patch for adm1031 support.
> 
> If you're comfortable rolling them together yourself, feel free to do
> so.

I will take care, no problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
