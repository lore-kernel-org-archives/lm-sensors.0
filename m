From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Fix for 64-bit platforms to i2c-2.8.7
Message-Id: <4153C035.4020804@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've had problems compiling 2.8.7 on Opteron (x86-64) systems due to 
some assembly code in i2c-algo-biths.c

This has been a problem for a while.  Usually I just comment out biths 
in the makefile, but I got annoyed enough the last time I did this, that 
I did some research to find out what the root problem was.

Skip to the patch if you don't want the full, gory details...

Seems that we've duplicated some code from the mainline kernel (udelay) 
in the biths implementation.  But as with most forks, the mainline 
kernel implementation works on 64-bit but ours doesn't.

Turns out that on x86 (32-bit) platforms, there is a multiply 
instruction that takes two 32-bit values and returns a 64-bit value. 
 The assembly code is tricky because it saves only the *high* 32-bits of 
this 64-bit result.  Effectively getting a '>>32' for free.  But longs 
are 64-bit on x86-64 and so this code is unnecessary.

In fact, I'm not really sure I see the point of this duplicated code at 
all.  It would seem like we should just call the kernels udelay in all 
cases.  In fact that's the fallback case in the code if it doesn't think 
it can use the multiply instruction.

Here's a patch (unfortunately, reversed) that avoids the assembly code 
problem with 32/64 bit longs.

diff -ru i2c-2.8.7.biths/kernel/i2c-algo-biths.c 
i2c-2.8.7/kernel/i2c-algo-biths.c
--- i2c-2.8.7.biths/kernel/i2c-algo-biths.c     2004-08-16 
15:37:13.000000000 -0700
+++ i2c-2.8.7/kernel/i2c-algo-biths.c   2003-07-25 00:56:42.000000000 -0700
@@ -682,18 +682,9 @@
        unsigned long now, loops, xloops;
        int d0;
        xloops = adap->xloops;
-#if BITS_PER_LONG = 32
-       /* Use trick of the mull instruction that it generates a 64-bit
-        *   result.  Drop the low 32-bits (d0) and use only the high
-        *   32-bits to effect a >>32 for "free"
-        */
        __asm__("mull %0"
                :"=d" (xloops), "=&a" (d0)
                :"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
-#else
-       xloops *= current_cpu_data.loops_per_jiffy ;
-       xloops >>= 32 ;
-#endif
        loops = xloops * HZ;
        do
        {

