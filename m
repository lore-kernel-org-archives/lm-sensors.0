From: rtjohnso@eecs.berkeley.edu (Robert T. Johnson)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <1061168082.16691.120.camel@dooby.cs.berkeley.edu>
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
	<1060985846.302.17.camel@dooby.cs.berkeley.edu> 
	<20030815235127.GA5697@kroah.com>
In-Reply-To: <20030815235127.GA5697@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, sensors@Stimpy.netroedge.com, vsu@altlinux.ru

On Fri, 2003-08-15 at 16:51, Greg KH wrote:
> On Fri, Aug 15, 2003 at 03:17:25PM -0700, Robert T. Johnson wrote:
> > For this particular bug (before all the patches started flying around),
> > you'd have to add a kernel annotation to the "struct i2c_msg" field
> > buf.
> 
> Look at 2.6, that annotatation is already there.

I just double-checked my copy of linux-2.6.0-test3, and I don't see it. 
Just to make sure we're talking about the same thing, I'm looking at
include/linux/i2c.h:402, i.e. the definition of field buf in struct
i2c_msg.

Now I see you have the msgs field of i2c_rdwr_ioctl_arg annotated as
__user.  That should've generated a warning from sparse.  Looks like a
bug in sparse to me.

> Nice, is cqual released somewhere so that we can compare it and start
> using it, like we already use sparse?

I just discussed it with the other developers, and we'll work on getting
a release out in the next week or so.  It still has rough edges, but
feedback from kernel developers like yourself will be invaluable.

> Yes it is, one of the paramaters in those functions is the size of the
> buffer :)

Oh.  Now I'm sold on your solution.  Thanks for pointing that out.

Best,
Rob

