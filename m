From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <200307250340.15012.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 25 July 2003 03:00 am, you wrote:
> > i2c-tsunami does not compile, and its fix is more than just
> > a one-liner.  It requires the <linux/slab.h> include, plus
> > the <linux/pci.h> include, plus some changes in static
> > struct initialization to accomodate recent gcc versions.
>
>     Hm... And that's the problem exactly? I'm currently not
> suscribed to the list, but will try to recompile this code...

Here's a snippet of my current patch to give you an idea:

 static struct i2c_algo_bit_data tsunami_i2c_bit_data = {
-
-       bit_tsunami_setsda,
-       bit_tsunami_setscl,
-       bit_tsunami_getsda,
-       bit_tsunami_getscl,
-       10, 10, HZ/2    /* delays/timeout */
+       .setsda         = bit_tsunami_setsda,
+       .setscl         = bit_tsunami_setscl,
+       .getsda         = bit_tsunami_getsda,
+       .getscl         = bit_tsunami_getscl,
+       .udelay         = 10,
+       .mdelay         = 10,
+       .timeout        = HZ/2,
 };

Apparently gcc-3.2.3/alpha doesn't grok the original method of 
static initialization.  It choked on it badly until I switched 
it.  gcc-2.95.3/x86 seems to like either way just fine.

Maybe the C standard has changed, or maybe gcc3 is just being a 
fruitcake.  But as the other static structs use a different form 
of initialization, I decided to accomodate gcc3 and introduce 
proper consistency in one fell swoop.

(Other lm_sensors drivers have small problems compiling on alpha, 
mostly one-liner fixes that I've been able to handle on my end.  
I was planning to finish it out and send the full patch 
upstream, but I hit a stumbling block on i2c-tsunami.)

> > Its biggest problem, though, is that it's missing a
> > tsunami_ids struct (list of PCI IDs), and this is REALLY a
> > problem.  I have no clue what the Tsunami/Typhoon (2127x)
> > PCI IDs are.  I know that they're the core logic controller
> > chips on such motherboards as the DP264 and the UP2000
> > series.  I also looked in the <linux/pci_ids.h> header for
> > 2.4.2[01], and the closest macro I could find for this PCI
> > device ID is
> > PCI_DEVICE_ID_DEC_21285.  I'm fairly certain that won't do
> > at all.
>
>     Tsunami/Typhoon chips are not PCI devices. They are core
> logic which is transparent to PCI stuff. The only visible
> parts on the UP2000/DS20 boards is the "real" hardware stuff:
> -----------
> 00:05.0 ISA bridge: Contaq Microsystems 82c693
> 00:05.1 IDE interface: Contaq Microsystems 82c693
> 00:05.2 IDE interface: Contaq Microsystems 82c693
> 00:05.3 USB Controller: Contaq Microsystems 82c693
> 00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
> (rev 01) ----------

Hmmm...well, part of the tsunami_driver struct requires a PCI ID 
table (tsunami_ids).  I'm not sure what's supposed to go in that 
table?

Could it be that someone tried to port the driver to the new API, 
half-finished it, and left it for dead?  lm_sensors-2.7.0 makes 
no mention of the tsunami_driver struct or the tsunami_ids 
table.  Maybe that little struct arrangement isn't supposed to 
be there?

> > CVS, as of 20030724, is no better.  Last entry for this
> > driver was apparently back in January.
> >
> > This is especially annoying, as the Tsunami driver is the
> > primary driver that makes lm_sensors useful at all on Alpha.
>
>     Just FYI. Tsunami i2c bus provides an access to a SPD
> chips only. Other stuff (such as lm75, adm9240) are accessed
> via i2c-elektor module. So, in fact UP2000 has to different
> i2c buses.

Ah, I never knew about that.  Good info to have, thanks.

What Alpha motherboards support sensors like that, btw?

> > Unfortunately, I have no such motherboard with this chipset.
> >  I'd like to make the driver work anyways.  Can people with
> > Typhoon/Tsunami motherboards please volunteer the PCI IDs
> > for these chips?  I'd prefer to merge them with the
> > <linux/pci_ids.h> file, then add some #ifdefs to
> > i2c-tsunami.c to make sure the PCI ID macros get defined
> > even on older kernel versions.
>
>     Wrong way. ;-))

Eh?  Wrong way how?  I suppose I'm missing something about 
contributing kernel macros for PCI IDs?

(Wouldn't surprise me if I was.  I'm not all _that_ much of a 
kernel hacker.)

> > Also, the i2c-tsunami driver itself
> > looks...well...unmaintained. Does anyone maintain it now? 
> > If it's been abandoned, I can happily take over maintenance,
> > assuming someone can loan or donate enough to build a
> > sufficiently-working Typhoon/Tsunami motherboard setup.
>
>     Yes. It's unmaintained due to the fact we have used
> kernels 2.2.x on our site, but now we are moving to 2.4
> series.

Ah, so that's where you've been. ;)  How's the upgrade going so 
far?

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
