From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 May 2010 13:14:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asc7621) Bug fixes
Message-Id: <20100503151405.2290c894@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BDC27C4.2000205@kenm.demon.co.uk>
In-Reply-To: <4BDC27C4.2000205@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ken,

If you could stop top-posting...

On Mon, 03 May 2010 13:47:30 +0100, Ken Milmore wrote:
> Regarding the SENSORS_LIMIT(reqval, 0, 0xffff) in store_in8() which you 
> have tagged as spurious, I believe it is necessary to prevent an 
> overflow situation if an input value were provided such that reqval * 
> 0xc0 > LONG_MAX.  I should probably have added a comment to this effect. 
>   The second SENSORS_LIMIT() then limits the result of the scaling 
> calculation to the register range 0 - 0xff.  To get away with a single 
> SENSORS_LIMIT(), it would be necessary guard to against the full-scale 
> value mapping to 256, which won't fit in the register.  This could be 
> accomplished like this:
> 
> SENSORS_LIMIT(reqval, 0, ((asc7621_in_scaling[nr] * 0x100) / 0xc0) - 1);
> 
> - but that just looks far too obscure to me, and not worth the bother. 
> Please let me know if you think otherwise.

OK, if this is done on purpose, then fine with me.

> In general I've been very cautious in preparing the patch to only change 
> lines of code that were demonstrably broken, rather than fixing up 
> stylistic issues.  For example, the temperature scaling calculation is 
> done in what is IMHO a rather bizarre fashion, but it doesn't actually 
> get the wrong answers so I have left well alone.  The same goes for use 
> of signed and unsigned types: personally, I'd strongly prefer to see 
> long, simple_strtol() and sprintf("%ld") used throughout the driver for 
> the scaled values, as I think consistency makes for more maintainable 
> code.  But I'm happy to go with your suggested changes all the same.

I'm very happy with the approach you took. The most important thing
right now is to get the driver in good shape for 2.6.34-final. If more
important changes or cleanups are desired, they can happen later.

BTW, if you feel like taking care of the asc7621 driver in the future,
feel tree to add your name to the MAINTAINERS entry for that driver. I
tend to accept more changes from driver maintainers than from other
contributors, because I know they will care if something breaks.

So I've applied your bugfixes patch, and will send it to Linus soon.

> Lastly, regarding the PWM control settings, I will take a look at what 
> can be done to make these comply better with the sysfs-interface.  IMHO 
> there is no completely clean solution here; several of the 
> sysfs-interface settings map onto the same bits of the same registers in 
> the device, so they cannot be completely orthogonalised.

I didn't look at the details (and certainly won't have the time to do
it) but this is something relatively frequent. It can require some
thinking to make all chips fit in the interface, but in most cases it
is manageable. Feel free to discuss specific issues you have.

> On a note of more general discussion:  I don't want to sound negative, 
> but maybe the PWM control interface has been a step too far for the 
> hwmon drivers.  For a device like the asc7621, the programmer has to 
> bend over backwards to make it fit the published interface, simply 
> because the settings must be poked into the device one at a time as they 
> are changed.  For this kind of device, it would be better to build up a 
> complete register profile and then stuff the whole thing into the device 
> in one go.  This could be better handled by a userland library than a 
> kernel driver...  Opinionated rant over. ;-)

You opinion on this is very welcome. I guess you refer to the automatic
fan speed control interface (the manual control interface is simple
enough that there's probably not much to discuss.) Originally there was
no standard interface for this. Several days ago I made a proposal to
standardize it, which received mixed reviews. I finally implemented it
because no better alternative came out, but there are still cases where
the chip won't fit.

As for the one-value-per-file approach, that's mandatory for sysfs
interface, and hwmon drivers have been using sysfs since kernel
2.5.something. That being said, the automatic fan speed control is
indeed very different from the monitoring part of the drivers, and I
would have no objection to a brand new interface being developed, if it
has significant advantages.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
