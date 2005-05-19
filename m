From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041014095439.GA32248@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 13, 2004 at 10:25:39AM -0700, Greg KH wrote:
> On Tue, Oct 12, 2004 at 11:18:22PM +0100, Ben Dooks wrote:
> > +
> > +static int debug_info;
> > +static int debug_norm = 1;
> 
> Why not make these module_param()?  That way they could be changed at
> module load time, or at run time (module paramaters are also boot line
> options if they are built into the kernel.) 
> 
> Or, most likely, these can just be deleted all together as you aren't
> developing the driver anymore, right?

Although I am happy with the current stability, there is scope for
more development, as we do not currently support the slave mode
operation for this driver. Since we do not have (and have not seen)
any examples of this on the 2410/2440, we are not in a hurry to
support it.
 
> > +/* Debug */
> > +
> > +#define DBG(lev, msg...) do {\
> > +	if (lev < debug_info) \
> > +		dev_info(i2c->dev, msg); \
> > +	if (lev < debug_norm ) \
> > +		dev_dbg(i2c->dev, msg); \
> > +	} while(0)
> 
> And if they go away, this odd DBG() macro can also go away, right?

would `#define DBG(lev, msg..) do {} while(0)` be good enough, so
that the debugging info is left if it needed to be resurrected later?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
