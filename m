From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-viapro and via686a don't mix with linux-2.6.0-test1
Message-Id: <20030715181909.GA4622@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030715142051.GA14443@h111.hadiko.de>
In-Reply-To: <20030715142051.GA14443@h111.hadiko.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 15, 2003 at 06:14:34PM +0200, Jean Delvare wrote:
> Log Message:
> (mds) don't use pci_module_init() for video i2c drivers so we don't
>       conflict with video drivers
> 
> It was for a different conflict (it seems). However, the changes made to
> i2c-viapro.c may also prevent the conflict you observed. This is a very
> recent change (occured on July 2nd.). I attached the patch, could you
> please check wether it is already applied to the 2.6.0 kernel tree? If
> not, could you try to apply it and tell us if it solves your problem?
> 
> I admit I'm a bit confused, because i2c-viapro is a bus driver while
> via686a is a chip driver. Thus I wonder how they can conflict...
> However, the driver registering mechanisms of the Linux kernel is beyond
> me, so it may just be me ;)

No, this isn't a valid solution.  The proper thing would be to put the
i2c bus functions within the video driver.  

The issue is that only one pci driver can bind to a device at the same
time.  You are working around it by grabbing the pci device that is
already bound to another driver, but that way is racy, and can cause big
problems (your driver will not be notified if the device goes away, like
in a hotplug system.)  Because of this, I'll be removing the
pci_for_each_dev() functions from the kernel once 2.7 opens up, and
possibly sooner if that takes a while...

thanks,

greg k-h
