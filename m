From: David Brownell <david-b@pacbell.net>
Date: Tue, 04 Aug 2009 02:21:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] spi: Add support for device table
Message-Id: <200908031921.23126.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru> <20090729170457.GA4803@oksana.dev.rtsoft.ru> <20090729214446.GB1728@fluff.org.uk>
In-Reply-To: <20090729214446.GB1728@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ben Dooks <ben-linux@fluff.org>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Wednesday 29 July 2009, Ben Dooks wrote:
> > =A0struct spi_driver {
> > +=A0=A0=A0=A0=A0const struct spi_device_id *id_table;
> > +=A0=A0=A0=A0=A0int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0(*probe_id)(struct spi_device *spi,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0const struct spi_device_i=
d *id);
>=20
> how about leaving it at just probe and have either a call or a field
> in the device that you can look at to see if this was a new style of
> call?
>=20
> > =A0=A0=A0=A0=A0=A0int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0(*probe)(struct spi_device *spi);

For the record, if this is going to happen I think the
appropriate long-term solution is to have probe() take
the device_id just as it does with other busses.

Of course that involves changing *every* SPI driver...
and I'd rather not do that quite yet.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
