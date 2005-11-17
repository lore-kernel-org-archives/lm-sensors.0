From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 17 Nov 2005 10:34:18 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <Vljn9pXR.1132219253.1222760.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <437B61B1.50003@varma-el.com>
References: <4378960F.8030800@varma-el.com>
In-Reply-To: <4378960F.8030800@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: avolkov@varma-el.com
Cc: "Mark A. Greer" <mgreer@mvista.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>


Hi Andrey,

On 2005-11-16, Andrey Volkov wrote:
> It's pity, but all chips of m41xx family (approx. 20 members) have same
> i2c slave address (0x68) and have not some hwd model specific id
> registers. Hence I couldn't made any clue about chip specific
> regs/pins/... at run-time (and couldn't use two or more chips in one i2c
> subnet :)). And the situation worsens, as various chips have various
> time regs offsets, as ex. REG_SEC of m41t00 have offset 0, but
> in m41t85 _SAME_ REG_SEC have offset 1, etc (God, who in ST was so,
> hm, ...., so made such decision?).

I wholeheartedly second your views, it would be way way better if all I2C
chips had an ID register. However, having a separate driver for every
chip doesn't actually solve the undifferenciability issue. You can't
prevent the user from loading the wrong driver. Also, the problem isn't
specific to the m41txx family of chips, many other families of chips
suffer the same.

The main problem here is that i2c-core currently lacks a mechanism which
would let us explicitely attach a given driver (and chip type within
that driver) to an arbitrary adapter, address pair. I will be working on
implementing this with the help of others in the next few weeks. RTC
drivers and media/video drivers should enjoy this new interface.

Thanks,
--
Jean Delvare
