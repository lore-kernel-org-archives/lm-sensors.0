From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Jul 2006 13:31:52 +0000
Subject: [lm-sensors] [RFC PATCH] lib/access.c optimization
Message-Id: <20060728153152.0a5f4e96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060725041358.GB12109@jupiter.solarsys.private>
In-Reply-To: <20060725041358.GB12109@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark,

> The following patch shaves about 8% off the execution time of 'sensors -u'
> on my workstation (2645586 cycles before vs. 2430821 cycles after).
> 
> Can I please get an ACK on this patch before I commit it?  Thanks.

This patch ain't trivial, it would help if you could explain what it is
doing, and how. It seems to be completely different from what you
showed to me at the OLS?

Thanks,
-- 
Jean Delvare

