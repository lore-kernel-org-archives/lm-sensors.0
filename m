From: timo-news@tee-en.net (Timo Neuvonen)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Intel D865GLC
Message-Id: <cul6q4$h7d$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cui0st$i6r$1@sea.gmane.org>
In-Reply-To: <cui0st$i6r$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > stable reading of 1.500 anyway -from day to day. It's not exactly the

> > too. The slight difference (1.494 in bios) _could_ be caused by

> The LSB of that input voltage channel is worth 0.008V, so
> the slightest change could result in the different reading.
>
This difference is obviously caused by software and different rounding
algorithms, because the difference shown (1.500-1.494=0.006V) was less than
the electrical resolution of the ad converter.
Stupid me, didn't check the resolution from AD's datasheet although was
wondering how much it might be. And I'm not an IT professional but
analog/mixed signal electronics designer with long experience... I'm shamed
:-(


> 2* You use a recent kernel and a not-so-recent lm_sensors.
> For a 2.6.9-rc1 or higher kernel, you need lm_sensors
> 2.8.8 or higher.
>
That's propably the problem. Kernel is 2.6.10-1.
I need to check if there is already a newer rpm for FC3, I try to live with
rpm binary packages whenever possible.

Thank you very much for all the advice!

--
Timo

