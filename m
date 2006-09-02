From: greg@kroah.com (Greg KH)
Date: Sat, 02 Sep 2006 18:30:13 +0000
Subject: [lm-sensors] Interface to PCI device list
Message-Id: <20060902183013.GB31197@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902164248.9a0075e4.khali@linux-fr.org>
In-Reply-To: <20060902164248.9a0075e4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 02, 2006 at 04:42:48PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Currently, the sensors-detect script uses /proc/bus/pci/devices (file)
> to get a list of the PCI devices on the system. As this file doesn't
> contain PCI class data, and I need it, I was looking for an
> alternative. For 2.6 kernels, /sys/bus/pci/devices (directory) looks
> like the right place to look at. This raises a few questions, which I
> hope you can answer:
> 
> 1* /proc/bus/pci/devices doesn't appear to contain PCI domain
> information. I guess it only lists the devices on domain 0000, and
> would miss devices on multi-domain machines?

Yes, it doesn't contain domain info on x86 boxes.  Not sure about bigger
ones like ia64 or ppc64.

> 2* Since which kernel version does /sys/bus/pci/devices look like the
> way it is right now? Did the device IDs always include the PCI domain?
> If it's stable since 2.6.0, I could use it in sensors-detect.

/sys/bus/pci/devices has always been there since 2.6.0.  I don't know
for sure about the format of the pci bus ids, but I think they have been
the same since that time too.

> 3* Will /sys/bus/pci/devices go away eventually?

No, that is the proper way to easily enumerate all PCI devices in the
system.  X is also switching over to use this, so it can not go away any
time in the next couple of years, unless something really wrong is found
with it (and something new would have to be created for it, which I
don't see happening...)

Hope this helps,

greg k-h

