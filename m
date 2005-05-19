From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC PATCH remove DIV_TO_REG in gl518sm.c
Message-Id: <z2mwAOV6.1111396224.7808090.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
In-Reply-To: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Starting converting gl518sm.c to use proper DIV_TO_REG error
> handling and found nothing using the macro?
>
> This trivial patch removes that apparently unused macro.

The macro *is* in fact used, although the (ab)use of macros all over the
place make it hard to see it the first place (grep can't help here).

Look at these two lines:

set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);

Climb up the preprocessing chain, and you'll see that the DIV_TO_REG
macro is actually needed. You could have noticed by simply
compile-testing your patch. I invite you to always do.

You just hit one of the various reasons why I prefer inline functions to
macros when both are possible. At least the compiler keeps track of
function users and will let you know the unused ones.

Thanks,
--
Jean Delvare
