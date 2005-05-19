From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Ticket 1834 Update
Message-Id: <jDdS5c7c.1102494941.4279120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> For fan 1,
> my version of the datasheet shows 24 MHz for bit7 = 0.
> (24 MHz / 1) / 256 = 93.75 kHz
>
> fan 2 matches what you have below.
> go figure...

Correct. I had forgotten to divide by 256 anyway so my value wasn't
correct.

24MHz|180kHz makes much more sense since 24Mhz/127 (max pre-scale) is
188kHz i.e. right above 180kHz. 1Mhz|125kHz doesn't look as
intreresting since both clocks cover almost the same range of
frequencies. I'd say that 24Mhz|180kHz is more likely to be correct,
Winbond must have corrected the values in the datasheet for PWM1 and
forgotten to do the same for PWM2.

Just a guess though.

Thanks,
Jean
