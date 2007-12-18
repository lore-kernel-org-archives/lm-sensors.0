From: Steve Hardy <steve@linuxrealtime.co.uk>
Date: Tue, 18 Dec 2007 20:56:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] : hwmon - new chip driver for TI
Message-Id: <4768340C.60208@linuxrealtime.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4754441F.1030405@linuxrealtime.co.uk> <20071212022550.d8d3b295.akpm@linux-foundation.org>
In-Reply-To: <20071212022550.d8d3b295.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Andrew,

Thanks your your comments, I'm currently preparing/testing a revised patch based on your suggestions, which I will post later this week.

A couple of comments inline.

Steve

> I wouldn't bother with EXPERIMENTAL personally.  It seems a farily
> pointless thing.
> 

OK, I copied one of the other hwmon drivers, many of which are marked experimental.

>> +static int ads7828_attach_adapter(struct i2c_adapter *adapter);
>> +static int ads7828_detect(struct i2c_adapter *adapter, int address, int 
>> kind);
>> +static void ads7828_init_client(struct i2c_client *client);
>> +static int ads7828_detach_client(struct i2c_client *client);
>> +static struct ads7828_data *ads7828_update_device(struct device *dev);
>> +static u16 ads7828_read_value(struct i2c_client *client, u8 reg);
> 
> I do dislike all these forward declarations, but they're all needed here
> give the order of the functions.  Maybe from my Pascal-on-pdp11 days..
> 

OK, this is due to re-using the driver structure/style of other hwmon drivers, will try to improve.

>> +static int ads7828_attach_adapter(struct i2c_adapter *adapter)
>> +{
>> +    if (!(adapter->class & I2C_CLASS_HWMON))
>> +        return 0;
> 
> Can this happen?

Hmmm, this code exists in pretty much all of the other hwmon drivers, so I will leave it in.

I think it relates to I2C vs ISA connected devices, to avoid detecting something with the correct ID on the wrong bus?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
