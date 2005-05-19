From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: i2c-dev.h
Message-Id: <20030602161450.GG4782@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED81794.9060303@paradyne.com>
In-Reply-To: <3ED81794.9060303@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 01, 2003 at 10:27:06PM -0700, Philip Pokorny wrote:
> So '- km' in the sensors.h comments must be Kyosti...
> 
> There has got to be some common header files between kernel and user space 
> so that data structures and "magic" constants are shared.

No, two separate header files, both kept in sync.  That's the way to do
this today.

> If user space can't include kernel headers, then the kernel will have to 
> include a "user space" header.

Nope, see the many threads on the linux-kernel mailing list about this
issue.

> It would seem to me that the alternative of having two copies of the same 
> data structures and constants would be worse.

Nope.

> When did this become such a big issue?

Always has been :)

> Absolutely, either put the old code back or create another file with the 
> common code that can be included one place or the other...

So does this mean that the drivers/i2c/* files in the 2.4 tree are out
of date with the cvs versions?  If so, I have some changes that are now
in 2.4 that need to be put into the cvs tree...

Also, any reason not to update the in-tree 2.4 kernel versions?

thanks,

greg k-h
