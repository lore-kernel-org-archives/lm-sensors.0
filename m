From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 16 Feb 2013 19:15:43 +0000
Subject: Re: [lm-sensors] [PATCH 7/9] hwmon: (adt7410) Add support for the adt7310/adt7320
Message-Id: <20130216191543.GA13740@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-7-git-send-email-lars@metafoo.de>
 <20130215203243.GG32433@roeck-us.net>
 <511FADFF.1040604@metafoo.de>
In-Reply-To: <511FADFF.1040604@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Sat, Feb 16, 2013 at 05:04:15PM +0100, Lars-Peter Clausen wrote:
> On 02/15/2013 09:32 PM, Guenter Roeck wrote:
> > On Fri, Feb 15, 2013 at 05:57:16PM +0100, Lars-Peter Clausen wrote:
> >> The adt7310/adt7320 is the SPI version of the adt7410/adt7320. The register map
> >> layout is a bit different, i.e. the register addresses differ between the two
> >> variants, but the bit layouts of the individual registers are identical. So both
> >> chip variants can easily be supported by the same driver. The issue of non
> >> matching register address layouts is solved by a simple look-up table which
> >> translates the I2C addresses to the SPI addresses.
> >>
> >> The patch moves the bulk of the adt7410 driver to a common module that will be
> >> shared by the adt7410 and adt7310 drivers. This common module implements the
> >> driver logic and uses a set of virtual functions to perform IO access. The
> >> adt7410 and adt7310 driver modules provide proper implementations of these IO
> >> accessor functions for I2C respective SPI.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >> ---
> >>  drivers/hwmon/Kconfig   |  20 ++
> >>  drivers/hwmon/Makefile  |   2 +
> >>  drivers/hwmon/adt7310.c | 160 ++++++++++++++++
> >>  drivers/hwmon/adt7410.c | 472 ++++++-----------------------------------------
> >>  drivers/hwmon/adt7x10.c | 476 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/hwmon/adt7x10.h |  47 +++++
> >>  6 files changed, 758 insertions(+), 419 deletions(-)
> >>  create mode 100644 drivers/hwmon/adt7310.c
> >>  create mode 100644 drivers/hwmon/adt7x10.c
> >>  create mode 100644 drivers/hwmon/adt7x10.h
> >>
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 89ac1cb..aaa14f4 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -179,9 +179,29 @@ config SENSORS_ADM9240
> >>  	  This driver can also be built as a module.  If so, the module
> >>  	  will be called adm9240.
> >>  
> >> +config SENSORS_ADT7X10
> >> +	tristate
> >> +	help
> >> +	  This module contains common code shared by the ADT7310/ADT7320 and
> >> +	  ADT7410/ADT7420 temperature monitoring chip drivers.
> >> +
> >> +	  If build as a module, the module will be called adt7x10.
> >> +
> >> +config SENSORS_ADT7310
> >> +	tristate "Analog Devices ADT7310/ADT7320"
> >> +	depends on SPI_MASTER
> >> +	select SENSORS_ADT7X10
> >> +	help
> >> +	  If you say yes here you get support for the Analog Devices
> >> +	  ADT7310 and ADT7320 temperature monitoring chips.
> >> +
> >> +	  This driver can also be built as a module. If so, the module
> >> +	  will be called adt7310.
> >> +
> >>  config SENSORS_ADT7410
> >>  	tristate "Analog Devices ADT7410/ADT7420"
> >>  	depends on I2C
> >> +	select SENSORS_ADT7X10
> >>  	help
> >>  	  If you say yes here you get support for the Analog Devices
> >>  	  ADT7410 and ADT7420 temperature monitoring chips.
> >> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> >> index 8d6d97e..5d36a57 100644
> >> --- a/drivers/hwmon/Makefile
> >> +++ b/drivers/hwmon/Makefile
> >> @@ -34,6 +34,8 @@ obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
> >>  obj-$(CONFIG_SENSORS_ADS1015)	+= ads1015.o
> >>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
> >>  obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
> >> +obj-$(CONFIG_SENSORS_ADT7X10)	+= adt7x10.o
> >> +obj-$(CONFIG_SENSORS_ADT7310)	+= adt7310.o
> >>  obj-$(CONFIG_SENSORS_ADT7410)	+= adt7410.o
> >>  obj-$(CONFIG_SENSORS_ADT7411)	+= adt7411.o
> >>  obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
> >> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
> >> new file mode 100644
> >> index 0000000..0483e6c
> >> --- /dev/null
> >> +++ b/drivers/hwmon/adt7310.c
> >> @@ -0,0 +1,160 @@
> >> +/*
> >> + * ADT7310/ADT7310 digital temperature sensor driver
> >> + *
> >> + * Copyright 2010-2013 Analog Devices Inc.
> >> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
> >> + *
> >> + * Licensed under the GPL-2 or later.
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/init.h>
> >> +#include <linux/spi/spi.h>
> >> +
> >> +#include "adt7x10.h"
> >> +
> >> +static const u8 adt7371_reg_table[] = {
> >> +	[ADT7410_TEMPERATURE]   = ADT7310_TEMPERATURE,
> >> +	[ADT7410_STATUS]	= ADT7310_STATUS,
> >> +	[ADT7410_CONFIG]	= ADT7310_CONFIG,
> >> +	[ADT7410_T_ALARM_HIGH]	= ADT7310_T_ALARM_HIGH,
> >> +	[ADT7410_T_ALARM_LOW]	= ADT7310_T_ALARM_LOW,
> >> +	[ADT7410_T_CRIT]	= ADT7310_T_CRIT,
> >> +	[ADT7410_T_HYST]	= ADT7310_T_HYST,
> >> +	[ADT7410_ID]		= ADT7310_ID,
> >> +};
> >> +
> >> +#define ADT7310_CMD_REG_MASK			0x28
> >> +#define ADT7310_CMD_REG_OFFSET			3
> >> +#define ADT7310_CMD_READ			0x40
> >> +#define ADT7310_CMD_CON_READ			0x4
> >> +
> >> +#define AD7310_COMMAND(reg) (adt7371_reg_table[(reg)] << ADT7310_CMD_REG_OFFSET)
> >> +
> >> +static int adt7310_spi_read_word(struct device *dev,
> >> +	u8 reg, u16 *data)
> > 
> > I don't really like the approach of separating the return value from the error
> > code, if both can be returned directly. There are two reasons: First, the code
> > gets more complex, and second, the compiler tends to get confused under some
> > conditions abd believe that the return value is not set. And I really don't want
> > to have to deal with the resulting build warnings, after getting rid of pretty
> > much all such warnings in the hwmon subsystem. So I'd really appreciate if you
> > could rewrite this and the subsequent patches to return both error and value as
> > function return values.
> > 
> 
> I can change it, but I don't think that the current code will confuse the
> compiler, the return value is set under all circumstances. And the code

There still tend to be conditions (mostly hit with randconfig configurations or
with some oddball configurations) where it gets confused; at least that is what
tends to happen.

> actually gets slightly more complex by rewriting it. Most of the time we don't
> want to store the result of the read operation on stack but rather somewhere else.
> 
> 	ret = adt7410_read_word(dev, TEMP);
> 	if (ret < 0) {
> 		...
> 	}
> 	data->temp[0] = ret;
> 
> Without the change we can write it as:
> 
> 	ret = adt7410_read_word(dev, TEMP, &data->temp[0])
> 	if (ret) {
> 		...
> 	}
> 
> The difference is not that big, so I won't argue over it if you prefer the
> first version.
> 
On the other side, you can then use functions such as spi_w8r16 and spi_w8r8,
and you don't need the conversion from one method to another in the i2c code.

So, yes, I would appreciate if you can make that change.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
