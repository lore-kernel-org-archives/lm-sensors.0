From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <200307271436.45439.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 27 July 2003 03:25 am, you wrote:
> > i2c-alpha.patch just includes Oleg's i2c-elektor fixes (the
> > i2c-velleman fix has already made it to CVS).
>
> I need Oleg's confirmation that this apply to Linux 2.4 as
> well as 2.6. (An explanation of why the change is needed would
> be welcome too).

Hmmm...my impression is that it enables the driver to work with 
newer kernels.  Just looking at the asm-${ARCH}/io.h header 
files from 2.4.20, there are some comments about plans to rip 
out certain relevant parts in 2.5/2.6, but I don't run 2.5/2.6, 
so I couldn't tell you exactly what's happened there.  You'd 
have to ask Oleg exactly what the patch fixes.

> I agree for all fixes but one. You include <linux/slab.h> in
> i2c-savage4.c while I think <asm/param.h> should be sufficent.
> Do you confirm?

I confirm, ja.  I don't know how I missed that, but <asm/param.h> 
is indeed sufficient.

> > For now, i2c-tsunami build targets are commented out in
> > kernel/busses/Module.mk.  They should be re-enabled when the
> > driver works again.
>
> I'd by far prefer a real fix... So we won't comment it out for
> now. We will do so before releasing 2.8.1 if no fix has been
> proposed at this time. If CVS testers don't notice it fails
> compiling, why would one want it to be fixed?

Fair enough. :)

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
