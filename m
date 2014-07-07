From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 07 Jul 2014 12:47:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc2103) Clamp limits instead of bailing out
Message-Id: <53BA96D2.9020501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404672224-30984-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404672224-30984-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/07/2014 12:22 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun,  6 Jul 2014 11:43:44 -0700, Guenter Roeck wrote:
>> It is customary to clamp limits instead of bailing out with an error
>> if a configured limit is out of the range supported by the driver.
>> This simplifies limit configuration, since the user will not typically
>> know chip and/or driver specific limits.
>
> Agreed.
>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/emc2103.c | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
>> index fd892dd..0f38294 100644
>> --- a/drivers/hwmon/emc2103.c
>> +++ b/drivers/hwmon/emc2103.c
>> @@ -250,9 +250,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
>>   	if (result < 0)
>>   		return result;
>>
>> -	val = DIV_ROUND_CLOSEST(val, 1000);
>> -	if ((val < -63) || (val > 127))
>> -		return -EINVAL;
>> +	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -63, 127);
>>
>>   	mutex_lock(&data->update_lock);
>>   	data->temp_min[nr] = val;
>> @@ -274,9 +272,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
>>   	if (result < 0)
>>   		return result;
>>
>> -	val = DIV_ROUND_CLOSEST(val, 1000);
>> -	if ((val < -63) || (val > 127))
>> -		return -EINVAL;
>> +	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -63, 127);
>>
>>   	mutex_lock(&data->update_lock);
>>   	data->temp_max[nr] = val;
>
> I fully agree with these two.
>
>> @@ -397,8 +393,7 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
>>   		return result;
>>
>>   	/* Datasheet states 16384 as maximum RPM target (table 3.2) */
>> -	if ((rpm_target < 0) || (rpm_target > 16384))
>> -		return -EINVAL;
>> +	rpm_target = clamp_val(rpm_target, 0, 16384);
>>
>>   	mutex_lock(&data->update_lock);
>>
>
> Here however, < 0 is really invalid. There is no excuse for the user to
> ask for a negative fan speed (as opposed to speeds above 16384, where
> the limit is arbitrary and impossible to guess without reading the
> datasheet.)
>
> IMHO the best way to handle that is to change rpm_target to unsigned
> long and set its value using kstrtoul (instead of kstrtol.)
>
Makes sense, I'll do that.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
