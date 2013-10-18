From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Oct 2013 16:13:53 +0000
Subject: Re: [lm-sensors] hwmon: (tmp401) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20131018161353.GA26869@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131018142506.GA25585@longonot.mountain>
In-Reply-To: <20131018142506.GA25585@longonot.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 18, 2013 at 05:25:06PM +0300, Dan Carpenter wrote:
> Hello Guenter Roeck,
> 
> The patch 9aeb5c70e84d: "hwmon: (tmp401) Convert to use 
> devm_hwmon_device_register_with_groups" from Sep 4, 2013, leads to 
> the following warning:
> "drivers/hwmon/tmp401.c:360 store_temp()
> 	 warn: 'data' isn't an ERR_PTR"
> 
> drivers/hwmon/tmp401.c
>    349  static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
>    350                            const char *buf, size_t count)
>    351  {
>    352          int nr = to_sensor_dev_attr_2(devattr)->nr;
>    353          int index = to_sensor_dev_attr_2(devattr)->index;
>    354          struct tmp401_data *data = dev_get_drvdata(dev);
>                                            ^^^^^^^^^^^^^^^^^^^
> Returns NULL.
> 
>    355          struct i2c_client *client = data->client;
>                                             ^^^^^^^^^^^^
> Dereference.
> 
>    356          long val;
>    357          u16 reg;
>    358          u8 regaddr;
>    359  
>    360          if (IS_ERR(data))
>                     ^^^^^^^^^^^^
> Can this test be removed?
> 
Yes, it can. Leftover from earlier code.

Thanks for the note, I'll update the patch.

Did you see this with smatch ? I am running smatch on the branch myself,
but I don't recall seing the report, so I wonder.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
