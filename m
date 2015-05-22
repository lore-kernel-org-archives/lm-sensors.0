From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 22 May 2015 03:58:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for Texas Instruments TPS2480/TPS2481
Message-Id: <555EA96D.6030208@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <555DF93F.3090909@appeartv.com>
In-Reply-To: <555DF93F.3090909@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hadrien,

On 05/21/2015 08:26 AM, Hadrien Copponnex wrote:
> Attached is a patch which adds hwmon support for Texas Instruments TPS2480/TPS2481 current sensor. The code follows the same architecture found in other hwmon drivers and should be pretty easy to understand.
>
> The chip reports measured current as the voltage drop across a shunt resistor. This value is reported in the curr1_input attribute as 10 uV steps. It is then the responsibility of the user to convert back this value in amperes to have the correct value (for instance using sensors.conf file).
>
The current is really reported in the current register. The voltage drop is just that, a voltage drop,
and should be reported as voltage.

> Many parameters affecting the chip operation are exported through sysfs interface and thus are available for configuration from userland. Even if it is not necessary to configure the chip before usage, there might be cases where a user needs to do so.
>
> To apply the patch on the latest kernel, simply type (assuming filename <patch>):
> git apply --check <patch>
>
> To use the driver, enable the option "SENSORS_TPS2480", in your kernel configuration file. I2C/SMBus support is required in your kernel. The code has been written in an architecture-independent way, but have only been tested on PowerPC architecture (big-endian).
>
> As this is my first patch submitted for the Linux kernel, it is possible that the approach I used is not correct, notably the way the driver reports current/voltage information and the exported chip parameters. I don't know if it is necessary to export that much information/configuration for a simple chip like this one, or if I should keep it simple, and use the chip in the default configuration.
>
> Please let me know any feedback you have on this patch.
>
Please read and follow Documentation/hwmon/submitting-patches,
and consider what it says as overall feedback. For the most
part, I won't comment on items covered by this document.
Some more comments inline.

Thanks,
Guenter

> Best regards,
> Hadrien Copponnex
> R&D Engineer
>
> AppearTV AS
> www.appeartv.com
>
> Signed-off-by: Hadrien Copponnex <hadrien.copponnex@appeartv.com>
>
> ---
>   drivers/hwmon/Kconfig   |   10 ++
>   drivers/hwmon/Makefile  |    1 +
>   drivers/hwmon/tps2480.c |  386 +++++++++++++++++++++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/tps2480.

>   3 files changed, 397 insertions(+)
>   create mode 100644 drivers/hwmon/tps2480.c
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 25d9e72..7919e7d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1504,6 +1504,16 @@ config SENSORS_TMP421
>         This driver can also be built as a module.  If so, the module
>         will be called tmp421.
>
> +config SENSORS_TPS2480
> +    tristate "Texas Instruments TPS2480/2481 (EXPERIMENTAL)"
> +    depends on I2C
> +    help
> +      If you say yes here you get support for Texas Instruments TPS2480
> +      and TPS2481 sensor chips.
> +
Those are not sensor chips. "Hotswap controllers", maybe ?

