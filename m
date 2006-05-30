From: laurent.pinchart@tbox.biz (Laurent Pinchart)
Date: Tue, 30 May 2006 08:55:31 +0000
Subject: [lm-sensors] How to control GPIOs I2C chips from a separate
Message-Id: <200605301055.31721.laurent.pinchart@tbox.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605231229.55405.laurent.pinchart@tbox.biz>
In-Reply-To: <200605231229.55405.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > > I'm developping the DSL chipset driver, and the needed arises to
> > > control the GPIO lines from inside the driver. I've had a look at some
> > > PCI drivers which need to control I2C devices, and all of them have the
> > > I2C chips connected to an I2C bus controlled by the PCI device. Getting
> > > a reference to those chips is thus quite easy. I'm a bit puzzled
> > > regarding how to do the same for my design. Could anyone advice me on
> > > how to get a reference to the PCA9557 from the DSL platform driver in a
> > > clean way ?
> >
> > Well this is a bit problem. There are three ways:
> >
> > 1) create EXPORT_SYMBOL(my_api) with defined API and call it from your
> > PCI device to the PCA driver some RTC drivers did this
> >
> > 2) there is,  now obsoleted, method with the i2c command callback. This
> > may be removed in the future.
> >
> > 3) create a class interface for this stuff and register the device in the
> > class I'm taking this aproach to create an watchdog class even for i2c
> > devices...
>
> 4) Have a single driver for both the DSL chipset and the
> GPIO-controlling chip. Given that the GPIO pins usage is specific to
> your system, reusability isn't an issue. You may make a composite
> module to keep a clean limit between both parts of the driver. It's
> mostly similar to option 1), except that you don't even have to define
> and API and export the symbols.

Good idea, but the GPIO chip is also used for other totally unrelated 
functions, so I think a GPIO class would make more sense.

Laurent Pinchart

