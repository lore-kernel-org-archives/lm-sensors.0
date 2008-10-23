From: David Brownell <david-b@pacbell.net>
Date: Thu, 23 Oct 2008 17:46:29 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <200810231046.30116.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thursday 23 October 2008, Jean Delvare wrote:
>=20
> > For SPI, everything is MSB first ... else insist (spi->mode & SPI_LSB_F=
IRST)
> > is true. =A0Please strike the comment implying it might not be MSB firs=
t.
>=20
> Except that the LM70 transmits the LSB first, so it seems valuable to
> underline that the TMP121 behaves differently.

If true, then this driver has a bug ... it should require
SPI_LSB_FIRST as well as SPI_3WIRE in spi->mode, for lm70.

But no, I checked the data sheet and it shows MSB first.
See the table in section 1.5.2 (MSB =3D D15) and the figures
in section 2 (D15 first).


See what confusion comes from implying things which are
contrary-to-fact?  :)

- Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
