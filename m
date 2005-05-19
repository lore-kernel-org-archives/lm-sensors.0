From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: major lm_sensors problem
Message-Id: <20020730151310.G9662@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200207301755.g6UHtga04064@shire.frodo.local>
In-Reply-To: <200207301755.g6UHtga04064@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Interesting... Well, I hope a reinstall works for you.  I couldn't say 
how or why it might.  Lm-sensors doesn't have much to do with 
harddrive storage or how the boot-blocks work.

Yeah, actually the Thinkpad issue (from my understanding) is this:

IBM uses a strange chip on some Thinkpads made by Atmel (the AT24RF08,
if I remember correctly) which is an eeprom as well as having some
controls over the access abilities (sort of 'permissions' of the areas
of it's memory).  From our current understanding, there is little (or
none) actual corruption, but rather a 'messing up' of the permissions
which causes the Bios to not be able to calculate the checksum of the
eeprom on boot up, and kick out a warning (which is by-passable by
hitting ESC).  Some users have said that the error was fatal, but some
other say that simply hitting ESC solves the issue.  But, most of this
is just a guess.  IBM hasn't been helpful in working with us, so there
isn't much we can do but gather info from users out there having
problems or experimenting.  If we had a Thinkpad or some technical
data from IBM, we would be better off.

The cause (as is warned in the documentation and in sensors-detect) is
this:  The I2C/SMBus protocol is very simple.  It has no indications
for what is present on the bus.  Unlike PCI, we can't just ask the
system the vendor/type/model of the device on the bus before talking
with it.  We must 'probe' all addresses on the bus to find chips, and
then try to identify them using a variety of tests and deductive
logic.  Some chips do NOT like this and react unfavorable if
communicated with in an unfavorable way.  Our first experience with
such a chip (which I experienced personally) was a clock generator
chip at 0x69 which would hang the I2C/SMBus when it was probed.  
Cycling the power on the box would make everything return to normal.

To this point, only IBM Thinkpads have had a chip which reacts
unfavorably to our probes (in a completely undocumented way) in a
persist condition.  That's why I was thinking that your computer (also
made by IBM) might have the same chip (still possible!).

I think you might be correct that we should warn ALL IBM users about 
using sensors-detect.  We are working on code, too, which will try to 
identify IBM's and simply blacklist them all so no Lm-sensors will 
attempt to run on the platform without explicitly being forced.

Thanks for your messages, and please let us know what you find out.  
Also let us know if there are any questions you have which we may be 
able to answer to help you fix this unfortunate situtation.


Phil


On Tue, Jul 30, 2002 at 02:20:17PM -0700, Minesh Khatri wrote:
> yes, i can boot from cd, just not from hard disk. it was definately an lm-sensors
> problem, because while i was running it, the thing crashed and never came back up
> again. (before i ran lm-sensors, everything was working perfectly). i did not
> have a whole lot of useful data on my hard drive that i had not already backed
> up, so i thought it was worth just re-installing the operating system. 
> 
> i guess i could have given the 'esc' idea a shot, but it's too late now :-). i
> had heard that lm-sensors in thinkpads can cause you to have to replace the board
> because it wipes out the eeprom, so i just wanted to make sure my situation was
> not that dire. although after my experience, you may want to append the warning
> to include IBM Intellistations as well. has anyone come up with an idea as to a
> probable cause for this kind of behavior?
> 
> thanks,
> minesh
> 
> --- phil@netroedge.com wrote:
> > 
> > OK, well this is beginning to sound different than the Thinkpad 
> > issue... How can you re-install w/o being able to boot?  Can you boot 
> > to CD but not HD or something?
> > 
> > On Thinkpads, it's been reported that you can hit 'ESC' to break out 
> > of the hanging error screen when booting, you could try that.  On 
> > Thinkpads, the ESC gets out of the error condition and the error 
> > message goes away after you shutdown and restart again (so I've 
> > heard).
> > 
> > Do you know that it was lm-sensors which did this, or was it just one
> > of the things you've done lately which may be suspect?
> > 
> > If you can boot to CD and your CD can see the harddrive, then it's 
> > likely that it is a boot loader problem.  Hard to say how lm-sensors 
> > could effect your boot loader?
> > 
> > 
> > Phil
> > 
> > On Tue, Jul 30, 2002 at 02:07:04PM -0700, Minesh Khatri wrote:
> > > nothing happens after the IBM logo comes up. i can still go to the BIOS
> > setup,
> > > but that's about it. after the logo, there is just a cursor in the top right
> > > corner and the system is hosed. i am reinstalling linux right now and
> > hopefully
> > > it will reboot correctly. do you know what the problem might be?
> > > 
> > > thanks,
> > > minesh
> > > 
> > > --- phil@netroedge.com wrote:
> > > > 
> > > > Hi, what happens when you try to boot?  Do you get a CRC error or 
> > > > something like that?  It's possible that you are experiencing the 
> > > > 'Thinkpad' problem, although I don't want to jump to conclusions at 
> > > > this point.
> > > > 
> > > > 
> > > > Phil
> > > > 
> > > > On Tue, Jul 30, 2002 at 10:40:35AM -0700, Minesh Khatri wrote:
> > > > > Hi,
> > > > > 
> > > > > I ran your program, sensors-detect, on Red Hat 7.3, and now it has
> > screwed up
> > > > my
> > > > > computer (IBM Intellistation). Linux will no longer boot. I was wondering
> > if
> > > > you
> > > > > had any solutions or reasons as to why this is happening? 
> > > > > 
> > > > > Thanks,
> > > > > Minesh
> > > > > 
> > > > > __________________________________________________
> > > > > Do You Yahoo!?
> > > > > Yahoo! Health - Feel better, live better
> > > > > http://health.yahoo.com
> > > > 
> > > > -- 
> > > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > > 
> > > 
> > > __________________________________________________
> > > Do You Yahoo!?
> > > Yahoo! Health - Feel better, live better
> > > http://health.yahoo.com
> > 
> > -- 
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Health - Feel better, live better
> http://health.yahoo.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
