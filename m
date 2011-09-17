From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Sat, 17 Sep 2011 17:52:41 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8D6D202@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

[snip..]
> > > > //but we do not know from which direction.
> > > > if (msr_val & THERM_LOG_THRESHOLD0) {
> > > > 	//if the status bit is one, the input temperature is higher than
> the
> > > > 	//configured threshold. If it is zero, the input temperature is
> lower
> > > > 	//than the configured threshold.
> > > > 	bool alarm = msr_val & THERM_STATUS_THRESHOLD0;
> > > > 		print: alarm
> > > > 	//Let the user space take care of 0/1 from the *_alarm interfaces.
> > > > }
> > > >
> > > So there is a clear notion of "exceed" associated with those thresholds ?
> >
> > Sorry Guenter. I don't get what you mean by this :-(
> >
> How about "It is known that the temperature is at or above the threshold" ?

Oh. I get it. Thank you..

> > > I thought there was just an interrupt whenever the threshold is reached
> > > from either side. Looks like I missed that one.
> > >
> > > Personally, I don't think "alarm" would be appropriate here, since we don't
> > > know if the threshold is supposed to be a lower or an upper limit, and if
> > > it reflects an alarm to start with. If we define a new set of attributes
> for
> > > unspecified thresholds, I would prefer something like
> > > "tempX_thresholdY_triggered".
> > >
> >
> > For me, it looks like, we need not know whether the threshold is upper or
> lower.
> > Anyway, for every threshold, we will get two interrupts (for either
> direction)
> > So, the user space can assume either a lower threshold and look for 0 in the
> > Corresponding alarm interface Or a higher threshold and look for 1 in the
> > alarm interface. Will this not work ?
> >
> For a lower threshold, "alarm" implies "temperature is at or below threshold",
> In other words, "alarm" can mean that a value is above or below a given
> threshold -
> it has a semantics that depends on its context.
> 
> This context is not known in the case of a generic threshold. This is why I
> suggested
> to use a more neutral term, such as "triggered", which would imply "at or above
> threshold" (or possibly just "threshold triggered" if the direction is not
> known)
> without attaching a semantics to it.
> 

Ok. I agree. We can use tempX_thresholdY_triggered.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
