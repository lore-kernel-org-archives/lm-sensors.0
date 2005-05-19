From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041012195026.GB9085@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 12, 2004 at 12:16:27PM -0700, Greg KH wrote:
> On Tue, Oct 12, 2004 at 10:00:50AM +0100, Ben Dooks wrote:
> > + * Changelog
> > + *	29-Sep-2004	BJD	Initial version
> > + *	04-Oct-2004	BJD	Fixed ignore ACK on last read
> > + *	08-Oct-2004	BJD	Fixed stop if zero length message
> 
> Changelogs for kernel files are in the bk tree, not in the individual
> files.  Otherwise, after a number of years, we end up with a huge mess
> (look at drivers/usb/serial/usb-serial.c for an example of that...)
> 
> Please remove them from the file.
> 
> > +#define PFX "s3c-i2c: "
> 
> Not needed
> 
> > +#define XFER_RETRY (-2000)
> > +#define XFER_NAKED (-ECONNREFUSED)
> 
> Don't make up new error codes, just use the exiting ones please.

will remove
 
> > +static int debug_info = 0;
> 
> Don't pre-initialize variables to 0.  It wastes space and is
> unnecessary.
> 
> > +/* Debug */
> > +
> > +#define DBG(lev, msg...) do {\
> > +	if (lev < debug_info) \
> > +		printk(KERN_INFO msg); \
> > +	if (lev < debug_norm ) \
> > +		printk(KERN_DEBUG msg); \
> > +	} while(0)
> 
> Please just use the dev_dbg(), dev_err() and friends macros instead of
> rolling your own.  Also use them instead of printk() to make it more
> consistant, and easier to determine the exact device spitting out the
> error/message.

ok, will make the changes for dev_err(), the debugging stuff i
annoying as there is no way to control how much is included if any
is.
 
> Hm, I don't see a MODULE_LICENSE() marking in the file.  How have you
> been able to load it without tainting the kernel?

no-one ever bothered to check if the code was built into the kernel
without a valid MODULE_LICENSE.

> > +/* IO read/write functions */
> > +
> > +static inline void wr_regb(struct s3c24xx_i2c *i2c, int reg, unsigned int val)
> > +{
> > +	writeb(val, i2c->regs + reg);
> > +}
> > +
> > +static inline void wr_regl(struct s3c24xx_i2c *i2c, int reg, unsigned long val)
> > +{
> > +	writel(val, i2c->regs + reg);
> > +}
> > +
> > +static inline unsigned long rd_regb(struct s3c24xx_i2c *i2c, int reg)
> > +{
> > +	return (unsigned long)readb(i2c->regs + reg);
> > +}
> > +
> > +static inline unsigned long rd_regl(struct s3c24xx_i2c *i2c, int reg)
> > +{
> > +	return readl(i2c->regs + reg);
> > +}
> 
> Just use the real write* and read* functions in your code, don't wrap
> them up into something else.  Also try building this with the 2.6.9-rc4
> kernel, odds are you will get a bunch of warnings about stuff that needs
> to be fixed here...  (hint void *regs needs to be void __iomem *regs in
> the s3c24xx_i2c structure.)

ok, sorted.

> > +#if 1
> > +	s3c24xx_i2c_showmsgs(msgs, num);
> > +#endif
> 
> Heh, is this needed?

it was very useful for debugging, suppose it can go now

i'll post a new patch when i've finished checking through the
rest of the changes


-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
