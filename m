From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Feb 2010 17:56:53 +0000
Subject: Re: [lm-sensors] Super I/O chip: missing VID base address
Message-Id: <20100217185653.1f932577@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266428121.8626.73.camel@vierstein>
In-Reply-To: <1266428121.8626.73.camel@vierstein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Lutz,

On Wed, 17 Feb 2010 18:35:21 +0100, Lutz Ballaschke wrote:
> Hi there,
> 
> i have to program parts of the super I/O chip F71862 from Fintek on a
> Jetway J7F2 x86 mini-ITX board. There is an existing linux driver
> (f71882fg) which supports the hardware monitoring function of that chip
> (FAN, TEMP, PWM) but not the VID function. 

Correct. Looking at the datasheet, I am not surprised... The VID
controller has only 4 input pins, while all recent CPU models need 6, 7
of even 8. I have no idea why Fintek did this, but in practice this
makes the VID feature of the F71862 essentially useless.

> So i started coding to get this VID function working. Unfortunately i
> got disappointed the moment i tried to read the base address out of the
> VID configuration register: the value is 
> 
> 0x00 
> 
> which i suppose is not the actual IO address, is it? Confused by the
> datasheet telling the same i wondered if that means i can't use VID
> function or just have to find out the default base address (like 0x3F8
> is default for UART which is also part of the F71862 chip)
> Any idea?

The base I/O of each logical device must be set by the BIOS prior to
use. Some logical devices may have a default value but the VID one does
not. If the BIOS did not set any address, you have to do it before
enabling the logical device (setting bit 0 of register 0x30 to 1.) You
are free to set the address to whatever you want, but I would suggest
picking a multiple of at least 16, and making sure you won't hit
already used ports (check in /proc/ioports.)

Then again, I am not sure how the VID feature of this chip would be
used on a recent system.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
