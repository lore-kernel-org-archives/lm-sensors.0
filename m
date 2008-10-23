From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 23 Oct 2008 13:13:23 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081023131323.GA20521@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

On Thu, Oct 23, 2008 at 02:57:10PM +0200, Jean Delvare wrote:
> > +  * Texas Instruments TMP121/TMP123
> > +    Datasheet: http://www.ti.com/lit/gpn/tmp121
> 
> I'd rather link to:
> http://focus.ti.com/docs/prod/folders/print/tmp121.html
> Where people can see a lot of useful information about the chip, and
> then download the datasheet.

done; (the chip isn't _that_ interesting or special ;-) )


> > +The TMP121 is very similar; main differences are 4 wire SPI interface,
> > +and 13bit temperature data (0.0625 celsius resolution).
> 
> 13-bit, degree Celsius

> > +	switch (p_lm70->chip) {
> > +	case LM70_CHIP_LM70:
> > +		raw = (rxbuf[1] << 8) + rxbuf[0];
> > +		dev_dbg(dev, "raw=0x%x\n", raw);
> 
> This debug statement is common to all cases so it could be moved
> outside of the switch block.

> > +	case LM70_CHIP_TMP121:
> > +		raw = (rxbuf[0] << 8) + rxbuf[1];
> > +		dev_dbg(dev, "raw=0x%x\n", raw);
> > +		val = (raw / 8) * 625 / 10;
> > +		break;
> > +
> > +	default:
> > +		raw = 0;
> 
> This default case is broken, it sets raw but not val, while what the
> following code uses is val. Anyway, I don't think you really need a
> default here, the chip type should have already been checked as you
> reach this portion of the driver code.
 
> > -	return sprintf(buf, "lm70\n");
> > +	struct spi_device *spi = to_spi_device(dev);
> > +	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
> 
> Err, what about just:
> 	struct lm70 *p_lm70 = dev_get_drvdata(dev);
> ? You don't use spi anywhere else.

I fixed everything you pointed out above;


> > --- /dev/null
> > +++ b/include/linux/spi/lm70.h
> > @@ -0,0 +1,15 @@
> > +/*
> > + * LM70 platform data
> > + */
> > +
> > +#ifndef _LM70_H_
> > +#define _LM70_H_
> > +
> > +#define LM70_CHIP_LM70		0
> > +#define LM70_CHIP_TMP121	1
> > +
> > +struct lm70_platform_data {
> > +	unsigned int chip;
> > +};
> > +
> > +#endif
> 
> I don't know much about the SPI side of things so I would like someone
> else to comment on that aspect of the patch (in particular the way
> different device types are supported by the same driver.) David, can
> you please take a look and let us know if you have any objection?

I'd be more than happy to just use a number cast to void * for 
spi platform_data and get rid of this header.  I'm not sure however
whether this is acceptable style for kernel code.

Thank you!
	Manuel Lauss

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
