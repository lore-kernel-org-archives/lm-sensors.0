From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 16 Sep 2009 14:37:45 +0000
Subject: Re: [lm-sensors] Accelerometer driver for
Message-Id: <4AB0F839.6040203@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <f34ca13c0908170720l6a7a1311m6592846f30056822@mail.gmail.com>
In-Reply-To: <f34ca13c0908170720l6a7a1311m6592846f30056822@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kalhan,

Mostly looks good, couple of nitpicks below.
I'd also suggest starting a new thread as this is a very different patch
from the one that started this thread.

Jonathan
> I2C support for lis302dl.
> 
>>From aba997f79290a58dd7a564bf9f931dffb43ec292 Mon Sep 17 00:00:00 2001
> From: Kalhan Trisal <kalhan.trisal@intel.com>
> Date: Wed, 16 Sep 2009 17:53:59 -0400
> Subject: [PATCH] I2C glue layer for lis3lv02d STMicroelectronics digital accelerometer
> This patch will support I2C interface for ST Microelectronics 3 axis digital accelerometer. Few register fields have changed due to which I have added device id to differentiate between LIS3LV02Dx and LIS[32]02DL.


Firstly please format patches more carefully.  Description typically sub 70 something
character lines and remove the previous email from below the patch.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
> ---
>  drivers/hwmon/Kconfig         |   17 ++++++
>  drivers/hwmon/Makefile        |    1 +
>  drivers/hwmon/lis3lv02d.c     |   13 ++++-
>  drivers/hwmon/lis3lv02d.h     |    9 +++-
>  drivers/hwmon/lis3lv02d_i2c.c |  115 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 151 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/hwmon/lis3lv02d_i2c.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..2a4eba1 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -992,6 +992,23 @@ config SENSORS_LIS3_SPI
>           will be called lis3lv02d and a specific module for the SPI transport
>           is called lis3lv02d_spi.
> 
> +config SENSORS_LIS3_I2C
> +       tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
> +       depends on I2C
> +       select INPUT_POLLDEV
> +       default n
> +       help
> +         This driver provides support for the LIS3LV02Dx accelerometer connected
> +         via I2C. The accelerometer data is readable via
> +         /sys/devices/platform/lis3lv02d.
What are peoples feelings on this?  Personally I'd prefer devices to register
as what they are when we can identify them rather than a generic name.
> +
> +         This driver also provides an absolute input class device, allowing
> +         the laptop to act as a pinball machine-esque joystick.
> +
> +         This driver can also be built as modules.  If so, the core module
> +         will be called lis3lv02d and a specific module for the I2C transport
> +         is called lis3lv02d_i2c.
> +
>  config SENSORS_APPLESMC
>         tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
>         depends on INPUT && X86
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b793dce..93ab518 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_SENSORS_IT87)    += it87.o
>  obj-$(CONFIG_SENSORS_K8TEMP)   += k8temp.o
>  obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
>  obj-$(CONFIG_SENSORS_LIS3_SPI) += lis3lv02d.o lis3lv02d_spi.o
> +obj-$(CONFIG_SENSORS_LIS3_I2C) += lis3lv02d.o lis3lv02d_i2c.o
>  obj-$(CONFIG_SENSORS_LM63)     += lm63.o
>  obj-$(CONFIG_SENSORS_LM70)     += lm70.o
>  obj-$(CONFIG_SENSORS_LM75)     += lm75.o
> diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> index 271338b..39562a3 100644
> --- a/drivers/hwmon/lis3lv02d.c
> +++ b/drivers/hwmon/lis3lv02d.c
> @@ -361,15 +361,22 @@ static ssize_t lis3lv02d_calibrate_store(struct device *dev,
>  }
> 
>  /* conversion btw sampling rate and the register values */
> -static int lis3lv02dl_df_val[4] = {40, 160, 640, 2560};
> +static int lis3lv02dl_df_val[6] = {40, 100, 160, 400, 640, 2560};
>  static ssize_t lis3lv02d_rate_show(struct device *dev,
>                         struct device_attribute *attr, char *buf)
>  {
>         u8 ctrl;
> -       int val;
> +       int val = 0;
> 
>         lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
> -       val = (ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4;
> +       if (lis3_dev.device_id = LIS302D_DEV) {
> +               if (ctrl & CTRL1_PD1)
Hang on, why do you appear to be querying a power down address
to get the rate?  I haven't looked at data sheet, but guessing 
this is because you just wanted the right mask.  If so add
a definition for your chip, say LIS302D_CTRL1_DR and use
that instead.

> +                       val = 3;
> +               else
> +                       val = 1;
> +       } else if (lis3_dev.device_id = LIS3LV02D_DEV)
> +               val = (ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4;
> +
>         return sprintf(buf, "%d\n", lis3lv02dl_df_val[val]);
>  }
> 
> diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
> index e320e2f..d21a7c8 100644
> --- a/drivers/hwmon/lis3lv02d.h
> +++ b/drivers/hwmon/lis3lv02d.h
> @@ -20,6 +20,7 @@
>   */
>  #include <linux/platform_device.h>
>  #include <linux/input-polldev.h>
> +#include <linux/i2c.h>
Worth having this inside some #defines?
Same for the additions to the struct lis3lv02d later, no point in
adding to kernel bloat if people don't want i2c support.
> 
>  /*
>   * The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ that seems to
> @@ -170,6 +171,11 @@ enum lis3lv02d_dd_src {
>         DD_SRC_IA       = 0x40,
>  };
> 
> +enum lis_dev_support {
> +       LIS3LV02D_DEV   = 0x01,
> +       LIS302D_DEV     = 0x02,
> +};
> +
>  struct axis_conversion {
>         s8      x;
>         s8      y;
> @@ -181,8 +187,9 @@ struct lis3lv02d {
>         int (*init) (struct lis3lv02d *lis3);
>         int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
>         int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
> -
worth using the existing bus_priv pointer for this rather than introducing
new element?
> +       struct i2c_client  *lisi2c_client; /* support I2C interface*/
>         u8                      whoami;    /* 3Ah: 2-byte registries, 3Bh: 1-byte registries */
> +       u8                      device_id;    /* devide_id fo chip */
 of or for?
>         s16 (*read_data) (struct lis3lv02d *lis3, int reg);
>         int                     mdps_max_val;
> 
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> new file mode 100644
> index 0000000..c75e554
> --- /dev/null
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -0,0 +1,115 @@
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
> +#include <linux/err.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include "lis3lv02d.h"
> +
> +
> +static int lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
> +{
> +       int ret;
> +       ret = i2c_smbus_read_byte_data(lis3->lisi2c_client, reg);
> +
> +       *v = (u8) ret;
> +       return 0;
> +}
> +
> +static int lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 val)
> +{
> +       int ret_val;
> +
> +       ret_val = i2c_smbus_write_byte_data(lis3->lisi2c_client, reg, val);
> +       return ret_val;
> +}
> +
> +static int lis3_i2c_init(struct lis3lv02d *lis3)
> +{
> +       u8 reg;
> +       int ret;
> +
> +       /* power up the device */
> +       ret = lis3->read(lis3, CTRL_REG1, &reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       reg |= CTRL1_PD0;
> +       return lis3->write(lis3, CTRL_REG1, reg);
> +}
> +
> +static struct axis_conversion lis3lv02d_axis_normal = { 1, 2, 3 };
> +
> +static int  lis302dl_probe(struct i2c_client *client,
> +                               const struct i2c_device_id *id)
> +{
> +       int ret;
> +
As above suggestion, stick the client structure in bus_priv.
> +       lis3_dev.lisi2c_client = client;
> +       lis3_dev.init = lis3_i2c_init;
> +       lis3_dev.read = lis3_i2c_read;
> +       lis3_dev.write = lis3_i2c_write;
> +       lis3_dev.irq = client->irq;
> +       lis3_dev.ac = lis3lv02d_axis_normal;
> +       lis3_dev.pdata = client->dev.platform_data;
> +       lis3_dev.device_id = LIS302D_DEV;
Not happy with this.  You are currently forcing all i2c devices
to be the one you have and all spi to be the other.  Both support
both bus types.  Easiest option here is to use the id table
to correctly register what you actually have. Or add a detect
feature.  I think these have different values in the WHO_AM_I
register, so you ought to be able to identify them.

> +       i2c_set_clientdata(client, &lis3_dev);
> +       ret = lis3lv02d_init_device(&lis3_dev);
> +       return ret;
combine last 2 lines.
> +}
> +
> +static int lis302dl_remove(struct i2c_client *client)
> +{
> +       struct lis3lv02d *lis3 = i2c_get_clientdata(client);
> +       lis3lv02d_joystick_disable();
> +       lis3lv02d_poweroff(lis3);
> +       return 0;
> +}
Any reason to restrict it to this device?  Far as I can tell
should work with anything the spi driver supports as well.
> +static struct i2c_device_id lis302dl_id[] = {
> +       { "lis302dl", 0 },
> +       { }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, lis302dl_id);
> +
> +static struct i2c_driver lis302dl_driver = {
> +       .driver = {
> +       .name = "lis302dl_i2c",
> +},
Formatting issue.  Run checkpatch over this before repost.
> +       .probe = lis302dl_probe,
> +       .remove = lis302dl_remove,
> +       .id_table = lis302dl_id,
> +};
> +
> +static int __init sensor_lis302dl_init(void)
> +{
> +       int res;
> +
> +       res = i2c_add_driver(&lis302dl_driver);
> +       return res;
combine this into 
return i2c_add_driver(&lis302dl_driver);
> +}
> +
> +static void  __exit sensor_lis302dl_exit(void)
> +{
> +i2c_del_driver(&lis302dl_driver);
Formatting issue. (missing tab?) Might just be email client
fun and games
> +}
> +
> +module_init(sensor_lis302dl_init);
> +module_exit(sensor_lis302dl_exit);
> +
> +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com>");
> +MODULE_DESCRIPTION("LIS[32]02DL I2C glue layer");
> +MODULE_LICENSE("GPL");
> +
> --
> 1.6.0.6
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
