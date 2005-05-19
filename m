From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [Fwd: [patch 2/9] 2.5.6 lm_sensors]
Message-Id: <3D3CAD95.6C08EAF2@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D39C5C1.CCADBF93@paradyne.com>
In-Reply-To: <3D39C5C1.CCADBF93@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Agreed. 

My preference is only i2c-piix4 and sensors-detect;
and my preference is using PCI ID's and not DMI. But
we may have to use DMI to be safe.

On the 24RF08 itself, our response will depend on whether
the corruption is via addresses 0x54-0x57, or via 0x5C.
I ordered samples today. When I get them I'll ask who else
wants one to test with.
Depending on the test results we may have to do something to eeprom.c
as well.


phil@netroedge.com wrote:
> 
> I guess our canidate solutions are solidifying:
> 
> - Detect Thinkpads and disable at least partial functionality
>   (like i2c-piix4 or addresses on all busses from 0x58-0x5F)
> 
> - Detect the AT24RF08 and either drive it properly, or safely
>   note and ignore it.
> 
> Does this sound right?
> 
> Alan's suggestion of detecting a possible vulnerable platform and
> safely disabling a driver (or the entire i2c/lm-sensors package)
> with DMI is a safe workaround for this specific issue, but ideally, if
> we can sense this chip and safely drive it, it would be awesome.
> That would address Alan's fears of a future machine for which we
> didn't blacklist having this chip.  Perhaps easier said than done, ey?
> 
> Anyways, if we do the DMI route, I would detect for brand 'IBM' and
> blacklist them all.  Accesses from 0x58-0x5F anyway (or what ever the
> range was for this chip).
> 
> Not sure how to use DMI?  There are some references to DMI in some
> drivers.  The most obvious is drivers/char/i8k.c, but he just
> copied-and-pasted Alan's code... not ideal usage.
> 
> Phil
> 
> On Sun, Jul 21, 2002 at 03:16:01PM -0400, Mark D. Studebaker wrote:
> > Do we know for sure that each of the thinkpads listed below
> > has a piix4? Probably not...
> >
> > Alan implied we should be using DMI data.
> > I found the attached program by him on the net for dumping
> > out the DMI data. Compile and run as root to see what info is
> > available. Perhaps we could check that for 'thinkpad'.
> > Not clear to me which field would tell us
> > 'what kind of SM management is present' or
> > what we would do with that info.
> > Anybody?
> >
> >
> > phil@netroedge.com wrote:
> > >
> > > Incidently, in the kernel drivers/sound/cs46xx.c, it checks for a 600E
> > > and 600X series Thinkpads by checking for the existance of some
> > > specific PCI devices.  Parhaps it's just as easy as looking for one of
> > > a series of specific PCI devices to detect for a Thinkpad?
> > >
> > > On linux-thinkpad.org they list the vulnerable Thinkpads as:
> > >
> > > ThinkPad 770X
> > > ThinkPad 600E
> > > ThinkPad 770Z
> > > ThinkPad 600X
> > > ThinkPad 240
> > > ThinkPad X20
> > > ThinkPad 570E
> > >
> > > It would be nice if we could detect for any Thinkpad, but we might be
> > > OK if we just were able to detect the above?
> > >
> > > Here's a list of know PCI ID's, which might be useful:
> > >
> > > http://pciids.sourceforge.net/pci.db
> > >
> > > The names here don't quite match with the scheme above, though...
> > >
> > > Phil
> > >
> > > On Sat, Jul 20, 2002 at 03:08:24PM -0700, phil@netroedge.com wrote:
> > > >
> > > > Yup.  If we can't get more details, then I suggest we detect for the
> > > > presence of a Thinkpad and not allow i2c-piix4 to initialize.
> > > > According to Keith's old email, that would be sufficient to prevent
> > > > any possible communication with the compromisable Flash ROM.
> > > >
> > > > When we were emailing with Keith, I think he said that the technical
> > > > details for detecting Thinkpads was company-confidential but he was
> > > > working to make it available to us.  Never heard any more on that...
> > > > The linux.kernel newsgroup suggested adding an explicit kernel config
> > > > that said 'Support for Thinkpads? [Y/n]'.  Another person suggested
> > > > that it be more preciously worded as 'Destroy my precious Thinkpad?
> > > > [Y/n]'.... ;')
> > > >
> > > > We could also look to see if there is any existing code in the Kernel
> > > > (or elsewhere) which detects for Thinkpads.
> > > >
> > > >
> > > > Phil
> > >
> > > --
> > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
