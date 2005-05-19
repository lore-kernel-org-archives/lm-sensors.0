From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <20040816202528.2699426c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1092648290.12729.471.camel@uganda>
In-Reply-To: <1092648290.12729.471.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Although lm_sensors already has driver for it's fan, voltage and
> temperature sensors, it does not have driver for is's GPIO, which
> allows anyone to create i2c and w1 adapters over it.
> Design is simple as 5 pennies:
> 
> 	SuperIO main driver
> 		|
> +----+----+-----+-----+-----+---
> |    |    |     |     |     |
> 
> 	Logical devices space...
> 
> Where each logical device may be registered and deregistered to/from
> main driver. Theoretically master device may have some kind of ioctl
> or any other communication mechanism with userspace/kernelspace which
> will allow any kind of slave manipulations.
> 
> Since you have "monitoring" driver already, I've created one only for
> GPIO.
> 
> Since I do not know where it should live(at my private trees it lives
> in drivers/w1/) I post here files itself.
> 
> Anyone using GNU/Arch may access it through public mirror at:
> http://tservice.net.ru/~s0mbre/2004/ branch "soekris--main--0".
> 
> Please review and comment.

I haven't read the code (yet), just a few random comments on the general
design:

1* The final driver definitely should be placed in a "common" location.
It isn't i2c- nor w1-specific. It would be in drivers/isa but this one
doesn't seem to exist... Maybe Greg will have a suggestion when he comes
back from vacations.

2* If such a design is in place as I port the pc87360 driver to Linux
2.6, I'll of course use it. Note that this driver supports not only the
PC87366 but also the PC87360, PC87363, PC87364 and PC87365 (although
these are less frequently found, it seems) so your driver would have to
support them all as well.

3* The Super-I/O mechanics are not PC8736x-specific. It is a standard
(established by Intel some years ago) used by all Super-I/O chips,
including those made by National Semiconductor, ITE, Winbond, SMSC and
VIA. This means that your driver should most likely be completely
generic, and probably doesn't even need to know of any chip ID. It
could, OTOH, export an ID test function (although I guess it wouldn't be
any different from the register read function with register set to
0x20).

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
