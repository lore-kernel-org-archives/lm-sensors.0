From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 10 Feb 2008 06:31:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1619) Add individual alarm and
Message-Id: <191fb4ca0802092231h6fb02a79peb388e0e51e74987@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106152759.64209d42@hyperion.delvare>
In-Reply-To: <20080106152759.64209d42@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good and compiles cleanly.

Acked-by: Juerg Haefliger <juergh at gmail.com>


> The new libsensors needs these individual alarm and fault files.
>
> Signed-off-by: Jean Delvare <khali at linux-fr.org>
> ---
> Alexey, would you have the opportunity to test this patch?
>
>   drivers/hwmon/max1619.c |   17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> --- linux-2.6.24-rc6.orig/drivers/hwmon/max1619.c       2007-12-20
> 12:37:39.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/max1619.c    2008-01-01
> 10:36:17.000000000 +0100
> @@ -32,6 +32,7 @@
>   #include <linux/jiffies.h>
>   #include <linux/i2c.h>
>   #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/mutex.h>
>   #include <linux/sysfs.h>
> @@ -161,6 +162,14 @@ static ssize_t show_alarms(struct device
>         return sprintf(buf, "%d\n", data->alarms);
>   }
>
> +static ssize_t show_alarm(struct device *dev, struct device_attribute
> *attr,
> +                         char *buf)
> +{
> +       int bitnr = to_sensor_dev_attr(attr)->index;
> +       struct max1619_data *data = max1619_update_device(dev);
> +       return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
> +}
> +
>   static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
>   static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
>   static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_low2,
> @@ -172,6 +181,10 @@ static DEVICE_ATTR(temp2_crit, S_IWUSR |
>   static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst2,
>         set_temp_hyst2);
>   static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
>
>   static struct attribute *max1619_attributes[] = {
>         &dev_attr_temp1_input.attr,
> @@ -182,6 +195,10 @@ static struct attribute *max1619_attribu
>         &dev_attr_temp2_crit_hyst.attr,
>
>         &dev_attr_alarms.attr,
> +       &sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp2_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
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
