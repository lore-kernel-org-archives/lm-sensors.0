From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Mon, 12 Oct 2009 13:20:53 +0000
Subject: Re: [lm-sensors] gadgetfs program for hid/hwmon testing
Message-Id: <4AD32D35.50302@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>> If it would help I can post a gadgetfs userspace program I wrote to emulate
>>> the device.
>> Yes, please post it together with explanations how to use it. If I can
>> emulate the device and test my libsensors patches myself, this should
>> be much faster.
> 
> Okay, I'll tidy it up and get it ready.  In order to run it you will need the
> following options enabled in your kernel (I have them all as modules):
> 
> USB_GADGET (Device drivers, USB support, USB Gadget Support)
> USB_GADGET_DUMMY_HCD (USB Gadget Support, USB Peripheral Controller, Dummy HCD)
> USB_GADGETFS (USB Gadget Support, USB Gadget Drivers, Gadget Filesystem)

I forgot to mention you'll also need support for the LED class in your kernel
to load the driver (or you could comment out all the LED code.)

This is enabled in Device Drivers, LED Support, LED Class Support (LEDS_CLASS).

Once you've inserted the modules you'll need to mount gadgetfs:

$ mkdir /dev/gadget
$ mount -t gadgetfs gadgetfs /dev/gadget
$ ls /dev/gadget
-rw-------  1 root root    0 2009-10-04 21:16 dummy_udc

Download and compile the code:

$ wget http://www.shikadi.net/files/odin/odin.tar.bz2
$ tar jxvf odin.tar.bz2
$ cd odin/gadget
$ make
$ ./new_data.cmd       # Populate /tmp with data the device will report
$ ./odin_gadget

You should now have a new USB device on your system:

$ lsusb
Bus 008 Device 004: ID 1044:4001 Chu Yuen Enterprise Co., Ltd

Next, compile the driver:

$ cd odin/kernel
$ make
$ insmod gbt-odin.ko
(If you get an error make sure you've inserted all the modules, especially
led_class)

Since the device is a HID device, the USB HID driver will grab it so it must
be released and assigned to the new driver instead.  (Eventually a blacklist
update will take care of this automatically.)

$ DEV=`basename /sys/bus/hid/devices/*1044:4001*`
$ echo $DEV > /sys/bus/hid/drivers/generic-usb/unbind
$ echo $DEV > /sys/bus/hid/drivers/gbt-odin/bind
$ dmesg | tail

Hopefully you'll see some messages indicating the driver has attached to the
hardware successfully.  You should have a new hwmon device on your system now!

The code is still pretty rough - plus it's my first kernel driver - so it
still needs a bit of work.  Having said that it's been running in my kernel
for a few days with no crashes yet :-)

I hope it works, let me know how you go!

Cheers,
Adam.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
