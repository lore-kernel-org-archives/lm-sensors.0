From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [RFC PATCH] I2C adm9240 driver, second round
Message-Id: <quxTd00p.1113389879.7233980.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <10hm51pcfe9aqb87f8ki18ht3runithc0v@4ax.com>
In-Reply-To: <10hm51pcfe9aqb87f8ki18ht3runithc0v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Fixed
>	local vrm copy put back in

Good.

>	force default interrupt mode to get temperature alarm status

Might cause problem. Have you checked whether this mode change affects
any (physical) output of the chip? If it does, then changing the mode
that might have been set up by the BIOS is unwise, as you have no idea
what is wired to that output.

>	slow update for sensor settings (instead of update on access)

What do you mean?

>	automatic fan clock divider now works properly :)

Good.

>	report out of range fan_min as zero

Where "out of range" means a register value of 0, or am I missing
something?

I think that reporting 0 in this case is the correct thing to do,
especially if the chip happens to disable fan alarms when the register
limit is set to 0. Is it the case of the ADM9240?

>	sensors now reads temperature (temp1_max_hyst had wrong name)

OK.

Thanks,
--
Jean Delvare
