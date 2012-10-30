From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 17:11:19 +0000
Subject: Re: [lm-sensors] [PATCH v3 8/9] hwmon: (it87) Manage device specific features with table
Message-Id: <20121030171119.GE11394@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121030180244.5767d1d0@endymion.delvare>
In-Reply-To: <20121030180244.5767d1d0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 30, 2012 at 06:02:44PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 29 Oct 2012 17:45:48 -0700, Guenter Roeck wrote:
> > This simplifies the code, improves runtime performance, reduces
> > code size (about 280 bytes on x86_64), and makes it easier
> > to add support for new devices.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v3: s/define^I/define /
> >     Handle new conditional FEAT_TEMP_OFFSET
> >     const char * const name -> const char *name
> >     define "features" flag consistently as u16
> > v2: Don't introduce new chip type for IT8726F. Doing that would break backward
> >     compatibility.
> >     Since we dropped the has_16bit_fans flag from patch 5/8, changing the code
> >     back to use has_16bit_fans() is no longer needed.
> > 
> >  drivers/hwmon/it87.c |  152 ++++++++++++++++++++++++++------------------------
> >  1 file changed, 80 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > index 2c027ae..96759c3 100644
> > --- a/drivers/hwmon/it87.c
> > +++ b/drivers/hwmon/it87.c
> > @@ -228,6 +228,63 @@ static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
> >  #define IT87_REG_AUTO_TEMP(nr, i) (0x60 + (nr) * 8 + (i))
> >  #define IT87_REG_AUTO_PWM(nr, i)  (0x65 + (nr) * 8 + (i))
> >  
> > +struct it87_devices {
> > +	const char *name;
> > +	u16 features;
> > +};
> > +
> > +#define FEAT_12MV_ADC		(1 << 0)
> > +#define FEAT_NEWER_AUTOPWM	(1 << 1)
> > +#define FEAT_OLD_AUTOPWM	(1 << 2)
> > +#define FEAT_16BIT_FANS		(1 << 3)
> > +#define FEAT_TEMP_OFFSET	(1 << 4)
> > +
> > +static const struct it87_devices it87_devices[] = {
> > +	[it87] = {
> > +		.name = "it87",
> > +		.features = FEAT_OLD_AUTOPWM,	/* may need to override */
> > +	},
> > +	[it8712] = {
> > +		.name = "it8712",
> > +		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
> > +	},
> 
> You were supposed to harmonize the wording, weren't you?
> 
Thought I did :(

> > +	[it8716] = {
> > +		.name = "it8716",
> > +		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
> > +	},
> > (...)
> > @@ -1980,8 +1968,28 @@ static int __devinit it87_probe(struct platform_device *pdev)
> >  
> >  	data->addr = res->start;
> >  	data->type = sio_data->type;
> > -	data->revision = sio_data->revision;
> > -	data->name = names[sio_data->type];
> > +	data->features = it87_devices[sio_data->type].features;
> > +	data->name = it87_devices[sio_data->type].name;
> > +	/*
> > +	 * IT8705F Datasheet 0.4.1, 3h = Version G.
> > +	 * IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
> > +	 * These are the first revisions with 16-bit tachometer support.
> > +	 */
> > +	switch (data->type) {
> > +	case it87:
> > +		if (sio_data->revision >= 0x03) {
> > +			data->features &= ~FEAT_OLD_AUTOPWM;
> > +			data->features |= FEAT_16BIT_FANS;
> > +		}
> > +		break;
> > +	case it8712:
> > +		if (sio_data->revision >= 0x08) {
> > +			data->features &= ~FEAT_OLD_AUTOPWM;
> > +			data->features |= FEAT_16BIT_FANS;
> > +		}
> 
> The missing break here is an invitation for future bugs. It was there
> before... I'm adding it back.
> 
Accidential.

> > +	default:
> > +		break;
> > +	}
> >  
> >  	/* Now, we do the remaining detection. */
> >  	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80)
> 
> I fixed it all myself, no need to resend.
> 
Ok. This will conflict with 4/9, though, for the has_temp_offset() function.
Did you fix those as well or should I resend both ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
