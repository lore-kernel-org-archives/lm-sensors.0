From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 May 2010 20:57:50 +0000
Subject: Re: [lm-sensors] [PATCH] drivers: remove all
Message-Id: <20100531225750.0dc18950@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
	<20100531190911.GC30712@core.coreip.homeip.net>
In-Reply-To: <20100531190911.GC30712@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, George Joseph <george.joseph@fairview5.com>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Alessandro Rubini <rubini@cvml.unipv.it>, Richard Purdie <rpurdie@rpsys.net>, Colin Leroy <colin@colino.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Paul Gortmaker <p_gortmaker@yahoo.com>, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, rtc-linux@googlegroups.com, devel@driverdev.osuosl.org

Hi Dmitry,

On Mon, 31 May 2010 12:09:12 -0700, Dmitry Torokhov wrote:
> Frankly I'd prefer taking input stuff through my tree with the goal of
> .36 merge window just to minimize potential merge issues. This is a
> simple cleanup patch that has no dependencies, so there is little gain
> from doing it all in one go.

If I take the patch in my i2c tree, the aim is to merge it upstream
immediately, so merge issues won't exist.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
