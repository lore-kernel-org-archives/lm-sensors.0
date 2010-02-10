From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 10 Feb 2010 14:58:02 +0000
Subject: Re: [lm-sensors] [PATCH] ads787x A/D driver for hwmon
Message-Id: <4B72C97A.7090304@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265759943-19863-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1265759943-19863-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

Firstly, before someone else brings it up.  This is a pretty high performance
chip.  Obviously it could be used for low speed hardware monitoring type
applications (and if you are fair enough!). Otherwise it might sense to move
this over to IIO as and when it is appropriate. 

Ignoring that, here goes for a quick review off datasheet.  Note that most of the
stuff below is nitpicking and things you would probably have cleaned up before
a final submission anyway. Looks pretty good and clean on the whole. Lots more
features that this device supports, but others can add them whenever they need them
and for hwmon uses you probably never do.
> ---
>  drivers/hwmon/Kconfig   |    9 ++
>  drivers/hwmon/Makefile  |    1 +
>  drivers/hwmon/ads787x.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/ads787x.h |   51 ++++++++++++
>  4 files changed, 260 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/ads787x.c
>  create mode 100644 drivers/hwmon/ads787x.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68cf877..4f49ed2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -169,6 +169,15 @@ config SENSORS_ADM9240
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm9240.
> +	  
> +config SENSORS_ADS787x
> +	tristate "TI ADS787x A/D converter"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for TI ADS7871, ....
Please list part numbers that it should work explicitly.  Otherwise
TI will go and release and ads7877 which is something completely different
and someone will then wonder why this doesn't work!
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ads7871.	  
>  
> 
....

