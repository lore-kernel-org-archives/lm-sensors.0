From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041022030806.GD9774@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys:

> >static ssize_t set_fan_min(struct device *dev, const char *buf,
> >		size_t count, int nr)
> >{
> >	struct i2c_client *client = to_i2c_client(dev);
> >	struct adm1026_data *data = i2c_get_clientdata(client);
> >	int     val;
> >
> >	down(&data->update_lock);
> >	val = simple_strtol(buf, NULL, 10);
> >	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
> >	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
> >		data->fan_min[nr]);
> >	up(&data->update_lock);
> >	return count;
> >}

* Jean Delvare <khali@linux-fr.org> [2004-10-19 12:09:43 +0200]:
> I see no reason to use the update_lock semaphore here. Other I2C client
> drivers don't.

This particular function does need the lock: it prevents a race condition
between data->fan_min[n] and data->fan_div[n].  I.e. the two lines starting
with the one containing FAN_TO_REG must occur atomically w.r.t. the client
data structure.

Other drivers may not need it, *iff* they do *not* adjust the fan min/max
during the set_fan_div function.  This module does make that adjustment.

I think Phil P. was the first to add this code actually, and it was
something I copied into a couple other drivers (lm78 and asb100 I think).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
