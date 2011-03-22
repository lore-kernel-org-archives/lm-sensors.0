From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 22 Mar 2011 00:00:42 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] hwmon: sht15: add support for
Message-Id: <20110322000042.GB14559@v0n.mtl.sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan.
On Mon, Mar 21, 2011 at 07:43:59PM +0000, Jonathan Cameron wrote:
> On 03/16/11 18:44, Vivien Didelot wrote:
> > Add support to read the sht15 status register. Explicitly:
> > * The measurement resolution through the temp_resolution and
> >   humidity_resolution sysfs attributes;
> > * An end of battery indicator through the battery_alarm sysfs attribute;
> > * Embedded heater support using the heater_enable sysfs attribute;
> > * Reload from OTP available through the otp_reload sysfs attribute.
> Hi Vivien.
> 
> As Guenter said, these definitely need documenting.. Once that is available
> I expect people will debate naming etc.
Sure. After discussing about that, checksumming, otp_reload and
*_resolution attributes have been removed. battery_alarm will be splitted into
temp1_alarm and humidity1_alarm to respect the convention.

I'll also add a documentation in Documentation/hwmon/ for the device.

> >  #define SHT15_MEASURE_TEMP	0x03
> >  #define SHT15_MEASURE_RH	0x05
> >  #define SHT15_SOFT_RESET	0x1E
> > +#define SHT15_READ_STATUS	0x07
> Keep this in numerical order.
Ok.

> Why cached the raw status?  Can't see any users.
> > +	u8				val_status;
As you've seen, it will be used in the next patch.

> Bit field for all these plesae as they are flags - might as well
> allow for possibility of saving a bit of space.
> > +	u8				end_of_battery;
> > +	u8				heater;
> > +	u8				no_otp_reload;
> > +	u8				temp_resolution;
> > +	u8				humidity_resolution;
Ok, I'll check it out.

> make it easier to read with !!(status & SHT15_STATUS_BATTERY);
> etc.
> > +	data->end_of_battery = (status & SHT15_STATUS_BATTERY) >> 6;
> > +	data->heater = (status & SHT15_STATUS_HEATER) >> 2;
> > +	data->no_otp_reload = (status & SHT15_STATUS_OTP_RELOAD) >> 1;
Good idea.

> Given these are yoked together could just have a single flag and
> interpret it in the few places that care?
> > +	if (status & SHT15_STATUS_RESOLUTION) {
> > +		data->temp_resolution = 12;
> > +		data->humidity_resolution = 8;
> > +	} else {
> > +		data->temp_resolution = 14;
> > +		data->humidity_resolution = 12;
> > +	}
Regarding one of your comment in the next patch, it makes sense to use an
explicit single flag, so I'll remove this as well.

> >  /**
> > @@ -378,6 +460,9 @@ static int sht15_update_vals(struct sht15_data *data)
> >  	mutex_lock(&data->read_lock);
> >  	if (time_after(jiffies, data->last_updat + timeout)
> >  	    || !data->valid) {
> As with the previous version, I'd make this optional controlled
> by platform data.  Not everyone cares and it just made their gpio's
> jump up and down a fair bit more.  Obviously if it's turned off, you
> will also want to change what attributes are registered.
> > +		ret = sht15_update_status(data);
> > +		if (ret)
> > +			goto error_ret;
I put the sht15_update_status() call here so it could have benefit of the
jiffies calculation. I also thought that it could be useful to update the
device state before each measurement, in order to notice an eventual low
power notice. Maybe I'm wrong and this test should be done separately?

> > +	/* Technically no need to read temperature and humidity as well */
> Given we do a fresh read here, why bother having the cache at all?  Just
> read it explicitly when we care.
> > +	ret = sht15_update_vals(data);
According to the previous comment, what about adding a mask as an argument
to the sht15_update_vals() function to know which measurement to do (only
status, temperature + humidity, etc.)?  Because the discussion could also
be pointed on the temperature measurement, which update unnecessarily the
humidity as well.

> I've no idea off the top of my head what OTP is so perhaps a more
> informative name or a suitable comment?
> > +static ssize_t sht15_show_otp_reload(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       char *buf)
This attribute will be removed and available from the platform data only.
It will be documented as well.

> > +static DEVICE_ATTR(battery_alarm, S_IRUGO, sht15_show_battery, NULL);
> > +static DEVICE_ATTR(heater_enable, S_IRUGO, sht15_show_heater, NULL);
> > +static DEVICE_ATTR(otp_reload, S_IRUGO, sht15_show_otp_reload, NULL);
> Not a chance any attribute with that incomprehensible a name is going
> to be merged.  For reference of others its a question of whether magic
> component specific corrections are applied or not.
> 
This will be updated.

> > +static DEVICE_ATTR(temp_resolution,
> > +		S_IRUGO,
> > +		sht15_show_temp_resolution,
> > +		NULL);
> > +static DEVICE_ATTR(humidity_resolution,
> > +		S_IRUGO,
> > +		sht15_show_humidity_resolution,
> > +		NULL);
> Probably do resolutions through platform data.  Might be some
> usecases for dynamically varying them but is it worth while
> supporting?  Not sure. One for discussion when you propose some
> documentation for these.
> 
Yes, resolution will be set in platform data.

Regards,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
