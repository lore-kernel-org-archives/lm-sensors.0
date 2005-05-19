From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 0/2] i2c: new sysfs class "hwmon"
Message-Id: <20050413055824.GA25581@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411044427.GA4963@jupiter.solarsys.private>
In-Reply-To: <20050411044427.GA4963@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 13, 2005 at 12:22:10AM -0400, Mark M. Hoffman wrote:
> Hi Greg, thanks for your advice:
> 
> * Greg KH <greg@kroah.com> [2005-04-12 14:55:55 -0700]:
> > On Mon, Apr 11, 2005 at 12:44:27AM -0400, Mark M. Hoffman wrote:
> > > Hi Khali, Greg, et. al:
> > > 
> > > After a brief chat w/ Khali last week (and some reading LDDv3) I did these
> > > patches.  The result for me looks like this:
> > > 
> > > /sys/class/hwmon/1-0290/device/ -> /sys/devices/platform/i2c-1/1-0290
> > > 
> > > Notes/Questions:
> > 
> > First a question from me, why?  What are you trying to do here?  Who
> > will be using the hwmon class?  And what for?  Will all "sensor-like"
> > sysfs files move to this new class, or is it just to enable userspace to
> > be able to find the hwmon devices easier?
> 
> Khali is working on patches to get rid of the i2c-isa 'pseudo-adapter'.
> Since any sensor chip attached to the ISA bus will no longer appear in
> the /sys/bus/i2c tree, a new way is needed.  Userspace tools can be
> taught to look in /sys/class/hwmon first, and then /sys/bus/i2c for
> backwards-compatibility.

Ok, that sounds acceptable.

> > > 1. I don't like "1-0290" for a class ID, but it was the easiest thing to
> > > use at the time.  A better name might be w83627thf-0.
> > 
> > As long as it's unique, that's the only requirement.
> 
> I just strlcpy'd the '1-0290' ID from the /sys/bus/i2c tree because it
> is unique.  My concern is that it's not very descriptive.

True, pick something else if you don't like that :)

> > > 2. The kernel complains if I don't provide a class::release function, but
> > > I can't really see a need for it in this case.  If I hold a file open through
> > > the /sys/class/hwmon/X/device/Y link and then try to rmmod the driver, the 
> > > rmmod will sleep until I close the file just as I expect.  Any hints here
> > > Greg?
> > 
> > Ick, yes, you _must_ have a release function.  _Please_ listen to the
> > kernel, it isn't saying those things for no reason...  If you add a file
> > to the class device, and do not have a release function, then you can
> 
> But... I didn't add any files to the class device. ;)  I'm not planning
> to move any existing files (temp1_input, etc) - I just want the link
> back to the device.  It didn't look like that (by itself) should require
> a release function, but I'll go back and read it again.

Ok, if you have _no_ sysfs files, and you have no where anyone else
could ever grab ahold of a reference to you, then no, you don't need a
release function.  But that's really not how a class_device structure
should be used.

> > have a memory leak.  The way that you use the class device owned by a
> > different device is not safe, nor a good idea.  I recommend using the
> 
> Err... what about struct i2c_adapter?

Yeah, that's a hack, I wouldn't look at how I intregrated the i2c code
into the driver core as _any_ model that should be copied :)

> > "class_device_create()" function that has been added to the -mm tree (or
> > the class_simple stuff that's in mainline, if you want an idea of what
> > it is.  Hm, no that will not quite work, that's why I wrote the
> > class_device_create() call...use that.)
> 
> OK, I'll try it again that way.

Thanks, I think you'll find it a lot easier.

greg k-h
