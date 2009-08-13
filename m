From: "Trisal, Kalhan" <kalhan.trisal@intel.com>
Date: Thu, 13 Aug 2009 10:56:21 +0000
Subject: Re: [lm-sensors] Accelerometer
Message-Id: <3CA6C6D9F70D314CA34352990B57DA1535F025DD@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A816C83.1070409@cam.ac.uk>
In-Reply-To: <4A816C83.1070409@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Jonathan.
  Please find my comments inline.

Thanks
Kalhan

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
Sent: Tuesday, August 11, 2009 6:35 PM
To: Trisal, Kalhan
Cc: lm-sensors@lm-sensors.org; alan@linux.intel.com
Subject: Re: [lm-sensors] Accelerometer driver for STMicroeletronics-LIS331DL-three-axis-digital

Kalhan Trisal wrote:
>>From 0d9b356e19170242fcbb746744b7ccb5156211eb Mon Sep 17 00:00:00 2001
> From: Kalhan Trisal <kalhan.trisal@intel.com>
> Date: Tue, 11 Aug 2009 11:12:02 -0400
> Subject: [PATCH] STMicroeletronics LIS331DL three-axis digital accelerometer
>
> This driver provides support for the LIS3331DL accelerometer
> accelerometer, connected to I2C. The accelerometer data is readable via
> sys/class/hwmon.
>
> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
Please read the various previous threads on where accelerometers should
go in the kernel.  One of the biggest elements of them is that hwmon
is not the right place. They typically aren't being used for low
update rate monitoring of hardware.  One option is IIO but thats still
waiting for someone to have time to review the core.  Take a look
at the lis3l02dq driver posted to lkml to see how this sort of device
would be handled (including the interrupts etc).

Anyhow, other than the where to put it issue, I have a few nitpicking
comments and queries below.

> ---
>  drivers/hwmon/Kconfig    |    9 ++
>  drivers/hwmon/Makefile   |    1 +
>  drivers/hwmon/lis331dl.c |  283 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/hwmon/lis331dl.c
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..ac6117a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -975,6 +975,15 @@ config SENSORS_LIS3LV02D
>         Say Y here if you have an applicable laptop and want to experience
>         the awesome power of lis3lv02d.
>
> +config SENSORS_LIS331DL
> +     tristate "STMicroeletronics LIS331DL three-axis digital accelerometer"
> +     depends on I2C_MRST
> +     default n
> +     help
> +       This driver provides support for the LIS3331DL accelerometer
> +       accelerometer, connected or I2C. The accelerometer data is readable via
> +       sys/class/hwmon.
> +
>  config SENSORS_LIS3_SPI
>       tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
>       depends on !ACPI && SPI_MASTER && INPUT
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b793dce..3b1e424 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231)        += vt8231.o
>  obj-$(CONFIG_SENSORS_W83627EHF)      += w83627ehf.o
>  obj-$(CONFIG_SENSORS_W83L785TS)      += w83l785ts.o
>  obj-$(CONFIG_SENSORS_W83L786NG)      += w83l786ng.o
> +obj-$(CONFIG_SENSORS_LIS331DL)       += lis331dl.o
>
>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/hwmon/lis331dl.c b/drivers/hwmon/lis331dl.c
> new file mode 100755
> index 0000000..9b999a3
> --- /dev/null
> +++ b/drivers/hwmon/lis331dl.c
> @@ -0,0 +1,283 @@
> +/*
> + * lis331dl.c - ST LIS331DL  Accelerometer Driver
> + *
> + * Copyright (C) 2009 Intel Corp
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon-vid.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +
> +
> +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
> +MODULE_DESCRIPTION("STMacroelectronics LIS331DL Accelerometer Driver");
> +MODULE_LICENSE("GPL v2");
> +
> +#define ACCEL_DATA_RATE_100HZ 0
> +#define ACCEL_DATA_RATE_400HZ 1
> +#define ACCEL_POWER_MODE_DOWN 0
> +#define ACCEL_POWER_MODE_ACTIVE 1
> +#define ACCEL_NORMAL_MODE 0
> +#define ACCEL_MEMORY_REBOOT 1
> +
> +/* internal return values */
> +
> +struct acclero_data {
> +     struct device *hwmon_dev;
> +     struct mutex update_lock;
> +};
The above structure has rather a general name, likely to lead to a clash
in the future. The same is true of a number of the functions.


>> will rename to device specific structure.

> +static unsigned int i2c_write_current_data(struct i2c_client *client,
> +                                     unsigned int reg, unsigned int value)
> +{
> +     int ret_val;
> +
> +     ret_val = i2c_smbus_write_byte_data(client, reg, value);
> +     return ret_val;
> +}
Why bother with above. Doesn't seem to being anything?  Presumably
it was to allow for later inclusion of spi support, but as is you
might as well call the smbus command directly.


>> yes can be done but for future support/enhancement  let's keep it as modular as possible.

