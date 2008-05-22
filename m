From: David Brownell <david-b@pacbell.net>
Date: Thu, 22 May 2008 00:53:38 +0000
Subject: Re: [lm-sensors] Accelerometer,
Message-Id: <200805211753.39133.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080520175041.GA30909@linux.intel.com>
In-Reply-To: <20080520175041.GA30909@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mgross@linux.intel.com
Cc: spi-devel-general@lists.sourceforge.net, Jonathan Cameron <Jonathan.Cameron@gmail.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Tuesday 20 May 2008, mark gross wrote:
> > ST Micro LIS3L02DQ 3D accelerometer. =A0...
>=20
> FWIW: I have this device talking to a PIC-18 and pushing the results
> over the serial port.

Jonathan neglected to mention that he's already sent a driver
for this to the SPI list.  ;)

Which is part of the reason for asking this question.  Right
now that driver sits in drivers/spi/lis3l02dq.c but that is
probably not its best long-term domicile.


> WRT linux support, I can't think of a generalized way to create a driver
> that would be able to be used with this device in Linux. =A0You need to
> know witch IRQ line the DR line is connected too, and if you are
> bit-banging the SPI data off the thing, then you need to know which
> GPIO's of the host CPU you'll be using. =A0If you have SPI hardware then
> you need to know where to pull the data from. =A0The problem doesn't seem=
 to
> generalize well.

I guess I don't follow.  The SPI framework handles all that
stuff already, even if you're bitbanging.  Though to be
sure, if you're bitbanging SPI you want your platform to
be able to inline those GPIO calls so those inner loops
only take a few instructions per bit ... also solved!  :)


> Also, If you are playing with accelerometer data, you likely need some
> real time support or at lest a reliable time stamping of the data to do
> anything interesting.

True.  I imagine a few other such issues will appear once
more folk than Jonathan are using these sorts of sensors
on Linux.  I'd expect the sample stream to have internal
timestamps for truly critical systems, unless variability
in when the host makes timestamps is not really an issue.
=20

> Another problem area is around SPI itself. =A0There are variations of
> device implementations around chip select polarity, clock biasing
> (rising,falling, or midpoint) sampling from one SPI part to the next.

Midpoint?  That's not one I've come across before.  All four
standard SPI clock/sample/shift modes are already supported
in the SPI framework though.  Ditto active-high chipselects
(vs normal active-low) etc.

- Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
