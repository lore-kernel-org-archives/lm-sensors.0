From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 11 Aug 2011 19:55:49 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: Add interrupt support to
Message-Id: <20110811195549.GA31135@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-3-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-3-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 11, 2011 at 09:48:51PM +0200, Henrik Rydberg wrote:
> On Wed, Aug 10, 2011 at 10:18:40AM -0700, Guenter Roeck wrote:
> > On Tue, 2011-08-09 at 12:14 -0400, Matthew Garrett wrote:
> > > The applesmc hardware supports providing interrupts for significant
> > > accelerometer events. Add framework for this - we'll want to notify
> > > userspace on these in the long run to handle head unloading, but we need
> > > to figure out the best interface for that first. Code based on a patch by
> > > Nicolas Boichat and the FreeBSD kernel code.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > > Cc: Nicolas Boichat <nicolas@boichat.ch>
> > 
> > Not sure if the overall code makes sense w/o actual use of the
> > interrupts, just to fill up the log. I'd like to get some feedback from
> > others on this.
> 
> The notion is exciting, but I agree with Guenter, no point adding it
> without usecase.

What kind of interface should we be presenting? We can't simply use it 
to send events on the existing input device because that's already 
defined as a polled input device.

> > > +	buffer[0] = 0xe0;
> > > +	buffer[1] = 0xf8;
> > > +	ret = applesmc_write_key_check(pdev, MOTION_SENSOR_KEY, buffer, 2);
> 
> Lots of buffer setting and calls to a new function - perhaps the
> function arguments should be modified?

Not without either making it varargs (no) or preventing it from being 
generalisable. We only use it for a maximum buffer size of 2 right now, 
but there's nothing in the hardware restricting it to that.

> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> 
> Is the list above exhaustive?

It's everything I've been able to glean from existing code and what I've 
been able to get the hardware to do myself.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
