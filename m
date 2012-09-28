From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 28 Sep 2012 01:35:59 +0000
Subject: Re: [lm-sensors] How to use SC18IS602 driver ?
Message-Id: <20120928013559.GA14405@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 27, 2012 at 07:40:14PM -0500, Bruce Parker wrote:
> ok...see below

Adding mailing list back in. Please don't drop it, and please don't top-post.

> # ls /sys/class/i2c-adapter/i2c-0
> 0-0020         0-0025         0-004c         0-0054         i2c-dev
> 0-0021         0-0026         0-0050         0-0055         name
> 0-0022         0-0027         0-0051         0-0056         new_device
> 0-0023         0-0028         0-0052         delete_device  subsystem
> 0-0024         0-0037         0-0053         device         uevent
> # ls /sys/class/i2c-adapter/i2c-0/0-0028
> driver      modalias    name        spi_master  subsystem   uevent
> # ls /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/
> spi0
> # ls /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/spi0
> device     spi0.0     subsystem  uevent
> # ls /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/spi0/spi0.0
> modalias   subsystem  uevent
> #
> 
> I guess I don't understand when the /dev/mtd* device is supposed to be created?
> 
Given the above, you must have either a device tree based configuration or a
platform initialization file. In there you would specify the parameters of the
SPI EEPROM. Assuming it is a Jedec compliant eeprom, that would in turn
instantiate the mtd devices. If you use device tree, I think you would specify
partition sizes in it as well.

Guenter

> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Thu 9/27/2012 7:10 PM
> To: Bruce Parker
> Subject: Re: How to use SC18IS602 driver ?
>  
> On Thu, Sep 27, 2012 at 05:56:02PM -0500, Bruce Parker wrote:
> > I'm logged in as root, but doesn't look like "sudo" or "i2cdetect" are
> > on my filesystem. Guess I need to get it added to ramdisk?
> > 
> Try "ls /sys/class/i2c-adapter/i2c-0"
> 
> Guenter
> 
> > Bruce...
> > 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net] 
> > Sent: Thursday, September 27, 2012 5:48 PM
> > To: Bruce Parker
> > Subject: Re: How to use SC18IS602 driver ?
> > 
> > On Thu, Sep 27, 2012 at 04:50:53PM -0500, Bruce Parker wrote:
> > > Message at bottom of email...
> > >  
> > > > -----Original Message-----
> > > > From: Guenter Roeck [mailto:linux@roeck-us.net] 
> > > > Sent: Tuesday, August 28, 2012 6:38 PM
> > > > To: Bruce Parker
> > > > Subject: Re: How to use SC18IS602 driver ?
> > > > 
> > > > On Tue, Aug 28, 2012 at 06:34:03PM -0500, Bruce Parker wrote:
> > > > >  [snip]
> > > > > >
> > > > > > With these entries, I can successfully boot Linux and see that
> > an
> > > > > entry
> > > > > > has been created at:
> > > > > > /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/spi0/spi0.0
> > > > > >
> > > > > Do you also see it at /sys/class/spi_master/spi0/spi0.0 ?
> > > > > 
> > > > > Yes
> > > > > 
> > > > > > In the past I have accessed eeproms by just having them in the
> > > > device
> > > > > > tree, then doing open(/sys/bus/i2c/devices/0-005x/eeprom) to get
> > > > file
> > > > > > descriptor. Then using file descriptor to do
> > > read()/write()...pretty
> > > > > > straight forward. Of course those eeproms were hanging directly
> > on
> > > > the
> > > > > > I2C bus.
> > > > > 
> > > > > Yes, this is how it works with I2C EEPROMs, or with AT25
> > conpatible
> > > > SPI
> > > > > EEPROMs.
> > > > > m25p80 works differently; it creates an mfd device.
> > > > > 
> > > > > Do you see any output with dmesg ? You should either see something
> > > > like
> > > > >         m25p80 spi0.0: s25sl064a (xxx Kbytes)
> > > > > or
> > > > >         m25p80 spi0.0: unrecognized JEDEC id ffffff
> > > > > 
> > > > > In the latter case, try again with mode 3 instead of mode 0.
> > > > > 
> > > > > No, but I don't have the hardware with the bridge and m25p80 on it
> > > > yet.
> > > > > Does that matter?
> > > > 
> > > > Ok, then I guess you'll have to wait for the hardware. The /dev/mtd
> > > > entries will
> > > > only be created if the hardware is actually there.
> > > > 
> > > > Guenter
> > > Hi again Guenter,
> > > I have my hardware now, but it does not appear to be discovered by the
> > > kernel at boot time. Using an I2C bus monitor, I do not see any
> > accesses
> > > to the I2C bridge during boot. The device is definitely in the device
> > > tree because the /sys/class/spi_master/spi0/spi0.0 file is being
> > > created. Should I see the kernel probing for the Bridge during boot
> > > time? Is there some specific kernel configuration I need to ask my
> > > kernel guy to enable?
> > > 
> > The driver is not an auto-detect driver, so you would not see any i2c
> > activity
> > unless you try to access a SPI device.
> > 
> > What do you see if you run "sudo i2cdetect 0" ?
> > 
> > Guenter
> > 
> > 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
