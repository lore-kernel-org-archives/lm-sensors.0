From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Mon, 19 Mar 2007 14:20:46 +0000
Subject: [lm-sensors] [PATCH 1/3] lm78: No longer use i2c-isa
Message-Id: <45FE9C3E.8070502@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070319133231.b2a2a2a0.khali@linux-fr.org>
In-Reply-To: <20070319133231.b2a2a2a0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> 
> Contrary to the LM78 / W83781D, which were dedicated hardware
> monitoring chips, the PC8374L is a Super-I/O, so it is very unlikely to
> be ever found on a daughter board (while for example the W83781D was
> used on graphics adapters). So it is rather unlikely that the ISA
> (actually LPC) access will not be available. If I were you, I'd write
> an ISA/LPC-only driver to start with, and only think of adding I2C
> support later if really needed.

Well unfortunately the person who brought PC8374L support up on the list and
who is willing todo the testing for me has an intel motherboard and intel loves
smbus, iow the hwmon logical device is disabled through the superio config
registers, this doesn't actually disable the device, but does disable isa
access, so I need to go i2c there, now I could force the logical device to on
(assuming the config isn't locked by the bios) but that might interfere with
any ACPI / other bios code accessing it (which doesn't seem to be the case but
could be) and would require assigning ioports to it. To make things even more
interesting the chip can be configured for memorymapped access too, now mmap
access would be ideal, but as said I don't like the idea of changing the
superio config. Thus the plan is to write a driver with supports all 3, and
decides which one to use based on the superio config. This is actually easier
then it sounds, because the only code that needs to take this into account is
the probe code and the writebyte / readbyte functions.

I'm also thinking about adding a force ioport / mmap io options, so that those
modes can be actually tested.

Any input/advice on this is much appreciated.

> BTW, the lm78 and w83781d drivers cannot safely disable the I2C access
> support when a device is found on the ISA bus. Think of the case where
> I plug a graphics adapter with a W83781D chip in a motherboard which
> itself has a W83781D chip.
> 

Ah I see.

Regards,

Hans



