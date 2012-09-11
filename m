From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 01:42:16 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <20120911014215.GA31628@roeck-us.net>
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
> 
Looking into the driver, I suspect the power meter configuration might not
survive a suspend/resume cycle. What do you see after a complete reboot ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
