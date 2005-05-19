From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <20050427231431.0e9ba84f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

> But whether it's the same hardware implementation or not, if it has
> the same effect, then it's the same feature (quack's like a duck =>
> it's a duck).
> 
> The fan dividors we're used to seeing are ripple counters on the
> 22.5kHz clock that divide it down to reduce the clock pulses counted
> by the gating fan pulses.
> 
> This ripple counter sounds like the same thing, but working on the
> fan pulses directly rather than on the 22.5kHz clock.  So the fan
> tach signal is slower with a higher divisor.
> 
> So the fan_ripple is the *inverse* of the fan_div value, but they
> have the same net effect, and you can account for the reciprical in
> the driver.  ie  fan_div = 8/fan_ripple (if the max "ripple" value
> is 8)

Thanks for the clarification, it all makes sense now, and actually both
ways can be seen as similar, you're right. It's really only a matter of
whether or not we compensate for the division in the driver. We
typically do for fan clock dividers and not in the FSC chips case, but
this is more or less arbitrary.

> I've had to deal with 4-pulse per rev fans before and I've done it
> with  'compute' commands in sensors.conf.  It does not need to be in
> the driver.

Changing the divider (whatever it actually divides) has an impact on the
measurable range and accuracy. This might be a good reason to let the
driver handle it when the chip does, so that we can get the best from
the hardware. Now I agree that the same approach that is currently
followed for the regular fan clock dividers could apply in the FSC case
as well. I have no strong opinion on this (understatement of me being
unable to decide what I think we should do) so any solution that is
consistent will be fine with me.

Thanks,
-- 
Jean Delvare
