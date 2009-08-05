From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 05 Aug 2009 01:06:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] spi: Add support for device table
Message-Id: <20090805010620.GB14451@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
 <20090729170457.GA4803@oksana.dev.rtsoft.ru>
 <20090729214446.GB1728@fluff.org.uk>
 <200908031921.23126.david-b@pacbell.net>
In-Reply-To: <200908031921.23126.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Brownell <david-b@pacbell.net>
Cc: Ben Dooks <ben-linux@fluff.org>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Mon, Aug 03, 2009 at 07:21:22PM -0700, David Brownell wrote:
> On Wednesday 29 July 2009, Ben Dooks wrote:
> > >  struct spi_driver {
> > > +     const struct spi_device_id *id_table;
> > > +     int                     (*probe_id)(struct spi_device *spi,
> > > +                                         const struct spi_device_id *id);
> > 
> > how about leaving it at just probe and have either a call or a field
> > in the device that you can look at to see if this was a new style of
> > call?
> > 
> > >       int                     (*probe)(struct spi_device *spi);
> 
> For the record, if this is going to happen I think the
> appropriate long-term solution is to have probe() take
> the device_id just as it does with other busses.

Just curious. Why you prefer another argument in the probe()
instead of calling some helper function? Most drivers don't
need the "id" argument, so why spend memory and cpu cycles
for it?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
