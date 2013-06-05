From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Jun 2013 11:45:30 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: mc13783-adc: Refactor source to indicate various mc13xxx chips
Message-Id: <20130605134530.12e8b7c2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <1370423952.906453652@f168.mail.ru>
 <20130605125308.36ba40ab@endymion.delvare>
 <1370430879.384973987@f91.mail.ru>
In-Reply-To: <1370430879.384973987@f91.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 05 Jun 2013 15:14:39 +0400, Alexander Shiyan wrote:
> > Let's look at it from another angle. What problem are you trying to
> > solve? I see absolutely no problem with the current function and file
> > names. Almost all Linux kernel drivers support more chips than their
> > name says.
> > 
> > On the other hand, changing all function names makes backporting fixes
> > harder, and changing Kconfig symbol names makes upgrading to the new
> > kernel version harder for everyone.
> > 
> > So the cost of your proposal far outweighs the benefits.
> 
> Well, let's leave the kconfig symbol as is. But about the rest, that mc13783_*
> symbols in the log (debug) will say a developer who does not know about
> mc13892 compatibility with mc13783? I still believe that this should be reflected.

You're splitting hairs here. mc13783_* symbols in the log mean this
comes from a driver named mc13783, period. A developer drawing
conclusions beyond that needs to be educated. Which device the driver
is driving can be retried from the log itself, or from sysfs. Or the
hardware board datasheet. "mc13xxx" would tell no more, BTW.

Also note that the name mc13xxx is wrong as well, as the mc13xxx-i2c
and mc13xxx-spi drivers handle the MC34708 chip too. So you'd have to
name all these drivers and functions mcxxxxx* to cover all the
supported chip. Which makes no sense at all, because so many x's are
confusing, and because the mask then matches many devices the drivers
do _not_ handle.

So please forget about this and move on to something else. There are
many many code cleanups and improvements, and bug fixes, all way more
important than this. So I'm sure you can find better ways to spend your
time, and mine.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
