From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 May 2015 23:30:47 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: added new hwmon driver for TI TPS2480/TPS2481
Message-Id: <5568F6A7.1060602@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5568693C.4010602@appeartv.com>
In-Reply-To: <5568693C.4010602@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hadrien,

On 05/29/2015 06:27 AM, Hadrien Copponnex wrote:
> Hi Guenter (and the lm-sensors team),
>
> First of all, thank you for your time and your valuable feedback. I have rewritten most of the driver code in order to follow the guidelines you gave me in your last mail.
>
Please try to wrap your emails to 80 columns or a bit less.
Also, please follow Documentation/SubmittingPatches
for the patch description and how to report versions.
As it is, if I were to apply your patch, the entire e-mail
would appear in the patch log which I am sure is neither
intended nor useful.

> Here is the list of the main changes since last version:
>
>     - added Documentation file
>     - fixed Kconfig to enable REGMAP_I2C
>     - fixed typo in many places
>     - cleaned and reordered include files
>     - now uses regmap with cache to read/write register values
>     - removed locking as regmap takes care of it
>     - driver now configures chip in its default configuration
>        * proved to be the best for current monitoring
>     - better compliance with the sysfs ABI (better abstraction)
>        * exports only standard variables with standard units
>        * removed raw register access through sysfs
>     - gets configuration (shunt resistance)
>        * from platform data or device tree
>
> I still have some remarks though, and would like to have your opinion on them.
>
>     - Regarding resetting the chip, you said:
>
>  > If really needed, this would probably leave the chip unconfigured.
>  > Is this what you want ? Also, are you sure this is needed ?
>  > It is quite unusual, and may result in a system reset.
>  > If that is the idea, it would be better to register a restart handler.
>  > See register_restart_handler() / unregister_restart_handler().
>
>        It is actually not needed, but from my point of view, when the
> driver is probed, I would like to put the chip in a 'known' configuration, which happens to be the default one. Therefore, I set the reset bit which gives me the configuration I want (cf. page 44).
>        Of course, I could simply set the configuration register with the desired values, and I would get the same result, but I was thinking that resetting the chip was a more clean solution.
>        What do you think ?
>
In this case it may result in a power loss, so I don't think it is
a good idea to reset the chip. Also, it is not as if the chip has
hundreds of configuration registers.

>     - Regarding Current/Power/Calibration measurements, you said:
>
>  > Per the datasheets, the shunt voltage must include the programmed gain.
>  > Current and power depend on the calibration values, so you'll have to
>  > do some complex calculations to convert the raw values into mA and uW.
>
>        I have refactored the way the driver works in order to provide better abstraction. The driver reports voltage in 'inX' variables, current in 'currX', etc, so the ABI is respected.
>        Many of the parameters like PGA, BADC, SADC are actually of no interest for us. For instance, the reported shunt voltage depends on the programmed gain, but this only affects the saturation of the result, not the precision (LSB) which is fixed at 10uV steps. And, if you have the chip in the default configuration, all of those parameters are set to the 'best' values.
>        The same happens for current and power readings which are dependent on the calibration. The driver performs itself the current/power computation as it only needs the shunt resistance (provided in platform data/device tree). So, we don't need to wait for the chip to convert the values for us.
>
Reporting power as voltage * current is not the idea with such a driver.
If you can not report power directly, don't do it, and let user space
do the calculation. It is not as if we have to "wait" for the chip
to do the calculation. The whole point here is that the chip may report
a different value as power than the simple multiplication (for example
if it does some averaging). We would want to see the resulting number.

>     - Regarding the alarm bit, you said:
>
>  > the bus voltage has an alarm bit, so you could provide in0_alarm.
>
>        I couldn't find anything in the chip documentation regarding alarms. The only thing I found was about SMBus alerts, but I have no idea when they are triggered and how to report them.
>        Isn't it the I2C bus driver taking care of that ?
>

I meant the OVR bit, which could be used to report a power alarm.
Not sure if it is that useful, though.

> To apply the patch on the latest kernel, simply type (assuming
> filename <patch>):
> git apply --check <patch>
>
> To use the driver, enable the option "SENSORS_TPS2480", in your kernel
> configuration file. I2C/SMBus support is required in your kernel. The

