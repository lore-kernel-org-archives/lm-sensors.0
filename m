From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <20040413154612.GB9630@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 13, 2004 at 11:40:05AM +0200, Jean Delvare wrote:
> Catching that train...
> 
> > > i2c layer uses SMBUS_QUICK mode to find devices on the bus.
> > > With current ibm iic driver it always succeeds no matter is device
> > > there or not.
> > 
> > I know how i2c layer does this and I believe this is not the right
> > approach.
> 
> Well, it has proven to be efficient for all chips but one (Atmel's
> AT24RF08) so far, and this case was considered a defect in the chips
> state machine.
> 
> The "quick write" operation is part of the SMBus specification
> (actually
> it's named "quick command" there).

Yeah, I know.

> I agree that this command is *not* fundamentally a detection command,
> and it *does* "write" a bit to the chip, so it can have an effect on
> it.  It just happens that most of the i2c chips do not handle that
> command specifically, so using it for detection just works with no side
> effect.
> 
> The reason why a "quick write" was implemented and not a "quick read"
> (which would also *send* a single bit, but 1 instead of 0) is unknown;
> looks like an arbitrary decision, but maybe was motivated by a reason I
> can't think of.
> 
> How do you suggest we would detect chips if not that way?

I think it's a major i2c defect (or design feature :). Bus wasn't design to 
support "autodetection" and decision to use one should be on case by case basis.

In embedded systems (and 4xx is an embedded chip) you usually do NOT 
autodetect anything...

>  > In general case you cannot just write some random garbage to some
> > random device and expect everything to work after wards.
> 
> There is no data sent, which is why it usually doesn't disturb the
> chips.

Well, in patch Evgeniy sent this is not the case. Due to the chip design there 
is no easy way to implement "quick write", so he decided to incorrectly 
issue "full" 1-byte write with random data.

So basically in SMBus speak, "quick" write command I2C_SMBUS_QUICK (which maybe 
harmless) was substituted with I2C_SMBUS_BYTE and _this_ is wrong and I was 
trying to explain why.

> > Your detection code MUST check whether your expected device exists
> > at this address (and not some other device) using 
> > device-specific access. Matt already mentioned some example of such
> > code.
> > If something ACKs on particular address doesn't mean there is a
> > device you are expecting.
> 
> Evgeniy already updated its chip driver code in that sense, so it
> should
> solve the problem. That said, this is a common scheme of the i2c-core
> to only call detection function on addresses that have been detected to
> hold a chip. If your bus driver doesn't reliably distinguish between
> polulated and unpopulated addresses, the chip driver's detection
> function will end up being called on all possible addresses (and in
> Evgeniy's case this is as much as 8 or even 16 addresses). Each time
> it'll issue a number of i2c commands (read word in this case), most of
> the time at addresses that do not exist. Maybe it'll cause more trouble
> to your bus than the "quick write" would have.

Yeah, probably, but this is the way old driver worked and I don't remember any 
whining about this before :).

As I've written in my previous e-mails we can implement "quick" write 
properly (using bit-banging), but it's not very trivial and definitely not the 
way Evgeniy tried to do this.

You see, I'm not a big fan of i2c-autodetection so it's not a high priority 
item in my list. Although after this long discussion I'm starting to think that 
maybe I'll do this just to get users off my back :)

Eugene.
