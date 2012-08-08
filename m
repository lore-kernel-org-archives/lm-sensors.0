From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Aug 2012 06:28:20 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Driver for ADT7410
Message-Id: <20120808062820.GA22903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <501BA87C.2020907@gmx.de>
In-Reply-To: <501BA87C.2020907@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 07, 2012 at 10:53:53PM +0200, Hartmut Knaack wrote:
> Hi Guenter,
> I did most of the fixes you recommended, just a few issues bother me, see below.
> Guenter Roeck schrieb:
> > On Fri, Aug 03, 2012 at 12:31:24PM +0200, Hartmut Knaack wrote:
> > +static int adt7410_temp_ready(struct i2c_client *client)
> > +{
> > +	int i, status;
> > +
> > +	for (i = 0; i < 4; i++) {
> > +		status = i2c_smbus_read_byte_data(client, ADT7410_STATUS);
> > +		if (status < 0)
> > +			return status;
> > +		if (!(status & ADT7410_STAT_NOT_RDY))
> > +			return 0;
> > +		msleep(100);
> > That seems to be a very excessive delay, and a huge penalty.
> >
> > I still wonder why you think this is needed. Almost every temperature sensor
> > chip
> > has a "busy" status bit, and we pretty much always ignore it.
> >
> > I suspect that this might actually be counter-reductive; the datasheet suggests
> > that -RDY is set after the temperature is read, and cleared after the next
> > update cycle. But for our application we don't really care if the old
> > temperature is returned multiple times.
> >
> My interpretation of the datasheet is, this bit indicates that a new temperature sample has been taken/stored since the last read. This indicates that the sensor is working properly (and not for some reason fallen into powerdown mode or defective). Maybe that is a bit paranoid, but I think the trade-off with this check function is rather low compared to possible problems resulting of wrong temperature values. Therefor I prefer to keep it.
> I also changed the sleep periods to 60 ms, giving the sensor up to 360 ms to come up with a valid sample. This is 150 % of the regular time (240 ms) to get a full sample.
> >

Hmm ... did you actually test it ? Never mind, I'll leave that up to you, but I
strongly suspect that it is unnecessary.

> >> +	if ((hyst < ADT7410_TEMP_MIN) || (hyst > ADT7410_TEMP_MAX))
> >> +		return -EINVAL;
> > Unnecessary ( )
> >
> > Clamping with SENSORS_LIMIT would be much better here and more consistent.
> > since you don't want to force the user to find the valid range by
> > trial-and-error.
> I thought about this a lot, and have to say that I prefer to let the user know if he entered an invalid value rather than just silently applying the min/max value of the device. That said, I am not really comfortable with the use of SENSORS_LIMIT in ADT7410_TEMP_TO_REG any more. Why do you prefer to clamp invalid values instead of indicating the need for the user to read about the hardware specifications?

The following quote is from an exchange I had about the subject with Jean Delvare.

"... The point of SENSORS_LIMIT() is to clamp the value provided
by the user when the hardware limits aren't known by the user. If the
user wants to set the high voltage limit to 2.2 V and the ADC only
supports 2.04 V max, it doesn't seem fair to yell at the user. Even
more so when the value being set may have been computed by libsensors
from a formula in sensors.conf."

And this is what Documentation/hwmon/sysfs-interface says:

"What to do if a value is found to be invalid, depends on the type of the
sysfs attribute that is being set. If it is a continuous setting like a
tempX_max or inX_max attribute, then the value should be clamped to its
limits using SENSORS_LIMIT(value, min_limit, max_limit). If it is not
continuous like for example a tempX_type, then when an invalid value is
written, -EINVAL should be returned."

Please follow its guidance.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
