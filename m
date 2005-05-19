From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: I2C device identification
Message-Id: <3C86C9CC.970198EC@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFF2EB205B84D011ADB200805FFE6E010BE14F51@txexmta2.amd.com>
In-Reply-To: <AFF2EB205B84D011ADB200805FFE6E010BE14F51@txexmta2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

according to our documentation in doc/smbus-protocol in the i2c  project
there is no quick read, only quick write.
But there is a byte read.
I wonder why we do quick write instead of byte read.
Is it "safer"?
Is quick write what screws up thinkpads?
And of course eeproms are really i2c devices, not smbus...


phil@netroedge.com wrote:
> 
> That's a tough question about which is safer or more reliable.  I
> guess it depends on the cross-section of devices being probed.  I've
> had a mobo a few years ago which would lock up the SMBus (not even the
> reset button fixed the condition) if the device at 0x69 was sent a
> quick-write.  It turned out to be a clocking chip which hung the bus
> because it was anticipating more data following the quick-write and
> didn't time out.
> 
> Some simple devices only respond to the quick-commands and switch
> things on or off depending on it if got a quick-read or write.  In
> that case, doing either quick command would cause a potential
> state-change in the device instead of doing a non-intrusive probe.
> 
> Oh, lastly, I think all I2C/SMBus transations start with a quick-type
> transaction.  So, if I have my head screwed on straight, it is
> impossible to not detect a chip with a quick-read which supports, say,
> a I2C Block-read.
> 
> Phil
> 
> On Wed, Mar 06, 2002 at 06:16:55PM -0600, leo.duran@amd.com wrote:
> > Phil,
> >
> > Thanks for the reply.
> > Your observations are in line with what I'm seeing.
> >
> > I have a DIMM at 0x50 that's somehow responds to "QuickWrite"
> > at 0x30.  But if do a "QuickRead", only the (real) device at
> > 0x50 responds.  It's doing a "QuickRead" an OK detection mechanism?
> > It seems most people prefer "QuickWrite" for device detection.
> >
> > Thanks,
> > Leo.
> >
> > -----Original Message-----
> > From: phil@netroedge.com [mailto:phil@netroedge.com]
> > Sent: Wednesday, March 06, 2002 5:59 PM
> > To: Duran, Leo; sensors@Stimpy.netroedge.com
> > Subject: Re: I2C device identification
> >
> >
> >
> > If you see a device at, say, 0x31 and 0x51 which both seem to be
> > eeproms, then they are most likely the same device responding to
> > either address.  Don't count on most eeproms to show up twice like
> > this, though.  It is possible to have devices in the 0x30-0x3f and
> > 0x50-0x5f be independant, unqiue devices.  It appears to be rare (at
> > least on motherboards).
> >
> > I hope this helps.
> >
> >
> > Phil
> >
> > On Wed, Mar 06, 2002 at 10:44:15AM -0600, leo.duran@amd.com wrote:
> > > Hello,
> > >
> > > In the "I2C Tools Page": http://www2.lm-sensors.nu/~lm78/i2ctools.html
> > > there is chart listing general devices addresses.
> > >
> > > The range 0x30 thru 0x37 is listed as "eeprom shadow", whereas the range
> > > 0x50 thru 0x57 is listed as "eeprom".  Does this mean that the same (eeprom)
> > > device will respond to both addresses?  Or are these two distint devices?
> > >
> > > Thanks for the clarification,
> > > Leo Duran.
> > >
> >
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
