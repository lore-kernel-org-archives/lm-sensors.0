From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Jul 2014 15:00:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ds620): Check data pointer before dereference it
Message-Id: <53C14D94.5070307@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405155313.7852.1.camel@phoenix>
In-Reply-To: <1405155313.7852.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/12/2014 07:24 AM, Guenter Roeck wrote:
> On 07/12/2014 01:55 AM, Axel Lin wrote:
>> data can be an ERR_PTR, so the client assignment must only happen after the
>> ERR_PTR check.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>   drivers/hwmon/ds620.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
>> index 1bdb6246..65e01a8 100644
>> --- a/drivers/hwmon/ds620.c
>> +++ b/drivers/hwmon/ds620.c
>> @@ -159,7 +159,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>>
>>       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>>       struct ds620_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>> +    struct i2c_client *client;
>> +
>> +    if (IS_ERR(data))
>> +        return PTR_ERR(data);
>> +
> Hi Axel,
>
> This check is not needed; data is from dev_get_drvdata() and that is not problematic.
>

Never mind, though. I fixed it up myself and merged it with the original devm conversion patch.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
