From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: lm_sensors
Message-Id: <5hpypiXp.1115909226.3088720.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitry,

> > First, check your BIOS for an automatic fan speed adjustment option. Is
> > there one? If there is one, disable it.
>
> I've found only 'CPU Warning Temperature', 'CPU FAN fail warnig',
> and 'System FAN fail warning' all disabled.

Unfortunately, this could be an indication that PWM is not wired on this
board. the two Gigabyte boards using the it87 driver I have access to
and that have their PWM lines wired do have the option in BIOS.

> It is like the same motherboard with Windoze is silent, though I'm not
> sure.

Please make sure ;) If the motherboard is actually silent under Windows,
please try to find out what the difference can be. Maybe you are using a
specific tool under Windows? If your CPU supports some form of power
saving or throttling, maybe it is enabled under Windows but not under
Linux (which could result in a faster fan speed if your fan is
themoregulated).

> Where to find the datasheet?

On ITE's web site:
http://www.ite.com.tw/product_info/file/pc/IT8712F_V0.8.2.pdf


> There is a second definition in the file about it87. Maybe I'd
> better to use it?

I can't tell, all motherboards are different. For the temperatures, you
would most likely simply do:

   ignore temp2
   label temp3 "CPU Temp"

--
Jean Delvare
