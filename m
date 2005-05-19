From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040210012143.GC3087@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 09, 2004 at 05:02:20PM -0800, Jon Smirl wrote:
> Maybe /sys/class/i2c-adapter shouldn't exist.

No.  It is necessary.  Why do you want to get rid of it?  What happens
if you don't load the i2c_dev module?  That isn't necessary to have a
working i2c system (in fact I hate the i2c_dev code for lots of
different reasons, it will probably go away in 2.7 for something
else...)

A i2c-adapter device is the i2c "bridge".  The i2c_dev device is just a
way to talk to a specific i2c-adapter directly from userspace.  There
is a handy symlink in the i2c_dev device's directory to point you to
where the i2c adapter that it is bound to is.  That's more info than 2.4
ever gave you.

> USB is using a different model to solve the same problem.

As the person who wrote both pieces of code, I am very aware of what the
USB and I2C driver model code does :)

> With USB the adapters are in /sys/bus/usb/devices as usb1, usb2, etc.

No, that is NOT the USB adapter!  That is the USB root hub.  You will
find the usb adapter in /sys/class/usb_host.  Hm, bet you missed that :)

So in short, that is a real usb device in /sys/bus/usb/devices/usb* 

Yeah, I use the same names in both places in the USB tree to try to keep
people from thinking I'm completely insane, but they are different
things as you can see by the device and driver links in the
/sys/class/usb_host/usb?/ directories.

> What about eliminating /sys/class/i2c-adapter and moving i2c-1, i2c-2,
> etc into ls /sys/bus/i2c/devices to match USB?

Want to reconsider this based on the above knowledge?  :)

thanks,

greg k-h
