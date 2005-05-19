From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040812002117.GA30854@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810225714.GA2700@pc.aurel32.lan>
In-Reply-To: <20040810225714.GA2700@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 12, 2004 at 01:11:16AM +0200, Aurelien Jarno wrote:
> On Wed, Aug 11, 2004 at 08:36:51PM +0200, Jean Delvare wrote:
> > > sensors-detect currently checks at the beginning of its execution if
> > > the i2c device nodes exists. It can't work on a system using udev as
> > > the nodes are created when the i2c-dev module is inserted.
> > > 
> > > The attached patch fixes that.
> > 
> > I don't get this:
> > 
> > +  if (-d './dev') {
> It's a typo, I made the patch to quickly. Should be
> if (-d './dev') {

I still don't see how that shows if you are running on a udev system or
not.  Why not check for /dev/.udev.tdb or grep the process list for
udevd (hm, but SLES 9 will fail that one, even though it's using udev.)

thanks,

greg k-h
