From: bob+sensors@mcelrath.org (Bob McElrath)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: compiling on alpha
Message-Id: <20030407161316.GA579@mcelrath.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am attempting to get the sensors package to compile on alpha (kernel
2.4.21-pre7), and it does not do so cleanly.  I am using the
lm-sensors-source package which is included in debian.  It has a version
2.6.5 from 20020915.  (If the bugs I mention below have been fixed in a
newer version then please disregard this mail)

First, the file kernel/busses/i2c-sis645.c must include the header
<linux/mm.h> in order to get the symbol GFP_ATOMIC.

Second, the Makefile should grab the necessary CFLAGS for modules from
the linux/arch/$(arch)/Makefile.  This can be done with a little
makefile code like this:
    LINUX_SOURCE := /usr/src/linux
    ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
    include $(LINUX_SOURCE)/arch/$(ARCH)/Makefile
This will of course set CFLAGS so maybe save it and put it in MODCFLAGS
for your makefile.  In particular on alpha the compile bombs with:
    /tmp/ccEu5TN5.s: Assembler messages:
    /tmp/ccEu5TN5.s:73: Error: macro requires $at register while noat in effect
unless the compiler flag -mcpu=ev67 is included.  (or whatever CPU the
user has)

Cheers,
Bob McElrath [Univ. of Wisconsin at Madison, Department of Physics]

    "You measure democracy by the freedom it gives its dissidents, not the
    freedom it gives its assimilated conformists." -- Abbie Hoffman

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030407/b12c6e5a/attachment.bin
