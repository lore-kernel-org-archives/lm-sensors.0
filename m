From: Frank Myhr <fmyhr@fhmtech.com>
Date: Wed, 16 Jul 2008 03:17:30 +0000
Subject: [lm-sensors] it87 automatic mode
Message-Id: <loom.20080716T030318-150@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew Paprocki <andrew <at> ishiboo.com> writes:

> What needs to be implemented for automatic mode? As far as I can tell
> in the datasheet, automatic mode changes the meaning of bits0-6 in the
> CTL register to be a selection of temp1/temp2/temp3 instead of a
> 128-step PWM control value. I could take a stab at implementing
> something for this if you know what you want it to look like. I assume
> the sysfs pwm inputs would change meaning in automatic mode to only be
> a 2 bit value indicating which temp to select? Is there anything more
> complicated needed?
> 
> -Andrew


Hi Andrew,

I'm currently working on implementing automatic mode for it87. My code 
isn't yet fit to post, and no guarantees that it ever will be--it's 
already taken far longer than I expected. But I hope to have something 
ready in the next week or two. If that delay is ok with you, you could 
perhaps hold off on your own implementation to save duplication of 
effort. I'm more than happy to work together also, but my code needs 
more work even before I'd want to email it to you.

I see it's already been a week since you posted this, so you might 
already have as much new code as I do by now... It's probably time for 
me to actually subscribe to the mailing list rather than just checking 
the archives occasionally.

-Frank


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
