From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Aug 2015 21:32:10 +0000
Subject: Re: [lm-sensors] [PATCH v2 07/10] hwmon: Support sensors exported via ARM SCP interface
Message-Id: <55C12F5A.5080705@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com> <1438615378-14241-8-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1438615378-14241-8-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Jean Delvare <jdelvare@suse.de>, Sudeep Holla <sudeep.holla@arm.com>

On 08/03/2015 08:22 AM, Punit Agrawal wrote:
> Create a driver to add support for SoC sensors exported by the System
> Control Processor (SCP) via the System Control and Power Interface
> (SCPI). The supported sensor types is one of voltage, temperature,
> current, and power.
>
> The sensor labels and values provided by the SCP are exported via the
> hwmon sysfs interface.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Looks good for the most part. Single comment below.
Assuming you fix it up, feel free to add

Acked-by: Guenter Roeck <linux@roeck-us.net>

for v3.

Thanks,
Guenter

> ---
>   Documentation/hwmon/scpi-hwmon |  33 ++++++++
>   drivers/hwmon/Kconfig          |   8 ++
>   drivers/hwmon/Makefile         |   1 +
>   drivers/hwmon/scpi-hwmon.c     | 183 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 225 insertions(+)
>   create mode 100644 Documentation/hwmon/scpi-hwmon
>   create mode 100644 drivers/hwmon/scpi-hwmon.c
>
> diff --git a/Documentation/hwmon/scpi-hwmon b/Documentation/hwmon/scpi-hwmon
> new file mode 100644
> index 0000000..4cfcdf2d
> --- /dev/null
> +++ b/Documentation/hwmon/scpi-hwmon
> @@ -0,0 +1,33 @@
> +Kernel driver scpi-hwmon
> +============
> +
> +Supported chips:
> + * Chips based on ARM System Control Processor Interface
> +   Addresses scanned: -
> +   Datasheet: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/index.html
> +
> +Author: Punit Agrawal <punit.agrawal@arm.com>
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for SoC's based on the ARM
> +System Control Processor (SCP) implementing the System Control
> +Processor Interface (SCPI). The following sensor types are supported
> +by the SCP -
> +
> +  * temperature
> +  * voltage
> +  * current
> +  * power
> +
> +The SCP interface provides an API to query the available sensors and
> +their values which are then exported to userspace by this driver.
> +
> +Usage Notes
> +-----------
> +
> +The driver relies on device tree node to indicate the presence of SCPI
> +support in the kernel. See
> +Documentation/devicetree/bindings/arm/arm,scpi.txt for details of the
> +devicetree node.
> \ No newline at end of file
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4943c3c..c9714b0 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1551,6 +1551,14 @@ config SENSORS_VEXPRESS
>   	  the ARM Ltd's Versatile Express platform. It can provide wide
>   	  range of information like temperature, power, energy.
>
> +config SENSORS_ARM_SCPI
> +	tristate "ARM SCPI Sensors"
> +	depends on ARM_SCPI_PROTOCOL
> +	help
> +	  This driver provides support for temperature, voltage, current
> +	  and power sensors available on ARM Ltd's SCP based platforms. The
> +	  actual number and type of sensors exported depend the platform.
> +
>   config SENSORS_VIA_CPUTEMP
>   	tristate "VIA CPU temperature sensor"
>   	depends on X86
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8aba87f..4961710 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -150,6 +150,7 @@ obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
>   obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
>   obj-$(CONFIG_SENSORS_V2M_JUNO)	+= v2m-juno.o
>   obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress.o
> +obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
>   obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
>   obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>   obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> new file mode 100644
> index 0000000..7e7e06b
> --- /dev/null
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -0,0 +1,183 @@
> +/*
> + * System Control and Power Interface(SCPI) based hwmon sensor driver
> + *
> + * Copyright (C) 2015 ARM Ltd.
> + * Punit Agrawal <punit.agrawal@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/scpi_protocol.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +struct sensor_data {
> +	struct scpi_sensor_info info;
> +	struct device_attribute dev_attr_input;
> +	struct device_attribute dev_attr_label;
> +	char input[20];
> +	char label[20];
> +};
> +
> +struct scpi_sensors {
> +	struct scpi_ops *scpi_ops;
> +	struct sensor_data *data;
> +	struct attribute **attrs;
> +	struct attribute_group group;
> +	const struct attribute_group *groups[2];
> +};
> +
> +/* hwmon callback functions */
> +static ssize_t
> +scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct scpi_sensors *scpi_sensors = dev_get_drvdata(dev);
> +	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
> +	struct sensor_data *sensor;
> +	u32 value;
> +	int ret;
> +
> +	sensor = container_of(attr, struct sensor_data, dev_attr_input);
> +
> +	ret = scpi_ops->sensor_get_value(sensor->info.sensor_id, &value);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", value);
> +}
> +
> +static ssize_t
> +scpi_show_label(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_data *sensor;
> +
> +	sensor = container_of(attr, struct sensor_data, dev_attr_label);
> +
> +	return sprintf(buf, "%s\n", sensor->info.name);
> +}
> +
> +static int scpi_hwmon_probe(struct platform_device *pdev)
> +{
> +	u16 nr_sensors, i;
> +	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
> +	struct scpi_ops *scpi_ops;
> +	struct device *hwdev, *dev = &pdev->dev;
> +	struct scpi_sensors *scpi_sensors;
> +	int ret;
> +
> +	scpi_ops = get_scpi_ops();
> +	if (!scpi_ops)
> +		return -EPROBE_DEFER;
> +
> +	ret = scpi_ops->sensor_get_capability(&nr_sensors);
> +	if (ret || !nr_sensors)
> +		return ret;
> +
This will return 0 if nr_sensors = 0. Should it be -ENODEV ?

> +	scpi_sensors = devm_kzalloc(dev, sizeof(*scpi_sensors), GFP_KERNEL);
> +	if (!scpi_sensors)
> +		return -ENOMEM;
> +
> +	scpi_sensors->data = devm_kcalloc(dev, nr_sensors,
> +				   sizeof(*scpi_sensors->data), GFP_KERNEL);
> +	if (!scpi_sensors->data)
> +		return -ENOMEM;
> +
> +	scpi_sensors->attrs = devm_kcalloc(dev, (nr_sensors * 2) + 1,
> +				   sizeof(*scpi_sensors->attrs), GFP_KERNEL);
> +	if (!scpi_sensors->attrs)
> +		return -ENOMEM;
> +
> +	scpi_sensors->scpi_ops = scpi_ops;
> +
> +	for (i = 0; i < nr_sensors; i++) {
> +		struct sensor_data *sensor = &scpi_sensors->data[i];
> +
> +		ret = scpi_ops->sensor_get_info(i, &sensor->info);
> +		if (ret)
> +			return ret;
> +
> +		switch (sensor->info.class) {
> +		case TEMPERATURE:
> +			snprintf(sensor->input, sizeof(sensor->input),
> +				 "temp%d_input", num_temp + 1);
> +			snprintf(sensor->label, sizeof(sensor->input),
> +				 "temp%d_label", num_temp + 1);
> +			num_temp++;
> +			break;
> +		case VOLTAGE:
> +			snprintf(sensor->input, sizeof(sensor->input),
> +				 "in%d_input", num_volt);
> +			snprintf(sensor->label, sizeof(sensor->input),
> +				 "in%d_label", num_volt);
> +			num_volt++;
> +			break;
> +		case CURRENT:
> +			snprintf(sensor->input, sizeof(sensor->input),
> +				 "curr%d_input", num_current + 1);
> +			snprintf(sensor->label, sizeof(sensor->input),
> +				 "curr%d_label", num_current + 1);
> +			num_current++;
> +			break;
> +		case POWER:
> +			snprintf(sensor->input, sizeof(sensor->input),
> +				 "power%d_input", num_power + 1);
> +			snprintf(sensor->label, sizeof(sensor->input),
> +				 "power%d_label", num_power + 1);
> +			num_power++;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		sensor->dev_attr_input.attr.mode = S_IRUGO;
> +		sensor->dev_attr_input.show = scpi_show_sensor;
> +		sensor->dev_attr_input.attr.name = sensor->input;
> +
> +		sensor->dev_attr_label.attr.mode = S_IRUGO;
> +		sensor->dev_attr_label.show = scpi_show_label;
> +		sensor->dev_attr_label.attr.name = sensor->label;
> +
> +		scpi_sensors->attrs[i << 1] = &sensor->dev_attr_input.attr;
> +		scpi_sensors->attrs[(i << 1) + 1] = &sensor->dev_attr_label.attr;
> +
> +		sysfs_attr_init(scpi_sensors->attrs[i << 1]);
> +		sysfs_attr_init(scpi_sensors->attrs[(i << 1) + 1]);
> +	}
> +
> +	scpi_sensors->group.attrs = scpi_sensors->attrs;
> +	scpi_sensors->groups[0] = &scpi_sensors->group;
> +
> +	hwdev = devm_hwmon_device_register_with_groups(dev,
> +			"scpi_sensors", scpi_sensors, scpi_sensors->groups);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static const struct of_device_id scpi_of_match[] = {
> +	{.compatible = "arm,scpi-sensors"},
> +	{},
> +};
> +
> +static struct platform_driver scpi_hwmon_platdrv = {
> +	.driver = {
> +		.name	= "scpi-hwmon",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = scpi_of_match,
> +	},
> +	.probe		= scpi_hwmon_probe,
> +};
> +module_platform_driver(scpi_hwmon_platdrv);
> +
> +MODULE_AUTHOR("Punit Agrawal <punit.agrawal@arm.com>");
> +MODULE_DESCRIPTION("ARM SCPI HWMON interface driver");
> +MODULE_LICENSE("GPL v2");
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
