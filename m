From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 12 Aug 2009 04:12:55 +0000
Subject: Re: [lm-sensors] [PATCH 4/7] spi: Prefix modalias with "spi:"
Message-Id: <8bd0f97a0908112112m2e97c71do722199fdce476231@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru> <20090729170510.GD4803@oksana.dev.rtsoft.ru>
In-Reply-To: <20090729170510.GD4803@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Wed, Jul 29, 2009 at 13:05, Anton Vorontsov wrote:
> This makes it consistent with other buses (platform, i2c, vio, ...).
> I'm not sure why we use the prefixes, but there must be a reason.
>
> This was easy enough to do it, and I did it.

acked-by-me for misc blackfin/adi drivers, thanks
-mike

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
