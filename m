From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <3E7B8FB5.103D3D75@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the driver model links, that's what I needed.

Greg KH wrote:
> 
> On Wed, Mar 19, 2003 at 09:21:37PM -0500, Mark D. Studebaker  wrote:
> >
> > No. The i2c and sensors projects were started by different people in
> > different places. In 1999, the i2c project was moved to be hosted
> > at Netroedge, where the sensors project was already.
> > It was put in a separate CVS tree. Over the last couple of
> > years the original i2c contributors have moved on.
> > But the separate trees remain.
> 
> Ah, that makes more sense now, thanks for the history lesson.
> 
> > guess I missed something, exactly what are the "driver model changes"?
> 
> Converting the i2c core, and all drivers over to the kernel driver
> model.  See include/linux/device.h for the structures and
> Documentation/driver-model/* for lots of documentation.  Also, Pat
> Mochel has written a lot of good documentation at:
>         http://www.kernel.org/pub/linux/kernel/people/mochel/doc/lca/driver-model-lca2003.tar.gz
> 
> It basically involves hooking the drivers and core up to the rest of the
> kernel, like I've already done.  All of the kernel's drivers are either
> already converted to this model, or are in the process of being
> converted.
> 
> > I see a new adapter.dev.parent in the bus drivers, is that it?
> 
> For now, yes.
> 
> > Are there any changes affecting the chip drivers? I didn't see any.
> 
> Not yet.  If you look at my original patch I sent to the list, I do hook
> up the chip drivers to the driver core, but don't do much with them.  I
> didn't include that portion in my patches to Linus as it needs some more
> work to get everything working properly.
> 
> Does this help explain stuff?  I hope to have a more concrete set of
> patches soon to show what I'm talking about (code is sometimes easier to
> understand than documentation :)
> 
> thanks,
> 
> greg k-h
