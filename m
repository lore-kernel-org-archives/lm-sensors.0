From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <20050325211940.03d83b1b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> lm85.c line 409...
> 
> static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
> {
>         struct lm85_data *data = lm85_update_device(dev); <<= lock taken for data refresh cycle
> 
> another updater process may change data while reader not holding lock
> here, harmless?
> 
>         return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr]) ); <<= data read without lock
> }

I see your point, as I figured as much today. But come to think of it,
nothing bad can really happen at this point. You might actually return a
different value of data->fan_min[nr] than the one lm85_update_device had
set. And now what? This is just a new value, which is at least as valid
as the old one was. So I see no problem here.

Now, there *might* be some readers which do more complex things with the
values, for which special care (i.e. locking) would be required. But
that's not the common case as far as I can see.

> > That's nice, please keep it up-to-date. You could name the person who
> > worked on each driver (i.e. you or me so far) so it is easier to spot
> > misses.
> 
> Will do.  
> I'l merge all the drivers into it and mark what we have so far

I have put my patches here:
http://jdelvare.net1.nerim.net/sensors/lock-on-set/

Feel free to review and comment.

As a side note, you'll notice that I did *not* add locking for
data->vrm. This is not a miss, I did on purpose. data->vrm isn't read
frop the chip, so it's not changed by the update function. The sysfs
change function is the only place where the value can change (let alone
init time), so the lock isn't necessary (until someone can prove
otherwise).

> Since you're zooming through most of these, how shall I handle 
> my fan_div patches?  Revert fan_div and do just locking so you 
> can finish that issue?
>
> Then I can do fan_div at slower pace later as it is less 
> important change than correcting locking.

Absolutely, this would be the better approach. Once we have all the
locking fixes, we can do a big patch, co-sign it and send it to Greg.
After that, you are free to go on with whatever fixes you want.

> Fun stuff, me jumping into the deep end?

Yeah, but I'm glad you found these problems. This means that you are
reading the code carefully and you understand how things work (or, in
this case, should have worked). Good for the future.

Thanks,
-- 
Jean Delvare
