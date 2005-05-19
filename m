From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <1081849205.407bb5753794d@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Catching that train...

> > i2c layer uses SMBUS_QUICK mode to find devices on the bus.
> > With current ibm iic driver it always succeeds no matter is device
> > there or not.
> 
> I know how i2c layer does this and I believe this is not the right
> approach.

Well, it has proven to be efficient for all chips but one (Atmel's
AT24RF08) so far, and this case was considered a defect in the chips
state machine.

The "quick write" operation is part of the SMBus specification
(actually
it's named "quick command" there).

I agree that this command is *not* fundamentally a detection command,
and it *does* "write" a bit to the chip, so it can have an effect on
it.  It just happens that most of the i2c chips do not handle that
command specifically, so using it for detection just works with no side
effect.

The reason why a "quick write" was implemented and not a "quick read"
(which would also *send* a single bit, but 1 instead of 0) is unknown;
looks like an arbitrary decision, but maybe was motivated by a reason I
can't think of.

How do you suggest we would detect chips if not that way?

> In general case you cannot just write some random garbage to some
> random device and expect everything to work after wards.

There is no data sent, which is why it usually doesn't disturb the
chips.

> Your detection code MUST check whether your expected device exists
> at this address (and not some other device) using 
> device-specific access. Matt already mentioned some example of such
> code.
> If something ACKs on particular address doesn't mean there is a
> device you are expecting.

Evgeniy already updated its chip driver code in that sense, so it
should
solve the problem. That said, this is a common scheme of the i2c-core
to only call detection function on addresses that have been detected to
hold a chip. If your bus driver doesn't reliably distinguish between
polulated and unpopulated addresses, the chip driver's detection
function will end up being called on all possible addresses (and in
Evgeniy's case this is as much as 8 or even 16 addresses). Each time
it'll issue a number of i2c commands (read word in this case), most of
the time at addresses that do not exist. Maybe it'll cause more trouble
to your bus than the "quick write" would have.

Just my two cents anyway. I don't know anything about your physical
SMBus device, and I wasn't there when it was decided that quick writes
would be used for detection purposes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
