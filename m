From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 21 Jan 2010 15:45:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add driver for ADT7411
Message-Id: <20100121154502.GD3738@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0096198034954217027=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
To: lm-sensors@vger.kernel.org


--===============0096198034954217027==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

some questions arouse:

> > +static int __devinit adt7411_probe(struct i2c_client *client,
> > +				   const struct i2c_device_id *id)
> > +{
> > +	int val;
> > +	struct adt7411_data *data;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DAT=
A))
> > +		return -ENODEV;
> > +
> > +	val =3D i2c_smbus_read_byte_data(client, ADT7411_REG_MANUFACTURE_ID);
> > +	if (val < 0 || val !=3D ADT7411_MANUFACTURE_ID) {
> > +		dev_err(&client->dev, "Wrong manufacturer ID. Got %d, "
> > +			"expected %d\n", val, ADT7411_MANUFACTURE_ID);
> > +		return -ENODEV;
> > +	}
> > +
> > +	val =3D i2c_smbus_read_byte_data(client, ADT7411_REG_DEVICE_ID);
> > +	if (val < 0 || val !=3D ADT7411_DEVICE_ID) {
> > +		dev_err(&client->dev, "Wrong device ID. Got %d, "
> > +			"expected %d\n", val, ADT7411_DEVICE_ID);
> > +		return -ENODEV;
> > +	}
>=20
> This is the wrong place for this check. Device identification goes into
> a .detect() function. By the time .probe() is called, you already know
> what device is there.

Just came to think of it: That essentially kills all sanity checks for plat=
form
devices (or static board_infos), or am I wrong? Would it be an idea to call
detect() for the address in the board_info, or are board_infos considered p=
er
se correct?

> > +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&data->lsb_msb_lock);
> > +
> > +	data->config[0] =3D ADT7411_CFG1_START_MONITOR | ADT7411_CFG1_RESERVE=
D1;
> > +	data->config[1] =3D ADT7411_CFG2_ENABLE_SMBUS_TO;
> > +	data->config[2] =3D ADT7411_CFG3_RESERVED1 | ADT7411_CFG3_REF_VDD;
> > +
> > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG2, ADT7411_CFG2_RESE=
T);
> > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG2, data->config[1]);
> > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG3, data->config[2]);
> > +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1, data->config[0]);
>=20
> This is bad practice. The BIOS/firmware might have setup the chip
> already. Resetting and then overwriting this configuration is bad. If
> you want to enforce a specific setup, this is a platform decision and
> you should provide the initialization data as platform data.

I assume ORing ADT7411_CFG1_START_MONITOR is OK, though? What about
ADT7411_CFG2_ENABLE_SMBUS_TO (SMBus Timeout)? Is this a user preference or a
driver trying to keep his bus alive?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktYdn4ACgkQD27XaX1/VRuAEACdE39rg2UAx/wjcrXNWXqiVXby
PwoAnA+ZT0Obq/LFK4gcCxunUyTTvwYf
=xy9Z
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--


--===============0096198034954217027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0096198034954217027==--
