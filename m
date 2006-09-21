From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 21:01:21 +0000
Subject: [lm-sensors] [PATCH] VT8231 driver with device_create_file()
Message-Id: <20060921230121.10157030.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060921182901.A183C12EE1@bluewhale.planbit.co.uk>
In-Reply-To: <20060921182901.A183C12EE1@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

Thanks for the quick reaction :)

First of all, your e-mail client appears to convert tabs to spaces, so
I couldn't apply this patch. Please try as an attachement next time.

> This patches the VT8231 driver to check the return status
> from device_create_file() and also use the newer and cleaner sysfs
> creation functions.
> 
> It works on my Via EPIA board with its VT8231.  I haven't been able
> to make it break to test all the cleanup paths, however, but
> they match the coding constructs on other drivers so they should be OK.

> --- linux-2.6.18/drivers/hwmon/vt8231.c.ref     2006-09-21 17:54:04.000000000 +0100
> +++ linux-2.6.18/drivers/hwmon/vt8231.c 2006-09-21 19:13:05.000000000 +0100
> @@ -36,6 +36,7 @@
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> +#include <linux/platform_device.h>
>  #include <asm/io.h>

You don't actually need this, I guess these are the remnants on a
different patch?

> 
>  static int force_addr;
> @@ -451,37 +452,6 @@
>  define_temperature_sysfs(5);
>  define_temperature_sysfs(6);
> 
> -#define CFG_INFO_TEMP(id)      { &sensor_dev_attr_temp##id##_input.dev_attr, \
> -                               &sensor_dev_attr_temp##id##_max_hyst.dev_attr, \
> -                               &sensor_dev_attr_temp##id##_max.dev_attr }
> -#define CFG_INFO_VOLT(id)      { &sensor_dev_attr_in##id##_input.dev_attr, \
> -                               &sensor_dev_attr_in##id##_min.dev_attr, \
> -                               &sensor_dev_attr_in##id##_max.dev_attr }
> -
> -struct str_device_attr_table {
> -       struct device_attribute *input;
> -       struct device_attribute *min;
> -       struct device_attribute *max;
> -};
> -
> -static struct str_device_attr_table cfg_info_temp[] = {
> -       { &dev_attr_temp1_input, &dev_attr_temp1_max_hyst, &dev_attr_temp1_max },
> -       CFG_INFO_TEMP(2),
> -       CFG_INFO_TEMP(3),
> -       CFG_INFO_TEMP(4),
> -       CFG_INFO_TEMP(5),
> -       CFG_INFO_TEMP(6)
> -};
> -
> -static struct str_device_attr_table cfg_info_volt[] = {
> -       CFG_INFO_VOLT(0),
> -       CFG_INFO_VOLT(1),
> -       CFG_INFO_VOLT(2),
> -       CFG_INFO_VOLT(3),
> -       CFG_INFO_VOLT(4),
> -       { &dev_attr_in5_input, &dev_attr_in5_min, &dev_attr_in5_max }
> -};
> -
>  /* Fans */
>  static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
>                 char *buf)
> @@ -585,6 +555,108 @@
> 
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> 
> +static struct attribute *vt8231_attributes_temps[6][4] = {
> +       {
> +               &dev_attr_temp1_input.attr,
> +               &dev_attr_temp1_max_hyst.attr,
> +               &dev_attr_temp1_max.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp2_input.dev_attr.attr,
> +               &sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
> +               &sensor_dev_attr_temp2_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp3_input.dev_attr.attr,
> +               &sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
> +               &sensor_dev_attr_temp3_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp4_input.dev_attr.attr,
> +               &sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
> +               &sensor_dev_attr_temp4_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp5_input.dev_attr.attr,
> +               &sensor_dev_attr_temp5_max_hyst.dev_attr.attr,
> +               &sensor_dev_attr_temp5_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp6_input.dev_attr.attr,
> +               &sensor_dev_attr_temp6_max_hyst.dev_attr.attr,
> +               &sensor_dev_attr_temp6_max.dev_attr.attr,
> +               NULL
> +       }
> +};
> +
> +static const struct attribute_group vt8231_group_temps[6] = {
> +       { .attrs = vt8231_attributes_temps[0] },
> +       { .attrs = vt8231_attributes_temps[1] },
> +       { .attrs = vt8231_attributes_temps[2] },
> +       { .attrs = vt8231_attributes_temps[3] },
> +       { .attrs = vt8231_attributes_temps[4] },
> +       { .attrs = vt8231_attributes_temps[5] }

Missing trailing comma.

> +};
> +
> +

One too many blank line.

> +static struct attribute *vt8231_attributes_volts[6][4] = {
> +       {
> +               &sensor_dev_attr_in0_input.dev_attr.attr,
> +               &sensor_dev_attr_in0_min.dev_attr.attr,
> +               &sensor_dev_attr_in0_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_in1_input.dev_attr.attr,
> +               &sensor_dev_attr_in1_min.dev_attr.attr,
> +               &sensor_dev_attr_in1_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_in2_input.dev_attr.attr,
> +               &sensor_dev_attr_in2_min.dev_attr.attr,
> +               &sensor_dev_attr_in2_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_in3_input.dev_attr.attr,
> +               &sensor_dev_attr_in3_min.dev_attr.attr,
> +               &sensor_dev_attr_in3_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_in4_input.dev_attr.attr,
> +               &sensor_dev_attr_in4_min.dev_attr.attr,
> +               &sensor_dev_attr_in4_max.dev_attr.attr,
> +               NULL
> +       }, {
> +               &dev_attr_in5_input.attr,
> +               &dev_attr_in5_min.attr,
> +               &dev_attr_in5_max.attr,
> +               NULL
> +       }
> +};
> +
> +static const struct attribute_group vt8231_group_volts[6] = {
> +       { .attrs = vt8231_attributes_volts[0] },
> +       { .attrs = vt8231_attributes_volts[1] },
> +       { .attrs = vt8231_attributes_volts[2] },
> +       { .attrs = vt8231_attributes_volts[3] },
> +       { .attrs = vt8231_attributes_volts[4] },
> +       { .attrs = vt8231_attributes_volts[5] }
> +};

