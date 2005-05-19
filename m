From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <20030725104409.45a5c677.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On Thursday 24 July 2003 06:37 am, you wrote:
> > OK, I'd prefer a slightly different fix. We don't include
> > <asm/param.h> in any of our drivers. It seems we include
> > <linux/slab.h> instead, so I think we should do the same for
> > this one. Could you try and confirm it works for you?
> 
> Yes, it works with <linux/slab.h> instead of <asm/param.h>.

I changed my mind. If it only needs asm/param.h, why would we overload
it with things it doesn't need? I'll include <asm/param.h> with a
comment that says it there is for HZ.

> > The i2c-philips-par driver seems to miss it too. Were you
> > successful building it?
> 
> Oddly, yes.  i2c-philips-par does not complain, at least.

I checked this, and it happens that this module includes
<linux/parport.h>, which itself includes <linux/proc_fs.h>, which in
turn includes <linux/slab.h> (which itself includes <asm/param.h> as we
now know). I will explicitely add an include <linux/slab.h> since I
think the module needs it (it uses kmalloc/kfree).

Thanks for reporting!

> Well, every one of those warnings is a possible segfault on 
> 64-bit platforms, because the upper 32 bits of a pointer get 
> lost.  Actually, in this case (kernel-land code), it might be
> rather worse--the driver could conceivably end up playing with 
> the wrong memory region, and do so with impunity.

I don't know about your specific warnings, so I just can't tell. If the
system you see them on is both Alpha and 64-bit, this makes two big
differences with what i2c and lm_sensors is usually used on, so no
wonder it doesn't work out of the box. I don't think any of the
developers here have an Alpha system. We must have one IA-64 system but
we don't spend too much time testing on it.

This is far better if the person who has the warnings can take a look
and fix them. We can hardly fix warnings we don't even see.

> i2c-tsunami does not compile, and its fix is more than just a 
> one-liner.  It requires the <linux/slab.h> include, plus the 
> <linux/pci.h> include, plus some changes in static struct 
> initialization to accomodate recent gcc versions.
> (...)
> CVS, as of 20030724, is no better.  Last entry for this driver 
> was apparently back in January.

You're right, and even these were bulk changes that are not specific to
that driver. The driver must not havee been tested for months if not
years (due to the lack of hardware on our side).

> This is especially annoying, as the Tsunami driver is the primary 
> driver that makes lm_sensors useful at all on Alpha.
> 
> Unfortunately, I have no such motherboard with this chipset.  I'd 
> like to make the driver work anyways.

My experience is that this won't work. Too hard to fix a driver unless
you have someone that can test it and really wants it to work. Fixing
things just to make them work almost never led me anywhere.

> Also, the i2c-tsunami driver itself looks...well...unmaintained.  
> Does anyone maintain it now?

Seems so, yes. Oleg?

> If it's been abandoned, I can 
> happily take over maintenance, assuming someone can loan or 
> donate enough to build a sufficiently-working Typhoon/Tsunami 
> motherboard setup.

We don't have such hardware, or we probably would maintain the driver by
ourselves.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
