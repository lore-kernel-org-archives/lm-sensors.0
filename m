From: Joe Perches <joe@perches.com>
Date: Tue, 09 Nov 2010 09:59:44 +0000
Subject: Re: [lm-sensors] [PATCH 19/32] drivers/hwmon/pc87360.c: Use pr_fmt
Message-Id: <1289296784.1823.45.camel@Joe-Laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
	 <190459d6c56001d564155d8a73ee8e47024b6149.1287556801.git.joe@perches.com>
	 <20101109103119.4cb66327@endymion.delvare>
In-Reply-To: <20101109103119.4cb66327@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Jim Cromie <jim.cromie@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, 2010-11-09 at 10:31 +0100, Jean Delvare wrote:
> On Tue, 19 Oct 2010 23:51:43 -0700, Joe Perches wrote:
> > Added #define pr_fmt KBUILD_MODNAME ": " fmt
> > Converted printks to pr_<level>
> > Coalesced any long formats
> > Removed prefixes from formats
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/hwmon/pc87360.c |   32 +++++++++++++-------------------
> >  1 files changed, 13 insertions(+), 19 deletions(-)
> The following is left in the driver:
> #ifdef DEBUG
> 			printk(KERN_DEBUG "pc87360: Fan 1: mon=%d "
> 			       "ctrl=%d inv=%d\n", (confreg[0]>>2)&1,
> 			       (confreg[0]>>3)&1, (confreg[0]>>4)&1);
> 			printk(KERN_DEBUG "pc87360: Fan 2: mon=%d "
> 			       "ctrl=%d inv=%d\n", (confreg[0]>>5)&1,
> 			       (confreg[0]>>6)&1, (confreg[0]>>7)&1);
> 			printk(KERN_DEBUG "pc87360: Fan 3: mon=%d "
> 			       "ctrl=%d inv=%d\n", confreg[1]&1,
> 			       (confreg[1]>>1)&1, (confreg[1]>>2)&1);
> #endif
> 
> Is there any reason why you didn't convert these to pr_debug()?

No.  These should be converted to pr_debug as well.

The conversion was done via script and the script doesn't
convert printk(KERN_DEBUG to pr_debug to avoid changing output.

Let me know if you want another patch.

> > @@ -1071,14 +1072,11 @@ static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses
> >  				confreg[3] = superio_inb(sioaddr, 0x25);
> >  
> >  				if (confreg[2] & 0x40) {
> > -					printk(KERN_INFO "pc87360: Using "
> > -					       "thermistors for temperature "
> > -					       "monitoring\n");
> > +					pr_info("Using thermistors for temperature monitoring\n");
> 
> I know checkpatch.pl no longer complains about long lines when they
> include a string, but 98 columns seems excessive to me. It would be
> easy enough to spread over two lines.

Also converted via a script.

If the string is split, it doesn't matter where it's split.
The split just makes it harder to use grep.

Personally, I think it's better to ignore the line length
of format strings completely.  Once it wraps in an editor,
it really doesn't matter how long the line is.

Of course, there are multiple strings in this file that
use dev_<level> that are split across lines that could be
converted as well so it's up to you if you want to leave
those as is.  Let me know if you want another patch to
integrate those dev_<level> format strings.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