> +++ b/drivers/hwmon/ads787x.c
> @@ -0,0 +1,199 @@
> +/*
> + *  ads787x - driver for TI ADS7871 A/D converter
> + *
> + *  Copyright (c) 2010 Paul Thomas <pthomas8589@gmail.com>
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or 
> + *  later as publishhed by the Free Software Foundation.
> + *
> + *	You need to have something like this in struct spi_board_info
> + *	{
> + *		.modalias	= "ads787x",
> + *		.max_speed_hz	= 2*1000*1000,
> + *		.chip_select	= 0,
> + *		.bus_num	= 1,
> + *	},
> + */
> +
> +#define DEBUG 1
Obviously get this sort of statement cleaned up before a final submission.
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/spi/spi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +
> +#include "ads787x.h"
> +
> +#define DEVICE_NAME 	"ads787x"
> +
> +struct ads787x_data {
> +	struct device	*hwmon_dev;
> +	struct mutex	update_lock;
> +};
> +
> +static int mcp251x_read_reg8(struct spi_device *spi, int reg)
> +{
> +	int ret;

Given all reg writes are from within this driver, is it not safe to assume
you didn't specify and spurious bits beyond the 5 allowed for the register
address? Hence I think the & 0x1f is no needed.
> +	reg = (reg & 0x1f) | INST_READ_bm;
> +	ret = spi_w8r8(spi, reg);
> +	if (ret < 0)
> +		return -EINVAL;
Please return the error value that spi_w8r8 returs rather than changing it.

> +
> +	return ret;
> +}
> +
> +static int mcp251x_write_reg8(struct spi_device *spi, int reg, u8 val)
> +{
> +	u8 tmp[2];

Again, should be able to rely on reg being a valid address. In which case we
can go for direct assignment of the array.

u8 tmp[2] = { reg, val };
> +	reg &= (reg & 0x1f);
> +	tmp[0] = reg;
> +	tmp[1] = val;
> +	return spi_write(spi, tmp, sizeof(tmp));
> +}
> +
> +static ssize_t show_voltage(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	int ret, val, i=0;
> +	uint8_t lb, hb, channel, mux_cnv;
> +	
> +	channel = attr->index;
> +	dev_dbg(&spi->dev, "setup REG_GAIN_MUX: channel = %d, ", channel);
> +	mcp251x_write_reg8(spi, REG_GAIN_MUX, 
> +		(MUX_CNV_bm | MUX_M3_bm | channel));
This currently scrubs any preset PGA gain.  Which is fine for an initial driver
but perhaps a comment can make this clear for anyone wanting to add support for
the PGA in future?

> +	
> +	ret = mcp251x_read_reg8(spi, REG_GAIN_MUX);
> +	mux_cnv = ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
> +	while(i<10 && mux_cnv)
> +	{
> +		i++;
> +		ret = mcp251x_read_reg8(spi, REG_GAIN_MUX);
> +		mux_cnv = ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
> +		/*TODO: if a platform could do the SPI stuff fast enough
> +		you could read before the conversion is complete
> +		a delay or sleep could be added here*/
Indeed nasty.  At the very least you want to return an error rather
that as you do below, -1. You could indeed sleep in here.  Another option which is obviously
wiring dependent would be to use the busy pin to drive a suitable interrupt
and then wait on a signal from that here.
> +	}
> +	dev_dbg(&spi->dev, "ret = %x, mux_cnv = %d\n\n", ret, mux_cnv);
> +	
> +	if(mux_cnv = 0)
> +	{
> +		lb = (mcp251x_read_reg8(spi, REG_LS_BYTE)>>2);
> +		hb = mcp251x_read_reg8(spi, REG_MS_BYTE);
> +		val = (hb<<6 | lb) & 0x1fff;
> +		
> +		return sprintf(buf, "%d\n", val);
> +	}
> +	else return sprintf(buf, "%d\n", -1);
> +}
> +
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_voltage, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_voltage, NULL, 4);
> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_voltage, NULL, 5);
> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);
> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);
> +
> +static struct attribute *ads787x_attributes[] = {
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ads787x_group = {
> +	.attrs = ads787x_attributes,
> +};
> +
> +static int __devinit ads787x_probe(struct spi_device *spi)
> +{
> +	int status, ret;
> +	struct ads787x_data *pdata;
> +
> +	dev_dbg(&spi->dev, "ads787x_probe\n");
> +	
> +	pdata = kzalloc(sizeof(struct ads787x_data), GFP_KERNEL);
> +	
> +	status = sysfs_create_group(&spi->dev.kobj, &ads787x_group);
> +	dev_dbg(&spi->dev, "status(sysfs_create_group) = %d\n", status);
> +	
> +	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
> +	spi_set_drvdata(spi, pdata);
> +

Style fix needed here.  (though again as you say the driver hasn't been cleaned
up yet!)	
> +	if (IS_ERR(pdata->hwmon_dev)) 
> +	{
> +		dev_dbg(&spi->dev, "hwmon_device_register: IS_ERR\n");
> +	}
> +	
> +	/* Configure the SPI bus */
> +	spi->mode = (SPI_MODE_0);
> +	spi->bits_per_word = 8;
> +	spi_setup(spi);
> +	
> +  	mcp251x_write_reg8(spi, REG_SER_CONTROL, 0);
> +	ret = mcp251x_read_reg8(spi, REG_SER_CONTROL);
Why?
> +	
> +	mcp251x_write_reg8(spi, REG_OSC_CONTROL, 
> +		(OSC_OSCR_bm | OSC_OSCE_bm | OSC_REFE_bm | OSC_BUFE_bm));
> +	ret = mcp251x_read_reg8(spi, REG_OSC_CONTROL);
I'm guessing this and the above are debug checks? 
> +	
> +	mcp251x_write_reg8(spi, REG_AD_CONTROL, 0);
> +	ret = mcp251x_read_reg8(spi, REG_AD_CONTROL);
> +
> +	return 0;
> +}
> +
> +static int __devexit ads787x_remove(struct spi_device *spi)
> +{
> +	struct ads787x_data *pdata = spi_get_drvdata(spi);
> +
> +	dev_dbg(&spi->dev, "ads787x_remove\n\n\n");
> +	hwmon_device_unregister(pdata->hwmon_dev);
> +	sysfs_remove_group(&spi->dev.kobj, &ads787x_group);
> +	return 0;
> +}
> +
> +static struct spi_driver ads787x_driver = {
> +	.driver = {
> +		.name = DEVICE_NAME,
> +		.bus = &spi_bus_type,
> +		.owner = THIS_MODULE,
> +	},
> +
> +	.probe = ads787x_probe,
> +	.remove = __devexit_p(ads787x_remove),
> +};
> +
> +static int __init ads787x_init(void)
> +{
> +	return spi_register_driver(&ads787x_driver);
> +}
> +
> +static void __exit ads787x_exit(void)
> +{
> +	spi_unregister_driver(&ads787x_driver);
> +}
> +
> +module_init(ads787x_init);
> +module_exit(ads787x_exit);
> +
> +MODULE_AUTHOR("Paul Thomas <pthomas8589@gmail.com>");
> +MODULE_DESCRIPTION("TI ADS787x A/D driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/ads787x.h b/drivers/hwmon/ads787x.h
> new file mode 100644
> index 0000000..56737a3
> --- /dev/null
> +++ b/drivers/hwmon/ads787x.h
> @@ -0,0 +1,51 @@
> +/*
> + *  ads787x - driver for TI ADS7871 A/D converter
> + *
> + *  Copyright (c) 2010 Paul Thomas <pthomas8589@gmail.com>
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or 
> + *  later as publishhed by the Free Software Foundation.
> + */
> +
> +/*From figure 18 in the datasheet*/
> +/*Register addresses*/
> +#define REG_LS_BYTE	0 /*A/D Output Data, LS Byte*/
> +#define REG_MS_BYTE	1 /*A/D Output Data, MS Byte*/
> +#define REG_PGA_VALID	2 /*PGA Valid Register*/
> +#define REG_AD_CONTROL	3 /*A/D Control Register*/
> +#define REG_GAIN_MUX	4 /*Gain/Mux Register*/
> +#define REG_IO_STATE	5 /*Digital I/O State Register*/
> +#define REG_IO_CONTROL	6 /*Digital I/O Control Register*/
> +#define REG_OSC_CONTROL	7 /*Rev/Oscillator Control Register*/
> +#define REG_SER_CONTROL 24 /*Serial Interface Control Register*/
> +#define REG_ID		31 /*ID Register*/
> +
> +/*From figure 17 in the datasheet
> +* These bits get ORed with the address to form
> +* the instruction byte */
> +/*Instruction Bit masks*/
> +#define INST_MODE_bm	(1<<7)
> +#define INST_READ_bm	(1<<6)
> +#define INST_16BIT_bm	(1<<5)
> +
> +/*From figure 18 in the datasheet*/
> +/*bit masks for Rev/Oscillator Control Register*/
> +#define MUX_CNV_bv	7
> +#define MUX_CNV_bm	(1<<MUX_CNV_bv)
> +#define MUX_M3_bm	(1<<3) /*M3 selects single ended*/
> +#define MUX_G_bv	4 /*allows for reg = (gain << MUX_G_bv) | ...*/
> +
> +/*From figure 18 in the datasheet*/
> +/*bit masks for Rev/Oscillator Control Register*/
> +#define OSC_OSCR_bm	(1<<5)
> +#define OSC_OSCE_bm	(1<<4)
> +#define OSC_REFE_bm	(1<<3)
> +#define OSC_BUFE_bm	(1<<2)
> +#define OSC_R2V_bm	(1<<1)
> +#define OSC_RBG_bm	(1<<0)
> \ No newline at end of file
Fix that before submission. :)

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
