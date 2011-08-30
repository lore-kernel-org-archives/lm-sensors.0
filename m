From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 30 Aug 2011 16:13:24 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (max16065) Add chip access
Message-Id: <20110830161324.GA25652@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314683876-16557-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314683876-16557-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 30, 2011 at 11:26:05AM -0400, Jean Delvare wrote:
> On Tue, 30 Aug 2011 07:26:44 -0700, Guenter Roeck wrote:
> > On Tue, Aug 30, 2011 at 03:14:12AM -0400, Jean Delvare wrote:
> > > On Mon, 29 Aug 2011 22:57:56 -0700, Guenter Roeck wrote:
> > > > The chips supported by the max16065 driver should not be accessed using direct
> > > > i2ctools commands. Add warning to driver documentation to alert users.
> > > > 
> > > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > > ---
> > > > RFC: Do we want this kind of warning in driver documentation ?
> > > 
> > > Sure, this can't hurt. Maybe we could add a section in i2c-tools'
> > > documentation as well, listing the dangerous chips, starting with this
> > > one? i2cdetect already has a note about the AT24RF08 for historical
> > > reasons, I wouldn't mind documenting the "dangerous" chips more
> > > prominently. Hopefully the list will stay short.
> > > 
> > Hopefully yes. Many of the PMBus chips are potentially affected, though.
> > They typically have a means to protect settings from overwrite, but if that
> > is not enabled, one can be in hot water. Worst I have seen so far was
> > to execute i2cdump on an eval board and it lost its configuration :(.
> 
> You are lucky. Back in 2002, worse a few lm-sensors users saw was their
> shiny new Thinkpad laptop tuned into a brick by sensors-detect (not
> even i2c-tools) due to what ended up being a state machine bug in the
> AT24RF08.)
> 
> Speaking of this... At which I2C addresses to these PMBus devices live?
> MAX16065/66 in particular but also other chips with similar problems.

MAX16065/66 is not a PMBus device ... by default, it resides at 0x50..0x53
(possibly the worst address space available for such a device).
That address can be overwritten by software to any valid address.
It does not have an ID register, so it can not be auto-detected.

PMBus devices can unfortunately be at any valid address. Many chips use a set
of resistors to set the address. Even those not using resistors can often
be programmed by SW to any address.

> If these are addresses sensors-detect is probing, then it's only a
> matter of time before we get a report from a user hitting the problem.
> 
Might well be. Most don't react too badly on reads, though. I had the problem
specifically with the Intersil chips. On those, the byte reads done by i2cdump
on write-only command registers are accepted as write commands. This causes
the chip configuration to be lost unless all writes are disabled/secured.
Which was not the case on my eval board. Oops ...

Turning PMBus chips into bricks is actually quite simple - I managed to do it
with several chips from multiple vendors. Since one has to do that on purpose
or by being careless (as in my case ;), so I would not count that against
the chips.

> Probably it's about time to let the kernel block user-space probing of
> specific I2C buses.

Sounds like a good idea. This is one reason why we don't set I2C_CLASS_HWMON
in our internal I2C adapter drivers.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
