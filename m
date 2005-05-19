From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: major lm_sensors problem
Message-Id: <20020731094732.H9662@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200207301755.g6UHtga04064@shire.frodo.local>
In-Reply-To: <200207301755.g6UHtga04064@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Yup, it's the AssetID chip (RFID eeprom).  So, it does seem to be the=20
'Thinkpad' issue after all.

Thanks for the link.  That's intesting that it effected your=20
bootloader of all things.  Odd.

If you get brave and want to try sensors-detect again, try to tell it=20
to skip address 0x5C.  That's where the access controls are for the=20
RFID chip.

In any case, I'm glad things are working for you again! :')


Phil

On Wed, Jul 31, 2002 at 06:43:24AM -0700, Minesh Khatri wrote:
> Well thankfully, the Linux reinstall worked fine. it appears lm-sensors m=
ight
> have messed up the boot manager because I was still able to get into a ba=
re bones
> linux rescue mode which allowed me to mount my old filesystem before i wi=
ped it
> out. (though i don't know how lm-sensors caused the problem)
>=20
> i think that chip you're talking about is the AssetID chip? if that's the=
 case,
> they are equipped in intellistations and other newer IBMs, as this link
> indicates:
>=20
> http://216.239.37.100/search?q=CAche:J1jUqL825uwC:www5.pc.ibm.com/ww/me.n=
sf/fd3ecf9754f09e878525697a006cc4a5/322919c94899700e85256a9d006e99a0/%24FIL=
E/xbasset.PDF+atmel+intellistation&hl=3Den&ie=3DUTF-8
>=20
> if it's just a problem with that particular chip, maybe you guys should j=
ust try
> to scan for that chip, and blacklist the computer if it has it (and not j=
ust all
> IBMs in general, since i bet there are a lot of IBMs on which lm-sensors =
would
> work, and maybe there are also other computers out there that might have =
this
> Atmel chip) but until then, a disclaimer in the documentation warning all=
 IBMs
> might be a good idea :-)
>=20
> --- phil@netroedge.com wrote:
> >=20
> > Interesting... Well, I hope a reinstall works for you.  I couldn't say =

> > how or why it might.  Lm-sensors doesn't have much to do with=20
> > harddrive storage or how the boot-blocks work.
> >=20
> > Yeah, actually the Thinkpad issue (from my understanding) is this:
> >=20
> > IBM uses a strange chip on some Thinkpads made by Atmel (the AT24RF08,
> > if I remember correctly) which is an eeprom as well as having some
> > controls over the access abilities (sort of 'permissions' of the areas
> > of it's memory).  From our current understanding, there is little (or
> > none) actual corruption, but rather a 'messing up' of the permissions
> > which causes the Bios to not be able to calculate the checksum of the
> > eeprom on boot up, and kick out a warning (which is by-passable by
> > hitting ESC).  Some users have said that the error was fatal, but some
> > other say that simply hitting ESC solves the issue.  But, most of this
> > is just a guess.  IBM hasn't been helpful in working with us, so there
> > isn't much we can do but gather info from users out there having
> > problems or experimenting.  If we had a Thinkpad or some technical
> > data from IBM, we would be better off.
> >=20
> > The cause (as is warned in the documentation and in sensors-detect) is
> > this:  The I2C/SMBus protocol is very simple.  It has no indications
> > for what is present on the bus.  Unlike PCI, we can't just ask the
> > system the vendor/type/model of the device on the bus before talking
> > with it.  We must 'probe' all addresses on the bus to find chips, and
> > then try to identify them using a variety of tests and deductive
> > logic.  Some chips do NOT like this and react unfavorable if
> > communicated with in an unfavorable way.  Our first experience with
> > such a chip (which I experienced personally) was a clock generator
> > chip at 0x69 which would hang the I2C/SMBus when it was probed. =20
> > Cycling the power on the box would make everything return to normal.
> >=20
> > To this point, only IBM Thinkpads have had a chip which reacts
> > unfavorably to our probes (in a completely undocumented way) in a
> > persist condition.  That's why I was thinking that your computer (also
> > made by IBM) might have the same chip (still possible!).
> >=20
> > I think you might be correct that we should warn ALL IBM users about=20
> > using sensors-detect.  We are working on code, too, which will try to=20
> > identify IBM's and simply blacklist them all so no Lm-sensors will=20
> > attempt to run on the platform without explicitly being forced.
> >=20
> > Thanks for your messages, and please let us know what you find out. =20
> > Also let us know if there are any questions you have which we may be=20
> > able to answer to help you fix this unfortunate situtation.
> >=20
> >=20
> > Phil
> >=20
> >=20
> > On Tue, Jul 30, 2002 at 02:20:17PM -0700, Minesh Khatri wrote:
> > > yes, i can boot from cd, just not from hard disk. it was definately an
> > lm-sensors
> > > problem, because while i was running it, the thing crashed and never =
came
> > back up
> > > again. (before i ran lm-sensors, everything was working perfectly). i=
 did not
