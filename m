From: avolkov@varma-el.com (Andrey Volkov)
Date: Wed, 16 Nov 2005 17:44:02 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <437B61B1.50003@varma-el.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6dEExmJ9.1132154398.1580970.khali@localhost>
In-Reply-To: <6dEExmJ9.1132154398.1580970.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Jean

Jean Delvare wrote:
> Hi Andrey,
> 
> On 2005-11-16, Andrey Volkov wrote:
> 
>>>I wrestled with the ST website for the m41t85 datasheet but lost so I
>>>I can only guess from the patch.  The drivers do look very similar.
>>>It looks like the m41t85 is basically a m41t00 with an alarm (watchdog
>>>timer never used AFAICT).
>>
>>http://www.st.com/stonline/products/literature/ds/7531/m41st85w.pdf
>>(I agree ST's (and Maxim's too) site is for strength of mind men :) ).
> 
> 
> We're sliding off-topic, but I find Maxim's website quite good.
Try select chip by interface :) (Timekeeping & RTC as ex).
But Maxim site is better, it's not disputed.
> 
> 
>>>Also there are some differences in register
>>>offsets and [maybe] some minor differences within the registers but
>>>nothing that serious.
>>
>>Mainly you're right, but, as I wrote before, due to _many_ little
>>differences I get #if/#else.. noise (half file, if be more precisely,
>>was under #if/#else) in unified file. But, if this noise
>>will be acceptable, then yes, I agree to merge this drivers, as minimum,
>>for better administration.
> 

<snip>

> Same reasonment holds for the m41t00 vs. m41t85 choice. You can't decide
> at compilation time. If we go for a common driver, it has to support
> both devices at the same time. Mark suggested to use platform-specific
> data. I'm not familiar with this, but it sounds reasonable.
It's pity, but all chips of m41xx family (approx. 20 members) have same
i2c slave address (0x68) and have not some hwd model specific id
registers. Hence I couldn't made any clue about chip specific
regs/pins/... at run-time (and couldn't use two or more chips in one i2c
subnet :)). And the situation worsens, as various chips have various
time regs offsets, as ex. REG_SEC of m41t00 have offset 0, but
in m41t85 _SAME_ REG_SEC have offset 1, etc (God, who in ST was so,
hm, ...., so made such decision?).

So I coldn't see any suitable run-time method of detection which
function driver could use for current "unknown" m41xx chip (from driver
probe point of view) whithout Kconfig/module parameter prompting.

> 
> I don't know for sure at this point whether having a single driver is
> the right choice, I'll let you and Mark check it out and decide. But
> the right way to determine this is definitely not through the use of
> #if/#endif preprocessing stuff.
IMHO - single driver for all m41xx will be nice thing, but I'm not
sure that it will not be monster- alike when it be released.

-- 
Regards
Andrey Volkov
