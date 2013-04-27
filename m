From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 27 Apr 2013 09:31:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if devm_kzalloc
Message-Id: <517B9AFE.9000205@jic23.retrosnub.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1366708003.10246.1.camel@phoenix> <20130423124800.GA29681@roeck-us.net>
In-Reply-To: <20130423124800.GA29681@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Axel Lin <axel.lin@ingics.com>, Jonathan Cameron <jic23@cam.ac.uk>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On 04/23/2013 01:48 PM, Guenter Roeck wrote:
> On Tue, Apr 23, 2013 at 05:06:43PM +0800, Axel Lin wrote:
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Good catch.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
Given the timing this will need to go in through hwmon
after the merge window is closed.  Sorry, busy week or
I would have caught up with this earlier.

Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>> ---
>>  drivers/hwmon/iio_hwmon.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>> index aafa453..368497f 100644
>> --- a/drivers/hwmon/iio_hwmon.c
>> +++ b/drivers/hwmon/iio_hwmon.c
>> @@ -84,8 +84,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>>  		return PTR_ERR(channels);
>>  
>>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>> -	if (st = NULL)
>> -		return -ENOMEM;
>> +	if (st = NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_release_channels;
>> +	}
>>  
>>  	st->channels = channels;
>>  
>> -- 
>> 1.7.10.4
>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
