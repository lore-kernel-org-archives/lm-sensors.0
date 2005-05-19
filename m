From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <20040412224143.478db698.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Apr 2004 10:43:06 -0700
Eugene Surovegin <ebs@ebshome.net> wrote:

> On Mon, Apr 12, 2004 at 03:59:32PM +0400, Evgeniy Polyakov wrote:
> > Attached diff against 2.4 kernel fixes "new" (for i2c-ibm_iic) i2c
> > initalization path.
> > This i2c adapter can't understand commands with zero length so it
> > doesn't recognize SMBUS_QUICK command and none chip can be attached
> > to this. Patch fixes this cruft.
> > Tested on ppc32 with max663x chip attached.
> > 
> > Please review and commit.
> 
> Well, this doesn't look correct.
> Could you explain what are you trying to do? Also, why did you change
> debugging macros?

Because they don't even compile with debug level > 0.

> Chip doesn't support 0-length transactions, and your code trying to
> start 1-byte transaction without writing any data to the output FIFO.

It does support although not fair.

I have tested with this (as you say) "hack" max663x chip.

> IBM IIC is broken enough and I don't see any point in such hacks.

Agree. But it is not point not to fixing at least initialization at
least in such manner.

> There is another patch I made for MV guys a month ago 
> (http://kernel.ebshome.net/iic_0_len-2.4.diff, 
> http://kernel.ebshome.net/iic_0_len-2.6.diff). 
> 
> It restores _incorrect_ old driver behavior and most probably I'll
> send that version upstream (I'm still waiting for OK from them).

Driver with your patch works exactly as driver without it.
It always returns 0 with or without any ACK read from bus.
It is wrong.
I "found" 7 max6634 sensors on the bus.

> 
> > === drivers/i2c/i2c-ibm_iic.c 1.4 vs 1.5 ==> > --- 1.4/drivers/i2c/i2c-ibm_iic.c	Fri Jun 27 15:19:03 2003
> > +++ 1.5/drivers/i2c/i2c-ibm_iic.c	Fri Apr  9 20:48:20 2004
> > @@ -61,14 +61,14 @@
> >  #define DBG_LEVEL 0
> >  
> >  #if DBG_LEVEL > 0
> > -#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
> > +#  define DBG(f, x...)	printk("ibm-iic" f, ##x)
> >  #else
> > -#  define DBG(x...)	((void)0)
> > +#  define DBG(f, x...)	((void)0)
> >  #endif
> >  #if DBG_LEVEL > 1
> > -#  define DBG2(x...) 	DBG( ##x )
> > +#  define DBG2(f, x...) 	DBG( f, x )
> >  #else
> > -#  define DBG2(x...) 	((void)0)
> > +#  define DBG2(f, x...) 	((void)0)
> >  #endif
> >  #if DBG_LEVEL > 2
> >  static void dump_iic_regs(const char* header, struct
> >  ibm_iic_private* dev)
> > @@ -328,6 +328,24 @@
> >  	return ret;
> >  }
> >  
> > +static int iic_write_empty(struct ibm_iic_private* dev)
> > +{
> > +	volatile struct iic_regs *iic = dev->vaddr;
> > +	int ret = 0;
> > +
> > +	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
> > +	
> > +	DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, 0, cntl);
> > +	
> > +	/* Start transfer */
> > +	out_8(&iic->cntl, cntl);
> > +	
> > +	/* Wait for completion */
> > +	ret = iic_wait_for_tc(dev);
> > +
> > +	return ret > 0 ? 0 : ret;
> > +}
> > +
> >  /*
> >   * Low level master transfer routine
> >   */
> > @@ -338,6 +356,11 @@
> >  	char* buf = pm->buf;
> >  	int i, j, loops, ret = 0;
> >  	int len = pm->len;
> > +	
> > +	if (len = 0)
> > +	{
> > +		return iic_write_empty(dev);
> > +	}
> >  
> >  	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
> >  	if (pm->flags & I2C_M_RD)
> > @@ -445,11 +468,6 @@
> >  		return -EINVAL;
> >  	}		
> >  	for (i = 0; i < num; ++i){
> > -		if (unlikely(msgs[i].len <= 0)){
> > -			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
> > -				msgs[i].len, i);
> > -			return -EINVAL;
> > -		}
> >  		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
> >  			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
> >  			return -EINVAL;
> 
> 


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
