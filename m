From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 15 Jan 2013 06:02:28 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Driver for Maxim MAX6697 and compatibles
Message-Id: <20130115060228.GA12840@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355722390-24798-1-git-send-email-linux@roeck-us.net>
 <20130114222404.47d3996d@endymion.delvare>
In-Reply-To: <20130114222404.47d3996d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

On Mon, Jan 14, 2013 at 10:24:04PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late review, originally I planned to do a quick review
> but apparently I am simply unable to do that. So here comes a complete
> review. As usual, pick what you agree with and feel free to ignore the
> rest :)
> 
Hi Jean,

as always an excellent and thorough review.

Couple of comments inline.

> On Sun, 16 Dec 2012 21:33:09 -0800, Guenter Roeck wrote:
> > Add support for MAX6581, MAX6602, MAX6622, MAX6636, MAX6689, MAX6693,
> > MAX6694, MAX6697, MAX6698, and MAX6699 temperature sensors
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2:
> > - Add suppport for platform data and devicetree based chip initialization
> > - Drop S_IRUGOWU macro: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
> > 
> >  Documentation/devicetree/bindings/i2c/max6697.txt |   45 ++
> >  Documentation/hwmon/max6697                       |   57 ++
> >  drivers/hwmon/Kconfig                             |   11 +
> >  drivers/hwmon/Makefile                            |    1 +
> >  drivers/hwmon/max6697.c                           |  634 +++++++++++++++++++++
> >  include/linux/platform_data/max6697.h             |   25 +
> >  6 files changed, 773 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/max6697.txt
> >  create mode 100644 Documentation/hwmon/max6697
> >  create mode 100644 drivers/hwmon/max6697.c
> >  create mode 100644 include/linux/platform_data/max6697.h
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/max6697.txt b/Documentation/devicetree/bindings/i2c/max6697.txt
> > new file mode 100644
> > index 0000000..3e867e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/max6697.txt
> > @@ -0,0 +1,45 @@
> > +max6697 properties
> > +
> > +Required properties:
> > +- compatible:
> > +	Should be one of
> > +		maxim,max6581
> > +		maxim,max6602
> > +		maxim,max6622
> > +		maxim,max6636
> > +		maxim,max6689
> > +		maxim,max6693
> > +		maxim,max6694
> > +		maxim,max6697
> > +		maxim,max6698
> > +		maxim,max6699
> > +- reg: I2C address
> > +
> > +Optional properties:
> 
> Your definition of "optional" is questionable. Setting _any_ of these
> properties will cause _all_ others to be considered as 0 and the chip
> will be reprogrammed with these settings. I'd say this is unexpected and

Actually, not just "any", but the values have to be specified if OF data is
present and a non-default configuration is wanted. I clarified that in the
text.

> confusing. I'd expect struct max6697_platform_data to be able to store
> "don't change" for every setting, so that only the properties actually
> provided are written to the chip.
> 
> If you really don't want to do that, then you should make it prominently
> visible both here and in max6697.h that one should either set all
> properties or none. Beware though that this may still cause trouble if
> you ever have to add one property to the set in the future.
> 
I tried to find a better wording. I do want to set all values, so that part is
on purpose.

> > +- smbus-timeout-disable
> > +	Set to enable SMBus timeout

s/enable/disable/

> > +- extended-range-enable
> > +	Only valid for MAX6581. Set to enable extended temperature range.
> > +- alert-mask
> > +	Alert bit mask. Alert disabled for bits set.
> > +- over-temperature-mask
> > +	Over temperature bit mask. Over temperature reporting disabled for
> > +	bits set.
> > +- resistance-cancellation
> > +	Boolean for all chips other than MAX6581. Enabled if set.
> > +	For MAX6581, resistance cancellation enabled for all channels if
> > +	specified as boolean, otherwise as per bit mask specified.
> > +- transistor-ideality
> > +	For MAX6581 only. Two values; first is bit mask, second is ideality
> > +	select value as per MAX6581 data sheet.
> 
> I'm not familiar with OF properties... Is there any standard for the
> properties above? If not, and other drivers implement similar
> properties, did you make sure to follow existing common practice?
> 
No, not for the optional properties; I did not find anything for those.
I had tried to submit a generic means to configure i2c chips via OF,
but that was rejected even though a similar approach is used for some
PHY chips.

[ ... ]

> > +
> > +static ssize_t show_temp11(struct device *dev,
> > +			   struct device_attribute *devattr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr_2(devattr)->nr;
> > +	int index = to_sensor_dev_attr_2(devattr)->index;
> > +	struct max6697_data *data = max6697_update_device(dev);
> > +
> > +	if (IS_ERR(data))
> > +		return PTR_ERR(data);
> > +
> > +	return sprintf(buf, "%d\n",
> > +		       ((data->temp[nr][index] << 3) |
> > +			(data->temp[nr][index + 1] >> 5)) * 125);
> 
> I can't see this code dealing properly with the negative temperature
> values supported by the MAX6581, nor with its extended format... nor
> with its normal format BTW, as it turns out to be completely different
> from the other chips.
> 
Actually, the data sheet is wrong for the normal format; actual values 
are the same as for other chips in that case. I now added explicit support
for the extended data format, by subtracting 64 from the returned value if
enabled. AFAICS that is correct.

> Did you have a formal request to support the MAX6581? It is different
> enough from the other support chips that I wouldn't mind dropping
> support for it from this driver, and only add support for it if someone
> needs it.
> 
MAX6581 is one of the chips used by Juniper (besides MAX6697), so I need
to have support for it.

[ ... ]

> > +
> > +static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 0);
> 
> This one will never be used, as temp1 is local and can't be faulty.
> 
It was there to have 6 sensors per group in the single-dimensional array
(which I needed for the initialization). I changed the array to two-dimensional,
so this is now gone.

[ ... ]

> > +	if (!pdata && !client->dev.of_node)
> > +		return 0;
> > +
> > +	if (!pdata || client->dev.of_node) {
> 
> A comment of what you're testing here would be helpful. Does platform
> take precedence over OF data, or the other way around? In fact the test
> seems wrong, as the second half will always be true if evaluated.
> 
The idea was for OF data to take precedence. So
	if (client->dev.of_node) {
serves the purpose.

[ ... ]
> > +
> > +	ret = i2c_smbus_write_byte_data(client, MAX6697_REG_CONFIG, reg);
> > +	if (ret < 0)
> > +		return ret;
> 
> You should never do this. If you want to modify specific bits of a
> register, read it first, modify and write back. Don't arbitrarily set
> the other bits to 0.
> 
That is on purpose. I want to set all other bits to 0.

Other problems I found:

- Bit masks were not well specified. While temp1 is local and temp2..8 are
  remote, bit masks were as per chip specifications. I changed the bit masks to
  follow temp1..8, ie bit 0=local, bit 1..7=remote.
- If neither platform data nor OF data is available, chip configuration was not
  read. Didn't make much of a difference in the old code, but since I now
  support the extended temperature on MAX6581 and a chip/config specific
  update interval, I had to add code to read the configuration in that case.

I'll do some more testing and resubmit later this week.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
