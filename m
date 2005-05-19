From: david@fubar.dk (David Zeuthen)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Patch for I2C + sysfs
Message-Id: <1073694587.5310.86.camel@laptop.fubar.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109231724.GC4693@kroah.com>
In-Reply-To: <20040109231724.GC4693@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2004-01-10 at 01:17, Greg KH wrote:
> But i2c adapters _are not_ on the i2c bus.  They are the "bridge device"
> between say the PCI bus and the i2c bus.  They are really just a PCI
> device, and so that's where they are in the tree.
> 

Ok, so they are exactly like PCI devices of class 12, subclass 3 (USB
serial controller) as seen in this screenshot

 http://freedesktop.org/~david/hal-pci-usb.png

right? (except of course they bridge PCI with i2c instead of USB)

Many thanks,
David
