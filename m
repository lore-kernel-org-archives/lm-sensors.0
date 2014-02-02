From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Feb 2014 21:02:20 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (lm63) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <52EEB25C.9080003@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390243126-19519-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390243126-19519-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/02/2014 12:42 PM, Jean Delvare wrote:
> On Mon, 20 Jan 2014 10:38:46 -0800, Guenter Roeck wrote:
>> Simplify code, reduce code size, attach hwmon attributes to hwmon device.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/lm63.c |  107 ++++++++++++++++++--------------------------------
>>   1 file changed, 39 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
>> index b56cb9f..c0bf82c 100644
>> --- a/drivers/hwmon/lm63.c
>> +++ b/drivers/hwmon/lm63.c
>> (...)
>> @@ -400,8 +400,7 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *devattr,
>>   			const char *buf, size_t count)
>>   {
>>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> -	struct i2c_client *client = to_i2c_client(dev);
>> -	struct lm63_data *data = i2c_get_clientdata(client);
>> +	struct lm63_data *data = dev_get_drvdata(dev);
>
> For consistency with other "set" functions, I'd prefer that you keep
> defining client here...
>
>>   	int nr = attr->index;
>>   	unsigned long val;
>>   	int err;
>> @@ -420,7 +419,7 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *devattr,
>>   	mutex_lock(&data->update_lock);
>>   	data->pwm1[nr] = data->pwm_highres ? val :
>>   			(val * data->pwm1_freq * 2 + 127) / 255;
>> -	i2c_smbus_write_byte_data(client, reg, data->pwm1[nr]);
>> +	i2c_smbus_write_byte_data(data->client, reg, data->pwm1[nr]);
>
> ... and leave this line unchanged. Same for a few other "set" functions
> later in this file.
>
Coincidentally, I came to the same conclusion, and already made that change
for the next revision.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