We don't really need that information.

> code has been written in an architecture-independent way, but have
> only been tested on PowerPC architecture (big-endian) with a 3.14 kernel.
> Please let me know any feedback you have on this patch v2.
>
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
>
> diff --git a/Documentation/hwmon/tps2480 b/Documentation/hwmon/tps2480
> new file mode 100644
> index 0000000..c4ca686
> --- /dev/null
> +++ b/Documentation/hwmon/tps2480
> @@ -0,0 +1,65 @@
> +Kernel driver tps2480
> +==========> +
> +Supported chips:
> +  * Texas Instruments TPS2480 / TPS2481
> +    Prefixes: 'tps2480'/'tps2481'
> +    Datasheet: Covers both chips
> +               http://www.ti.com/lit/ds/symlink/tps2480.pdf
> +
> +Author: Hadrien Copponnex <hadrien.copponnex@appeartv.com>
> +
> +Description
> +-----------
> +
> +The chips are hot-swap controllers and I2C current monitors.
> +
> +As a hardware monitoring driver, only the current monitor functionality is
> +of interest.
> +
Why is voltage and power monitoring not of interest ?

> +There are no differences between the two chips from the monitoring
> +point of view. They differ only by the automatic restart feature implemented
> +in the TPS2481 when a fault occurs.
> +
> +The driver exports 4 variables through the standard hwmon/sysfs mechanism.
> +
> +  - in0: Bus Voltage [mV]
> +  - in1: Shunt Voltage [mV]
> +  - curr1: Shunt Current [mA]
> +  - power1: Power [uW]
> +
> +Upon driver instantiation, a reset is performed to put the chip in its default
> +state. No programming of the chip is necessary to use it as a simple shunt monitor
> +(cf. page 36 paragraph 4). The configurable parameters provide different
> +conversion/averaging/saturation computations, but the default ones provide the
> +best results.
> +
> +Current and power registers are not used as the equivalent data is computed by
> +the driver itself. This does not reduce precision but provide less hassle as
> +otherwise the calibration register would need to be configured and more complex
> +computations would have to be done.

I don't think I like that :-(.

> +
> +Configuration
> +-------------
> +
> +The driver needs to know what is the shunt resistance used to measure the current.
> +This information is mandatory and the driver will fail if not reported.
> +
> +It can be provided using platform data or using the device tree.
> +
> +For device tree, insert a property called 'shunt' with an unsigned
> +integer representing the value in milliohms.
> +
> +Here is an example of a DTS file snippet declaring the chip for a 30 mOhms shunt:
> +
> +  ...
> +  tps2480@40  {
> +    compatible = "tps2480";
> +    reg = <0x40>;
> +    shunt = <30>;

Please use "shunt-resistor".

Devicetree configuration needs to be described in
Documentation/devicetree/bindings/hwmon/tps2480, and must be submitted to the
devicetree mailing list.

> +  };
> +  ...
> +
> +For platform data, fill the tps2480_platform_data structure defined in
> +linux/i2c/tps2480.h. It contains a unique element where shunt can be set.
> +
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 25d9e72..60d0d50 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1504,6 +1504,17 @@ config SENSORS_TMP421
>         This driver can also be built as a module.  If so, the module
>         will be called tmp421.
>
> +config SENSORS_TPS2480
> +    tristate "Texas Instruments TPS2480/2481 (EXPERIMENTAL)"
> +    depends on I2C
> +    select REGMAP_I2C
> +    help
> +      If you say yes here you get support for Texas Instruments TPS2480
> +      and TPS2481 I2C current monitors.
> +
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
> index 0000000..1dd0a9d
> --- /dev/null
> +++ b/drivers/hwmon/tps2480.c
> @@ -0,0 +1,356 @@
> +/*
> + * Hardware monitoring driver for TI TPS2480 / TPS2481
> + *
> + * Copyright (c) 2014-2015 AppearTV AS
> + *
> + * Parts of this file are based from:
> + *    ads1015.c (platform data/of config reading)
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
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/i2c/tps2480.h>
> +
> +#define TPS2480_REG_CONFIG        0x00 /* R/W */
> +#define TPS2480_REG_SHUNT_VOLTAGE 0x01 /* R   */
> +#define TPS2480_REG_BUS_VOLTAGE   0x02 /* R   */
> +#define TPS2480_REG_POWER         0x03 /* R   */
> +#define TPS2480_REG_CURRENT       0x04 /* R   */
> +#define TPS2480_REG_CALIBRATION   0x05 /* R/W */
> +#define TPS2480_MAX_REGISTERS     6
> +
> +enum tps2480_chips {
> +    tps2480,
> +    tps2481,
> +};
> +
> +struct tps2480_data {
> +    struct regmap  *regmap;
> +    int             shunt;
> +} tps2480_data;
> +
> +static bool is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +    return reg < TPS2480_MAX_REGISTERS;
> +}
> +
Not necessary; registers are by default readable.

