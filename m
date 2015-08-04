From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Aug 2015 21:39:17 +0000
Subject: Re: [lm-sensors] [PATCH v2 08/10] hwmon: Support registration of thermal zones for SCP temperature s
Message-Id: <55C13105.9070509@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com> <1438615378-14241-9-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1438615378-14241-9-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Jean Delvare <jdelvare@suse.de>, Eduardo Valentin <edubezval@gmail.com>

On 08/03/2015 08:22 AM, Punit Agrawal wrote:
> Add support to create thermal zones based on the temperature sensors
> provided by the SCP. The thermal zones can be defined using the
> thermal DT bindings and should refer to the SCP sensor id to select
> the sensor.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Eduardo Valentin <edubezval@gmail.com>

Hi,

assuming you fix up the nitpicks below,

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/scpi-hwmon.c | 103 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 7e7e06b..d96a3e5 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -20,6 +20,7 @@
>   #include <linux/scpi_protocol.h>
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
> +#include <linux/thermal.h>
>
>   struct sensor_data {
>   	struct scpi_sensor_info info;
> @@ -29,14 +30,39 @@ struct sensor_data {
>   	char label[20];
>   };
>
> +struct scpi_thermal_zone {
> +	struct list_head list;
> +	int sensor_id;
> +	struct scpi_sensors *scpi_sensors;
> +	struct thermal_zone_device *tzd;
> +};
> +
>   struct scpi_sensors {
>   	struct scpi_ops *scpi_ops;
>   	struct sensor_data *data;
> +	struct list_head thermal_zones;
>   	struct attribute **attrs;
>   	struct attribute_group group;
>   	const struct attribute_group *groups[2];
>   };
>
> +static int scpi_read_temp(void *dev, long *temp)
> +{
> +	struct scpi_thermal_zone *zone = dev;
> +	struct scpi_sensors *scpi_sensors = zone->scpi_sensors;
> +	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
> +	struct sensor_data *sensor = &scpi_sensors->data[zone->sensor_id];
> +	u32 value;
> +	int ret;
> +
> +	ret = scpi_ops->sensor_get_value(sensor->info.sensor_id, &value);
> +	if (ret)
> +		return ret;
> +
> +	*temp = value;
> +	return 0;
> +}
> +
>   /* hwmon callback functions */
>   static ssize_t
>   scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
> @@ -66,6 +92,24 @@ scpi_show_label(struct device *dev, struct device_attribute *attr, char *buf)
>   	return sprintf(buf, "%s\n", sensor->info.name);
>   }
>
> +static void
> +unregister_thermal_zones(struct platform_device *pdev,
> +			 struct scpi_sensors *scpi_sensors)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, &scpi_sensors->thermal_zones) {
> +		struct scpi_thermal_zone *zone;
> +
> +		zone = list_entry(pos, struct scpi_thermal_zone, list);
> +		thermal_zone_of_sensor_unregister(&pdev->dev, zone->tzd);
> +	}
> +}
> +
> +static struct thermal_zone_of_device_ops scpi_sensor_ops = {
> +	.get_temp = scpi_read_temp,
> +};
> +
>   static int scpi_hwmon_probe(struct platform_device *pdev)
>   {
>   	u16 nr_sensors, i;
> @@ -157,10 +201,66 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   	scpi_sensors->group.attrs = scpi_sensors->attrs;
>   	scpi_sensors->groups[0] = &scpi_sensors->group;
>
> +	platform_set_drvdata(pdev, scpi_sensors);
> +
>   	hwdev = devm_hwmon_device_register_with_groups(dev,
>   			"scpi_sensors", scpi_sensors, scpi_sensors->groups);
>
> -	return PTR_ERR_OR_ZERO(hwdev);
> +	if (IS_ERR(hwdev))
> +		return PTR_ERR(hwdev);
> +
> +	/*
> +	 * Register the temperature sensors with the thermal framework
> +	 * to allow their usage in setting up the thermal zones from
> +	 * device tree.
> +	 *
> +	 * NOTE: Not all temperature sensors maybe used for thermal
> +	 * control
> +	 */
> +	INIT_LIST_HEAD(&scpi_sensors->thermal_zones);
> +	for (i = 0; i < nr_sensors; i++) {
> +		struct sensor_data *sensor = &scpi_sensors->data[i];
> +		struct scpi_thermal_zone *zone;
> +
> +		if (sensor->info.class != TEMPERATURE)
> +			continue;
> +
> +		zone = devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);

			devm_kzalloc(dev, ...);

for consistency.

> +		if (!zone) {
> +			ret = -ENOMEM;
> +			goto unregister_tzd;
> +		}
> +
> +		zone->sensor_id = i;
> +		zone->scpi_sensors = scpi_sensors;
> +		zone->tzd = thermal_zone_of_sensor_register(dev, i, zone,
> +							    &scpi_sensor_ops);
> +		/*
> +		 * The call to thermal_zone_of_sensor_register returns
> +		 * an error for sensors that are not associated with
> +		 * any thermal zones.

... or if the thermal subsystem is not configured.

> +		 */
> +		if (IS_ERR(zone->tzd)) {
> +			devm_kfree(dev, zone);
> +			continue;
> +		}
> +		list_add(&zone->list, &scpi_sensors->thermal_zones);
> +	}
> +
> +	return 0;
> +
> +unregister_tzd:
> +	unregister_thermal_zones(pdev, scpi_sensors);
> +	return ret;
> +}
> +
> +static int scpi_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct scpi_sensors *scpi_sensors = platform_get_drvdata(pdev);
> +
> +	unregister_thermal_zones(pdev, scpi_sensors);
> +
> +	return 0;
>   }
>
>   static const struct of_device_id scpi_of_match[] = {
> @@ -175,6 +275,7 @@ static struct platform_driver scpi_hwmon_platdrv = {
>   		.of_match_table = scpi_of_match,
>   	},
>   	.probe		= scpi_hwmon_probe,
> +	.remove		= scpi_hwmon_remove,
>   };
>   module_platform_driver(scpi_hwmon_platdrv);
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