> +      This driver can also be built as a module.  If so, the module
> +      will be called tps2480.
> +
>   config SENSORS_TWL4030_MADC
>       tristate "Texas Instruments TWL4030 MADC Hwmon"
>       depends on TWL4030_MADC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b4a40f1..b640247 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_SENSORS_TMP102)    += tmp102.o
>   obj-$(CONFIG_SENSORS_TMP103)    += tmp103.o
>   obj-$(CONFIG_SENSORS_TMP401)    += tmp401.o
>   obj-$(CONFIG_SENSORS_TMP421)    += tmp421.o
> +obj-$(CONFIG_SENSORS_TPS2480)   += tps2480.o
>   obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
>   obj-$(CONFIG_SENSORS_VEXPRESS)    += vexpress.o
>   obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
> diff --git a/drivers/hwmon/tps2480.c b/drivers/hwmon/tps2480.c
> new file mode 100644
> index 0000000..caaf847
> --- /dev/null
> +++ b/drivers/hwmon/tps2480.c
> @@ -0,0 +1,386 @@
> +/*
> + * Hardware monitoring driver for TI TPS2480 / TPS2481
> + *
> + * Copyright (c) 2014 AppearTV AS
> + *

2015 ?

> + * Relevant documentation:
> + *    http://www.ti.com/lit/ds/symlink/tps2480.pdf
> + *
Plus tps2481 ? it might be better to point to the datasheet in the
documentation file. This way it only needs to be updated once.

> + * Parts of this file are based from:
> + *    ltc4151.c (tps2480_update_device function)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/delay.h>

Is this needed ?

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/jiffies.h>
> +
Please provide include files in alphabetical order.

> +#define TPS2480_REG_CONFIG        0x00 /* R/W */
> +#define TPS2480_REG_SHUNT_VOLTAGE 0x01 /* R   */
> +#define TPS2480_REG_BUS_VOLTAGE   0x02 /* R   */
> +#define TPS2480_REG_POWER         0x03 /* R   */
> +#define TPS2480_REG_CURRENT       0x04 /* R   */
> +#define TPS2480_REG_CALIBRATION   0x05 /* R/W */
> +#define TPS2480_MAX_REGISTERS     6
> +
> +struct tps2480_data {
> +    struct device  *hwmon_dev;

Not needed (see below).

> +    struct mutex    lock;
> +    u16             registers[TPS2480_MAX_REGISTERS];
> +    unsigned long   last_updated;
> +    u8              valid;

Please use bool.

> +} tps2480_data;
> +
> +/*
> + * Chip operating functions
> + */
> +
> +static s32 write_register(struct i2c_client *client, u8 reg, u16 value)
> +{
> +    s32 err = i2c_smbus_write_word_data(client, reg, cpu_to_le16(value));
> +
i2c_smbus_write_word_data does not need cpu_to_le16(). If the byte order is wrong,
you need to use i2c_smbus_write_word_swapped().

> +    if (err)
> +        dev_err(&client->dev, "cannot write i2c command");
> +    return err;
> +}

Please just use i2c_smbus_write_word_data (or probably i2c_smbus_write_word_swapped)
and return the error to use space.

> +
> +static s32 reset_chip(struct device *dev)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct tps2480_data *data = i2c_get_clientdata(client);
> +
> +    mutex_lock(&data->lock);
> +    data->valid = 0;
> +    mutex_unlock(&data->lock);

This mutex does not protect anything.

> +
> +    return write_register(client, TPS2480_REG_CONFIG, 1 << 15);

If really needed, this would probably leave the chip unconfigured.
Is this what you want ? Also, are you sure this is needed ?
It is quite unusual, and may result in a system reset.
If that is the idea, it would be better to register a restart handler.
See register_restart_handler() / unregister_restart_handler().

> +}
> +
> +/* returns the driver data associated to the device
> + * in addition, reads the latest status from registers
> + * don't forget to release the lock when you have finished using the data
> + * structure
> + */
> +static struct tps2480_data *tps2480_update_device(struct device *dev)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct tps2480_data *data = i2c_get_clientdata(client);
> +    u8 i;
> +
Please just use int. It generates better code on most architectures.

> +    mutex_lock(&data->lock);
> +
> +    if (time_after(jiffies, data->last_updated + HZ + HZ / 2) ||

With this chip, it probably doesn't make much sense to use
this much caching time. Worst case conversion time is 68ms.
Given that, it might not even make sense to cache anything,
and to just read the registers directly.

You might consider using regmap instead of direct i2c accesses.
Regmap could be configured to cache the configuration and calibration
registers permanently, which would probably make sense.

> +        !data->valid) {
> +        /* read data and update device structure */
> +        for (i = 0; i < TPS2480_MAX_REGISTERS; ++i) {
> +            s32 val = i2c_smbus_read_word_data(client, i);
> +
> +            if (val < 0) {
> +                data->valid = 0;
> +                goto finish;
> +            }
> +            data->registers[i] = le16_to_cpu((u16)val);

i2c_smbus_read_word_data returns data in host byte order. If the byte order
is wrong, you would need to use use i2c_smbus_read_word_swapped().

> +        }
> +        data->valid = 1;
> +        data->last_updated = jiffies;
> +    }
> +
> +finish:

