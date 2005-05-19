From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: i2c patches for 2.5.15
Message-Id: <3CED7BC6.99258BEB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Albert,
sorry for my slow response.

I looked at the new 2.5.17-i2c-* patches in your directory
and they look good.

I went back to look at cause of the CONFIG changes.
I applied a patch last October which changed the
names in Config.in to match the names at the bottom of i2c-core.c.

I think that was a mistake, we should have changed i2c-core.c.
That's what's now in the kernel, and you maintain that by
not changing the names in your patch. Good.

I'll change Config.in and i2c-core.c in CVS to match what's
in the kernel.

It's been a week since you posted your patches so 
I recommend you go ahead and send them to Linus.

Let us know how it goes.
If you need any help summarizing the changes for Linus
then let me know. The big change in i2c-core.c is the addition
of i2c block reads and writes, in case that wasn't obvious.

Thanks again for your hard work.

mds




Albert Cranford wrote:
> 
> Hi all,
> The latest patches against 2.5.15 with everyones advice.
> Comments first and URL links at bottom of page.
> Later,
> Albert
> 
> patch-1
> # leave CONFIG names as in kernel
> patch-2
> # i2c-core.c:Leave LINUX_VERSION in kernel.  Leave i2c_debug=1.  Leave
> #   CONFIG names as in the kernel.  Remove #ifdef MODULE_LICENSE around
> #   MODULE_LICENSE.
> # i2c-dev.c:Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> #   Remove compatibality code for < 2.4.0
> # i2c-proc.c: Print message on kmalloc failure.  Leave ENOMEM as in kernel.
> #   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.  Remove 2.2.19 compat
> #   code.
> patch-3
> # i2c-algo-bit.c: Leave kernel time_before/after_eq
> #   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> # i2c-algo-pcf.c: Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> # i2c/i2c-elektor.c: Leave kernel __exit pcf_isa_exit(void)
> #   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> # i2c-elv.c: Leave kernel __exit bit_elv_exit(void)
> #   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> # i2c-philips-par.c: Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> # i2c/i2c-velleman.c: Leave kernel __exit bit_velle_exit(void)
> #   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
> # Drop i2c-algo-8xx.[ch] deltas
> # Drop i2c-algo-ppc405.[ch] deltas
> # Drop i2c-pcf-epp.c deltas
> # Drop i2c-ppc405.[ch] deltas
> # Drop i2c-ppc405adap.h deltas
> # Drop i2c-pport.c deltas
> # Drop i2c-rpx.c deltas
> patch-4
> # i2c-elektor.c:Adding call to pcf_isa_init to i2c_pcfisa_init causes:
> # i2c-elektor.o: In function `i2c_pcfisa_init':
> # i2c-elektor.o(.text.init+0x95): undefined reference to `local symbol
> # i2c-elektor.c: fix by removing __exit for inline compiling.
> 
> http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/patches/i2c-1.html
> http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/patches/i2c-2.html
> http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/patches/i2c-3.html
> http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/patches/i2c-4.html
> 
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
