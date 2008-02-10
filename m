From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 10 Feb 2008 06:16:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm92) Add individual alarm files
Message-Id: <191fb4ca0802092216j6aa8a0d8q4b423981ae1a2a2d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106152552.3ce76bba@hyperion.delvare>
In-Reply-To: <20080106152552.3ce76bba@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good and compiles cleanly.

Acked-by: Juerg Haefliger <juergh at gmail.com>


> The new libsensors needs these individual alarm files.
>
> Signed-off-by: Jean Delvare <khali at linux-fr.org>
> ---
> James, would you have the opportunity to test this patch?
>
>   drivers/hwmon/lm92.c |   16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> --- linux-2.6.24-rc6.orig/drivers/hwmon/lm92.c  2007-12-26
> 14:39:06.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/lm92.c       2007-12-31 16:37:17.000000000
> +0100
> @@ -45,6 +45,7 @@
>   #include <linux/slab.h>
>   #include <linux/i2c.h>
>   #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/mutex.h>
>
> @@ -209,6 +210,14 @@ static ssize_t show_alarms(struct device
>         return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp1_input));
>   }
>
> +static ssize_t show_alarm(struct device *dev, struct device_attribute
> *attr,
> +                         char *buf)
> +{
> +       int bitnr = to_sensor_dev_attr(attr)->index;
> +       struct lm92_data *data = lm92_update_device(dev);
> +       return sprintf(buf, "%d\n", (data->temp1_input >> bitnr) & 1);
> +}
> +
>   static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1_input, NULL);
>   static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp1_crit,
>         set_temp1_crit);
> @@ -221,6 +230,9 @@ static DEVICE_ATTR(temp1_max, S_IWUSR |
>         set_temp1_max);
>   static DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp1_max_hyst, NULL);
>   static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
>
>
>   /*
> @@ -297,7 +309,9 @@ static struct attribute *lm92_attributes
>         &dev_attr_temp1_max.attr,
>         &dev_attr_temp1_max_hyst.attr,
>         &dev_attr_alarms.attr,
> -
> +       &sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>         NULL
>   };
>
>
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
