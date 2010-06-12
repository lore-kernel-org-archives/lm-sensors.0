From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Jun 2010 09:37:15 +0000
Subject: Re: [lm-sensors] ITE IT8721F chipset support? [typo]
Message-Id: <20100612113715.3e36c0bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C134377.6090305@powercraft.nl>
In-Reply-To: <4C134377.6090305@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jelle,

On Sat, 12 Jun 2010 10:21:11 +0200, Jelle de Jong wrote:
> Hello everybody,
> 
> [I made a confusing typo; IT8712F instead of IT8721F]
> 
> I got a new motherboard with an ITE IT8721F and it seems there is no
> driver support yet. I tested with the latest sensors-detect and
> checked the 2.6.34 kernel code.
> 
> http://imagebin.ca/img/KOmZOy.jpg # picture chipset

New chip. I've added detection to sensors-detect, but we have no
support yet. The chip isn't even listed on ITE's website.

> http://debian.pastebin.com/zagTLbkx # dmidecode

Asus board. You will have to use the asus_atk0110 driver.

> http://debian.pastebin.com/P50Mf0Bv # latest sensors-detect
> 
> I want to use the driver to control fans with PWM. There are two four
> pin fan connectors on the motherboard and the BIOS shows support for
> PWM fans in silent standard turbo and manual mode.
> 
> I can't find a datasheet with the differences between 20f and 21f? If
> somebody can add support for this chipset I would be very thankful.
> 
> I helped in the past with providing motherboards for developers. I can
> also provide remote SSH root access to this system if needed.

Manual fan speed control isn't available on Asus desktop boards that
implement ATK0110, and probably never will. I fear you chose the wrong
board for the job, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
