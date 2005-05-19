From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: MPX2/LM90 switching discussion
Message-Id: <20040717092301.337d084d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F6F2A2.50503@synque.com>
In-Reply-To: <40F6F2A2.50503@synque.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks for the comments, I start looking at the code this weekend,
> and since a journey of a thousand miles starts with the first step,
> it's probably best that I get a user-space program running to prove
> the concept and then go from there.

Absolutely. And experimenting with it will also let you test race
conditions, errors on switching etc... so you may have a better view on
what further code should care about.

> I found one of your suggestions very intriguing, writing a 
> independent LM90 driver, something like LM90MPX2 or some such, that a 
> user could insmod instead of or in addition to the LM90 driver. Only 
> MPX2 users would want to use it, and it would segregate this nasty 
> switching business away from the pristine code.

A replacement driver would have the drawback of duplicating part of the
code. A complementary driver would have the drawback that the lm90
driver would need some changes. I don't know what is worse, and trying
both for a wise comparison may be required.

> I've also thought a
> bit about how to solve the synchronization issue as simply as
> possible, and I'm toying with successive accesses reading from
> alternate CPUs. Basically, a incoming request would read from the
> current CPU and trigger a switch.

Yes, that's about the only way I can think about. Or you may try to read
the first CPU temp, then switch, then read all other values, then read
what would possibly be the second CPU temp. But I suspect that the LM90
will stop sampling values when you access it through the SMBus, so it'll
probably won't work (but you may want to try though).

> I know that the two-second caching
> presents a problem, so the minimum access period would have to be
> three seconds. Once again, this is an issue only LM90MPX2 users would
> need to be concerned about. So perhaps we can find a compromise
> between the solution resting in kernel-space, yet not bloating
> existing code (or at least co-habitating with it!)

I don't much get how you go from 2 to 3 seconds. At any rate, you may
want to read the LM90 datasheet. The 2 seconds delay is more or less
arbitrary. Depending on all chips supported (and you would only support
one) and the temperature update frequency, this delay may be lowered.

> I truly understand how badly the folks over at Iwill hosed this up. 
> I don't know /why/ they did what they did, but I do know that their
> BIOS handles it, and Alex's code handles it, so it ought to be
> possible in Linux.

Well, we never said it was not possible. We only questionned on what
would be considered acceptable, and what would not. Iwill BIOS is
specific to your motherboard, which means that anything that works is
basically acceptable. MBM is an all-in-one solution. We have kernel
drivers with an interface to user-space, and a library for use by the
other applications. This adds constraints at the price of evolutivity
(*kof*).

Good luck :)

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
