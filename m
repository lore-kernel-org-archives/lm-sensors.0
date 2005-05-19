From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: lm_sensors
Message-Id: <20020908121158.A17459@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Just to throw my $.02 in, I think Kyosti is right to say the problem
isn't really ideally fixed, however we've made some significant
progress in making it fairly safe for known users with this chip.

As far as adding locking goes, I can't think of a reason why we need
locking to implement the I2C/SMBus protocol.  It would be the safest
way to go to implement a completely reliable workaround for this
particular issue, but is it *right*?  Unless we are going to need this
locking mechanism as a standard feature, I would opt to not implement
it.  Are there are any other devices which require that consecutive
transations (not just with it, but all bus transactions) to be tightly
controlled?  Do we have reason to believe that there may be more in
the future?

The nice thing with putting drivers in the kernel is that we can allow
everyone access to the bus w/o the risk of someone hogging control of
it.  If we add locking, we potentially lose that if a user-space app
abuses the locking feature.


Phil

On Sat, Sep 07, 2002 at 02:18:18PM -0400, Mark D. Studebaker wrote:
> Ky?sti M?lkki wrote:
> > 
> > On Thu, 5 Sep 2002, Mark D. Studebaker wrote:
> > 
> > > Kyosti has described some ways in which the 24RF08 could still
> > > theoretically be corrupted (on non-IBM systems). While not disagreeing
> > > with him, I think we need to draw the line somewhere, and in my
> > > opinion we have a good explanation for Alan Cox that we have both
> > > blacklisted the IBM systems _AND_ fixed the actual problem on non-IBM
> > > systems, if there are any.
> > 
> > I think we should not claim the actual problem fixed until adapter
> > lock is held between the two Write Quicks. Unless of course, if you
> > can convince Alan Cox that it hardly ever happens...
> > 
> > 1. Module eeprom.o
> > 
> > Generates Quick + multiple Read sequences if loaded with chksum!=0.
> > 
> 
> I verified that 'modprobe eeprom checksum=1' does corrupt the 24RF08.
> We should add a second write quick, but that doesn't solve your locking
> concern.
> 
> > Lucky we are, even number of Quicks protects 24rf08 from being
> > corrupted by future transactions, but the lock issue applies here.
> > I do not know if loading another client "simultaneuosly" is safe.
> > 
> > 2. Two Write Quicks are breaken apart, since adapter lock is released
> > 
> > Only single Write Quick in i2cdetect - but even number of those, and
> > two Write Quicks in sensors-detect but releasing the bus in between.
> > Just running sensors-detect twice may be harmful. First run loads
> > sensor client that polls readings every five seconds or so.
> > 
> 
> We could double the write quicks in i2cdetect like we did in
> sensors-detect.
> But that doesn't solve your locking concern.
> 
> So do you have a proposal for locking?
> Is there anyway to lock the adapter from userspace?
> If there is, that's preferable to hacking i2c-core to double/fake write
> quicks,
> in my opinion.
> 
> > > I don't see how we can prevent corruption in a multi-master system.
> > 
> > If 0x54-0x57 is known to be any eeprom, Write Byte could replace Write
> > Quick for the address probe.

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
