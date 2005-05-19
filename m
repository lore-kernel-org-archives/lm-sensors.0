From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [patch] gcc-3.2 problems: i2c local vs. kernel headers
Message-Id: <20030504162646.GA5787@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319172417.GC14159@westend.com>
In-Reply-To: <20030319172417.GC14159@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a long message, sorry...

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-04-29 13:15:48 -0400]:
> * Jean Delvare <khali@linux-fr.org> [2003-04-29 08:43:09 +0200]:
> 
> > I had similar problems as I switched to Slackware 9.0. The main problem
> > is that I first asked the distribution to install kernel headers (as a
> > package), and then installed and compiled my own kernel from sources.
> > Then, as I tried to compile i2c and lm_sensors for this new kernel,
> > headers were a complete mess. The clean solution I used is:
> > 
> > 1* Remove the kernel headers package. This package installed all headers
> > directly in /usr/include, where non-kernel headers also live. These
> > files aren't needed once you have real kernel sources available.
> > 
> > 2* Create the following symlinks (these are *directories*):
> > /usr/include/asm -> /usr/src/linux/include/asm
> > /usr/include/linux -> /usr/src/linux/include/linux
> > This of course assume that you have a complete kernel source tree at
> > /usr/src/linux.
> 
> Please read this:
> 
> http://www.tldp.org/LDP/lfs/html/chapter06/kernel.html#AEN2385
> 
> Slackware and RedHat (glibc-kernheaders) are doing the right thing.
> 

When compiling a program, you want the system headers to match
those which were used to compile your glibc, *not* the currently
running kernel itself.  So, the RH package glibc-kernheaders
installs the headers into /usr/include/{asm,linux} which were
used to build glibc.

After compiling and installing i2c and lm_sensors, those headers
go under /usr/local/include.  The default include order puts this
ahead of /usr/include so that's ok too.  You installed a new libsensors
so you want programs to compile with the new (sensors) headers.

The /usr/include/{asm,linux} links are a bad idea (so says Linus in
the above reference) *unless* you also recompile *all* of your system
libraries to match - something you are unlikely to do every time you
compile a new kernel.

But, the sensors modules themselves need to be compiled against headers
from the kernel with which you expect them to run (this is true for
most kernel modules.)  Ultimately, we want the include order to look
like this for lm_sensors2 kernel modules:

	.                    (from lm_sensors2)
	kernel/include       (from lm_sensors2)
	/usr/local/include   (from i2c)
	$(LINUX_HEADERS)     (target kernel, e.g. ~/src/linux-2.4.21)
	<other GCC includes>
	/usr/include

This is accomplished with older GCCs by specifying -I/usr/local/include
before -I$(LINUX_HEADERS).  But, newer GCC *ignores* the -I/usr/local/include
argument (because it's already considered a system include directory).
So newer GCC produces this instead:

	.
	kernel/include
	$(LINUX_HEADERS)     (target kernel)
	/usr/local/include   (from i2c)
	<other GCC includes>
	/usr/include

This is a problem, because we need the new i2c headers in /usr/local/include
to trump the older ones in $(LINUX_HEADERS).  Christian's patch leads to this:

	.
	kernel/include
	/usr/local/include   (from i2c)
	<other GCC includes>
	/usr/include
	$(LINUX_HEADERS)     (target kernel)

That's still wrong, because we're going to pick up old kernel headers from
/usr/include while compiling the kernel modules.  Now you see why Jean's
method works for lm_sensors2... because he's wacking /usr/include and replacing
it with $(LINUX_HEADERS) - which seems to work for lm_sensors2 but is wrong
for just about every other thing you would want to compile.  (Again, see that
web reference above.)

So after all that, here's a fix as diff from 2.7.0.  It produces the correct
include order (first of 3 above).  This works fine with stock RedHat 9,
keeping glibc-kernheaders intact.  I tested with RedHat 8.0 too.

Jean, could you please test this with Slackware?  Any other comments
before I check it in?

Index: Makefile
=================================RCS file: /home/cvs/lm_sensors2/Makefile,v
retrieving revision 1.60
diff -r1.60 Makefile
181c181
< ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
---
> ALL_CPPFLAGS := -I. -Ikernel/include -isystem $(I2C_HEADERS) -isystem $(LINUX_HEADERS)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
