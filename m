From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <sjtHfYd9.1098429880.9163020.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

>> >static ssize_t set_fan_min(struct device *dev, const char *buf,
>> >		size_t count, int nr)
>> >{
>> >	struct i2c_client *client = to_i2c_client(dev);
>> >	struct adm1026_data *data = i2c_get_clientdata(client);
>> >	int     val;
>> >
>> >	down(&data->update_lock);
>> >	val = simple_strtol(buf, NULL, 10);
>> >	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
>> >	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
>> >		data->fan_min[nr]);
>> >	up(&data->update_lock);
>> >	return count;
>> >}
>
>* Jean Delvare <khali@linux-fr.org> [2004-10-19 12:09:43 +0200]:
>> I see no reason to use the update_lock semaphore here. Other I2C client
>> drivers don't.
>
>This particular function does need the lock: it prevents a race condition
>between data->fan_min[n] and data->fan_div[n].  I.e. the two lines starting
>with the one containing FAN_TO_REG must occur atomically w.r.t. the client
>data structure.
>
>Other drivers may not need it, *iff* they do *not* adjust the fan min/max
>during the set_fan_div function.  This module does make that adjustment.
>
>I think Phil P. was the first to add this code actually, and it was
>something I copied into a couple other drivers (lm78 and asb100 I think).

You're completely right here of course, thanks a lot for pointing my
overlooking out. What I really meant is that I don't see no reason for
locking in the general case (simply writing a voltage limit or something
like that). In the case of the fan divider this is admittedly quite
different and locking is needed.

This answers Justin's question as to where the locking should happen,
sysfs callback function or bus write function. It better be the former
so that only functions actually requiring the lock will use it.

Thanks,

Jean
