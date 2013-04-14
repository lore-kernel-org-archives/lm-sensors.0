From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 14 Apr 2013 11:36:29 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (tmp401) Simplification and cleanup
Message-Id: <20130414113629.GA16884@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Apr 14, 2013 at 12:17:40PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri,  5 Apr 2013 18:02:55 -0700, Guenter Roeck wrote:
> > Use two-dimensional array pointing to registers
> > Merge temperature and limit access function into a single function
> 
> Spelling : functions.
> 
> > Return eror codes from I2C accesses
> 
> Spelling: error. I'd also suggest s/accesses/reads/ as you don't check
> for error on writes.
> 
> > Use DIV_ROUND_CLOSEST for rounding operations
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/tmp401.c |  369 ++++++++++++++++++------------------------------
> >  1 file changed, 137 insertions(+), 232 deletions(-)
> 
> Very nice cleanup. See my comments inline.
> 
Thanks a lot for the review!

> > diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> > index f07fc40..c0cf87d 100644
> > --- a/drivers/hwmon/tmp401.c
> > +++ b/drivers/hwmon/tmp401.c
> > @@ -57,21 +57,32 @@ enum chips { tmp401, tmp411, tmp431 };
> > (...)
> > +static const u8 TMP401_TEMP_MSB_READ[6][2] = {
> > +	{ 0x00, 0x01 },	/* temp */
> > +	{ 0x06, 0x08 },	/* low limit */
> > +	{ 0x05, 0x07 },	/* high limit */
> > +	{ 0x20, 0x19 },	/* therm (crit) limit */
> > +	{ 0x30, 0x34 },	/* lowest */
> > +	{ 0x32, 0x36 },	/* highest */
> > +};
> > +
> > +static const u8 TMP401_TEMP_MSB_WRITE[6][2] = {
> > +	{ 0x00, 0x00 },	/* temp  (unused) */
> 
> Typo: doubled space.
> 
> > +	{ 0x0C, 0x0E },	/* low limit */
> > +	{ 0x0B, 0x0D },	/* high limit */
> > +	{ 0x20, 0x19 },	/* therm (crit) limit */
> > +	{ 0x30, 0x34 },	/* lowest */
> > +	{ 0x32, 0x36 },	/* highest */
> > +};
> > +
> > +static const u8 TMP401_TEMP_LSB[6][2] = {
> > +	{ 0x15, 0x10 },	/* temp */
> > +	{ 0x17, 0x14 },	/* low limit */
> > +	{ 0x16, 0x13 },	/* high limit */
> > +	{ 0x00, 0x00 },	/* therm (crit) limit (unused) */
> > +	{ 0x31, 0x35 },	/* lowest */
> > +	{ 0x33, 0x37 },	/* highest */
> > +};
> 
> It might make sense to use 0 instead of 0x00 for unused fields, to make
> it more immediately visible that they aren't used.
> 
> > (...)
> > -static ssize_t store_temp_max(struct device *dev, struct device_attribute
> > -	*devattr, const char *buf, size_t count)
> > +static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
> > +			  const char *buf, size_t count)
> >  {
> > -	int index = to_sensor_dev_attr(devattr)->index;
> > +	int nr = to_sensor_dev_attr_2(devattr)->nr;
> > +	int index = to_sensor_dev_attr_2(devattr)->index;
> >  	struct tmp401_data *data = tmp401_update_device(dev);
> >  	long val;
> > -	u16 reg;
> > -
> > -	if (kstrtol(buf, 10, &val))
> > -		return -EINVAL;
> > +	u16 regval;
> 
> This name change is inconsistent, "reg" is used everywhere else.
> 
I know. Problem is that I need a "reg" or similar variable for the register
itself when adding tmp432 support, so I decided to go with regval for the
register value.
Got a better / different good name for the register variable ? 

> >  
> > -	reg = tmp401_temp_to_register(val, data->config);
> > -
> > -	mutex_lock(&data->update_lock);
> > -
> > -	i2c_smbus_write_byte_data(to_i2c_client(dev),
> > -		TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[index], reg >> 8);
> > -	i2c_smbus_write_byte_data(to_i2c_client(dev),
> > -		TMP401_TEMP_HIGH_LIMIT_LSB[index], reg & 0xFF);
> > -
> > -	data->temp_high[index] = reg;
> > -
> > -	mutex_unlock(&data->update_lock);
> > -
> > -	return count;
> > -}
> > -
> > -static ssize_t store_temp_crit(struct device *dev, struct device_attribute
> > -	*devattr, const char *buf, size_t count)
> > -{
> > -	int index = to_sensor_dev_attr(devattr)->index;
> > -	struct tmp401_data *data = tmp401_update_device(dev);
> > -	long val;
> > -	u8 reg;
> > +	if (IS_ERR(data))
> > +		return PTR_ERR(data);
> >  
> >  	if (kstrtol(buf, 10, &val))
> >  		return -EINVAL;
> >  
> > -	reg = tmp401_crit_temp_to_register(val, data->config);
> > +	regval = tmp401_temp_to_register(val, data->config);
> >  
> >  	mutex_lock(&data->update_lock);
> >  
> >  	i2c_smbus_write_byte_data(to_i2c_client(dev),
> > -		TMP401_TEMP_CRIT_LIMIT[index], reg);
> > +		TMP401_TEMP_MSB_WRITE[nr][index], regval >> 8);
> > +	if (nr = 3) {
> > +		/* drop LSB for critical limit */
> > +		regval &= 0xff00;
> 
> This is not rounding properly. The original code was rounding properly.
> 
> > +	} else {
> > +		i2c_smbus_write_byte_data(to_i2c_client(dev),
> > +					  TMP401_TEMP_LSB[nr][index],
> > +					  regval & 0xFF);
> > +	}
> >  
> > -	data->temp_crit[index] = reg;
> > +	data->temp[nr][index] = regval;
> >  
> >  	mutex_unlock(&data->update_lock);
> 
> > (...)
> > @@ -459,18 +364,18 @@ static ssize_t reset_temp_history(struct device *dev,
> >  		return -EINVAL;
> >  	}
> >  	i2c_smbus_write_byte_data(to_i2c_client(dev),
> > -		TMP411_TEMP_LOWEST_MSB[0], val);
> > +				  TMP401_TEMP_MSB_WRITE[5][0], val);
> >  
> >  	return count;
> >  }
> 
> Unrelated to your patch, but I think this function should clear
> data->valid, as the lowest and highest temperature values are no longer
> valid.
> 
Good catch. I'll add a separate patch for that.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
