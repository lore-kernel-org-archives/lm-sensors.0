From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0211280002430.20734-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 Nov 2002, Mark D. Studebaker wrote:

> If I'm looking at your 2nd picture correctly, it looks like it
> implements a 50/50 duty cycle. That looks right to me. I don't
> understand why there are udelays() in the sdalo() and sdahi()
> functions.

It was udelay/3 duty cycle. Some setup and hold time is required,
1 us is around 66 PCI clocks.

> We don't want to violate that. If udelay = 5,
> (which implies a 100 KHz clock) that should
> be the minimum time high _or_ low for the clock.

If we use 1us in sdahi/lo, and udelay=3 for sclhi/lo,
we get duty cycle of udelay/(udelay+2):

SDA: -__--------_______---------
SCL: --__---_____---_____---____

Finally, with SDA half of SCL clock rate and (udelay-1) offset:

SDA: -______________-------------______
SCL: --___---___---___---___---___---___

As for other issues in algo-bit:

At several locations, return code of sclhi() is silently ignored,

I think I replace i2c_start with i2c_repstart -- if SCL is already low,
we may have multi-master or bus stuck. To count for possibility of a
second master, we should read back SDA level on master write slots.

Are return values of i2c_transfer and friends explained somewhere?

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
