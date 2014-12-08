From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Dec 2014 14:13:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401) Detect TMP435 on all addresses it supports
Message-Id: <5485B223.7080204@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417910556-23966-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417910556-23966-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/08/2014 02:16 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat,  6 Dec 2014 16:02:36 -0800, Guenter Roeck wrote:
>> TMP435 supports a range of I2C addresses, not just 0x4c.
>>
>> Cc: Patrick Titiano <ptitiano@baylibre.com>
>> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Tested with TMP435 at addresses 0x37 and 0x48.
>>
>>   drivers/hwmon/tmp401.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
>> index f2182ee..99664eb 100644
>> --- a/drivers/hwmon/tmp401.c
>> +++ b/drivers/hwmon/tmp401.c
>> @@ -44,7 +44,8 @@
>>   #include <linux/sysfs.h>
>>
>>   /* Addresses to scan */
>> -static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
>> +static const unsigned short normal_i2c[] = { 0x37, 0x48, 0x49, 0x4a, 0x4c, 0x4d,
>> +	0x4e, 0x4f, I2C_CLIENT_END };
>>
>>   enum chips { tmp401, tmp411, tmp431, tmp432, tmp435 };
>>
>> @@ -679,18 +680,16 @@ static int tmp401_detect(struct i2c_client *client,
>>   		kind = tmp411;
>>   		break;
>>   	case TMP431_DEVICE_ID:
>> -		if (client->addr = 0x4e)
>> +		if (client->addr != 0x4c && client->addr != 0x4d)
>>   			return -ENODEV;
>>   		kind = tmp431;
>>   		break;
>>   	case TMP432_DEVICE_ID:
>> -		if (client->addr = 0x4e)
>> +		if (client->addr != 0x4c && client->addr != 0x4d)
>>   			return -ENODEV;
>>   		kind = tmp432;
>>   		break;
>>   	case TMP435_DEVICE_ID:
>> -		if (client->addr != 0x4c)
>> -			return -ENODEV;
>>   		kind = tmp435;
>>   		break;
>>   	default:
>
> Looks good, but you should update Documentation/hwmon/tmp401 in the
> same way.
>
Yes, I'll do that.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
