From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: update_lock
Message-Id: <20040330053832.GE27638@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-03-20 18:49:09 +0100]:
> Hi all,
> 
> I have a question about the locking mechanism we have in all our i2c
> client drivers, 2.4 and 2.6 as well.
> 
> The data->update_lock semaphore is used in the *_update_dev function,
> and only there.

Right, but that is not always sufficient.

> and only there. There are various other places all over the drivers
> where we access the same internal data, (in get callback functions) and
> even write to it (in store callback functions typically), and also
> access the i2c bus (in store functions too).
> 
> Why is it that we don't use the lock here?

It's a bug that's in all the drivers... e.g. from lm78.c:

254: static ssize_t set_in_min(struct device *dev, const char *buf,
255:                 size_t count, int nr)
256: {
257:         struct i2c_client *client = to_i2c_client(dev);
258:         struct lm78_data *data = i2c_get_clientdata(client);
259:         unsigned long val = simple_strtoul(buf, NULL, 10);
260:         data->in_min[nr] = IN_TO_REG(val);
261:         lm78_write_value(client, LM78_REG_IN_MIN(nr), data->in_min[nr]);
262:         return count;
263: }

Lines 260 & 261 need to be protected against a simultaneous lm78_update_device(),
but they're obviously not.

> What are we trying to protect exactly?

As they're written today, the update_lock only prevents multiple _update_device()
calls from occurring at once.  This is necessary, but not sufficient.

For the above case, you could do this:

259:         unsigned long val = simple_strtoul(buf, NULL, 10);
260:         /* deleted */
261:         lm78_write_value(client, LM78_REG_IN_MIN(nr), IN_TO_REG(val));
261.5:       data->valid = 0;
262:         return count;

However, there are still cases where you need to write two different locations
atomically, where an intervening _update_device() would be bad.  Those need to
use update_lock.  An example is the fan_div/fan_min store.

I'll try to send a patch later in the week.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
