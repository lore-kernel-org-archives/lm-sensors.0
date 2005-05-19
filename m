From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH remove W83781D_RT ???
Message-Id: <20050327185925.6eea45c2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
In-Reply-To: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> no objections. RT was an experiment of mine we should have removed
> long ago.
> 
> what was the bug?

In the 2.6 version of the driver:

static ssize_t
store_rt_reg(struct device *dev, const char *buf, size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct w83781d_data *data = i2c_get_clientdata(client);
	u32 val, i;

	down(&data->update_lock);

	for (i = 0; i < count; i++) {
		val = simple_strtoul(buf + count, NULL, 10); <-- BUG HERE

		/* fixme: no bounds checking 0-255 */
		data->rt[nr - 1][i] = val & 0xff;
		w83781d_write_value(client, W83781D_REG_RT_IDX, i);
		w83781d_write_value(client, W83781D_REG_RT_VAL,
				    data->rt[nr - 1][i]);
	}

	up(&data->update_lock);
	return count;
}

"buf" and "count" are provided by sysfs. "buf" points to a buffer of
length "count". "buf + count", by definition, is outside of the buffer,
so there no chance simple_strtoul() returns anything useful (if it
doesn't simply crash).

So this code cannot work, which IMHO is a proof that nobody ever tried
this so we can remove it.

Thanks,
-- 
Jean Delvare
