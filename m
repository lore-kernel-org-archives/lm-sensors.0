From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Sep 2010 16:51:09 +0000
Subject: Re: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <20100913165109.GC593@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2010 at 11:33:56AM -0400, Jean Delvare wrote:
> On Mon, 13 Sep 2010 20:13:00 +0530, Datta, Shubhrajyoti wrote:
> > > From: Jean Delvare [mailto:khali@linux-fr.org]
> > > Massive NACK. You are exposing a raw register interface to user-space,
> > > in a way which can't be standardized. This goes against the philosophy
> > > of our standard sysfs interface.
> > > 
> > > If you have an LM75-style device in an embedded device, configuration
> > > should be provided as platform data. For other cases, either the
> > > BIOS/firmware should configure the device properly, or you can do it
> > > with i2c-dev + i2cset from user-space.
> > 
> > Ok makes sense. 
> > > 
> > > If any properly really needs to be exposed though sysfs in your
> > > opinion, it must be standardized first and stick to the one file, one
> > > feature philosophy.
> > I chose it as a sysfs because ideally the resolution/time is a tradeoff applications are better suited and not board dependent.
> 
> Polarity OTOH is quite board-specific.
> 
> > However agree to your "one file, one feature" comment. Was wondering if any other driver has similar interface or sysfs entry(resolution).
> 
> Not that I know of. At least there's no standard sysfs attribute for
> that. We have one for update rate, but it's fairly recent. Having one
> for resolution would certainly make sense for simple temperature
> sensors.

I found the following attributes used for the update inverval.

adt7470.c	auto_update_interval
lm95241.c	rate
adm1031.c	update_rate

Not sure about adt7470.c, ince it reflects an automatic interval, but would it make sense
to update lm95241.c to use the standard attribute ?

On a side note, update_rate (or rate) doesn't really reflect its use. A "rate"
would be measured in updates/time, not in absolute time. Or, in other words,
it reflects a frequency, not an interval. So we are really talking about intervals.
Not sure if that is worth bitching about, but since the attribute is quite new
it might make sense to think about it.

Resolution would have to be sensor dependent, since each sensor can have its own resolution.
Would be nice to have an attribute for that.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
