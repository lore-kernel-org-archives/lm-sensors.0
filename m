From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Apr 2014 01:12:38 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/3] hwmon: (lm77) Drop function macros
Message-Id: <53547086.80101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140421004503.7b0b557a@endymion.delvare>
In-Reply-To: <20140421004503.7b0b557a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/20/2014 03:45 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 20 Apr 2014 11:41:17 -0700, Guenter Roeck wrote:
>> Function macros make the code harder to read and increase code size,
>> so drop them.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3: No comma after t_num_entries.
>>      Make temp_regs const and provide array size.
>
> I see the const but not the array size, see below.
>
>>      Fix show_temp_hyst, specifically display of low limit hysteresis.
>>      Simplify set_temp and handling of hysteresis.
>
> I'm afraid you introduced a regression with that change, see below.
>
>> --- a/drivers/hwmon/lm77.c
>> +++ b/drivers/hwmon/lm77.c
>> (...)
>> +static const u8 temp_regs[] = {
>
> No t_num_temp?
>
I think I must be getting old :-(

>> +	[t_input] = LM77_REG_TEMP,
>> +	[t_min] = LM77_REG_TEMP_MIN,
>> +	[t_max] = LM77_REG_TEMP_MAX,
>> +	[t_crit] = LM77_REG_TEMP_CRIT,
>> +	[t_hyst] = LM77_REG_TEMP_HYST,
>> +};
>> +
>>   /* Each client has this additional data */
>>   struct lm77_data {
>>   	struct device		*hwmon_dev;
>>   	struct mutex		update_lock;
>>   	char			valid;
>>   	unsigned long		last_updated;	/* In jiffies */
>> -	int			temp_input;	/* Temperatures */
>> -	int			temp_crit;
>> -	int			temp_min;
>> -	int			temp_max;
>> -	int			temp_hyst;
>> +	int			temp[t_num_temp];/* index using temp_index */
>
> A space between ; and /* would improve readability IMHO.
>
ok

>>   	u8			alarms;
>>   };
>
>> (...)
>> +static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
>> +			const char *buf, size_t count)
>>   {
>> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>>   	struct i2c_client *client = to_i2c_client(dev);
>>   	struct lm77_data *data = i2c_get_clientdata(client);
>> -	unsigned long val;
>> -	int err;
>> +	int nr = attr->index;
>> +	int err, oldhyst;
>> +	long val;
>>
>> -	err = kstrtoul(buf, 10, &val);
>> +	err = kstrtol(buf, 10, &val);
>>   	if (err)
>>   		return err;
>>
>>   	mutex_lock(&data->update_lock);
>> -	data->temp_hyst = data->temp_crit - val;
>> -	lm77_write_value(client, LM77_REG_TEMP_HYST,
>> -			 LM77_TEMP_TO_REG(data->temp_hyst));
>> +	if (nr = t_crit) {
>> +		/* preserve hysteresis when setting T_crit */
>> +		oldhyst = data->temp[nr] - data->temp[t_hyst];
>> +		data->temp[t_hyst] = data->temp[nr] - oldhyst;
>
> The above pair of lines is a no-op. You want to use val (the new value)
> in the second line, instead of data->temp[nr] (the old value.)
>
> That being said, if you are going to remove this feature in the next
> patch, you might as well swap the patches and remove it first. That way
> you won't have to deal with it here.
>
Guess I am going to do just that.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
