From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 31 Jul 2014 14:49:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (lm77) Prevent overflow problem when writing large limits
Message-Id: <CAFRkauCi_RWGUOaf6Rnw-0Q+MHnNAJnzVfRdTtZHUXbm=1wefg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406791851.7637.1.camel@phoenix>
In-Reply-To: <1406791851.7637.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-31 22:46 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/31/2014 12:30 AM, Axel Lin wrote:
>>
>> On platforms with sizeof(int) < sizeof(long), writing a temperature
>> limit larger than MAXINT will result in unpredictable limit values
>> written to the chip.
>> Clamp the input values to the supported limits first to fix the problem.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>   drivers/hwmon/lm77.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
>> index 5ceb443..72a02b0 100644
>> --- a/drivers/hwmon/lm77.c
>> +++ b/drivers/hwmon/lm77.c
>> @@ -80,8 +80,7 @@ struct lm77_data {
>>    */
>>   static inline s16 LM77_TEMP_TO_REG(int temp)
>>   {
>> -       int ntemp = clamp_val(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
>> -       return (ntemp / 500) * 8;
>> +       return (temp / 500) * 8;
>>   }
>>
>>   static inline int LM77_TEMP_FROM_REG(s16 reg)
>> @@ -176,7 +175,7 @@ static ssize_t set_temp(struct device *dev, struct
>> device_attribute *devattr,
>>                 return err;
>>
>>         mutex_lock(&data->update_lock);
>> -       data->temp[nr] = val;
>> +       data->temp[nr] = clamp_val(val, LM77_TEMP_MIN, LM77_TEMP_MAX);
>>         lm77_write_value(client, temp_regs[nr], LM77_TEMP_TO_REG(val));
>
>
> Found it: Clamp applied to data->temp[nr], but you are still using val here.
> Has to be LM77_TEMP_TO_REG(data->temp[nr]).

Thanks a lot.
I'll send a v3 soon.

Regards,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
