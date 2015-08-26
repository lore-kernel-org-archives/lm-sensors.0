From: Il Han <corone.il.han@gmail.com>
Date: Wed, 26 Aug 2015 03:49:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Maxim MAX31790
Message-Id: <CADrkgW+99tyxXnq1-j-suF0whq6PGxy=jDWyadr4soctmfm8+g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2015-08-25 23:52 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:

> On 08/24/2015 10:52 PM, Il Han wrote:
>
>> The driver supports the Maxim MAX31790.
>>
>> Signed-off-by: Il Han <corone.il.han@gmail.com>
>> ---
>>
>> +static ssize_t set_fan_target(struct device *dev,
>> +                             struct device_attribute *devattr,
>> +                             const char *buf, size_t count)
>> +{
>> +       struct sensor_device_attribute *attr >> to_sensor_dev_attr(devattr);
>> +       struct i2c_client *client = to_i2c_client(dev);
>> +       struct max31790_data *data = i2c_get_clientdata(client);
>>
>
> Did you test those set functions ?
>
> This should be
>
>         struct max31790_data *data = dev_get_drvdata(dev);
>         struct i2c_client *client = data->client;
>
> The above code crashes, since dev is not an i2c client device.
>
> Guenter
>
>
I tested them hundreds of times, but not on the latest kernel version.
So I am going to modify them.

Thanks,
--
Il Han


>
> +       u8 bits;
>> +       int sr;
>> +       int target_count;
>> +       unsigned long rpm;
>> +       int err;
>> +
>> +       err = kstrtoul(buf, 10, &rpm);
>> +       if (err)
>> +               return err;
>> +
>> +       mutex_lock(&data->update_lock);
>> +
>> +       rpm = clamp_val(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
>> +       bits = bits_for_tach_period(rpm);
>> +       data->fan_dynamics[attr->index] >> +                       ((data->fan_dynamics[attr->index]
>> +                         & ~MAX31790_FAN_DYN_SR_MASK)
>> +                        | (bits << MAX31790_FAN_DYN_SR_SHIFT));
>> +       err = i2c_smbus_write_byte_data(client,
>> +                       MAX31790_REG_FAN_DYNAMICS(attr->index),
>> +                       data->fan_dynamics[attr->index]);
>> +
>> +       if (err < 0) {
>> +               mutex_unlock(&data->update_lock);
>> +               return err;
>> +       }
>> +
>> +       sr = get_tach_period(data->fan_dynamics[attr->index]);
>> +       target_count = RPM_TO_REG(rpm, sr);
>> +       target_count = clamp_val(target_count, 0x1, 0x7FF);
>> +
>> +       data->target_count[attr->index] = target_count << 5;
>> +
>> +       err = i2c_smbus_write_word_swapped(client,
>> +                       MAX31790_REG_TARGET_COUNT(attr->index),
>> +                       data->target_count[attr->index]);
>> +
>> +       mutex_unlock(&data->update_lock);
>> +
>> +       if (err < 0)
>> +               return err;
>> +
>> +       return count;
>> +}
>>
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
