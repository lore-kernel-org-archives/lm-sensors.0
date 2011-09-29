From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 29 Sep 2011 16:37:24 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: ad7314 driver (ported from IIO).
Message-Id: <4E849EC4.5070603@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E834D56.8060502@cam.ac.uk>  <1317298279-25905-1-git-send-email-jic23@cam.ac.uk> <1317310610.3888.148.camel@groeck-laptop>
In-Reply-To: <1317310610.3888.148.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Device-drivers-devel@blackfin.uclinux.org" <Device-drivers-devel@blackfin.uclinux.org>

On 09/29/11 16:36, Guenter Roeck wrote:
> On Thu, 2011-09-29 at 08:11 -0400, Jonathan Cameron wrote:
>> Currently dropped power down mode support.
>> V2: Fixes:
>> - messed up use of cache aligned store fixed.
>> - correct output format to be milli degrees.
>> - add documentation file.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Hi Jonathan,
> 
> almost there ...
:)
>> +==========
>> +
>> +Supported chips:
>> +   * Analog Devices AD7314
>> +     Prefx: 'ad7314'
>> +     Datasheet: Publicaly available at Analog Devices website.
>> +   * Analog Devices ADT7301
>> +     Prefx: 'adt7301'
>> +     Datasheet: Publicaly available at Analog Devices website.
>> +   * Analog Devices ADT7302
>> +     Prefx: 'adt7302'
>> +     Datasheet: Publicaly available at Analog Devices website.
> 
> Publicaly -> Publicly
drat, forgot to spell check. For that matter Prefx -> Prefix.

>> +		/*
>> +		 * Documented as a 13 bit twos complement register
>> +		 * with a sign bit - which is a 14 bit 2's complement
>> +		 * register.  1lsb - 31.25 milli degrees centigrade
>> +		 */
>> +		data &= ADT7301_TEMP_MASK;
>> +		data = (data << 2) >> 2;
>> +
>> +		return sprintf(buf, "%d\n", (3125 * (int)data)/100);
> 
> You don't need a typecast here (like with the first sprintf). There
> should be spaces around '/' (CodingStyle 3.1). 
> Even better would be to use
> 		DIV_ROUND_CLOSEST(data * 3125, 100)
> to reduce the rounding error.
Nice. Didn't know about that one.
> 
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>> +			  ad7314_show_temperature, NULL, 0);
>> +
>> +static struct attribute *ad7314_attributes[] = {
>> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ad7314_group = {
>> +	.attrs = ad7314_attributes,
>> +};
>> +
>> +static int __devinit ad7314_probe(struct spi_device *spi_dev)
>> +{
>> +	int ret;
>> +	struct ad7314_data *chip;
>> +
>> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>> +	if (chip = NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_ret;
>> +	}
>> +	dev_set_drvdata(&spi_dev->dev, chip);
>> +
>> +	ret = sysfs_create_group(&spi_dev->dev.kobj, &ad7314_group);
>> +	if (ret < 0)
>> +		goto error_free_chip;
>> +
> Something missing here which I didn't notice at first ... but you do
> remove the hwmon device below, so it makes sense to create it ;).
> 
> 	chip->hwmon_dev = hwmon_device_register(&spi_dev->dev);
>         if (IS_ERR(chip->hwmon_dev)) {
>                 err = PTR_ERR(chip->hwmon_dev);
>                 goto error_remove_group;
>         }
> 
Gah!

That's the problem with developing without hardware.  This sort of
dumbass error always seem to sneak in.

Good spot.

New version along shortly.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
