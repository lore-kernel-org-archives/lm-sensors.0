From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <o2DT2DNI.1108743986.5909490.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> I don't know what parameters to pass to i2detect and i2cdump. I've tried
> some adresses like 002e and lots of others but i don't know which one.
> I'll take time to read man for i2cdetect and i2c dump. But i don't have
> time to do it know.

"i2cdetect 0" will list the addresses on your SMBus. Then use these
address as parameters to i2cdump. Most likely You need to do "i2cdump 0
0x2e".

> OK i realised that /sys/bus/i2c/devices/0-002e/name contains adm1027
> instead of adt7463. Actually, i don't know which one is right since i
> can't read the name of a chip that is "jailed" in a laptop.

Both chips are mostly compatible. Do you have any reason to believe that
you really have either one? Sometimes manufacturers just put what they
have available at any given moment, thanks to that compatibility.

> Do i have to load the lm85 module with special options like :
> modprobe lm85 force_adt7463=xxxx

Should not be needed. The dump will tell. Either you really have an
ADM1027, or the detction is broken and we'll fix it.

> > I admit I am surprised, I never thought that lowering the speed of the
> > fan could really spare a significant amount of battery.
>
> Well, i thought that the fastest the fan turns, the more energy is spent
> and the shorter the battery lasts. No ? If the fan does not spend a lot
> of energy, reducing fan speed has at least one advantage : less noise !

That makes sense, but I'd guess the fan only uses 0.5W of power or so.
If you set the PWM to a 50% duty cycle you'll save 0.25W. Out of the
25W your laptop must be consumming, it's not much, only 1%. Still I
agree that whatever you can save, should be. But actually I think it's
more interesting for the noise reduction than for the power consumption
reduction.

> Should i use something like :
>
> set pwm1_zone 123
>
> in /etc/sensors.conf in the appropriate section (lm85 and co...), as
> explained at the end of your linked document ?

You may need to. Zones define which temperature sensors determine the
speed of a given fan. I'd hope that your BIOS already configured the
zones properly, but maybe not. At any rate, be very careful when chaning
this. If you configure the zones improperly, the fans may stop speeding
up properly on temperature increase (obviously), possibly causing
permanent damage to your hardware!

--
Jean Delvare
