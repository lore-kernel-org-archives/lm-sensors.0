From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Feb 2014 16:26:53 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (lm95245) Fix hysteresis temperatures
Message-Id: <530A214D.60905@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393090212-24900-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393090212-24900-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 02/23/2014 01:49 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 22 Feb 2014 09:30:09 -0800, Guenter Roeck wrote:
>> Hysteresis temperatures are defined as absolute temperatures,
>> not as delta value from the critical temperatures.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Don't change indentation
>>      Don't call lm95245_update_device from set function
>>      In set function, actually write the calculated hysteresis
>>      instead of the entered value.
>>
>>   drivers/hwmon/lm95245.c |   30 +++++++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
>> index 3f0956e..d7bcea1 100644
>> --- a/drivers/hwmon/lm95245.c
>> +++ b/drivers/hwmon/lm95245.c
>> @@ -272,27 +272,39 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
>>   	return count;
>>   }
>>
>> +static ssize_t show_crit_hyst(struct device *dev, struct device_attribute *attr,
>> +			char *buf)
>> +{
>> +	struct lm95245_data *data = lm95245_update_device(dev);
>> +	int index = to_sensor_dev_attr(attr)->index;
>> +	int hyst = data->regs[index] - data->regs[8];
>> +
>> +	return snprintf(buf, PAGE_SIZE - 1, "%d\n", hyst * 1000);
>> +}
>> +
>>   static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
>>   			const char *buf, size_t count)
>>   {
>>   	struct i2c_client *client = to_i2c_client(dev);
>>   	struct lm95245_data *data = i2c_get_clientdata(client);
>> +	int index = to_sensor_dev_attr(attr)->index;
>>   	unsigned long val;
>> +	long hyst;
>> +	int limit;
>
> Nitpicking: it makes little sense to have hyst and limit as different
> types.
>
Ok, I'll change that.

>>
>>   	if (kstrtoul(buf, 10, &val) < 0)
>>   		return -EINVAL;
>>
>> -	val /= 1000;
>> -
>> -	val = clamp_val(val, 0, 31);
>> -
>>   	mutex_lock(&data->update_lock);
>>
>> +	limit = i2c_smbus_read_byte_data(client, lm95245_reg_address[index]);
>> +	hyst = limit - val / 1000;
>> +	hyst = clamp_val(hyst, 0, 31);
>
> Note that you don't actually need to hold the lock for that. Access to
> the SMBus itself is already serialized at the bus driver level, and
> you're not touching any field of the data structure (that's what the
> lock is protecting.)
>
I think it was because the valid flag is cleared, to make sure the data
is only re-read after the hysteresis register is written to.

>>   	data->valid = 0;
>
> BTW do you have any idea why the whole cache is invalidated here? I'd
> think that storing hyst as data->regs[8] would be enough?
>

It also ensures that the limit register value in the cache is current,
but since that is not volatile it should not really make a difference.

I'll change that and only update regs[8]. But then I do need the lock,
or at least I think so.

>>
>>   	/* shared crit hysteresis */
>>   	i2c_smbus_write_byte_data(client, LM95245_REG_RW_COMMON_HYSTERESIS,
>> -		val);
>> +		hyst);
>>
>>   	mutex_unlock(&data->update_lock);
>>
>> @@ -378,16 +390,16 @@ static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
>>   static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);
>>   static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_limit,
>>   		set_limit, 6);
>> -static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_limit,
>> -		set_crit_hyst, 8);
>> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_crit_hyst,
>> +		set_crit_hyst, 6);
>>   static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
>>   		STATUS1_LOC);
>>
>>   static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
>>   static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_limit,
>>   		set_limit, 7);
>> -static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_limit,
>> -		set_crit_hyst, 8);
>> +static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_crit_hyst,
>> +		set_crit_hyst, 7);
>>   static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
>>   		STATUS1_RTCRIT);
>>   static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type,
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>

Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
