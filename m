From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Feb 2014 16:35:37 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (lm95245) Make temp2_crit_hyst read-only
Message-Id: <530A2359.30708@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393090212-24900-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393090212-24900-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/23/2014 02:27 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 22 Feb 2014 09:30:12 -0800, Guenter Roeck wrote:
>> The hysteresis register is shared among both temperature sensors.
>> This means changing one also affects the other. To avoid confusion,
>> established way to express this is to make only the first instance writable
>> and keep all other instances as read-only. Otherwise users may be
>> confused that changing the second writable value also affects the first,
>> while it is more obvious that a writable value may affect a different
>> read-only value.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Additional patch
>>
>>   drivers/hwmon/lm95245.c |    3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
>> index 310e145..1f6a18f 100644
>> --- a/drivers/hwmon/lm95245.c
>> +++ b/drivers/hwmon/lm95245.c
>> @@ -396,8 +396,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
>>   static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
>>   static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_limit,
>>   		set_limit, 7);
>> -static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_crit_hyst,
>> -		set_crit_hyst, 7);
>> +static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_crit_hyst, NULL, 7);
>>   static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
>>   		STATUS1_RTCRIT);
>>   static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type,
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Maybe you can mention the limitation in the driver documentation file.
> The lm90 documentation says this:
>
>    Each sensor has its own high and low limits, plus a critical limit.
>    Additionally, there is a relative hysteresis value common to both critical
>    values. To make life easier to user-space applications, two absolute values
>    are exported, one for each channel, but these values are of course linked.
>    Only the local hysteresis can be set from user-space, and the same delta
>    applies to the remote hysteresis.
>

Good idea. I'll add the relevant text.

Thanks a lot for the review!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
