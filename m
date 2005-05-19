From: michael.hufer@freenet.de (Michael Hufer)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <200309241918.10547.michael.hufer@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 23 September 2003 23:22, Jean Delvare wrote:
> > First, I added a new mod parameter "reset_it87" which controls whether
> Mmm, looks good, except one part in init_client_it87. Not only the
> reset_it parameter prevents the reset, but it also disables all default
> settings - so it acts like the "init=0" parameter some of our drivers
> have. I think that only the reset command (writing 0x80 in register
> 0x00) is evil. The rest of the init isn't dangerous (also it has also
> been discussed wether it should be done or not).
Actually, the 'reset_it87' parameter did only disable the chip reset in an 
early version. But it turned out that some of the init settings also affected 
something of the BIOS's pwm setup. I then extended the scope of the if(reset) 
to all/most of the initialization code. I never investigated exactly which 
register(-value) was responsible, thought. But of course, you are right the 
way it is currently used it should be renamed to 'init', 

> [...] Also, did you checked
> your fan3_div code? Looks buggy.

It might look like that, but its doing exactly what I wanted it to do. ;-)
The reason: 
While the tech docu of the it87xx chips says that the fan divisor 3 is fixed 
to 2, it seems that the CPU fan connected as fan3 needs a 8 as divider to 
report the correct speed as reported by the BIOS Setup and MBM on my Windows 
dual install. The BIOS obviously should know how to calculate the fan speed 
from the register value, I don't know how MBM gets the same value, thought. 
When I use the default divisor of 2 on the register value I get the 
unreasonable high fan speed of ~8000rpm when it is running in low speed mode 
and >~140000rpm on full speed!
Thus, I made this divisor changeable, too. There might be a better, cleaner 
way to do this, thought. Suggestions are welcome.

> Your patch looks overall great and I'm willing to apply it after the
> points above are fixed and the questions below are discussed.
>
> 1* Should the reset command be kept at all? I really believe it should
> go away. The chip is obviously initialized with correct values by the
> BIOS, so the reset is unnecessary at least, and can break thinks
> (experience showed it did). If we decide to keep it in the code, I'd at
> least expect it not to be the default.

It could be made default not to reset the chip but as there might be a 
BIOS/motherboard out there that does not correctly initialize the chip, there 
should be a way to reset the chip on module load.

Cheers,
	Micha.
