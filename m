From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Feb 2014 16:38:53 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (ltc4245) Associate log messages with hwmon device
Message-Id: <530A241D.2070105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392516972-27576-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392516972-27576-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/23/2014 02:46 AM, Jean Delvare wrote:
> On Sat, 15 Feb 2014 18:16:11 -0800, Guenter Roeck wrote:
>> Since sysfs attributes are not attached to the hwmon device,
>> it makes sense to associate log messages with the hwmon device
>> as well.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/ltc4245.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
>> index 2c6da5d..0a3eddb 100644
>> --- a/drivers/hwmon/ltc4245.c
>> +++ b/drivers/hwmon/ltc4245.c
>> @@ -95,7 +95,7 @@ static void ltc4245_update_gpios(struct device *dev)
>>   	 * readings as stale by setting them to -EAGAIN
>>   	 */
>>   	if (time_after(jiffies, data->last_updated + 5 * HZ)) {
>> -		dev_dbg(&client->dev, "Marking GPIOs invalid\n");
>> +		dev_dbg(dev, "Marking GPIOs invalid\n");
>>   		for (i = 0; i < ARRAY_SIZE(data->gpios); i++)
>>   			data->gpios[i] = -EAGAIN;
>>   	}
>> @@ -141,7 +141,7 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
>>
>>   	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
>>
>> -		dev_dbg(&client->dev, "Starting ltc4245 update\n");
>> +		dev_dbg(dev, "Starting ltc4245 update\n");
>>
>>   		/* Read control registers -- 0x00 to 0x07 */
>>   		for (i = 0; i < ARRAY_SIZE(data->cregs); i++) {
>
> Both debug messages are quite pointless IMHO and I'd rather delete them
> than update them.
>
Ok, I'll do that.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
