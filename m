From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Apr 2006 19:49:53 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060404214953.a0f73ff2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Harald,

> > This is some kind of "high-density" PC, i.e. it is hard to disassemble.
> > I was lucky that the first chip was easy to spot, but the second one
> > could be anywhere. I would suggest to postpone this to tomorrow.
> 
> I have opened the case, removed the power supply and the harddisk,
> but I did not find another Fintek chip. Is it possible that it
> is close to the CPU, maybe below the cooler, or so?
> 
> Maybe it is integrated on the chip we found?

I doubt it. My Fintek contact told me it is a custom ASIC they made
for just one company, so I'm almost certain it's a separate chip. Maybe
it doesn't even have Fintek's usual top marking because of the "custom"
aspect.

No need to search any further anyway, finding the chip won't help us.
Fintek cannot provide a datasheet for custom ASICs. And that chip might
not need a driver in the first place.

-- 
Jean Delvare

