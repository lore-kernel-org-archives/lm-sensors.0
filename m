From: "Bruce Parker" <BruceP@tanisys.com>
Date: Mon, 01 Oct 2012 14:03:15 +0000
Subject: Re: [lm-sensors] How to use SC18IS602 driver ?
Message-Id: <16691A8B34B5D9458EA3A1C37A11555A01B20426@tanisys-ex2.Tanisys.Local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120928013559.GA14405@roeck-us.net>
In-Reply-To: <20120928013559.GA14405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
> Adding mailing list back in. Please don't drop it, and please 
> don't top-post.
> 
> > # ls /sys/class/i2c-adapter/i2c-0
> > 0-0020         0-0025         0-004c         0-0054         i2c-dev
> > 0-0021         0-0026         0-0050         0-0055         name
> > 0-0022         0-0027         0-0051         0-0056         
> new_device
> > 0-0023         0-0028         0-0052         delete_device  
> subsystem
> > 0-0024         0-0037         0-0053         device         uevent
> > # ls /sys/class/i2c-adapter/i2c-0/0-0028
> > driver      modalias    name        spi_master  subsystem   uevent
> > # ls /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/
> > spi0
> > # ls /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/spi0
> > device     spi0.0     subsystem  uevent
> > # ls /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/spi0/spi0.0
> > modalias   subsystem  uevent
> > #
> > 
> > I guess I don't understand when the /dev/mtd* device is 
> supposed to be created?
> > 
> Given the above, you must have either a device tree based 
> configuration or a
> platform initialization file. In there you would specify the 
> parameters of the
> SPI EEPROM. Assuming it is a Jedec compliant eeprom, that 
> would in turn
> instantiate the mtd devices. If you use device tree, I think 
> you would specify
> partition sizes in it as well.
> 
> Guenter
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > Sent: Thu 9/27/2012 7:10 PM
> > To: Bruce Parker
> > Subject: Re: How to use SC18IS602 driver ?
> >  
> > On Thu, Sep 27, 2012 at 05:56:02PM -0500, Bruce Parker wrote:
> > > I'm logged in as root, but doesn't look like "sudo" or 
> "i2cdetect" are
> > > on my filesystem. Guess I need to get it added to ramdisk?
> > > 
> > Try "ls /sys/class/i2c-adapter/i2c-0"
> > 
> > Guenter
> > 
> > > Bruce...
> > > 
> > > -----Original Message-----
> > > From: Guenter Roeck [mailto:linux@roeck-us.net] 
> > > Sent: Thursday, September 27, 2012 5:48 PM
> > > To: Bruce Parker
> > > Subject: Re: How to use SC18IS602 driver ?
> > > 
> > > On Thu, Sep 27, 2012 at 04:50:53PM -0500, Bruce Parker wrote:
> > > > Message at bottom of email...
> > > >  
> > > > > -----Original Message-----
> > > > > From: Guenter Roeck [mailto:linux@roeck-us.net] 
> > > > > Sent: Tuesday, August 28, 2012 6:38 PM
> > > > > To: Bruce Parker
> > > > > Subject: Re: How to use SC18IS602 driver ?
> > > > > 
> > > > > On Tue, Aug 28, 2012 at 06:34:03PM -0500, Bruce Parker wrote:
> > > > > >  [snip]
> > > > > > >
> > > > > > > With these entries, I can successfully boot Linux 
> and see that
> > > an
> > > > > > entry
> > > > > > > has been created at:
> > > > > > > /sys/class/i2c-adapter/i2c-0/0-0028/spi_master/spi0/spi0.0
> > > > > > >
> > > > > > Do you also see it at /sys/class/spi_master/spi0/spi0.0 ?
> > > > > > 
> > > > > > Yes
> > > > > > 
> > > > > > > In the past I have accessed eeproms by just 
> having them in the
> > > > > device
> > > > > > > tree, then doing 
> open(/sys/bus/i2c/devices/0-005x/eeprom) to get
> > > > > file
> > > > > > > descriptor. Then using file descriptor to do
> > > > read()/write()...pretty
> > > > > > > straight forward. Of course those eeproms were 
> hanging directly
> > > on
> > > > > the
> > > > > > > I2C bus.
> > > > > > 
> > > > > > Yes, this is how it works with I2C EEPROMs, or with AT25
> > > conpatible
> > > > > SPI
> > > > > > EEPROMs.
> > > > > > m25p80 works differently; it creates an mfd device.
> > > > > > 
> > > > > > Do you see any output with dmesg ? You should 
> either see something
> > > > > like
> > > > > >         m25p80 spi0.0: s25sl064a (xxx Kbytes)
> > > > > > or
> > > > > >         m25p80 spi0.0: unrecognized JEDEC id ffffff
> > > > > > 
> > > > > > In the latter case, try again with mode 3 instead of mode 0.
> > > > > > 
> > > > > > No, but I don't have the hardware with the bridge 
> and m25p80 on it
> > > > > yet.
> > > > > > Does that matter?
> > > > > 
> > > > > Ok, then I guess you'll have to wait for the 
> hardware. The /dev/mtd
> > > > > entries will
> > > > > only be created if the hardware is actually there.
> > > > > 
> > > > > Guenter
> > > > Hi again Guenter,
> > > > I have my hardware now, but it does not appear to be 
> discovered by the
> > > > kernel at boot time. Using an I2C bus monitor, I do not see any
> > > accesses
> > > > to the I2C bridge during boot. The device is definitely 
> in the device
> > > > tree because the /sys/class/spi_master/spi0/spi0.0 file is being
> > > > created. Should I see the kernel probing for the Bridge 
> during boot
> > > > time? Is there some specific kernel configuration I 
> need to ask my
> > > > kernel guy to enable?
> > > > 
> > > The driver is not an auto-detect driver, so you would not 
> see any i2c
> > > activity
> > > unless you try to access a SPI device.
> > > 
> > > What do you see if you run "sudo i2cdetect 0" ?
> > > 
> > > Guenter
> > > 
> > > 
> > 
> 

