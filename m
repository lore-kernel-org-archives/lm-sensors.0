From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Nov 2010 10:11:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (adm9240) Implement the
Message-Id: <20101103111135.6ae02917@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101102174042.1d548a0c@endymion.delvare>
In-Reply-To: <20101102174042.1d548a0c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Thanks for the fast review.

On Tue, 2 Nov 2010 11:40:37 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Tue, 2010-11-02 at 12:40 -0400, Jean Delvare wrote:
> > We have a standard intrusion detection interface now, drivers should
> > implement it. I've left the old interface in place for the time being,
> > with a deprecation warning, it will be removed later.
> > 
> Good idea!
> 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  Documentation/hwmon/adm9240 |    2 +-
> >  drivers/hwmon/adm9240.c     |   31 ++++++++++++++++++++++++++++---
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> > --- linux-2.6.37-rc1.orig/drivers/hwmon/adm9240.c	2010-11-02 14:32:58.000000000 +0100
> > +++ linux-2.6.37-rc1/drivers/hwmon/adm9240.c	2010-11-02 16:50:55.000000000 +0100
> > @@ -20,7 +20,7 @@
> >   * Alarms	16-bit map of active alarms
> >   * Analog Out	0..1250 mV output
> >   *
> > - * Chassis Intrusion: clear CI latch with 'echo 1 > chassis_clear'
> > + * Chassis Intrusion: clear CI latch with 'echo 0 > intrusion0_alarm'
> >   *
> >   * Test hardware: Intel SE440BX-2 desktop motherboard --Grant
> >   *
> > @@ -476,13 +476,15 @@ static ssize_t set_aout(struct device *d
> >  static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
> >  
> >  /* chassis_clear */
> > -static ssize_t chassis_clear(struct device *dev,
> > +static ssize_t chassis_clear_legacy(struct device *dev,
> >  		struct device_attribute *attr,
> >  		const char *buf, size_t count)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> >  	unsigned long val = simple_strtol(buf, NULL, 10);
> >  
> > +	dev_warn(&client->dev, "Attribute chassis_clear is deprecated, "
> > +		 "use intrusion0_alarm instead\n");
> >  	if (val = 1) {
> >  		i2c_smbus_write_byte_data(client,
> >  				ADM9240_REG_CHASSIS_CLEAR, 0x80);
> > @@ -490,7 +492,29 @@ static ssize_t chassis_clear(struct devi
> >  	}
> >  	return count;
> >  }
> > -static DEVICE_ATTR(chassis_clear, S_IWUSR, NULL, chassis_clear);
> > +static DEVICE_ATTR(chassis_clear, S_IWUSR, NULL, chassis_clear_legacy);
> > +
> > +static ssize_t chassis_clear(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct adm9240_data *data = i2c_get_clientdata(client);
> > +	unsigned long val;
> > +
> > +	if (strict_strtoul(buf, 10, &val) || val != 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&data->update_lock);
> > +	data->alarms &= ~(1 << 12);
> 
> Not sure if that is a good idea. The original code doesn't do it,

Hardly a valid reason per se... There are plenty of cases where the
original code does the wrong thing ;)

> and you can not really know for sure if the alarm will be reset;
> after all, the chassis might still be open.

This OTOH is a very valid point, which I had missed.

> I think it would be better 
> to leave updating the flag to the attribute update handler.

The problem is that this infringes the rule that register value caching
should be transparent to the caller. When we set limits, we make sure
that the cache contains the new value as it is written to the chip, so
that user-space sees the change immediately. Behaving differently for
the intrusion detection case would be unexpected and confusing.

> If you
> really want to update the flag immediately, I think you should re-read
> the register and not just reset the flag.

It's not so easy. For most chips, the intrusion alarm flag is part of
an alarm register which contains many other flags, which are latched
when the error condition is spotted and cleared when the register is
read. Reading such registers other than on user request may lose
temporary error condition alarms. 

What I can offer is resetting data->valid to 0, to force a cache
refresh on next access from user-space. This should let the driver
always return the right value. This also has the advantage of being
cheap from a code perspective. The run-time overhead is negligible
IMHO, as I don't expect the chassis intrusion alarm to be cleared by
the user frequently.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
