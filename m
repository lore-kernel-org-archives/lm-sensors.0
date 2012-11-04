From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Nov 2012 09:00:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for AMDTSI, and restrict  sensor type configurati
Message-Id: <20121104100000.5641a6b0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351820480-8998-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351820480-8998-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 3 Nov 2012 15:03:17 -0700, Guenter Roeck wrote:
> On Sat, Nov 03, 2012 at 08:59:45PM +0100, Jean Delvare wrote:
> > On Thu,  1 Nov 2012 18:41:20 -0700, Guenter Roeck wrote:
> > > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > > index 6a1410b..362ba60 100644
> > > --- a/drivers/hwmon/it87.c
> > > +++ b/drivers/hwmon/it87.c
> > > @@ -331,6 +331,7 @@ struct it87_data {
> > >  	u16 features;
> > >  	u8 peci_mask;
> > >  	u8 old_peci_mask;
> > > +	u8 ext_temp_type;	/* external temperature sensor type (5 or 6) */
> > >  
> > >  	unsigned short addr;
> > >  	const char *name;
> > > @@ -643,7 +644,7 @@ static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
> > >  
> > >  	if ((has_temp_peci(data, nr) && (reg >> 6 = nr + 1))
> > >  	    || (has_temp_old_peci(data, nr) && (extra & 0x80)))
> > > -		return sprintf(buf, "6\n");  /* Intel PECI */
> > > +		return sprintf(buf, "%u\n", data->ext_temp_type);
> > 
> > In theory you need an explicit cast to unsigned int (or unsigned short
> > with %hu).
>
> Ok. Or maybe just use %d ?

You'll need a cast with %d too. There is simply no format to print a u8.

> > > (...)
> > > +	if (data->features & FEAT_TEMP_OLD_PECI) {
> > > +		reg = it87_read_value(data, IT87_REG_VID);
> > > +		switch ((reg >> 4) & 0x07) {
> > > +		case 0x0:
> > > +		default:
> > > +			data->features &> > > +			  ~(FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI);
> > > +			break;
> > > +		case 0x3:	/* PCH (IT8721F) */
> > > +			if (data->features & FEAT_TEMP_PECI) {
> > > +				data->features &= ~FEAT_TEMP_PECI;
> > > +				data->ext_temp_type = 6;
> > > +			} else {
> > > +				data->features &= ~FEAT_TEMP_OLD_PECI;
> > > +			}
> > > +			break;
> > > +		case 0x4:	/* AMDTSI */
> > > +			data->ext_temp_type = 5;
> > > +			break;
> > 
> > The IT8782 and IT8783 datasheets I have suggest that AMDTSI isn't
> > supported on these two chips.
>
> Thanks for the note - I didn't notice. I'll have to think about this some more.
> Maybe I should introduce a separate flag for AMDTSI.

Or do this part of the configuration based on chip type rather than
feature flags. I think I would have started there (which doesn't mean
it'll be better though, you won't know for sure until you try.)

> > (...)
> > I am having a hard time finding information about SST. Is it a variant
> > of PECI, an Intel-only thing? Do you have documentation?
>
> Nothing really. The W83627UHG datasheet says it means Simple Serial Transport,
> which is supposed to be a replacement for SMBus. Not sure if it is really
> used anywhere (or what we should do if it is selected, for that matter).

OK... I suppose it is used to let a master hardware monitoring device
read from a slave hardware monitoring device so that the master can do
automatic fan speed regulation based on e temperature sensor found in
the slave. Counting this as PECI isn't quite right... the truth in this
case is that we don't know the sensor type, other than its external
nature. We should either not report a type at all (but that might make
the code more complex) or add another type value for this case, like
"external" or "unknown".

> > (...)
> > The more I look at the code above, the more I suspect that you should
> > have made PCH PECI a separate feature from FEAT_TEMP_OLD_PECI. I'm
> > sure it would make the code a lot clearer and less fragile too. Your
> > code makes the assumption that FEAT_TEMP_PECI + FEAT_TEMP_OLD_PECI <=>
> > FEAT_TEMP_OLD_PECI relates to PCH, which happens to be the case today
> > but that's just a coincidence and that could change in the future. I
> > couldn't find any bug in the code above but it took me a long time to
> > read it, understand it and make sure it was correct. That doesn't seem
> > right.
>
> Plus, turns out IT8728F actually has a separate register to select the target
> for AMDTSI/PCH :(. I'll think about it some more.

OK.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