Missing comma.

> +
> +static struct attribute *vt8231_attributes[] = {
> +       &sensor_dev_attr_fan1_input.dev_attr.attr,
> +       &sensor_dev_attr_fan2_input.dev_attr.attr,
> +       &sensor_dev_attr_fan1_min.dev_attr.attr,
> +       &sensor_dev_attr_fan2_min.dev_attr.attr,
> +       &sensor_dev_attr_fan1_div.dev_attr.attr,
> +       &sensor_dev_attr_fan2_div.dev_attr.attr,
> +       &dev_attr_alarms.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group vt8231_group = {
> +       .attrs = vt8231_attributes,
> +};
> +
>  static struct i2c_driver vt8231_driver = {
>         .driver = {
>                 .name   = "vt8231",
> @@ -669,47 +741,46 @@
> 
>         vt8231_init_client(client);
> 
> -       /* Register sysfs hooks */

You could leave this comment here, it still applies.

> -       data->class_dev = hwmon_device_register(&client->dev);
> -       if (IS_ERR(data->class_dev)) {
> -               err = PTR_ERR(data->class_dev);
> +       if ((err = sysfs_create_group(&client->dev.kobj, &vt8231_group)))
>                 goto exit_detach;
> -       }
> 
>         /* Must update device information to find out the config field */
>         data->uch_config = vt8231_read_value(client, VT8231_REG_UCH_CONFIG);
> 
> -       for (i = 0; i < ARRAY_SIZE(cfg_info_temp); i++) {
> +       for (i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++) {
>                 if (ISTEMP(i, data->uch_config)) {
> -                       device_create_file(&client->dev,
> -                                          cfg_info_temp[i].input);
> -                       device_create_file(&client->dev, cfg_info_temp[i].max);
> -                       device_create_file(&client->dev, cfg_info_temp[i].min);
> +                       if ((err = sysfs_create_group(&client->dev.kobj, &vt8231_group_temps[i])))
> +                               goto exit_remove_files;

Line too long. Either split it over two lines, or use the following
trick:

       for (i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++) {
               if (!ISTEMP(i, data->uch_config))
                       continue;
               if ((err = sysfs_create_group(&client->dev.kobj, &vt8231_group_temps[i])))
                       goto exit_remove_files;
       }

It may fit then (or maybe not.)


>                 }
>         }
> 
> -       for (i = 0; i < ARRAY_SIZE(cfg_info_volt); i++) {
> +       for (i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++) {
>                 if (ISVOLT(i, data->uch_config)) {
> -                       device_create_file(&client->dev,
> -                                          cfg_info_volt[i].input);
> -                       device_create_file(&client->dev, cfg_info_volt[i].max);
> -                       device_create_file(&client->dev, cfg_info_volt[i].min);
> +                       if ((err = sysfs_create_group(&client->dev.kobj, &vt8231_group_volts[i])))
> +                               goto exit_remove_files;

Ditto.

>                 }
>         }
> 
> -       device_create_file(&client->dev, &sensor_dev_attr_fan1_input.dev_attr);
> -       device_create_file(&client->dev, &sensor_dev_attr_fan2_input.dev_attr);
> -       device_create_file(&client->dev, &sensor_dev_attr_fan1_min.dev_attr);
> -       device_create_file(&client->dev, &sensor_dev_attr_fan2_min.dev_attr);
> -       device_create_file(&client->dev, &sensor_dev_attr_fan1_div.dev_attr);
> -       device_create_file(&client->dev, &sensor_dev_attr_fan2_div.dev_attr);
> -
> -       device_create_file(&client->dev, &dev_attr_alarms);
> +       /* Register sysfs hooks */
> +       data->class_dev = hwmon_device_register(&client->dev);
> +       if (IS_ERR(data->class_dev)) {
> +               err = PTR_ERR(data->class_dev);
> +               goto exit_remove_files;
> +       }
>         return 0;
> 
> +exit_remove_files:
> +       for(i=0; i<ARRAY_SIZE(vt8231_group_volts); i++)
> +               sysfs_remove_group(&client->dev.kobj, &vt8231_group_volts[i]);
> +
> +       for(i=0; i<ARRAY_SIZE(vt8231_group_temps); i++)
> +               sysfs_remove_group(&client->dev.kobj, &vt8231_group_temps[i]);

Coding style: space between "for" and "(", spaces around "=", spaces
around "<".

> +
> +       sysfs_remove_group(&client->dev.kobj, &vt8231_group);
>  exit_detach:
>         i2c_detach_client(client);
>  exit_free:
> +       platform_set_drvdata(client, NULL);

This too looks like a change for a different patch - this isn't a
platform driver yet.

>         kfree(data);
>  exit_release:
>         release_region(isa_address, VT8231_EXTENT);

You forgot to delete the files in vt8231_detach_client().

Otherwise I'm quite happy with your patch, I wouldn't have done
better :) Care to respin a patch fixing the above issues, and attach it
so that it doesn't get corrupted?

Thanks,
-- 
Jean Delvare

