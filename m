From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 Apr 2015 13:38:10 +0000
Subject: Re: [lm-sensors] [PATCH 01/22] hwmon: (it87) Fix in7 voltage display
Message-Id: <552680C2.6020508@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428184513-22380-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1428184513-22380-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/09/2015 04:31 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat,  4 Apr 2015 14:54:52 -0700, Guenter Roeck wrote:
>> Commit a6ebb8b09421 ("hwmon: (it87) Introduce feature flag to reflect internal
>> in7 sensor") actually caused in7 to never be recognized as internal.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/it87.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index 4763d1157a5e..32180aaa4ac6 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -1910,7 +1910,7 @@ static int __init it87_find(unsigned short *address,
>>   		sio_data->internal |= (1 << 1);
>>
>>   	/* in8 (Vbat) is always internal */
>> -	sio_data->internal = (1 << 2);
>> +	sio_data->internal |= (1 << 2);
>>
>>   	/* Only the IT8603E has in9 */
>>   	if (sio_data->type != it8603)
>
> Meanwhile you merged that fix in patch "hwmon: (it87) Introduce feature
> flag to reflect internal in7 sensor" so this patch is no longer
> relevant, right?
>
Yes.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
