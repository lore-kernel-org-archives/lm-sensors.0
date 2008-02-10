From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 10 Feb 2008 06:51:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smsc47m1) Add individual alarm
Message-Id: <191fb4ca0802092251i3c6e6178xbbda7708cb0ce615@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106153613.1ebf3e1a@hyperion.delvare>
In-Reply-To: <20080106153613.1ebf3e1a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good - assuming the bit positions are correct, which I can't
fully verify without a datasheet - and compiles cleanly.

Acked-by: Juerg Haefliger <juergh at gmail.com>


> The new libsensors needs these individual alarm files.
>
> Signed-off-by: Jean Delvare <khali at linux-fr.org>
> ---
> Anyone with an SMSC LPC47M1xx-compatible chip that could test this
> patch? Hartmut maybe?
>
>   drivers/hwmon/smsc47m1.c |   25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
>
> --- linux-2.6.24-rc6.orig/drivers/hwmon/smsc47m1.c      2007-12-26
> 14:39:06.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/smsc47m1.c   2008-01-01
> 12:40:11.000000000 +0100
> @@ -198,6 +198,14 @@ static ssize_t get_fan_div(struct device
>         return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
>   }
>
> +static ssize_t get_fan_alarm(struct device *dev, struct device_attribute
> +                            *devattr, char *buf)
> +{
> +       int bitnr = to_sensor_dev_attr(devattr)->index;
> +       struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
> +       return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
> +}
> +
>   static ssize_t get_pwm(struct device *dev, struct device_attribute
>                        *devattr, char *buf)
>   {
> @@ -347,6 +355,8 @@ static SENSOR_DEVICE_ATTR(fan##offset##_
>                 get_fan_min, set_fan_min, offset - 1);                  \
>   static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,               \
>                 get_fan_div, set_fan_div, offset - 1);                  \
> +static SENSOR_DEVICE_ATTR(fan##offset##_alarm, S_IRUGO, get_fan_alarm, \
> +               NULL, offset - 1);                                      \
>   static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,             \
>                 get_pwm, set_pwm, offset - 1);                          \
>   static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,    \
> @@ -374,12 +384,15 @@ static struct attribute *smsc47m1_attrib
>         &sensor_dev_attr_fan1_input.dev_attr.attr,
>         &sensor_dev_attr_fan1_min.dev_attr.attr,
>         &sensor_dev_attr_fan1_div.dev_attr.attr,
> +       &sensor_dev_attr_fan1_alarm.dev_attr.attr,
>         &sensor_dev_attr_fan2_input.dev_attr.attr,
>         &sensor_dev_attr_fan2_min.dev_attr.attr,
>         &sensor_dev_attr_fan2_div.dev_attr.attr,
> +       &sensor_dev_attr_fan2_alarm.dev_attr.attr,
>         &sensor_dev_attr_fan3_input.dev_attr.attr,
>         &sensor_dev_attr_fan3_min.dev_attr.attr,
>         &sensor_dev_attr_fan3_div.dev_attr.attr,
> +       &sensor_dev_attr_fan3_alarm.dev_attr.attr,
>
>         &sensor_dev_attr_pwm1.dev_attr.attr,
>         &sensor_dev_attr_pwm1_enable.dev_attr.attr,
> @@ -533,7 +546,9 @@ static int __devinit smsc47m1_probe(stru
>                  || (err = device_create_file(dev,
>                                 &sensor_dev_attr_fan1_min.dev_attr))
>                  || (err = device_create_file(dev,
> -                               &sensor_dev_attr_fan1_div.dev_attr)))
> +                               &sensor_dev_attr_fan1_div.dev_attr))
> +                || (err = device_create_file(dev,
> +                               &sensor_dev_attr_fan1_alarm.dev_attr)))
>                         goto error_remove_files;
>         } else
>                 dev_dbg(dev, "Fan 1 not enabled by hardware, skipping\n");
> @@ -544,7 +559,9 @@ static int __devinit smsc47m1_probe(stru
>                  || (err = device_create_file(dev,
>                                 &sensor_dev_attr_fan2_min.dev_attr))
>                  || (err = device_create_file(dev,
> -                               &sensor_dev_attr_fan2_div.dev_attr)))
> +                               &sensor_dev_attr_fan2_div.dev_attr))
> +                || (err = device_create_file(dev,
> +                               &sensor_dev_attr_fan2_alarm.dev_attr)))
>                         goto error_remove_files;
>         } else
>                 dev_dbg(dev, "Fan 2 not enabled by hardware, skipping\n");
> @@ -555,7 +572,9 @@ static int __devinit smsc47m1_probe(stru
>                  || (err = device_create_file(dev,
>                                 &sensor_dev_attr_fan3_min.dev_attr))
>                  || (err = device_create_file(dev,
> -                               &sensor_dev_attr_fan3_div.dev_attr)))
> +                               &sensor_dev_attr_fan3_div.dev_attr))
> +                || (err = device_create_file(dev,
> +                               &sensor_dev_attr_fan3_alarm.dev_attr)))
>                         goto error_remove_files;
>         } else if (data->type = smsc47m2)
>                 dev_dbg(dev, "Fan 3 not enabled by hardware, skipping\n");
>
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
