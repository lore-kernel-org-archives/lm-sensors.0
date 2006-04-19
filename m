From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Apr 2006 20:20:51 +0000
Subject: [lm-sensors] Black box flight recorder for Linux
Message-Id: <44469BA3.2090309@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44379AB8.6050808@superbug.co.uk>	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>	<m3odz9kze6.fsf@defiant.localdomain> <m364l5dep9.fsf@defiant.localdomain>
In-Reply-To: <m364l5dep9.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Green <andy@warmcat.com>, lm-sensors@lm-sensors.org

Hello,
> 
> Interesting: i2cdetect and friends can only find a custom Asus sensors
> chip on this bus (ASB100 chip at addresses 0x2D, 0x48 and 0x49) - and
> now my 24C64 at 0x57 (config address 7 = all ones). But the BIOS POST
> searches and finds more devices: there is something at 0x2F, 0x69, and
> there are (I think) DDR SDRAM EEPROMs and 0x51 and 0x52 (0x50 is an
> empty DIMM slot). Got this info with my "DIY" logic analyzer. I think
> the BIOS POST disconnects somehow the devices before loading the OS
> (in order to prevent data damage?).

Well Asus likes to play hide and seek...

> No wonder my first attempt with 24C16 which occupies all 0x50 - 0x57
> addresses had to fail.

Hm that should work, because Asus most likely multiplexes physical lines
instead of devices (using 74HC4052 IIRC)

> I think VGA monitors respond (at least?) at 0x50 address so
> a 16-bit-addressable EEPROM (at least not larger than 24C2048 which
> IMHO aren't yet available) with all-ones I^2C address selected
> should do as well if connected to VGA/DVI I^2C/ACCESS.bus.

What about to connect the device to parallel port, there are some adapter
schematics in kernel docs.

Simplest one needs just one 7405 two diodes and four resistors.

There is also a i2c-pport driver that may work without additional parts, just 3
pins of parport are used. Please note that you should set the parport to SPP
mode and not load any linux drivers. The driver is for 2.4. No 2.6 but I have
used it so you may find it on http://assembler.cz

Regards
Rudolf

