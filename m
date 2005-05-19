From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040114190315.GA6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 05, 2004 at 09:34:41AM -0700, Tom Rini wrote:
> On Sun, Jan 04, 2004 at 05:08:49PM +1100, Rusty Russell wrote:
> 
> > In message <1072821970727@kroah.com> you write:
> > > +/* If fix_hstcfg is set to anything different from 0, we reset one of the
> > > +   registers to be a valid value. */
> > > +static int fix_hstcfg = 0;
> > > +MODULE_PARM(fix_hstcfg, "i");
> > > +MODULE_PARM_DESC(fix_hstcfg,
> > > +		"Fix config register. Needed on some boards (Force CPCI735).");
> > > +
> > 
> > BTW, it'd be nice if someone converted these to module_param, too...
> 
> Done.

Applied, thanks.

greg k-h
