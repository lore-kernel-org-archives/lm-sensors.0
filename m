From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 09 Jul 2011 21:17:36 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/3] hwmon: (lm95241) Fix negative
Message-Id: <20110709211736.GB7650@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310071365-2475-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310071365-2475-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Jul 09, 2011 at 04:36:18PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 7 Jul 2011 13:42:44 -0700, Guenter Roeck wrote:
> > Negative temperatures were returned in degrees C instead of milli-Degrees C.
> > Also, negative temperatures were reported for remote temperature sensors even
> > if the chip was configured for positive-only results.
> > 
> > Fix by detecting temperature modes, and by treating negative temperatures
> > similar to positive temperatures, with appropriate sign extension.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Candidate for -stable.
> > 
> >  drivers/hwmon/lm95241.c |   20 ++++++++++++++------
> >  1 files changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> > index 01c638e..ec02e30 100644
> > --- a/drivers/hwmon/lm95241.c
> > +++ b/drivers/hwmon/lm95241.c
> > @@ -98,11 +98,16 @@ struct lm95241_data {
> >  };
> >  
> >  /* Conversions */
> > -static int TempFromReg(u8 val_h, u8 val_l)
> > +static int temp_from_reg_signed(u8 val_h, u8 val_l)
> >  {
> > -	if (val_h & 0x80)
> > -		return val_h - 0x100;
> > -	return val_h * 1000 + val_l * 1000 / 256;
> > +	s16 val_hl = (val_h << 8) | val_l;
> > +	return val_hl * 1000 / 256;
> > +}
> > +
> > +static int temp_from_reg_unsigned(u8 val_h, u8 val_l)
> > +{
> > +	u16 val_hl = (val_h << 8) | val_l;
> > +	return val_hl * 1000 / 256;
> >  }
> >  
> >  static struct lm95241_data *lm95241_update_device(struct device *dev)
> > @@ -135,10 +140,13 @@ static ssize_t show_input(struct device *dev, struct device_attribute *attr,
> >  			  char *buf)
> >  {
> >  	struct lm95241_data *data = lm95241_update_device(dev);
> > +	int index = to_sensor_dev_attr(attr)->index;
> >  
> >  	return snprintf(buf, PAGE_SIZE - 1, "%d\n",
> > -		TempFromReg(data->temp[to_sensor_dev_attr(attr)->index],
> > -			    data->temp[to_sensor_dev_attr(attr)->index + 1]));
> > +			!index || (data->config & index) ?
> 
> Hmm. This really should be:
> 
> +			!index || (data->config & (1 << (index / 2))) ?
> 
> It just _happens_ that (1 << (index / 2)) = index for index values 2
> and 4, so your code works. But if we ever add support for a compatible
> device with an extra temperature channel, it'll break. Not sure if the
> rest of the driver code would properly cope with such a change anyway,
> though.
> 
> Furthermore, I think that readability could be slightly improved by
> changing "!index" to "index = 0", as this is neither an error
> condition nor a boolean).
> 
Makes sense. I changed it to

		index = 0 || (data->config & (1 << (index / 2)))

> Readability could be improved even more with driver-wide changes but
> this is obviously out-of-scope for this patch.
> 
Yes, I know. Another time, maybe.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
