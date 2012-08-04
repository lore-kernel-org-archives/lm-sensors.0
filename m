From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Aug 2012 05:30:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for ADT7410
Message-Id: <20120804053011.GB16958@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50183D4E.5040708@gmx.de>
In-Reply-To: <50183D4E.5040708@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut,

On Fri, Aug 03, 2012 at 01:20:13PM +0200, Hartmut Knaack wrote:
> Guenter Roeck schrieb:
> > Hi,
> >
> > your mailer replaced all tabs with spaces, making a real review quite difficult.
> > Please fix that.
> It likes to do that, but I fixed it :-)
> >
> > Couple of comments (not a complete review):
> >
> > - For configuration, we commonly assume it is taken care of by the BIOS. Other
> >   that that, if you think anything needs to be configurable, use platform data
> >   and/or device tree information. No sysfs attributes, please.
> I tend to regard this from the users point of view. My aim is to have it supported in openwrt, where you get your ready-to-flash image and install your custom kernel modules and software. It's fine to have some valid default configuration, maybe set by those ways you mentioned. But I would prefer to have some chance of runtime configuration. BIOS/bootloader is something you don't really want to mess with, platform data requires kernel (module) compilation, from what I know. Device tree might work, though I'm pretty unexperienced with that, yet.

Me too, but that is not an excuse. Ultimately, it is platform data, device tree,
or nothing.

> > - Hysteresis is an absolute temperature, not a relative one. So the question for
> >   a generis attribute would be what it applies to. The current approach does not
> >   have that problem.
> From what I see, most sensors store hysteresis as absolute temperature (like lm75). But some store one offset values (like adt7410, adt7475), which have to get converted by the driver to appear like absolute values. In case of the adt7410, the offset applies to min, max and crit, and in my driver it is set with max_hyst (since I think that is the most common use). But if someone would only want to use alarm for min, it would be necessary to check/set max and set max_hyst, which I think is a bit confusing.

I suggested to provide the hyst attribute for min, max, and crit. This way you
cover it all. Sure, there are three attributes for one register, but that is ok.
See the lm77 driver for an example.

> > - The access retry code in adt7410_update_device is really quite complex.
> >   Is this really needed ? In general, the sensor should be configured for
> >   continuous conversion, and it should not be necessary to wait for a conversion
> >   to complete. besides, we can not afford an active 240 ms wait loop, so if the
> >   loop should _really_ be needed, you would have to add a sleep function call.
> Changed to sleep up to 4 times for 100 ms.

I'll really want to know why you think this is necessary before I accept it. 

> > - The detect function is quite weak. you should definitely also check bits 0..3
> >   of the status register (must be 0), and consider checking against known chip
> >   revision numbers. Question is also if the chip is expected to show up
> >   in a PC type system; if not, it might make sense to drop the detect function
> >   entirely, given its weakness.
> Added those checks. I personally would not need the detect function, just added it for completeness.

I still don't feel comfortable with it. Do you have a use case where it is
needed, or, in other words, do you know of a PC type system with such a sensor ?
Otherwise it might be better to just drop it.

> > - No unnecessary ( ), please [no, it does not make the code easier to read,
> >   it just hides the really important ( )s].
> hopefully fixed.

Not all of them, though.

> > - Please run the patch through checkpatch.pl. I can not really say for sure
> >   due to the tab problem how many issues there  are, but I see at least one
> >   checkpatch error.
> It complained about unneccessary parenthesis, before, but I thought it was safer to keep them.

Extra parenthesis make the code more difficult to read and understand.
It gets difficult to find out what the coder really wanted to implement.
So, really, no, it is not safer, it adds risk.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
