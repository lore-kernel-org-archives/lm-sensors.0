From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [Fwd: [patch 2/9] 2.5.6 lm_sensors]
Message-Id: <3D3B0BCB.C5440548@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D39C5C1.CCADBF93@paradyne.com>
In-Reply-To: <3D39C5C1.CCADBF93@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

That's a great find.
(at line 5250).

Also note that at line 3158, it checks for PIIX4, and if not there,
the comment says definitely not a Thinkpad.

I'll put the 3 ID's from line 5250 into piix4 as a 'blacklist'.
Can somebody do the same in sensors-detect?
(check for those 3 ID's, if one is present, exit with a message).

We may need an lspci -n output from every thinkpad on the planet.
Or maybe just reject any board that has any IBM device at all?

phil@netroedge.com wrote:
> 
> Incidently, in the kernel drivers/sound/cs46xx.c, it checks for a 600E
> and 600X series Thinkpads by checking for the existance of some
> specific PCI devices.  Parhaps it's just as easy as looking for one of
> a series of specific PCI devices to detect for a Thinkpad?
> 
> On linux-thinkpad.org they list the vulnerable Thinkpads as:
> 
> ThinkPad 770X
> ThinkPad 600E
> ThinkPad 770Z
> ThinkPad 600X
> ThinkPad 240
> ThinkPad X20
> ThinkPad 570E
> 
> It would be nice if we could detect for any Thinkpad, but we might be
> OK if we just were able to detect the above?
> 
> Here's a list of know PCI ID's, which might be useful:
> 
> http://pciids.sourceforge.net/pci.db
> 
> The names here don't quite match with the scheme above, though...
> 
> Phil
> 
> On Sat, Jul 20, 2002 at 03:08:24PM -0700, phil@netroedge.com wrote:
> >
> > Yup.  If we can't get more details, then I suggest we detect for the
> > presence of a Thinkpad and not allow i2c-piix4 to initialize.
> > According to Keith's old email, that would be sufficient to prevent
> > any possible communication with the compromisable Flash ROM.
> >
> > When we were emailing with Keith, I think he said that the technical
> > details for detecting Thinkpads was company-confidential but he was
> > working to make it available to us.  Never heard any more on that...
> > The linux.kernel newsgroup suggested adding an explicit kernel config
> > that said 'Support for Thinkpads? [Y/n]'.  Another person suggested
> > that it be more preciously worded as 'Destroy my precious Thinkpad?
> > [Y/n]'.... ;')
> >
> > We could also look to see if there is any existing code in the Kernel
> > (or elsewhere) which detects for Thinkpads.
> >
> >
> > Phil
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
