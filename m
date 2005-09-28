From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 28 Sep 2005 04:49:26 +0000
Subject: [lm-sensors] [PATCH] fix functionality constant for read_byte_pec
Message-Id: <20050928024853.GA10192@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

> > * Jean Delvare <khali@linux-fr.org> [2005-09-25 23:32:39 +0200]:
> > > I think this is the right time to analyze the situation, and rework the
> > > whole PEC implementation to make it better. I think I understand that

> On 2005-09-27, Mark M. Hoffman wrote:
> > I question whether it's the "right time" if there are no in-kernel users.
> > OTOH, I won't try to talk you out of working on it.

* Jean Delvare <khali@linux-fr.org> [2005-09-27 12:36:52 +0200]:
> Let me reformulate then. As there are no in-kernel users yet, I think
> this is the right time to remove the current (partly broken) PEC
> implementation before anyone starts using it. And while we are (or at
> least I am) at it, let's see if we can come up with a better
> implementation. I plan to have the lm90 driver use PEC for at least the
> ADM1032, so this will be the first user of the new PEC implementation.

I didn't realize you had plans to use it - cool.

> > > (7) SMBus slaves will support PEC on all transactions they use, or none.
> > >
> > > (8) SMBus masters will support PEC an all transactions they support, or
> > > none. Not sure it actually matters though.
> >
> > Yes that's probably true of the hardware at least.  The drivers are a
> > different story though.  I'd rather have the option (as a bus driver
> > author) to *not* implement a bus xfer that I can't test and/or don't
> > need. If I want just one PEC xfer, now I have to implement all of them?
> 
> No, you don't, which is why I commented on (8) probably not mattering
> after all. In my planned model, clients (that is, chip driver
> implentations) declare themselves globally PEC-capable, then start a
> transaction. The bus driver *may* check for I2C_CLIENT_PEC and *may* use
> the PEC version of the requested transaction if it implements it. This
> is all optional and the choice is made on individual transaction types.
> A given bus driver may implement byte data writes with PEC and not byte
> data reads with PEC, for example (purely hypothetical case). A client
> which declared itself PEC capable when attaching to that bus will get
> byte data writes with PEC when asking for byte data writes, and byte
> data reads without PEC when asking for byte data reads. The client
> isn't supposed to care or even know whether the bus does support any
> particular transaction with PEC.

OK, I get it now (duh).

> > > (6) implies that (1) is not needed for SMBus masters. Clients do not
> > > need to be aware of PEC support for individual transactions. It's
> > > actually questionable whether they need to know about the bus PEC
> > > capabilities at all (except for ARP, maybe.) They certainly don't need
> > > to know whether PEC support is hardware or software.
> >
> > If you're planning to kill all the individual PEC func flags, I guess
> > that's OK.  If you're going to make PEC support all-or-nothing for
> > bus drivers, then you can just have a single PEC-capable flag for them.
> > (That will solve the smbus-arp.c problem in your patch in a later msg.)
> 
> I'm not sure a global flag is even needed. Apart from arp-smbus, I
> can't think of any other case where a client will make a decision on
> that flag. As I see it, arp-smbus was a proof-of-concept, it's not
> supposed to stay as is if we ever implement ARP. ARP is a part of the
> SMBus specification itself and should be included in i2c-core (or
> i2c-core-arp if we want to keep it separated) rather than a regular chip
> driver.

I looked at this some time ago just out of curiosity.  There's no doubt
that real SMBus/ARP support would need some help from i2c-core.  Clients
would need to register as ARP-capable. The client would also have to tell
i2c-core what its 128-bit UDID is.  Then, whenever i2c-core decides to 
(re)enumerate the bus, it must have a way to let the client know if/when
the address has changed.

It helps, by the way, to forget whatever you may know about ethernet ARP
while you're looking at this.

> Do you happen to know how ARP is physically implemented on systems where
> it exists? Unfortunately I have no system with ARP (or I guess I'd see
> something at address 0x61). My guess is that the ARP is no separate chip
> on the bus but is integrated into the host itself. If this is true, then
> it would probably be more logical to have bus drivers that are ARP

Every ARP-capable device listens on address 0x61.  Most of the ARP commands
only require the slave(s) to ACK - so if there are 2 or more slaves, they
will all "answer" at once and there's no problem with that.  OTOH, a cmd
like Get UDID will start off with all slaves answering, but they will
drop out one by one (because of normal I2C bus arbitration rules) until
one of them has spoken its own UDID.  When the master issues Get UDID again,
any slave that has already answered completely must now stay quiet.  And
so the host continues issuing Get UDID until no one answers.

> capable register themselves to i2c-core-arp which would contain the
> common code, rather than blindly probing for something at 0x61 on every

That was more or less my vision also.  But note: I thought SMBus/ARP
support would ultimately require no changes to existing bus drivers
(assuming they were PEC capable, anyway).  But i2c-core-arp would need
some way to guarantee that the bus driver performs the PEC xfers.
Or as you mentioned, let the bus driver tell the core that it is ARP
capable.

> bus. But I need to take a longer look at arp-smbus and the ARP section
> in the SMBus 2.0 specification before I say more on this.

Yes anyway, it's good to keep this all in mind as you're reworking PEC
support.

> Additional notes of interest:
> 
> * I'm not even sure we need the current arp-smbus driver to check for
> PEC capabilities. Although the SMBus 2.0 specification says PEC is
> mandatory for ARP, it's obviously for reliability reasons, and I don't
> think anything bad would happen if a non-PEC ARP-capable system was ever
> created, as long as no I/O error happen.

I couldn't care less about the arp-smbus demo driver in CVS.  If you
replaced the contents of that file with the entire works of Shakespeare
(in a comment, so it still compiled) I don't think anyone would notice.

> * Even if the above were wrong, I doubt we'll ever see a device at
> address 0x61 other than for ARP, so the address restriction alone is
> probably enough for detection.
>
> * We can play it safe and leave I2C_FUNC_SMBUS_HWPEC_CALC in place at
> least for the moment. My planned implementation of PEC would drop
> software PEC support for non-I2C SMBus masters, leaving only three
> possibilities: I2C masters using software PEC, SMBus masters using
> hardware PEC, and SMBus masters without PEC. I2C_FUNC_I2C would imply
> software PEC, I2C_FUNC_SMBUS_HWPEC_CALC would imply hardware PEC, so PEC
> support would be (I2C_FUNC_I2C | I2C_FUNC_SMBUS_HWPEC_CALC) != 0.
> 
> * I still think that a single PEC flag is rather error prone, because
> I2C_FUNC_SMBUS_HWPEC_CALC means that at least one transfer supports PEC,
> that might not the ones ARP needs, for example (just like I2C protolo
> mangling has a single FUNC flag covering 4 capabilities, not all of
> which may be implented in any bus driver). In contrast, software PEC
> will always be complete (I see no reason it can't be.)

True.

> > Again: keep a single PEC-capable flag though.
> 
> I will, in that I won't drop the one which exists for now - but I would
> welcome a concrete example where this would be needed.

As I mentioned... *if* SMBus/ARP support were to be completely transparent
to the bus driver, you would need this... else if you add a flag that marks
a bus driver as ARP capable, that's just as good.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

