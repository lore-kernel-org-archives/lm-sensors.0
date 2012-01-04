From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Jan 2012 22:07:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add new hwmon-core interface
Message-Id: <1325714834.2649.29.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323378601-6930-2-git-send-email-dev@lynxeye.de>
In-Reply-To: <1323378601-6930-2-git-send-email-dev@lynxeye.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-12-08 at 16:10 -0500, Lucas Stach wrote:
> This adds a new hwmon-core interface to centralize sysfs handling
> and enable cooperation with other in-kernel drivers.
> 
> v3:
> - checkpatch clean
> 
> v4:
> - more flexible interface to allow different capabilities for
>   every sensor and holes in sensor numbering
> - corrected a few oversights
> - split out vid and vrm handling as separate feature
> - support 2d attributes for trip point and treshold handling
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
[ ... ]

> +
> +       hw_dev_attr->sensor_dev.dev_attr.attr.mode = mode;
> +       if (mode && S_IRUGO) {
> +               if (type = value)
> +                       hw_dev_attr->sensor_dev.dev_attr.show = &get_num;
> +               else
> +                       hw_dev_attr->sensor_dev.dev_attr.show = &get_text;
> +       }
> +       if (mode && S_IWUGO)

This and "mode && SIRUGO" look wrong and don't make much sense. Guess
you mean & ?

[ ... ]

> +
> +struct hwmon_device_instance {
> +       struct hwmon_device_caps caps;
> +       int (*get_numeric_attr) (struct device *hw_device,
> +                       enum hwmon_feature feature, u32 subfeature, u8 index,
> +                       u8 nr, int *value);
> +       int (*set_numeric_attr) (struct device *hw_device,
> +                       enum hwmon_feature feature, u32 subfeature, u8 index,
> +                       u8 nr, int value);
> +       int (*get_text_attr) (struct device *hw_device,
> +                       enum hwmon_feature feature, u32 subfeature, u8 index,
> +                       char *buf);
> +       struct list_head sysfs_node;

Looks like sysfs_node is used internally by the core code, and not by
the driver. If so, it should not be exported.

Regarding inst_data, I think it would be better to keep the current
approach with a local data structure, and reference hwinst from it. So
you would have

	data->hw_inst = hw_inst;
	i2c_set_clientdata(client, data);
and
	data = i2c_get_clientdata(client);
	hw_inst = data->hw_inst;

To avoid the many mallocs in the probe function, maybe it would be
possible to pass the various parameters to hwmon_create_sysfs() and have
it return a pointer to hw_inst. Just an idea.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
