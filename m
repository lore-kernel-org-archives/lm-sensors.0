From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Feb 2014 16:48:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (max6639) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <530A267B.9070105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393031014-26259-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393031014-26259-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/23/2014 08:21 AM, Jean Delvare wrote:
> On Fri, 21 Feb 2014 17:03:34 -0800, Guenter Roeck wrote:
>> Simplify code, reduce code size, and attach sysfs attricutes to hwmon device.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/max6639.c |   81 +++++++++++++++--------------------------------
>>   1 file changed, 26 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
>> index 52646bb..e4852bb 100644
>> --- a/drivers/hwmon/max6639.c
>> +++ b/drivers/hwmon/max6639.c
>> (...)
>> @@ -424,9 +417,9 @@ static int rpm_range_to_reg(int range)
>>   	return 1; /* default: 4000 RPM */
>>   }
>>
>> -static int max6639_init_client(struct i2c_client *client)
>> +static int max6639_init_client(struct max6639_data *data,
>> +			       struct i2c_client *client)
>
> As in a previous review, I'd suggest keeping client as the first
> parameter of this function.
>
You are right. I fixed it.

> All other changes look good, nice cleanup.
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks a lot!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
