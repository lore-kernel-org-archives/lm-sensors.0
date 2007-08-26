From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:50:46 +0000
Subject: Re: [lm-sensors] [PATCH] Add f75375s driver
Message-Id: <20070826185046.GJ3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070628230725.GA29698@kos.to>
In-Reply-To: <20070628230725.GA29698@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Riku:

* Riku Voipio <riku.voipio@iki.fi> [2007-08-24 13:03:09 +0300]:
> After diving deeper into mutexes, I eventually figured that the
> driver is already doing the correct thing. f75375_read16 is only
> called from f75375_update_device() while holding update mutex and
> from f75375_detect when we are reading static values. So just

I'll try to be more clear: the driver is making "best effort".  The remaining
possible race condition is if *the hardware itself* updates the 16-bit value
between the first and second read by the driver.

The mutex is there to keep the driver from racing with itself, but there's
nothing you can do to prevent the driver from racing with the hardware.
(AFAICT from reading the datasheet... see my original review comments.)

> document that. The rest of the issues Mark noticed have also
> been fixed.

Indeed.  Nice work too.

> From 7dcb7e2d5a685f438ef3ad3cd0f92f256629189d Mon Sep 17 00:00:00 2001
> From: Riku Voipio <riku.voipio@movial.fi>
> Date: Fri, 24 Aug 2007 10:46:18 +0300
> Subject: [PATCH] Add f75375s driver
> 
> Signed-off-by: Riku Voipio <riku.voipio@movial.fi>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
