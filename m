From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <20031222180324.GA2742@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 22, 2003 at 06:55:46PM +0100, Jean Delvare wrote:
> > > I searched my mail archive for Greg's original comment, but couldn't
> > > find it. Greg, any chance you could refresh my memory?
> > 
> > For systems that have a 64bit kernel, and a 32bit userspace, all
> > ioctls in the kernel need a "thunking" layer in order to pass the data
> > between the kernel and userspace properly.  Last I looked that layer
> > did not contain any i2c ioctls, so i2c-dev will not work on those
> > kinds of systems (ppc64, sparc64, mips64, amd64, ia64, etc...)
> 
> OK. This means that these architectures can't user i2cdetect at the
> moment, but could do at a later time, providing the necessary layer is
> written.
> 
> So I think that the right thing to do would be to remove all bus
> scanning from the drivers themselves. Reasons for doing this have been
> discused earlier in this thread. If some people need bus scanning and
> i2cdetect doesn't work for them, I guess we'll hear from them, and
> we'll write the layer.

I agree, it should be done by the i2c core, or by userspace, but not by
each individual driver.  I played around a bit with adding it to the i2c
core, and enabling hotplug events for every device found, which would
cause the different i2c chip drivers to be automatically loaded by
userspace.  But I felt it was too big of a change for 2.6, due to it
being so late in the development cycle.  Something like that should be
on the 2.7 wishlist though...

thanks,

greg k-h
