From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: update_lock
Message-Id: <20040331033659.GD29782@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-03-30 11:22:39 +0200]:
> According to Mark M. Hoffman:

> > For the above case, you could do this:
> > 
> > 259:         unsigned long val = simple_strtoul(buf, NULL, 10);
> > 260:         /* deleted */
> > 261:         lm78_write_value(client, LM78_REG_IN_MIN(nr),
> > IN_TO_REG(val));
> > 261.5:       data->valid = 0;
> > 262:         return count;

First let me point out there's still a race in my suggestion above... but
the worst that can happen is that you would read an old value once. In the
existing implementation, a write could get lost.

> I don't like this much. This breaks our caching scheme. Basically, you
> invalidate all values just because of one value. Seems too high a price
> to pay, especially since you mostly *know* the missing value, you just
> wrote it. Why don't we just swap lines 260 and 261? I.e. basically don't
> trust data->in_min[nr] (because it can be changed by _update_device())
> and use our own, local temporary variable (var). Write to the chip
> first, then update data->in_min[nr]. It could still be trashed by
> _update_device() after that, unless we also lock on writes. See below.

I understand about the caching, but it's much more simple this way.
Especially it would be very easy for someone to review one or all
of our drivers and see a common idiom...

	down(&data->update_lock);
	lm78_write_value(foo);
	/* or maybe read/write multiple registers */
	data->valid = 0;
	up(&data->update_lock);

and *know* that there are no races there... at a glance.

> > However, there are still cases where you need to write two different
> > locations atomically, where an intervening _update_device() would be
> > bad. Those need to use update_lock.  An example is the
> > fan_div/fan_min store.
> 
> What do we have to fear exactly. Please give the details of a
> troublesome scneario.

Actually, it doesn't even need to be two seperate locations.  E.g.
from asb100.c set_fan_div()...

        case 2: /* fan 3 */
                reg = asb100_read_value(client, ASB100_REG_PIN);
                reg = (reg & 0x3f) | (data->fan_div[2] << 6);
                asb100_write_value(client, ASB100_REG_PIN, reg);
                break;

This is a classic read-modify-write race.  It's literally impossible
to get rid of that race if you have something like the BIOS fiddling
with the chip behind our backs.  But at least our own update_device()
calls shouldn't get in the way.

> What about using my method described above for 9+-bit temperature
> values? I don't see anything bad happening if we write a value, then
> update the whole thing, then write the second value.
> 
> I think that the more elegant solution would be to:
> 1* Keep locking in _update_device().

No dispute there, see my other message. [1]

> 2* Lock in _write_value(). Drivers that don't have such a function
> (which includes mines) will need one.

At least in asb100.c, the entire write_value function runs holding a
different lock because of the bank switching.  Holding the update_lock
here would accomplish nothing AFAICT.

> 3* Never use data->x as a temporary step between scanning user input
> (from sysfs) and writing the value to the chip. The correct order is
> scan to a temporary value, write it to the chip, and then write it to
> data->x, if I understood it properly.

This is still not sufficient in case you need to do a read-modify-write
like above.  That applies to all registers whose bits map to more than
one sysfs file.

So, I think we should grab the lock, do the work, clear data->valid, and
then let go of the lock.  Are there any objections other than forcing a full
update_device on the next read?  I don't see that update as a problem.
(Again, see [1])

I'll try to send an example patch later this week.

> This also assumes that no sysfs callback function is actually allowed to
> read from the chip directly (unless the read value is not part of
> update_device() realm, but I don't think we have such cases).

Yes, this is relatively clean and we should keep it that way.

[1] http://archives.andrew.net.au/lm-sensors/msg07255.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
