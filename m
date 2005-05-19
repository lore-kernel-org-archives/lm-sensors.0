From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <200307242129.59862.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 24 July 2003 06:37 am, you wrote:
> OK, I'd prefer a slightly different fix. We don't include
> <asm/param.h> in any of our drivers. It seems we include
> <linux/slab.h> instead, so I think we should do the same for
> this one. Could you try and confirm it works for you?

Yes, it works with <linux/slab.h> instead of <asm/param.h>.

> The i2c-philips-par driver seems to miss it too. Were you
> successful building it?

Oddly, yes.  i2c-philips-par does not complain, at least.

> > Also, I'm seeing a lot of "cast from pointer to integer of
> > different size" warnings compiling this same driver, mostly
> > having to do with the CTRL macro.  This worries me,
> > especially on 64-bit platforms.  Should I be worried in this
> > case?
>
> I saw hundreds of warnings on perfectly clean code while I was
> compiling on a IA-64 system recently. I don't think you should
> be afraid. Just remove the -Wall flag if you want gcc to leave
> you alone. If there are still warnings after that, then we
> will take a look at them.

Well, every one of those warnings is a possible segfault on 
64-bit platforms, because the upper 32 bits of a pointer get 
lost.  Actually, in this case (kernel-land code), it might be 
rather worse--the driver could conceivably end up playing with 
the wrong memory region, and do so with impunity.

I know there are special cases where this warning can be ignored, 
but in my experience, such cases are the exception rather than 
the rule.

Now, on to other things (lm_sensors in particular):

i2c-tsunami does not compile, and its fix is more than just a 
one-liner.  It requires the <linux/slab.h> include, plus the 
<linux/pci.h> include, plus some changes in static struct 
initialization to accomodate recent gcc versions.

Its biggest problem, though, is that it's missing a tsunami_ids 
struct (list of PCI IDs), and this is REALLY a problem.  I have 
no clue what the Tsunami/Typhoon (2127x) PCI IDs are.  I know 
that they're the core logic controller chips on such 
motherboards as the DP264 and the UP2000 series.  I also looked 
in the <linux/pci_ids.h> header for 2.4.2[01], and the closest 
macro I could find for this PCI device ID is 
PCI_DEVICE_ID_DEC_21285.  I'm fairly certain that won't do at 
all.

CVS, as of 20030724, is no better.  Last entry for this driver 
was apparently back in January.

This is especially annoying, as the Tsunami driver is the primary 
driver that makes lm_sensors useful at all on Alpha.

Unfortunately, I have no such motherboard with this chipset.  I'd 
like to make the driver work anyways.  Can people with 
Typhoon/Tsunami motherboards please volunteer the PCI IDs for 
these chips?  I'd prefer to merge them with the 
<linux/pci_ids.h> file, then add some #ifdefs to i2c-tsunami.c 
to make sure the PCI ID macros get defined even on older kernel 
versions.

Also, the i2c-tsunami driver itself looks...well...unmaintained.  
Does anyone maintain it now?  If it's been abandoned, I can 
happily take over maintenance, assuming someone can loan or 
donate enough to build a sufficiently-working Typhoon/Tsunami 
motherboard setup.

As always, please CC me off-list as I'm not subscribed.  (If this 
thread keeps up, I may as well just subscribe and be done with 
it.)

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
