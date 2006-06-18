From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 20:17:15 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060618221715.6a872ba3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060618021736.f08a39bb.gimeshell@web.de>
In-Reply-To: <20060618021736.f08a39bb.gimeshell@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Actually my point was that there is probably nothing to correct.
> 
> my BIOS does have such an idle loop, too.
> Temperature is increasing from about 35 degrees immidiately after
> entering BIOS up to 46 degrees met after a few minutes.
> Looking at sensors output while linux is idle, i get shown about 30
> degrees with sensors default computation line for asus CUSL.

So I'd say the compute line is correct and you don't need to change it.

> > We use the formula which gives the best result for the applicable
> > range of temperatures. There's little point in having a slighly more
> > simple equation if it gives less accurate results.
> 
> But what's the mathematic principle behind this method (first
> to multiply with value, then to add another value)?

We simply try to reflect the physical reality. Given that this physical
reality is complex we limit ourselves to a linear interpolation in the
temperature range we are interested in. Usually this is good enough.

> Isn't the bottom line outcome the same if only adding fixed value
> instead of first to multiply and after that to add another value?

Sorry, there's not much I can do for you at this point. You seem to
lack the basics of linear algebra.

-- 
Jean Delvare

