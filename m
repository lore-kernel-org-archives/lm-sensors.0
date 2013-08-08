From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Aug 2013 20:00:26 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <20130808200026.GA18226@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk>
 <52038035.7030803@roeck-us.net>
 <20130808130840.GC6427@sirena.org.uk>
 <5203B78C.7010101@roeck-us.net>
 <20130808171554.GI6427@sirena.org.uk>
In-Reply-To: <20130808171554.GI6427-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Thu, Aug 08, 2013 at 06:15:54PM +0100, Mark Brown wrote:
> On Thu, Aug 08, 2013 at 08:21:48AM -0700, Guenter Roeck wrote:
> > On 08/08/2013 06:08 AM, Mark Brown wrote:
> 
> > >I'd be most surprised if the device worked without power, if the driver
> > >fails to get and enable a regulator for it then that's not great
> > >(especially if it does so silently).
> 
> > Correct, but it appears that the driver magically worked for a long time
> > without it.
> 
> Sure, it'll work in systems that have always on regulators.
> 
> > Is it guaranteed that the driver keeps working for all cases where
> > regulator support is enabled in the kernel, and where it used to work
> > so far without mandating the existence of this specific regulator ?
> > My main concern is having to deal with complaints that the driver stopped
> > working for no good reason.
> 
> Sure, that's the transition issues I mentioned - the regulator API does
> have stubbing facilities which should cover things and it's very easy to
> define stub regulators if you need to.  Like I say I expect this to be a
> lot easier after the next merge window as another way of doing stubs is
> being added which should make this even easier by avoiding disrupting
> drivers that do genuinely want to check for absent supplies and handle
> that better.
> 
We will need to make sure that all dts files using any of the compatible chips
are updated accordingly. There are several entries in various dts files for
adm1032, adt7461, lm90, and nct1008.

> > In this context, is it common practice to name such regulators "vdd"
> > or similar ? What if there are multiple LM90 or compatible chips
> > in a system, connected to different power rails ? Who determines
> > if the regulator is supposed to be named "vdd" or "vcc" or anything
> > else, and to which power rails it is actually connected ? How can
> > and does one guarantee that "vdd" is the correct regulator to use
> > for all systems ? What if some other driver requests "vdd", but the chip
> > it supports happens to be connected to a different power rail ?
> 
> That's not what the name means - they are nothing to do with the board.

Ok, makes sense.

> The names requested by a driver are defined with regard to the device
> and should be the names used by the chip itself as defined in the

9 votes for vdd, 11 votes for vcc, one undecided (no datasheet available).
Guess one is as good as the other ;-).

Guenter

> datasheet.  A board that uses regulators then maps these onto specific
> regulators in the system, the driver doesn't need to know anything about
> this process.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
