From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Mar 2007 14:02:07 +0000
Subject: [lm-sensors] [PATCH 1/3] lm78: No longer use i2c-isa
Message-Id: <20070319150207.95d2105b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070319133231.b2a2a2a0.khali@linux-fr.org>
In-Reply-To: <20070319133231.b2a2a2a0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 19 Mar 2007 13:44:38 +0100, Hans de Goede wrote:
> I see that you're using a platform here not a isa driver. There was mention of 
> maybe mentioning the isa driver structure/class in the future does this mean 
> that the plan is to keep using platfrom driver for isa sensor chips?

I have been considering an isa driver, but fell back to a platform
driver for two reasons:

1* libsensors would most probably need another update to support yet
another type of hardware monitoring driver. While this could be done,
it would delay my plan to kill i2c-isa by several months, which isn't
really acceptable.

2* isa drivers are only available on some architectures, as the driver
core code for them depends on CONFIG_ISA which cannot be selected on
some architectures. While I suppose that LM78 chips connected on the
ISA bus are only found on x86 systems, LM78 chips connected to the I2C
bus could be found on virtually any system. So, in order to use an isa
driver rather than a platform driver, I would first have had to either
clutter the driver with #ifdef-CONFIG_ISAs to let other architectures
use the I2C part of the driver, or split the driver in two or three
modules. Again, this was not impossible, but it would have taken more
time than I have available, and more time than I think is worth
spending on an otherwise very old driver.

So yes, I admit that going with a platform driver is the easy way and
not necessarily the best absolute technical solution. That being said,
I seem to understand that CONFIG_ISA=y means "the system has ISA slots",
which suggests that isa drivers should only be used for legacy ISA
daughter boards.

> I'm very interested in the work as the PC8374L chip for which I'm planning to 
> write a driver can be accessed through both isa and i2c too.
> 
> I notice that you always register the i2c driver in case of the lm78, for the 
> PC8374L I was thinking about only registering then i2c driver if ISA access is 
> disabled. ISA access can be disabled through the superio config registers, in 
> this case the i2c address can still be read from those superio config registers 
> and one can try to fallback to i2c access. What do you think is best?

Contrary to the LM78 / W83781D, which were dedicated hardware
monitoring chips, the PC8374L is a Super-I/O, so it is very unlikely to
be ever found on a daughter board (while for example the W83781D was
used on graphics adapters). So it is rather unlikely that the ISA
(actually LPC) access will not be available. If I were you, I'd write
an ISA/LPC-only driver to start with, and only think of adding I2C
support later if really needed. As a matter of fact, the Winbond
W83627HF and ITE IT8712F have their hardware monitoring features
exposed on both the LPC bus and the SMBus, and we ended up dropping
SMBus access support entirely from the it87 driver. Dropping support
for the W83627HF SMBus access is somewhere on my TODO list, too.

BTW, the lm78 and w83781d drivers cannot safely disable the I2C access
support when a device is found on the ISA bus. Think of the case where
I plug a graphics adapter with a W83781D chip in a motherboard which
itself has a W83781D chip.

-- 
Jean Delvare

