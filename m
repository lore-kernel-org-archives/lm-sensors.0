From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <b72c41582s4lum584b71dojehattmjhf1n@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Sat, 26 Mar 2005 18:31:38 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>Mmmm, looks like gl520sm wasn't your best one ;)
horrible, musta got distracted.

>Skipping pcf8574 and pcf8591, they are different chip and might need
>special handling.
does that mean revert and ignore those two?  skip them for now?
pcf8591 seems clean, I left it in, the other has a problem, left 
it out.

>>  	for (i = 0; i < count; i++) {
>>  		val = simple_strtoul(buf + count, NULL, 10);
>
>BTW, there is a bug here, isn't it? "buf + count" makes no sense? "buf +
>i" would make more, but would still not work as far as I can see. It's
>plain broken to me. This would tend to prove that nobody ever used this
>function... Couldn't we just get rid of that RT thing? I always wondered
>who was using this, and now the answer seems to be "no one".

Alright, I made a separate patch to remove it --> kill #ifdef blocks.

on whitespace, line folding:
I see what you mean, no gratuitous cleanups while patching a particular 
issue.  Makes sense.

>Soooo... that's not so bad (except gl520sm), please fix all points I
>listed here and post new patches.
Thanks.  No problems.

other post:
>data->sensor is evaluated twice, and could change in the meantime...
>e.g. if value is "thermistor first", and changed to "thermal diode"
>between the calls, we'll return "disabled", which is not correct.
>
>One simple fix if we don't want to lock is to store the value of
>data->sensor in a local variable, and use it afterwards:

just released lock held during it87_update_device(dev), so we 
don't take lock again, I put in your suggestion.  Can't hurt.


>I would also appreciate if you could review my own patches now. There is
>no reason you would have made mistakes and I wouldn't, after all. The
>best way to check is to apply the patch and check the new driver code.
>Checking the patches directly doesn't help that much, as you'll miss the
>in-function returns lacking up() and the functions lacking locking
>altogether.

for x in /home/public/patch/set-locking/*.diff; do cat $x | patch -p1; done

patching file drivers/i2c/chips/lm87.c
Hunk #3 FAILED at 326.
Hunk #4 FAILED at 338.
2 out of 8 hunks FAILED -- saving rejects to file drivers/i2c/chips/lm87.c.rej

Let's see if I can work it out...

Fixed it, you get yours rediff'd to -mm3 for free :)

>
>Remaining drivers:
>ds1337, isp1301_omap, m41t00, rtc8564: Don't use sysfs, so we don't care
>smsc47b397: read-only, so no changes needed.
>
>So we covered all chip driver :) Once cross-review and fixes are done we
>can build the big patch and send it over.

Okay, I review 28 files, adm1016, adm1031, lm85 moved the 'val =' 
assignment above lock to match the rest, additional small whitespace 
fixups in my patches removed to match original, found nothing with 
your patches, apart from mm2 -> mm3 hiccup noted above.

for x in /home/public/*.diff; do cat $x |patch -p1;done
patching file drivers/i2c/chips/adm1025.c
patching file drivers/i2c/chips/adm1026.c
patching file drivers/i2c/chips/adm1031.c
patching file drivers/i2c/chips/asb100.c
patching file drivers/i2c/chips/ds1621.c
patching file drivers/i2c/chips/fscher.c
patching file drivers/i2c/chips/fscpos.c
patching file drivers/i2c/chips/gl518sm.c
patching file drivers/i2c/chips/gl520sm.c
patching file drivers/i2c/chips/it87.c
patching file drivers/i2c/chips/lm63.c
patching file drivers/i2c/chips/lm75.c
patching file drivers/i2c/chips/lm77.c
patching file drivers/i2c/chips/lm78.c
patching file drivers/i2c/chips/lm80.c
patching file drivers/i2c/chips/lm83.c
patching file drivers/i2c/chips/lm85.c
patching file drivers/i2c/chips/lm87.c
patching file drivers/i2c/chips/lm90.c
patching file drivers/i2c/chips/lm92.c
patching file drivers/i2c/chips/max1619.c
patching file drivers/i2c/chips/pc87360.c
patching file drivers/i2c/chips/pcf8591.c
patching file drivers/i2c/chips/sis5595.c
patching file drivers/i2c/chips/smsc47m1.c
patching file drivers/i2c/chips/via686a.c
patching file drivers/i2c/chips/w83627hf.c
patching file drivers/i2c/chips/w83781d.c

.config has all sensors as modules + ISA + PIIX4 + algos <m> + debug

Assuming this one compiles okay I'll post one big new patch, for 
you to review and co-sign if I got my bit right.  I'll replace 
files in http://scatter.mine.nu/lmsensors/lock-on-set/ to suit, 
as well provide as an all-lock-on-set.tar.bz2.

bugfix

pcf8574.c set_write needs something to limit value to byte size, 
I added "unsigned long val = simple_strtoul(buf, NULL, 10) & 0xff;"
but have left it out of the patchset above.  

fscher.c set_watchdog_status, I had altered the code but put it 
back to the way it was for you to check logic:

        down(&data->update_lock);
        data->watchdog[1] &= ~v;
        fscher_write_value(client, reg, v);
        up(&data->update_lock);

safer or different with:

	fscher_write_value(client, reg, data->watchdog[1]); 

. instead?  Dunno, thought I better leave it as found.

w83781d.c remove W83781D_RT I made a patch to do this, applies 
after locking patch.

All drivers compile tested, and again as a unit from which I'll 
drag out the big patch matching list above.

Also send bugfix as RFC patches again.

Cheers,
Grant.
