From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Dec 2005 10:05:55 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83792d fix fan auto adjust
Message-Id: <20051211110555.04f0af45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7BF78@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7BF78@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> This patch fix the auto adjust fan divisor bug, and save the low limit
> while change the divisor.
> I have tested it and it works well on my MB. It depends on the previous
> patch (w83792d_lm2_clear_code.patch)
> Please can you check it? 

I've taken a look and the patch looks rather good. However there's
something I am not happy with in the w83792d driver. It's not directly
related to this patch, as the current code in lm_sensors CVS has the
same issue. But as you are working in the same area, maybe you could
fix it.

The w83792d driver changes the fan clock dividers automatically. I'm
fine with that, however it also lets the user change the divider values
manually. This does not make sense! At the next fan speed reading,
chances are that the driver will change the divider value if it wasn't
optimal anyway.

So I would like fan_div to be read-only for the user. If you do that,
you'll see that you can simplify the automatic fan div change code,
because you will no more need to convert from divider to register value
(e.g. 8 -> 0x03). Your new "w83792d_set_fan_div" function will take a
register value as its "divisor" parameter rather that a divider value.

Can you please rework your patch in that direction?

Thanks,
-- 
Jean Delvare

