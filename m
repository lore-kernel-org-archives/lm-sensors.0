From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 3/3
Message-Id: <Ky47NT3d.1115201231.3150830.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050504061438.GD1439@orphique>
References: <20050504061438.GD1439@orphique>
In-Reply-To: <20050504061438.GD1439@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>


Hi Ladislav, hi all,

> Chip is searched by bus number rather than its own proprietary id.

Yes, I think it makes much more sense (especially since the proprietary
id was not known by anyone outside of the ds1337 driver).

I think I understand that ds1337_do_command() will be called from some
other kernel driver. Why isn't it exported then? I'd expect:
EXPORT_SYMBOL(ds1337_do_command);
next to the end of the ds1337 driver. Maybe it would also make sense to
have a ds1337.h header file declaring this function?

Additionally, I would welcome an additional patch documenting the fact
that the ds1337 driver will work fine with the Dallas DS1339 real-time
clock chip.

Thanks,
--
Jean Delvare
