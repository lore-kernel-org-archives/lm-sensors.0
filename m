From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 23 Jan 2016 13:51:04 +0000
Subject: Re: [lm-sensors] [PATCH v2] rtc: rtc-ds1307: add temperature sensor support for ds3231
Message-Id: <CAC5umyhTLQVqNcC5JFhUPhpC5H=cmj0znwn022Ez-LYy_jUOnA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453485441-11667-1-git-send-email-akinobu.mita@gmail.com>
	<56A27A11.1010805@roeck-us.net>
In-Reply-To: <56A27A11.1010805@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

2016-01-23 3:50 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
>> +static ssize_t ds3231_hwmon_show_temp(struct device *dev,
>> +                               struct device_attribute *attr, char *buf)
>> +{
>> +       struct ds1307   *ds1307 = dev_get_drvdata(dev);
>
>
> space instead of tab ?

OK.

>> +       struct i2c_client *client = ds1307->client;
>> +       u8 temp_buf[2];
>> +       s16 temp;
>> +       int control;
>> +       int status;
>> +       s32 ret;
>> +       unsigned long timeout;
>> +
>> +       status = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
>> +       if (status < 0)
>> +               return status;
>> +
>> +       /*
>> +        * Start user-initiated temperature conversion
>> +        */
>> +       if (!(status & DS3231_BIT_BSY)) {
>> +               struct mutex    *lock = &ds1307->rtc->ops_lock;
>> +
>> +               mutex_lock(lock);
>> +
>> +               control = i2c_smbus_read_byte_data(client,
>> DS1337_REG_CONTROL);
>> +               if (control < 0) {
>> +                       mutex_unlock(lock);
>> +                       return control;
>> +               }
>> +               ret = i2c_smbus_write_byte_data(client,
>> DS1337_REG_CONTROL,
>> +                                               control |
>> DS3231_BIT_CONV);
>> +               if (ret)
>> +                       return ret;
>> +
>
> Leaks the lock. It might be better to define error abort handling with a
> label.

You are right.  But as you suggested, I'll remove user-initiated
temperature conversion code, so no lock is required because
it's not necessary to update control register.

>> +               mutex_unlock(lock);
>
>
> Another conversion could be initiated at this point.
> It might be better to keep the lock until the sequence is complete.

Alarm handling also acquires this lock to update control register,
so I did not want to delay it by holding this lock longer.

>> +
>> +               /*
>> +                * A user-initiated temperature conversion does not affect
>> +                * the BSY bit for approximately 2ms.
>> +                */
>> +               usleep_range(2000, 3000);
>> +       }
>> +
>> +       /*
>> +        * Wait until the conversion is finished
>> +        */
>> +       timeout = jiffies + HZ;
>
>
> Can it really take that long ? Datashet gives a maximum of 200 ms.

You are right, I just checked that 200ms is enough.  Although this
code will also be removed as described above.

>> +
>> +       do {
>> +               control = i2c_smbus_read_byte_data(client,
>> DS1337_REG_CONTROL);
>> +               if (control < 0)
>> +                       return control;
>> +               if (!(control & DS3231_BIT_CONV))
>> +                       break;
>> +               if (time_after(jiffies, timeout))
>> +                       return -EIO;
>> +               usleep_range(2000, 3000);
>> +       } while (1);
>> +
>> +       ret = ds1307->read_block_data(ds1307->client,
>> DS3231_REG_TEMPERATURE,
>> +                                       sizeof(temp_buf), temp_buf);
>
>
> I am not sure if using read_block_data() is worth the complexity.
> Two individual calls to i2c_smbus_read_byte_data() seem to be
> much more straightforward.

I would like to keep using ds1307->read_block_data because other code
in this driver tries to use it for reading multiple registers at once.

>> +       if (ret < 0)
>> +               return ret;
>> +       if (ret != sizeof(temp_buf))
>> +               return -EIO;
>
>
> [ ... and would also avoid the odd -EIO here ]
>
> Please consider just relying on internal/automatic conversions. True,
> those only occur every 64 seconds, but given the accuracy of +- 3
> degrees C I don't think the gain of an immediate conversion outweighs
> the additional code complexity and the resulting delay.

OK, it makes sense.  I'll just drop the code for an immediate conversion.
If there were an interface to forcibly start retrieving sensor data, I could
keep it.

>> +
>> +       /*
>> +        * Temperature is represented as a 10-bit code with a resolution
>> of
>> +        * 0.25 degree celsius and encoded in two's complement format.
>> +        */
>> +       temp = (temp_buf[0] << 8) | temp_buf[1];
>> +       temp >>= 6;
>> +
>> +       return sprintf(buf, "%d\n", temp * 250);
>> +}
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3231_hwmon_show_temp,
>> +                       NULL, 0);
>> +
>> +static struct attribute *ds3231_hwmon_attrs[] = {
>> +       &sensor_dev_attr_temp1_input.dev_attr.attr,
>> +       NULL,
>> +};
>> +ATTRIBUTE_GROUPS(ds3231_hwmon);
>> +
>> +static int ds1307_hwmon_register(struct ds1307 *ds1307)
>> +{
>> +       if (ds1307->type != ds_3231)
>> +               return 0;
>> +
>> +       devm_hwmon_device_register_with_groups(&ds1307->client->dev,
>> +                                               ds1307->client->name,
>> +                                               ds1307,
>> ds3231_hwmon_groups);
>> +
>
> No error check ?
>
> It might make sense to not fail registration if this call fails,
> but maybe a warning in the console log would make sense.

Make sense.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
