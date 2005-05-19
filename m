From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <20040226053831.GA11584@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Bernhard Schrenk <clemy@clemy.org> [2004-02-25 09:26:41 +0100]:
> Hi,
> 
> Please excuse my late response. I have attached the new patch including the
> changes in latest cvs revision (1.15) of the driver and the suggestion from
> Jean to change the descriptive text. The patch is against kernel version
> 2.6.3.

Thanks again!

> > * Jean Delvare <khali@linux-fr.org> [2004-02-21 16:50:17 +0100]:
> > > MMH, can you take care about this port (review, test if possible, and
> > > send to Greg)?
> 
> I can take care about this, but its my first linux kernel patch, so I do not
> really know the required review and test process.

Nothing so formal, really.  Basically...

There's a small group of people that have CVS commit privileges for the
kernel 2.4 and userland stuff.  These same people (but mostly Jean lately)
review any driver work destined for kernel 2.6.  After review, a patch
is sent to Greg KH who is the gatekeeper for I2C and sensors kernel 2.6.

I was going to resubmit your most recent patch to Greg, but you may as
well do that yourself... put [PATCH 2.6] in the subject; put a short
description of what the patch does in the body; attach the patch itself
to the message as *plain text* or even inline with the message body.
Be sure to CC the sensors mailing list.

Some time later, Greg will apply it to his tree; then he'll send a batch
of I2C/sensors patches to LKML.  Later still, your driver will show up
in Linus' tree.

Of course, others may review and comment at every step... however most
of the review for these drivers happens here on this mailing list.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
