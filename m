From: David Brownell <david-b@pacbell.net>
Date: Tue, 28 Oct 2008 10:43:03 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <200810280343.03800.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tuesday 28 October 2008, Kaiwan N Billimoria wrote:
> Hi,
>=20
> Got a chance to test this patch today..
> short answer: no it did not seem to work.

Well, then can you see what the issue is then?
The current mainline code is clearly buggy...


> I got readings with largish negative values (from /sys/.../temp1_input);
> have not really had the time to debug this..
>=20
> [Sorry have not pasted o/p here becoz i do the work on an office PC,
> where i built the 2.6.28-rc2 kernel & tried this; a bit misconfigured so
> graphics did not come up (hence no clipboard stuff)...
> Also, am writing this email off my notebook where i can't test the
> device as it has no parport.]
>=20
> Of course, in the first place, that's why the logic is the way it is.

I think there must be bugs covering up for each other...


> I can (re)confirm though that for the LM70 chip the temperature register
> is sent MSB first...

Right, which is why the lm70.c code should use the

> -=A0=A0=A0=A0=A0raw =3D (rxbuf[1] << 8) + rxbuf[0];
> +=A0=A0=A0=A0=A0raw =3D (rxbuf[0] << 8) + rxbuf[1];

So the question is then what *else* is going on (buggy)
that the previous code seemed to work despite that bug...

- Dave


> Let me know,
>=20
> -kaiwan.
>=20
> On Fri, 2008-10-24 at 02:21 -0700, David Brownell wrote:
>=20
> > I suspect the following should do the job ... it has
> > the parport based adapter leave the data in MSB-first
> > byte order, with the lm70 driver converting to CPU
> > byte order.  (In a way that will match the TMP121/123
> > support.)
> >=20
> > - Dave
> >=20
> > ---
> >  drivers/hwmon/lm70.c      |    4 +++-
> >  drivers/spi/spi_lm70llp.c |   19 +++----------------
> >  2 files changed, 6 insertions(+), 17 deletions(-)
> >=20
> > --- a/drivers/hwmon/lm70.c
> > +++ b/drivers/hwmon/lm70.c
> > @@ -67,7 +67,7 @@ static ssize_t lm70_sense_temp(struct de
> >  	}
> >  	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
> > =20
> > -	raw =3D (rxbuf[1] << 8) + rxbuf[0];
> > +	raw =3D (rxbuf[0] << 8) + rxbuf[1];
> >  	dev_dbg(dev, "raw=3D0x%x\n", raw);
> > =20
> >  	/*
> > @@ -109,6 +109,8 @@ static int __devinit lm70_probe(struct s
> >  	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
> >  		return -EINVAL;
> > =20
> > +	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
> > +
> >  	p_lm70 =3D kzalloc(sizeof *p_lm70, GFP_KERNEL);
> >  	if (!p_lm70)
> >  		return -ENOMEM;
> > --- a/drivers/spi/spi_lm70llp.c
> > +++ b/drivers/spi/spi_lm70llp.c
> > @@ -173,6 +173,8 @@ static void lm70_chipselect(struct spi_d
> >  {
> >  	struct spi_lm70llp *pp =3D spidev_to_pp(spi);
> > =20
> > +	/* REVISIT initialize the clock polarity ... */
> > +
> >  	if (value)
> >  		assertCS(pp);
> >  	else
> > @@ -184,22 +186,7 @@ static void lm70_chipselect(struct spi_d
> >   */
> >  static u32 lm70_txrx(struct spi_device *spi, unsigned nsecs, u32 word,=
 u8 bits)
> >  {
> > -	static u32 sio=3D0;
> > -	static int first_time=3D1;
> > -
> > -	/* First time: perform SPI bitbang and return the LSB of
> > -	 * the result of the SPI call.
> > -	 */
> > -	if (first_time) {
> > -		sio =3D bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
> > -		first_time=3D0;
> > -		return (sio & 0x00ff);
> > -	}
> > -	/* Return the MSB of the result of the SPI call */
> > -	else {
> > -		first_time=3D1;
> > -		return (sio >> 8);
> > -	}
> > +	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
> >  }
> > =20
> >  static void spi_lm70llp_attach(struct parport *p)
>=20
>=20
>=20



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
