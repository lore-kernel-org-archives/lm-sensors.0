From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 17 Sep 2011 18:09:43 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110917180943.GA21521@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durga,

On Sat, Sep 17, 2011 at 01:40:41PM -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
[ ... ]

> > > For me, it looks like, we need not know whether the threshold is upper or
> > lower.
> > > Anyway, for every threshold, we will get two interrupts (for either
> > direction)
> > > So, the user space can assume either a lower threshold and look for 0 in the
> > > Corresponding alarm interface Or a higher threshold and look for 1 in the
> > > alarm interface. Will this not work ?
> > >
> > For a lower threshold, "alarm" implies "temperature is at or below threshold",
> > In other words, "alarm" can mean that a value is above or below a given
> > threshold -
> > it has a semantics that depends on its context.
> > 
> > This context is not known in the case of a generic threshold. This is why I
> > suggested
> > to use a more neutral term, such as "triggered", which would imply "at or above
> > threshold" (or possibly just "threshold triggered" if the direction is not
> > known)
> > without attaching a semantics to it.
> > 
> 
> Ok. I agree. We can use tempX_thresholdY_triggered.
> 
I'd like to hear Jean's opinion first. Also, if we introduce new attributes,
we should probably reinstate the old "max".

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
