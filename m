From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 06:11:18 +0000
Subject: Re: [lm-sensors] [PATCH] Support for Enermax DigiFanless 550W PSU
Message-Id: <55D17B06.60108@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF=9fWv3JY_ejXwa9Z93YYnbEOXQjgt-xh60nT4GySwMY7b-yA@mail.gmail.com>
In-Reply-To: <CAF=9fWv3JY_ejXwa9Z93YYnbEOXQjgt-xh60nT4GySwMY7b-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/16/2015 08:57 PM, Frank Schaefer wrote:
> Regarding the placement of the driver, I'm actually kind of torn on
> this myself.  Mainly because the driver includes hid-ids.h, which for
> some reason resides in drivers/hid instead of the more logical
> include/linux.  I could obviously move things around and still include
> it as "../hid/hid-ids.h", although that feels wrong as well.
>
> I can do whichever you feel is the lesser of two evils; in the
> meantime, I'll focus on cleaning up and re-testing the code.
>
That depends on the hid maintainers, really. If an include file from the
hid directory is needed, the driver should either reside there or the code
should be reworked to not require it.

Main problem I have with drivers outside their subsystem is that they
are often not properly maintained, and they are often not reviewed by people
who know the subsystem. That you copied lm-sensors with your patch is really
the exception; most of the time that doesn't happen, and very often such
drivers have problems or don't even work in the first place.

But, again, that really depends on the hid maintainers. If the common hid
approach is to have all hid drivers there, so be it.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
