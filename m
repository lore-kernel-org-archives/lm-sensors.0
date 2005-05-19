From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ds1337 driver works also with ds1339 chip
Message-Id: <u7zs9Dp4.1115728806.6659250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050510120804.GA2492@orphique>
References: <20050510120804.GA2492@orphique>
In-Reply-To: <20050510120804.GA2492@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>


Hi Ladislav,

> > next to the end of the ds1337 driver. Maybe it would also make sense to
> > have a ds1337.h header file declaring this function?
>
> I'm not sure if adding yet another driver specific header is a good
> idea. Perhaps we should consolidate I2C RTC drivers a bit more and
> create common header for them?

Agreed, although I would go one step further. I see no reason why it
matters whether these are *I2C* RTC or not. I have no concrete proposal
but it really sounds like a common RTC interface would be needed here -
if it doesn't exist already. Can't say more unfortunately, as I never
had to use a RTC myself.

> Document the fact that ds1337 driver works also with DS1339 real-time
> clock chip.

Good work, thanks.

--
Jean Delvare