> +static bool is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +    switch (reg) {
> +    case TPS2480_REG_CONFIG:
> +    case TPS2480_REG_CALIBRATION:
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static bool is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +    switch (reg) {
> +    case TPS2480_REG_SHUNT_VOLTAGE:
> +    case TPS2480_REG_BUS_VOLTAGE:
> +    case TPS2480_REG_POWER:
> +    case TPS2480_REG_CURRENT:
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static const struct reg_default tps2480_reg_defaults[] = {
> +    {TPS2480_REG_CONFIG, 0x399f},
> +    {TPS2480_REG_POWER, 0x0000},
> +    {TPS2480_REG_CURRENT, 0x0000},
> +    {TPS2480_REG_CALIBRATION, 0x0000},

I don't think you need to specify the read-only registers here.

Actually, you never call regmap_sync, so specifying reg_defaults
is unnecessary anyway (and you overwrite TPS2480_REG_CONFIG
anyway with a completely different value).

> +};
> +
> +static const struct regmap_config tps2480_regmap_config = {
> +    .reg_bits = 8,
> +    .val_bits = 16,
> +    .writeable_reg = is_writeable_reg,
> +    .readable_reg = is_readable_reg,
> +    .volatile_reg = is_volatile_reg,
> +    .max_register = TPS2480_MAX_REGISTERS,
> +    .reg_defaults = tps2480_reg_defaults,
> +    .num_reg_defaults = 4,
> +    .cache_type = REGCACHE_FLAT,
> +};
> +
> +/*
> + * Helper functions
> + */
> +
> +static struct tps2480_data *get_data(struct device *dev)
> +{
> +    return i2c_get_clientdata(to_i2c_client(dev));
> +}

Unnecessary shim function. i2c_get_clientdata() is wrong anyway;
it should be dev_get_drvdata().

> +
> +static int init_chip(struct tps2480_data *data)
> +{
> +    return regmap_write(data->regmap, TPS2480_REG_CONFIG, 1 << 15);
> +}
> +
> +static int extract_bus_voltage(unsigned int value)

Please use reg_to_bus_voltage().

> +{
> +    return (int)(value >> 3);
> +}
> +
> +static int extract_shunt_voltage(unsigned int value)

Please use reg_to_shunt_voltage().

> +{
> +    return (int)((s16)value);
> +}
> +
> +/*
> + * Sysfs callbacks
> + */
> +
> +static ssize_t show_in0(struct device *dev, struct device_attribute *attr, char
> +*buf)
> +{
> +    /* Read bus voltage */
> +    unsigned int value;
> +    int signed_value;
> +    int err = regmap_read(get_data(dev)->regmap,
> +        TPS2480_REG_BUS_VOLTAGE,
> +        &value);
> +    if (err)
> +        return err;
> +
> +    /* Step size is 4mV */
> +    signed_value = extract_bus_voltage(value) * 4;

Why * 4 here and not in the extract_ function ?

> +
> +    return snprintf(buf, PAGE_SIZE, "%d\n", signed_value);
> +}
> +
> +static ssize_t show_in1(struct device *dev, struct device_attribute *attr,
> +char *buf)

Is that bad indentation or a line wrap ?

> +{
> +    /* Read shunt voltage */
> +    unsigned int value;
> +    int signed_value;
> +    int err = regmap_read(get_data(dev)->regmap,
> +        TPS2480_REG_SHUNT_VOLTAGE,
> +        &value);

Please split the out of the variable declaration. It is a bit much and just makes
the code less readable. Same for other cases where you do the same.
Also, just use a local variable for

> +    if (err)
> +        return err;
> +
> +    /* Step size is 10uV */
> +    signed_value = extract_shunt_voltage(value) / 100;
> +
> +    return snprintf(buf, PAGE_SIZE, "%d\n", signed_value);
> +}
> +
> +static ssize_t show_curr1(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    /* Measured current is computed by dividing the shunt voltage by
> +     * the shunt resistance.
> +     */
> +
> +    /* Read shunt voltage */
> +    unsigned int value;
> +    int signed_value;
> +    struct tps2480_data *data = get_data(dev);
> +    int err = regmap_read(data->regmap, TPS2480_REG_SHUNT_VOLTAGE, &value);
> +
> +    if (err)
> +        return err;
> +
> +    /* Shunt voltage has 10uV step
> +     * Shunt resistance has 1 mOhm step
> +     */
> +    signed_value = extract_shunt_voltage(value) * 10 / data->shunt;

I really don't like this. Why not program the calibration register accordingly
so it returns what you are looking for ?

> +
> +    return snprintf(buf, PAGE_SIZE, "%d\n", signed_value);
> +}
> +
> +static ssize_t show_power1(struct device *dev, struct device_attribute *attr,
> +char *buf)
> +{
> +    /* Measured power is computed by multiplying the bus voltage by
> +     * the current passing through the shunt resistor.
> +     *
> +     * V = bus voltage
> +     * U = shunt voltage
> +     * R = shunt resistance
> +     * I = shunt current
> +     *
> +     * Power = V * I = V * (U/R)
> +     */

/*
  * Please use standard symmetric multi-line comments.
  */

> +
> +    /* Read bus & shunt voltage */
> +    unsigned int value;
> +    int signed_value;
> +    int bus_voltage;
> +    int shunt_voltage;
> +    int err;
> +    struct tps2480_data *data = get_data(dev);

You can just use dev_get_drvdata().

Please order variables by length if possible.

> +
> +    err = regmap_read(data->regmap, TPS2480_REG_BUS_VOLTAGE, &value);
> +    if (err)
> +        return err;
> +
> +    bus_voltage = extract_bus_voltage(value);
> +
> +    err = regmap_read(data->regmap, TPS2480_REG_SHUNT_VOLTAGE, &value);
> +    if (err)
> +        return err;

Same here. I think you should just program the calibration and read
the value from the power register.

Is that really that difficult ?

Otherwise we could just declare a fixed shunt resistor value of, say,
10 mOhm and let user space handle the calculations.

> +
> +    shunt_voltage = extract_shunt_voltage(value);
> +
> +    /* Bus voltage has 4mV step
> +     * Shunt voltage has 10uV step
> +     * Shunt resistance has 1 mOhm step
> +     */
> +    signed_value = (bus_voltage * shunt_voltage * 40) / data->shunt;
> +
> +    return snprintf(buf, PAGE_SIZE, "%d\n", signed_value);
> +}
> +
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in1, NULL, 1);
> +static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, show_curr1, NULL, 1);
> +static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, show_power1, NULL, 1);
> +
> +static struct attribute *tps2480_attrs[] = {
> +    &sensor_dev_attr_in0_input.dev_attr.attr,
> +    &sensor_dev_attr_in1_input.dev_attr.attr,
> +    &sensor_dev_attr_curr1_input.dev_attr.attr,
> +    &sensor_dev_attr_power1_input.dev_attr.attr,
> +    NULL,
> +};
> +
> +static struct attribute_group tps2480_attr_grp = {
> +    .attrs = tps2480_attrs,
> +};
> +
> +static const struct attribute_group *tps2480_attr_grps[] = {
> +    &tps2480_attr_grp,
> +    NULL,
> +};
> +
> +/*
> + * Driver interface functions
> + */
> +
> +#ifdef CONFIG_OF
> +static int tps2480_read_config_of(struct i2c_client *client,
> +    struct tps2480_data *data)
> +{
> +    int err;
> +    unsigned int value;
> +
> +    if (!client->dev.of_node) {
> +        dev_err(&client->dev, "cannot find of node");
> +        return -EINVAL;
> +    }
> +
> +    err = of_property_read_u32(client->dev.of_node, "shunt", &value);

Should be

	if (err)
		return err;

or only assign value if there is no error. Otherwise shunt would be
random, which is undesirable even if we abort due to the error anyway.

> +    data->shunt = (int)value;
> +
> +    return err;
> +}
> +#endif

