From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Jun 2015 23:48:33 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: ntc: fix iio raw to microvolts conversion
Message-Id: <556CEF51.50100@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1433176057-26446-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1433176057-26446-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/01/2015 03:06 PM, Chris Lesiak wrote:

[ ... ]
.
>>>
>>> I think things could be improved in one of two ways:
>>> 1.  Accept the precision that you get by doing the calculation millivolts.
>>>      Simplify things by using millivolts throughout, although pullup_uv
>>>      needs to remain becaus it is part of the interface.
>>> 2.  Create an additional patch doing the calculations with microvolts
>>>      instead of millivolts.
>>>
>>> What are your thoughts?
>>>
>>
>> You explain above that doing the calculations in mV looses precision.
>> Given that, what would be the point of the first proposal, especially
>> since the uV are already available (and may still be needed in
>> ntc_adc_iio_read if conversion through iio is not available) ?
>>
>> Thanks,
>> Guenter
>>
>
> I do think that option 2 is the better choice.  If you'd like, I'll create a patch.
>
Your call.

> But if 1 were implemented, ntc_adc_iio_read would give a value in millivolts
> even when iio_convert_raw_to_processed failed.  Something like:
>
> ret = iio_convert_raw_to_processed(channel, raw, &mv, 1);
> if (ret < 0) {
>      /* Assume 12 bit ADC with vref at pullup_uv*/
>      mv = (pdata->pullup_uv * (s64)raw / 1000) >> 12;
> }
>

But what would be the point ? I don't see how that would improve anything.
Since iio internally supports uV, at least optionally, you would then
always loose accuracy. So we might as well leave everything as-is.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
