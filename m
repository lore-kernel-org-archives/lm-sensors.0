From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 11 Sep 2012 10:05:04 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <20120911100504.GA24179@alberich>
List-Id: <lm-sensors.vger.kernel.org>
References: <504B7388.8020102@01019freenet.de>
In-Reply-To: <504B7388.8020102@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 10, 2012 at 09:13:46PM +0200, Andreas Hartmann wrote:
> Andreas Herrmann wrote:
> > On Sat, Sep 08, 2012 at 09:50:25AM -0700, Guenter Roeck wrote:
> >> On Sat, Sep 08, 2012 at 06:34:16PM +0200, Andreas Hartmann wrote:
> > 
> >   [...]
> > 
> >>> fam15h_power-pci-00c4
> >>> Adapter: PCI adapter
> >>> power1:       85.74 W
> >>>
> >>> I read about this value, which would be the power consumption of the
> >>> CPU. If this would be correct, my cpu wouldn't be a cpu but a light bulb
> >>> :-) and the fan would most probably run on maximum speed non stop (which
> >>> it doesn't do - it's running on minimum).
> >>>
> >> If they have a built-in AC unit, both temperature and power consumption would
> >> make sense. Hmm ... maybe I should apply for a patent on that idea :).
> >>
> >>> CPU:       AMD FX(tm)-4100 Quad-Core Processor
> >>> Board:     Gigabyte GA-990XA-UD3
> >>> Bios:      Award F11 05/17/2012
> >>> Kernel:    3.4.10-1.1-desktop 64 bit (openSUSE)
> >>> lmsensors: sensors-3.3.2-55.1.x86_64
> >>>
> >>>
> >>> Do you need more information about the hardware? Feel free to ask!
> > 
> > What's the output of
> > 
> >   # setpci -s 18.5 0xe0.l
> 
> Hmm, a few hours later and one s2ram / resume cycle in between, the
> power value is broken again. It's showing constantly
> 	power1:       85.74 W
> in idle mode. setpci now says:
> 
> 00fff83e (first try)
> 
> 00fffffe (all other tries)
> 
> 
> As I did it a few hours ago, I got 003930c9 and the reported values have
> been between 26 W and 40 W (sounds reasonable to me) - before and after
> entering setpci.

We had added a quirk to set a different initialization value for the
running average range register (It's 0xe after resume on your box, we
set it to 0x9, see also your mail where you reported 0x003930c9 for
the setpci command output.)

 commit 00250ec90963b7ef6678438888f3244985ecde14
 Author: Andre Przywara <andre.przywara@amd.com>
 Date:   Mon Apr 9 18:16:34 2012 -0400

    hwmon: fam15h_power: fix bogus values with current BIOSes

So it seems that the quirk explicitly needs to be applied
on resume. (as the BIOS restores the old bogus value)

Thanks for testing.
Will look at how to address this with a patch.


Regards,
Andreas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
