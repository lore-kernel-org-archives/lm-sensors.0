From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] lm-sensors newb needs help
Message-Id: <Q1nnFZHu.1116408532.5621530.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1116388677.22757.6.camel@wlt.obsidian-studios.com>
In-Reply-To: <1116388677.22757.6.camel@wlt.obsidian-studios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi William,

> Now I can see a winbond chip on the board, but got nothing when I
> compiled in support for it. Through trial and error I finally have the
> following showing up in dmesg.

Which Winbond chip? Not all of these are hardware monitoring chips,
Winbond produces many many different chips.

> i2c-sis96x version 1.0.0
> sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
> it87: Found IT8705F chip at 0x290, revision 3

That IT8705F chip, made by ITE, would be your hardware monitoring device.

> However when I do I get
>
> root # sensors
> No sensors found!

I suspect that you did not load or compile in the i2c-isa driver, which
you need in combination with the it87 driver.

> root # sensors-detect
> Can't access /proc/modules! at /usr/sbin/sensors-detect line 1837.

This is an old bug affecting monolithic kernels, which was fixed in
lm_sensors 2.8.8. You may want to upgrade, or hack the script by
yourself (just remove the bogus check).

> root # i2cdetect -l
> i2c-0   unknown         SiS96x SMBus adapter at 0x0c00
>                         Algorithm unavailable

You should see the ISA pseudo-adapter as well (from the i2c-isa driver
mentioned above). If you get this one, I'd expect the IT8705F chip to
show the hardware monitoring data you are after.

You'll find the i2c-isa driver under Device Drivers > I2C support > I2C
Hardware Bus support when configuring your kernel, it's named "ISA Bus
support". Just make sure you have it enabled.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
