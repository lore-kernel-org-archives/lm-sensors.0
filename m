From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 10 Feb 2008 06:56:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (via686a) Add individual alarm files
Message-Id: <191fb4ca0802092256n66c35e0cg4eb64176aa4f838f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154204.6abccc25@hyperion.delvare>
In-Reply-To: <20080106154204.6abccc25@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good - assuming the bit positions are correct, which I can't
verify without a datasheet - and compiles cleanly.

Acked-by: Juerg Haefliger <juergh at gmail.com>


> The new libsensors needs these individual alarm files.
>
> Signed-off-by: Jean Delvare <khali at linux-fr.org>
> ---
> Ian, would you have the opportunity to test this patch?
>
>   drivers/hwmon/via686a.c |   28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> --- linux-2.6.24-rc6.orig/drivers/hwmon/via686a.c       2008-01-01
> 14:16:22.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/via686a.c    2008-01-01
> 14:18:42.000000000 +0100
> @@ -533,6 +533,24 @@ static ssize_t show_alarms(struct device
>   }
>   static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>
> +static ssize_t show_alarm(struct device *dev, struct device_attribute
> *attr,
> +                         char *buf)
> +{
> +       int bitnr = to_sensor_dev_attr(attr)->index;
> +       struct via686a_data *data = via686a_update_device(dev);
> +       return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
> +}
> +static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
> +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 11);
> +static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 15);
> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
> +
>   static ssize_t show_name(struct device *dev, struct device_attribute
>                          *devattr, char *buf)
>   {
> @@ -557,6 +575,11 @@ static struct attribute *via686a_attribu
>         &sensor_dev_attr_in2_max.dev_attr.attr,
>         &sensor_dev_attr_in3_max.dev_attr.attr,
>         &sensor_dev_attr_in4_max.dev_attr.attr,
> +       &sensor_dev_attr_in0_alarm.dev_attr.attr,
> +       &sensor_dev_attr_in1_alarm.dev_attr.attr,
> +       &sensor_dev_attr_in2_alarm.dev_attr.attr,
> +       &sensor_dev_attr_in3_alarm.dev_attr.attr,
> +       &sensor_dev_attr_in4_alarm.dev_attr.attr,
>
>         &sensor_dev_attr_temp1_input.dev_attr.attr,
>         &sensor_dev_attr_temp2_input.dev_attr.attr,
> @@ -567,6 +590,9 @@ static struct attribute *via686a_attribu
>         &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>         &sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
>         &sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
> +       &sensor_dev_attr_temp1_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp2_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp3_alarm.dev_attr.attr,
>
>         &sensor_dev_attr_fan1_input.dev_attr.attr,
>         &sensor_dev_attr_fan2_input.dev_attr.attr,
> @@ -574,6 +600,8 @@ static struct attribute *via686a_attribu
>         &sensor_dev_attr_fan2_min.dev_attr.attr,
>         &sensor_dev_attr_fan1_div.dev_attr.attr,
>         &sensor_dev_attr_fan2_div.dev_attr.attr,
> +       &sensor_dev_attr_fan1_alarm.dev_attr.attr,
> +       &sensor_dev_attr_fan2_alarm.dev_attr.attr,
>
>         &dev_attr_alarms.attr,
>         &dev_attr_name.attr,
>
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