I don't see an unlock operation, which is highly unusual (more on that below).

> +    return data;
> +}
> +
> +/*
> + * Sysfs callbacks
> + */
> +
> +static ssize_t perform_show(struct device  *dev, char *buf, u8 reg, const u16
> +*p, const char *fmt)
> +{
> +    struct tps2480_data *data = tps2480_update_device(dev);
> +    u16 value = data->registers[reg];

This is an unsigned short which may be displayed as short with %hd.
Only reason for the compiler not to complain is probably that the format
is passed as parameter. This results in the compiler not being able
to do format checking, which is really nice to have. One more reason
to use individual functions for the different attributes.

> +    u8 valid = data->valid;
> +
Unnecessary variable.

> +    mutex_unlock(&data->lock);
> +    if (!valid)

Ah, this is where the unlock is hiding. Please don't do that,
and keep the locking within one function. Please have
tps2480_update_device() return the actual error,
and return that error to user space.

> +        return -EIO;

Replacing one error with another is never a good idea. Static checkers
will complain about that if they catch it.

> +    value = (value >> p[1]) & p[0];

The printed value must follow the ABI (mV, mA, uW). Given the
different calculations necessary, it might be better to just use
a separate function for each attribute.

Per the datasheets, the shunt voltage must include the programmed gain.
Current and power depend on the calibration values, so you'll have to
do some complex calculations to convert the raw values into mA and uW.

> +    return snprintf(buf, PAGE_SIZE, fmt, value);
> +}
> +
> +static ssize_t perform_store(struct device *dev, const char *buf, size_t count,
> +u8 reg, const u16 *p)
> +{

As with the show command, I would suggest to use separate write functions
for each (writable) attribute.

> +    struct tps2480_data *data = tps2480_update_device(dev);

Not needed here. You don't need to read anything from the chip
to update one of its registers.

> +    struct i2c_client *client = to_i2c_client(dev);
> +    unsigned long val = 0;
> +    ssize_t result = count;
> +    s32 err;
> +
> +    if (kstrtoul(buf, 10, &val) || val > p[0]) {
> +        result = -EINVAL;

kstrtoul() returns an error, which you should return

> +        goto finish;

directly without locking / goto.

> +    }
> +
Locking is needed from here

> +    data->registers[reg] = (val & p[0]) << p[1];
> +
> +    err = write_register(client, reg, data->registers[reg]);

to here.

> +    if (err)
> +        result = err;
> +
> +finish:
> +    mutex_unlock(&data->lock);

but not here.

> +
> +    return result;
> +}
> +
> +/* Variable parameters
> +   [0]: mask
> +   [1]: shift */
> +static const u16 in0[2] = {0xfff8, 0x01};
> +static const u16 cu1[2] = {0xffff, 0x00};
> +static const u16 cu2[2] = {0xffff, 0x00};
> +static const u16 pow[2] = {0xffff, 0x00};
> +static const u16 bvr[2] = {0x0001, 0x0d};
> +static const u16 pga[2] = {0x0003, 0x0b};
> +static const u16 bad[2] = {0x000f, 0x07};
> +static const u16 sad[2] = {0x000f, 0x03};
> +static const u16 mod[2] = {0x0007, 0x00};
> +static const u16 cal[2] = {0xffff, 0x00};
> +
> +static ssize_t show_in0(struct device *dev, struct device_attribute *attr, char
> +*buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_BUS_VOLTAGE, in0, "%hu\n");
> +}
> +
> +static ssize_t show_curr1(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_SHUNT_VOLTAGE, cu1, "%hd\n");
> +}
> +
> +static ssize_t show_curr2(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CURRENT, cu2, "%hd\n");
> +}
> +
> +static ssize_t show_power(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_POWER, pow, "%hu\n");
> +}
> +
> +static ssize_t store_reset(struct device *dev, struct device_attribute *attr,
> +const char *buf, size_t count)
> +{
> +    s32 err = reset_chip(dev);
> +
> +    return err ? err : count;
> +}
> +
> +static ssize_t show_bus_voltage_range(struct device *dev, struct
> +device_attribute *attr, char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CONFIG, bvr, "%hu\n");
> +}
> +
> +static ssize_t store_bus_voltage_range(struct device *dev, struct
> +device_attribute *attr, const char *buf, size_t count)
> +{
> +    return perform_store(dev, buf, count, TPS2480_REG_CONFIG, bvr);
> +}
> +
> +static ssize_t show_pga(struct device *dev, struct device_attribute *attr, char
> +*buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CONFIG, pga, "%hu\n");
> +}
> +
> +static ssize_t store_pga(struct device *dev, struct device_attribute *attr,
> +const char *buf, size_t count)
> +{
> +    return perform_store(dev, buf, count, TPS2480_REG_CONFIG, pga);
> +}
> +
> +static ssize_t show_badc(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CONFIG, bad, "%hu\n");
> +}
> +
> +static ssize_t store_badc(struct device *dev, struct device_attribute *attr,
> +const char *buf, size_t count)
> +{
> +    return perform_store(dev, buf, count, TPS2480_REG_CONFIG, bad);
> +}
> +
> +static ssize_t show_sadc(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CONFIG, sad, "%hu\n");
> +}
> +
> +static ssize_t store_sadc(struct device *dev, struct device_attribute *attr,
> +const char *buf, size_t count)
> +{
> +    return perform_store(dev, buf, count, TPS2480_REG_CONFIG, sad);
> +}
> +
> +static ssize_t show_mode(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CONFIG, mod, "%hu\n");
> +}
> +
> +static ssize_t store_mode(struct device *dev, struct device_attribute *attr,
> +const char *buf, size_t count)
> +{
> +    return perform_store(dev, buf, count, TPS2480_REG_CONFIG, mod);
> +}
> +
> +static ssize_t show_calibration(struct device *dev, struct device_attribute
> +*attr, char *buf)
> +{
> +    return perform_show(dev, buf, TPS2480_REG_CALIBRATION, cal, "%hu\n");
> +}
> +
> +static ssize_t store_calibration(struct device *dev, struct device_attribute
> +*attr, const char  *buf, size_t count)
> +{
> +    return perform_store(dev, buf, count, TPS2480_REG_CALIBRATION, cal);
> +}
> +
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL, 0); /* Bus
> +voltage */

