From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2007 19:12:00 +0000
Subject: Re: [lm-sensors] kernel TODO
Message-Id: <20070625211200.407411fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070624161439.GD3289@mars.solarsys.private>
In-Reply-To: <20070624161439.GD3289@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 24 Jun 2007 12:14:39 -0400, Mark M. Hoffman wrote:
> [PATCH] Apple SMC driver - fix input device
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019462.html
> status: update & resend, please
> 
> [PATCH 1/2] Apple SMC driver - standardize and sanitize sysfs tree + minor features addition
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019519.html
> [PATCH 2/2] Apple SMC driver - implement key enumeration
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019520.html
> status: update & resend, please

As far as I can see, these are all already upstream.

> [PATCH] applesmc - switch to using input-polldev
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019787.html
> status: needs respin to v2.6.22-rc5, wants to be picked for testing
> 
> [PATCH] ams - switch to using input-polldev
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019788.html
> status: wants reviewer

These are fundamentally input patches, in Dmitry Torokhov's realm. I
fail to see why you would bother with them.

> [PATCH] Add temperature-tracking mode to f71805f driver (v2)
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020079.html
> status: reviewed by Jean Delvare, needs update for email addresses

May need more than this: I reviewed the 1st version, not the second,
which is larger. Will do this evening or tomorrow morning.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
