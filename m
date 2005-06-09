From: hinko.kocevar@cetrtapot.si (Hinko Kocevar)
Date: Thu, 09 Jun 2005 12:40:18 +0000
Subject: [lm-sensors] Re: [RFC] SPI core
Message-Id: <42A81C56.1070602@cetrtapot.si>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com> <20050602040655.GE4906@jupiter.solarsys.private> <20050602045145.GA7838@kroah.com> <1117717356.5794.9.camel@localhost.localdomain> <20050609071523.GE22729@kroah.com>
In-Reply-To: <20050609071523.GE22729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Rui Sousa <rui.sousa@laposte.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

Greg KH wrote:

> 
> The fact that the i2c drivers are not really true "drivers" in the
> driver model.  We bind them by hand to the device and then register the
> device with the core.  That isn't a nice thing to do...

And introduces alot of code do simple stuff that SPI is supposed to do. I also 
ported i2c-core,i2c-dev, i2c-bit-algo and parport bus to work with SPI device. 
Resulting SPI code base was huge and I was confused in the begining why, and 
later wondered if there is need for such a design.

I dumped evrything and created three functions : spi_access, spi_transfer and 
spi_release. First and last functions only assert/deassert CS line, 
respectevely. Spi_transfer is the core function and is more-or-less different 
on every CPU (if not using bit-banging). As every CPU has different approach in 
handling SPI interface is almost neccesary to write CPU dependent SPI part for 
each CPU out there (at least transfer function). Also you can use CPUs 
synchronous serial interface (if one supports it) or just use bit-bang algo to 
get bits in and out.

I have two devices on SPI and I drive them both by bit-banging bits in and out. 
While I was using I2C-like-SPI model I wanted to make it base for all other SPI 
devices my board would/could hold. Sad thing is that every manufacturer and/or 
device (let it be serial flash, audio codec, A/D converter, ...) has its own 
concept of accessing and transfering data to and from the SPI device. I 
experienced this a short while ago while trying to make tsc2301 audio codec and 
datakey spi serial flash to use common SPI code. I ended up duplicating the 
three aforementioned functions in the each driver and still SPI code is ~10-15 
times smaller than initial I2C-to-SPI port I did.

I would also like to see SPI core in linux driver model, but nothing like I2C 
stuff. SPI is far to simple (and yet so diverse) that much more simple concept 
could be used.

just my .2 ?

regards,
hinko k

-- 
..because under Linux "if something is possible in principle,
then it is already implemented or somebody is working on it".

					--LKI
