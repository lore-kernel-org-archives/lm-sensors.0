From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 11 Jun 2011 15:35:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1668) Add support for
Message-Id: <20110611153531.GA26275@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110611112818.670e5db8@endymion.delvare>
In-Reply-To: <20110611112818.670e5db8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Jun 11, 2011 at 05:28:18AM -0400, Jean Delvare wrote:
> Hi Guenter,
>=20
> On Thu, 9 Jun 2011 18:14:07 -0700, Guenter Roeck wrote:
> > MAX1668 and compatibles have several external temperature sensors, but =
only
> > a single FAULT status bit. If a fault occurs, the temperature reported =
on
> > affected sensors is 127 degrees C. Use this knowledge to report faults =
on
> > individual external sensors.
> >=20
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Tested with MAX1668 with one sensor disconnected. Resulting output is a=
s follows.
> > Seems to be better than just reporting extra-high temperature.
>=20
> Looks overall good.
>=20
> Acked-by: Jean Delvare <khali@linux-fr.org>
>=20
> Minor comments below if you are interested.
>=20
I am, see below. Thanks a lot for the review!

> As a side note, it seems that
> http://git.kernel.org/?p=3Dlinux/kernel/git/groeck/staging.git;a=3Dcommit=
;h=AF2dcfe730577d5399973a4df648190f5562b470
> doesn't properly credit David as being the original author of the
> commit.
>=20
One of those cases where "git am" didn't work and I had to apply the patch =
manually.
I'll fix it. One of those days I'll have to figure out how to apply such=20
patches without having to revert to "patch".

> >=20
> > root@groeck-desktop# sensors
> > max1668-i2c-5-18
> > Adapter: i2c-devantech-iss at bus 001 device 007
> > temp1:        +23.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > temp2:        +25.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > temp3:        +25.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > temp4:        +25.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > temp5:          FAULT  (low  =3D -55.0=B0C, high =3D +127.0=B0C)    ALA=
RM(MAX)
> >=20
> >  drivers/hwmon/max1668.c |   26 +++++++++++++++++++++++++-
> >  1 files changed, 25 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> > index ddefb64..af85d44 100644
> > --- a/drivers/hwmon/max1668.c
> > +++ b/drivers/hwmon/max1668.c
> > @@ -123,7 +123,7 @@ static struct max1668_data *max1668_update_device(s=
truct device *dev)
> >  		goto abort;
> >  	}
> >  	data->alarms &=3D 0x00ff;
> > -	data->alarms |=3D ((u8) (val & 0x60)) << 8;
> > +	data->alarms |=3D ((u8) (val & 0x70)) << 8;
>=20
> The (u8) type cast doesn't seem needed. Same a few lines below for
> MAX1668_REG_STAT2.
>=20
Actually, turns out that
	data->alarms =3D val << 8;
followed by
	data->alarms |=3D val;
for MAX1668_REG_STAT2 is good enough.

> > =20
> >  	val =3D i2c_smbus_read_byte_data(client, MAX1668_REG_STAT2);
> >  	if (unlikely(val < 0)) {
> > @@ -189,6 +189,19 @@ static ssize_t show_alarm(struct device *dev, stru=
ct device_attribute *attr,
> >  	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
> >  }
> > =20
> > +static ssize_t show_fault(struct device *dev,
> > +			  struct device_attribute *devattr, char *buf)
> > +{
> > +	int index =3D to_sensor_dev_attr(devattr)->index;
> > +	struct max1668_data *data =3D max1668_update_device(dev);
> > +
> > +	if (IS_ERR(data))
> > +		return PTR_ERR(data);
> > +
> > +	return sprintf(buf, "%d\n",
>=20
> %u would probably make more sense, as this is used for alarms above.
> But I agree %d will work too.
>=20
Still more consistent. I changed it.

> > +		       (data->alarms & (1 << 12)) && data->temp[index] =3D 127);
> > +}
> > +
> >  static ssize_t set_temp_max(struct device *dev,
> >  			    struct device_attribute *devattr,
> >  			    const char *buf, size_t count)
> > @@ -276,6 +289,11 @@ static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO=
, show_alarm, NULL, 2);
> >  static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO, show_alarm, NULL, =
1);
> >  static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, =
0);
> > =20
> > +static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_fault, NULL, 1);
> > +static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_fault, NULL, 2);
> > +static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_fault, NULL, 3);
> > +static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_fault, NULL, 4);
> > +
> >  /* Attributes common to MAX1668, MAX1989 and MAX1805 */
> >  static struct attribute *max1668_attribute_common[] =3D {
> >  	&sensor_dev_attr_temp1_max.dev_attr.attr,
> > @@ -294,6 +312,9 @@ static struct attribute *max1668_attribute_common[]=
 =3D {
> >  	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
> >  	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
> >  	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
> > +
> > +	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> > +	&sensor_dev_attr_temp3_fault.dev_attr.attr,
> >  	NULL
> >  };
> > =20
> > @@ -310,6 +331,9 @@ static struct attribute *max1668_attribute_unique[]=
 =3D {
> >  	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
> >  	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
> >  	&sensor_dev_attr_temp5_min_alarm.dev_attr.attr,
> > +
> > +	&sensor_dev_attr_temp4_fault.dev_attr.attr,
> > +	&sensor_dev_attr_temp5_fault.dev_attr.attr,
> >  	NULL
> >  };
> > =20
>=20
>=20
> --=20
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
