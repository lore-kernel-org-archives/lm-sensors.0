From: matt@aclaro.com (Matthew Mastracci)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Patch for I2C + sysfs
Message-Id: <3FFF3F9C.1060100@aclaro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109231724.GC4693@kroah.com>
In-Reply-To: <20040109231724.GC4693@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:

Thanks for the response, Greg.  I've CC'd David Zeuthen of HAL on this 
one, perhaps to provide more input.

>>This patch ensures that I2C adapter devices show up under the
>>/sys/bus/i2c directory.  Without, only I2C devices themselves will show
>>up, breaking HAL.  
> 
> 
> Ccing the sensors list, as I should have pointed you to that in the
> first place, sorry.
> 
> 
>>--- drivers/i2c/i2c-core.c~     2004-01-08 20:47:05.000000000 -0700
>>+++ drivers/i2c/i2c-core.c      2004-01-08 20:47:22.000000000 -0700
>>@@ -143,6 +143,7 @@
>>        sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
>>        adap->dev.driver = &i2c_adapter_driver;
>>        adap->dev.release = &i2c_adapter_dev_release;
>>+       adap->dev.bus = &i2c_bus_type;
>>        device_register(&adap->dev);
>>        device_create_file(&adap->dev, &dev_attr_name);
> 
> 
> But adapters are not on the i2c bus.  They are the "root" of the i2c
> bus.  I2C adapters live as devices on other busses (PCI, platform, etc.)

I'm modelling this after the usb sysfs entry.  The usb adapters 
themselves appear in /sys/bus/usb/devices:

[ truncated ls -l ]
lrwxrwxrwx    1 root     root           53 Jan  8 20:33 3-0:1.0 -> 
./../../devices/pci0000:00/0000:00:02.1/usb3/3-0:1.0
lrwxrwxrwx    1 root     root           45 Jan  8 20:33 usb1 -> 
./../../devices/pci0000:00/0000:00:02.2/usb1
lrwxrwxrwx    1 root     root           45 Jan  8 20:33 usb2 -> 
./../../devices/pci0000:00/0000:00:02.0/usb2
lrwxrwxrwx    1 root     root           45 Jan  8 20:33 usb3 -> 
./../../devices/pci0000:00/0000:00:02.1/usb3
[matthew@matt devices]$ cat usb1/product
EHCI Host Controller

> 
> What exactly is the problem that HAL can't see the devices in the place
> where they are in the sysfs tree?

Without this patch, the device only appears in two places:

   * under the class directory with class "i2c-adapter", and
   * under the root devices tree in its respective pci path.

If you contrast this with the usb controllers, they appear in three places:

    * under the class directory with class "usb_host",
    * under the root devices tree in its repective pci path, and
    * under the /sys/bus/usb directory

HAL uses libsysfs, which parses the contents of the various bus/ 
directories to determine the appropriate bus for the given subdevices 
beneath each device.  It assumes that for each valid device directory 
directory in the /sys/devices/ tree, there is an entry in one of the bus 
directories.

Since the I2C-n directories don't appear in any of the bus directories, 
libsysfs can only print "unknown" bus for them and they can't be 
appropriately placed within the HAL tree.

I had assumed that since the I2C adapters are similar in function to the 
usb_host devices, they should appear in the same place.

If this is not the case, should the usb hosts be under the PCI bus tree 
as well?  In that case, should the I2C adapters be there too?

> 
> thanks,
> 
> greg k-h
> 

No prob.  Thanks for the feedback!

Matt.
