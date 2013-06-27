From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Jun 2013 17:12:51 +0000
Subject: Re: [lm-sensors] [lm-sensors 1/2] hwmon: (ds1621) Add ds1721 chip support
Message-Id: <20130627171251.GA9132@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jun 27, 2013 at 04:50:05PM +0200, Jean Delvare wrote:
> On Thu, 27 Jun 2013 07:31:25 -0700, Guenter Roeck wrote:
> > On Thu, Jun 27, 2013 at 10:36:31AM +0200, Jean Delvare wrote:
> > > I'm once again late, but I could not find the time to test your ds1621
> > > patches before today.
> > >=20
> > > On Wed, 8 May 2013 22:45:53 -0700, Robert Coulson wrote:
> > > > --- a/drivers/hwmon/ds1621.c
> > > > +++ b/drivers/hwmon/ds1621.c
> > > > (...)
> > > > +/*
> > > > + * TEMP: 0.001C/bit (-55C to +125C)
> > > > + * REG:
> > > > + *  - 1621, 1625: x =3D 0.5C
> > > > + *  - 1721:       x =3D 0.0625C
> > > > + * Assume highest resolution and let the bits fall where they may..
> > > > + */
> > > > +static inline u16 DS1621_TEMP_TO_REG(long temp)
> > > > +{
> > > > +	int ntemp =3D clamp_val(temp, DS1621_TEMP_MIN, DS1621_TEMP_MAX);
> > > > +	ntemp +=3D (ntemp < 0 ? -31 : 31);
> > > > +	ntemp =3D DIV_ROUND_CLOSEST(ntemp * 10, 625) << 4;
> > > > +	return (u16)ntemp;
> > > > +}
> > >=20
> > > This breaks limit rounding on the DS1621. Limits have a resolution of
> > > 0.5=B0C on that chip, so limit values should rounded to the closest
> > > half-degree. It used to work but no longer: if I write 20300 to
> > > temp1_min, it is rounded down to 20000, while it should be rounded up
> > > to 20500.
> > >=20
> > My fault, since I proposed that approach. Didn't I have the same problem
> > with some other driver ? Makes it even worse. I'll have to look up my n=
otes.
>=20
> Yes I am almost certain we discussed this very topic for another driver
> recently, I think it was tmp401.
>=20
You are right.

Can you test the following patch ? It follows the logic implemented in the
tmp401 driver.

Thanks,
Guenter

---
From 007a7f590ae0e34368314f2acd9574aa2e701505 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Jun 2013 10:07:19 -0700
Subject: [PATCH] hwmon: (ds1621) Fix temperature rounding operations

Commit "hwmon: (ds1621) Add ds1721 chip support" broke rounding
for chips or configurations with less than 12 bit resolution.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ds1621.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 317f683..9192225 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -128,6 +128,8 @@ struct ds1621_data {
=20
 	u16 temp[3];			/* Register values, word */
 	u8 conf;			/* Register encoding, combined */
+	u8 zbits;			/* Resolution encoded as number of
+					 * zero bits */
 	u16 update_interval;		/* Conversion rate in milliseconds */
 };
=20
@@ -139,16 +141,14 @@ static inline int DS1621_TEMP_FROM_REG(u16 reg)
 /*
  * TEMP: 0.001C/bit (-55C to +125C)
  * REG:
- *  - 1621, 1625: 0.5C/bit
- *  - 1631, 1721, 1731: 0.0625C/bit
- * Assume highest resolution and let the bits fall where they may..
+ *  - 1621, 1625: 0.5C/bit, 7 zero-bits
+ *  - 1631, 1721, 1731: 0.0625C/bit, 4 zero-bits
  */
-static inline u16 DS1621_TEMP_TO_REG(long temp)
+static inline u16 DS1621_TEMP_TO_REG(long temp, u8 zbits)
 {
-	int ntemp =3D clamp_val(temp, DS1621_TEMP_MIN, DS1621_TEMP_MAX);
-	ntemp +=3D (ntemp < 0 ? -31 : 31);
-	ntemp =3D DIV_ROUND_CLOSEST(ntemp * 10, 625) << 4;
-	return (u16)ntemp;
+	temp =3D clamp_val(temp, DS1621_TEMP_MIN, DS1621_TEMP_MAX);
+	temp =3D DIV_ROUND_CLOSEST(temp * (1 << (8 - zbits)), 1000) << zbits;
+	return temp;
 }
=20
 static void ds1621_init_client(struct i2c_client *client)
@@ -172,6 +172,7 @@ static void ds1621_init_client(struct i2c_client *clien=
t)
 	switch (data->kind) {
 	case ds1625:
 		data->update_interval =3D DS1625_CONVERSION_MAX;
+		data->zbits =3D 7;
 		sreg =3D DS1621_COM_START;
 		break;
 	case ds1631:
@@ -180,10 +181,12 @@ static void ds1621_init_client(struct i2c_client *cli=
ent)
 		resol =3D (new_conf & DS1621_REG_CONFIG_RESOL) >>
 			 DS1621_REG_CONFIG_RESOL_SHIFT;
 		data->update_interval =3D ds1721_convrates[resol];
+		data->zbits =3D 7 - resol;
 		sreg =3D DS1721_COM_START;
 		break;
 	default:
 		data->update_interval =3D DS1621_CONVERSION_MAX;
+		data->zbits =3D 7;
 		sreg =3D DS1621_COM_START;
 		break;
 	}
@@ -254,7 +257,7 @@ static ssize_t set_temp(struct device *dev, struct devi=
ce_attribute *da,
 		return err;
=20
 	mutex_lock(&data->update_lock);
-	data->temp[attr->index] =3D DS1621_TEMP_TO_REG(val);
+	data->temp[attr->index] =3D DS1621_TEMP_TO_REG(val, data->zbits);
 	i2c_smbus_write_word_swapped(client, DS1621_REG_TEMP[attr->index],
 				     data->temp[attr->index]);
 	mutex_unlock(&data->update_lock);
--=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
