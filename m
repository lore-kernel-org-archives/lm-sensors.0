From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Sep 2010 18:09:06 +0000
Subject: Re: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <20100913180906.GA2099@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2010 at 01:41:21PM -0400, Jean Delvare wrote:
> On Mon, 13 Sep 2010 09:51:09 -0700, Guenter Roeck wrote:
> > On Mon, Sep 13, 2010 at 11:33:56AM -0400, Jean Delvare wrote:
> > > Not that I know of. At least there's no standard sysfs attribute for
> > > that. We have one for update rate, but it's fairly recent. Having one
> > > for resolution would certainly make sense for simple temperature
> > > sensors.
> > 
> > I found the following attributes used for the update inverval.
> > 
> > adt7470.c	auto_update_interval
> > lm95241.c	rate
> > adm1031.c	update_rate
> > 
> > Not sure about adt7470.c, ince it reflects an automatic interval, but would it make sense
> > to update lm95241.c to use the standard attribute ?
> 
> Yes it would.
> 
> > On a side note, update_rate (or rate) doesn't really reflect its use. A "rate"
> > would be measured in updates/time, not in absolute time. Or, in other words,
> > it reflects a frequency, not an interval. So we are really talking about intervals.
> > Not sure if that is worth bitching about, but since the attribute is quite new
> > it might make sense to think about it.
> 
> Jonathan Cameron (Cc'd) had a similar concern:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028596.html
> 
> Nobody seemed to care back then. I can't disagree with both of you, but
> OTOH I don't feel too strongly about it either. So if someone submits a
> patch making things better, that's fine with me, but I won't spend my
> own time on it.
> 
I'll submit a set of patches. update_interval ok ? It reflects the time between
events, while period tends to reflect a duration.

> > Resolution would have to be sensor dependent, since each sensor can have its own resolution.
> > Would be nice to have an attribute for that.
> 
> Not too sure about that. I had the same reaction at first, but do we
> actually know of devices where the resolution isn't global?
> 
Yes, in the lm90 driver. Only max6657/58/59 and max6646 have extended local
temperatures, all other chips have only 8 bit resolution for the local temperature.
Remote temperatures are all extended, ie have higher resoution.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
