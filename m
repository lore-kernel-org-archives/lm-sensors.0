From: Chris Lesiak <chris.lesiak@licor.com>
Date: Mon, 01 Jun 2015 21:21:23 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: ntc: fix iio raw to microvolts conversion
Message-Id: <556CCCD3.5020003@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1433176057-26446-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1433176057-26446-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/01/2015 02:54 PM, Guenter Roeck wrote:
> On 06/01/2015 09:27 AM, Chris Lesiak wrote:
>> The function ntc_adc_iio_read was assuming both a 12 bit ADC and that
>> pullup_uv is the same as the ADC reference voltage.  If either
>> assumption is false, then the result is incorrect.
>>
>> Attempt to use iio_convert_raw_to_processed to convert the raw value to
>> microvolts.  It will fail for iio channels that don't support support
>
> But we need millivolts ?

No.  I think we really do want microvolts.

Don't let the old comment "/* unit: mV */ " lead you astray.  It is 
incorrect.

The value eventually makes its way to the function get_ohm_of_thermistor.
That function is expecting the value to be in microvolts.

It is true that get_ohm_of_thermistor promptly converts both uv and 
pullup_uv
to millivolts by dividing by 1000.  But I don't think that conversion to
millivolts is necessary.  In fact it is hurting the accuracy a little.

For example, take the ncpXXwb473 connected to 5000 mV and pulled down 
through
a 47000 ohm resistor.  At 25 C, the resistance of the thermistor is 
47000 ohms.
The measured voltage will be 2500 mV.  If we measure instead 2501 mV, then
the calculated resistance will be 46962 ohms - a difference of 38 ohms.
So the precision of the resistance estimate could be increased by 38X by
doing the calculations in microvolts.

But how does that resolution affect the temperature estimate?
At room temperature, the sensitivity of the thermistor is -5.3x10^-4 C/ohm.
So, the resolution of the temperature measurement is 0.02 C.  That probably
is good enough for most purposes.

The result will be worse at lower temperatures, but if you wanted to measure
low temperatures, you'd probably connect the thermistor to ground and 
pull it
up through the resistor.

I think things could be improved in one of two ways:
1.  Accept the precision that you get by doing the calculation millivolts.
     Simplify things by using millivolts throughout, although pullup_uv
     needs to remain becaus it is part of the interface.
2.  Create an additional patch doing the calculations with microvolts
     instead of millivolts.

What are your thoughts?

Chris

>
> Guenter
>
>> IIO_CHAN_INFO_SCALE; in that case fall back to the assumptions.
>>
>> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
>> ---
>>   drivers/hwmon/ntc_thermistor.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> This patch was previously titled:
>> "hwmon: ntc: use iio_read_channel_processed if possible"
>> but that doesn't describe it anymore.
>>
>> Changes in v3
>> ======>>
>> - Don't use iio_read_channel_processed because it does not return 
>> results in
>>    microvolts.
>>
>> - Do use iio_convert_raw_to_processed with a scale factor of 1000 to get
>>    microvolts instead of the iio normal unit of millivolts.
>>
>> - Do it all in the context of the original ntc_adc_iio_read function 
>> instead
>>    of having separate read functions for the raw and processed cases.
>>
>> diff --git a/drivers/hwmon/ntc_thermistor.c 
>> b/drivers/hwmon/ntc_thermistor.c
>> index 6880011..e08ed47 100644
>> --- a/drivers/hwmon/ntc_thermistor.c
>> +++ b/drivers/hwmon/ntc_thermistor.c
>> @@ -190,20 +190,21 @@ struct ntc_data {
>>   static int ntc_adc_iio_read(struct ntc_thermistor_platform_data 
>> *pdata)
>>   {
>>       struct iio_channel *channel = pdata->chan;
>> -    s64 result;
>> -    int val, ret;
>> +    int raw, uv, ret;
>>
>> -    ret = iio_read_channel_raw(channel, &val);
>> +    ret = iio_read_channel_raw(channel, &raw);
>>       if (ret < 0) {
>>           pr_err("read channel() error: %d\n", ret);
>>           return ret;
>>       }
>>
>> -    /* unit: mV */
>> -    result = pdata->pullup_uv * (s64) val;
>> -    result >>= 12;
>> +    ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
>> +    if (ret < 0) {
>> +        /* Assume 12 bit ADC with vref at pullup_uv*/
>> +        uv = (pdata->pullup_uv * (s64)raw) >> 12;
>> +    }
>>
>> -    return (int)result;
>> +    return uv;
>>   }
>>
>>   static const struct of_device_id ntc_match[] = {
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
