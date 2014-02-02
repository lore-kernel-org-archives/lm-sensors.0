From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Feb 2014 21:59:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm80) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <52EEBFC0.5040004@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391363141-7157-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391363141-7157-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/02/2014 01:00 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun,  2 Feb 2014 09:45:41 -0800, Guenter Roeck wrote:
>> Simplify code, reduce code size, and attach hwmon attributes to
>> hwmon device.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/lm80.c |   64 ++++++++++++++++----------------------------------
>>   1 file changed, 20 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
>> index eba89aa..914d7e5 100644
>> --- a/drivers/hwmon/lm80.c
>> +++ b/drivers/hwmon/lm80.c
>> (...)
>> @@ -541,14 +536,14 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
>>   static int lm80_probe(struct i2c_client *client,
>>   		      const struct i2c_device_id *id)
>>   {
>> +	struct device *hwmon_dev;
>>   	struct lm80_data *data;
>> -	int err;
>>
>>   	data = devm_kzalloc(&client->dev, sizeof(struct lm80_data), GFP_KERNEL);
>>   	if (!data)
>>   		return -ENOMEM;
>>
>> -	i2c_set_clientdata(client, data);
>> +	data->client = client;
>>   	mutex_init(&data->update_lock);
>>
>>   	/* Initialize the LM80 chip */
>> @@ -558,30 +553,11 @@ static int lm80_probe(struct i2c_client *client,
>>   	data->fan_min[0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
>>   	data->fan_min[1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
>>
>> -	/* Register sysfs hooks */
>> -	err = sysfs_create_group(&client->dev.kobj, &lm80_group);
>> -	if (err)
>> -		return err;
>> -
>> -	data->hwmon_dev = hwmon_device_register(&client->dev);
>> -	if (IS_ERR(data->hwmon_dev)) {
>> -		err = PTR_ERR(data->hwmon_dev);
>> -		goto error_remove;
>> -	}
>> -
>> -	return 0;
>> -
>> -error_remove:
>> -	sysfs_remove_group(&client->dev.kobj, &lm80_group);
>> -	return err;
>> -}
>> -
>> -static int lm80_remove(struct i2c_client *client)
>> -{
>> -	struct lm80_data *data = i2c_get_clientdata(client);
>> -
>> -	hwmon_device_unregister(data->hwmon_dev);
>> -	sysfs_remove_group(&client->dev.kobj, &lm80_group);
>> +	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
>> +							   client->name, data,
>> +							   lm80_groups);
>> +	if (IS_ERR(hwmon_dev))
>> +		return PTR_ERR(hwmon_dev);
>>
>>   	return 0;
>
> Why not return PTR_ERR_OR_ZERO?
>
>>   }
>> @@ -614,8 +590,8 @@ static void lm80_init_client(struct i2c_client *client)
>>
>>   static struct lm80_data *lm80_update_device(struct device *dev)
>>   {
>> -	struct i2c_client *client = to_i2c_client(dev);
>> -	struct lm80_data *data = i2c_get_clientdata(client);
>> +	struct lm80_data *data = dev_get_drvdata(dev);
>> +	struct i2c_client *client = data->client;
>>   	int i;
>>   	int rv;
>>   	int prev_rv;
>
> You did not update the dev_dbg() call in this function as you just did
> in adm1021_update_device(). I believe this should be done consistently
> over all drivers. More generally, if we decide to use the hwmon device
> for run-time messages then this should be done in all functions of all
> (converted) hwmon drivers.
>

Hi Jean,

Makes sense. I'll do that in the next revision (and look through other drivers
to do the same there if needed).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
