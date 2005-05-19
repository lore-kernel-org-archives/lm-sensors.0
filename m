From: rtjohnso@eecs.berkeley.edu (Robert T. Johnson)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <1060985846.302.17.camel@dooby.cs.berkeley.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
	<20030806100702.78298ffe.khali@linux-fr.org>
	<1060886657.1006.7121.camel@dooby.cs.berkeley.edu>
	<20030814190954.GA2492@kroah.com>
	<1060912895.1006.7160.camel@dooby.cs.berkeley.edu> 
	<20030815211329.GB4920@kroah.com>
In-Reply-To: <20030815211329.GB4920@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Marcelo Tosatti <marcelo@conectiva.com.br>, sensors@Stimpy.netroedge.com, vsu@altlinux.ru

On Fri, 2003-08-15 at 14:13, Greg KH wrote:
> i2c-dev.c is annotated in 2.6.  Did I miss anything that needs to be
> marked as such?

For this particular bug (before all the patches started flying around),
you'd have to add a kernel annotation to the "struct i2c_msg" field
buf.  But you still have the problem that sparse silently ignores
missing annotations, so you can never tell if you've missed something
important.  Cqual infers the annotations on its own, so you never have
to worry that some might be missing or wrong.

That's also how we get away with just ~200 annotations.  From these
"seed" annotations, cqual figures out everything else on its own.

> > I think all these functions should be changed to take two pointers, only
> > one of which is allowed to be non-NULL.  Then the flag can go away.  I
> > hope to submit a patch to this effect in the future.  I think sparse
> > can't check these either, unless you insert casts between user/kernel. 
> > But inserting casts loses the benefits of the automatic verification,
> > since the casts could be wrong.
> 
> Hm, how about just fixing the tty core to always pass in kernel buffers?
> That would fix the "problem" in one place :)

That's a good idea, but is that possible?  In other words, can the tty
core always tell how much to copy into kernel space?  The solution I
propose is a very simple change that fits easily into the current
architecture.

> Hm, I had already applied your patch, so this one doesn't apply.  Care
> to re-do it against 2.6.0-test4 whenever that comes out?

I was afraid that might happen.  I'll do a patch against test4 when it's
available.  Thanks for your suggestions.

Best,
Rob

