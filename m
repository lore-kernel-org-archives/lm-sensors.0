From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 29 Jul 2009 22:40:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] spi: Add support for device table
Message-Id: <20090729224050.GA17902@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
 <20090729170457.GA4803@oksana.dev.rtsoft.ru>
 <20090729214446.GB1728@fluff.org.uk>
 <20090729223223.GA15280@oksana.dev.rtsoft.ru>
In-Reply-To: <20090729223223.GA15280@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Thu, Jul 30, 2009 at 02:32:23AM +0400, Anton Vorontsov wrote:
> On Wed, Jul 29, 2009 at 10:44:46PM +0100, Ben Dooks wrote:
> [...]
> > > +	const struct spi_device_id *id_table;
> > > +	int			(*probe_id)(struct spi_device *spi,
> > > +					    const struct spi_device_id *id);
> > 
> > how about leaving it at just probe and have either a call or a field
> > in the device that you can look at to see if this was a new style of
> > call?
> 
> There are no technical difficulties with that, but it would be
> inconsitent wrt other "device table"-aware buses (i2c, pci, of).

Btw, I guess there are few reasons why other buses pass id via
probe() call:

- You'll have to store the "id" in device struct forever, while
  in most cases you only need it during probe(), then you don't
  need it at all;

- If you don't store "id" in the device struct, you'll have
  to look up the device table twice (at first during bus->match(),
  and second time in drivers' probe() hook, i.e.
  probe(struct bus_dev *dev) {
  	id = bus_get_devid(dev); /* here */
  }

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
