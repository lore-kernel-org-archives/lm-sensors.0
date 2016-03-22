From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 22 Mar 2016 14:11:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (max31722) Add support for MAX31722/MAX31723 temperature sensors
Message-Id: <56F152A6.6000903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1458646865-6416-2-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1458646865-6416-2-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/22/2016 04:41 AM, Tiberiu Breana wrote:
> Add basic support for the Maxim Integrated MAX31722/MAX31723 SPI
> temperature sensors / thermostats.
>
> Includes:
>      - ACPI support;
>      - raw temperature readings;
>      - power management
>
> Datasheet:
> https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
>
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> ---
>   Documentation/hwmon/max31722 |  34 +++++
>   drivers/hwmon/Kconfig        |  11 ++
>   drivers/hwmon/Makefile       |   1 +
>   drivers/hwmon/max31722.c     | 304 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 350 insertions(+)
>   create mode 100644 Documentation/hwmon/max31722
>   create mode 100644 drivers/hwmon/max31722.c
>
> diff --git a/Documentation/hwmon/max31722 b/Documentation/hwmon/max31722
> new file mode 100644
> index 0000000..090da845
> --- /dev/null
> +++ b/Documentation/hwmon/max31722
> @@ -0,0 +1,34 @@
> +Kernel driver max31722
> +===========
> +
> +Supported chips:
> +  * Maxim Integrated MAX31722
> +    Prefix: 'max31722'
> +    ACPI ID: MAX31722
> +    Addresses scanned: -
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
> +  * Maxim Integrated MAX31723
> +    Prefix: 'max31723'
> +    ACPI ID: MAX31723
> +    Addresses scanned: -
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
> +
> +Author: Tiberiu Breana <tiberiu.a.breana@intel.com>
> +
> +Description
> +-----------
> +
> +This driver adds support for the Maxim Integrated MAX31722/MAX31723 thermometers
> +and thermostats running over an SPI interface.
> +
> +Usage Notes
> +-----------
> +
> +This driver uses ACPI to auto-detect devices. See ACPI IDs in the above section.
> +
> +Sysfs entries
> +-------------
> +
> +The following attribute is supported:
> +
> +temp1_input		Measured temperature. Read-only.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5c2d13a..714be75 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -821,6 +821,17 @@ config SENSORS_MAX197
>   	  This driver can also be built as a module. If so, the module
>   	  will be called max197.
>
> +config SENSORS_MAX31722
> +tristate "MAX31722 temperature sensor"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	  Support for the Maxim Integrated MAX31722/MAX31723 digital
> +	  thermometers/thermostats operating over an SPI interface.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called max31722.
> +
>   config SENSORS_MAX6639
>   	tristate "Maxim MAX6639 sensor chip"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 58cc3ac..2ef5b7c 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -112,6 +112,7 @@ obj-$(CONFIG_SENSORS_MAX16065)	+= max16065.o
>   obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
>   obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
>   obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
> +obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
>   obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
>   obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
>   obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
> diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
> new file mode 100644
> index 0000000..13ba906
> --- /dev/null
> +++ b/drivers/hwmon/max31722.c
> @@ -0,0 +1,304 @@
> +/*
> + * max31722 - hwmon driver for Maxim Integrated MAX31722/MAX31723 SPI
> + * digital thermometer and thermostats.
> + *
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License. See the file COPYING in the main
> + * directory of this archive for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#define MAX31722_REG_CFG				0x00
> +#define MAX31722_REG_TEMP_LSB				0x01
> +#define MAX31722_REG_TEMP_MSB				0x02
> +#define MAX31722_MAX_REG				0x86
> +
> +#define MAX31722_MODE_CONTINUOUS			0x00
> +#define MAX31722_MODE_STANDBY				0x01
> +#define MAX31722_RESOLUTION_11BIT			0x02
> +
> +#define MAX31722_REGMAP_NAME				"max31722_regmap"
> +
> +#define MAX31722_REGFIELD(name)						    \
> +	do {								    \
> +		data->reg_##name =					    \
> +			devm_regmap_field_alloc(&spi->dev, regmap,	    \
> +				max31722_reg_field_##name);		    \
> +		if (IS_ERR(data->reg_##name)) {				    \
> +			dev_err(&spi->dev, "reg field alloc failed.\n");    \
> +			return PTR_ERR(data->reg_##name);		    \
> +		}							    \
> +	} while (0)
> +
> +struct max31722_data {
> +	struct spi_device *spi_device;
> +	struct device *hwmon_dev;
> +	struct regmap *regmap;
> +	struct regmap_field *reg_state;
> +	struct regmap_field *reg_resolution;
> +};
> +
> +/*
> + * This is a negative exponent value lookup table (as millidegree units)
> + * for calculating LSB values. The value corresponding to the fourth LSB
> + * bit is missing, as it is not used.
> + */
> +static const int max31722_milli_table[3] = {
> +	500, 250, 125
> +};
> +
> +static const struct reg_field max31722_reg_field_state > +				REG_FIELD(MAX31722_REG_CFG, 0, 0);
> +static const struct reg_field max31722_reg_field_resolution > +				REG_FIELD(MAX31722_REG_CFG, 1, 2);
> +
> +static bool max31722_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MAX31722_REG_TEMP_LSB:
> +	case MAX31722_REG_TEMP_MSB:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool max31722_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MAX31722_REG_TEMP_LSB:
> +	case MAX31722_REG_TEMP_MSB:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static struct regmap_config max31722_regmap_config = {
> +	.name = MAX31722_REGMAP_NAME,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = MAX31722_MAX_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.volatile_reg = max31722_is_volatile_reg,
> +	.writeable_reg = max31722_is_writeable_reg,
> +
> +	.read_flag_mask = 0x00,
> +	.write_flag_mask = 0x80,
> +};
> +
> +static int max31722_set_mode(struct max31722_data *data, u8 mode)
> +{
> +	int ret;
> +	struct spi_device *spi = data->spi_device;
> +
> +	ret = regmap_field_write(data->reg_state, mode);
> +	if (ret < 0)
> +		dev_err(&spi->dev, "failed to set sensor mode.\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t max31722_show_name(struct device *dev,
> +				  struct device_attribute *devattr,
> +				  char *buf)
> +{
> +	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
> +}
> +
> +static ssize_t max31722_show_temperature(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int i;
> +	int ret;
> +	u8 lsb;
> +	s16 val;
> +	u16 temp;
> +	struct max31722_data *data = dev_get_drvdata(dev);
> +
> +	ret = regmap_bulk_read(data->regmap, MAX31722_REG_TEMP_LSB, &temp, 2);
> +	if (ret < 0) {
> +		dev_err(&data->spi_device->dev,
> +			"failed to read temperature register\n");

Please no error log on data reads. It can easily cause the kernel log
to fill up if there is a problem with the chip.

> +		return ret;
> +	}
> +	/*
> +	 * The MSB contains the integer part of the temperature value
> +	 * (signed), while the LSB contains the fractional part as
> +	 * negative powers of 2, e.g.: bit 0 is 2^-1, bit 1 is 2^-2, etc.
> +	 * Temperature is exported in millidegrees Celsius.
> +	 */
> +	val = (temp >> 8) * 1000;
> +	lsb = (temp << 8) >> 13; /* We only need the first 3 LSB bits. */
> +	i = 0;
> +	while (i < 3) {
> +		if ((lsb >> (3 - i - 1)) & 0x01)
> +			val += max31722_milli_table[i];
> +		i++;
> +	}
> +
Why not just the following ?

	val = ((s16)le16_to_cpu(temp) >> 5) * 125;

You need le16_to_cpu() since temp is in little endian format.

> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, max31722_show_name, NULL);

Note that the name attribute is provided by the hwmon core if you use
[devm_]hwmon_device_register_with_groups().

> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
> +			  max31722_show_temperature, NULL, 0);
> +
> +static struct attribute *max31722_attributes[] = {
> +	&dev_attr_name.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max31722_group = {
> +	.attrs = max31722_attributes,
> +};
> +
> +static int max31722_init(struct max31722_data *data)
> +{
> +	int ret = 0;

Unnecessary variable initialization.

> +	struct spi_device *spi = data->spi_device;
> +	struct regmap *regmap;
> +
> +	/* Initialize the regmap */
> +	regmap = devm_regmap_init_spi(spi, &max31722_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "regmap initialization failed.\n");
> +		return PTR_ERR(regmap);
> +	}
> +	data->regmap = regmap;
> +
> +	MAX31722_REGFIELD(state);
> +	MAX31722_REGFIELD(resolution);

Please code this explicitly instead of using function macros.

> +
> +	/* Set SD bit to 0 so we can have continuous measurements. */
> +	ret = regmap_field_write(data->reg_state, MAX31722_MODE_CONTINUOUS);
> +	if (ret < 0)
> +		goto err;
> +	/*
> +	 * Set resolution to 11 bits (3 decimals) so we can have the maximum
> +	 * precision in the exported millidegree range.

With 12 bit resolution, the step size is 62.5 milli-degrees C, so using
it would increase the accuracy in the exported range. Are you concerned
about the loss of the 0.5 milli-degrees C which would not be reportable,
or about the higher conversion time ? Please update the explanation accordingly.
Or drop the explanation entirely.

Note that you could use the update_interval attribute to make the conversion
rate (and thus the accuracy) user configurable.

> +	 */
> +	ret = regmap_field_write(data->reg_resolution,
> +				 MAX31722_RESOLUTION_11BIT);

I wonder if regmap_field_write() really adds value. You end up writing
the same register twice.

> +	if (ret < 0)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	dev_err(&spi->dev, "sensor configuration failed.\n");
> +	return ret;
> +}
> +
> +static int max31722_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct max31722_data *data;
> +
> +	data = devm_kzalloc(&spi->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, data);
> +	data->spi_device = spi;