Ok...got i2cdetect installed and below is result:
# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: UU UU UU UU UU UU UU UU UU -- -- -- -- -- -- --
30: -- 31 -- -- -- -- -- UU -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- UU -- -- --
50: UU UU UU UU UU UU UU -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
I2C-SPI bridge is at addr 28, so it appears to be detected. 

Below is my entry in device tree, but I do not see anything special in
/dev/mtd*
                                spi: spi@28 {
                                        compatible = "nxp,sc18is602";
                                        #address-cells = <1>;
                                        #size-cells = <0>;
                                        reg = <0x28>;
                                        m25p80@0 {
                                                #address-cells = <1>;
                                                #size-cells = <1>;
                                                compatible "fsl,espi-flash";
                                                linux,modalias "m25p80";
                                                spi-max-frequency <25000000>;
                                                modal = "s25sl064a";
                                                reg = <0>;
                                                mode = <0>;

                                                partition@0 {
                                                    reg = <0x0
0x00080000>;
                                                    label = "Test
Image";
                                                    read-only;
                                                };
                                        };
                                };


# ls /dev/mtd*
/dev/mtd0        /dev/mtd6        /dev/mtdblock2   /dev/mtdr12
/dev/mtd1        /dev/mtd7        /dev/mtdblock3   /dev/mtdr13
/dev/mtd10       /dev/mtd8        /dev/mtdblock4   /dev/mtdr14
/dev/mtd11       /dev/mtd9        /dev/mtdblock5   /dev/mtdr15
/dev/mtd12       /dev/mtdblock0   /dev/mtdblock6   /dev/mtdr2
/dev/mtd13       /dev/mtdblock1   /dev/mtdblock7   /dev/mtdr3
/dev/mtd14       /dev/mtdblock10  /dev/mtdblock8   /dev/mtdr4
/dev/mtd15       /dev/mtdblock11  /dev/mtdblock9   /dev/mtdr5
/dev/mtd2        /dev/mtdblock12  /dev/mtdr0       /dev/mtdr6
/dev/mtd3        /dev/mtdblock13  /dev/mtdr1       /dev/mtdr7
/dev/mtd4        /dev/mtdblock14  /dev/mtdr10      /dev/mtdr8
/dev/mtd5        /dev/mtdblock15  /dev/mtdr11      /dev/mtdr9


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
