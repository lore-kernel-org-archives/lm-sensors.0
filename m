From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0212151036430.32061-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Dec 2002, Mark Studebaker wrote:

> BTW, I want to make sure you've read the suggestions Dori Eldar made
> this summer, which I summarized in i2c/TODO. They're the ones marked
> "D.E.".

Yes. I got some idea what is doable and what to drop on the floor.

> > Actually, I meant 1 us violates "bus free time between Stop and
> > Start", "Low period of SCL" and "SCL clock frequency".
> > With 1us resolution best we can do within fast mode specs is
> > udelay=2 and get 250kHz. I think stock kernel tree doesn't export
> > anything to improve the resolution, so I will settle for udelay.
> >
> Agreed. Fast mode max is a udelay of 1.25. If people want to
> violate that and set a udelay of 1, they can at their peril.
> We should add documentation that a udelay of 2 (250 kHz) is a practical
> lower limit and we do not recommend a udelay of 1.
>
> When nanosleep or whatever gets exported, we can do better.

I decided to go for a new algorithm driver that pushes bus timing to the
adapter code. Currently it falls back to udelay(), but could use any
approriate counter/timer available.
I hope to get this tested a bit and commited today.

> Reading ticket 517 more carefully, the i2c-core layer DOES return
> error codes pretty faithfully. I thing the bus drivers do too.
> So I misspoke. It's the CHIP drivers that generally ignore the
> error returns and the -1 return gets cast to an FF value.

Yes, i2c-core gives -1 for any error. Being more specific about what
went wrong can be done without breaking compatibility. In i2c_transfer,
we could pass return from algo->xfer as-is.

> Should we keep adapter->retry? Seems like more trouble than it is worth.
> Maybe you could hold it back as part 2 of the patch?

Well my patch got so radical that I broke compatibility, and some
changes are not easy to port back.
I think I have caught and fixed following problems in original code:

All the duty cycle stuff.

If SDA is stuck low, writes seem to work, reads returns 0x00.
If SCL is stuck low, we keep hitting timeout.
The driver should die more gracefully on bus failure, and advice the
caller to give up by returning -ENODEV or something besides -1.

After SCL timeout, SCL is not pulled low by host.
Client may release SCL at any time between timeout and stop.
At some situations, timeout is ignored and/or SDA is toggled.
Stop assumes SCL low on entry.


> The i2c_smbus_xxx_xxx calls return an s32, -1 on failure.
> In a chip driver, for example, it should probably check for -1
> returns and throw out that reading, and show the user the last good reading.
> Otherwise, cast s32 to u8 as usual.

Why test for -1 explicitely, just test negative for error?

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
