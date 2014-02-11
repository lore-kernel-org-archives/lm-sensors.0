From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Feb 2014 20:57:46 +0000
Subject: Re: [lm-sensors] [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <201402112157.46774.arnd@arndb.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com> <1392138636-29240-10-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1392138636-29240-10-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

On Tuesday 11 February 2014, Pawel Moll wrote:
> -#define VEXPRESS_HWMON_ATTRS(_name, _label_attr, _input_attr)  \
> -struct attribute *vexpress_hwmon_attrs_##_name[] = {           \
> -       &dev_attr_name.attr,                                    \
> -       &dev_attr_##_label_attr.attr,                           \
> -       &sensor_dev_attr_##_input_attr.dev_attr.attr,           \
> -       NULL                                                    \
> -}
> +#define VEXPRESS_HWMON_ATTR_GROUPS(_name, _label_attr, _input_attr)    \
> +static struct attribute *vexpress_hwmon_##_name##_attrs[] = {          \
> +       &dev_attr_##_label_attr.attr,                                   \
> +       &sensor_dev_attr_##_input_attr.dev_attr.attr,                   \
> +       NULL                                                            \
> +};                                                                     \
> +ATTRIBUTE_GROUPS(vexpress_hwmon_##_name)
>  
>  #if !defined(CONFIG_REGULATOR_VEXPRESS)
>  static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
>  static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
>                 NULL, 1000);
> -static VEXPRESS_HWMON_ATTRS(volt, in1_label, in1_input);
> -static struct attribute_group vexpress_hwmon_group_volt = {
> -       .attrs = vexpress_hwmon_attrs_volt,
> -};
> +VEXPRESS_HWMON_ATTR_GROUPS(volt, in1_label, in1_input);

Maybe it would be a good time to get rid of the obfuscation here and just
open-code the attribute groups rather than defining another macro.

I understand you want to save a few source lines, but it really helps
readability if you can search for the attribute groups when they
are referenced later. Just because the common driver model code uses
macros with string concatenation doesn't mean it's a good idea to
do the same in a device driver.

	Arnd

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
