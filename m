From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 18 Oct 2013 14:25:06 +0000
Subject: Re: [lm-sensors] hwmon: (tmp401) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20131018142506.GA25585@longonot.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guenter Roeck,

The patch 9aeb5c70e84d: "hwmon: (tmp401) Convert to use 
devm_hwmon_device_register_with_groups" from Sep 4, 2013, leads to 
the following warning:
"drivers/hwmon/tmp401.c:360 store_temp()
	 warn: 'data' isn't an ERR_PTR"

drivers/hwmon/tmp401.c
   349  static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
   350                            const char *buf, size_t count)
   351  {
   352          int nr = to_sensor_dev_attr_2(devattr)->nr;
   353          int index = to_sensor_dev_attr_2(devattr)->index;
   354          struct tmp401_data *data = dev_get_drvdata(dev);
                                           ^^^^^^^^^^^^^^^^^^^
Returns NULL.

   355          struct i2c_client *client = data->client;
                                            ^^^^^^^^^^^^
Dereference.

   356          long val;
   357          u16 reg;
   358          u8 regaddr;
   359  
   360          if (IS_ERR(data))
                    ^^^^^^^^^^^^
Can this test be removed?

   361                  return PTR_ERR(data);
   362  

regards,
dan carpenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
