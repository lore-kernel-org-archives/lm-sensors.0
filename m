From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 25 Sep 2007 09:20:21 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75 should handle I/O errors
Message-Id: <20070925112021.6babd618@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Mon, 24 Sep 2007 13:09:00 -0700, David Brownell wrote:
> > On Tue, 18 Sep 2007 09:51:07 -0700, David Brownell wrote:
> > > When talking to a TMP75 chip with a flakey I2C adapter (it easily gets
> > > underrun errors on loaded systems), I happened to notice that the LM75
> > > driver holds the delusion that I/O calls can never fail.
> >
> > Almost all I2C chip drivers do...
> 
> Oops.  I suppose that's partially explained by how rude the fault model
> in those calls is ... such as
> 
>  - normally returning "-1" instead of a real "what went wrong" code;
>  - can't say how many RX bytes are valid, in error-after-N-bytes cases;
>  - can't say how many TX bytes were sent before slave NAK
>  - after slave NAKs a TX, can't control whether to issue the next i2c_msg
>  - ...
> 
> So it's less realistic than usual to expect drivers to check for faults.

I'm not happy with this situation either. In particular your first
point is a pity and would be pretty easy to fix. Feel free to submit
patches.

> > > This patch corrects that by retrying a few times after errors, and then
> > > by refusing to record error codes as register values.  The retries seem
> > > to resolve the problem under light system loads.  Clearly they won't be
> > > able to resolve it in all cases, so the second mechanism is also needed.
> >
> > The patch looks correct and could be applied, however... While I agree
> > that the error handling mechanism belongs to the lm75 driver, the retry
> > mechanism doesn't. Duplicating this retry mechanism in all chip drivers
> > doesn't look good. Don't you think it would be better implemented at
> > i2c adapter level, or even better at i2c core level?
> 
> Nope.  It's not OK to retry all messages.  In *this* case, reads have no
> side effects (the TMP75 had SMBALERT# cleared using that SMBus patch),
> and the writes are idempotent ... so it's safe.  That's not true in general.
> (Simple counter-example:  messages may update counters, explicitly or
> implicitly.  Retries would bork the counters...)

Let me play the devil's advocate here. We retry only if a transaction
failed. If the transaction failed, how could it have any side effect?

> It's message-specific whether retrying is safe ... and context-specific
> whether it's desirable.  And by "message" I mean an entire array of
> "struct i2c_msg" instances, not an individual "i2c_msg".

I did not suggest retrying individual i2c_msg, that wouldn't make any
sense. But retrying arrays of i2c_msgs (aka transactions) sounds rather
safe to me. Do you have a real-world example where it is not, or are
you playing it safe just in case?

I guess that your point of view is the reason why i2c-algo-bit and
i2c-algo-pcf only retry if the address byte wasn't acked, and not after
that.

> > We have i2c_adapter.retries for that already, however it seems that the
> > code to handle retries is missing in most bus drivers. Only
> > i2c-algo-bit, i2c-algo-pcf, i2c-pxa and i2c-s3c2410 appear to implement
> > it, and not even the same way: the former two only retry if the address
> > byte is not acked, while the latter two retry on any failure.
> 
> No wonder this "retry" thing has always seemed like a puzzle to me!
> 
> I do know that when I tripped over algo-bit retrying, it seemed more
> buglike than not.  (Eight retries to establish that the alert response
> message had done its job?  Puhleeeze!)

Admittedly, if you are doing reads and expect them to fail (which is
also the case when we use zero-byte messages to probe for chip
presence) the retry mechanism is not so desirable and only slows things
down.

> > What about moving the retry mechanism to i2c-core (in i2c_smbus_xfer
> > and i2c_transfer)?
> 
> Retry logic certainly doesn't belong in the lowlevel (adapter) code.
> 
> If it needs to exist at all, I'd rather see it controlled by whoever
> issues the call.  Maybe an I2C_M_RETRIES mask for a two-bit field,
> defaulting to no retries, which could be assigned by the caller iff
> they know it's safe to retry ... though the i2c_smbus_*() calls
> have no way to pass such stuff.

There is a way: we can make this an i2c_client attribute or flag. just
like I2C_CLIENT_TEN sets I2C_M_TEN, I2C_CLIENT_RETRIES (2-bit flag)
could set I2C_M_RETRIES.

> It'd be best IMO if the retry mechanism were just removed.

If you have strong arguments for that, just send a patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
