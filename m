From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030318012337.GA4904@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 17, 2003 at 08:17:14PM -0500, Mark D. Studebaker  wrote:
> 
> I'm catching up on my mail. Glad to have you on the job.

Thanks.

> It's good you are taking things from CVS.
> As you may know, Kyosti Malkki did a lot of cleanup and
> pre-2.4.9 compatiblility removal in January.
> He branched i2c CVS (with the HEAD 2.5-compatible).
> Lm_sensors CVS is not branched.

So where should I be looking to get the latest kernel code?  It looks
like the kernel files in drivers/i2c/ are in the i2c CVS's kernel/
directory, right?

And then the kernel drivers/i2c/busses/ and drivers/i2c/chips match up
with the lm_sensors2 CVS's kernel/busses and kernel/chips directories?

If so, any hope of merging the two to make it at least sane?  :)

> The biggest thing remaining to do in CVS is tackling
> the PCI drivers. Approx. 20 of our 60 drivers are PCI.

Where are these drivers?  I only see 17 instances of pci_module_init()
in the lm_sensors2 cvs tree.  Are these the ones?  If you look at
2.5.65, 3 ones were added from the cvs tree (and converted to work
properly with the pci code.)  I see there are only 5 drivers in the main
kernel tree that use pci_module_init() so a number more still need to be
moved into there.

> I'd like to keep sensors CVS 2.4-compatible, or at least
> delay a branch as long as possible. Kyosti was working
> on getting to the point that we could submit a patch
> to 2.4 (until we do that, CVS is incompatible with stock 2.4
> kernels because of the i2c_driver struct change).

Why care about backwards compatibility?  Hopefully there will not need
to be a cvs tree for the kernel portions of the i2c code if we get all
of the code into the main kernel tree.

It's tough to develop code in a cvs tree and then move that into the
main kernel tree (trust me, I've done it for years...)  It's much easier
once the code is in the main kernel, to just work off of those versions,
possibly keeping a few patches along as they are developed, before they
are accepted in the main kernel trees.  I've successfully done this for
the pci hotplug code for 2.4 and 2.5, and the usb code for 2.2, 2.4, and
2.5.

Also, kernel code over kernel major versions differs a lot.  Already the
i2c code is branched due to the driver model changes, and that will also
cause more changes in the future (all good :)

> Any sensors changes/cleanups that are 2.4 compatible,
> it's preferable to check those changes into CVS
> for testing. Ideally we can submit drivers to 2.5 directly
> out of CVS.

Are there any test scripts or procedures that one should go through to
determine if any changes break anything or not?

thanks,

greg k-h
