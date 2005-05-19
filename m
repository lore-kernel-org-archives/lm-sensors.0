From: louis-martin.cote@verint.com (cote, louis-martin)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Possible bug in i2c_register_entry ?
Message-Id: <6C25030C55C5D84FBEFD632E966730653109A3@mtlmail1.Co.Corp.VerintSystems.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
In-Reply-To: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> As strange as it may sound if you consider the age of the code, I
> believe that you are right and we should rely on ctl_name instead of
> procname. It has gone unnoticed so far most probably because all
> hardware monitoring device drivers export all their sysctl entries to
> procfs.
> 
> I will fix that in CVS, and send a similar fix to Marcelo Tosatti for
> Linux 2.4, although I'm not sure he will accept it. The fix doesn't
> apply to 2.6 since we are using sysfs instead of procfs now.
> 
> BTW, for which device are you writing a driver?

Bonjour Jean,

Je suis tent? de vous r?pondre en fran?ais, mais je r?siste, for other people's sake !

I'm writing a device driver for a Philips PCA9555 chip, which is a 16-bit I/O port with interrupt I2C device.

Since our project in for an embedded system, the driver itself it tightly bound to the way the chip is integrated into our hardware.
I doubt it is of any interest for anyone outside, considering it relies on a homebrewed CPLD for interrupt management.

However, before doing that, I "backported" the LM77 driver found in Linux 2.6 to Linux 2.4.
If you are interested in getting it, I will be glad to provide it. Just tell me where to submit it, and maybe give me 1 hour to remove customizations I made for supporting our embedded platform (like interrupts)! The basic functionality (temp read/write) should run fine on any host hardware (PC / Mac / whatever).

Thanks for getting back to me.
Merci !


Louis-Martin



