From: Lucas Stach <dev@lynxeye.de>
Date: Mon, 04 Jul 2011 15:28:29 +0000
Subject: Re: [lm-sensors] [RFC 1/2] add new hwmon core interface
Message-Id: <1309793309.8699.14.camel@Portable-Work>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309477463.18912.27.camel@tellur>
In-Reply-To: <1309477463.18912.27.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jonathan,

thanks for your suggestions, I really appreciate them.  

Am Freitag, den 01.07.2011, 10:37 +0100 schrieb Jonathan Cameron:
> On 07/01/11 00:44, Lucas Stach wrote:
> > From 94262a505a888fdb04cb1f37ffb33e240a58484f Mon Sep 17 00:00:00 2001
> > From: Lucas Stach <dev@lynxeye.de>
> > Date: Fri, 1 Jul 2011 00:55:30 +0200
> > Subject: [PATCH 1/2] hwmon: add hwmon-core interface
> > 
> > This adds an interface to easily access attributes from hwmon drivers and
> > a way to generically build sysfs entries for supported attributes.
> In principal this is quite similar to what we did recently with IIO_CHAN_SPEC
> in iio, but clearly your approach is somewhat different.  Perhaps it is worth
> us both reading each others code to see if we can make suggestions.
I'm working off a 2.6.39 tree, are these changes are already in there? I
would love to take a look at them. Can you give me some pointer
(patchname or else)?
> 
> Based on an initial look my main suggestion is to set it up so these capabilities
> can be specified as static const structure in the drivers. Makes for easier to read
> and smaller code.  Actually I can see no reason why you can't do this in your
> example driver.  As far as I can tell these are shared across multiple instances
> of the driver anyway.
When writing this interface I had the adt7475 driver in mind. The caps
of this driver are dependant on how things are wired up in hardware. So
two instances of the driver could possibly have different caps. But yes
it seems to be a good idea to make this only a pointer, so the
implementer of a driver could decide if he want to have a single static
const struct or one struct for each instance.
> 
> Various comments inline.  Basically they boil down to the fact this code could
> be much shorter with a few minor tweaks to how things are configured.
> 
> 
> > ---
> >  drivers/hwmon/hwmon-core.c |  656 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/hwmon-core.h |  211 ++++++++++++++
> >  2 files changed, 867 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/hwmon-core.c
> >  create mode 100644 include/linux/hwmon-core.h
> > 
> > diff --git a/drivers/hwmon/hwmon-core.c b/drivers/hwmon/hwmon-core.c
> > new file mode 100644
> > index 0000000..eb39a45
> > --- /dev/null
> > +++ b/drivers/hwmon/hwmon-core.c
> > @@ -0,0 +1,656 @@
> > +/*
> > + * hwmon-core.c
> > + * Copyright (C) 2011 Lucas Stach
> > + *
> > + * hwmon-core interface implementation
> > + *
> > + * Provides functions to create/destroy a sysfs interface out of a
> > + * hwmon_device_instance.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/list.h>
> > +#include <linux/hwmon-core.h>
> > +#include <linux/hwmon-sysfs.h>
> > +
> > +#define HWMON_NAME_SIZE 32
> > +
> > +struct hwmon_device_attribute {
> > +	struct sensor_device_attribute sensor_dev;
> > +	struct hwmon_device_instance *hw_dev_inst;
> > +	char name[HWMON_NAME_SIZE];
> > +	struct list_head node;
> > +};
> > +
> > +#define to_hwmon_device_attr(_sensor_attr) \
> > +	container_of(_sensor_attr, struct hwmon_device_attribute, sensor_dev)
> > +
> > +#define HWMON_GET_TEXT_ACCESSOR(_name, _enum) \
> > +	static ssize_t _name(struct device *dev, \
> > +		struct device_attribute *devattr, char *buf) \
> > +	{ \
> > +		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
> > +		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
> > +		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
> > +		return hw_dev->get_text_attr(hw_dev->inst_data, \
> > +			_enum, attr->index, buf); \
> > +	}
> > +
> > +#define HWMON_GET_NUM_ACCESSOR(_name, _enum) \
> > +	static ssize_t _name(struct device *dev, \
> > +		struct device_attribute *devattr, char *buf) \
> > +	{ \
> > +		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
> > +		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
> > +		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
> > +		int value, ret; \
> > +		ret = hw_dev->get_numeric_attr(hw_dev->inst_data, \
> > +				_enum, attr->index, &value); \
> > +		if(ret) \
> > +			return ret; \
> > +		ret = snprintf(buf, PAGE_SIZE, "%u\n", value); \
> > +		return ret; \
> > +	}
> > +
> > +#define HWMON_SET_NUM_ACCESSOR(_name, _enum) \
> > +	static ssize_t _name(struct device *dev, \
> > +		struct device_attribute *devattr, const char *buf, size_t count) \
> > +	{ \
> > +		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
> > +		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
> > +		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
> > +		long value; \
> > +		if(strict_strtol(buf, 10, &value)) \
> > +			return -EINVAL; \
> > +		hw_dev->set_numeric_attr(hw_dev->inst_data, \
> > +			_enum, attr->index, value); \
> > +		return count; \
> > +	}
> > +
> Why not just encapsulate the enum into a structure then you will only need one accessor
> for each type of reading?  Just use a sensor_device_attribute and put it in the index
> field.  Lots less code and same result.  Also means you can drop the function pointers
> in my suggestion below.  Whilst you currently pass on the attr->index value I can't
> see any where it is actually set?
Thanks, in the beginning I was afraid to bloat the
hwmon_device_attribute struct too much, but yes it seems to be the
better idea to put the enum in there and drop this ridiculous amount of
accessor functions. 
> 
> 
> > +/* accessor functions to route sysfs to hwmon core api */
> > +
> > +HWMON_GET_TEXT_ACCESSOR(show_name, hwmon_attr_name)
> > +HWMON_GET_NUM_ACCESSOR(show_update_interval, hwmon_attr_update_interval)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_in_min, hwmon_attr_volt_min)
> > +HWMON_SET_NUM_ACCESSOR(set_in_min, hwmon_attr_volt_min)
> > +HWMON_GET_NUM_ACCESSOR(show_in_lcrit, hwmon_attr_volt_lcrit)
> > +HWMON_SET_NUM_ACCESSOR(set_in_lcrit, hwmon_attr_volt_lcrit)
> > +HWMON_GET_NUM_ACCESSOR(show_in_max, hwmon_attr_volt_max)
> > +HWMON_SET_NUM_ACCESSOR(set_in_max, hwmon_attr_volt_max)
> > +HWMON_GET_NUM_ACCESSOR(show_in_crit, hwmon_attr_volt_crit)
> > +HWMON_SET_NUM_ACCESSOR(set_in_crit, hwmon_attr_volt_crit)
> > +HWMON_GET_NUM_ACCESSOR(show_in_vid, hwmon_attr_volt_vid)
> > +HWMON_GET_TEXT_ACCESSOR(show_in_label, hwmon_attr_volt_label)
> > +HWMON_GET_NUM_ACCESSOR(show_in_input, hwmon_attr_volt_input)
> > +HWMON_GET_NUM_ACCESSOR(show_in_vrm, hwmon_attr_volt_vrm)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_fan_min, hwmon_attr_fan_min)
> > +HWMON_SET_NUM_ACCESSOR(set_fan_min, hwmon_attr_fan_min)
> > +HWMON_GET_NUM_ACCESSOR(show_fan_max, hwmon_attr_fan_max)
> > +HWMON_SET_NUM_ACCESSOR(set_fan_max, hwmon_attr_fan_max)
> > +HWMON_GET_NUM_ACCESSOR(show_fan_div, hwmon_attr_fan_div)
> > +HWMON_SET_NUM_ACCESSOR(set_fan_div, hwmon_attr_fan_div)
> > +HWMON_GET_NUM_ACCESSOR(show_fan_pulses, hwmon_attr_fan_pulses)
> > +HWMON_SET_NUM_ACCESSOR(set_fan_pulses, hwmon_attr_fan_pulses)
> > +HWMON_GET_NUM_ACCESSOR(show_fan_target, hwmon_attr_fan_target)
> > +HWMON_SET_NUM_ACCESSOR(set_fan_target, hwmon_attr_fan_target)
> > +HWMON_GET_TEXT_ACCESSOR(show_fan_label, hwmon_attr_fan_label)
> > +HWMON_GET_NUM_ACCESSOR(show_fan_input, hwmon_attr_fan_input)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_pwm, hwmon_attr_pwm)
> > +HWMON_SET_NUM_ACCESSOR(set_pwm, hwmon_attr_pwm)
> > +HWMON_GET_NUM_ACCESSOR(show_pwm_enable, hwmon_attr_pwm_enable)
> > +HWMON_SET_NUM_ACCESSOR(set_pwm_enable, hwmon_attr_pwm_enable)
> > +HWMON_GET_NUM_ACCESSOR(show_pwm_mode, hwmon_attr_pwm_mode)
> > +HWMON_SET_NUM_ACCESSOR(set_pwm_mode, hwmon_attr_pwm_mode)
> > +HWMON_GET_NUM_ACCESSOR(show_pwm_freq, hwmon_attr_pwm_freq)
> > +HWMON_SET_NUM_ACCESSOR(set_pwm_freq, hwmon_attr_pwm_freq)
> > +HWMON_GET_NUM_ACCESSOR(show_pwm_auto_ct, hwmon_attr_pwm_auto_channels_temp)
> > +HWMON_SET_NUM_ACCESSOR(set_pwm_auto_ct, hwmon_attr_pwm_auto_channels_temp)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_temp_input, hwmon_attr_temp_input)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_type, hwmon_attr_temp_type)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_type, hwmon_attr_temp_type)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_max, hwmon_attr_temp_max)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_max, hwmon_attr_temp_max)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_min, hwmon_attr_temp_min)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_min, hwmon_attr_temp_min)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_max_hyst, hwmon_attr_temp_max_hyst)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_max_hyst, hwmon_attr_temp_max_hyst)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_crit, hwmon_attr_temp_crit)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_crit, hwmon_attr_temp_crit)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_crit_hyst, hwmon_attr_temp_crit_hyst)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_crit_hyst, hwmon_attr_temp_crit_hyst)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_emergency, hwmon_attr_temp_emergency)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_emergency, hwmon_attr_temp_emergency)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_emergency_hyst, hwmon_attr_temp_emergency_hyst)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_emergency_hyst, hwmon_attr_temp_emergency_hyst)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_lcrit, hwmon_attr_temp_lcrit)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_lcrit, hwmon_attr_temp_lcrit)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_offset, hwmon_attr_temp_offset)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_offset, hwmon_attr_temp_offset)
> > +HWMON_GET_TEXT_ACCESSOR(show_temp_label, hwmon_attr_temp_label)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_lowest, hwmon_attr_temp_lowest)
> > +HWMON_GET_NUM_ACCESSOR(show_temp_highest, hwmon_attr_temp_highest)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_reset_hist, hwmon_attr_temp_reset_history)
> > +HWMON_SET_NUM_ACCESSOR(set_temp_reset_hist_glob,
> > +		hwmon_attr_temp_reset_history_glob)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_curr_max, hwmon_attr_curr_max)
> > +HWMON_SET_NUM_ACCESSOR(set_curr_max, hwmon_attr_curr_max)
> > +HWMON_GET_NUM_ACCESSOR(show_curr_min, hwmon_attr_curr_min)
> > +HWMON_SET_NUM_ACCESSOR(set_curr_min, hwmon_attr_curr_min)
> > +HWMON_GET_NUM_ACCESSOR(show_curr_lcrit, hwmon_attr_curr_lcrit)
> > +HWMON_SET_NUM_ACCESSOR(set_curr_lcrit, hwmon_attr_curr_lcrit)
> > +HWMON_GET_NUM_ACCESSOR(show_curr_crit, hwmon_attr_curr_crit)
> > +HWMON_SET_NUM_ACCESSOR(set_curr_crit, hwmon_attr_curr_crit)
> > +HWMON_GET_NUM_ACCESSOR(show_curr_input, hwmon_attr_curr_input)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average, hwmon_attr_pow_average)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_int, hwmon_attr_pow_average_interval)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_average_int, hwmon_attr_pow_average_interval)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_int_max,
> > +		hwmon_attr_pow_average_interval_max)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_int_min,
> > +		hwmon_attr_pow_average_interval_min)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_highest,
> > +		hwmon_attr_pow_average_highest)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_lowest,
> > +		hwmon_attr_pow_average_lowest)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_max, hwmon_attr_pow_average_max)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_average_max, hwmon_attr_pow_average_max)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_average_min, hwmon_attr_pow_average_min)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_average_min, hwmon_attr_pow_average_min)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_input, hwmon_attr_pow_input)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_input_highest, hwmon_attr_pow_input_highest)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_input_lowest, hwmon_attr_pow_input_lowest)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_reset_history, hwmon_attr_pow_reset_history)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_accuracy, hwmon_attr_pow_accuracy)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_cap, hwmon_attr_pow_cap)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_cap, hwmon_attr_pow_cap)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_cap_hyst, hwmon_attr_pow_cap_hyst)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_cap_hyst, hwmon_attr_pow_cap_hyst)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_cap_max, hwmon_attr_pow_cap_max)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_cap_min, hwmon_attr_pow_cap_min)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_max, hwmon_attr_pow_max)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_max, hwmon_attr_pow_max)
> > +HWMON_GET_NUM_ACCESSOR(show_pow_crit, hwmon_attr_pow_crit)
> > +HWMON_SET_NUM_ACCESSOR(set_pow_crit, hwmon_attr_pow_crit)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_energy_input, hwmon_attr_ener_input)
> > +
> > +HWMON_GET_NUM_ACCESSOR(show_humidity_input, hwmon_attr_humi_input)
> > +
> > +/* functions to build/destroy sysfs entries from given hwmon caps */
> > +
> > +static int new_sysfs_entry(const char *name, mode_t mode,
> > +		ssize_t (*show)(struct device *, struct device_attribute *, char *),
> > +		ssize_t (*store)(struct device *, struct device_attribute *,
> > +				const char *, size_t),
> > +		int index, struct list_head *list, struct device *dev)
> > +{
> > +	struct hwmon_device_attribute *hw_dev_attr;
> > +	int ret = 0;
> > +
> > +	hw_dev_attr = kzalloc(sizeof(struct hwmon_device_attribute), GFP_KERNEL);
> > +	if(!hw_dev_attr)
> > +		return -ENOMEM;
> > +
> > +	strlcpy(hw_dev_attr->name, name, 32);
> > +
> > +	hw_dev_attr->sensor_dev.dev_attr.attr.name = hw_dev_attr->name;
> > +	hw_dev_attr->sensor_dev.dev_attr.attr.mode = mode;
> > +	hw_dev_attr->sensor_dev.dev_attr.show = show;
> > +	hw_dev_attr->sensor_dev.dev_attr.store = store;
> > +	hw_dev_attr->sensor_dev.index = index;
> > +	hw_dev_attr->hw_dev_inst = dev_get_drvdata(dev);
> > +	sysfs_attr_init(&hw_dev_attr->sensor_dev.dev_attr.attr);
> > +
> > +	ret = device_create_file(dev->parent, &hw_dev_attr->sensor_dev.dev_attr);
> > +	if(ret) {
> > +		kfree(hw_dev_attr);
> > +		return ret;
> > +	}
> > +
> > +	list_add(&hw_dev_attr->node, list);
> > +
> > +	return 0;
> > +}
> > +
> > +int hwmon_create_sysfs(struct device *dev)
> > +{
> > +	struct hwmon_device_instance *hw_dev = dev_get_drvdata(dev);
> > +	struct hwmon_device_caps *caps = &hw_dev->caps;
> > +	char attr_name[HWMON_NAME_SIZE];
> > +	int i;
> > +
> > +	INIT_LIST_HEAD(&hw_dev->sysfs_node);
> > +
> > +	new_sysfs_entry("name", S_IRUGO, &show_name, NULL, 0,
> > +			&hw_dev->sysfs_node, dev);
> > +	new_sysfs_entry("update_interval", S_IRUGO, &show_update_interval, NULL, 0,
> > +			&hw_dev->sysfs_node, dev);
> > +
> > +	/* voltage sysfs entries */
> > +	for(i = 1; i <= caps->num_voltage; i++) {
> 
> Hmm. the approach of lots of separate bit fields you have used in hwmon_device_caps
> does make this code overly repetative.  Perhaps having
> a single voltage capabilities field, and using a bit mask would allow you to do
> this as a trivial use of a magic table.
> 
> Say we have
> 
> unsigned int volt_caps:8;
> enum {
>      min,
>      lcrit,
>      max,
>      crit,
>      label,
>      vid,
>      vrm,
> } volt_caps;
> 
> enum {
>      text,
>      value,
> } cap_type;
> struct cap_info {
>        const char *format_string;
>        enum cap_type;
>        /* some function pointers */
> }
> 
> struct cap_info[] = {
>        [min] = { "in%u_min", value, &show_in_min, &set_in_min },
>        [lcrit] = { "in%u_lcrit", value, &show_in_lcrit, &set_in_lcrit },
> ...
> };
> 
> The the following just becomes a for_each_bit_set() against that structure.
> 
> With a little extension of this principal, all the different channel types
> can be handled as well.
> 
Thanks I wasn't aware of this possibility.
> 
[...snip...]

> This structure is rather complex, and as far as I can tell
> puts lots of arbitary limits on numbers of channels.
Abitary limits: true. As I'm thinking again about this a :8 should be
enough to cover any future expansions.

The channel caps enumerator are taken from lm-sensors kernel
documentation. I hope that I have all possibilities covered. Will make
this real enums to get rid of the overly complex construction code.
> 
> > +struct hwmon_device_caps {
> > +	/* number of inputs */
> > +	unsigned int num_voltage:4;
> > +	unsigned int num_fan:4;
> > +	unsigned int num_pwm:4;
> > +	unsigned int num_temp:4;
> > +	unsigned int num_current:4;
> > +	unsigned int num_power:4;
> > +	unsigned int num_energy:4;
> > +	unsigned int num_humidity:4;
> > +	unsigned int num_intrusion:4;
> > +
> > +	unsigned int num_trip_points:4;
> > +
> > +	/* voltage caps */
> > +	unsigned int volt_min:1;
> > +	unsigned int volt_lcrit:1;
> > +	unsigned int volt_max:1;
> > +	unsigned int volt_crit:1;
> > +	unsigned int volt_label:1;
> > +	unsigned int volt_vid:1;
> > +	unsigned int volt_vrm:1;
> > +
> > +	/* fan caps */
> > +	unsigned int fan_min:1;
> > +	unsigned int fan_max:1;
> > +	unsigned int fan_div:1;
> > +	unsigned int fan_pulses:1;
> > +	unsigned int fan_target:1;
> > +	unsigned int fan_label:1;
> > +
> > +	/* pwm caps */
> > +	unsigned int pwm_freq:1;
> > +	unsigned int pwm_auto_channels_temp:1;
> > +	unsigned int pwm_auto_point_pwm:1;
> > +	unsigned int pwm_auto_point_temp:1;
> > +	unsigned int pwm_auto_point_temp_hyst:1;
> > +
> > +	/* temp caps */
> > +	unsigned int temp_type:1;
> > +	unsigned int temp_min:1;
> > +	unsigned int temp_max:1;
> > +	unsigned int temp_max_hyst:1;
> > +	unsigned int temp_crit:1;
> > +	unsigned int temp_crit_hyst:1;
> > +	unsigned int temp_emergency:1;
> > +	unsigned int temp_emergency_hyst:1;
> > +	unsigned int temp_lcrit:1;
> > +	unsigned int temp_offset:1;
> > +	unsigned int temp_label:1;
> > +	unsigned int temp_lowest:1;
> > +	unsigned int temp_highest:1;
> > +	unsigned int temp_reset_history:1;
> > +	unsigned int temp_auto_point_pwm:1;
> > +	unsigned int temp_auto_point_temp:1;
> > +	unsigned int temp_auto_point_temp_hyst:1;
> > +
> > +	/* current caps */
> > +	unsigned int curr_max:1;
> > +	unsigned int curr_min:1;
> > +	unsigned int curr_lcrit:1;
> > +	unsigned int curr_crit:1;
> > +
> > +	/* power caps */
> > +	unsigned int pow_average:1;
> > +	unsigned int pow_average_interval:1;
> > +	unsigned int pow_average_interval_min:1;
> > +	unsigned int pow_average_interval_max:1;
> > +	unsigned int pow_average_min:1;
> > +	unsigned int pow_average_max:1;
> > +	unsigned int pow_average_lowest:1;
> > +	unsigned int pow_average_highest:1;
> > +	unsigned int pow_input_lowest:1;
> > +	unsigned int pow_input_highest:1;
> > +	unsigned int pow_reset_history:1;
> > +	unsigned int pow_accuracy:1;
> > +	unsigned int pow_cap:1;
> > +	unsigned int pow_cap_hyst:1;
> > +	unsigned int pow_cap_min:1;
> > +	unsigned int pow_cap_max:1;
> > +	unsigned int pow_max:1;
> > +	unsigned int pow_crit:1;
> > +
> > +	/* alarm caps */
> > +	unsigned int alarm_channel:1;
> > +	unsigned int alarm_limit:1;
> > +};
> > +
> > +
> > +struct hwmon_device_instance {
> > +	struct hwmon_device_caps caps;
> > +	int (*get_numeric_attr) (void * inst_data, enum hwmon_numeric_attr attr,
> > +			unsigned int index, int *value);
> > +	int (*get_text_attr) (void * inst_data, enum hwmon_text_attr attr,
> > +			unsigned int index, char *buf);
> > +	int (*set_numeric_attr) (void * inst_data, enum hwmon_numeric_attr attr,
> > +			unsigned int index, int value);
> > +	struct list_head sysfs_node;
> > +	void *inst_data;
> > +};
> > +
> > +#endif /* HWMON_CORE_H_ */
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
