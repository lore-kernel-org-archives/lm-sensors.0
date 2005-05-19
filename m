From: vdovikin@jscc.ru (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <003501c35282$de910d20$6628d0c3@mlab.cs.msu.su>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i2c-tsunami does not compile, and its fix is more than just a
> one-liner.  It requires the <linux/slab.h> include, plus the
> <linux/pci.h> include, plus some changes in static struct
> initialization to accomodate recent gcc versions.
    Hm... And that's the problem exactly? I'm currently not suscribed to the
list, but will try to recompile this code...

>
> Its biggest problem, though, is that it's missing a tsunami_ids
> struct (list of PCI IDs), and this is REALLY a problem.  I have
> no clue what the Tsunami/Typhoon (2127x) PCI IDs are.  I know
> that they're the core logic controller chips on such
> motherboards as the DP264 and the UP2000 series.  I also looked
> in the <linux/pci_ids.h> header for 2.4.2[01], and the closest
> macro I could find for this PCI device ID is
> PCI_DEVICE_ID_DEC_21285.  I'm fairly certain that won't do at
> all.
    Tsunami/Typhoon chips are not PCI devices. They are core logic which is
transparent to PCI stuff. The only visible parts on the UP2000/DS20 boards
is the "real" hardware stuff:
-----------
00:05.0 ISA bridge: Contaq Microsystems 82c693
00:05.1 IDE interface: Contaq Microsystems 82c693
00:05.2 IDE interface: Contaq Microsystems 82c693
00:05.3 USB Controller: Contaq Microsystems 82c693
00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890 (rev 01)
----------

>
> CVS, as of 20030724, is no better.  Last entry for this driver
> was apparently back in January.
>
> This is especially annoying, as the Tsunami driver is the primary
> driver that makes lm_sensors useful at all on Alpha.
    Just FYI. Tsunami i2c bus provides an access to a SPD chips only. Other
stuff (such as lm75, adm9240) are accessed via i2c-elektor module. So, in
fact UP2000 has to different i2c buses.

>
> Unfortunately, I have no such motherboard with this chipset.  I'd
> like to make the driver work anyways.  Can people with
> Typhoon/Tsunami motherboards please volunteer the PCI IDs for
> these chips?  I'd prefer to merge them with the
> <linux/pci_ids.h> file, then add some #ifdefs to i2c-tsunami.c
> to make sure the PCI ID macros get defined even on older kernel
> versions.
    Wrong way. ;-))

>
> Also, the i2c-tsunami driver itself looks...well...unmaintained.
> Does anyone maintain it now?  If it's been abandoned, I can
> happily take over maintenance, assuming someone can loan or
> donate enough to build a sufficiently-working Typhoon/Tsunami
> motherboard setup.
    Yes. It's unmaintained due to the fact we have used kernels 2.2.x on our
site, but now we are moving to 2.4 series.

    Please Cc me in your mail.

Regards,
    Oleg.
