From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 05 Jul 2011 08:37:43 +0000
Subject: Re: [lm-sensors] [RFC 1/2] add new hwmon core interface
Message-Id: <4E12CD57.6010106@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309477463.18912.27.camel@tellur>
In-Reply-To: <1309477463.18912.27.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/04/11 16:28, Lucas Stach wrote:
> Hello Jonathan,
> 
> thanks for your suggestions, I really appreciate them.  
> 
> Am Freitag, den 01.07.2011, 10:37 +0100 schrieb Jonathan Cameron:
>> On 07/01/11 00:44, Lucas Stach wrote:
>>> From 94262a505a888fdb04cb1f37ffb33e240a58484f Mon Sep 17 00:00:00 2001
>>> From: Lucas Stach <dev@lynxeye.de>
>>> Date: Fri, 1 Jul 2011 00:55:30 +0200
>>> Subject: [PATCH 1/2] hwmon: add hwmon-core interface
>>>
>>> This adds an interface to easily access attributes from hwmon drivers and
>>> a way to generically build sysfs entries for supported attributes.
>> In principal this is quite similar to what we did recently with IIO_CHAN_SPEC
>> in iio, but clearly your approach is somewhat different.  Perhaps it is worth
>> us both reading each others code to see if we can make suggestions.
> I'm working off a 2.6.39 tree, are these changes are already in there?
Current mainline, or for more examples, staging-next tree.  They went in during the
last merge window.  Looking at the end result is probably better than following
through the patches.  We had some pretty serious holes to jump through to keep
the tree working / building all the way through the conversion (as it overlapped
with a few other major changes).

>I
> would love to take a look at them. Can you give me some pointer
> (patchname or else)?
>>
>> Based on an initial look my main suggestion is to set it up so these capabilities
>> can be specified as static const structure in the drivers. Makes for easier to read
>> and smaller code.  Actually I can see no reason why you can't do this in your
>> example driver.  As far as I can tell these are shared across multiple instances
>> of the driver anyway.
> When writing this interface I had the adt7475 driver in mind. The caps
> of this driver are dependant on how things are wired up in hardware. So
> two instances of the driver could possibly have different caps. But yes
> it seems to be a good idea to make this only a pointer, so the
> implementer of a driver could decide if he want to have a single static
> const struct or one struct for each instance.
Sure.  If the devices only supports a small set of combinations, I'd be inclined
to still do it with a couple of const struct arrays then select between them.  Probably
more memory efficient in the end.  The other trick is to have an array and a array_count
int. Then you can put any single optional channels at the end then control what is included
by changing that counter.

