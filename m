From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <20050327110109.1d501a12.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > Skipping pcf8574 and pcf8591, they are different chip and might need
> > special handling.
>
> does that mean revert and ignore those two?  skip them for now?
> pcf8591 seems clean, I left it in, the other has a problem, left 
> it out.

I discusses these with Aurelien Jarno, which knows the drivers better
than I do as he actually uses them, and our conclusion are:

* pcf8574: no locking is needed AT ALL (nor even in the update function,
which BTW should be merged into show_read). So forget about this one for
this patch set. I have a specific patch ready for this one, which I'll
post separately.

* pcf8591: The lock on data->control is actually needed (second part of
the patch) but the lock on data->aout is not, because nowhere else this
value is modified.

> Alright, I made a separate patch to remove it --> kill #ifdef blocks.

Thanks. You only forgot to kill this line:
#define W83781D_RT                    1


> for x in /home/public/patch/set-locking/*.diff; do cat $x | patch -p1;
> done
> 
> patching file drivers/i2c/chips/lm87.c
> Hunk #3 FAILED at 326.
> Hunk #4 FAILED at 338.
> 2 out of 8 hunks FAILED -- saving rejects to file
> drivers/i2c/chips/lm87.c.rej
> 
> Let's see if I can work it out...
> 
> Fixed it, you get yours rediff'd to -mm3 for free :)

Hmm no that's not correct. My original patch was correct but assumed
that you apply this preliminary patch before:
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.12-rc1-mm2-i2c-lm87-indent.diff

It was posted on the list already:
http://archives.andrew.net.au/lm-sensors/msg30209.html
So I know Greg will pick it before applying our big lock-on-write patch.
Please restore my original version of the patch.

> bugfix
> 
> pcf8574.c set_write needs something to limit value to byte size, 
> I added "unsigned long val = simple_strtoul(buf, NULL, 10) & 0xff;"
> but have left it out of the patchset above.  

I have come to something better and more complete, I think.
http://jdelvare.net1.nerim.net/sensors/linux-2.6.12-rc1-mm3-i2c-pcf8574-cleanups.diff
Aurelien Jarno will test it.

> fscher.c set_watchdog_status, I had altered the code but put it 
> back to the way it was for you to check logic:
> 
>         down(&data->update_lock);
>         data->watchdog[1] &= ~v;
>         fscher_write_value(client, reg, v);
>         up(&data->update_lock);
> 
> safer or different with:
> 
> 	fscher_write_value(client, reg, data->watchdog[1]); 
> 
> .. instead?  Dunno, thought I better leave it as found.

The code looks strange to me too, but I wouldn't change it, at least not
without reading the datasheet twice first.

> w83781d.c remove W83781D_RT I made a patch to do this, applies 
> after locking patch.

Correct.

Thanks,
-- 
Jean Delvare
