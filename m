From: laurent.pinchart@tbox.biz (Laurent Pinchart)
Date: Tue, 30 May 2006 08:53:52 +0000
Subject: [lm-sensors]
Message-Id: <200605301053.52371.laurent.pinchart@tbox.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> > I'm facing a small architecture problem on an embedded (MPC8248) design.
> > The processor has a hardware I2C bus for which a driver exists in the
> > Denx linuxppc kernel tree at rsync://www.denx.de/git/linux-2.6-denx (the
> > driver is called i2c-mpc8260, does anyone know if there are plans to
> > integrate it in mainline kernels ?).
>
> No we dont know.
>
> > Our hardware platform has a DSL daughterboard on which a PCA9557 GPIO I2C
> > chip is used to control several DSL functions (resetting chipsets,
> > connecting to the line, ...). The DSL and PCA9557 chipsets are thus both
> > part of a single "device", but are not connected to the same bus (the DSL
> > chipset is a platform device, while the PCA9557 is connected on the I2C
> > bus).
>
> Good.
>
> > I'm developping the DSL chipset driver, and the needed arises to control
> > the GPIO lines from inside the driver. I've had a look at some PCI
> > drivers which need to control I2C devices, and all of them have the I2C
> > chips connected to an I2C bus controlled by the PCI device. Getting a
> > reference to those chips is thus quite easy. I'm a bit puzzled regarding
> > how to do the same for my design. Could anyone advice me on how to get a
> > reference to the PCA9557 from the DSL platform driver in a clean way ?
>
> Well this is a bit problem. There are three ways:
>
> 1) create EXPORT_SYMBOL(my_api) with defined API and call it from your PCI
> device to the PCA driver some RTC drivers did this

That's not very clean, but would work.

> 2) there is,  now obsoleted, method with the i2c command callback. This may
> be removed in the future.

I'd rather not use obsoleted methods.

> 3) create a class interface for this stuff and register the device in the
> class I'm taking this aproach to create an watchdog class even for i2c
> devices...

I'll try that, as it seems to be the cleaner approach. I suppose I'm not the 
only one who is interested in a GPIO class.

> And because perhaps you will not want to have your driver integrated into
> kernel, and because it is a very special think you may use the #1 method
> without problems.

I'll go for #1 first as our deadlines are quite tight, and will try to 
implement #3 a bit later. Regarding integrating the driver into the mainline 
kernel, I unfortunately can't do that as the specs are covered by an NDA :-(

> Please note that if the PCA driver needs to be called 
> from interrupts then you will need some workqueues. See some other RTC
> drivers for inspiration. (pre 2.6.17 because I think 2.6.17 has already a
> RTC class)

Thanks.

Laurent Pinchart

