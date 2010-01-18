From: Wolfram Sang <w.sang@pengutronix.de>
Date: Mon, 18 Jan 2010 15:02:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add driver for ADT7411
Message-Id: <20100118150257.GB4288@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1810639380060869093=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
To: lm-sensors@vger.kernel.org


--===============1810639380060869093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > I polished up an older driver from us. Hope I didn't overlook some issu=
es...
>=20
> Review:

Seems like it was a bad first try, after all :(

> It seems to me that you are only using a small subset of the registers
> defined above. I suggest not defining registers you don't use, as it
> only makes the code bigger with no benefit. The datasheet of this chip
> is publicly available, if anybody needs a reference.

The intention was to spare other people copying this data again, but I get =
your
point and agree.

> Logic seems overly complex. Do you have such an unreliable I2C bus that
> transient failures are frequent?

The customer had a very "hostile" environment, so this was needed. It could=
 be
rated as a special extension and dropped, of course. I saw it in some other
drivers (lm93) and wasn't sure about the preferred way.

> > +	u8 lsb_reg =3D ADT7411_REG_EXT_TEMP_AIN14_LSB + (nr >> 2);
> > +	u8 lsb_shift =3D (nr & 0x03) << 1;
>=20
> "2 * (nr & 0x03)" would be easier to understand.

Really? Will do, but when it comes to registers and bit positions, I like
shifting better.

> > +static ssize_t adt7411_set_bit(struct device *dev, struct device_attri=
bute *attr,
> > +			     const char *buf, size_t count)
> > +{
> > +	struct sensor_device_attribute_2 *s_attr2 =3D to_sensor_dev_attr_2(at=
tr);
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct adt7411_data *data =3D i2c_get_clientdata(client);
> > +	int reg, bit, ret;
> > +	unsigned long val;
> > +
> > +	ret =3D strict_strtoul(buf, 0, &val);
> > +
> > +	if (ret || val > 1)
> > +		return -EINVAL;
> > +
> > +	reg =3D s_attr2->index;
> > +	bit =3D s_attr2->nr;
> > +
> > +	if (val)
> > +		data->config[reg] |=3D bit;
> > +	else
> > +		data->config[reg] &=3D ~bit;
> > +
> > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1 + reg,
> > +		data->config[reg]);
> > +	return count;
> > +}
>=20
> This assumes that nobody else ever changes the configuration registers.
> That's an unsafe assumption... Not only external users of the chip
> could (think multi-master I2C setups) but even concurrent users of your
> own driver could! So you want to read the register value instead of
> relying on a cached value. And if you want to keep a cache (which
> doesn't seem terribly needed to me),you also want to protect the
> read-modify-write operation with a mutex.

Right, but the mutex is needed for the non-cached I2C-based RMW, too, no?

Rest is also accepted, of course. Thanks for the review!

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktUeCEACgkQD27XaX1/VRskPgCgupOkbmZyetPBjCm+KpNW/UU+
EfoAn29pc85LJKCZjI7WROX6eUDHbOf9
=NZ+D
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


--===============1810639380060869093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1810639380060869093==--
