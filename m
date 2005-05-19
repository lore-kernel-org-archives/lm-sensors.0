From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <tYTiZAEB.1109158385.4108350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> What information should we ask ASUS to provide? Could you tell us more
> about it?
>
> In your opinion, what is the exact reason that 792 driver can NOT work
> on this motherboard? The bug of 792 driver? the bug of i2c bus driver?
> or the bug of the motherboard itself? Can we make the 792 driver work
> if we modify w83792d.c when we know the "hidden information" you
> mentioned.

The w83792d driver does not need to be changed. The problem is that the
W83792D chip is not accessible. If it were accessible, the driver would
work just fine.

What we need is to know where the W83792D chip is located. If it is on
the standard Intel 82801 SMBus, then there must be something to do to
unhide it. Our guess is that they use GPIO lines to disable/enable
segments of the SMBus. Another possibility is that they may have setup
another SMBus, maybe using GPIO lines, or a different chip on the
motherboard. If they use GPIO lines, we can't guess which ones nor how,
unless they help.

So the question you would need to ask Asus is: How do you get access to
the W83792D chip? Their answer must include the bus the chip sits on
(Intel SMBus, other chip, GPIOs...) and the operations needed to unlock
that bus (or segment thereof) if such operations are needed.

Hope that helps,
--
Jean Delvare
