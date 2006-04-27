From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Apr 2006 21:41:14 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060427234114.941c9657.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ben, Jordan,

Can you please comment on this?
http://bugzilla.kernel.org/show_bug.cgi?idd45#c15

This is a propsal to make the scx200_acb driver's default base
addresses configurable through Kconfig. What do you think?

Another possibility would be to detect them at runtime depending on
some platform data. Sounds more complex, if possible at all.

Or we can stick to the current state (default addresses, can be
overriden with module parameters).

What makes the current default addresses (0x820 and 0x840) more
legitimate than what Alexander has (0x810 and 0x820)?

Thanks,
-- 
Jean Delvare

