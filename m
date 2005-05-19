From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <20050326184427.47bbc9bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant

> Lucky last: it87

I'm commenting on the second version of the patch.

show_sensor is a read function, not write, but I think it needs locking
(the way it is now, at least).

static ssize_t show_sensor(struct device *dev, char *buf, int nr)
{
	struct it87_data *data = it87_update_device(dev);
	if (data->sensor & (1 << nr))
		return sprintf(buf, "3\n");  /* thermal diode */
	if (data->sensor & (8 << nr))
		return sprintf(buf, "2\n");  /* thermistor */
	return sprintf(buf, "0\n");      /* disabled */
}

data->sensor is evaluated twice, and could change in the meantime...
e.g. if value is "thermistor first", and changed to "thermal diode"
between the calls, we'll return "disabled", which is not correct.

One simple fix if we don't want to lock is to store the value of
data->sensor in a local variable, and use it afterwards:

static ssize_t show_sensor(struct device *dev, char *buf, int nr)
{
	struct it87_data *data = it87_update_device(dev);
	u8 reg = data->sensor; /* In case the value is updated while we use it */

	if (reg & (1 << nr))
		return sprintf(buf, "3\n");  /* thermal diode */
	if (reg & (8 << nr))
		return sprintf(buf, "2\n");  /* thermistor */
	return sprintf(buf, "0\n");      /* disabled */
}

> static ssize_t set_fan_div(struct device *dev, const char *buf, 
> 		size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct it87_data *data = i2c_get_clientdata(client);
> 	int val = simple_strtol(buf, NULL, 10);
> 	int i, min[3];
> 
> 	down(&data->update_lock);
> 	u8 old = it87_read_value(client, IT87_REG_FAN_DIV);

Wrong order, you can't do that.

Rest looks OK to me.

Thanks,
-- 
Jean Delvare