> +static ssize_t rate_show(struct device *dev,
> +                     struct device_attribute *attr, char *buf)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     int ret_val, val;
> +
> +     val = i2c_smbus_read_byte_data(client, 0x20);
> +     ret_val = (val & 0x80); /* 1= 400HZ 0= 100HZ */
> +     if (ret_val = 0x80)
> +             ret_val = 1;
Having carefully added definitions for this above, why not use them?


>> will do this change in next patch.

> +     return sprintf(buf, "%d\n", ret_val);
> +
odd spacing.
>> will rectify this.
> +}

Not clear what state is refering to. Looking at the data sheet I
can see that it is power down control. Do you want userspace access
to this, or should it be done via the fine grained power management
stuff that is working its way into the kernel?

>> in mids the Apps. manager are intelligent to check if no apps are going to use the device they can power down the device,
>> power management can do this, but we decided that exposing this to app manager will be more effective as we can put the
>>device in active mode only when needed.

> +static ssize_t state_show(struct device *dev,
> +                     struct device_attribute *attr, char *buf)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     int ret_val, val;
> +
Definitions for register addresses would make this easier to read.

>> taken will do the change in next patch

> +     val = i2c_smbus_read_byte_data(client, 0x20);
> +     ret_val = (val & 0x40);
> +     if (ret_val = 0x40)
> +             ret_val = 1;
> +     return sprintf(buf, "%d\n", ret_val);
> +}
> +

Up to you whether you do a single access point for all 3 readings (scan
across them) or individual reads.  Guess which makes sense depends on the
application.

>> thought about this but apps want all the data at a given time stamp, this also many not be accurate but by calling individual x,y,z
>>this seems to be more accurate at given time stamp what is the current position.

> +static ssize_t xyz_pos_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +     int x, y, z;
> +     struct i2c_client *client = to_i2c_client(dev);
I haven't read the data sheet thoroughly, but is the device capable of
doing more complex reads? (would be nice to cut down the bus load
of this given the device is running at maybe 400 Hz).
Table 14 of the data sheet seems to hint this can be done.
I guess it would also be dependant on what your i2c adapter supports.

>> Agree It is adapter dependent, will put the note here saying that if the adapter support multiple
>> register read simultaneously then that also can be performed.

> +     x = i2c_smbus_read_byte_data(client, 0x29);
> +     y = i2c_smbus_read_byte_data(client, 0x2B);
> +     z = i2c_smbus_read_byte_data(client, 0x2D);
> +     return sprintf(buf, "%d, %d, %d \n", x, y, z);
> +}
> +
> +static ssize_t rate_store(struct device *dev,
> +             struct device_attribute *attr, const char *buf, size_t count)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     struct acclero_data *data = i2c_get_clientdata(client);
> +     unsigned int ret_val, set_val;
> +     unsigned long val;
> +
> +     if (strict_strtoul(buf, 10, &val))
> +             return -EINVAL;
Why bother locking for updates without protecting the reads as well?
Given I'm guessing a given i2c write is atomic, I'm not sure you gain
anything.


 > > will remove mutex

> +     ret_val = i2c_smbus_read_byte_data(client, 0x20);
> +
> +     mutex_lock(&data->update_lock);
> +     if (val = ACCEL_DATA_RATE_100HZ)
> +             set_val = (ret_val & 0x7F); /* setting the 8th bit to 0 */
> +     else if (val = ACCEL_DATA_RATE_400HZ)
> +             set_val = (ret_val | (1 << 7));
> +     else
> +             goto invarg;
> +
> +     i2c_write_current_data(client, 0x20, set_val);
> +     mutex_unlock(&data->update_lock);
> +     return count;
> +invarg:
> +     mutex_unlock(&data->update_lock);
> +     return -EINVAL;
> +}
> +
> +static ssize_t state_store(struct device *dev,
> +             struct device_attribute *attr, const  char *buf, size_t count)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     struct acclero_data *data = i2c_get_clientdata(client);
> +     unsigned int ret_val, set_val;
> +     unsigned long val;
> +
> +     if (strict_strtoul(buf, 10, &val))
> +             return -EINVAL;
> +     ret_val = i2c_smbus_read_byte_data(client, 0x20);
> +
> +     mutex_lock(&data->update_lock);
> +     if (val = ACCEL_POWER_MODE_DOWN)
> +             set_val = ret_val & 0xBF; /* if value id 0 */
> +     else if (val = ACCEL_POWER_MODE_ACTIVE)
> +             set_val = (ret_val | (1<<6)); /* if value is 1 */
> +     else
> +             goto invarg;
> +
> +     i2c_write_current_data(client, 0x20, set_val);
> +     mutex_unlock(&data->update_lock);
> +     return count;
> +invarg:
> +     mutex_unlock(&data->update_lock);
> +     return -EINVAL;
> +}

Why do you want this exposed to userspace? To my reading
the primary purpose in doing this is to reset any changes
to the various calibrated parameters. Exporting to userspace
might make sense if you were also exporting interfaces for them
(HPcoeff for example) Even then, I'm not sure providing access
to this isn't more confusing than ideal.

