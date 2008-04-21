From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Mon, 21 Apr 2008 11:54:13 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 2/5] lm75: add new-style driver
Message-Id: <200804211354.16630.laurentp@cse-semaphore.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7395992259969388902=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161030.12898.david-b@pacbell.net>
In-Reply-To: <200804161030.12898.david-b@pacbell.net>
To: lm-sensors@vger.kernel.org

--===============7395992259969388902==
Content-Type: multipart/signed; boundary="nextPart2277009.FDNd0ZD0I9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2277009.FDNd0ZD0I9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 20 April 2008 13:33, Jean Delvare wrote:
> Hi David,
>=20
> On Wed, 16 Apr 2008 10:30:12 -0700, David Brownell wrote:
> > Teach the LM75 driver how to use new-style driver binding:
> >=20
> >  - Create a second driver struct, using new-style driver binding methods
> >    cribbed from the legacy code.
> >=20
> >  - Make the legacy probe logic delegate all its work to this new code.
> >=20
> >  - The old driver struct was renamed as "lm75_legacy".
> >=20
> >  - Sensor limits are chip-specific; record them, and use them in new
> >    routines to interconvert temperature and register values.
> >=20
> >  - More careful initialization.  Chips are put into 9-bit mode so
> >    the current interconversion routines will never fail.
> >=20
> >  - Save the original chip configuration, and restore it on exit.
> >=20
> > A later patch updates those interconversion routines to support
> > higher resolution measurements on chips which support them.
> >=20
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> >  drivers/hwmon/Kconfig |    9 +-
> >  drivers/hwmon/lm75.c  |  191=20
+++++++++++++++++++++++++++++++++++++-------------
> >  2 files changed, 149 insertions(+), 51 deletions(-)
> >=20
>=20
> Out of the various comments I made back in September 2007, there's
> really only one which I have to repeat here. Let's say that the other
> ones were only nitpicking on my side.=20
>=20
> > (...)
> > --- a/drivers/hwmon/lm75.c
> > +++ b/drivers/hwmon/lm75.c
> > @@ -54,18 +54,19 @@ static const u8 LM75_REG_TEMP[3] =3D {
> > =20
> >  /* Each client has this additional data */
> >  struct lm75_data {
> > -	struct i2c_client	client;
> > +	struct i2c_client	*client;
> >  	struct device		*hwmon_dev;
> >  	struct mutex		update_lock;
> > +	long			min, max;
> > +	u8			orig_conf;
> >  	char			valid;		/* !=3D0 if registers are valid */
> >  	unsigned long		last_updated;	/* In jiffies */
> > -	u16			temp[3];	/* Register values,
> > +	s16			temp[3];	/* Register values,
> >  						   0 =3D input
> >  						   1 =3D max
> >  						   2 =3D hyst */
> >  };
> > =20
> > -static void lm75_init_client(struct i2c_client *client);
> >  static int lm75_read_value(struct i2c_client *client, u8 reg);
> >  static int lm75_write_value(struct i2c_client *client, u8 reg, u16=20
value);
> >  static struct lm75_data *lm75_update_device(struct device *dev);
> > @@ -75,13 +76,28 @@ static struct lm75_data *lm75_update_dev
> > =20
> >  /* sysfs attributes for hwmon */
> > =20
> > +static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
> > +{
> > +	if (temp < lm75->min)
> > +		temp =3D lm75->min;
> > +	else if (temp > lm75->max)
> > +		temp =3D lm75->max;
> > +
> > +	return LM75_TEMP_TO_REG(temp);
>=20
> This is inefficient. Your have already done half of what
> LM75_TEMP_TO_REG() does, so you're better copying the rest in your
> function.
>=20
> Alternatively, you could just move the addition of the min and max
> settings the next patch in the series, as I can't really see how they
> are related to converting the driver to new-style i2c. This would be in
> line with your own comment that my complaint is "addressed in the third
> patch".

Moving min and max support to the third patch seems indeed better.

> > +}
> > +
> > +static inline int reg_to_temp(s16 reg)
> > +{
> > +	return LM75_TEMP_FROM_REG(reg);
> > +}
> > +
> >  static ssize_t show_temp(struct device *dev, struct device_attribute *=
da,
> >  			 char *buf)
> >  {
> >  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> >  	struct lm75_data *data =3D lm75_update_device(dev);
> > -	return sprintf(buf, "%d\n",
> > -		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
> > +
> > +	return sprintf(buf, "%d\n", reg_to_temp(data->temp[attr->index]));
> >  }
> > =20
> >  static ssize_t set_temp(struct device *dev, struct device_attribute *d=
a,
> > @@ -94,7 +110,7 @@ static ssize_t set_temp(struct device *d
> >  	long temp =3D simple_strtol(buf, NULL, 10);
> > =20
> >  	mutex_lock(&data->update_lock);
> > -	data->temp[nr] =3D LM75_TEMP_TO_REG(temp);
> > +	data->temp[nr] =3D temp_to_reg(data, temp);
> >  	lm75_write_value(client, LM75_REG_TEMP[nr], data->temp[nr]);
> >  	mutex_unlock(&data->update_lock);
> >  	return count;

David, could you please resubmit the rest of the patch set rebased on the=20
latest version of your first patch ? I will apply 2/5 manually for now for=
=20
test purpose.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2277009.FDNd0ZD0I9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDIBo8y9gWxC9vpcRAn8OAJ0YWUie+zymLp4uOf+jm72jDLEw2QCgl3nI
DQDaGG+KYB602xEaPAy0EKo=
=acHd
-----END PGP SIGNATURE-----

--nextPart2277009.FDNd0ZD0I9--


--===============7395992259969388902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7395992259969388902==--
