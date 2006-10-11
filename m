From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 11 Oct 2006 22:04:01 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min,
Message-Id: <452D6A51.60109@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4529A56C.1030507@gmail.com>
In-Reply-To: <4529A56C.1030507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>> implement separate min, max, alarms for each voltage input,
>> and min, max, crit alarms for temps.
>>
>> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
>> ---
>>
>> $ diffstat pc-set/hwmon-pc87360-separate-alarms.patch
>>  pc87360.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 files changed, 139 insertions(+), 5 deletions(-)
>>
>>     
>>> What about the fans?
>>>       
>> Current driver has no existing alarms on the fans, and my mobo has no 
>> fans either.
>>     
>
> "sensors" display alarms for the fans for all the PC87360 family chips,
> so they must exist.
>
>   
>> So adding them is a- more risky cuz its untestable here, b - a new feature.
>> I'll look at it later.
>>     
>
> This shouldn't be that risky, and we need it anyway. We can't switch
> libsensors to the new model until it offers a functionality level
> equivalent to the current code for all supported devices.
>
>   
>> diff -ruNp -X dontdiff -X exclude-diffs 19rc1-0/drivers/hwmon/pc87360.c 19rc1-1/drivers/hwmon/pc87360.c
>> --- 19rc1-0/drivers/hwmon/pc87360.c	2006-10-05 20:17:51.000000000 -0600
>> +++ 19rc1-1/drivers/hwmon/pc87360.c	2006-10-10 09:00:29.000000000 -0600
>> @@ -495,7 +495,9 @@ static struct sensor_device_attribute in
>>  	&in_input[X].dev_attr.attr,	\
>>  	&in_status[X].dev_attr.attr,	\
>>  	&in_min[X].dev_attr.attr,	\
>> -	&in_max[X].dev_attr.attr
>> +	&in_max[X].dev_attr.attr,	\
>> +	&in_min_alarm[X].dev_attr.attr,	\
>> +	&in_max_alarm[X].dev_attr.attr
>>  
>>  static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
>>  {
>> @@ -525,6 +527,46 @@ static ssize_t show_in_alarms(struct dev
>>  }
>>  static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
>>  
>> +static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
>>     
>
> Line too long, please fold. Same for all other callbacks you introduced.
>
>   
Ok.  I was under impression that fn-sigs were the sole exception to the 
line-wrap rule,
in that having the full sig on a single line is good for grepping.

I'll guess that folding existing functions should be a separate patch ?
(combined with any other cosmetic changes, later)

>
> This callback is exactly the same as show_in_min_alarm above, so why
> don't you just reuse it? Same for show_therm_max_alarm below and
> show_in_max_alarm.
>
> Which made me check the current code, and it appears that
> show_therm_input, show_therm_min and show_therm_max are redundant with
> show_in_input, show_in_min and show_in_max, respectively, so the code
> could be simplified. And this is again true of "set" callbacks, unless
> I am overlooking something? The benefit is even bigger here as these
> callbacks are larger. Care to submit a patch?
>
>   
I was planning to fold them together in a 2D patch, like so:

static ssize_t show_temp(struct device *dev, struct device_attribute 
*devattr, char *buf)
{
    struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
    struct pc87360_data *data = pc87360_update_device(dev);
    int idx = attr->index;
    unsigned res = -1;

    switch (attr->nr) {
    case FN_TEMP_INPUT:
        res = TEMP_FROM_REG(data->temp[idx]);
        break;
    case FN_TEMP_STATUS:
        res = data->temp_status[idx];
        break;
    case FN_TEMP_MIN:
        res = TEMP_FROM_REG(data->temp_min[idx]);
        break;
    case FN_TEMP_MAX:
        res = TEMP_FROM_REG(data->temp_max[idx]);
        break;
    case FN_TEMP_CRIT:
        res = TEMP_FROM_REG(data->temp_crit[idx]);
        break;
    case FN_TEMP_MIN_ALARM:
        res = (data->temp_status[idx] & 2) >> 1;
        break;
    case FN_TEMP_MAX_ALARM:
        res = (data->temp_status[idx] & 4) >> 2;
        break;
    case FN_TEMP_CRIT_ALARM:
        res = (data->temp_status[idx] & 8) >> 3;
        break;
    default:
        dev_err(dev, "unknown attr fetch\n");
     }
     return sprintf(buf, "%u\n", res);
}

This gets significant shrinkage..
  15902    5160      32   21094    5266 
19rc1mm1-1/drivers/hwmon/pc87360.ko  --- this patch
  14011    5160      32   19203    4b03 
19rc1mm1-2/drivers/hwmon/pc87360.ko  --- 2D patch

This folding doesnt rely on thermistor measurements being done with voltage
hardware, which is an ideosyncrasy of this particular part, and doesnt 
work for
the temp_ sensors (only the therm ones), so I think its clearer and more 
general this way.


>>  static struct attribute * pc8736x_temp_attr_array[] = {
>>  	TEMP_UNIT_ATTRS(0),
>>  	TEMP_UNIT_ATTRS(1),
>>  	TEMP_UNIT_ATTRS(2),
>> -	/* include the few miscellaneous atts here */
>>     
>
> This comment can stay for now?
>
>   
Its less true than it once was - few is one, and not so miscellaneous -
temp-alarms belongs with temp_*, and comment implies that its something 
of a catch-all. 
At least that was my mis-thinking when I 1st added it.

Or did you mean drop it *later* ?

>>  	&dev_attr_alarms_temp.attr,
>>  	NULL
>>  };
>>
>>     
> Otherwise it looks OK to me, thanks for working on this. Please
> resubmit with the minor issues above addressed and the fan alarms when
> you're done with that.
>
>   
Ok. 2 separate patches, works for me :-)

> Thanks,
>   

btw, thunderbird shows me 7:28 am on this mail, but Id *swear*
I looked at my inbox a dozen times today w/o seeing it.
Any idea why ? / what time did you actually send it ?

thanks
jimc


ps.  got a (link to a good model) patch converting a superio-i2c driver 
to platform_driver ?
It will simplify things if I have something to crib from ;-)

