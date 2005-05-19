From: js@convergence.de (Johannes Stezenbach)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: 2.6.0-test11: i2c-dev.h for userspace
Message-Id: <20031212192132.GC32169@convergence.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com> <20031212185357.GB32169@convergence.de> <20031212190105.GB3038@kroah.com>
In-Reply-To: <20031212190105.GB3038@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 11:01:05AM -0800, Greg KH wrote:
> On Fri, Dec 12, 2003 at 07:53:57PM +0100, Johannes Stezenbach wrote:
> > 
> > I think you create a mess here. Other drivers have usable
> > API include files in /usr/include/linux, why are i2c.h and i2c-dev.h
> > special?
> 
> They aren't.  The rule is:
> 	DO NOT INCLUDE KERNEL HEADER FILES IN USERSPACE TOOLS.
> Please read the archives for lkml on why this is true.

I've read this statement multiple times on lkml, from Linus
and others. And you won't believe it: I'm all for a separation
of driver API includes and kernel includes.

But:

> Yeah, we do need a way to have "sanitized" kernel headers so that
> userspace can include them, but for now, use what your libc provides.

IMHO the problem is that Linux 2.6.0 is about to be released with some
broken driver API include files, and without a clear policy how driver
authors, glibc and distribution maintainers and should handle
the situation in a consistent way.


> > I think that sucks.
> 
> Sorry you feel that way, but the i2c header is not going to be any
> different than any other kernel header at this time.

I think they are different now.


Johannes
