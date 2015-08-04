From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 04 Aug 2015 11:00:41 +0000
Subject: Re: [lm-sensors] [PATCH v2 04/10] thermal: Fix thermal_zone_of_sensor_register to match documentatio
Message-Id: <9hha8u7mi7a.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
	<1438615378-14241-5-git-send-email-punit.agrawal@arm.com>
	<55BF8F25.9010305@roeck-us.net>
In-Reply-To: <55BF8F25.9010305@roeck-us.net> (Guenter Roeck's message of "Mon,
	03 Aug 2015 08:56:21 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

Guenter Roeck <linux@roeck-us.net> writes:

> On 08/03/2015 08:22 AM, Punit Agrawal wrote:
>> thermal_zone_of_sensor_register is documented as returning a pointer
>> to either a valid thermal_zone_device on success, or a corresponding
>> ERR_PTR() value.
>>
>> In contrast, the function returns NULL when THERMAL_OF is configured
>> off. Fix this.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks, Guenter.

>> ---
>>   include/linux/thermal.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 037e9df..a47b34a 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -364,7 +364,7 @@ static inline struct thermal_zone_device *
>>   thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>>   				const struct thermal_zone_of_device_ops *ops)
>>   {
>> -	return NULL;
>> +	return ERR_PTR(-ENOSYS);
>>   }
>>
>>   static inline
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
