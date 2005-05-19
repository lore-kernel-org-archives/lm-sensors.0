From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: LM75 detection reworked
Message-Id: <200407050724.i657OnNW011853@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040703105636.6ba726d6.khali@linux-fr.org>
In-Reply-To: <20040703105636.6ba726d6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,

> Will the LM75 driver still work with the LM77?

Well, it never did, so it can't do less now.

> Is the only difference the encoding of the temperature values?
>
> If so, then it looked like a simple chip specific shift could be added
> to the FROM_REG and TO_REG macros to make the same driver work for both
> chips.
>
> But I haven't looked into the code in detail or the datasheet for the
> chips...

No, there are other differences:

* The LM77 has additional min and max limits.
* LM77 hyst register is relative and applies to all 3 limits (LM75's is
absolute).
* The LM77 has alarm flags for all three limits.
* The LM77 has a shorter address range (4 addresses instead of 8).

All in all, the LM75 and the LM77 have not much in common except being
single temperature sensors those first 4 registers are used for the same
thing (but with different formats). For this reason I don't see much
benefit in having a single driver for both chips. Another reason is that
the LM77 is obviously not much used (of we would have noticed the
incompatibility way earlier!) while the LM75 is widely used, so let's
not bloat the lm75 driver.

Thanks,
Jean Delvare
