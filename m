From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 17 Sep 2009 15:02:16 +0000
Subject: Re: [lm-sensors] I2C support STMicroeletronics LIS302Dx three-axis
Message-Id: <4AB24F78.6040003@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090917215312.GA6974@intel.com>
In-Reply-To: <20090917215312.GA6974@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, managed to remove the mailing list from the cc.

Sorry Kalhan, 

I missed a couple of points in last review.
Couple of unnecessary includes that it would be nice to get rid of
and some cleanups of error handling.

Why has this version lost the changes you proposed to the core driver in order
to support the subtly different rate query registers?
Are you splitting that off into a separate patch? (that is probably the right
way to go)

Fix the headers and any of the other bits are optional.
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

> From b0d6e99edb0fcccc1ce79bdd85aaa5d2a5e125ea Mon Sep 17 00:00:00 2001
> From: Kalhan Trisal <kalhan.trisal@intel.com>
> Date: Thu, 17 Sep 2009 17:37:44 -0400
> Subject: [PATCH] I2C support STMicroeletronics LIS302Dx three-axis digital accelerometer
> 
> Glue layer for  lis3lv02d/LIS[32]02DL to support I2C interface.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
> 
> ---
>  drivers/hwmon/Kconfig         |   17 ++++++
>  drivers/hwmon/Makefile        |    1 +
>  drivers/hwmon/lis3lv02d_i2c.c |  112 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/hwmon/lis3lv02d_i2c.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..cd3646e 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -992,6 +992,23 @@ config SENSORS_LIS3_SPI
>  	  will be called lis3lv02d and a specific module for the SPI transport
>  	  is called lis3lv02d_spi.
>  
> +config SENSORS_LIS3_I2C
> +	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
> +	depends on I2C && INPUT
> +	select INPUT_POLLDEV
> +	default n
> +	help
> +	  This driver provides support for the LIS3LV02Dx accelerometer connected
> +	  via I2C. The accelerometer data is readable via
> +	  /sys/devices/platform/lis3lv02d.
> +
> +	  This driver also provides an absolute input class device, allowing
> +	  the laptop to act as a pinball machine-esque joystick.
> +
> +	  This driver can also be built as modules.  If so, the core module
> +	  will be called lis3lv02d and a specific module for the I2C transport
> +	  is called lis3lv02d_i2c.
> +
>  config SENSORS_APPLESMC
>  	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
>  	depends on INPUT && X86
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b793dce..93ab518 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_SENSORS_IT87)	+= it87.o
>  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
>  obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
>  obj-$(CONFIG_SENSORS_LIS3_SPI)	+= lis3lv02d.o lis3lv02d_spi.o
> +obj-$(CONFIG_SENSORS_LIS3_I2C)	+= lis3lv02d.o lis3lv02d_i2c.o
>  obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
>  obj-$(CONFIG_SENSORS_LM70)	+= lm70.o
>  obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> new file mode 100755
> index 0000000..fdfff16
> --- /dev/null
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -0,0 +1,112 @@
> +/*
> + * lis3lv02d_i2c - I2C glue layer for LIS[32]02DL varients
> + *
> + * Copyright (c) 2009  Kalhan Trisal <kalhan.trisal@intel.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publishhed by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>


Not used.
> +#include <linux/err.h>

Not used in this file.
> +#include <linux/input.h>

No need for the next two headers (don't think you are using them).
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>

> +#include <linux/i2c.h>
> +#include "lis3lv02d.h"
> +
> +
> +static int lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
> +{
> +	int ret;
> +	ret = i2c_smbus_read_byte_data(lis3->bus_priv, reg);
Ideally you would check for an error and pass it on up, but that's only
worth while if the caller does anything with it.  Arguably that code
should but seeing as it doesn't this is a fix for another day.
However it is possible for your code to put something invalid into *v.
Not a good thing if you have no way of knowing it is incorrect.
> +
> +	*v = (u8) ret;
> +	return 0;
> +}
> +
> +static int lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 val)
> +{
> +	int ret_val;
> +
> +	ret_val = i2c_smbus_write_byte_data(lis3->bus_priv, reg, val);
> +	return ret_val;
Would be nice to convert this to the shorter
return i2c_smbus_write_byte_data(lis3->bus_priv, reg, val);

So in this case you are returning error codes so probably best to do
so for the read as well just for consistency.
> +}
> +
> +static int lis3_i2c_init(struct lis3lv02d *lis3)
> +{
> +	u8 reg;
> +	int ret;
> +
> +	/* power up the device */
> +	ret = lis3->read(lis3, CTRL_REG1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg |= CTRL1_PD0;
> +	return lis3->write(lis3, CTRL_REG1, reg);
> +}
> +
> +static struct axis_conversion lis3lv02d_axis_normal = { 1, 2, 3 };
> +
> +static int  lis302dl_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	int ret;
> +
> +	lis3_dev.bus_priv = client;
> +	lis3_dev.init = lis3_i2c_init;
> +	lis3_dev.read = lis3_i2c_read;
> +	lis3_dev.write = lis3_i2c_write;
> +	lis3_dev.irq = client->irq;
> +	lis3_dev.ac = lis3lv02d_axis_normal;
> +	lis3_dev.pdata = client->dev.platform_data;
> +	i2c_set_clientdata(client, &lis3_dev);
> +	ret = lis3lv02d_init_device(&lis3_dev);
> +	return ret;
Might as well loose the uncessary int ret and just
return lis3lv02d_init_device(&lis3_dev);
> +}
> +
> +static int lis302dl_remove(struct i2c_client *client)
> +{
> +	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
> +	lis3lv02d_joystick_disable();
> +	lis3lv02d_poweroff(lis3);
> +	return 0;
> +}
> +
> +static struct i2c_device_id lis302dl_id[] = {
> +	{ "lis302dl", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, lis302dl_id);
> +
> +static struct i2c_driver lis302dl_driver = {
> +	.driver = {
> +	.name = "lis302dl_i2c",
> +	},
> +	.probe = lis302dl_probe,
> +	.remove = lis302dl_remove,
> +	.id_table = lis302dl_id,
> +};
> +
> +static int __init sensor_lis302dl_init(void)
> +{
> +	return  i2c_add_driver(&lis302dl_driver);
> +}
> +
> +static void  __exit sensor_lis302dl_exit(void)
> +{
> +	i2c_del_driver(&lis302dl_driver);
> +}
> +
> +module_init(sensor_lis302dl_init);
> +module_exit(sensor_lis302dl_exit);
> +
> +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com>");
> +MODULE_DESCRIPTION("LIS[32]02DL I2C glue layer");
> +MODULE_LICENSE("GPL");
> +



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