You don't really use the parameter (last value), so providing it is quite useless.

the bus voltage has an alarm bit, so you could provide in0_alarm.

> +static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, show_curr1, NULL, 1); /* Shunt
> +voltage */

This is a voltage, not a current ??
Also, the shunt voltage can be negative per the datasheet.

> +static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO, show_curr2, NULL, 1); /*
> +Current */
> +static SENSOR_DEVICE_ATTR(power_input, S_IRUGO, show_power, NULL, 1); /*
> +Power */

power1_input

> +static SENSOR_DEVICE_ATTR(reset, S_IWUSR, NULL, store_reset, 0); /* Reset */

I don't think this should be exported.

> +static SENSOR_DEVICE_ATTR(bus_voltage_range, S_IRUGO | S_IWUSR,
> +show_bus_voltage_range, store_bus_voltage_range, 0); /* Bus voltage range */

Maybe in1_max.

> +static SENSOR_DEVICE_ATTR(pga, S_IRUGO | S_IWUSR, show_pga, store_pga, 0); /*
> +PGA */
> +static SENSOR_DEVICE_ATTR(badc, S_IRUGO | S_IWUSR, show_badc, store_badc, 0);
> +/* BADC */
> +static SENSOR_DEVICE_ATTR(sadc, S_IRUGO | S_IWUSR, show_sadc, store_sadc, 0);
> +/* SADC */
> +static SENSOR_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, store_mode, 0);
> +/* Mode */
> +static SENSOR_DEVICE_ATTR(calibration, S_IRUGO | S_IWUSR, show_calibration,
> +store_calibration, 0); /* Calibration */
> +
Those are not standard attributes supported by the ABI. Where needed, they
should be provided either with platform data or with devicetree data or both,
but not with attributes. It might make sense to provide some abstraction
instead of just raw register values.

Some of the parameters may be implementable as in[01]_max (for shunt and bus
voltage range) and curr1_max (for the maximum supported current).

