From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <3E768459.4040005@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Greg KH wrote:
> On Mon, Mar 17, 2003 at 08:17:14PM -0500, Mark D. Studebaker  wrote:
> 
>>I'm catching up on my mail. Glad to have you on the job.
> 
> 
> Thanks.
> 
> 
>>It's good you are taking things from CVS.
>>As you may know, Kyosti Malkki did a lot of cleanup and
>>pre-2.4.9 compatiblility removal in January.
>>He branched i2c CVS (with the HEAD 2.5-compatible).
>>Lm_sensors CVS is not branched.
> 
> 
> So where should I be looking to get the latest kernel code?  It looks
> like the kernel files in drivers/i2c/ are in the i2c CVS's kernel/
> directory, right?
> 

right

> And then the kernel drivers/i2c/busses/ and drivers/i2c/chips match up
> with the lm_sensors2 CVS's kernel/busses and kernel/chips directories?
> 

right

> If so, any hope of merging the two to make it at least sane?  :)
> 

sounds like more trouble than it is worth;
hard to move files in CVS without losing the history.

> 
>>The biggest thing remaining to do in CVS is tackling
>>the PCI drivers. Approx. 20 of our 60 drivers are PCI.
> 
> 
> Where are these drivers?  I only see 17 instances of pci_module_init()
> in the lm_sensors2 cvs tree.  Are these the ones?  If you look at
> 2.5.65, 3 ones were added from the cvs tree (and converted to work
> properly with the pci code.)  I see there are only 5 drivers in the main
> kernel tree that use pci_module_init() so a number more still need to be
> moved into there.
> 

right. Plus a couple more in chips/ that don't call pci_module_init
(sis5595, vt8231). Minus the ones already in 2.5 (I see that
2.5.65 added your patch with 3 more) leaves about 15.

My point was the ~40 non-PCI drivers should go a lot more easily;
Kyosti already did a lot of cleanup on those.

> 
>>I'd like to keep sensors CVS 2.4-compatible, or at least
>>delay a branch as long as possible. Kyosti was working
>>on getting to the point that we could submit a patch
>>to 2.4 (until we do that, CVS is incompatible with stock 2.4
>>kernels because of the i2c_driver struct change).
> 
> 
> Why care about backwards compatibility?  Hopefully there will not need
> to be a cvs tree for the kernel portions of the i2c code if we get all
> of the code into the main kernel tree.
> 

We have a large number of 2.4-based "customers". Our project is
ranked in the top 100 on freshmeat (no idea if that means anything, though :)
If our 2.7.0 release last December was the last 2.4-compatible release,
how bad is that? I don't know. Unless we get a patch into 2.4, it will be,
because of the i2c_driver struct change that's already been made in CVS.
I'm guessing we want to release 2.4-compatible packages for another year?
But maybe that's hopelessly ambitious. Maybe 2.7.0 will have to be it.
Kyosti was optimistic that on the lm_sensors side (as opposed to i2c),
we could stay compatible with 2.4 and 2.5 in one branch. But he
hasn't been heard from in a while...

> It's tough to develop code in a cvs tree and then move that into the
> main kernel tree (trust me, I've done it for years...)  It's much easier
> once the code is in the main kernel, to just work off of those versions,
> possibly keeping a few patches along as they are developed, before they
> are accepted in the main kernel trees.  I've successfully done this for
> the pci hotplug code for 2.4 and 2.5, and the usb code for 2.2, 2.4, and
> 2.5.
> 
> Also, kernel code over kernel major versions differs a lot.  Already the
> i2c code is branched due to the driver model changes, and that will also
> cause more changes in the future (all good :)
> 

I'm not disagreeing with you. Maybe it's easier with our collection of
small drivers. Maybe not. Maybe it only makes sense for drivers not
yet in the kernel.

> 
>>Any sensors changes/cleanups that are 2.4 compatible,
>>it's preferable to check those changes into CVS
>>for testing. Ideally we can submit drivers to 2.5 directly
>>out of CVS.
> 
> 
> Are there any test scripts or procedures that one should go through to
> determine if any changes break anything or not?
> 

Nothing formal.
You can send the group mail and ask for testing. I have a pretty good collection of HW.
For bus drivers, if you're lucky enough to have HW to test on,
you should try i2cdetect, and i2cdump (with different modes).
For chip drivers, even if you don't have the hardware, it's
good to load the module with a force_xxx parameter and
then try 'sensors' and look in /proc.

> thanks,
> 
> greg k-h
