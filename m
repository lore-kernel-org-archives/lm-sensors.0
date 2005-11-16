From: avolkov@varma-el.com (Andrey Volkov)
Date: Wed, 16 Nov 2005 15:51:15 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <437B4734.7060306@varma-el.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <437A57CB.8090302@varma-el.com> <20051116031520.GL5546@mag.az.mvista.com>
In-Reply-To: <20051116031520.GL5546@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org



Mark A. Greer wrote:

> When I originally submitted the m41t00 patch, I made it clear that it
> was PPC only and gave the reason why:
> 
> http://archives.andrew.net.au/lm-sensors/msg29280.html
> 
> What processor arch did you test your m41t85 driver on?
PPC32 :) (MPC5200).

> AFAICT, PPC is the only arch that uses that exact definition of
> get/set_rtc_time().
But chip (and driver) itself may be used in any i2c net with any
chip as master with slightly modification of platform driver.
Am I right?.

-- 
Regards
Andrey Volkov
