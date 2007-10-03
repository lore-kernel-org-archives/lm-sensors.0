From: David Brownell <david-b@pacbell.net>
Date: Wed, 03 Oct 2007 19:58:37 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75 should handle I/O errors
Message-Id: <20071003195837.2E900239415@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > The patch looks correct and could be applied, however... While I agree
> > > that the error handling mechanism belongs to the lm75 driver, the retry
> > > mechanism doesn't. Duplicating this retry mechanism in all chip drivers
> > > doesn't look good. Don't you think it would be better implemented at
> > > i2c adapter level, or even better at i2c core level?
> > 
> > Nope.  It's not OK to retry all messages.  In *this* case, reads have no
> > side effects (the TMP75 had SMBALERT# cleared using that SMBus patch),
> > and the writes are idempotent ... so it's safe.  That's not true in general.
> > (Simple counter-example:  messages may update counters, explicitly or
> > implicitly.  Retries would bork the counters...)
>
> Let me play the devil's advocate here. We retry only if a transaction
> failed. If the transaction failed, how could it have any side effect?

Partial failures are the norm in complex systems ... and I2C doesn't
even have transactional semantics.  (No ACID guarantees, etc.)  Messages
aren't guaranteed to have atomic effects.  So a fault happening half way
through could leave the message half-acted-upon... the half that was
acted upon could easily have had a side effect.


> > It's message-specific whether retrying is safe ... and context-specific
> > whether it's desirable.  And by "message" I mean an entire array of
> > "struct i2c_msg" instances, not an individual "i2c_msg".
>
> I did not suggest retrying individual i2c_msg, that wouldn't make any
> sense. But retrying arrays of i2c_msgs (aka transactions) sounds rather
> safe to me. Do you have a real-world example where it is not, or are
> you playing it safe just in case?

The PMBus "clear fault" request needs only a single i2c_message,
whether it's part of such a "transaction" or not.

Scenario:  issue the clear fault request; a new fault is reported;
retry clear_fault.  Now you've lost a fault notification.


> I guess that your point of view is the reason why i2c-algo-bit and
> i2c-algo-pcf only retry if the address byte wasn't acked, and not after
> that.

And in fact, I noticed that the comment for the I2C_RETRIES ioctl
is explicit that it only applies to the address.  If any driver
retries anything more, that'd be incorrect ...

Also:  given that definition, SMBus devices shouldn't be retried,
since they must always acknowledge their addresses.  If this retry
mechanism sticks around, maybe it should be coupled with a flag
like I2C_CLIENT_SMBUS, with SMBus devices never getting retries.


> > > We have i2c_adapter.retries for that already, however it seems that the
> > > code to handle retries is missing in most bus drivers. Only
> > > i2c-algo-bit, i2c-algo-pcf, i2c-pxa and i2c-s3c2410 appear to implement
> > > it, and not even the same way: the former two only retry if the address
> > > byte is not acked, while the latter two retry on any failure.

So it seems like i2c-pxa and i2c-s3c2410 should at least be
bugfixed to match the I2C_RETRIES semantics (address only).


> > No wonder this "retry" thing has always seemed like a puzzle to me!
> > 
> > I do know that when I tripped over algo-bit retrying, it seemed more
> > buglike than not.  (Eight retries to establish that the alert response
> > message had done its job?  Puhleeeze!)
>
> Admittedly, if you are doing reads and expect them to fail (which is
> also the case when we use zero-byte messages to probe for chip
> presence) the retry mechanism is not so desirable and only slows things
> down.

When you're probing for an SMBus device with a QUICK zero-byte
message, a lack of response should be definitive.  I2C devices
are allowed ignore the address stage if they're too busy.


> > > What about moving the retry mechanism to i2c-core (in i2c_smbus_xfer
> > > and i2c_transfer)?
> > 
> > Retry logic certainly doesn't belong in the lowlevel (adapter) code.
> > 
> > If it needs to exist at all, I'd rather see it controlled by whoever
> > issues the call.  Maybe an I2C_M_RETRIES mask for a two-bit field,
> > defaulting to no retries, which could be assigned by the caller iff
> > they know it's safe to retry ... though the i2c_smbus_*() calls
> > have no way to pass such stuff.
>
> There is a way: we can make this an i2c_client attribute or flag. just
> like I2C_CLIENT_TEN sets I2C_M_TEN, I2C_CLIENT_RETRIES (2-bit flag)
> could set I2C_M_RETRIES.

If the mechanism is needed, yes.  But as you noted, it's hardly
supported at all ... so it's not being relied on, and thus wouldn't
seem to need a replacement.


> > It'd be best IMO if the retry mechanism were just removed.
>
> If you have strong arguments for that, just send a patch.

I may do that.  There don't seem to be any real requirements to
have it, and half of its (four) implementations violate even its
current loose specification.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
