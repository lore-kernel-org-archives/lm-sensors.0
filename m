From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [ltp] Incorporating Thinkpad Detection into Lm_sensors
Message-Id: <20020724161212.D8689@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 24, 2002 at 06:00:39PM -0400, Mark Studebaker wrote:
> did you reply to Joe?

Yes.  I just thanked him and told him we were digesting everything he 
said.  Feel free to ask him a follow up, if you have something.

> I think he doesn't know what an SMBus 'write quick' is,
> if you explain that to him (copy from i2c/doc/smbus-protocol)
> that should give him what he needs.

I got the impression he understood.  This is how I read his email,
correct me if you think I'm wrong: He said that quick-commands didn't
seem to work because the chip was too stupid to stop intepreting the
I2C command after receiving after a STOP.  So, two consecutive quick
commands looked like a single larger 'byte write' command, or perhaps
even three of them looked like a larger 'byte write data' command.  
Hense, the possible corruption of the eeprom...

btw-I got the feeling that IBM didn't get rid of the chip on
other/newer Thinkpads which were not vulnerable, but switched to an
ASIC which is 'different' but apparently operates the same way.  
Perhaps the ASIC isn't as dumb as the Atmel chip (that it knows what a
i2c quick command is).

Oh, and I was also suprised that Joe said the laptops weren't acutally 
dead.  You hit 'ESC' and went on your way.  The laptop even seemed to 
correct the CRC on the eeprom so the error went away on the next boot.  
I don't know if this is the case, though?


Phil

> phil@netroedge.com wrote:
> > 
> > BTW- I don't know if any 'add-ons' might show up the PCI list.  We
> > might need to account for that.
> > 
> > Phil
> > 
> > On Wed, Jul 24, 2002 at 05:48:51PM -0400, Mark Studebaker wrote:
> > > Hi, I'm on the lm_sensors project too.
> > > I would like to investigate using PCI ID's to identify a thinkpad.
> > > This would be simpler than using DMI.
> > > Would folks please post the output of 'lspci' and 'lspci -n'
> > > for each of the following laptops reported to be a problem.
> > > Obviously we only need one posting for each model.
> > > thanks
> > > >
> > > > ThinkPad 770X
> > > > ThinkPad 600E
> > > > ThinkPad 770Z
> > > > ThinkPad 600X
> > > > ThinkPad 240
> > > > ThinkPad X20
> > > > ThinkPad 570E
> > > >
> > >
> > > Michael Selway wrote:
> > > >
> > > > Charles E Taylor IV writes:
> > > >  > [Thinkpad detection]
> > > >  >
> > > >  > On Mon, 22 Jul 2002 12:43:24 -0500
> > > >  > Jim Redmond <jim@scrubnugget.com> wrote:
> > > >  >
> > > >  > > I'm pretty sure this is based on a .config setting, defined by the user.
> > > >  >
> > > >  > On my stock RH 7.3 Thinkpad 600, I notice the following in the startup
> > > >  > logs:
> > > >  >
> > > >  > IBM machine detected. Enabling interrupts during APM calls.
> > > >
> > > > The code I pointed out to the lm_sensors guys is the code which
> > > > causes this line to be printed.  AFAIK, Linux always overrides the
> > > > setting of APM_ALLOW_INTS on all IBM machines, both in .config and
> > > > on the kernel command line: APM_ALLOW_INTS is forcibly set ON.
> > > >
> > > > I've been experimenting with undoing all this so that I have
> > > > control of APM_ALLOW_INTS again.  I'm persuing my struggle to get
> > > > 100% reliable suspend/resume on my T21.  Currently I'm running
> > > > with APM_ALLOW_INTS switched OFF.  It's a "well known fact" that
> > > > this doesn't work on thinkpads.  Well, it does on my T21.  It's
> > > > too early to say whether it's helped my suspend problems, as I'm
> > > > down to one failure every few weeks now, so it takes a long time
> > > > to test.  So far it's at least as reliable and maybe more
> > > > reliable.
> > > >
> > > > Michael.
> > > >
> > > > ----- The Linux ThinkPad mailing list -----
> > > > The linux-thinkpad mailing list home page is at:
> > > > http://www.bm-soft.com/~bm/tp_mailing.html
> > >
> > > ----- The Linux ThinkPad mailing list -----
> > > The linux-thinkpad mailing list home page is at:
> > > http://www.bm-soft.com/~bm/tp_mailing.html
> > 
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
