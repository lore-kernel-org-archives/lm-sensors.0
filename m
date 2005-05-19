From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0212110631100.22823-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Dec 2002, Mark Studebaker wrote:

> One question - is clock low time = udelay at end of a
> read, including end of i2c_inb and i2c_stop? it looks to me like
> it's only Tmin + Tmin?

Did you mean "end of i2c_inb and i2c_outb"? At end of i2c_stop clock
remains high, perhaps need to insert missing "Stop to Start" delay
there.

For repetive inb/outb clock low after ACK is T_hold+T_setup = T_scllo.
Between inb/outb ACK and stop, it is T_hold+T_min = T_min+T_min,
should really be T_hold+T_setup there.

> One other general comment - sdalo() and sdahi() could be deleted
> and inlined into test_bus(), which is the only place they're used?

I thought of adding 'paranoid' mode, that reads back bus state after
any set. This is likely to recombine bus set, get and delay in one
inlined call.

> > I have been reading the "Fast Mode" specs to test my setup, at some
> > points the 1 us I use violates this.
>
> Disagree. If you think about it, the max hold spec really only applies
> when you are an i2c slave.

Actually, I meant 1 us violates "bus free time between Stop and
Start", "Low period of SCL" and "SCL clock frequency".
With 1us resolution best we can do within fast mode specs is
udelay=2 and get 250kHz. I think stock kernel tree doesn't export
anything to improve the resolution, so I will settle for udelay.

> > The i2c_adapter->retry now applies to complete message. Previously
> > it would fail on any [NA] after the address [A].
> > I am not 100% sure how auto-incrementing EEPs will tolerate it,
> > if we fail in the middle of a page and then resend from the beginning.
>
> We may want to think about this more. Or maybe do something different
> on reads than on writes. We don't want to corrupt eeproms.

Yep. Thinking more into it, correct retry sequence is device specific if
failure happens after address byte. Both i2c<->async and i2c<->parallel
converters should continue with with the first failed byte.

Should we keep adapter->retry for address retry? Getting [NA] for
address may reflect eeprom busy writing, disconnected device or
bus problems. Do SMBus hosts ignore this?

> > A message may be sent correctly after ignored [NA], retry or timeout.
> > The caller could check this in i2c_msg->err, if necessary.
>
> OK. But the whole mechanism of saving and checking the error, etc. is
> somewhat elaborate, not sure if useful or not. If you look at the
> smbus-layer calls (which in turn use the "emulation layer" if the
> adapter is i2c-only), errors aren't returned at all.

With algo-bit this is messy, for SMBus style adapter, you can get return
code from status register directly? For simplicity, the errorcode
set in adapter driver could pass unchanged to the caller. If adapter
drivers already return <0 for failure, nothing is changed from the
caller's point of view. Unless they test for -1 explicitly, which they
should not.

Some means (besides log) to report a stuck or disconnected bus may be
necessary to support removable SMBus devices like batteries, AC adapters
etc.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
