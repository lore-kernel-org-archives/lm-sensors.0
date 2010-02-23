From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 23 Feb 2010 08:33:16 +0000
Subject: Re: [lm-sensors] reformat: [PATCH] hwmon: Driver for Andigilog
Message-Id: <4B8392CC.1000605@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000601caa1fd$c6dadb30$54909190$@joseph@fairview5.com>
In-Reply-To: <000601caa1fd$c6dadb30$54909190$@joseph@fairview5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/23/2010 03:26 AM, George Joseph wrote:
>> -----Original Message-----
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Sent: Monday, February 22, 2010 6:55 AM
>> To: George Joseph
>> Cc: lm-sensors@lm-sensors.org
>> Subject: Re: [lm-sensors] reformat: [PATCH] hwmon: Driver for Andigilog aSC7621 family monitoring
>> chips
>>
>> Hi,
>>
>> Here is a full review of the driver, see comments inline.
>>
>> Allthough the structure of the driver is still a bit weird,
>> I must admit it works well. I don't know what it brushed me
>> the wrong way last time, sorry about that.
>>
>> If you can do a new revision addressing the few minor comments
>> I have, then I can ack this soon, and Jean will hopefully take it
>> for 2.6.34 .
>>
>> Regards,
>>
>> Hans
>>
>
> Thanks Hans.  I've made most of the changes but I've got 2 comments below.
>

<snip>

>>> +static u32 asc7621_range_map[] = {
>>> +	2000, 2500, 3330, 4000, 5000, 6670, 8000, 10000,
>>> +	13330, 16000, 20000, 26670, 32000, 40000, 53330, 80000,
>>> +};
>>> +
>>> +static ssize_t show_ap2_temp(struct device *dev,
>>> +			     struct device_attribute *attr, char *buf)
>>> +{
>>> +	SETUP_SHOW_data_param(dev, attr);
>>> +	long auto_point1;
>>> +	u8 regval;
>>> +	int temp;
>>> +
>>> +	mutex_lock(&data->update_lock);
>>> +	auto_point1 = ((s8) data->reg[param->msb[1]]) * 1000;
>>> +	regval >>> +	    ((data->reg[param->msb[0]]>>   param->shift[0])&   param->mask[0]);
>>> +	temp = auto_point1 + asc7621_range_map[SENSORS_LIMIT(regval, 0, 15)];
>>
>> The SENSORS_LIMIT here is not needed, as the mask already does the limiting.
>
> The reason I use the SENSORS_LIMIT here (and the other places you commented)
> is because a typo in the shift or mask specified in the PREAD/PWRITE macros
> could cause regval to get set to an index outside the lookup array.  I'll
> remove the SENSORS_LIMITs if you want but I'd prefer to keep them.
>

If you want to keep them that is fine, I found this usage of SENSOR_LIMIT
a bit strange, and unneeded. But if you prefer to keep them, ok.

>>
>>> +	mutex_unlock(&data->update_lock);
>>> +
>>> +	return sprintf(buf, "%d\n", temp);
>>> +
>>> +}
>>> +
>>> +static ssize_t store_ap2_temp(struct device *dev,
>>> +			      struct device_attribute *attr,
>>> +			      const char *buf, size_t count)
>>> +{
>>> +	SETUP_STORE_data_param(dev, attr);
>>> +	long reqval;
>>> +	long auto_point1;
>>> +	int i = 0;
>>> +	u8 currval = 0;
>>> +	u8 newval = 255;
>>> +
>>> +	if (strict_strtol(buf, 10,&reqval))
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&data->update_lock);
>>> +	auto_point1 = data->reg[param->msb[1]] * 1000;
>>> +	for (i = ARRAY_SIZE(asc7621_range_map) - 1; i>= 0; i--) {
>>> +		if (reqval>= auto_point1 + asc7621_range_map[i]) {
>>> +			newval = i;
>>> +			break;
>>> +		}
>>> +	}
>>> +	if (newval = 255) {
>>> +		mutex_unlock(&data->update_lock);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>
>> For autopoint1 you use SENSORS_LIMIT, so it seems more consistent
>> to me to do the same here, so instead of returning EINVAL simply
>> use newval = 0
>
> I'm not sure I follow.
>

The store function used for autopoint1, will simply clamp the user
given input between -128000 and +127000 if it is out of that range. Here when
reqval is larger then autopoint1 + 80000, you do the same, but when it is
smaller then autopoint1 + 2000 you return -EINVAL. That seems inconsistent
to me. So I would like to see this store function clamp autopoint2 to
autopoint1 + 2000 (so set newval to 0) when the input-value < autopoint1 + 2000.

NB
You could add a check for input-value < autopoint1 and return -EINVAL there,
that makes sense, but just clamping is fine too.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
