From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [PATCH] i2c-sis630 fixes for 2.6.0-test7
Message-Id: <20031010220001.GA18193@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310101904.19719.amalysh@web.de>
In-Reply-To: <200310101904.19719.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 10, 2003 at 07:23:21PM +0200, Alexander Malysh wrote:
> On Friday 10 October 2003 19:15, Greg KH wrote:
> > On Fri, Oct 10, 2003 at 07:04:18PM +0200, Alexander Malysh wrote:
> > > Hi Greg,
> > >
> > > attached you can find a patch that should fix i2c-sis630 driver for
> > > 2.6.0-X kernel. With i2c-sis630 from stock 2.6.0-X we have oops and
> > > driver was not correct registered against i2c-core.
> > >
> > > Changes:
> > > 	1) fixed a oops while modprobing
> > > 	2) added check for buffer overflow for i2c block data read transaction
> > > 	3) added 'force' modprobe parameter. It's allow more easily testing for
> > > not yet supported SiS chips.
> > >
> > > Please apply... Thanks.
> >
> > Why did you add a printk() call right before a call to dev_err()?  Can
> > you remove that change and resubmit the patch?
> 
> oops, sorry. It was for debugging...
> corrected patch attached.

Thanks, I've applied this and will send it on up the food chain.

greg k-h
