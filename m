From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 05 Jun 2013 11:36:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: mc13783-adc: Refactor source to indicate various mc13xxx chips
Message-Id: <201306051336.49776.arnd@arndb.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <20130605125308.36ba40ab@endymion.delvare> <1370430879.384973987@f91.mail.ru>
In-Reply-To: <1370430879.384973987@f91.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 05 June 2013, Alexander Shiyan wrote:
> Well, let's leave the kconfig symbol as is. But about the rest, that mc13783_*
> symbols in the log (debug) will say a developer who does not know about
> mc13892 compatibility with mc13783? I still believe that this should be reflected.

If the log messages use dev_printk, they will use the correct device name already,
if not, that can be fixed.

I agree with Jean: we don't just rename things unless there is a significant
benefit, which I don't see here. There is also the risk that we need to support
a different chip named mc13xxx in the future that is different enough to require
a new driver and then the naming is even more screwed up.

	Arnd

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
