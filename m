From: "Trisal, Kalhan" <kalhan.trisal@intel.com>
Date: Wed, 16 Sep 2009 11:33:42 +0000
Subject: Re: [lm-sensors] Accelerometer driver for
Message-Id: <3CA6C6D9F70D314CA34352990B57DA1537CB1C82@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f34ca13c0908170720l6a7a1311m6592846f30056822@mail.gmail.com>
In-Reply-To: <f34ca13c0908170720l6a7a1311m6592846f30056822@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I2C support for lis302dl.

From aba997f79290a58dd7a564bf9f931dffb43ec292 Mon Sep 17 00:00:00 2001
From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Wed, 16 Sep 2009 17:53:59 -0400
Subject: [PATCH] I2C glue layer for lis3lv02d STMicroelectronics digital accelerometer
This patch will support I2C interface for ST Microelectronics 3 axis digital accelerometer. Few register fields have changed due to which I have added device id to differentiate between LIS3LV02Dx and LIS[32]02DL.

Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
---
 drivers/hwmon/Kconfig         |   17 ++++++
 drivers/hwmon/Makefile        |    1 +
 drivers/hwmon/lis3lv02d.c     |   13 ++++-
 drivers/hwmon/lis3lv02d.h     |    9 +++-
 drivers/hwmon/lis3lv02d_i2c.c |  115 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hwmon/lis3lv02d_i2c.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..2a4eba1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -992,6 +992,23 @@ config SENSORS_LIS3_SPI
          will be called lis3lv02d and a specific module for the SPI transport
          is called lis3lv02d_spi.

+config SENSORS_LIS3_I2C
+       tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
+       depends on I2C
+       select INPUT_POLLDEV
+       default n
+       help
+         This driver provides support for the LIS3LV02Dx accelerometer connected
+         via I2C. The accelerometer data is readable via
+         /sys/devices/platform/lis3lv02d.
+
+         This driver also provides an absolute input class device, allowing
+         the laptop to act as a pinball machine-esque joystick.
+
+         This driver can also be built as modules.  If so, the core module
+         will be called lis3lv02d and a specific module for the I2C transport
+         is called lis3lv02d_i2c.
+
 config SENSORS_APPLESMC
        tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
        depends on INPUT && X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b793dce..93ab518 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_SENSORS_IT87)    += it87.o
 obj-$(CONFIG_SENSORS_K8TEMP)   += k8temp.o
 obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
 obj-$(CONFIG_SENSORS_LIS3_SPI) += lis3lv02d.o lis3lv02d_spi.o
+obj-$(CONFIG_SENSORS_LIS3_I2C) += lis3lv02d.o lis3lv02d_i2c.o
 obj-$(CONFIG_SENSORS_LM63)     += lm63.o
 obj-$(CONFIG_SENSORS_LM70)     += lm70.o
 obj-$(CONFIG_SENSORS_LM75)     += lm75.o
diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 271338b..39562a3 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -361,15 +361,22 @@ static ssize_t lis3lv02d_calibrate_store(struct device *dev,
 }

 /* conversion btw sampling rate and the register values */
