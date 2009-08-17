From: "Constantine A. Murenin" <mureninc@gmail.com>
Date: Mon, 17 Aug 2009 14:20:28 +0000
Subject: Re: [lm-sensors] Accelerometer driver for
Message-Id: <f34ca13c0908170720l6a7a1311m6592846f30056822@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Isn't this accelerometer already supported by hwmon/lis3lv02d.c?  From
the datasheets, I don't see any register differences between lis331dl
and lis302dl.

Cheers,
Constantine.

2009/8/17 Jonathan Cameron <jic23@cam.ac.uk>:
> Hi Kalhan,
>
> Nice clean driver.
>
> Few minor bits I missed before... Other than cleaning up the Kconfig
> description, up to you whether you bother with the others.
>
> Note, unless general opinions have changed, this won't get merged in hwmo=
n.
>
>>>From f63c311f0106f6fbcced05b168cf60f996621e47 Mon Sep 17 00:00:00 2001
>> From: Kalhan Trisal <kalhan.trisal@intel.com>
>> Date: Fri, 14 Aug 2009 20:44:56 -0400
> Curious abrievation of accelerometer, probably just use accel.
>> Subject: [PATCH] STMicroeletronics-LIS331DL-three-axis-digital-accelrome=
ter
>>
>> submitting the patch with comments incorporated.
>> This driver provides support for the LIS3331DL accelerometer
>> accelerometer, connected to I2C. The accelerometer data is readable via
>> sys/class/hwmon.
>>
>> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
>>
>>
>> ---
>> =A0drivers/hwmon/Kconfig =A0 =A0| =A0 =A08 ++
>> =A0drivers/hwmon/Makefile =A0 | =A0 =A01 +
>> =A0drivers/hwmon/lis331dl.c | =A0250 +++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 259 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/lis331dl.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 2d50166..394a591 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1017,6 +1017,14 @@ config SENSORS_APPLESMC
>> =A0 =A0 =A0 =A0 Say Y here if you have an applicable laptop and want to =
experience
>> =A0 =A0 =A0 =A0 the awesome power of applesmc.
>>
>> +config SENSORS_LIS331DL
>> + =A0 =A0 tristate "STMicroeletronics LIS331DL three-axis digital accele=
rometer"
>> + =A0 =A0 depends on I2C
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you say yes here you get support for the Accelerometer =
=A0Devices
> Please rewrite this description. We are dealing with specific acceleromet=
er only.
>> + =A0 =A0 =A0 Device can be configured using sysfs.
>> + =A0 =A0 =A0 x y Z data can be =A0 accessible via sysfs.
>> +
>> =A0config HWMON_DEBUG_CHIP
>> =A0 =A0 =A0 bool "Hardware Monitoring Chip debugging messages"
>> =A0 =A0 =A0 default n
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index b793dce..3b1e424 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231) =A0 =A0 =A0 =A0+=3D vt823=
1.o
>> =A0obj-$(CONFIG_SENSORS_W83627EHF) =A0 =A0 =A0+=3D w83627ehf.o
>> =A0obj-$(CONFIG_SENSORS_W83L785TS) =A0 =A0 =A0+=3D w83l785ts.o
>> =A0obj-$(CONFIG_SENSORS_W83L786NG) =A0 =A0 =A0+=3D w83l786ng.o
>> +obj-$(CONFIG_SENSORS_LIS331DL) =A0 =A0 =A0 +=3D lis331dl.o
>>
>> =A0ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>> =A0EXTRA_CFLAGS +=3D -DDEBUG
>> diff --git a/drivers/hwmon/lis331dl.c b/drivers/hwmon/lis331dl.c
>> new file mode 100644
>> index 0000000..c8d6b84
>> --- /dev/null
>> +++ b/drivers/hwmon/lis331dl.c
>> @@ -0,0 +1,250 @@
>> +/*
>> + * lis331dl.c - ST LIS331DL =A0Accelerometer Driver
>> + *
>> + * Copyright (C) 2009 Intel Corp
>> + *
>> + * =A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong
>> + * with this program; if not, write to the Free Software Foundation, In=
c.,
>> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/slab.h>
>> +#include <linux/i2c.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/hwmon-vid.h>
>> +#include <linux/err.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/sysfs.h>
>> +
>> +
>> +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
>> +MODULE_DESCRIPTION("STMacroelectronics LIS331DL Accelerometer Driver");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +#define ACCEL_DATA_RATE_100HZ 0
>> +#define ACCEL_DATA_RATE_400HZ 1
>> +#define ACCEL_POWER_MODE_DOWN 0
>> +#define ACCEL_POWER_MODE_ACTIVE 1
>> +
>> +/* internal return values */
>> +
>> +struct lis331dl_data {
>> + =A0 =A0 struct device *hwmon_dev;
>> + =A0 =A0 struct mutex update_lock;
>> +};
>
> Might be better to actually output this in Hz, so either 100 or 200
> rather than 0 or 1. Same is true when setting it. =A0Can always add
> another sysfs file as available_rates which lists the posibilities.
>> +static ssize_t rate_show(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr,=
 char *buf)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 int ret_val, val;
