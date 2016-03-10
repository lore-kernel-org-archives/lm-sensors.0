From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 10 Mar 2016 02:29:17 +0000
Subject: Re: [lm-sensors] [PATCH 04/13] hwmon: convert scpi-hwmon to use devm_thermal_zone_of_sensor_register
Message-Id: <56E0DBFD.7060903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-5-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-5-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>

On 03/09/2016 01:35 PM, Eduardo Valentin wrote:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>   drivers/hwmon/scpi-hwmon.c | 41 ++++++++---------------------------------
>   1 file changed, 8 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 7e20567..2309e47 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -31,10 +31,8 @@ struct sensor_data {
>   };
>
>   struct scpi_thermal_zone {
> -	struct list_head list;
>   	int sensor_id;
>   	struct scpi_sensors *scpi_sensors;
> -	struct thermal_zone_device *tzd;
>   };
>
>   struct scpi_sensors {
> @@ -92,20 +90,6 @@ scpi_show_label(struct device *dev, struct device_attribute *attr, char *buf)
>   	return sprintf(buf, "%s\n", sensor->info.name);
>   }
>
> -static void
> -unregister_thermal_zones(struct platform_device *pdev,
> -			 struct scpi_sensors *scpi_sensors)
> -{
> -	struct list_head *pos;
> -
> -	list_for_each(pos, &scpi_sensors->thermal_zones) {
> -		struct scpi_thermal_zone *zone;
> -
> -		zone = list_entry(pos, struct scpi_thermal_zone, list);
> -		thermal_zone_of_sensor_unregister(&pdev->dev, zone->tzd);
> -	}
> -}
> -
>   static struct thermal_zone_of_device_ops scpi_sensor_ops = {
>   	.get_temp = scpi_read_temp,
>   };
> @@ -224,6 +208,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&scpi_sensors->thermal_zones);
>   	for (i = 0; i < nr_sensors; i++) {
>   		struct sensor_data *sensor = &scpi_sensors->data[i];
> +		struct thermal_zone_device *z;
>   		struct scpi_thermal_zone *zone;
>
>   		if (sensor->info.class != TEMPERATURE)
> @@ -232,42 +217,33 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   		zone = devm_kzalloc(dev, sizeof(*zone), GFP_KERNEL);
>   		if (!zone) {
>   			ret = -ENOMEM;
> -			goto unregister_tzd;
> +			goto mfail;

			return -ENOMEM;

... and drop the unnecessary label.

Thanks,
Guenter

>   		}
>
>   		zone->sensor_id = i;
>   		zone->scpi_sensors = scpi_sensors;
> -		zone->tzd = thermal_zone_of_sensor_register(dev,
> -				sensor->info.sensor_id, zone, &scpi_sensor_ops);
> +		z = devm_thermal_zone_of_sensor_register(dev,
> +							 sensor->info.sensor_id,
> +							 zone,
> +							 &scpi_sensor_ops);
>   		/*
>   		 * The call to thermal_zone_of_sensor_register returns
>   		 * an error for sensors that are not associated with
>   		 * any thermal zones or if the thermal subsystem is
>   		 * not configured.
>   		 */
> -		if (IS_ERR(zone->tzd)) {
> +		if (IS_ERR(z)) {
>   			devm_kfree(dev, zone);
>   			continue;
>   		}
> -		list_add(&zone->list, &scpi_sensors->thermal_zones);
>   	}
>
>   	return 0;
>
> -unregister_tzd:
> -	unregister_thermal_zones(pdev, scpi_sensors);
> +mfail:
>   	return ret;
>   }
>
> -static int scpi_hwmon_remove(struct platform_device *pdev)
> -{
> -	struct scpi_sensors *scpi_sensors = platform_get_drvdata(pdev);
> -
> -	unregister_thermal_zones(pdev, scpi_sensors);
> -
> -	return 0;
> -}
> -
>   static const struct of_device_id scpi_of_match[] = {
>   	{.compatible = "arm,scpi-sensors"},
>   	{},
> @@ -280,7 +256,6 @@ static struct platform_driver scpi_hwmon_platdrv = {
>   		.of_match_table = scpi_of_match,
>   	},
>   	.probe		= scpi_hwmon_probe,
> -	.remove		= scpi_hwmon_remove,
>   };
>   module_platform_driver(scpi_hwmon_platdrv);
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