-static int lis3lv02dl_df_val[4] = {40, 160, 640, 2560};
+static int lis3lv02dl_df_val[6] = {40, 100, 160, 400, 640, 2560};
 static ssize_t lis3lv02d_rate_show(struct device *dev,
                        struct device_attribute *attr, char *buf)
 {
        u8 ctrl;
-       int val;
+       int val = 0;

        lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
-       val = (ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4;
+       if (lis3_dev.device_id = LIS302D_DEV) {
+               if (ctrl & CTRL1_PD1)
+                       val = 3;
+               else
+                       val = 1;
+       } else if (lis3_dev.device_id = LIS3LV02D_DEV)
+               val = (ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4;
+
        return sprintf(buf, "%d\n", lis3lv02dl_df_val[val]);
 }

diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index e320e2f..d21a7c8 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -20,6 +20,7 @@
  */
 #include <linux/platform_device.h>
 #include <linux/input-polldev.h>
+#include <linux/i2c.h>

 /*
  * The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ that seems to
@@ -170,6 +171,11 @@ enum lis3lv02d_dd_src {
        DD_SRC_IA       = 0x40,
 };

+enum lis_dev_support {
+       LIS3LV02D_DEV   = 0x01,
+       LIS302D_DEV     = 0x02,
+};
+
 struct axis_conversion {
        s8      x;
        s8      y;
@@ -181,8 +187,9 @@ struct lis3lv02d {
        int (*init) (struct lis3lv02d *lis3);
        int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
        int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
-
+       struct i2c_client  *lisi2c_client; /* support I2C interface*/
        u8                      whoami;    /* 3Ah: 2-byte registries, 3Bh: 1-byte registries */
+       u8                      device_id;    /* devide_id fo chip */
        s16 (*read_data) (struct lis3lv02d *lis3, int reg);
        int                     mdps_max_val;

diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
new file mode 100644
index 0000000..c75e554
--- /dev/null
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -0,0 +1,115 @@
+/*
+ * lis3lv02d_i2c - I2C glue layer for LIS[32]02DL varients
+ *
+ * Copyright (c) 2009  Kalhan Trisal <kalhan.trisal@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include "lis3lv02d.h"
+
+
+static int lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
+{
+       int ret;
+       ret = i2c_smbus_read_byte_data(lis3->lisi2c_client, reg);
+
+       *v = (u8) ret;
+       return 0;
+}
+
+static int lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 val)
+{
+       int ret_val;
+
+       ret_val = i2c_smbus_write_byte_data(lis3->lisi2c_client, reg, val);
+       return ret_val;
+}
+
+static int lis3_i2c_init(struct lis3lv02d *lis3)
+{
+       u8 reg;
+       int ret;
+
+       /* power up the device */
+       ret = lis3->read(lis3, CTRL_REG1, &reg);
+       if (ret < 0)
+               return ret;
+
+       reg |= CTRL1_PD0;
+       return lis3->write(lis3, CTRL_REG1, reg);
+}
+
+static struct axis_conversion lis3lv02d_axis_normal = { 1, 2, 3 };
+
+static int  lis302dl_probe(struct i2c_client *client,
+                               const struct i2c_device_id *id)
+{
+       int ret;
+
+       lis3_dev.lisi2c_client = client;
+       lis3_dev.init = lis3_i2c_init;
+       lis3_dev.read = lis3_i2c_read;
+       lis3_dev.write = lis3_i2c_write;
+       lis3_dev.irq = client->irq;
+       lis3_dev.ac = lis3lv02d_axis_normal;
+       lis3_dev.pdata = client->dev.platform_data;
+       lis3_dev.device_id = LIS302D_DEV;
+       i2c_set_clientdata(client, &lis3_dev);
+       ret = lis3lv02d_init_device(&lis3_dev);
+       return ret;
+}
+
+static int lis302dl_remove(struct i2c_client *client)
+{
+       struct lis3lv02d *lis3 = i2c_get_clientdata(client);
+       lis3lv02d_joystick_disable();
+       lis3lv02d_poweroff(lis3);
+       return 0;
+}
+
+static struct i2c_device_id lis302dl_id[] = {
+       { "lis302dl", 0 },
+       { }
+};
+
+MODULE_DEVICE_TABLE(i2c, lis302dl_id);
+
+static struct i2c_driver lis302dl_driver = {
+       .driver = {
+       .name = "lis302dl_i2c",
+},
+       .probe = lis302dl_probe,
+       .remove = lis302dl_remove,
+       .id_table = lis302dl_id,
+};
+
+static int __init sensor_lis302dl_init(void)
+{
+       int res;
+
+       res = i2c_add_driver(&lis302dl_driver);
+       return res;
+}
+
+static void  __exit sensor_lis302dl_exit(void)
+{
+i2c_del_driver(&lis302dl_driver);
+}
+
+module_init(sensor_lis302dl_init);
+module_exit(sensor_lis302dl_exit);
+
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com>");
+MODULE_DESCRIPTION("LIS[32]02DL I2C glue layer");
+MODULE_LICENSE("GPL");
+
--
1.6.0.6


-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
Sent: Tuesday, August 18, 2009 6:45 PM
To: Constantine A. Murenin
Cc: Trisal, Kalhan; alan@linux.intel.com; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Accelerometer driver for STMicroeletronics-LIS331DL-three-axis-digital

Constantine A. Murenin wrote:
> Hi,
>
> Isn't this accelerometer already supported by hwmon/lis3lv02d.c?  From
> the datasheets, I don't see any register differences between lis331dl
> and lis302dl.

Good spot. I hadn't realized the support was in there for the single
byte devices.  On that note, to my mind at least this needs to be
added to the Kconfig option at the very least. The only place it is
readily apparent at the moment is in the header and that is in a form
that won't allow for grepping etc.  Personally I'd favour the driver
actually exporting all the devices it supports rather than just one of
them.  This might be best done once the device table patch for spi has
gone in. For those of us using board files to register devices it is
always nice to be able to put the right device name in rather than
something we have to figure out is compatible.

Most other hwmon modules do this exporting of multiple names
(e.g. lm75). For now doing it for spi is a little messy as you have
register multiple drivers explicitly. Soon the equivalent of
the i2c method should be in place for spi.

Kalhan would need to implement i2c access but that should be straight
forward.

> Cheers,
> Constantine.
>
> 2009/8/17 Jonathan Cameron <jic23@cam.ac.uk>:
>> Hi Kalhan,
>>
>> Nice clean driver.
>>
>> Few minor bits I missed before... Other than cleaning up the Kconfig
>> description, up to you whether you bother with the others.
>>
>> Note, unless general opinions have changed, this won't get merged in hwmon.
>>
>>> >From f63c311f0106f6fbcced05b168cf60f996621e47 Mon Sep 17 00:00:00 2001
>>> From: Kalhan Trisal <kalhan.trisal@intel.com>
>>> Date: Fri, 14 Aug 2009 20:44:56 -0400
>> Curious abrievation of accelerometer, probably just use accel.
>>> Subject: [PATCH] STMicroeletronics-LIS331DL-three-axis-digital-accelrometer
>>>
>>> submitting the patch with comments incorporated.
>>> This driver provides support for the LIS3331DL accelerometer
>>> accelerometer, connected to I2C. The accelerometer data is readable via
>>> sys/class/hwmon.
>>>
>>> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
>>>
>>>
>>> ---
>>>  drivers/hwmon/Kconfig    |    8 ++
>>>  drivers/hwmon/Makefile   |    1 +
>>>  drivers/hwmon/lis331dl.c |  250 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 259 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/hwmon/lis331dl.c
>>>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index 2d50166..394a591 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -1017,6 +1017,14 @@ config SENSORS_APPLESMC
>>>         Say Y here if you have an applicable laptop and want to experience
>>>         the awesome power of applesmc.
>>>
>>> +config SENSORS_LIS331DL
>>> +     tristate "STMicroeletronics LIS331DL three-axis digital accelerometer"
>>> +     depends on I2C
>>> +     help
>>> +       If you say yes here you get support for the Accelerometer  Devices
>> Please rewrite this description. We are dealing with specific accelerometer only.
>>> +       Device can be configured using sysfs.
>>> +       x y Z data can be   accessible via sysfs.
>>> +
>>>  config HWMON_DEBUG_CHIP
>>>       bool "Hardware Monitoring Chip debugging messages"
>>>       default n
>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>> index b793dce..3b1e424 100644
>>> --- a/drivers/hwmon/Makefile
>>> +++ b/drivers/hwmon/Makefile
>>> @@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231)        += vt8231.o
>>>  obj-$(CONFIG_SENSORS_W83627EHF)      += w83627ehf.o
>>>  obj-$(CONFIG_SENSORS_W83L785TS)      += w83l785ts.o
>>>  obj-$(CONFIG_SENSORS_W83L786NG)      += w83l786ng.o
>>> +obj-$(CONFIG_SENSORS_LIS331DL)       += lis331dl.o
>>>
>>>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>>>  EXTRA_CFLAGS += -DDEBUG
>>> diff --git a/drivers/hwmon/lis331dl.c b/drivers/hwmon/lis331dl.c
>>> new file mode 100644
>>> index 0000000..c8d6b84
>>> --- /dev/null
>>> +++ b/drivers/hwmon/lis331dl.c
>>> @@ -0,0 +1,250 @@
>>> +/*
>>> + * lis331dl.c - ST LIS331DL  Accelerometer Driver
>>> + *
>>> + * Copyright (C) 2009 Intel Corp
>>> + *
>>> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; version 2 of the License.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License along
>>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>>> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> + *
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/hwmon-sysfs.h>
>>> +#include <linux/hwmon-vid.h>
>>> +#include <linux/err.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/sysfs.h>
>>> +
>>> +
>>> +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
>>> +MODULE_DESCRIPTION("STMacroelectronics LIS331DL Accelerometer Driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +
>>> +#define ACCEL_DATA_RATE_100HZ 0
>>> +#define ACCEL_DATA_RATE_400HZ 1
>>> +#define ACCEL_POWER_MODE_DOWN 0
>>> +#define ACCEL_POWER_MODE_ACTIVE 1
>>> +
>>> +/* internal return values */
>>> +
>>> +struct lis331dl_data {
>>> +     struct device *hwmon_dev;
>>> +     struct mutex update_lock;
>>> +};
>> Might be better to actually output this in Hz, so either 100 or 200
>> rather than 0 or 1. Same is true when setting it.  Can always add
>> another sysfs file as available_rates which lists the posibilities.
>>> +static ssize_t rate_show(struct device *dev,
>>> +                     struct device_attribute *attr, char *buf)
>>> +{
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +     int ret_val, val;
>>> +
>>> +     val = i2c_smbus_read_byte_data(client, 0x20);
>>> +     ret_val = (val & 0x80); /* 1= 400HZ 0= 100HZ */
>>> +     if (ret_val = 0x80)
>>> +             ret_val = ACCEL_DATA_RATE_400HZ;
>>> +     return sprintf(buf, "%d\n", ret_val);
>>> +
>>> +}
>>> +
>>> +static ssize_t state_show(struct device *dev,
>>> +                     struct device_attribute *attr, char *buf)
>>> +{
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +     int ret_val, val;
>>> +
>>> +     val = i2c_smbus_read_byte_data(client, 0x20);
>>> +     ret_val = (val & 0x40);
>>> +     if (ret_val = 0x40)
>>> +             ret_val = ACCEL_POWER_MODE_ACTIVE;
>>> +     return sprintf(buf, "%d\n", ret_val);
>>> +}
>>> +
>>> +/* if adapter support multiple read better to use that device support that */
>>> +static ssize_t xyz_pos_show(struct device *dev,
>>> +                             struct device_attribute *attr, char *buf)
>>> +{
>>> +     int x, y, z;
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +
>>> +     x = i2c_smbus_read_byte_data(client, 0x29);
>>> +     y = i2c_smbus_read_byte_data(client, 0x2B);
>>> +     z = i2c_smbus_read_byte_data(client, 0x2D);
>>> +     return sprintf(buf, "%d, %d, %d \n", x, y, z);
>>> +}
>>> +
>>> +static ssize_t rate_store(struct device *dev,
>>> +             struct device_attribute *attr, const char *buf, size_t count)
>>> +{
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +     struct lis331dl_data *data = i2c_get_clientdata(client);
>>> +     unsigned int ret_val, set_val;
>>> +     unsigned long val;
>>> +
>>> +     if (strict_strtoul(buf, 10, &val))
>>> +             return -EINVAL;
>>> +     ret_val = i2c_smbus_read_byte_data(client, 0x20);
>>> +
>>> +     mutex_lock(&data->update_lock);
>>> +     if (val = ACCEL_DATA_RATE_100HZ)
>> Could go with (ret_val & ~0x80) which makes the comment unecessary.
>> Fine either way though. (or even (ret_val & ~(1 << 7)) for consistency).
>>> +             set_val = (ret_val & 0x7F); /* setting the 8th bit to 0 */
>>> +     else if (val = ACCEL_DATA_RATE_400HZ)
>>> +             set_val = (ret_val | (1 << 7));
>>> +     else
>>> +             goto invarg;
>>> +
>>> +     i2c_smbus_write_byte_data(client, 0x20, set_val);
>>> +     mutex_unlock(&data->update_lock);
>>> +     return count;
>>> +invarg:
>>> +     mutex_unlock(&data->update_lock);
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static ssize_t state_store(struct device *dev,
>>> +             struct device_attribute *attr, const  char *buf, size_t count)
>>> +{
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +     struct lis331dl_data *data = i2c_get_clientdata(client);
>>> +     unsigned int ret_val, set_val;
>>> +     unsigned long val;
>>> +
>>> +     if (strict_strtoul(buf, 10, &val))
>>> +             return -EINVAL;
>>> +
>>> +     mutex_lock(&data->update_lock);
>>> +     ret_val = i2c_smbus_read_byte_data(client, 0x20);
>>> +     if (val = ACCEL_POWER_MODE_DOWN)
>> Same trick with negating might make this clearer.
>>> +             set_val = ret_val & 0xBF; /* if value id 0 */
>>> +     else if (val = ACCEL_POWER_MODE_ACTIVE)
>>> +             set_val = (ret_val | (1<<6)); /* if value is 1 */
>>> +     else
>>> +             goto invarg;
>>> +
>>> +     i2c_smbus_write_byte_data(client, 0x20, set_val);
>>> +     mutex_unlock(&data->update_lock);
>>> +     return count;
>>> +invarg:
>>> +     mutex_unlock(&data->update_lock);
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static DEVICE_ATTR(data_rate, S_IRUGO | S_IWUSR, rate_show, rate_store);
>>> +static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR, state_show, state_store);
>>> +static DEVICE_ATTR(position, S_IRUGO, xyz_pos_show, NULL);
>>> +
>>> +static struct attribute *lis331dl_attr[] = {
>>> +     &dev_attr_data_rate.attr,
>>> +     &dev_attr_power_state.attr,
>>> +     &dev_attr_position.attr,
>>> +     NULL
>>> +};
>>> +
>>> +static struct attribute_group lis331dl_gr = {
>>> +     .attrs = lis331dl_attr
>>> +};
>>> +
>>> +static void accel_set_default_config(struct i2c_client *client)
>>> +{
>>> +     /* Device is configured in
>>> +     * 100Hz output data rate 7 bit 0
>>> +     * active mode   6 bit 1
>>> +     * x,y,z axix enable   0,1,2 bits 1*/
>>> +     i2c_smbus_write_byte_data(client, 0x20, 0x47);
>>> +}
>>> +
>>> +static int  lis331dl_probe(struct i2c_client *client,
>>> +                                     const struct i2c_device_id *id)
>>> +{
>>> +     int res;
>>> +     struct lis331dl_data *data;
>>> +
>>> +     data = kzalloc(sizeof(struct lis331dl_data), GFP_KERNEL);
>>> +     if (data = NULL) {
>> Memory alloc failed might be marginally clearer (ignore if you like!)
>>> +             printk(KERN_WARNING "lis331dl: Memory initi failed \n");
>>> +             return -ENOMEM;
>>> +     }
>>> +     mutex_init(&data->update_lock);
>>> +     i2c_set_clientdata(client, data);
>>> +
>>> +     res = sysfs_create_group(&client->dev.kobj, &lis331dl_gr);
>>> +     if (res) {
>>> +             printk(KERN_WARNING "lis331dl: Sysfs  group failed!!\n");
>>> +             goto acclero_error1;
>>> +     }
>>> +     data->hwmon_dev = hwmon_device_register(&client->dev);
>>> +     if (IS_ERR(data->hwmon_dev)) {
>>> +             res = PTR_ERR(data->hwmon_dev);
>>> +             data->hwmon_dev = NULL;
>>> +             sysfs_remove_group(&client->dev.kobj, &lis331dl_gr);
>> Not sure if this was in original patch or my email client added it,
>> but the line break should probably be avoided.
>> How about:
>> +               printk(KERN_WARNING
>>                       "lis331dl: unable to register hwmon device\n");
>>
>>> +             printk(KERN_WARNING "lis331dl: unable to register \
>>> +                                             hwmon device\n");
>>> +             goto acclero_error1;
>>> +     }
>>> +     accel_set_default_config(client);
>>> +
>>> +     dev_info(&client->dev, "%s lis331dl:  Accelerometer chip \
>>> +                                                     foundn", client->name);
>>> +     return res;
>>> +
>>> +acclero_error1:
>>> +     i2c_set_clientdata(client, NULL);
>>> +     kfree(data);
>>> +     return res;
>>> +}
>>> +
>>> +static int lis331dl_remove(struct i2c_client *client)
>>> +{
>>> +     struct lis331dl_data *data = i2c_get_clientdata(client);
>>> +
>>> +     hwmon_device_unregister(data->hwmon_dev);
>>> +     sysfs_remove_group(&client->dev.kobj, &lis331dl_gr);
>>> +     kfree(data);
>>> +     return 0;
>>> +}
>>> +
>>> +static struct i2c_device_id lis331dl_id[] = {
>>> +     { "lis331dl", 0 },
>>> +     { }
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(i2c, lis331dl_id);
>>> +
>>> +static struct i2c_driver lis331dl_driver = {
>>> +     .driver = {
>>> +     .name = "lis331dl",
>>> +     },
>>> +     .probe = lis331dl_probe,
>>> +     .remove = lis331dl_remove,
>>> +     .id_table = lis331dl_id,
>>> +};
>>> +
>>> +static int __init sensor_lis331dl_init(void)
>>> +{
>>> +     return  i2c_add_driver(&lis331dl_driver);
>>> +}
>>> +
>>> +static void  __exit sensor_lis331dl_exit(void)
>>> +{
>>> +     i2c_del_driver(&lis331dl_driver);
>>> +}
>>> +
>>> +module_init(sensor_lis331dl_init);
>>> +module_exit(sensor_lis331dl_exit);
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
