From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 06 Nov 2013 19:28:41 +0000
Subject: Re: [lm-sensors] hwmon: (tmp401) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20131106192841.GB22627@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131018142506.GA25585@longonot.mountain>
In-Reply-To: <20131018142506.GA25585@longonot.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guenter Roeck,

The patch 42f309303902: "hwmon: (tmp401) Convert to use
devm_hwmon_device_register_with_groups" from Sep 4, 2013, leads to
the following
static checker warning: "drivers/hwmon/tmp401.c:360 store_temp()
	 warn: 'data' isn't an ERR_PTR"

drivers/hwmon/tmp401.c
   354          struct tmp401_data *data = dev_get_drvdata(dev);
   355          struct i2c_client *client = data->client;
   356          long val;
   357          u16 reg;
   358          u8 regaddr;
   359  
   360          if (IS_ERR(data))
   361                  return PTR_ERR(data);

dev_get_drvdata() returns NULL on error, but I'm not sure if that's
possible here.  Can the check be removed?

regards,
dan carpenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