Please provide an #else case with a shim function here
to avoid the #ifdefs in the code below.

> +
> +static int tps2480_read_config(struct i2c_client *client,
> +    struct tps2480_data *data)

Please use checkpatch --strict and fix the indentations. Also please fix all
the whitespace errors reported with checkpatch.

Checkpatch also reports that the patch is corrupted due to a line wrap.

> +{
> +    struct tps2480_platform_data *pdata = dev_get_platdata(&client->dev);
> +#ifdef CONFIG_OF
> +    int err;
> +#endif
> +
> +    if (pdata) {
> +        data->shunt = (int)pdata->shunt;

Defining the platform data as unsigned int but using an int
internally doesn't make much sense to me. Any special reason for
storing shunt as int ?

> +        return 0;
> +    }
> +
> +#ifdef CONFIG_OF
> +    err = tps2480_read_config_of(client, data);
> +    if (err)
> +        return err;
> +#endif
> +    return 0;
> +}
> +
> +static int tps2480_probe(struct i2c_client *client,
> +    const struct i2c_device_id *id)
> +{
> +    struct tps2480_data *data;
> +    struct device *hwmon_dev;
> +    int err;
> +
> +    data = devm_kzalloc(&client->dev,
> +                        sizeof(struct tps2480_data),
> +                        GFP_KERNEL);
> +    if (!data)
> +        return -ENOMEM;
> +
> +    i2c_set_clientdata(client, data);

Not needed. Use dev_get_drvdata() instead of i2c_get_clientdata().

> +
> +    err = tps2480_read_config(client, data);
> +    if (err)
> +        return err;
> +
> +    /* Check that shunt is != 0. */
> +    if (data->shunt = 0) {

FWIW, I can configure shunt as 0xffffffff which will cause it to be -1
since you store it as int.

> +        dev_err(&client->dev, "shunt cannot be 0");
> +        return -EINVAL;
> +    }
> +
> +    /* Initialize the register map which accesses the chip registers. */
> +    data->regmap = devm_regmap_init_i2c(client, &tps2480_regmap_config);
> +    if (IS_ERR(data->regmap))
> +        return PTR_ERR(data->regmap);
> +
> +    /* Initialize the chip to its default configuration. */
> +    err = init_chip(data);
> +    if (err)
> +        return err;
> +
> +    /* Registers the device to appear in sysfs. */
> +    hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +        client->name,
> +        data,
> +        tps2480_attr_grps);
> +
> +    return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id tps2480_id[] = {
> +    {"tps2480", tps2480},
> +    {"tps2481", tps2481},
> +    {},
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
> +    .id_table = tps2480_id,
> +};
> +
> +module_i2c_driver(tps2480_driver);
> +
> +MODULE_AUTHOR("Hadrien Copponnex <hadrien.copponnex@appeartv.com>");
> +MODULE_DESCRIPTION("I2C/SMBus Driver for TI TPS2480/TPS2481");
> +MODULE_LICENSE("GPL");
> +

whitespace error

> diff --git a/include/linux/i2c/tps2480.h b/include/linux/i2c/tps2480.h
> new file mode 100644
> index 0000000..be1c4a7
> --- /dev/null
> +++ b/include/linux/i2c/tps2480.h
> @@ -0,0 +1,27 @@
> +/*
> + * Platform Data for TI TPS2480 / TPS2481
> + *
> + * Copyright (c) 2014-2015 AppearTV AS
> + *
> + * Hadrien Copponnex <hadrien.copponnex@appeartv.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef LINUX_TPS2480_H
> +#define LINUX_TPS2480_H
> +
> +struct tps2480_platform_data {
> +    unsigned int shunt;

Please provide a comment describing the expected units (milli-ohm ?
micro-ohm ?). Shunt resistors can be fractions of milli-ohm, so it
may be a good idea to use micro-ohm.

> +};
> +
> +#endif /* LINUX_TPS2480_H */
> +

No empty line at the end, please (whitespace error).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
