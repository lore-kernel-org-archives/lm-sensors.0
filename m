From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: lm_sensors
Message-Id: <3D7815C6.83FF9513@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you Pam for your long email.
I think your "understandings" #1-3 are correct,
as are your "solutions" #1-2.

Solution #1 is only interesting if you care to release
the interface to the hardware sensors. We don't really have
much interest in having people run lm_sensors just to
access the eeprom, for example. So if you would like to
release the information so that thinkpad users can access their
sensors under linux, great. If not, I don't think
there is a lot of demand for this. My opinion anyway.

Solution #2 is implemented now, in a rather coarse way. 
We read the DMI information
in the BIOS and look for a "Vendor" string of "IBM"
in the "System Information Block".
This is implemented both in "sensors-detect" and in "i2c-piix4".

Solution #2 could obviously be improved if you give us a way
to identify systems that specifically have a Atmel 24RF08 eeprom
on them. It is our suspicion that more recent Thinkpads have
a standard eeprom (Atmel 24C08 or compatible). These are thought
not to be susceptible to corruption. The "MTM" info sounds
great - _if_ you can correlate MTM's to eeprom types!

We have also implemented a third solution.
Solution #3 works if solution #2 fails and is a true "root cause" fix.
The root cause is a quick write "0" in the chip range 0x54-0x57 (the
24RF08)
followed by a read from any chip at any address, which corrupts
the 24RF08 due to a bug ("feature"?) in that chip.
This sequence happens in our "sensors-detect" script (which also has the
solution #2 fix).
The script now follows any quick write "0" in the chip range 0x54-57
with a second quick write. This resets the 24RF08 state machine and
prevents corruption. This fix is tested and verified.

Kyosti has described some ways in which the 24RF08 could still
theoretically
be corrupted (on non-IBM systems). While not disagreeing with him,
I think we need to draw the line somewhere, and in my opinion we have
a good explanation for Alan Cox that we have both blacklisted the
IBM systems _AND_ fixed the actual problem on non-IBM systems, if there
are any.
I don't see how we can prevent corruption in a multi-master system.

So I propose leaving both solution #2 and solution #3 in place.
In fact Linus has accepted a patch for kernel 2.5.34 that exports
a variable to us to implement solution #2 in-kernel - this 
patch was blessed by Alan Cox and it (together with the
explanation above) paves the way for inclusion
of lm_sensors in 2.5.

For Pam I have the following questions:

- Is our Solution #2 (DMI) a valid way of identifying IBM systems?
- Can you give us a way to identify systems that contain 24RF08's?
- Can you release to us the method for accessing hardware sensors?
- Do you have someone that can verify our solutions #2 and #3 on 
   a 24RF08-containing system running linux? If you give us a contact
   we can send them code and instructions. Of course, worst case,
   they would have to be prepared for corruption and be able to fix it.

thanks again for your help.
mds


phil@netroedge.com wrote:
> 
> Hey Mark, do we need more specific information on detecting Thinkpads,
> or are we confident that we can work around the issue w/o needing to
> resort to blacklisting?
> 
> One issue that concerns me (and Alan Cox) with the blacklisting is
> that we are assuming that the AT24RF08 won't be run into on other
> hardware (IBM Intellistations which are suggested to have chips like
> the 24RF08, or even non-IBM hardware).
> 
> If we think we have a possible fix in place, perhaps Pam (and those on
> the thinkpad mailing list) can help confirm the fix?  This would be
> preferable to the DMI detection and workaround mess (although you guys
> did some awesome work with that).
> 
> Phil
> 
> On Thu, Sep 05, 2002 at 01:56:44PM -0400, Pam Huntley wrote:
> >
> > Hi Phil,
> >
> > I have heard from the hardware engineers in Japan.  They wanted me to
> > clarify some things with you, particularly the optimal solution you would
> > like, and what is tolerable.
> >
> > First I'd like to make sure I actually understand the problem, since I'm
> > not really a hardware person, and our ThinkPad hardware guys only speak
> > passable English.  Below is what I understand, put together from your
> > emails and the hardware team's comments:
> > 1.  lm_sensors is a software package for Linux that does health montoring
> > of hardware, soon to be added to the Linux kernel.  It uses a wide variety
> > of sensors, including temperature, battery life, fan speed, voltages,
> > memory detection, etc.  The typical PC has a chipset on the motherboard
> > which is usually accessed via the ISA bus or the SMBus, which is what
> > lm_sensors is coded to use.
> > 2.  The sensor (the thermal sensor) in ThinkPad is not connected to SMBUS,
> > instead IBM normally uses an embedded controller to monitor thermal sensors
> > (sometimes using multiple sensors). However, the H/W implementation varies
> > depending on model. IBM does not disclose the interface to access to those
> > sensors.
> > 3.   lm_sensors uses SMBUS  to connect several different devices, and one
> > of them is ATMEL EEPROM, which contains machine serial or other
> > device/system vital information. lm_sensors accesses the EEPROM in a way
> > that causes it to be corrupt. To quote your recent email:
> > "We got some samples of the Atmel AT24RF08 chip, and we
> > were able to reproduce the corruption!  In a nut-shell, this
> > particular chip has a broken I2C bus state-machine which can interpret
> > certain sequences of bus communications (including communications with
> > other unrelated chips) as being 'data write' commands which corrupt
> > the eeprom."
> > Then BIOS detects the error condition and posts the error code and the
> > machine needs to repair.
> >
> >
> > As far as solutions you'd like, my understanding is this:
> > 1.  Optimal solution:  you have the hardware specs, you know what chipsets
> > are involved, and you can access the information without blowing away the
> > eeprom.
> > 2.  Minimal solution:  you know how to detect IBM hardware, and disable lm
> > sensors on it.
> >
> > The hardware guys are suggesting you detect IBM ThinkPads specifically, and
> > are preparing a document for public release that would tell you how to do
> > this.  Knowing how IBM works (legal reviews, etc), this may take a little
> > time, but at least it could allow lm_sensors to still run on the server
> > hardware that isn't broken.
> >
> > It seems to me that for lm_sensors to work flawlessly on all ThinkPads, you
> > would need to know all the different ways that the hardware engineers
> > implement their sensors, and how to access this information safely.  Is
> > this correct?  As far as I can tell, the ThinkPad hardware engineers are
> > very reluctant to release this information.  The reason that was given to
> > me is that whenever they released the specs for their BIOS and related
> > hardware in the past, they got locked down to a particular implementation,
> > and were unable to change things without upsetting the people that were
> > relying on that particular design.    However, they have been willing to
> > release some limited information recently, so if you do need this
> > information, we could at least ask.
> >
> > Please let me know your thoughts on all this.  I'll tell the hardware guys
> > to proceed with the documentation on how to detect IBM ThinkPads.  Whether
> > or not I persue more information with depends on your response.
> >
> > Thanks,
> > Pam
> >
> >
> > ======================
> > Pamela Huntley, IBM PCD Software Development
> > Phone: (919) 543-3598   Email: phuntley@us.ibm.com
> >
> >
> >
> >
> >                       phil@netroedge.co
> >                       m                        To:       Pam Huntley/Raleigh/IBM@IBMUS,
> >                                                 sensors@Stimpy.netroedge.com
> >                       08/30/2002 07:22         cc:
> >                       PM                       Subject:  Re: lm sensors
> >
> >
> >
> >
> >
> >
> >
> > On Fri, Aug 30, 2002 at 05:20:50PM -0400, Pam Huntley wrote:
> > >[...]
> > > I gave them your contact information (email).  I haven't heard if they'll
> > > contact you directly or not, as they are in Japan, they might just send
> > me
> > > stuff and let me pass it on to you. I should know more next week when
> > they
> > > respond to my email.
> >
> > OK, sounds good.
> >
> > > As far as detecting IBM, I think you are on the right track.  My
> > > understanding is that both the vendor flag "IBM" and the MTM (machine
> > type
> > > and model) are located in the BIOS, and that you can access this using
> > > SMAPI calls.  We used to use DMI on our older machines, I'm not sure if
> > it
> > > will work on the newer ones.  Again, I write mostly GUI software, so I'm
> > a
> > > little fuzzy on things like BIOS, but I can probably get more specifics
> > if
> > > this is something you need to know more about.  I believe you can
> > actually
> > > get the MTM and just test the type to make sure it's a ThinkPad, and that
> > > way you won't have to disable it for ALL IBM machines.  Hopefully we can
> > > get the specs to you and you won't have to disable it at all.
> >
> > I'm hoping we can identify the chip and work around the problem so we
> > don't have to blacklist anything.  That would be ideal.
> >
> > > I'm hoping that we can get you what you need, I'll keep you posted as to
> > > what I know.
> >
> > Thanks!! We really appreciate your help. :')
> >
> >
> > Phil
> >
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> >
> >
> >
> >
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
