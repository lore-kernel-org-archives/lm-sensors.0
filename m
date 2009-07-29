From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 29 Jul 2009 22:32:23 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] spi: Add support for device table
Message-Id: <20090729223223.GA15280@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
 <20090729170457.GA4803@oksana.dev.rtsoft.ru>
 <20090729214446.GB1728@fluff.org.uk>
In-Reply-To: <20090729214446.GB1728@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Wed, Jul 29, 2009 at 10:44:46PM +0100, Ben Dooks wrote:
[...]
> > +	const struct spi_device_id *id_table;
> > +	int			(*probe_id)(struct spi_device *spi,
> > +					    const struct spi_device_id *id);
> 
> how about leaving it at just probe and have either a call or a field
> in the device that you can look at to see if this was a new style of
> call?

There are no technical difficulties with that, but it would be
inconsitent wrt other "device table"-aware buses (i2c, pci, of).

Note that I'm getting rid of probe_id function in patch 5/7, as a
cleanup step. I want to keep "new features" and "api cleanups"
separate. That way it's easier to review the changes.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
