From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Aug 2011 07:45:35 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (max16065) Add chip access
Message-Id: <20110831094535.024f5cc4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314683876-16557-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314683876-16557-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 30 Aug 2011 09:13:24 -0700, Guenter Roeck wrote:
> On Tue, Aug 30, 2011 at 11:26:05AM -0400, Jean Delvare wrote:
> > You are lucky. Back in 2002, worse a few lm-sensors users saw was their
> > shiny new Thinkpad laptop tuned into a brick by sensors-detect (not
> > even i2c-tools) due to what ended up being a state machine bug in the
> > AT24RF08.)
> > 
> > Speaking of this... At which I2C addresses to these PMBus devices live?
> > MAX16065/66 in particular but also other chips with similar problems.
> 
> MAX16065/66 is not a PMBus device ... by default, it resides at 0x50..0x53
> (possibly the worst address space available for such a device).

Indeed. We might have to stop probing these addresses completely in
sensors-detect, too bad for the ADM1033/34. The detection currently
only accesses registers 0x3d, 0x3e and 0x3f, hopefully it's OK for the
MAX16065/66.

> That address can be overwritten by software to any valid address.
> It does not have an ID register, so it can not be auto-detected.

I've seen many chips with this software address change feature, but
I've rarely seen it used in practice. Such address changes are only
needed in case of address collisions, and in this case you can't access
the device in the first place without an alternative register access
method or a switch or multiplexer on the I2C bus. In which case
changing the address is no longer mandatory.

> PMBus devices can unfortunately be at any valid address. Many chips use a set
> of resistors to set the address. Even those not using resistors can often
> be programmed by SW to any address.

We will have to address problems as they show up on a case by case
basis then.

> > If these are addresses sensors-detect is probing, then it's only a
> > matter of time before we get a report from a user hitting the problem.
>
> Might well be. Most don't react too badly on reads, though.

The problem is that not all chips agree on what a register read is, due
to the flexibility (or lack of standardization) of the I2C protocol.
Thankfully PMBus devices should be implemented as SMBus slaves so they
should follow the standard SMBus transactions. However in practice you
found they don't always do.

> I had the problem
> specifically with the Intersil chips. On those, the byte reads done by i2cdump
> on write-only command registers are accepted as write commands. This causes
> the chip configuration to be lost unless all writes are disabled/secured.
> Which was not the case on my eval board. Oops ...
> 
> Turning PMBus chips into bricks is actually quite simple - I managed to do it
> with several chips from multiple vendors. Since one has to do that on purpose
> or by being careless (as in my case ;), so I would not count that against
> the chips.

You can always blame anyone when this happens... the loose I2C
specification, the chip manufacturer, Linux tools, yourself... It's
really a combination of all these that leads to disasters, and only the
last two we have a control over.

> > Probably it's about time to let the kernel block user-space probing of
> > specific I2C buses.
> 
> Sounds like a good idea. This is one reason why we don't set I2C_CLASS_HWMON
> in our internal I2C adapter drivers.

This doesn't currently protect you against sensors-detect, that's the
problem. The lack of I2C_CLASS_HWMON only protects you against kernel
hwmon drivers.

Some months ago I made sensors-detect more clever in which I2C adapters
it accepts to probe by default. In particular, we skip I2C adapters on
PCI multimedia controllers. However this is only an unreliable band
aid, there's definitely room for improvement.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
