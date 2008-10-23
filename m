From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 23 Oct 2008 20:13:17 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-new-driver-ti-tmp401.patch
Message-Id: <4900DADD.1080308@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4853E081.1020109@hhs.nl>
In-Reply-To: <4853E081.1020109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 14 Jun 2008 17:15:13 +0200, Hans de Goede wrote:
>> This is a new hwmon driver for TI's TMP401 temperature sensor IC. This driver
>> was written on behalf of an embedded systems vendor under the
>> linuxdriverproject.
>>
>> It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb adapter.
>> Which was provided by Till Harbaum, many thanks to him for this!
>>
>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Review:
> 

Sorry for the slow response and thanks for the review, I now have a local 
version ready with all issues fixed except for one:

<snip>

>> +static struct sensor_device_attribute tmp401_attr[] = {
>> +	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
>> +	SENSOR_ATTR(temp1_min, 0644, show_temp_min, store_temp_min, 0),
>> +	SENSOR_ATTR(temp1_max, 0644, show_temp_max, store_temp_max, 0),
>> +	SENSOR_ATTR(temp1_crit, 0644, show_temp_crit, store_temp_crit, 0),
>> +	SENSOR_ATTR(temp1_crit_hyst, 0644, show_temp_crit_hyst,
>> +			store_temp_crit_hyst, 0),
>> +	SENSOR_ATTR(temp1_min_alarm, 0444, show_status, NULL,
>> +			TMP401_STATUS_LOCAL_LOW_MASK),
>> +	SENSOR_ATTR(temp1_max_alarm, 0444, show_status, NULL,
>> +			TMP401_STATUS_LOCAL_HIGH_MASK),
>> +	SENSOR_ATTR(temp1_crit_alarm, 0444, show_status, NULL,
>> +			TMP401_STATUS_LOCAL_CRIT_MASK),
>> +	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
>> +	SENSOR_ATTR(temp2_min, 0644, show_temp_min, store_temp_min, 1),
>> +	SENSOR_ATTR(temp2_max, 0644, show_temp_max, store_temp_max, 1),
>> +	SENSOR_ATTR(temp2_crit, 0644, show_temp_crit, store_temp_crit, 1),
>> +	SENSOR_ATTR(temp2_crit_hyst, 0444, show_temp_crit_hyst, NULL, 1),
>> +	SENSOR_ATTR(temp2_fault, 0444, show_status, NULL,
>> +			TMP401_STATUS_REMOTE_OPEN_MASK),
>> +	SENSOR_ATTR(temp2_min_alarm, 0444, show_status, NULL,
>> +			TMP401_STATUS_REMOTE_LOW_MASK),
>> +	SENSOR_ATTR(temp2_max_alarm, 0444, show_status, NULL,
>> +			TMP401_STATUS_REMOTE_HIGH_MASK),
>> +	SENSOR_ATTR(temp2_crit_alarm, 0444, show_status, NULL,
>> +			TMP401_STATUS_REMOTE_CRIT_MASK),
>> +};
> 
> At page 11, in section "STATUS REGISTER", the datasheet suggests that
> the hysteresis value also applies to the local and remote high limits.
> Did you test that? If this is true then you should add files
> temp1_max_hyst and temp2_max_hyst (read-only.)
> 

This only is true if the AL/TH bit in the config register is 1. I choose to 
ignore this non default mode for now. I think it indeed makes sense to 
conditionally add temp1_max_hyst and temp2_max_hyst (read-only) when this is 
the case, but I'm not sure if its worth the additional code, what do you think?

> As a side note, it seems to me that your driver also supports the TI
> TMP411 chip. Both chips seem to be essentially compatible.

They are I've ordered a few samples and adding support for this chip is on my 
to do list.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
