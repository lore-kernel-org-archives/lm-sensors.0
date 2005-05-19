From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [Fwd: [patch 2/9] 2.5.6 lm_sensors]
Message-Id: <20020720150824.F1076@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D39C5C1.CCADBF93@paradyne.com>
In-Reply-To: <3D39C5C1.CCADBF93@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Yup.  If we can't get more details, then I suggest we detect for the 
presence of a Thinkpad and not allow i2c-piix4 to initialize.  
According to Keith's old email, that would be sufficient to prevent 
any possible communication with the compromisable Flash ROM.

When we were emailing with Keith, I think he said that the technical
details for detecting Thinkpads was company-confidential but he was
working to make it available to us.  Never heard any more on that...  
The linux.kernel newsgroup suggested adding an explicit kernel config
that said 'Support for Thinkpads? [Y/n]'.  Another person suggested
that it be more preciously worded as 'Destroy my precious Thinkpad?
[Y/n]'.... ;')

We could also look to see if there is any existing code in the Kernel 
(or elsewhere) which detects for Thinkpads.


Phil

On Sat, Jul 20, 2002 at 05:37:01PM -0400, Mark D. Studebaker wrote:
> Well, Alan Has Spoken.
> Unless we identify and fix the problem, we won't be in the kernel.
> We'll either have to get through to somebody at IBM
> (perhaps we can find Keith wherever he is now for help?)
> or else buy an old Thinkpad and reverse engineer it.
> I can't even think of a reply to Alan worth sending.
> Any suggestions?
> 
> phil@netroedge.com wrote:
> > 
> > Yeah, I can see both sides to this.  Unfortunately, the only serious
> > issue we had is with those (apparently) few old Thinkpads.  Even Keith
> > of IBM (who has been let go after IBM dropped Linux support for
> > Thinkpads) couldn't get many details on it.  He thought it was a Flash
> > ROM on the PIIX4 I2C bus which responded in a non-standard way to
> > being probed (I'm calling the I2C protocol for eeproms 'standard').
> > 
> > I did some quick checking, and the list of known susceptible Thinkpads
> > don't seem to be sold any more.  So it might be only an issue for
> > someone with old hardware.
> > 
> > I guess we can put it like this:
> > 
> > The I2C bus drivers are safe.  Most use PCI access to identify and
> > configure the bus masters.  Pretty reliable and safe.
> > 
> > Chip drivers are less safe given the nature of not knowing what are on
> > the busses.  They use a combination of addressing space division, and
> > probing of 'signature' registers (which might be chip ID or
> > manufacturer registers) to confirm the indentity of the chip.  Still,
> > no reports of corruption or horrible things happening with installing
> > all the chip drivers on a system.  But, we can't do 'ideal'
> > detection... it's still possible a device exists (or will exists)
> > which one of our drivers will mangle.
> > 
> > Least safe are user-space apps which do scanning by reading and/or
> > writing indescriminately to all the addresses on all busses.  We
> > provide a lot of warnings for the only known group of users who may be
> > susceptible to a corruption issue in this case.
> > 
> > Alan worries that a new machine might come out (or stuff might exist
> > that we don't know about) with a device which gets corrupted from a
> > standard kernel driver.  That would suck!  It may be unlikely, but it
> > would suck.
> > 
> > Phil
> > 
> > On Sat, Jul 20, 2002 at 04:19:30PM -0400, Mark D. Studebaker wrote:
> > >
> > > X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
> > > Subject: Re: [patch 2/9] 2.5.6 lm_sensors
> > > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > To: Mark Studebaker <mds@paradyne.com>
> > > Cc: Linus Torvalds <torvalds@transmeta.com>,
> > >    Albert Cranford
> > >        <ac9410@bellsouth.net>
> > > In-Reply-To: <3D38C59C.5010901@paradyne.com>
> > > X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6)
> > > Date: 20 Jul 2002 21:07:50 +0100
> > >
> > > On Sat, 2002-07-20 at 03:06, Mark Studebaker wrote:
> > > > It's our userspace detection script, "sensors-detect",
> > > > that causes the problems, and we do not have any info from
> > > > IBM that would allow us to fix it.
> > > > The script has a big fat warning at the beginning.
> > >
> > > So the answer is no.
> > >
> > > > We don't know if it is the script itself, or certain modules it loads,
> > > > that cause the problem.
> > >
> > > And its not only no its "no and we are not sure what is going on or if
> > > what we have now is always safe".
> > >
> > > > Red Hat has been shipping kernels with our modules for over a year,
> > > > IIRC. We do not have a single report of an IBM Thinkpad user loading a
> > > > module and
> > > > getting fubared.
> > >
> > > The user has to choose to enable it and that is quite tricky. I am still
> > > deeply opposed to Red Hat shipping this code. You don't even seem to use
> > > the DMI data to identify what kind of SM management is present.
> > >
> > > > My own theory is that the Thinkpads have some non-standard
> > > > Serial Presence Detect eeproms for their memory, that those are
> > > > being corrupted by the sensors-detect script,
> > > > which prevents the BIOS from correctly discovering the SDRAMs and booting.
> > > > Just a theory though.
> > >
> > > So anybody else could be using the same chips and we might not know yet
> > > ?
> > >
> > > Alan
> > >
> > 
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
