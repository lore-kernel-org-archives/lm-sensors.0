From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-algo-bit timing
Message-Id: <3DEA4F76.71B364B1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I looked carefully at the loops in i2c_outb() and i2c_inb().
These are what set the timing and duty cycle for most of an i2c bus
cycle.
I'm (for the moment) ignoring timing and issues outside these loops.
If any of these statements don't look correct, speak up :)

- i2c_outb generates a 33% duty cycle clock (udelay high, 2 * udelay
low)
- i2c_inb generates a 50/50 clock (udelay high, udelay low)
- Neither function calls sdahi or sdalo inside its loop in normal
operation,
   so changes to sdahi/sdalo won't affect the duty cycle.
- It appears that we can make changes to i2c_outb to get a 50/50 clock.
  The loop from i2c_outb() is annotated below. Note that these
  changes don't correctly handle delays coming into and out of the loop.



	/* assert: scl is low */
	for ( i=7 ; i>=0 ; i-- ) {
		sb = c & ( 1 << i );
		setsda(adap,sb);
// The following udelay ensures setup time to the r.e. of the clock,
// and ensures the clock low time (together with the udelay at the
bottom of the loop)
// It could be changed to udelay(adap->udelay - 1)
		udelay(adap->udelay);
		DEBPROTO(printk(KERN_DEBUG "%d",sb!=0));
// The following call to sclhi() contains a call to delay(adap->udelay)
// which ensures the clock high time
		if (sclhi(adap)<0) { /* timed out */
			sdahi(adap); /* we don't want to block the net */
			DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x, timeout at bi			
			return -ETIMEDOUT;
		};
		/* do arbitration here: 
		 * if ( sb && ! getsda(adap) ) -> ouch! Get out of here.
		 */
		setscl(adap, 0 );
// The following udelay ensures hold time after the f.e. of the clock,
// and ensures the clock low time (together with the udelay at the top
of the loop)
// It could be changed to udelay(1) and still meet the 300 ns hold time
// (ref. I2C bus spec version 2.1, table 5, note 2)
		udelay(adap->udelay);
	}




Ky?sti M?lkki wrote:
> 
> On Wed, 27 Nov 2002, Mark D. Studebaker wrote:
> 
> > If I'm looking at your 2nd picture correctly, it looks like it
> > implements a 50/50 duty cycle. That looks right to me. I don't
> > understand why there are udelays() in the sdalo() and sdahi()
> > functions.
> 
> It was udelay/3 duty cycle. Some setup and hold time is required,
> 1 us is around 66 PCI clocks.
> 
> > We don't want to violate that. If udelay = 5,
> > (which implies a 100 KHz clock) that should
> > be the minimum time high _or_ low for the clock.
> 
> If we use 1us in sdahi/lo, and udelay=3 for sclhi/lo,
> we get duty cycle of udelay/(udelay+2):
> 
> SDA: -__--------_______---------
> SCL: --__---_____---_____---____
> 
> Finally, with SDA half of SCL clock rate and (udelay-1) offset:
> 
> SDA: -______________-------------______
> SCL: --___---___---___---___---___---___
> 
> As for other issues in algo-bit:
> 
> At several locations, return code of sclhi() is silently ignored,
> 
> I think I replace i2c_start with i2c_repstart -- if SCL is already low,
> we may have multi-master or bus stuck. To count for possibility of a
> second master, we should read back SDA level on master write slots.
> 
> Are return values of i2c_transfer and friends explained somewhere?
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
