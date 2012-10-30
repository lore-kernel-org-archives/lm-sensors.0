From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 17:05:59 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/9] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <20121030170559.GD11394@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 30, 2012 at 05:42:56PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 29 Oct 2012 17:45:44 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v3: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
> >     Limit support for new attributes to IT8716F and higher
> >     Clarify code to select target register in set_temp().
> >     Only clear valid flag only when writing into offset registers,
> 
> Duplicate word "only".
> 
> >     not for any other temperature limit set operations.
> > v2: The macro to calculate IT87_REG_TEMP_OFFSET was broken. Use array instead.
> >     When writing the temperature offset attribute, set the flag to enable it.
> >     Add documentation describing the new attributes.
> > 
> >  Documentation/hwmon/it87 |    9 +++++++
> >  drivers/hwmon/it87.c     |   67 ++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 71 insertions(+), 5 deletions(-)
> > (...)
> > --- a/drivers/hwmon/it87.c
> > +++ b/drivers/hwmon/it87.c
> > (...)
> > @@ -312,6 +314,15 @@ static inline int has_newer_autopwm(const struct it87_data *data)
> >  	    || data->type = it8728;
> >  }
> >  
> > +static inline int has_temp_offset(const struct it87_data *data)
> > +{
> > +	return data->type = it8716
> > +	    || data->type = it8721
> > +	    || data->type = it8728
> > +	    || data->type = it8782
> > +	    || data->type = it8783;
> 
> What about it8718 and it8720?
> 
I'll add those.

> > +}
> > +
> >  static int adc_lsb(const struct it87_data *data, int nr)
> >  {
> >  	int lsb = has_12mv_adc(data) ? 12 : 16;
> > @@ -546,16 +557,37 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> >  	int index = sattr->index;
> >  	struct it87_data *data = dev_get_drvdata(dev);
> >  	long val;
> > +	u8 reg;
> >  
> >  	if (kstrtol(buf, 10, &val) < 0)
> >  		return -EINVAL;
> >  
> > +	switch (index) {
> > +	case 1:
> > +		reg = IT87_REG_TEMP_LOW(nr);
> > +		break;
> > +	case 2:
> > +		reg = IT87_REG_TEMP_HIGH(nr);
> > +		break;
> > +	case 3:
> > +		reg = IT87_REG_TEMP_OFFSET[nr];
> > +		break;
> > +	default:
> > +		WARN_ONCE(true, "Driver implementation error\n");
> > +		return -EINVAL;
> > +	}
> 
> Or just use default for either case and be done with it. It's not
> like the warning will ever be printed, and that's what the original
> code was doing anyway.
> 
ok

> > +
> >  	mutex_lock(&data->update_lock);
> >  	data->temp[nr][index] = TEMP_TO_REG(val);
> > -	it87_write_value(data,
> > -			 index = 1 ? IT87_REG_TEMP_LOW(nr)
> > -				    : IT87_REG_TEMP_HIGH(nr),
> > -			 data->temp[nr][index]);
> > +	if (index = 3) {
> > +		u8 regval = it87_read_value(data, IT87_REG_BEEP_ENABLE);
> > +		if (!(regval & 0x80)) {
> > +			regval |= 0x80;
> > +			it87_write_value(data, IT87_REG_BEEP_ENABLE, regval);
> > +		}
> > +		data->valid = 0;
> > +	}
> 
> This could be moved to the switch above, assuming earlier locking,
> saving a test.
>
ok

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
