From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 26 Sep 2006 19:08:22 +0000
Subject: [lm-sensors] 2.10.1: No rule to make target `asm/io.h',
Message-Id: <20060926190822.GN10410@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926135555.GH10410@neu.nirvana>
In-Reply-To: <20060926135555.GH10410@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 26, 2006 at 08:56:48PM +0200, Jean Delvare wrote:
> > > No, it looks like /usr/include/asm/io.h was recently dropped.
> > 
> > Ah, looking at the previous (current) release the contents of asm/io.h
> > are
> > 
> > | #ifndef _ASM_IO_H
> > | #define _ASM_IO_H
> > | 
> > | #warning <asm/io.h> is deprecated, use <sys/io.h> instead
> > | #include <sys/io.h>
> > | 
> > | #endif
> 
> I found some posts along these lines on the web. However, I take that
> you never saw this warning, because our code reads:
> 
> /* To keep glibc2 happy */
> #if defined(__GLIBC__) && __GLIBC__ = 2 && __GLIBC_MINOR__ >= 0
> #include <sys/io.h>
> #else
> #include <asm/io.h>
> #endif
> 
> So it should look for sys/io.h rather than asm/io.h. It does for me.
> I suspect that the test on __GLIBC__ somehow fails for you. Can you
> please give a try to the following program?

I returns the expected result:

__GLIBC__ = 2
__GLIBC_MINOR__ = 4


> --- 8< ---
> #include <stdio.h>
> 
> int main()
> {
> 	printf("__GLIBC__ = %d\n", __GLIBC__);
> 	printf("__GLIBC_MINOR__ = %d\n", __GLIBC_MINOR__);
> 	return 0;
> }
> --- 8< ---
> 
> $ gcc -Wall -W test_glibc.c -o test_glibc
> 
> I expect some surprise on your FC6 system.
> 
> That being said the test above looks bogus to me, the test on
> __GLIBC_MINOR__ is useless as far as I can see, and the test will break
> on GLIBC 3 for sure.
> 

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060926/0d7861e3/attachment.bin 
