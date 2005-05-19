From: davidsen@tmr.com (Bill Davidsen)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] I2C update for 2.6.9
Message-Id: <417D4621.5010604@tmr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1098231506642@kroah.com> <10982315063481@kroah.com>
In-Reply-To: <10982315063481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Greg KH wrote:

> Trip points
> =====> 
> Trip points are now numbered (point1, point2, etc...) instead of named
> (_off, _min, _max, _full...). This solves the problem of various chips
> having a different number of trip points. The interface is still chip
> independent in that it doesn't require chip-specific knowledge to be
> used by user-space apps.

It would seem that all chips would have off, max, full, etc, but mapping 
nondescript names into functionality may require some chip info anyway. 
As you note, with some chips these are not nice linear points on a line, 
  so it would seem to tell if the top points were "max norm" and "max 
safe" vs. "critical" and "shutdown NOW" is still going to need some 
information on the chip, both points and operating range.

That's an observation, not a complaint, not even a question unless you 
feel the urge to enlighten me.
> 
> The reason for this change is that newer chips tend to have more trip
> points. the LM63 has 8, the LM93 has no less than 12. Also, I read in
> the LM63 datasheet that ideal pwm vs temperature curve were parabolic in
> shape. Seems hard to achieve this if we arbitrarily lock the number of
> trip points to 3 ;)
> 
> I also introduced an optional hysteresis temperature for trip points.
> The LM63 has this. Since it makes full sense I'd expect other chips to
> propose this as well.
> 
> As before, there are two sets of files, each chip driver picks the one
> matching its internal model: trip points are either temperature
> channel-dependent (ADM1031...) or pwm channel-dependent (IT87xx...). If
> we ever come accross fan speed-driven pwm outputs where trip points are
> fan channel-dependent we may have to offer a third set of files. We'll
> see when/if this happens.
> 
> I hope I have taken everyone's comments and advice into account and we
> can make this interface proposal part of the sysfs interface standard
> now. I'm sorry it took so long. Comments welcome.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
