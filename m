From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Feb 2013 09:21:26 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130206102126.6b392a69@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Feb 2013 09:11:05 +0100 (CET), Dag Wieers wrote:
> On Wed, 6 Feb 2013, Jean Delvare wrote:
> 
> > On Wed, 6 Feb 2013 00:26:06 +0100 (CET), Dag Wieers wrote:
> >
> >> I noticed on my second AppleTV device that it has a second address that
> >> replied:
> >>
> >> root ~ # i2cdetect 0
> >> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> >> I will probe file /dev/i2c-0.
> >> I will probe address range 0x03-0x77.
> >> Continue? [Y/n]
> >>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> >> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> >> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> >> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> >> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> >> 40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
> >> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> >> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
> >> 70: -- -- -- -- -- -- -- --
> >>
> >> The differences between both devices is that this one has the original
> >> wireless device (b43) instead of the crystalhd mini-pci, and it doesn't
> >> have the DVB USB stick inserted.
> >>
> >> What could 48 be ?
> >
> > This address was commonly used for simple temperature sensors (e.g.
> > LM75) but these are no longer so frequent. This could be virtually
> > anything. If you are willing to take the risk, you can provide a byte
> > dump of the chip with:
> > # i2cdump 0 0x48 b
> > at which point I can tell you if this is a device I recognize (a.k.a.
> > human version of sensors-detect.)
> 
> What risk am I taking wrt. probability and damage ? :)

There is no standard on which I2C/SMBus transactions a slave must
support not how it interprets them. "Read byte" transactions send a
register offset to the slave and the slave is expected to reply with
the 8-bit register value. 95% of the I2C/SMBus slaves understand that
and will to what you expect, however a few of them will not. Amongst
the one which won't, are a few which will treat the register offset as
an actual write. And do whatever they are supposed to do when you write
to them. We have has (thankfully rare) reports of dead hardware as a
result of poking at unknown I2C slaves.

The risk is relatively low, but it exists. If you want to make it as
low as possible, you can start with:

# i2cget 0 0x48

This will read the presumed internal pointer value from the chip. Write
down the value for future use. I'll call in $v below. Then try a single
register read:

# i2cget 0 0x48 $v

If it returns $v again, and $v is neither 0x00 nor 0xff, you better
leave the chip alone, and cold boot the machine (just in case.) In
other cases, the chip seem to behave normally and you can go with:

# i2cdump 0 0x48 b

> And what could be the reason for the difference in behaviour of both 
> devices ? Could it be BIOS, firmware, ACPI, kernel, or is this pure 
> hardware-related ?

It can be a lot of things. It can be that one machine has an extra chip
and the other doesn't. Or the chip can be present on both, but hidden
behind a multiplexer, and that multiplexer has a different default
setting on the machines. Or both machines have a compatible chip but
not exactly the same one, and one replies to SMBus quick commands (used
by i2cdetect) and the other one does not. And there are certainly more
possible reasons I can't think of right now.

> PS I now added dmidecode to the OpenELEC build system in order to find 
> other differences between both devices.

Good idea.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
