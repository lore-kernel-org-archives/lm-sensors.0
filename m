From: Chris Lesiak <chris.lesiak@licor.com>
Date: Mon, 01 Jun 2015 22:06:10 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: ntc: fix iio raw to microvolts conversion
Message-Id: <556CD752.3040506@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1433176057-26446-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1433176057-26446-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/01/2015 04:44 PM, Guenter Roeck wrote:
> On 06/01/2015 02:21 PM, Chris Lesiak wrote:
>> On 06/01/2015 02:54 PM, Guenter Roeck wrote:
>>> On 06/01/2015 09:27 AM, Chris Lesiak wrote:
>>>> The function ntc_adc_iio_read was assuming both a 12 bit ADC and that
>>>> pullup_uv is the same as the ADC reference voltage.  If either
>>>> assumption is false, then the result is incorrect.
>>>>
>>>> Attempt to use iio_convert_raw_to_processed to convert the raw 
>>>> value to
>>>> microvolts.  It will fail for iio channels that don't support support
>>>
>>> But we need millivolts ?
>>
>> No.  I think we really do want microvolts.
>>
>> Don't let the old comment "/* unit: mV */ " lead you astray.  It is 
>> incorrect.
>>
> Ok.
>
>> The value eventually makes its way to the function 
>> get_ohm_of_thermistor.
>> That function is expecting the value to be in microvolts.
>>
>> It is true that get_ohm_of_thermistor promptly converts both uv and 
>> pullup_uv
>> to millivolts by dividing by 1000.  But I don't think that conversion to
>> millivolts is necessary.  In fact it is hurting the accuracy a little.
>>
>> For example, take the ncpXXwb473 connected to 5000 mV and pulled down 
>> through
>> a 47000 ohm resistor.  At 25 C, the resistance of the thermistor is 
>> 47000 ohms.
>> The measured voltage will be 2500 mV.  If we measure instead 2501 mV, 
>> then
>> the calculated resistance will be 46962 ohms - a difference of 38 ohms.
>> So the precision of the resistance estimate could be increased by 38X by
>> doing the calculations in microvolts.
>>
>> But how does that resolution affect the temperature estimate?
>> At room temperature, the sensitivity of the thermistor is -5.3x10^-4 
>> C/ohm.
>> So, the resolution of the temperature measurement is 0.02 C. That 
>> probably
>> is good enough for most purposes.
>>
>> The result will be worse at lower temperatures, but if you wanted to 
>> measure
>> low temperatures, you'd probably connect the thermistor to ground and 
>> pull it
>> up through the resistor.
>>
>> I think things could be improved in one of two ways:
>> 1.  Accept the precision that you get by doing the calculation 
>> millivolts.
>>      Simplify things by using millivolts throughout, although pullup_uv
>>      needs to remain becaus it is part of the interface.
>> 2.  Create an additional patch doing the calculations with microvolts
>>      instead of millivolts.
>>
>> What are your thoughts?
>>
>
> You explain above that doing the calculations in mV looses precision.
> Given that, what would be the point of the first proposal, especially
> since the uV are already available (and may still be needed in
> ntc_adc_iio_read if conversion through iio is not available) ?
>
> Thanks,
> Guenter
>

I do think that option 2 is the better choice.  If you'd like, I'll 
create a patch.

But if 1 were implemented, ntc_adc_iio_read would give a value in millivolts
even when iio_convert_raw_to_processed failed.  Something like:

ret = iio_convert_raw_to_processed(channel, raw, &mv, 1);
if (ret < 0) {
     /* Assume 12 bit ADC with vref at pullup_uv*/
     mv = (pdata->pullup_uv * (s64)raw / 1000) >> 12;
}

-- 
Chris Lesiak
Principal Design Engineer, Software
LI-COR, Inc.
chris.lesiak@licor.com

Any opinions expressed are those of the author and
do not necessarily represent those of his employer.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
