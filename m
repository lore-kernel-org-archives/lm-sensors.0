From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH] libsensors (chips.c, chips.h) update for 2.6.X lm85 fan
Message-Id: <20041120103843.2c86faf9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041004201808.GF22290@penguincomputing.com>
In-Reply-To: <20041004201808.GF22290@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Justin,

Sorry for the delay...

> Here is a patch for lm_sensors/lib/chips.h and lm_sensors/lib/chips.c
> to update the lm85 entries and keep them in step with the patch for
> lm85 fan control in the 2.6.X lm85 driver.
> 
> Again, feedback appreciated.

Hm, now that your kernel patch is in 2.6, I guess we want to apply this?

I don't think that the patch is quite correct though.

First, I think that your changes break the compatibility with the 2.4
driver. You have to extend, not replace, the existing entries. See the
head of chips.c for hints, or other driver entries in the same file.

Second, I'd prefer a path to chips.h which doesn't realign things. I
understand you did if for the beauty of it all, but it makes my
reviewing work harder. This isn't a problem if all values aren't exactly
aligned.

Thanks.

Jean
