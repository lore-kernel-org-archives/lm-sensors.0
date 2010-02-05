From: Wolfram Sang <w.sang@pengutronix.de>
Date: Fri, 05 Feb 2010 23:49:43 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: add driver for ADT7411 voltage &
Message-Id: <20100205234943.GA32589@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1922227163529333754=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
To: lm-sensors@vger.kernel.org


--===============1922227163529333754==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I don't quite get why adt7411_read_vdd() is responsible for updating
> data->next_update, while it doesn't make use of its value.
> data->next_update is only used by adt7411_show_input() so it would make
> more sense to set it there too. It would be more flexible, as you could
> decide that the cache (the lifetime of which is controlled by
> data->next_update) includes both the value of vdd and the value of
> ref_is_vdd. This would avoid reading vdd when you don't need it, and
> guarantee that you never use uninitialized values.

I had the idea that reading vdd via sysfs should also update the cache. Try=
ing
to do this and reorganizing the code to solve some chicken-and-egg-problem
regarding the cache, it seems I stumbled over my own feet.

I implemented it according to your suggestions and it looks cleaner, in dee=
d. I
just had to drop the idea that reading vdd from sysfs also updates the cach=
e,
as I would now need another lock for it which I think is not worth the trou=
ble.

> > +static ssize_t adt7411_set_bit(struct device *dev, struct device_attri=
bute *attr,
> > +			     const char *buf, size_t count)
> > +{
> > +	struct sensor_device_attribute_2 *s_attr2 =3D to_sensor_dev_attr_2(at=
tr);
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	int ret;
> > +	unsigned long flag;
> > +
> > +	ret =3D strict_strtoul(buf, 0, &flag);
> > +	if (ret || flag > 1)
> > +		return -EINVAL;
> > +
> > +	ret =3D adt7411_modify_bit(client, s_attr2->index, s_attr2->nr, flag);
> > +	return ret < 0 ? ret : count;
> > +}
>=20
> Calling the above function should invalidate the cache. At least
> changing adc_ref_vdd makes the cached value data->adc_ref_vdd wrong,
> and presumably the other settings may also affect the value of
> data->vdd_cached. As I don't expect the user to change the settings
> frequently, there's probably no point in trying to be smart.

I hate this driver, it makes me look pretty stupid :/

I already made a V3 and will probably send it on Monday after some testing =
with
the hardware.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktsrpcACgkQD27XaX1/VRt/SgCeMb33BZezeQNwDhE+8lcVU5rx
sOwAoKxNIBDND7VUL1lO5hurWJQpNowO
=F2Ab
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--


--===============1922227163529333754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1922227163529333754==--
