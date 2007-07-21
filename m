From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Jul 2007 20:48:33 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-support-fscpos.patch
Message-Id: <20070721224833.52f6fc61@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46922D2E.60400@hhs.nl>
In-Reply-To: <46922D2E.60400@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 15 Jul 2007 11:40:34 +0200, Hans de Goede wrote:
> Despite you saying that the individual alarms patch should be split up I 
> actually tried to make as little changes as possible. I'm not sure now if that 
> is the best plan, these 2 drivers really need a cleanup, they also need dyn 
> sysfs attr + handlers for example, but I wanted to safe that for later to keep 
> the patches small / manageable.

And I thank you for that. Note that it's always easier to merge two
(incremental) patches afterwards than to split one patch afterwards ;)

> >> @@ -709,8 +756,14 @@ static ssize_t set_watchdog_control(stru
> >>  
> >>  static ssize_t show_watchdog_control(struct fscher_data *data, char *buf, int nr)
> >>  {
> >> -	/* bits 0..3 reserved, bit 5 write only => mask with 0xd0 */
> >> -	return sprintf(buf, "%u\n", data->watchdog[2] & 0xd0);
> >> +	u8 mask;
> >> +
> >> +	if (data->kind = fscher)
> >> +		mask = 0xd0; /* bits 0..3 reserved, 5 write only */
> >> +	else
> >> +		mask = 0x90; /* bits 0..3 & 6 reserved, 5 write only */
> > 
> > ... and 0xb0 here. Any reason why you use different values? If you
> > think the fscpos driver uses the wrong masks, please send a patch to
> > fix them.
> > 
> 
> Bit 5 is write only, so we have no idea what it will return when read, so yes I 
> believe the fscpos driver is using the wrong masks.

It's write-only, but it has a default value of 0... which suggests that
reading from this register will always return 0 for bit 5. Not to say
that masking it out isn't a good idea, but the code we have in fscpos
probably works fine in practice.

>                                                     Alternatively to fixing 
> this we could concider ripping out the watchdog support completely, I would 
> actually prefer that, because as said its nothing more then a couple of raw 
> registers exports. If peope want to get to the raw registers they can use i2c-dev.

It's not that simple, because the fscpos (or fscher) driver requests
the I2C address, so i2c-dev won't be able to use it... unless
I2C_SLAVE_FORCE is used, or direct I2C messaging is used, but we don't
want to encourage either practice. In fact I would like i2c-dev to be
less permissive in the future, I wanted to work on it but as usual it
got preempted by higher-priority tasks.

> >> @@ -720,7 +773,7 @@ static ssize_t set_watchdog_status(struc
> >>  	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
> >>  
> >>  	mutex_lock(&data->update_lock);
> >> -	data->watchdog[1] &= ~v;
> >> +	data->watchdog[1] &= ~v; /* write 1 to clear */
> > 
> > This comment is confusing. You say "write 1 to clear" while the code
> > sets the bit in question to 0, not 1. Please clarify.
> > 
> >>  	fscher_write_value(client, reg, v);
> >>  	mutex_unlock(&data->update_lock);
> >>  	return count;
> 
> The code in question confused me, hence I added the comment to try and clarify 
> it. Notice how v gets masked with 0x02, and thus can only be 0 or 0x02, if its 
> zero, the this line: "data->watchdog[1] &= ~v" does nothing, if its 0x02, then 
> bit 1 of our copy of the watchdog register gets cleared. IOW if the user writes 
> 1 to bit 1 its gets cleared. We update our local copy of the register to 
> reflect this, clearing the bit if a one is written, notice that v is used later 
> to write to the chip, not our copy of the register, so a 1 gets written, 
> clearing the bit and the statement I added the comment to updates our in memory 
> copy to reflect the change caused by this write.
>
> Suggestions for a clearer comment, while not using as much text as I just did, 
> are welcome.

Thanks for the clarification. I'm fine with the comment now, but I
think it should be moved one line down, next to the
fscher_write_value(). If you also want a comment on the first line,
that could be /* update our copy */ (it would probably be more logical
the other way around, BTW.)

>              Alternatively, we could just leave it as is, without any comment 
> at all. Or even better just kill off the pseudo watchdog support entirely.

I admit that this watchdog implementation is less than optimal, and I
would be happy to get rid of it. But now that it has been there for a
while, you can't just kill it. You need to either offer a replacement,
or deprecate it and only plan it for a removal in a (relatively) far
future.

The Linux kernel does have a standard interface for watchdogs, so the
clean solution would be to replace this non-standard interface with the
standard one. I don't know how hard it would be, but I guess probably
not too difficult, especially as you have a chip for testing.

If you really don't have the time to do this, then you will have to
make it clearly visible (Kconfig, documentation, log message) that the
old watchdog interface is deprecated and will be removed, so that
users have a chance to volunteer for the conversion if they care. You
can make it a config option if you want.

Hope that helps,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