The only use of spi_device is in max31722_init(), so you might was well
pass it as parameter and drop the variable from the data structure.
> +
> +	ret = max31722_init(data);
> +	if (ret < 0)
> +		goto err_standby;
> +
> +	ret = sysfs_create_group(&spi->dev.kobj, &max31722_group);
> +	if (ret < 0)
> +		goto err_standby;
> +
> +	data->hwmon_dev = hwmon_device_register(&spi->dev);

Please use hwmon_device_register_with_groups().

> +	if (IS_ERR(data->hwmon_dev)) {
> +		ret = PTR_ERR(data->hwmon_dev);
> +		goto err_remove_group;
> +	}
> +
> +	return 0;
> +
> +err_remove_group:
> +	sysfs_remove_group(&spi->dev.kobj, &max31722_group);
> +err_standby:
> +	max31722_set_mode(data, MAX31722_MODE_STANDBY);
> +	return ret;
> +}
> +
> +static int max31722_remove(struct spi_device *spi)
> +{
> +	struct max31722_data *data = spi_get_drvdata(spi);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&spi->dev.kobj, &max31722_group);
> +
> +	return max31722_set_mode(data, MAX31722_MODE_STANDBY);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int max31722_suspend(struct device *dev)
> +{
> +	struct spi_device *spi_device = to_spi_device(dev);
> +	struct max31722_data *data = spi_get_drvdata(spi_device);
> +
> +	return max31722_set_mode(data, MAX31722_MODE_STANDBY);
> +}
> +
> +static int max31722_resume(struct device *dev)
> +{
> +	struct spi_device *spi_device = to_spi_device(dev);
> +	struct max31722_data *data = spi_get_drvdata(spi_device);
> +
> +	return max31722_set_mode(data, MAX31722_MODE_CONTINUOUS);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max31722_pm_ops, max31722_suspend, max31722_resume);
> +
> +#define MAX31722_PM_OPS (&max31722_pm_ops)
> +#else
> +#define MAX31722_PM_OPS NULL
> +#endif
> +
> +static const struct spi_device_id max31722_spi_id[] = {
> +	{"max31722", 0},
> +	{"max31723", 0},
> +	{}
> +};
> +
> +static const struct acpi_device_id max31722_acpi_id[] = {
> +	{"MAX31722", 0},
> +	{"MAX31723", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, max31722_spi_id);
> +
> +static struct spi_driver max31722_driver = {
> +	.driver = {
> +		.name = "max31722",
> +		.pm = MAX31722_PM_OPS,
> +		.acpi_match_table = ACPI_PTR(max31722_acpi_id),
> +	},
> +	.probe =            max31722_probe,
> +	.remove =           max31722_remove,
> +	.id_table =         max31722_spi_id,
> +};
> +
> +module_spi_driver(max31722_driver);
> +
> +MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
> +MODULE_DESCRIPTION("max31722 sensor driver");
> +MODULE_LICENSE("GPL v2");
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
