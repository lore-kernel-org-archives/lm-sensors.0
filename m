From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 16 Nov 2005 16:33:59 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <6dEExmJ9.1132154398.1580970.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <437B4619.6050805@varma-el.com>
References: <4378960F.8030800@varma-el.com>
In-Reply-To: <4378960F.8030800@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: avolkov@varma-el.com
Cc: "Mark A. Greer" <mgreer@mvista.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>


Hi Andrey,

On 2005-11-16, Andrey Volkov wrote:
> > I wrestled with the ST website for the m41t85 datasheet but lost so I
> > I can only guess from the patch.  The drivers do look very similar.
> > It looks like the m41t85 is basically a m41t00 with an alarm (watchdog
> > timer never used AFAICT).
> 
> http://www.st.com/stonline/products/literature/ds/7531/m41st85w.pdf
> (I agree ST's (and Maxim's too) site is for strength of mind men :) ).

We're sliding off-topic, but I find Maxim's website quite good.

> > Also there are some differences in register
> > offsets and [maybe] some minor differences within the registers but
> > nothing that serious.
>
> Mainly you're right, but, as I wrote before, due to _many_ little
> differences I get #if/#else.. noise (half file, if be more precisely,
> was under #if/#else) in unified file. But, if this noise
> will be acceptable, then yes, I agree to merge this drivers, as minimum,
> for better administration.

This simply means you did it the wrong way. The use of #if/#else/#endif
suggests that you made the distinction between chips at compilation
time, and the generated driver binary ended up supporting only one of
the two chips. This doesn't make any sense. Same is true for your
output clock frequency, making it a kernel configuration option means
that the decision happens at compilation time, which is very restrictive.

Think of what will happen when a Linux distribution has to build a kernel
for their next release. How are they going to build a kernel suitable
for all systems? With your approach, they just won't be able to.
They'd have to build one kernel with m41t00 support, and one with
m41t85 support. Even worse, they would need one separate build for each
variant of the m41t85 driver, and there are over a dozen of these (one
without clock output, and one more for each allowed clock frequency).
That's obviously insane.

This is why you want to move the decision at the run time level rather
than the compilation time level whenever possible. The clock output
option can't be a configuration option. I previously suggested a sysfs
file, because this gives the greatest flexibility. If you don't like
the idea for whatever reason, you may go for a module parameter instead.

Same reasonment holds for the m41t00 vs. m41t85 choice. You can't decide
at compilation time. If we go for a common driver, it has to support
both devices at the same time. Mark suggested to use platform-specific
data. I'm not familiar with this, but it sounds reasonable.

I don't know for sure at this point whether having a single driver is
the right choice, I'll let you and Mark check it out and decide. But
the right way to determine this is definitely not through the use of
#if/#endif preprocessing stuff.

Thanks,
--
Jean Delvare
