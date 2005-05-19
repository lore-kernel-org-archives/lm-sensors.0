From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <FhJaayQs.1111667171.3125820.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Surveyed drivers/i2c/chips/*.c containing "_write_value(" and...
>
> The winner is lm85.c :o)
>
> driver          write lock taken status [0]
> --------------  ---------------------------------------------------
> adm1021.c       no, appears to not need it

Out of curiousity, I took a look. See what I found:

	data->value = TEMP_TO_REG(temp);
	adm1021_write_value(client, reg, data->value);

As long as we don't hold update_lock here, it could happen that
data->value is overwritten by an update right inbetween these two lines,
right? Causing the write to become silently useless, which is no good.
So, either the lock should be held even in this most simple write case,
or we should use a temporary variable and put the lines the other way
around:

	w = TEMP_TO_REG(temp);
	adm1021_write_value(client, reg, w);
	data->value = w;

This should be concurrent-update-safe as far as I can see. I don't know
what is preferable, performance-wise. At least, locking is a general
solution to the problem. Temporary variables might be fine for simple
cases like the one above, but it might become a mess for more complex
functions. Also, using locks make it clear to the user that a concurrent
access issue exists. The trick of using local variables isn't as
obvious, and future code cleanup attempts might break it. So all in all
I believe that using the lock is better.

> asb100.c        no locking, needs it 357

True. Currently, data->fan_div[nr] might be overwritten by a concurrent
update.

> ds1621.c        no, appears to not need it
> fscher.c        no, appears to not need it
> fscpos.c        no, appears to not need it
> gl518sm.c       no, appears to not need it

I believe they all do, exactly for the same reason adm1021 does. As long
as data->anything is used to store a new value before it is written to a
register, locking is needed.

> gl520sm.c       no locking, needs it 371

That's right, if both fan1_min and fan2_min are set at the same time,
the current code may miss one of them.

> it87.c          no locking ??

What do you mean? It has the same update_lock the other drivers have,
used only for the big update so far. A quick look shows that it needs
locks for at least the same reason the adm1021 does, let alone possible
multiple functions registers.

Skipping the other ones, as obviously all drivers need lock on register
write for one reason or another.

> lm85.c          Yes -- full locking from data-> access to completion!

How different is it from adm1026 and adm1031? These two ones look all
right to me too.

What about the drivers not listed here? adm1025, lm83, lm90, lm92,
w83l785ts (surprisingly enough, all mine)?

> [0] assuming lock not required until after client init completed

Assumption is correct, locking makes no sense until we create at least
one sysfs file, and sysfs file creations happens after init (if not this
is considered a bug and shall be fixed).

> [1] down() may be before or after: val = simple_strtol(buf, NULL, 10);
> Is this a problem?  Can anthing can stomp 'buf'?

"buf" is ours. There is no reason to hold the lock during the
simple_strtol, so for better performance the down() should be moved
below it.

> Query: Should all drivers follow lm85 model where lock taken by
> write accessors prior to reading data->somevalue through to
> completion?

I think so. Shame on me for not realizing before. I think I remember it
was already discussed here before, and back then I didn't realize what
the issue was, and possibly gave bad advice to drivers porters. Please
forgive me.

> As far as i2c bus saturation or rate limiting goes, that is not
> something for the chip drivers, I now think it it belongs to the
> i2c bus driver.

It doesn't. For one thing, rate limitation is chip-specific, because the
value update time differs from chip to chip. For another, some chips
must *not* be limited in any way, or they become useless (think I/O
expanders). Even for chips where we have a rate limitation, it doesn't
apply to all parts of the driver, so there is no way this can be moved
outside of the driver.

> 'Somebody Else's Problem' --Douglas Adams

In which book is this?

Thanks,
--
Jean Delvare
