From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041015000134.GC19890@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 14, 2004 at 10:54:39AM +0100, Ben Dooks wrote:
> > > +/* Debug */
> > > +
> > > +#define DBG(lev, msg...) do {\
> > > +	if (lev < debug_info) \
> > > +		dev_info(i2c->dev, msg); \
> > > +	if (lev < debug_norm ) \
> > > +		dev_dbg(i2c->dev, msg); \
> > > +	} while(0)
> > 
> > And if they go away, this odd DBG() macro can also go away, right?
> 
> would `#define DBG(lev, msg..) do {} while(0)` be good enough, so
> that the debugging info is left if it needed to be resurrected later?

Just do what the other i2c drivers do.  Have dev_dbg() be enabled if the
proper CONFIG option is set.  Otherwise dev_dbg() goes away to nothing.

thanks,

greg k-h
