From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Oct 2008 17:53:34 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081023195334.240014c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 23 Oct 2008 10:46:29 -0700, David Brownell wrote:
> On Thursday 23 October 2008, Jean Delvare wrote:
> >=20
> > > For SPI, everything is MSB first ... else insist (spi->mode & SPI_LSB=
_FIRST)
> > > is true. =A0Please strike the comment implying it might not be MSB fi=
rst.
> >=20
> > Except that the LM70 transmits the LSB first, so it seems valuable to
> > underline that the TMP121 behaves differently.
>=20
> If true, then this driver has a bug ... it should require
> SPI_LSB_FIRST as well as SPI_3WIRE in spi->mode, for lm70.
>=20
> But no, I checked the data sheet and it shows MSB first.
> See the table in section 1.5.2 (MSB =3D D15) and the figures
> in section 2 (D15 first).
>=20
>=20
> See what confusion comes from implying things which are
> contrary-to-fact?  :)

I didn't assume anything, I simply read the code:

+	switch (p_lm70->chip) {
+	case LM70_CHIP_LM70:
+		raw =3D (rxbuf[1] << 8) + rxbuf[0];
+		val =3D ((int)raw/32) * 250;
+		break;
+
+	case LM70_CHIP_TMP121:
+		raw =3D (rxbuf[0] << 8) + rxbuf[1];
+		val =3D (raw / 8) * 625 / 10;
+		break;
+	}

Does it look to you like both chips expect the same byte order? Me not.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
