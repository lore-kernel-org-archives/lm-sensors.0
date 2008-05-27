From: mark gross <mgross@linux.intel.com>
Date: Tue, 27 May 2008 15:56:41 +0000
Subject: Re: [lm-sensors] Accelerometer,
Message-Id: <20080527155641.GB29868@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080520175041.GA30909@linux.intel.com> <200805211753.39133.david-b@pacbell.net>
In-Reply-To: <200805211753.39133.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Brownell <david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, Jonathan Cameron <Jonathan.Cameron@gmail.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, May 21, 2008 at 05:53:38PM -0700, David Brownell wrote:
> On Tuesday 20 May 2008, mark gross wrote:
> > > ST Micro LIS3L02DQ 3D accelerometer. =A0...
> >=20
> > FWIW: I have this device talking to a PIC-18 and pushing the results
> > over the serial port.
>=20
> Jonathan neglected to mention that he's already sent a driver
> for this to the SPI list.  ;)
>=20
> Which is part of the reason for asking this question.  Right
> now that driver sits in drivers/spi/lis3l02dq.c but that is
> probably not its best long-term domicile.
>=20
>=20
> > WRT linux support, I can't think of a generalized way to create a driver
> > that would be able to be used with this device in Linux. =A0You need to
> > know witch IRQ line the DR line is connected too, and if you are
> > bit-banging the SPI data off the thing, then you need to know which
> > GPIO's of the host CPU you'll be using. =A0If you have SPI hardware then
> > you need to know where to pull the data from. =A0The problem doesn't se=
em to
> > generalize well.
>=20
> I guess I don't follow.  The SPI framework handles all that
> stuff already, even if you're bitbanging.  Though to be
> sure, if you're bitbanging SPI you want your platform to
> be able to inline those GPIO calls so those inner loops
> only take a few instructions per bit ... also solved!  :)
>

I'll take a look sometime soon.
=20
>=20
> > Also, If you are playing with accelerometer data, you likely need some
> > real time support or at lest a reliable time stamping of the data to do
> > anything interesting.
>=20
> True.  I imagine a few other such issues will appear once
> more folk than Jonathan are using these sorts of sensors
> on Linux.  I'd expect the sample stream to have internal
> timestamps for truly critical systems, unless variability
> in when the host makes timestamps is not really an issue.
> =20

Its on my list of things to do..

>=20
> > Another problem area is around SPI itself. =A0There are variations of
> > device implementations around chip select polarity, clock biasing
> > (rising,falling, or midpoint) sampling from one SPI part to the next.
>=20
> Midpoint?  That's not one I've come across before.  All four
> standard SPI clock/sample/shift modes are already supported
> in the SPI framework though.  Ditto active-high chipselects
> (vs normal active-low) etc.

Yeah, its one of the sampling modes for the PIC18F4455 its one of the
master mode sampling options  (see page 194 of
http://ww1.microchip.com/downloads/en/DeviceDoc/39632D.pdf )

--mgross


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
