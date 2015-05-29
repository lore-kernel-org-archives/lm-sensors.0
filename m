From: Chris Lesiak <chris.lesiak@licor.com>
Date: Fri, 29 May 2015 23:12:37 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: ntc: use iio_read_channel_processed if possible
Message-Id: <5568F265.9020505@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432821471-17373-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1432821471-17373-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/29/2015 05:47 PM, Guenter Roeck wrote:
> On 05/28/2015 06:57 AM, Chris Lesiak wrote:
>> The function ntc_adc_iio_read (now ntc_adc_iio_read_raw) assumes
>> both a 12 bit ADC and that pullup_uv is the same as the ADC reference
>> voltage.  If either assumption is false, then the result is incorrect.
>>
>> For iio channels supporting either IIO_CHAN_INFO_PROCESSED or
>> IIO_CHAN_INFO_SCALE, the new ntc_adc_iio_read will be used.  It gets
>> microvolts directly with a call to iio_read_channel_processed.
>>
>> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
>
> Looks ok to me. Applied to -next.
>
> Thanks,
> Guenter
>

Guenter,

I am sorry to say that I must ask you to please revert that patch.

I had a mistaken belief that iio_read_channel_processed returned 
microvolts directly.  But the standard voltage unit for the iio 
subsystem is in fact millivolts, just as in the hwmon subsystem.  I was 
confused by a broken iio adc driver that in fact did scale results to 
microvolts.  The combination resulted in tests that pased when they 
shouldn't have.

Early next week I hope to submit a new patch that uses 
iio_read_channel_raw and converts the result to microvolts with 
iio_convert_raw_to_processed.  That allows an additional scale actor of 
1000.

Thank you for your time and patience reviewing these patches.

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
