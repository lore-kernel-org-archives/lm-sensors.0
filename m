From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ds1337 4/4
Message-Id: <AKwWUAUT.1112977301.6626650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050408123545.GA4961@orphique>
References: <20050407231904.GE27226@orphique>
In-Reply-To: <20050407231904.GE27226@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>


Hi Ladislav,

> (...) (And in ideal world
> firmware (such as U-Boot, RedBoot, etc.) should set this register).

Thanks for pointing the obvious out to me. You convinced me, this simply
doesn't belong to the kernel. So your patch is not needed.

I would still welcome a patch documenting the fact that the DS1339 is
compatible with the DS1337 and is supported by the ds1337 driver.

Thanks,
--
Jean Delvare