>> +
>> + =A0 =A0 val =3D i2c_smbus_read_byte_data(client, 0x20);
>> + =A0 =A0 ret_val =3D (val & 0x80); /* 1=3D 400HZ 0=3D 100HZ */
>> + =A0 =A0 if (ret_val =3D 0x80)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret_val =3D ACCEL_DATA_RATE_400HZ;
>> + =A0 =A0 return sprintf(buf, "%d\n", ret_val);
>> +
>> +}
>> +
>> +static ssize_t state_show(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr,=
 char *buf)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 int ret_val, val;
>> +
>> + =A0 =A0 val =3D i2c_smbus_read_byte_data(client, 0x20);
>> + =A0 =A0 ret_val =3D (val & 0x40);
>> + =A0 =A0 if (ret_val =3D 0x40)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret_val =3D ACCEL_POWER_MODE_ACTIVE;
>> + =A0 =A0 return sprintf(buf, "%d\n", ret_val);
>> +}
>> +
>> +/* if adapter support multiple read better to use that device support t=
hat */
>> +static ssize_t xyz_pos_show(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_=
attribute *attr, char *buf)
>> +{
>> + =A0 =A0 int x, y, z;
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> +
>> + =A0 =A0 x =3D i2c_smbus_read_byte_data(client, 0x29);
>> + =A0 =A0 y =3D i2c_smbus_read_byte_data(client, 0x2B);
>> + =A0 =A0 z =3D i2c_smbus_read_byte_data(client, 0x2D);
>> + =A0 =A0 return sprintf(buf, "%d, %d, %d \n", x, y, z);
>> +}
>> +
>> +static ssize_t rate_store(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const char *buf=
, size_t count)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 struct lis331dl_data *data =3D i2c_get_clientdata(client);
>> + =A0 =A0 unsigned int ret_val, set_val;
>> + =A0 =A0 unsigned long val;
>> +
>> + =A0 =A0 if (strict_strtoul(buf, 10, &val))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 ret_val =3D i2c_smbus_read_byte_data(client, 0x20);
>> +
>> + =A0 =A0 mutex_lock(&data->update_lock);
>> + =A0 =A0 if (val =3D ACCEL_DATA_RATE_100HZ)
> Could go with (ret_val & ~0x80) which makes the comment unecessary.
> Fine either way though. (or even (ret_val & ~(1 << 7)) for consistency).
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_val =3D (ret_val & 0x7F); /* setting the 8=
th bit to 0 */
>> + =A0 =A0 else if (val =3D ACCEL_DATA_RATE_400HZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_val =3D (ret_val | (1 << 7));
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto invarg;
>> +
>> + =A0 =A0 i2c_smbus_write_byte_data(client, 0x20, set_val);
>> + =A0 =A0 mutex_unlock(&data->update_lock);
>> + =A0 =A0 return count;
>> +invarg:
>> + =A0 =A0 mutex_unlock(&data->update_lock);
>> + =A0 =A0 return -EINVAL;
>> +}
>> +
>> +static ssize_t state_store(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const =A0char *=
buf, size_t count)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 struct lis331dl_data *data =3D i2c_get_clientdata(client);
>> + =A0 =A0 unsigned int ret_val, set_val;
>> + =A0 =A0 unsigned long val;
>> +
>> + =A0 =A0 if (strict_strtoul(buf, 10, &val))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&data->update_lock);
>> + =A0 =A0 ret_val =3D i2c_smbus_read_byte_data(client, 0x20);
>> + =A0 =A0 if (val =3D ACCEL_POWER_MODE_DOWN)
> Same trick with negating might make this clearer.
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_val =3D ret_val & 0xBF; /* if value id 0 */
>> + =A0 =A0 else if (val =3D ACCEL_POWER_MODE_ACTIVE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_val =3D (ret_val | (1<<6)); /* if value is=
 1 */
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto invarg;
>> +
>> + =A0 =A0 i2c_smbus_write_byte_data(client, 0x20, set_val);
>> + =A0 =A0 mutex_unlock(&data->update_lock);
>> + =A0 =A0 return count;
>> +invarg:
>> + =A0 =A0 mutex_unlock(&data->update_lock);
>> + =A0 =A0 return -EINVAL;
>> +}
>> +
>> +static DEVICE_ATTR(data_rate, S_IRUGO | S_IWUSR, rate_show, rate_store);
>> +static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR, state_show, state_st=
ore);
>> +static DEVICE_ATTR(position, S_IRUGO, xyz_pos_show, NULL);
>> +
>> +static struct attribute *lis331dl_attr[] =3D {
>> + =A0 =A0 &dev_attr_data_rate.attr,
>> + =A0 =A0 &dev_attr_power_state.attr,
>> + =A0 =A0 &dev_attr_position.attr,
>> + =A0 =A0 NULL
>> +};
>> +
>> +static struct attribute_group lis331dl_gr =3D {
>> + =A0 =A0 .attrs =3D lis331dl_attr
>> +};
>> +
>> +static void accel_set_default_config(struct i2c_client *client)
>> +{
>> + =A0 =A0 /* Device is configured in
>> + =A0 =A0 * 100Hz output data rate 7 bit 0
>> + =A0 =A0 * active mode =A0 6 bit 1
>> + =A0 =A0 * x,y,z axix enable =A0 0,1,2 bits 1*/
>> + =A0 =A0 i2c_smbus_write_byte_data(client, 0x20, 0x47);
>> +}
>> +
>> +static int =A0lis331dl_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const struct i2c_device_id *id)
>> +{
>> + =A0 =A0 int res;
>> + =A0 =A0 struct lis331dl_data *data;
>> +
>> + =A0 =A0 data =3D kzalloc(sizeof(struct lis331dl_data), GFP_KERNEL);
>> + =A0 =A0 if (data =3D NULL) {
> Memory alloc failed might be marginally clearer (ignore if you like!)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "lis331dl: Memory initi fa=
iled \n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> + =A0 =A0 mutex_init(&data->update_lock);
>> + =A0 =A0 i2c_set_clientdata(client, data);
>> +
>> + =A0 =A0 res =3D sysfs_create_group(&client->dev.kobj, &lis331dl_gr);
>> + =A0 =A0 if (res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "lis331dl: Sysfs =A0group =
failed!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto acclero_error1;
>> + =A0 =A0 }
>> + =A0 =A0 data->hwmon_dev =3D hwmon_device_register(&client->dev);
>> + =A0 =A0 if (IS_ERR(data->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 res =3D PTR_ERR(data->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->hwmon_dev =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &lis331d=
l_gr);
> Not sure if this was in original patch or my email client added it,
> but the line break should probably be avoided.
> How about:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "lis331dl: unable to register=
 hwmon device\n");
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "lis331dl: unable to regis=
ter \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 hwmon device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto acclero_error1;
>> + =A0 =A0 }
>> + =A0 =A0 accel_set_default_config(client);
>> +
>> + =A0 =A0 dev_info(&client->dev, "%s lis331dl: =A0Accelerometer chip \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 foundn", client->name);
>> + =A0 =A0 return res;
>> +
>> +acclero_error1:
>> + =A0 =A0 i2c_set_clientdata(client, NULL);
>> + =A0 =A0 kfree(data);
>> + =A0 =A0 return res;
>> +}
>> +
>> +static int lis331dl_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 struct lis331dl_data *data =3D i2c_get_clientdata(client);
>> +
>> + =A0 =A0 hwmon_device_unregister(data->hwmon_dev);
>> + =A0 =A0 sysfs_remove_group(&client->dev.kobj, &lis331dl_gr);
>> + =A0 =A0 kfree(data);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct i2c_device_id lis331dl_id[] =3D {
>> + =A0 =A0 { "lis331dl", 0 },
>> + =A0 =A0 { }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, lis331dl_id);
>> +
>> +static struct i2c_driver lis331dl_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 .name =3D "lis331dl",
>> + =A0 =A0 },
>> + =A0 =A0 .probe =3D lis331dl_probe,
>> + =A0 =A0 .remove =3D lis331dl_remove,
>> + =A0 =A0 .id_table =3D lis331dl_id,
>> +};
>> +
>> +static int __init sensor_lis331dl_init(void)
>> +{
>> + =A0 =A0 return =A0i2c_add_driver(&lis331dl_driver);
>> +}
>> +
>> +static void =A0__exit sensor_lis331dl_exit(void)
>> +{
>> + =A0 =A0 i2c_del_driver(&lis331dl_driver);
>> +}
>> +
>> +module_init(sensor_lis331dl_init);
>> +module_exit(sensor_lis331dl_exit);
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