You could use the update_interval attribute to set the conversion time,
though that is in milli-seconds so you'd only affect the number of samples
taken per value.

> +static struct attribute *tps2480_attrs[] = {
> +    &sensor_dev_attr_in0_input.dev_attr.attr,
> +    &sensor_dev_attr_curr1_input.dev_attr.attr,
> +    &sensor_dev_attr_curr2_input.dev_attr.attr,
> +    &sensor_dev_attr_power_input.dev_attr.attr,
> +    &sensor_dev_attr_reset.dev_attr.attr,
> +    &sensor_dev_attr_bus_voltage_range.dev_attr.attr,
> +    &sensor_dev_attr_pga.dev_attr.attr,
> +    &sensor_dev_attr_badc.dev_attr.attr,
> +    &sensor_dev_attr_sadc.dev_attr.attr,
> +    &sensor_dev_attr_mode.dev_attr.attr,
> +    &sensor_dev_attr_calibration.dev_attr.attr,
> +    NULL
> +};
> +
> +static struct attribute_group tps2480_attr_grp = {
> +    .attrs = tps2480_attrs,
> +};
> +
> +/*
> + * Driver interface functions
> + */
> +
> +static int tps2480_probe(struct i2c_client *client, const struct i2c_device_id
> +*id)
> +{
> +    struct tps2480_data *data;
> +    int err;
> +
> +    if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +I2C_FUNC_SMBUS_WORD_DATA)) {
> +        dev_err(&client->dev, "i2c adapter doesn't support smbus");
> +        return -EOPNOTSUPP;
> +    }
> +
> +    data = devm_kzalloc(&client->dev,
> +                        sizeof(struct tps2480_data),
> +                        GFP_KERNEL);

Not all continuation lines are needed here.

> +    if (data = NULL) {
> +        dev_err(&client->dev, "cannot allocate memory");

Memory allocation failures already display an error message.
Another one is not needed.

> +        return -ENOMEM;
> +    }
> +    i2c_set_clientdata(client, data);
> +
> +    mutex_init(&data->lock);
> +
> +    err = sysfs_create_group(&client->dev.kobj, &tps2480_attr_grp);
> +    if (err) {
> +        dev_err(&client->dev, "error creating sysfs attribute group");
> +        return err;
> +    }
> +
> +    data->hwmon_dev = hwmon_device_register(&client->dev);

Please use devm_hwmon_device_register_with_groups(). You can then
just return PTR_ERR_OR_ZERO(hwmon_dev), and you don't need to call
sysfs_create_group().

> +    if (IS_ERR(data->hwmon_dev)) {
> +        err = PTR_ERR(data->hwmon_dev);
> +        dev_err(&client->dev, "error registering hwmon device");
> +        sysfs_remove_group(&client->dev.kobj, &tps2480_attr_grp);
> +        return err;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tps2480_remove(struct i2c_client *client)

Not needed if you use devm_hwmon_device_register_with_groups().

> +{
> +    struct tps2480_data *data = i2c_get_clientdata(client);
> +
> +    hwmon_device_unregister(data->hwmon_dev);
> +    sysfs_remove_group(&client->dev.kobj, &tps2480_attr_grp);
> +
> +    return 0;
> +}
> +
> +static const struct i2c_device_id tps2480_id[] = {
> +    {"tps2480", 0},

It might make sense to also provide "tps2481" to simplify / support
instantiation on systems with that chip.

> +    {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tps2480_id);
> +
> +static struct i2c_driver tps2480_driver = {
> +    .class = I2C_CLASS_HWMON,
> +    .driver = {
> +           .name = "tps2480",
> +           },
> +    .probe = tps2480_probe,
> +    .remove = tps2480_remove,
> +    .id_table = tps2480_id,
> +};
> +
> +module_i2c_driver(tps2480_driver);
> +
> +MODULE_AUTHOR("Hadrien Copponnex <hadrien.copponnex@appeartv.com>");
> +MODULE_DESCRIPTION("I2C/SMBus Driver for TI TPS2480/TPS2481");
> +MODULE_LICENSE("GPL");


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
