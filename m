From: greg@kroah.com (Greg KH)
Date: Sun, 03 Sep 2006 01:56:36 +0000
Subject: [lm-sensors] Interface to PCI device list
Message-Id: <20060903015636.GA2541@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902164248.9a0075e4.khali@linux-fr.org>
In-Reply-To: <20060902164248.9a0075e4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 02, 2006 at 10:41:51PM +0200, Jean Delvare wrote:
> So on the multi-domain machine, the domain is prepended to the bus
> number. This is where lspci appears to be taking the information when
> told to use /proc. I found that lspci was using /sys/bus/pci/devices by
> default on Linux 2.6. It can be forced back to using /proc/bus/pci,
> with more or less success depending on the system.

Yes, lspci uses sysfs to get most of it's info these days.

> > > 3* Will /sys/bus/pci/devices go away eventually?
> > 
> > No, that is the proper way to easily enumerate all PCI devices in the
> > system.  X is also switching over to use this, so it can not go away any
> > time in the next couple of years, unless something really wrong is found
> > with it (and something new would have to be created for it, which I
> > don't see happening...)
> 
> Damn. I thought your answer was a bit strange, until I read my question
> again and noticed I had messed up ;) Let me try again:
> 
> 3B* Will /proc/bus/pci go away eventually?
> 
> Of course, I did not expect /sys/bus/pci/devices to go away by the
> next 7 years...

Heh, ok, that makes more sense.

No, I don't have any immediate plans to drop it.  It is messy, and hard
to read, but some tools use it (like X) and the code to generate it is
very tiny.  But who knows, someone might send me a patch once X is
converted over to use sysfs fully :)

> > Hope this helps,
> 
> Well, now I get to decide what I want to do. I need the PCI class and
> this doesn't appear to be easy to get using /proc/bus/pci (you need to
> walk through subdirectories, and extract the 3 class bytes from each
> binary file.)

Which is exactly why we created sysfs :)

> This seems much easier to get it from /sys/bus/pci/devices (single
> directory to get the list, then just one text file to read to get the
> class for each device.)

Yes.

> For now my code is a ugly hack reading the device list
> from /proc/bus/pci/devices, then for each device the class
> from /sys/bus/pci/devices if available. That was the shortest path from
> the current code to what I wanted to do, and was good enough for
> testing, but I'd be ashamed to commit it as is. The only advantage is
> the compatibility with 2.4 kernels.

Ick, who cares about 2.4 anymore :)

I'd recommend using sysfs, and following the rules of walking the tree
and not relying on specific files to be present that might not be in the
future.  Also please be able to handle any directory turning into a
symlink at any point in the future too, but since you aren't messing
with the /sys/class/ directories, I don't think this will be a problem
for you.

If you want, we have some very flexible code in udev to traverse sysfs
and get various things from it.  Feel free to use it, as the license is
the same for both projects (GPL).

thanks,

greg k-h

