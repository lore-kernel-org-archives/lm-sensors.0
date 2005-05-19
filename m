From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Patch for I2C + sysfs
Message-Id: <20040110001700.GB5429@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109231724.GC4693@kroah.com>
In-Reply-To: <20040109231724.GC4693@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 09, 2004 at 04:56:12PM -0700, Matthew Mastracci wrote:
> >But adapters are not on the i2c bus.  They are the "root" of the i2c
> >bus.  I2C adapters live as devices on other busses (PCI, platform, etc.)
> 
> I'm modelling this after the usb sysfs entry.  The usb adapters 
> themselves appear in /sys/bus/usb/devices:

That is because those "usbX" devices _are_ real USB devices.  They are
the USB root hub, which lives in the silicon inside the USB controller.
The kernel sees them as a real USB device, and they talk USB to the
kernel.

I2C adapters are not like that.

> >What exactly is the problem that HAL can't see the devices in the place
> >where they are in the sysfs tree?
> 
> Without this patch, the device only appears in two places:
> 
>   * under the class directory with class "i2c-adapter", and

This is why that class directory was created.  In order that userspace
can find all of the i2c adapters.

>   * under the root devices tree in its respective pci path.
> 
> If you contrast this with the usb controllers, they appear in three places:
> 
>    * under the class directory with class "usb_host",
>    * under the root devices tree in its repective pci path, and
>    * under the /sys/bus/usb directory

Again, the USB root hubs are a different type of device, you can't
compare the two, sorry.

> HAL uses libsysfs, which parses the contents of the various bus/ 
> directories to determine the appropriate bus for the given subdevices 
> beneath each device.  It assumes that for each valid device directory 
> directory in the /sys/devices/ tree, there is an entry in one of the bus 
> directories.
> 
> Since the I2C-n directories don't appear in any of the bus directories, 
> libsysfs can only print "unknown" bus for them and they can't be 
> appropriately placed within the HAL tree.

But i2c adapters _are not_ on the i2c bus.  They are the "bridge device"
between say the PCI bus and the i2c bus.  They are really just a PCI
device, and so that's where they are in the tree.

> I had assumed that since the I2C adapters are similar in function to the 
> usb_host devices, they should appear in the same place.

Nope, apples and oranges.

> If this is not the case, should the usb hosts be under the PCI bus tree 
> as well?  In that case, should the I2C adapters be there too?

USB hosts do show up in /sys/class/usb_hosts/ just like the i2c adapters
do :)

Hope this helps,

greg k-h
