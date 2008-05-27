From: David Brownell <david-b@pacbell.net>
Date: Tue, 27 May 2008 23:42:42 +0000
Subject: Re: [lm-sensors] Accelerometer,
Message-Id: <200805271642.42291.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <200805211753.39133.david-b@pacbell.net> <20080527155641.GB29868@linux.intel.com>
In-Reply-To: <20080527155641.GB29868@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mgross@linux.intel.com
Cc: spi-devel-general@lists.sourceforge.net, Jonathan Cameron <Jonathan.Cameron@gmail.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Tuesday 27 May 2008, mark gross wrote:
>=20
> > > Another problem area is around SPI itself. =A0There are variations of
> > > device implementations around chip select polarity, clock biasing
> > > (rising,falling, or midpoint) sampling from one SPI part to the next.
> >=20
> > Midpoint? =A0That's not one I've come across before. =A0All four
> > standard SPI clock/sample/shift modes are already supported
> > in the SPI framework though. =A0Ditto active-high chipselects
> > (vs normal active-low) etc.
>=20
> Yeah, its one of the sampling modes for the PIC18F4455 its one of the
> master mode sampling options =A0(see page 194 of
> http://ww1.microchip.com/downloads/en/DeviceDoc/39632D.pdf )

Actually figure 19-3 (p. 198) may be a bit more clear.

Curious.  That PIC18F controller has *three* bits ... equivalents
of CPOL and CPHA, plus a bit saying whether to wait a whole or
half clock after the leading clock edge before sampling it.

A quick survey of some other SPI chips suggests that the most
conventional interpretation is to sample on the trailing edge
of the clock, and not presume long hold times.

I would surely hope the SPI interface spec doesn't have to get
into the mess of timing variations which typify anyone trying to
make memory controllers do the Right thing ... *shudder* ...

- Dave



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
