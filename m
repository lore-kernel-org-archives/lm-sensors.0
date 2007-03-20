From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 20 Mar 2007 21:51:48 +0000
Subject: [lm-sensors] coretemp - take3
Message-Id: <46005774.8030704@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45FDC7A4.9070601@assembler.cz>
In-Reply-To: <45FDC7A4.9070601@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Alexey, Nicolas

> Frankly I don't understand when one should use rdmsr_safe() instead of
> rdmsr(). p4-clockmod driver worked fine with plain rdmsr/wrmsr.
> For general education, why this driver uses _safe functions?

It uses not well documented register 0xEE which might not even exist, and I do 
not want to oops the kernel. I'm in touch with Intel, but it goes slowly.

> What's wrong with http://ssh.cz/~ruik/patches/add-msr-io-safe.patch
> is:
> a) naming: _on_cpu is suffix and thus should be last
> 	FOO(...) => FOO_on_cpu(unsigned int cpu, ...)

Ok I will name it rdmsr_safe_on_cpu

> 
> b) static qualifier should be first.

Aha good catch!

> c) coding style in wrmsr_on_cpu/rdmsr_on_cpu/...
> 
> 	static int foo(...)
> 	{
> 		...
> 	}

Yep sorry I will fix it.

> 
> d) +#include <linux/errno.h>
> 
> 	what for? those dummy inlines don't include -E*

Well I tried to compile the kernel with allnoconfig and then just enable SMP and 
  coretemp, and the kernel screamed for the header files in that rdmsr_safe (so 
no EIO and the other was not defined) There was a problem even before the 
coretemp actually started to compile. Maybe it should be in different patch...

>> I will answer the rest in the evening.

Small glitch in coretemp_init:

     printk(KERN_NOTICE DRVNAME ": This driver uses undocumented features"

         "of Core CPU. Temperature might be wrong!\n");


Ok will fix.

Also, in __wrmsr_on_cpu_safe:
rv->err = wrmsr_safe(rv->msr_no, &rv->l, &rv->h);

should be:
rv->err = wrmsr_safe(rv->msr_no, rv->l, rv->h);

Will fix too. Thanks for the feedback. It is real pity that I do not have more 
time for this those days :/

I will spin the new patches to this thread, with the fixes, so we can start 
accepting/review phase for individual patches.

Thanks,

Rudolf

