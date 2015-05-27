From: Chris Lesiak <chris.lesiak@licor.com>
Date: Wed, 27 May 2015 14:36:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ntc: Don't assume a 12 bit ADC
Message-Id: <5565D662.5030004@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432672902-28185-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1432672902-28185-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/26/2015 06:00 PM, Guenter Roeck wrote:
> On Tue, May 26, 2015 at 03:41:42PM -0500, Chris Lesiak wrote:
>> The function ntc_adc_iio_read was using iio_read_channel_raw and
>> converting to microVolts using the assumption of a 12 bit ADC.  If a
>> converter with different precision was used, the result was in error.
>>
>> Instead, use iio_read_channel_processed, which does the conversion to
>> microVolts itself.
>>
>> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
>> ---
>>   drivers/hwmon/ntc_thermistor.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
>> index 6880011..0d3a686 100644
>> --- a/drivers/hwmon/ntc_thermistor.c
>> +++ b/drivers/hwmon/ntc_thermistor.c
>> @@ -190,20 +190,15 @@ struct ntc_data {
>>   static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>>   {
>>   	struct iio_channel *channel = pdata->chan;
>> -	s64 result;
>>   	int val, ret;
>>   
>> -	ret = iio_read_channel_raw(channel, &val);
>> +	ret = iio_read_channel_processed(channel, &val);
>>   	if (ret < 0) {
>>   		pr_err("read channel() error: %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> -	/* unit: mV */
>> -	result = pdata->pullup_uv * (s64) val;
>> -	result >>= 12;
>> -
>> -	return (int)result;
>> +	return val;
> The calculation used to need pullup_uv. As far as I can see,
> the iio driver knows nothing about pullup_uv, which makes me
> wonder how this can work. Can you explain ?
>
> Thanks,
> Guenter
>

On further review, it would be premature to apply that patch.

Although it is good circuit design practice for pullup_uv to be the same 
as the ADC vref, that is not always the case.  The ntc_thermistor driver 
currently assumes they are the same and that the ADC is 12 bit.

24 of the 31 iio/adc device drivers in the 4.0 tree know their vref, 
either from device tree or pdata (example at91_adc.c), via 
regulator_get_voltage (example mcp320x.c), as a fixed internal reference 
(example max1027.c), or a combination of the above (example ad7266.c).

The other 7 do not support IIO_CHAN_INFO_SCALE.  They are:

axp288_adc.c
exynos_adc.c
men_z188_adc.c
ti_am335x_adc.c
twl4030-madc.c
twl6030-gpadc.c
viperboard_adc.c

A look at the arm device trees show that ntc_thermistor is used with 
exynos_adc on both exynos5420-peach-pit and exynos5800-peach-pi. This 
patch would break those platforms.

One solution would be to add support for IIO_CHAN_INFO_SCALE to the rest 
of the adc drivers, or at least exynos_adc.

I'll submit a patch taking a different approach: use 
iio_read_channel_processed only when supported by the adc.





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
