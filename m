From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <20030814190954.GA2492@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806100702.78298ffe.khali@linux-fr.org>
In-Reply-To: <20030806100702.78298ffe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 14, 2003 at 11:44:08AM -0700, Robert T. Johnson wrote:
> Thank you for looking at my bug report and proposed patch with such
> careful scrutiny!  I think the mem leak fix you propose is fine, but I
> had an ulterior motive for writing the user/kernel fix as I did. 
> 
> The user/kernel bug was discovered by our automatic bug-finding tool,
> cqual, and my patch allowed i2c-dev.c to pass through cqual with no
> warnings.  The new patch does not, because rdwr_pa[i].buf is sometimes a
> a user pointer and sometimes a kernel pointer, e.g. on i2c-dev.c, line
> 248:
> 
> 
> data_ptrs[i] = rdwr_pa[i].buf; // rdwr_pa[i].buf is user pointer
> rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL); // now it's kernel
> 
> 
> Cqual is not just a bug finder, it can verify the _absence_ of bugs.  I
> think this is pretty cool.  Imagine a kernel that can be automatically
> verified to have no user/kernel bugs.  You'd never have to worry about
> user/kernel bugs again!

Hm, much like Linus's sparse does already?  :)

> But like all automatic code verification tools, cqual imposes certain
> limits on the types of code you can write.  For example, cqual doesn't
> allow a variable to sometimes hold a user pointer and sometimes hold a
> kernel pointer, like rdwr_pa[i].buf now does.  The original patch avoids
> this, but the new patch doesn't for performance reasons.  FWIW, I think
> Linus' checker will also fail to check the new patch. 

His checker missed the 2.6 version of this, for some reason, I haven't
taken the time to figure out why.

How is cqual going to handle all of the tty drivers which can have a
pointer be either a userspace pointer, or a kernel pointer depending on
the value of another paramater in a function?

> So there's a trade-off here between performance and automatic code
> auditing.  Considering that 
> 
> 1. The performance cost of the original patch is minor. 
> 2. i2c-dev.c has had user/kernel bugs in the past. 
> 3. This user/kernel bug was tricky and time consuming to understand. 

4. no one really uses i2c-dev at all...

> After looking at your rewritten patch, I thought of a possibly cleaner
> way to make i2c-dev.c pass cqual without warnings.  I've included it
> below.  I'd like to work with the i2c developers to find a solution
> which can be automatically audited and that you like. 

If you want to change the kernel to user interface like this, I suggest
you do this for 2.6 first, let's not disturb that interface during the
2.4 stable kernel series.

Want to re-do this patch against 2.6.0-test3?

Actually, why not just create a i2cfs for stuff like this and get rid of
the ioctl crap all together...  Almost no one uses this (as is evident
by a lack of 64 bit translation layer logic), and ioctls are a giant
pain (as evidenced by the need for the 64 bit translation layer.)   It
also forces users to program in languages that allow ioctls.

Anyway, just a thought, as I really do not like the logic in i2c-dev.c
at all...

Oh, this should be discussed on lkml too, not just the sensors mailing
list.

thanks,

greg k-h
