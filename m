From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 15:33:56 +0000
Subject: Re: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <20100913173356.4d251fb8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Sep 2010 20:13:00 +0530, Datta, Shubhrajyoti wrote:
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Massive NACK. You are exposing a raw register interface to user-space,
> > in a way which can't be standardized. This goes against the philosophy
> > of our standard sysfs interface.
> > 
> > If you have an LM75-style device in an embedded device, configuration
> > should be provided as platform data. For other cases, either the
> > BIOS/firmware should configure the device properly, or you can do it
> > with i2c-dev + i2cset from user-space.
> 
> Ok makes sense. 
> > 
> > If any properly really needs to be exposed though sysfs in your
> > opinion, it must be standardized first and stick to the one file, one
> > feature philosophy.
> I chose it as a sysfs because ideally the resolution/time is a tradeoff applications are better suited and not board dependent.

Polarity OTOH is quite board-specific.

> However agree to your "one file, one feature" comment. Was wondering if any other driver has similar interface or sysfs entry(resolution).

Not that I know of. At least there's no standard sysfs attribute for
that. We have one for update rate, but it's fairly recent. Having one
for resolution would certainly make sense for simple temperature
sensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
