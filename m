From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 31 May 2010 19:09:12 +0000
Subject: Re: [lm-sensors] [PATCH] drivers: remove all
Message-Id: <20100531190911.GC30712@core.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, George Joseph <george.joseph@fairview5.com>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Alessandro Rubini <rubini@cvml.unipv.it>, Richard Purdie <rpurdie@rpsys.net>, Colin Leroy <colin@colino.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Paul Gortmaker <p_gortmaker@yahoo.com>, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, rtc-linux@googlegroups.com, devel@driverdev.osuosl.org

Hi Wolfram,

On Mon, May 31, 2010 at 02:55:48PM +0200, Wolfram Sang wrote:
> I2C-drivers can use the clientdata-pointer to point to private data. As I2C
> devices are not really unregistered, but merely detached from their driver, it
> used to be the drivers obligation to clear this pointer during remove() or a
> failed probe(). As a couple of drivers forgot to do this, it was agreed that it
> was cleaner if the i2c-core does this clearance when appropriate, as there is
> no guarantee for the lifetime of the clientdata-pointer after remove() anyhow.
> This feature was added to the core with commit
> e4a7b9b04de15f6b63da5ccdd373ffa3057a3681 to fix the faulty drivers.
> 
> As there is no need anymore to clear the clientdata-pointer, remove all current
> occurrences in the drivers to simplify the code and prevent confusion.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> 
> Some more notes:
> 
> I waited for rc1 as I knew there were some drivers/patches coming along which
> needed to be processed, too.
> 
> I'd suggest that this goes via the i2c-tree, so we get rid of all occurences at
> once.
> 

Frankly I'd prefer taking input stuff through my tree with the goal of
.36 merge window just to minimize potential merge issues. This is a
simple cleanup patch that has no dependencies, so there is little gain
from doing it all in one go.

Thanks.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
