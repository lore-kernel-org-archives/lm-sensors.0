From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 30 Jul 2009 02:12:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] spi: Add support for device table
Message-Id: <20090730021250.GA12001@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
 <20090729170457.GA4803@oksana.dev.rtsoft.ru>
 <20090729214446.GB1728@fluff.org.uk>
 <20090729223223.GA15280@oksana.dev.rtsoft.ru>
 <20090729224050.GA17902@oksana.dev.rtsoft.ru>
In-Reply-To: <20090729224050.GA17902@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Thu, Jul 30, 2009 at 02:40:50AM +0400, Anton Vorontsov wrote:
[...]
> - If you don't store "id" in the device struct, you'll have
>   to look up the device table twice (at first during bus->match(),
>   and second time in drivers' probe() hook, i.e.
>   probe(struct bus_dev *dev) {
>   	id = bus_get_devid(dev); /* here */
>   }

Hm... actually, we're doing this anyway, but in spi core.

So, doing something like spi_get_device_id() might be a good
idea.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