>> this is exposed to user space if the application manager is sensing that the values
>> from the device are inconsistent, then best way is to reboot the device. This option is
>> only for sensor application manager. I felt it will be useful when device misbehaves and can be rectified
>> dynamically by rebooting the device.

> +static ssize_t reboot_mem_store(struct device *dev,
> +             struct device_attribute *attr, const char *buf, size_t count)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     struct acclero_data *data = i2c_get_clientdata(client);
> +     unsigned int ret_val, set_val;
> +     unsigned long val;
> +
> +     if (strict_strtoul(buf, 10, &val))
> +             return -EINVAL;
> +     ret_val = i2c_smbus_read_byte_data(client, 0x21);
> +     if (val = ACCEL_MEMORY_REBOOT) {
> +             mutex_lock(&data->update_lock);
> +             set_val = (ret_val | (1 << 6)); /* setting the 6th  bit */
> +             i2c_write_current_data(client, 0x21, set_val);
> +             mutex_unlock(&data->update_lock);
> +     } else
> +             return -EINVAL;
> +     return count;
> +}
> +
> +static DEVICE_ATTR(data_rate, S_IRUGO | S_IWUSR, rate_show, rate_store);
> +static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR, state_show, state_store);
> +static DEVICE_ATTR(reboot_mem, S_IWUSR, NULL, reboot_mem_store);
> +static DEVICE_ATTR(position, S_IRUGO, xyz_pos_show, NULL);
> +
> +static struct attribute *mid_att_acclero[] = {
> +     &dev_attr_data_rate.attr,
> +     &dev_attr_power_state.attr,
> +     &dev_attr_reboot_mem.attr,
> +     &dev_attr_position.attr,
> +     NULL
> +};
This is a little odd, why have a device with an attribute group
of the same name? I think this will lead to a somewhat unusual
structure in sysfs.

>> I am not clear here, does it mean that we should rename it as accelerometer.

> +static struct attribute_group m_acclero_gr = {
> +     .name = "lis331dl",
> +     .attrs = mid_att_acclero
> +};
> +
> +static void accel_set_default_config(struct i2c_client *client)
> +{
This could at very least do with a comment explaining what default
you have selected.


>> Accepted will do that.

> +     i2c_write_current_data(client, 0x20, 0x47);
> +}
> +
> +static int  lis331dl_probe(struct i2c_client *client,
> +                                     const struct i2c_device_id *id)
> +{
> +     int res;
> +     struct acclero_data *data;
> +
> +     data = kzalloc(sizeof(struct acclero_data), GFP_KERNEL);
> +     if (data = NULL) {
> +             printk(KERN_WARNING "lis331dl: Memory initi failed \n");
> +             return -ENOMEM;
> +     }
> +     mutex_init(&data->update_lock);
> +     i2c_set_clientdata(client, data);
> +
> +     res = sysfs_create_group(&client->dev.kobj, &m_acclero_gr);
> +     if (res) {
> +             printk(KERN_WARNING "lis331dl: Sysfs  group failed!!\n");
> +             goto acclero_error1;
> +     }
> +     data->hwmon_dev = hwmon_device_register(&client->dev);
> +     if (IS_ERR(data->hwmon_dev)) {
> +             res = PTR_ERR(data->hwmon_dev);
> +             data->hwmon_dev = NULL;
> +             sysfs_remove_group(&client->dev.kobj, &m_acclero_gr);
> +             printk(KERN_WARNING "lis331dl: unable to register \
> +                                             hwmon device\n");
> +             goto acclero_error1;
> +     }
> +     accel_set_default_config(client);
> +
> +     dev_info(&client->dev, "%s lis331dl:  Accelerometer chip \
> +                                                     foundn", client->name);
> +     return res;
> +
> +acclero_error1:
> +     i2c_set_clientdata(client, NULL);
> +     kfree(data);
> +     return res;
> +}
> +
> +static int lis331dl_remove(struct i2c_client *client)
> +{
> +     struct acclero_data *data = i2c_get_clientdata(client);
> +
> +     hwmon_device_unregister(data->hwmon_dev);
> +     sysfs_remove_group(&client->dev.kobj, &m_acclero_gr);
> +     kfree(data);
> +     return 0;
> +}
That's a very odd name for i2c device.  Shouldn't it be lis33ld1
or similar?

>> Accepted will do the change.

> +static struct i2c_device_id lis331dl_id[] = {
> +     { "i2c_accel", 0 },
> +     { }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, lis331dl_id);
> +
> +static struct i2c_driver lis331dl_driver = {
> +     .driver = {
> +     .name = "lis331dl",
> +     },
> +     .probe = lis331dl_probe,
> +     .remove = lis331dl_remove,
> +     .id_table = lis331dl_id,
> +};
> +
> +static int __init sensor_lis331dl_init(void)
> +{
> +     int res;
> +
> +     res = i2c_add_driver(&lis331dl_driver);
> +     return res;
> +}
> +
> +static void  __exit sensor_lis331dl_exit(void)
> +{
> +     i2c_del_driver(&lis331dl_driver);
> +}
> +
> +module_init(sensor_lis331dl_init);
> +module_exit(sensor_lis331dl_exit);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
