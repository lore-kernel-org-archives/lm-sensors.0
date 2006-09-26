From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 20:17:03 +0000
Subject: [lm-sensors] 2.10.1: No rule to make target `asm/io.h',
Message-Id: <20060926221703.fdcaf3c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926135555.GH10410@neu.nirvana>
In-Reply-To: <20060926135555.GH10410@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Axel,

> On Tue, Sep 26, 2006 at 08:56:48PM +0200, Jean Delvare wrote:
> > > > No, it looks like /usr/include/asm/io.h was recently dropped.
> > > 
> > > Ah, looking at the previous (current) release the contents of asm/io.h
> > > are
> > > 
> > > | #ifndef _ASM_IO_H
> > > | #define _ASM_IO_H
> > > | 
> > > | #warning <asm/io.h> is deprecated, use <sys/io.h> instead
> > > | #include <sys/io.h>
> > > | 
> > > | #endif
> > 
> > I found some posts along these lines on the web. However, I take that
> > you never saw this warning, because our code reads:
> > 
> > /* To keep glibc2 happy */
> > #if defined(__GLIBC__) && __GLIBC__ = 2 && __GLIBC_MINOR__ >= 0
> > #include <sys/io.h>
> > #else
> > #include <asm/io.h>
> > #endif
> > 
> > So it should look for sys/io.h rather than asm/io.h. It does for me.
> > I suspect that the test on __GLIBC__ somehow fails for you. Can you
> > please give a try to the following program?
> 
> I returns the expected result:
> 
> __GLIBC__ = 2
> __GLIBC_MINOR__ = 4

Hmmm...

Can you try replacing in prog/dump/isadump.c:

/* To keep glibc2 happy */
#if defined(__GLIBC__) && __GLIBC__ = 2 && __GLIBC_MINOR__ >= 0
#include <sys/io.h>
#else
#include <asm/io.h>
#endif

With simply:

#include <sys/io.h>

And report? I'd like to make sure it's that part of the code causing
problem.

(You'll need to do the same in superio.c and isaset.c if it works.)

If it doesn't help, please provide the preprocessed output:

gcc -I. -E prog/dump/isadump.c -o prog/dump/isadump.E

Thanks,
-- 
Jean Delvare

