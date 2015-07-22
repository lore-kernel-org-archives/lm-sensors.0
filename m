From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jul 2015 15:58:57 +0000
Subject: Re: [lm-sensors] [PATCH 7/9] hwmon: Support registration of thermal zones for SCP temperature sensor
Message-Id: <55AFBDC1.3000604@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com> <1437573763-6525-8-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1437573763-6525-8-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Eduardo Valentin <edubezval@gmail.com>

On 07/22/2015 07:02 AM, Punit Agrawal wrote:
> Add support to create thermal zones based on the temperature sensors
> provided by the SCP. The thermal zones can be defined using the
> thermal DT bindings and should refer to the SCP sensor id to select
> the sensor.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> ---
>   drivers/hwmon/scpi-hwmon.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index dd0a6f1..1e52ced 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -22,6 +22,7 @@
>   #include <linux/scpi_protocol.h>
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
> +#include <linux/thermal.h>
>
>   static struct scpi_ops *scpi_ops;
>
> @@ -33,12 +34,18 @@ struct sensor_dev {
>   	char label[20];
>   };
>
> +struct scpi_thermal_zone {
> +	struct list_head list;
> +	struct thermal_zone_device *tzd;
> +};
> +
>   struct scpi_sensors {
>   	int num_volt;
>   	int num_temp;
>   	int num_current;
>   	int num_power;
>   	struct sensor_dev *device;
> +	struct list_head thermal_zones;
>   	struct device *hwdev;
>   };
>   struct scpi_sensors scpi_sensors;
> @@ -54,6 +61,20 @@ static int scpi_read_sensor(struct sensor_dev *sensor, u32 *value)
>   	return 0;
>   }
>
> +static int scpi_read_temp(void *dev, long *temp)
> +{
> +	struct sensor_dev *sensor = dev;
> +	u32 value;
> +	int ret;
> +
> +	ret = scpi_read_sensor(sensor, &value);
> +	if (ret)
> +		return ret;
> +
> +	*temp = value;
> +	return 0;
> +}
> +
>   /* hwmon callback functions */
>   static ssize_t
>   scpi_hwmon_show_sensor(struct device *dev,
> @@ -90,6 +111,10 @@ struct attribute *scpi_attrs[24] = { 0 };
>   struct attribute_group scpi_group;
>   const struct attribute_group *scpi_groups[2] = { 0 };
>
> +struct thermal_zone_of_device_ops scpi_sensor_ops = {

static struct ...

> +	.get_temp = scpi_read_temp,
> +};
> +
>   static int scpi_hwmon_probe(struct platform_device *pdev)
>   {
>   	u16 sensors, i;
> @@ -108,9 +133,12 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   	if (!scpi_sensors.device)
>   		return -ENOMEM;
>
> +	INIT_LIST_HEAD(&scpi_sensors.thermal_zones);
> +
>   	dev_info(&pdev->dev, "Found %d sensors\n", sensors);
>   	for (i = 0; i < sensors; i++) {
>   		struct sensor_dev *dev = &scpi_sensors.device[i];
> +		struct scpi_thermal_zone *zone;
>
>   		ret = scpi_ops->sensor_get_info(i, &dev->info);
>   		if (ret) {
> @@ -130,6 +158,20 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   			snprintf(dev->label, 20,
>   				 "temp%d_label", scpi_sensors.num_temp);
>   			scpi_sensors.num_temp++;
> +
> +			zone = devm_kmalloc(&pdev->dev, sizeof(*zone),
> +					    GFP_KERNEL);

Please consider using devm_kzalloc().

> +			if (!zone)
> +				return -ENOMEM;
> +
> +			zone->tzd = thermal_zone_of_sensor_register(&pdev->dev,
> +						    i, dev, &scpi_sensor_ops);
> +			if (!IS_ERR(zone->tzd))
> +				list_add(&zone->list,
> +					 &scpi_sensors.thermal_zones);
> +			else
> +				devm_kfree(&pdev->dev, zone);
> +

I would prefer

			if (IS_ERR_OR_NULL(zone->tzd)) {
				devm_kfree(&pdev->dev, zone);
				break;
			}
			list_add(&zone->list, &scpi_sensors.thermal_zones);

The code has a problem, though: You don't clean up thermal zones if
there is an error later on in the probe function. Either you need to
implement a cleanup function to be called from an error handler (and
from the remove function), or you need to wait with registering
thermal zones to the very end of the probe function.

Note that thermal_zone_of_sensor_register can return NULL if thermal
zones are not configured, so you have to use IS_ERR_OR_NULL
when checking for errors.

>   			break;
>   		case VOLTAGE:
>   			snprintf(dev->input, 20,
> @@ -187,7 +229,18 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>
>   static int scpi_hwmon_remove(struct platform_device *pdev)
>   {
> +	struct list_head *pos;
> +
>   	scpi_ops = NULL;
> +
> +	list_for_each(pos, &scpi_sensors.thermal_zones) {
> +		struct scpi_thermal_zone *zone;
> +
> +		zone = list_entry(pos, struct scpi_thermal_zone, list);
> +		thermal_zone_of_sensor_unregister(scpi_sensors.hwdev,

Not sure how this can work. The registration was with &pdev->dev,
not with hwdev. What happens if you actually unload this driver ?

> +						  zone->tzd);
> +	}
> +
>   	return 0;
>   }
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
