From: Xiangfu Liu <xiangfu.z@gmail.com>
Date: Mon, 21 Jun 2010 02:56:10 +0000
Subject: Re: [lm-sensors] [PATCH v2 00/26] Add support for the Ingenic
Message-Id: <4C1ED4CA.9030906@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <20100620092610.GA4950@alpha.franken.de>
In-Reply-To: <20100620092610.GA4950@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>, Anton Vorontsov <cbouatmailru@gmail.com>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Gortmaker <p_gortmaker@yahoo.com>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org, lm-sensors@lm-sensors.org, rtc-linux@googlegroups.com

On 06/20/2010 05:26 PM, Thomas Bogendoerfer wrote:
> great stuff. I have a JZ4730 based netbook, for which I started magling
> the provided sources quite some time ago, but I didn't reach the
> point of submitting patches... there are a lot of common stuff between
> JZ4730 and JZ4740 so IMHO it would be a good thing not to nail
> everthing to JZ4740 namewise. It might also a good idea to select
> something like arch/mips/jzrisc as base directory, put the

Hi Thomas

I would advice "xburst" instead jzrisc. because the Ingenic call
their cpu "XBurst" series. like: XBurst JZ4740, XBurst JZ4750 ...


> factored out code there and add JZ4730/JZ4740 in either seperate
> files or directories.


-- 
Best Regards
Xiangfu Liu
http://www.openmobilefree.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
