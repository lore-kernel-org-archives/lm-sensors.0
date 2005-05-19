From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: update_lock
Message-Id: <1080725309.406a8f3d732cb@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Mark M. Hoffman:

> > > For the above case, you could do this:
> > > 
> > > 259:         unsigned long val = simple_strtoul(buf, NULL, 10);
> > > 260:         /* deleted */
> > > 261:         lm78_write_value(client, LM78_REG_IN_MIN(nr),
> > > IN_TO_REG(val));
> > > 261.5:       data->valid = 0;
> > > 262:         return count;
> 
> First let me point out there's still a race in my suggestion above...
> but the worst that can happen is that you would read an old value
> once. In the existing implementation, a write could get lost.

I wouldn't call that a race. I _update_device() is called between the
write and valid=0, you simply get the value you would have gotten
before the write.

A more relevant case would be when setting fan divisors, because you
are
also changing fan mins. If there's an update inbetween the two writes,
the returned set of values is incoherent. This is what I call a race
condition. And that cannot be solved by your data->valid = 0 trick,
(which I definitely don't like). We have to lock on write.

> I understand about the caching, but it's much more simple this way.
> Especially it would be very easy for someone to review one or all
> of our drivers and see a common idiom...
> 
> 	down(&data->update_lock);
> 	lm78_write_value(foo);
> 	/* or maybe read/write multiple registers */
> 	data->valid = 0;
> 	up(&data->update_lock);
> 
> and *know* that there are no races there... at a glance.

The absence of race is guaranteed by the use of the lock, not by the
invalidation of the cached data. I still see no benefit in invalidating
all the cache over simply storing the written value in the cache by
ourselves.

> Actually, it doesn't even need to be two seperate locations.  E.g.
> from asb100.c set_fan_div()...
> 
>         case 2: /* fan 3 */
>                 reg = asb100_read_value(client, ASB100_REG_PIN);
>                 reg = (reg & 0x3f) | (data->fan_div[2] << 6);
>                 asb100_write_value(client, ASB100_REG_PIN, reg);
>                 break;
> 
> This is a classic read-modify-write race.  It's literally impossible
> to get rid of that race if you have something like the BIOS fiddling
> with the chip behind our backs.  But at least our own
> update_device() calls shouldn't get in the way.

I guess you mean, if someone else is *writing* to the same register
between our read and our write? (if only reading, I don't see any race,
like above: you get the old value instead of the new one, andt hat's
all). This simply confirms what I we seem to agree on since the
beginning: we need to lock on write.

> At least in asb100.c, the entire write_value function runs holding a
> different lock because of the bank switching.  Holding the
> update_lock here would accomplish nothing AFAICT.

I think you're correct. Same is true for w83781d and w83627hf, of
course. But that's not the most common case.

> > 3* Never use data->x as a temporary step between scanning user
> > input (from sysfs) and writing the value to the chip. The correct
> > order is scan to a temporary value, write it to the chip, and then
> > write it to data->x, if I understood it properly.
> 
> This is still not sufficient in case you need to do a
> read-modify-write like above.

Correct, not sufficient *and* useless if update and writes all use the
lock. Let's forget about that.

> That applies to all registers whose bits map to more than one sysfs
> file.

I don't get you here. I tend to think this affects all the registers.
Two processes could want to write to the same sysfs file at the same
time.


> So, I think we should grab the lock, do the work, clear data->valid,
> and then let go of the lock.  Are there any objections other than
> forcing a full update_device on the next read?  I don't see that
> update as a problem.

Objection! ;)

As stated several times before, I still don't see how forcing a full
update helps in any way. If update and writing functions all use the
lock, the races problem is solved. All you have to do is update the
cache with the single value you just wrote. I don't much like the idea
of generating activity on the i2c for no reason, speed considerations
left apart.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
