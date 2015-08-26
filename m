From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 26 Aug 2015 04:15:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Maxim MAX31790
Message-Id: <55DD3D74.7000203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/25/2015 08:49 PM, Il Han wrote:
> 2015-08-25 23:52 GMT+09:00 Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>:
>
>     On 08/24/2015 10:52 PM, Il Han wrote:
>
>         The driver supports the Maxim MAX31790.
>
>         Signed-off-by: Il Han <corone.il.han@gmail.com <mailto:corone.il.han@gmail.com>>
>         ---
>
>         +static ssize_t set_fan_target(struct device *dev,
>         +                             struct device_attribute *devattr,
>         +                             const char *buf, size_t count)
>         +{
>         +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>         +       struct i2c_client *client = to_i2c_client(dev);
>         +       struct max31790_data *data = i2c_get_clientdata(client);
>
>
>     Did you test those set functions ?
>
>     This should be
>
>              struct max31790_data *data = dev_get_drvdata(dev);
>              struct i2c_client *client = data->client;
>
>     The above code crashes, since dev is not an i2c client device.
>
>     Guenter
>
>
> I tested them hundreds of times, but not on the latest kernel version.
> So I am going to modify them.
>
It has nothing to do with the kernel version, but with using the devm_ function
to register the hwmon device.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
