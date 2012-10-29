From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Oct 2012 17:28:30 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121029172830.GA27431@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 29, 2012 at 05:55:20PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 28 Oct 2012 11:20:01 -0700, Guenter Roeck wrote:
> > IT8721 and IT8728 support Intel PECI temperature reporting. Each sensor
> > can be programmed to display the temperature reported on the PECI interface.
> > 
> > If configured for Intel PECI, the driver reported the respective thermal sensor
> > as "disabled (0)". Fix the code to correctly report it as "Intel PECI (6)".
> 
> I think the driver reported it as whatever the other configuration bits
> said, not necessarily zero. The configuration scheme for thermal sensor
> types on these chips is anything but straightforward, plus you
> shouldn't assume every BIOS out there is sane ;)
> 
Good point. I'll change the text.

> Anyway, good catch, I had not noticed that newer IT87xxF chips had
> support for PECI.
> 
Me not either. See below how I found it. Interestingly, IT8782 and IT8783
don't support it (IT8772 does, though, according to coreboot).

> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Another potential candidate for -stable.
> 
> Seems difficult with this patch at the end of the series and depending
> on another non-trivial patch earlier in the series. Anyway I consider
> this a new feature rather than a bug fix, and some more work seems to
> be needed (see below), so no, I don't think pushing this to stable is
> the right thing to do.
> 
Ok; pretty much why I didn't do it in the first place.

> > 
> >  Documentation/hwmon/it87 |    3 ++-
> >  drivers/hwmon/it87.c     |   18 ++++++++++++++----
> >  2 files changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
> > index 92ce617..3d938aea 100644
> > --- a/Documentation/hwmon/it87
> > +++ b/Documentation/hwmon/it87
> > @@ -217,4 +217,5 @@ Temperature offset attributes
> >  The driver supports temp[1-3]_offset sysfs attributes to adjust the reported
> >  temperature for thermal diodes or diode connected thermal transistors.
> >  If a temperature sensor is configured for thermistors, the attribute values
> > -are ignored.
> > +are ignored. If the thermal sensor type is Intel PECI, the temperature offset
> > +must be programmed to the critical CPU temperature.
> 
> I don't quite get this part.. Who should do that, and how?
> 
The BIOS, presumably. It does it on my board, but wrongly. It sets it
to 97 degrees C, while the CPU's Tcrit is 105 degrees C. I fixed the
offset to 105, and now the reported temperature matches the CPU temperature
(and moves with it). This is how I found out about PECI support in the
first place.

> > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > index f3f3e79..f8336be 100644
> > --- a/drivers/hwmon/it87.c
> > +++ b/drivers/hwmon/it87.c
> > @@ -237,6 +237,7 @@ struct it87_devices {
> >  #define	FEAT_NEWER_AUTOPWM	(1 << 1)
> >  #define	FEAT_OLD_AUTOPWM	(1 << 2)
> >  #define	FEAT_16BIT_FAN		(1 << 3)
> > +#define	FEAT_PECI		(1 << 4)
> >  
> >  static const struct it87_devices it87_devices[] = {
> >  	[it87] = {
> > @@ -261,11 +262,13 @@ static const struct it87_devices it87_devices[] = {
> >  	},
> >  	[it8721] = {
> >  		.name = "it8721",
> > -		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FAN,
> > +		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FAN
> > +		  | FEAT_PECI,
> >  	},
> >  	[it8728] = {
> >  		.name = "it8728",
> > -		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FAN,
> > +		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FAN
> > +		  | FEAT_PECI,
> >  	},
> >  	[it8782] = {
> >  		.name = "it8782",
> > @@ -281,6 +284,7 @@ static const struct it87_devices it87_devices[] = {
> >  #define has_12mv_adc(data)	((data)->features & FEAT_12MV_ADC)
> >  #define has_newer_autopwm(data)	((data)->features & FEAT_NEWER_AUTOPWM)
> >  #define has_old_autopwm(data)	((data)->features & FEAT_OLD_AUTOPWM)
> > +#define has_peci(data)		((data)->features & FEAT_PECI)
> >  
> >  struct it87_sio_data {
> >  	enum chips type;
> > @@ -581,6 +585,8 @@ static ssize_t show_type(struct device *dev, struct device_attribute *attr,
> >  	struct it87_data *data = it87_update_device(dev);
> >  	u8 reg = data->sensor;	    /* In case value is updated while used */
> >  
> > +	if (has_peci(data) && (reg >> 6 = nr + 1))
> > +		return sprintf(buf, "6\n");  /* Intel PECI */
> 
> Looks fine for the IT8728F, but not for the IT8721F.
> 
> For the IT8721F, the code above works fine for temp1 and temp3, but as
> I understand the datasheet, value 2 isn't possible and the PECI flag
> for temp2 would be bit 7 in register 0x55. On that chip, the CPU PECI
> temperature can only be mapped to temp1 and temp3 and the south bridge
> (PCH) PECI temperature can only be mapped to temp2.
> 
Yes, I know, I was lazy :). I think I'll use a bitmap to handle it.
Should only be releevant for writes, though.

> Speaking of PCH PECI temperature, apparently the IT8728F can do this
> too, but differently. Relevant register is 0x9E, but to be honest I'm
> not sure exactly how to handle it :( I suppose we can start with only
> supporting the other registers for the time being, it's already better
> than the current situation.
> 
Let me check on my board. Maybe I can get it to work; if so, I'll submit another
patch to handle it.

> >  	if (reg & (1 << nr))
> >  		return sprintf(buf, "3\n");  /* thermal diode */
> >  	if (reg & (8 << nr))
> > @@ -604,13 +610,17 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
> >  	reg = it87_read_value(data, IT87_REG_TEMP_ENABLE);
> >  	reg &= ~(1 << nr);
> >  	reg &= ~(8 << nr);
> > +	if (has_peci(data) && (reg >> 6 = nr + 1 || val = 6))
> > +		reg &= 0x3f;
> >  	if (val = 2) {	/* backwards compatibility */
> >  		dev_warn(dev,
> >  			 "Sensor type 2 is deprecated, please use 4 instead\n");
> >  		val = 4;
> >  	}
> > -	/* 3 = thermal diode; 4 = thermistor; 0 = disabled */
> > -	if (val = 3)
> > +	/* 3 = thermal diode; 4 = thermistor; 6 = Intel PECI; 0 = disabled */
> > +	if (has_peci(data) && val = 6)
> > +		reg |= (nr + 1) << 6;
> 
> If there's no specific reason for handling this first, I'd move it last
> for consistency and a slightly smaller patch.
> 
Ok.

> > +	else if (val = 3)
> >  		reg |= 1 << nr;
> >  	else if (val = 4)
> >  		reg |= 8 << nr;
> 
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
