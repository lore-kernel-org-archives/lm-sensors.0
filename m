From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: status of i2c in 2.5.70 kernel
Message-Id: <20030609161657.GB6635@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030609114202.19c1002e.b.stolk@chello.nl>
In-Reply-To: <20030609114202.19c1002e.b.stolk@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 09, 2003 at 11:42:02AM +0200, Bram Stolk wrote:
> First: I'm not using your lm-sensor/i2c package, but I am
> using the i2c stuff from a stock 2.5.70 kernel.

Good, glad to hear it.

> The stock 2.5.70 kernel does not seem to support PROC_FS for
> i2c any more. It used to be in i2c-core.c, but now it has been
> removed.

That is because the /sys interface is now how to talk to i2c devices,
not /proc.

> Browsing your CVS, I saw that your package includes a 
> i2c-proc.c

Out of date, do not use.

> Has the new proc interface been offered for inclusion
> with future 2.5 kernels yet?

Heh, you mean the "old" interface :)
No, it is not in 2.5, and will not be.

> Also, there seems to be a duality: sysfs vs procfs.
> When I mount sysfs, I get a /sys/bus/i2c dir, which contains
> dirs only, and no files. However, I do have a working i2c
> adapter, as I can read /dev/i2c-0:
> Opening device...
> Done
> I2C_FUNC_SMBUS_BYTE
> i2c chip found at: 2d, val = 1
> i2c chip found at: 50, val = 0
> i2c chip found at: 69, val = 8
> When running on my via686 system, with support for
> CONFIG_I2C_VIAPRO=y
> CONFIG_SENSORS_VIA686A=y
> CONFIG_I2C_SENSOR=y
> CONFIG_I2C_CHARDEV=y
> 
> Shouldn't I get some entries in /sys/bus/i2c, or do I have to wait for
> a better i2c support in future 2.5 kernels?

You do not have _any_ files in /sys/bus/i2c?  i2c client devices show up
here, and you might not really have a via686a client device.  Are you
sure you do?  Does the 2.4 i2c drivers show up information for this
device?

i2c-dev lets you talk to the i2c adapter, not a specific i2c
device.  Look at /sys/class/i2c-dev/ to see what i2c adapter you are
actually talking to through /dev/i2c0.  Also look at
/sys/class/i2c-adapter for all of the i2c adapters in the system.

Hope this helps,

greg k-h