Again, to draw a comparison.  Right now, we only have one driver doing the equivalent
dynamically for IIO (and that one hasn't been posted for review yet). It has between
12 and 12*8 channels depending on configuration.  Small variants are all handled by
multiple const arrays.
>>
>> Various comments inline.  Basically they boil down to the fact this code could
>> be much shorter with a few minor tweaks to how things are configured.
>>
...

>>> +
>>> +#define HWMON_SET_NUM_ACCESSOR(_name, _enum) \
>>> +	static ssize_t _name(struct device *dev, \
>>> +		struct device_attribute *devattr, const char *buf, size_t count) \
>>> +	{ \
>>> +		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
>>> +		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
>>> +		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
>>> +		long value; \
>>> +		if(strict_strtol(buf, 10, &value)) \
>>> +			return -EINVAL; \
>>> +		hw_dev->set_numeric_attr(hw_dev->inst_data, \
>>> +			_enum, attr->index, value); \
>>> +		return count; \
>>> +	}
>>> +
>> Why not just encapsulate the enum into a structure then you will only need one accessor
>> for each type of reading?  Just use a sensor_device_attribute and put it in the index
>> field.  Lots less code and same result.  Also means you can drop the function pointers
>> in my suggestion below.  Whilst you currently pass on the attr->index value I can't
>> see any where it is actually set?
> Thanks, in the beginning I was afraid to bloat the
> hwmon_device_attribute struct too much, but yes it seems to be the
> better idea to put the enum in there and drop this ridiculous amount of
> accessor functions. 
Yup, sometimes saving a small amount of space is more of a headache than it's worth!
>>
>>
>>> +/* accessor functions to route sysfs to hwmon core api */
>>> +
>>> +HWMON_GET_TEXT_ACCESSOR(show_name, hwmon_attr_name)
>>> +HWMON_GET_NUM_ACCESSOR(show_update_interval, hwmon_attr_update_interval)
...
>>> +int hwmon_create_sysfs(struct device *dev)
>>> +{
>>> +	struct hwmon_device_instance *hw_dev = dev_get_drvdata(dev);
>>> +	struct hwmon_device_caps *caps = &hw_dev->caps;
>>> +	char attr_name[HWMON_NAME_SIZE];
>>> +	int i;
>>> +
>>> +	INIT_LIST_HEAD(&hw_dev->sysfs_node);
>>> +
>>> +	new_sysfs_entry("name", S_IRUGO, &show_name, NULL, 0,
>>> +			&hw_dev->sysfs_node, dev);
>>> +	new_sysfs_entry("update_interval", S_IRUGO, &show_update_interval, NULL, 0,
>>> +			&hw_dev->sysfs_node, dev);
>>> +
>>> +	/* voltage sysfs entries */
>>> +	for(i = 1; i <= caps->num_voltage; i++) {
>>
>> Hmm. the approach of lots of separate bit fields you have used in hwmon_device_caps
>> does make this code overly repetative.  Perhaps having
>> a single voltage capabilities field, and using a bit mask would allow you to do
>> this as a trivial use of a magic table.
>>
>> Say we have
>>
>> unsigned int volt_caps:8;
>> enum {
>>      min,
>>      lcrit,
>>      max,
>>      crit,
>>      label,
>>      vid,
>>      vrm,
>> } volt_caps;
>>
>> enum {
>>      text,
>>      value,
>> } cap_type;
>> struct cap_info {
>>        const char *format_string;
>>        enum cap_type;
>>        /* some function pointers */
>> }
>>
>> struct cap_info[] = {
>>        [min] = { "in%u_min", value, &show_in_min, &set_in_min },
>>        [lcrit] = { "in%u_lcrit", value, &show_in_lcrit, &set_in_lcrit },
>> ...
>> };
>>
>> The the following just becomes a for_each_bit_set() against that structure.
>>
>> With a little extension of this principal, all the different channel types
>> can be handled as well.
>>
> Thanks I wasn't aware of this possibility.
:)
>>
> [...snip...]
> 
>> This structure is rather complex, and as far as I can tell
>> puts lots of arbitary limits on numbers of channels.
> Abitary limits: true. As I'm thinking again about this a :8 should be
> enough to cover any future expansions.
> 
> The channel caps enumerator are taken from lm-sensors kernel
> documentation. I hope that I have all possibilities covered. Will make
> this real enums to get rid of the overly complex construction code.
Yup, as long as it is cleanly defined, it should be possible and easy to add more
elements as they are added to the spec.  This will grow over time as people
add more 'interesting' devices.

 One possibility that has been floating around was (as suggested by Mark Brown) that
we allow IIO to act as an automated host (under very strict conditions) for hwmon
drivers.   His prime application is on SOC adc's where some channels are strictly
hwmon, but others are used for high speed purposes.  Clearly that's easier to do
if we have this nice clean bit of code that does creation from a description. Just
need a little layer in between ;) 
>>
>>> +struct hwmon_device_caps {
>>> +	/* number of inputs */
>>> +	unsigned int num_voltage:4;
>>> +	unsigned int num_fan:4;
>>> +	unsigned int num_pwm:4;
>>> +	unsigned int num_temp:4;
>>> +	unsigned int num_current:4;
>>> +	unsigned int num_power:4;
>>> +	unsigned int num_energy:4;
>>> +	unsigned int num_humidity:4;
>>> +	unsigned int num_intrusion:4;
>>> +
>>> +	unsigned int num_trip_points:4;
>>> +
>>> +	/* voltage caps */
>>> +	unsigned int volt_min:1;
>>> +	unsigned int volt_lcrit:1;
>>> +	unsigned int volt_max:1;
>>> +	unsigned int volt_crit:1;
>>> +	unsigned int volt_label:1;
>>> +	unsigned int volt_vid:1;
>>> +	unsigned int volt_vrm:1;
>>> +
>>> +	/* fan caps */
>>> +	unsigned int fan_min:1;
>>> +	unsigned int fan_max:1;
>>> +	unsigned int fan_div:1;
>>> +	unsigned int fan_pulses:1;
>>> +	unsigned int fan_target:1;
>>> +	unsigned int fan_label:1;
>>> +
>>> +	/* pwm caps */
>>> +	unsigned int pwm_freq:1;
>>> +	unsigned int pwm_auto_channels_temp:1;
>>> +	unsigned int pwm_auto_point_pwm:1;
>>> +	unsigned int pwm_auto_point_temp:1;
>>> +	unsigned int pwm_auto_point_temp_hyst:1;
>>> +
>>> +	/* temp caps */
>>> +	unsigned int temp_type:1;
>>> +	unsigned int temp_min:1;
>>> +	unsigned int temp_max:1;
>>> +	unsigned int temp_max_hyst:1;
>>> +	unsigned int temp_crit:1;
>>> +	unsigned int temp_crit_hyst:1;
>>> +	unsigned int temp_emergency:1;
>>> +	unsigned int temp_emergency_hyst:1;
>>> +	unsigned int temp_lcrit:1;
>>> +	unsigned int temp_offset:1;
>>> +	unsigned int temp_label:1;
>>> +	unsigned int temp_lowest:1;
>>> +	unsigned int temp_highest:1;
>>> +	unsigned int temp_reset_history:1;
>>> +	unsigned int temp_auto_point_pwm:1;
>>> +	unsigned int temp_auto_point_temp:1;
>>> +	unsigned int temp_auto_point_temp_hyst:1;
>>> +
>>> +	/* current caps */
>>> +	unsigned int curr_max:1;
>>> +	unsigned int curr_min:1;
>>> +	unsigned int curr_lcrit:1;
>>> +	unsigned int curr_crit:1;
>>> +
>>> +	/* power caps */
>>> +	unsigned int pow_average:1;
>>> +	unsigned int pow_average_interval:1;
>>> +	unsigned int pow_average_interval_min:1;
>>> +	unsigned int pow_average_interval_max:1;
>>> +	unsigned int pow_average_min:1;
>>> +	unsigned int pow_average_max:1;
>>> +	unsigned int pow_average_lowest:1;
>>> +	unsigned int pow_average_highest:1;
>>> +	unsigned int pow_input_lowest:1;
>>> +	unsigned int pow_input_highest:1;
>>> +	unsigned int pow_reset_history:1;
>>> +	unsigned int pow_accuracy:1;
>>> +	unsigned int pow_cap:1;
>>> +	unsigned int pow_cap_hyst:1;
>>> +	unsigned int pow_cap_min:1;
>>> +	unsigned int pow_cap_max:1;
>>> +	unsigned int pow_max:1;
>>> +	unsigned int pow_crit:1;
>>> +
>>> +	/* alarm caps */
>>> +	unsigned int alarm_channel:1;
>>> +	unsigned int alarm_limit:1;
>>> +};
>>> +
>>> +
>>> +struct hwmon_device_instance {
>>> +	struct hwmon_device_caps caps;
>>> +	int (*get_numeric_attr) (void * inst_data, enum hwmon_numeric_attr attr,
>>> +			unsigned int index, int *value);
>>> +	int (*get_text_attr) (void * inst_data, enum hwmon_text_attr attr,
>>> +			unsigned int index, char *buf);
>>> +	int (*set_numeric_attr) (void * inst_data, enum hwmon_numeric_attr attr,
>>> +			unsigned int index, int value);
>>> +	struct list_head sysfs_node;
>>> +	void *inst_data;
>>> +};
>>> +
>>> +#endif /* HWMON_CORE_H_ */
>>
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
