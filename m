From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 16:52:21 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (adt7410) Add support for the adt7310/adt7320
Message-Id: <20130219165221.GC19550@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <1361194739-16525-2-git-send-email-lars@metafoo.de>
 <20130219013003.GB25124@roeck-us.net>
 <512368B7.5060003@metafoo.de>
In-Reply-To: <512368B7.5060003@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Tue, Feb 19, 2013 at 12:57:43PM +0100, Lars-Peter Clausen wrote:
> On 02/19/2013 02:30 AM, Guenter Roeck wrote:
> > On Mon, Feb 18, 2013 at 02:38:57PM +0100, Lars-Peter Clausen wrote:
> [...]
> >> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
> >> new file mode 100644
> >> index 0000000..2196ac3
> >> --- /dev/null
> >> +++ b/drivers/hwmon/adt7310.c
> >> @@ -0,0 +1,115 @@
> >> +/*
> >> + * ADT7310/ADT7310 digital temperature sensor driver
> >> + *
> >> + * Copyright 2010-2013 Analog Devices Inc.
> > 
> > Not really; copyright is yours, unless you are signing it off to analog or if
> > you are working for them and have permission (or the duty) to sign off the
> > copyright. Even then it should be 2013 only for this file.
> 
> I work for them. The copyright notice comes from the IIO adt7410/adt7310
> driver, where also this code comes from. Although this portion of the code
> was written in 2012, so maybe change it to 2012-2013.
> 
Ok.

> [...]
> >> diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
> >> new file mode 100644
> >> index 0000000..a7165e6
> >> --- /dev/null
> >> +++ b/drivers/hwmon/adt7x10.h
> >> @@ -0,0 +1,48 @@
> >> +#ifndef __HWMON_ADT7X10_H__
> >> +#define __HWMON_ADT7X10_H__
> >> +
> >> +#include <linux/types.h>
> >> +#include <linux/pm.h>
> >> +
> >> +/* ADT7410 registers definition */
> >> +#define ADT7410_TEMPERATURE		0
> >> +#define ADT7410_STATUS			2
> >> +#define ADT7410_CONFIG			3
> >> +#define ADT7410_T_ALARM_HIGH		4
> >> +#define ADT7410_T_ALARM_LOW		6
> >> +#define ADT7410_T_CRIT			8
> >> +#define ADT7410_T_HYST			0xA
> >> +#define ADT7410_ID			0xB
> >> +
> >> +/* ADT7310 registers definition */
> >> +#define ADT7310_STATUS			0
> >> +#define ADT7310_CONFIG			1
> >> +#define ADT7310_TEMPERATURE		2
> >> +#define ADT7310_ID			3
> >> +#define ADT7310_T_CRIT			4
> >> +#define ADT7310_T_HYST			5
> >> +#define ADT7310_T_ALARM_HIGH		6
> >> +#define ADT7310_T_ALARM_LOW		7
> >> +
> >> +struct device;
> >> +
> >> +struct adt7410_ops {
> >> +	int (*read_byte)(struct device *, u8 reg);
> >> +	int (*write_byte)(struct device *, u8 reg, u8 data);
> >> +	int (*read_word)(struct device *, u8 reg);
> >> +	int (*write_word)(struct device *, u8 reg, u16 data);
> >> +};
> >> +
> >> +int adt7410_probe(struct device *dev, const char *name,
> >> +	const struct adt7410_ops *ops);
> >> +int adt7410_remove(struct device *dev);
> >> +
> > 
> > I think the above should be adt7x10_ops, adt7x10_probe and adt7x10_remove, to
> > indicate that those are common functions.
> > 
> > I would actually suggest to rename all functions in adt7x10.c (not just the
> > exported ones).
> 
> I normally don't like to rename all the symbols in one file just because
> support for another part is added, since it just cause lots of noise in the
> diff. My initial plan was to call the two new modules adt7410-i2c and
> adt7410-spi, but then though it is probably going to be confusing to have
> the driver for the adt7310 called adt7410-spi. In this case the renaming
> probably doesn't hurt since we already have lots of diff noise anyway. It
> probably would have made sense to make the review easier to split this up in
> two patches, one which renames adt7410 to adt7x10 and a second one which
> adds the new functionality.
> 
In general I agree, but the diff shows the renamed file as all-new code anyway,
so I figured renaming the functions doesn't really create additional noise. I'll
leave it up to you how to handle it in detail, but the exported common functions
and defines should really not be named adt7410. After all, future developers
won't know the history.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
