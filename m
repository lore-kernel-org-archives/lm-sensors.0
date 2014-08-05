From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 05 Aug 2014 02:43:15 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm92) Prevent overflow problem when writing large limits
Message-Id: <CAFRkauDuZnP1=JU0ZQRpOVXzD7HZBBVoLuBeC3CRceNdERrRoA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407204511.20206.3.camel@phoenix>
In-Reply-To: <1407204511.20206.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-08-05 10:40 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On Tue, Aug 05, 2014 at 10:08:31AM +0800, Axel Lin wrote:
>> On platforms with sizeof(int) < sizeof(long), writing a temperature
>> limit larger than MAXINT will result in unpredictable limit values
>> written to the chip. Avoid auto-conversion from long to int to fix
>> the problem.
>>
>> The hysteresis temperature range depends on the value of
>> data->temp[attr->index], since val is subtracted from it.
>> Use a wider clamp, [-120000, 220000] should do to cover the
>> possible range.
>>
>> Also uses clamp_val to simplify the code a bit.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/hwmon/lm92.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
>> index d2060e2..08a261d 100644
>> --- a/drivers/hwmon/lm92.c
>> +++ b/drivers/hwmon/lm92.c
>> @@ -74,12 +74,9 @@ static inline int TEMP_FROM_REG(s16 reg)
>>       return reg / 8 * 625 / 10;
>>  }
>>
>> -static inline s16 TEMP_TO_REG(int val)
>> +static inline s16 TEMP_TO_REG(long val)
>>  {
>> -     if (val <= -60000)
>> -             return -60000 * 10 / 625 * 8;
>> -     if (val >= 160000)
>> -             return 160000 * 10 / 625 * 8;
>> +     val = clamp_val(val, -60000, 160000);
>>       return val * 10 / 625 * 8;
>>  }
>>
>> @@ -206,8 +203,10 @@ static ssize_t set_temp_hyst(struct device *dev,
>>       if (err)
>>               return err;
>>
>> +     val = clamp_val(val, -120000, 220000);
>>       mutex_lock(&data->update_lock);
>> -     data->temp[t_hyst] = TEMP_FROM_REG(data->temp[attr->index]) - val;
>> +      data->temp[t_hyst] >> +             TEMP_TO_REG(TEMP_FROM_REG(data->temp[attr->index]) - val);
>>       i2c_smbus_write_word_swapped(client, LM92_REG_TEMP_HYST,
>>                                    TEMP_TO_REG(data->temp[t_hyst]));
>
> Hi Axel,
>
> Almost ... unfortunately, now you've got TEMP_TO_REG() on data->temp[t_hyst]
> twice. No need to resend, I fixed it up myself.
Ah, thanks.

Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
