From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 19 Apr 2006 10:47:46 +0000
Subject: [lm-sensors] Black box flight recorder for Linux
Message-Id: <m364l5dep9.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>
	<m3odz9kze6.fsf@defiant.localdomain>
In-Reply-To: <m3odz9kze6.fsf@defiant.localdomain> (Krzysztof Halasa's message of "Mon, 10 Apr 2006 21:24:01 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lkml <linux-kernel@vger.kernel.org>, Andy Green <andy@warmcat.com>
Cc: lm-sensors@lm-sensors.org

Hi,

(Cc to lm-sensors list).

> Yes, that could be used, too. It would be a bit more complicated as
> different VGA cards use different access methods (i.e., different
> I/O port and bit numbers). X11 drivers probably know how to drive it.

BTW: I just soldered a 24C64 I^2C EEPROM (the largest I could find
at home but 24C512 (64 KB) and even 24C1024 (128 KB) are available
on the market) to a connector and connected it to SMBus on my Asus
A7V333 mobo. I don't have code to write "printk" messages to it yet
but will look at it sometime.

Interesting: i2cdetect and friends can only find a custom Asus sensors
chip on this bus (ASB100 chip at addresses 0x2D, 0x48 and 0x49) - and
now my 24C64 at 0x57 (config address 7 = all ones). But the BIOS POST
searches and finds more devices: there is something at 0x2F, 0x69, and
there are (I think) DDR SDRAM EEPROMs and 0x51 and 0x52 (0x50 is an
empty DIMM slot). Got this info with my "DIY" logic analyzer. I think
the BIOS POST disconnects somehow the devices before loading the OS
(in order to prevent data damage?).

No wonder my first attempt with 24C16 which occupies all 0x50 - 0x57
addresses had to fail.

I think VGA monitors respond (at least?) at 0x50 address so
a 16-bit-addressable EEPROM (at least not larger than 24C2048 which
IMHO aren't yet available) with all-ones I^2C address selected
should do as well if connected to VGA/DVI I^2C/ACCESS.bus.
-- 
Krzysztof Halasa

