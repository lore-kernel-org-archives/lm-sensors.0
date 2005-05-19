From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: i2c-dev.h
Message-Id: <20030602181124.GA5601@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED81794.9060303@paradyne.com>
In-Reply-To: <3ED81794.9060303@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 02, 2003 at 10:58:15AM -0700, Philip Pokorny wrote:
> Greg KH wrote:
> >On Sun, Jun 01, 2003 at 10:27:06PM -0700, Philip Pokorny wrote:
> >
> >>So '- km' in the sensors.h comments must be Kyosti...
> >>
> >>There has got to be some common header files between kernel and user 
> >>space so that data structures and "magic" constants are shared.
> >
> >No, two separate header files, both kept in sync.  That's the way to do
> >this today.
> 
> How are they kept in sync.  Force of will?  Without some automatic way 
> to keep them in sync you've just exchanged one set of problems for 
> another...

Right now, you are correct.  Force of will is all we got :)

> 
> >>If user space can't include kernel headers, then the kernel will have to 
> >>include a "user space" header.
> >
> >Nope, see the many threads on the linux-kernel mailing list about this
> >issue.
> 
> OK.  So H Peter Anvin suggested something very like what I'm suggesting 
> here:
> 
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=aho5ql%249ja%241%40cesium.transmeta.com
> 
> Google doesn't seem to turn up much else on the linux.kernel mailing 
> list other than "IOCTL's are bad" comments (and the variations that boil 
> down to "BINARY interfaces are bad")  I would view this as supporting my 
> position that it's annoying (and has been for a long time), but not 
> worse than the alternatives and not so annoying as to require fixing.

For 2.5/2.6 someone could step up to the plate and do the work right
now.  Otherwise this is going to be a 2.7 thing.

> >>It would seem to me that the alternative of having two copies of the same 
> >>data structures and constants would be worse.
> >
> >Nope.
> 
> So we disagree...

Heh, I understand, but the only way that we are allowed to do this is to
keep two copies.  Well, you can have one in the cvs tree, and there will
be one in the main kernel source tree.

And yes, ioctls are bad :)

thanks,

greg k-h
