From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Notes: automatic fan clock divider selection in adm9240
Message-Id: <nVC3zUgb.1113205038.7705960.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <fnlj51d1h4t37846bt741scmr7bj8s17b2@4ax.com>
In-Reply-To: <fnlj51d1h4t37846bt741scmr7bj8s17b2@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Working on tweaking adm9240 driver, just finished documenting a method
> for automatic fan clock divider control in the driver.  Code suggested
> by Jean Delvare, implemented and tweaked for correct behaviour in the
> face of unreasonable user input.

I am all in favor of this (obviously). Could you please detail what kind
of changes you did on top of my original w83627ehf code? If it sounds
good I'll backport to my driver.

Thanks,
--
Jean Delvare
