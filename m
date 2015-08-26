From: Il Han <corone.il.han@gmail.com>
Date: Wed, 26 Aug 2015 04:27:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Maxim MAX31790
Message-Id: <CADrkgWLckYEHa11Jrau6WuwvGqjwFK0B3HE35T=Gch0h_7E7gw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2015-08-26 13:15 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:

> On 08/25/2015 08:49 PM, Il Han wrote:
>
>> 2015-08-25 23:52 GMT+09:00 Guenter Roeck <linux@roeck-us.net <mailto:
>> linux@roeck-us.net>>:
>>
>>     On 08/24/2015 10:52 PM, Il Han wrote:
>>
>>         The driver supports the Maxim MAX31790.
>>
>>         Signed-off-by: Il Han <corone.il.han@gmail.com <mailto:
>> corone.il.han@gmail.com>>
>>         ---
>>
>>         +static ssize_t set_fan_target(struct device *dev,
>>         +                             struct device_attribute *devattr,
>>         +                             const char *buf, size_t count)
>>         +{
>>         +       struct sensor_device_attribute *attr >> to_sensor_dev_attr(devattr);
>>         +       struct i2c_client *client = to_i2c_client(dev);
>>         +       struct max31790_data *data = i2c_get_clientdata(client);
>>
>>
>>     Did you test those set functions ?
>>
>>     This should be
>>
>>              struct max31790_data *data = dev_get_drvdata(dev);
>>              struct i2c_client *client = data->client;
>>
>>     The above code crashes, since dev is not an i2c client device.
>>
>>     Guenter
>>
>>
>> I tested them hundreds of times, but not on the latest kernel version.
>> So I am going to modify them.
>>
>> It has nothing to do with the kernel version, but with using the devm_
> function
> to register the hwmon device.
>
>
Right... So I had to modify the _probe function on the other kernel version.

Thanks,
--
Il Han
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
