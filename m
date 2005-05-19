From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: update_lock
Message-Id: <1080638559.40693c5f97fe9@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Mark M. Hoffman:

First of all, thanks for pointing out the relevant thread. Interesting
read, to say the least.

To answer a question raised there about the read_word capability:
There are two kinds of word reads if I understood correctly. The real
one is implemented in the LM75 for example, where the regiesters are
actually 16-bit wide. The second relies on the auto-increment ability
of some chips, and will return the values of two consecutive 8-bit wide
registers. This is quite different.

I wouldn't use read_word in the second case, because you never know
wether you read the registers from the same hardware update. In various
cases, the two registers that are supposed to assemble into a 9- to
16-bit value are not even adjacent. See what I did in the lm90 driver
to workaround the problem (basically read register A, then B, then A
again, if both A match the read is considered valid, else retry).

Anyway that's not necessarily on-topic.

> > The data->update_lock semaphore is used in the *_update_dev
> > function, and only there.
> 
> Right, but that is not always sufficient.

So we agree.

> > and only there. There are various other places all over the
> > drivers where we access the same internal data, (in get callback
> > functions) and
> > even write to it (in store callback functions typically), and also
> > access the i2c bus (in store functions too).
> > 
> > Why is it that we don't use the lock here?
> 
> It's a bug that's in all the drivers... e.g. from lm78.c:
> 
> 254: static ssize_t set_in_min(struct device *dev, const char *buf,
> 255:                 size_t count, int nr)
> 256: {
> 257:         struct i2c_client *client = to_i2c_client(dev);
> 258:         struct lm78_data *data = i2c_get_clientdata(client);
> 259:         unsigned long val = simple_strtoul(buf, NULL, 10);
> 260:         data->in_min[nr] = IN_TO_REG(val);
> 261:         lm78_write_value(client, LM78_REG_IN_MIN(nr),
> data->in_min[nr]);
> 262:         return count;
> 263: }
> 
> Lines 260 & 261 need to be protected against a simultaneous
> lm78_update_device(), but they're obviously not.

Correct, I missed that possibility.

> > What are we trying to protect exactly?
> 
> As they're written today, the update_lock only prevents multiple
> _update_device() calls from occurring at once.  This is necessary,
> but not sufficient.

Agreed.

> For the above case, you could do this:
> 
> 259:         unsigned long val = simple_strtoul(buf, NULL, 10);
> 260:         /* deleted */
> 261:         lm78_write_value(client, LM78_REG_IN_MIN(nr),
> IN_TO_REG(val));
> 261.5:       data->valid = 0;
> 262:         return count;

I don't like this much. This breaks our caching scheme. Basically, you
invalidate all values just because of one value. Seems too high a price
to pay, especially since you mostly *know* the missing value, you just
wrote it. Why don't we just swap lines 260 and 261? I.e. basically don't
trust data->in_min[nr] (because it can be changed by _update_device())
and use our own, local temporary variable (var). Write to the chip
first, then update data->in_min[nr]. It could still be trashed by
_update_device() after that, unless we also lock on writes. See below.

> However, there are still cases where you need to write two different
> locations atomically, where an intervening _update_device() would be
> bad. Those need to use update_lock.  An example is the
> fan_div/fan_min store.

What do we have to fear exactly. Please give the details of a
troublesome scneario.

What about using my method described above for 9+-bit temperature
values? I don't see anything bad happening if we write a value, then
update the whole thing, then write the second value.

I think that the more elegant solution would be to:
1* Keep locking in _update_device().
2* Lock in _write_value(). Drivers that don't have such a function
(which includes mines) will need one.
3* Never use data->x as a temporary step between scanning user input
(from sysfs) and writing the value to the chip. The correct order is
scan to a temporary value, write it to the chip, and then write it to
data->x, if I understood it properly.

This also assumes that no sysfs callback function is actually allowed to
read from the chip directly (unless the read value is not part of
update_device() realm, but I don't think we have such cases).

BTW I reiterate my agreement with Phil Pokorny's registers split between
input values and limits. Having two different caching periods for these
groups makes much much sense and is likely to speed chip updates up. I
also agree that not updating limits at all wouldn't be clever, since
sometimes motherboards write to them in our backs and it's something we
have to be informed of.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