> > > have a whole lot of useful data on my hard drive that i had not alrea=
dy
> > backed
> > > up, so i thought it was worth just re-installing the operating system=
.=20
> > >=20
> > > i guess i could have given the 'esc' idea a shot, but it's too late n=
ow :-).
> > i
> > > had heard that lm-sensors in thinkpads can cause you to have to repla=
ce the
> > board
> > > because it wipes out the eeprom, so i just wanted to make sure my sit=
uation
> > was
> > > not that dire. although after my experience, you may want to append t=
he
> > warning
> > > to include IBM Intellistations as well. has anyone come up with an id=
ea as to
> > a
> > > probable cause for this kind of behavior?
> > >=20
> > > thanks,
> > > minesh
> > >=20
> > > --- phil@netroedge.com wrote:
> > > >=20
> > > > OK, well this is beginning to sound different than the Thinkpad=20
> > > > issue... How can you re-install w/o being able to boot?  Can you bo=
ot=20
> > > > to CD but not HD or something?
> > > >=20
> > > > On Thinkpads, it's been reported that you can hit 'ESC' to break ou=
t=20
> > > > of the hanging error screen when booting, you could try that.  On=20
> > > > Thinkpads, the ESC gets out of the error condition and the error=20
> > > > message goes away after you shutdown and restart again (so I've=20
> > > > heard).
> > > >=20
> > > > Do you know that it was lm-sensors which did this, or was it just o=
ne
> > > > of the things you've done lately which may be suspect?
> > > >=20
> > > > If you can boot to CD and your CD can see the harddrive, then it's =

> > > > likely that it is a boot loader problem.  Hard to say how lm-sensor=
s=20
> > > > could effect your boot loader?
> > > >=20
> > > >=20
> > > > Phil
> > > >=20
> > > > On Tue, Jul 30, 2002 at 02:07:04PM -0700, Minesh Khatri wrote:
> > > > > nothing happens after the IBM logo comes up. i can still go to th=
e BIOS
> > > > setup,
> > > > > but that's about it. after the logo, there is just a cursor in th=
e top
> > right
> > > > > corner and the system is hosed. i am reinstalling linux right now=
 and
> > > > hopefully
> > > > > it will reboot correctly. do you know what the problem might be?
> > > > >=20
> > > > > thanks,
> > > > > minesh
> > > > >=20
> > > > > --- phil@netroedge.com wrote:
> > > > > >=20
> > > > > > Hi, what happens when you try to boot?  Do you get a CRC error =
or=20
> > > > > > something like that?  It's possible that you are experiencing t=
he=20
> > > > > > 'Thinkpad' problem, although I don't want to jump to conclusion=
s at=20
> > > > > > this point.
> > > > > >=20
> > > > > >=20
> > > > > > Phil
> > > > > >=20
> > > > > > On Tue, Jul 30, 2002 at 10:40:35AM -0700, Minesh Khatri wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > I ran your program, sensors-detect, on Red Hat 7.3, and now i=
t has
> > > > screwed up
> > > > > > my
> > > > > > > computer (IBM Intellistation). Linux will no longer boot. I w=
as
> > wondering
> > > > if
> > > > > > you
> > > > > > > had any solutions or reasons as to why this is happening?=20
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > > Minesh
> > > > > > >=20
> > > > > > > __________________________________________________
> > > > > > > Do You Yahoo!?
> > > > > > > Yahoo! Health - Feel better, live better
> > > > > > > http://health.yahoo.com
> > > > > >=20
> > > > > > --=20
> > > > > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > > > > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > > > > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > > > >=20
> > > > >=20
> > > > > __________________________________________________
> > > > > Do You Yahoo!?
> > > > > Yahoo! Health - Feel better, live better
> > > > > http://health.yahoo.com
> > > >=20
> > > > --=20
> > > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > >=20
> > >=20
> > > __________________________________________________
> > > Do You Yahoo!?
> > > Yahoo! Health - Feel better, live better
> > > http://health.yahoo.com
> >=20
> > --=20
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
>=20
>=20
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Health - Feel better, live better
> http://health.yahoo.com

--=20
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
