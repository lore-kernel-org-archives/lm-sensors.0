From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Feb 2014 16:28:27 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (lm95245) Convert to use devm_hwmon_device_register_with_grou
Message-Id: <530A21AB.5050103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393090212-24900-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393090212-24900-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/23/2014 02:16 AM, Jean Delvare wrote:
> On Sat, 22 Feb 2014 09:30:10 -0800, Guenter Roeck wrote:
>> Simplify code, reduce code size, and attach hwmon attributes
>> to hwmon device.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Adjust to changes in 1st patch
>>
>>   drivers/hwmon/lm95245.c |   82 ++++++++++++++++-------------------------------
>>   1 file changed, 27 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
>> index d7bcea1..b62a1f4 100644
>> --- a/drivers/hwmon/lm95245.c
>> +++ b/drivers/hwmon/lm95245.c
>> (...)
>> @@ -149,7 +149,7 @@ static struct lm95245_data *lm95245_update_device(struct device *dev)
>>   		+ msecs_to_jiffies(data->interval)) || !data->valid) {
>>   		int i;
>>
>> -		dev_dbg(&client->dev, "Updating lm95245 data.\n");
>> +		dev_dbg(dev, "Updating lm95245 data.\n");
>>   		for (i = 0; i < ARRAY_SIZE(lm95245_reg_address); i++)
>>   			data->regs[i]
>>   			  = i2c_smbus_read_byte_data(client,
>
> You could apply patch 3/4 first and make this patch smaller.
>
Good idea, I'll do that.

> Other than this, it looks alright.
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks!
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
