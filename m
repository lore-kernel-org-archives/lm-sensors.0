From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: [PATCH] i2c: new driver for ds1337 RTC
Message-Id: <20050407211839.GA5357@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique>
In-Reply-To: <20050407142804.GA11284@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

On Thu, Apr 07, 2005 at 04:28:04PM +0200, Ladislav Michl wrote:
> Here is yet another patch this time fixes only.
> CHANGELOG:
> * use i2_tranfer function instead of adapter->algo->master_xfer, so
>   we have proper bus locking.
> * BCD2BIN and BIN2BCD are proper macros to use here, see linux/bcd.h
> * Move NULL argument checking from get/set date functions to
>   ds1337_command function, so it is only at one place. Note that other
>   drivers do not this checking at all and I think it is pointess,
>   because you have to know that you are passing struct rtc_time anyway.
> * dev_dbg should probably print info about device driver we are
>   debugging so client->dev looks as better choice than
>   client->adapter->dev.

Jean's point is that you should send an individual patch for each type
of individual change.  It's ok to say "patch 3 requires you to have
applied patches 1 and 2" and so on.  Please split this up better.

thanks,

greg k-h
