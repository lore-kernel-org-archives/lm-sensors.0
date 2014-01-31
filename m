From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Jan 2014 04:01:02 +0000
Subject: Re: [lm-sensors] Bug(?) in PMBus core, Issue with UCD90120
Message-Id: <20140131040102.GA2339@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <2c6b4098-bf55-4b8a-a089-0a51f478fae9@VA3EHSMHS004.ehs.local>
In-Reply-To: <2c6b4098-bf55-4b8a-a089-0a51f478fae9@VA3EHSMHS004.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi S=F6ren,

On Thu, Jan 30, 2014 at 05:13:42PM -0800, S=F6ren Brinkmann wrote:
> Hi Guenther,
>=20
> I recently became aware of some weird behavior when using the UCD9000
> driver for voltage monitoring. We use that device on our zc706 Zynq
> platform to generate 5 voltage rails. Observing the voltages in Linux
> showed a correct value for rail 1 but a 2x error in in rails 2-3 and a
> 4x error in rail 5. Digging through specs, docs and sources I could
> track this down to this:
>  - The PMBus core assumes one VOUT_MODE register per chip
>  - UCD90120 has VOUT_MODE registers per rail
>=20
> In our setup we have an exponent of -14 for rail 1, -13 for rails 2-4 and
> -14 for rail 5. The PMBus core only reads and uses the first one and
> applies it to all rails.
>=20
> I'm not sure whether the UCD devices don't comply to spec or whether
> this is a bug in the PMBus core, either way, the reported values from
> the driver are prone to be wrong/scaled by an unknown factor.
>=20
The PMBus specification is sufficiently vague to ensure that pretty much
any interpretation of it is PMBus compliant.

> Is this somehow known behavior for which a workaround might be
> available? Otherwise, if you know how an acceptable solution might look
> like, I might find some time and give it a shot.
>=20
I think we may have to expand the driver to detect and configure the expone=
nt
per rail/page. At least I can not think of another solution right now.

Can you test the patch below ? Completely untested, but it compiles.
It will likely need some refinement (for example, other chips may not even =

have the VOUT_MODE command on non-zero pages), but should be useful for
testing.

Thanks,
Guenter

---
From ac94470368c469d762242e73b71c0b07f3feb7fc Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 30 Jan 2014 19:51:14 -0800
Subject: [PATCH] hwmon: (pmbus) Support per-page exponent in linear mode

Some chips use different exponents for sensors on different pages
or rails. Detect and store exponent per page to support this situation.

This fixes a problem with wrong voltages seen on UCD90120.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   68 ++++++++++++++++++++--------------=
----
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 3cbf66e..291d11f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -90,7 +90,8 @@ struct pmbus_data {
=20
 	u32 flags;		/* from platform data */
=20
-	int exponent;		/* linear mode: exponent for output voltages */
+	int exponent[PMBUS_PAGES];
+				/* linear mode: exponent for output voltages */
=20
 	const struct pmbus_driver_info *info;
=20
@@ -410,7 +411,7 @@ static long pmbus_reg2data_linear(struct pmbus_data *da=
ta,
 	long val;
=20
 	if (sensor->class =3D=3D PSC_VOLTAGE_OUT) {	/* LINEAR16 */
-		exponent =3D data->exponent;
+		exponent =3D data->exponent[sensor->page];
 		mantissa =3D (u16) sensor->data;
 	} else {				/* LINEAR11 */
 		exponent =3D ((s16)sensor->data) >> 11;
@@ -516,7 +517,7 @@ static long pmbus_reg2data(struct pmbus_data *data, str=
uct pmbus_sensor *sensor)
 #define MIN_MANTISSA	(511 * 1000)
=20
 static u16 pmbus_data2reg_linear(struct pmbus_data *data,
-				 enum pmbus_sensor_classes class, long val)
+				 struct pmbus_sensor *sensor, long val)
 {
 	s16 exponent =3D 0, mantissa;
 	bool negative =3D false;
@@ -525,7 +526,7 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *dat=
a,
 	if (val =3D=3D 0)
 		return 0;
=20
-	if (class =3D=3D PSC_VOLTAGE_OUT) {
+	if (sensor->class =3D=3D PSC_VOLTAGE_OUT) {
 		/* LINEAR16 does not support negative voltages */
 		if (val < 0)
 			return 0;
@@ -534,10 +535,10 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *d=
ata,
 		 * For a static exponents, we don't have a choice
 		 * but to adjust the value to it.
 		 */
-		if (data->exponent < 0)
-			val <<=3D -data->exponent;
+		if (data->exponent[sensor->page] < 0)
+			val <<=3D -data->exponent[sensor->page];
 		else
-			val >>=3D data->exponent;
+			val >>=3D data->exponent[sensor->page];
 		val =3D DIV_ROUND_CLOSEST(val, 1000);
 		return val & 0xffff;
 	}
@@ -548,14 +549,14 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *d=
ata,
 	}
=20
 	/* Power is in uW. Convert to mW before converting. */
-	if (class =3D=3D PSC_POWER)
+	if (sensor->class =3D=3D PSC_POWER)
 		val =3D DIV_ROUND_CLOSEST(val, 1000L);
=20
 	/*
 	 * For simplicity, convert fan data to milli-units
 	 * before calculating the exponent.
 	 */
-	if (class =3D=3D PSC_FAN)
+	if (sensor->class =3D=3D PSC_FAN)
 		val =3D val * 1000;
=20
 	/* Reduce large mantissa until it fits into 10 bit */
@@ -585,22 +586,22 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *d=
ata,
 }
=20
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
-				 enum pmbus_sensor_classes class, long val)
+				 struct pmbus_sensor *sensor, long val)
 {
 	long m, b, R;
=20
-	m =3D data->info->m[class];
-	b =3D data->info->b[class];
-	R =3D data->info->R[class];
+	m =3D data->info->m[sensor->class];
+	b =3D data->info->b[sensor->class];
+	R =3D data->info->R[sensor->class];
=20
 	/* Power is in uW. Adjust R and b. */
-	if (class =3D=3D PSC_POWER) {
+	if (sensor->class =3D=3D PSC_POWER) {
 		R -=3D 3;
 		b *=3D 1000;
 	}
=20
 	/* Calculate Y =3D (m * X + b) * 10^R */
-	if (class !=3D PSC_FAN) {
+	if (sensor->class !=3D PSC_FAN) {
 		R -=3D 3;		/* Adjust R and b for data in milli-units */
 		b *=3D 1000;
 	}
@@ -619,7 +620,7 @@ static u16 pmbus_data2reg_direct(struct pmbus_data *dat=
a,
 }
=20
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
-			      enum pmbus_sensor_classes class, long val)
+			      struct pmbus_sensor *sensor, long val)
 {
 	val =3D clamp_val(val, 500, 1600);
=20
@@ -627,20 +628,20 @@ static u16 pmbus_data2reg_vid(struct pmbus_data *data,
 }
=20
 static u16 pmbus_data2reg(struct pmbus_data *data,
-			  enum pmbus_sensor_classes class, long val)
+			  struct pmbus_sensor *sensor, long val)
 {
 	u16 regval;
=20
-	switch (data->info->format[class]) {
+	switch (data->info->format[sensor->class]) {
 	case direct:
-		regval =3D pmbus_data2reg_direct(data, class, val);
+		regval =3D pmbus_data2reg_direct(data, sensor, val);
 		break;
 	case vid:
-		regval =3D pmbus_data2reg_vid(data, class, val);
+		regval =3D pmbus_data2reg_vid(data, sensor, val);
 		break;
 	case linear:
 	default:
-		regval =3D pmbus_data2reg_linear(data, class, val);
+		regval =3D pmbus_data2reg_linear(data, sensor, val);
 		break;
 	}
 	return regval;
@@ -746,7 +747,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 		return -EINVAL;
=20
 	mutex_lock(&data->update_lock);
-	regval =3D pmbus_data2reg(data, sensor->class, val);
+	regval =3D pmbus_data2reg(data, sensor, val);
 	ret =3D _pmbus_write_word_data(client, sensor->page, sensor->reg, regval);
 	if (ret < 0)
 		rv =3D ret;
@@ -1643,12 +1644,13 @@ static int pmbus_find_attributes(struct i2c_client =
*client,
  * This function is called for all chips.
  */
 static int pmbus_identify_common(struct i2c_client *client,
-				 struct pmbus_data *data)
+				 struct pmbus_data *data, int page)
 {
 	int vout_mode =3D -1;
=20
-	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE))
-		vout_mode =3D _pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+	if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
+		vout_mode =3D _pmbus_read_byte_data(client, page,
+						  PMBUS_VOUT_MODE);
 	if (vout_mode >=3D 0 && vout_mode !=3D 0xff) {
 		/*
 		 * Not all chips support the VOUT_MODE command,
@@ -1659,7 +1661,7 @@ static int pmbus_identify_common(struct i2c_client *c=
lient,
 			if (data->info->format[PSC_VOLTAGE_OUT] !=3D linear)
 				return -ENODEV;
=20
-			data->exponent =3D ((s8)(vout_mode << 3)) >> 3;
+			data->exponent[page] =3D ((s8)(vout_mode << 3)) >> 3;
 			break;
 		case 1: /* VID mode         */
 			if (data->info->format[PSC_VOLTAGE_OUT] !=3D vid)
@@ -1674,7 +1676,7 @@ static int pmbus_identify_common(struct i2c_client *c=
lient,
 		}
 	}
=20
-	pmbus_clear_fault_page(client, 0);
+	pmbus_clear_fault_page(client, page);
 	return 0;
 }
=20
@@ -1682,7 +1684,7 @@ static int pmbus_init_common(struct i2c_client *clien=
t, struct pmbus_data *data,
 			     struct pmbus_driver_info *info)
 {
 	struct device *dev =3D &client->dev;
-	int ret;
+	int page, ret;
=20
 	/*
 	 * Some PMBus chips don't support PMBUS_STATUS_BYTE, so try
@@ -1715,10 +1717,12 @@ static int pmbus_init_common(struct i2c_client *cli=
ent, struct pmbus_data *data,
 		return -ENODEV;
 	}
=20
-	ret =3D pmbus_identify_common(client, data);
-	if (ret < 0) {
-		dev_err(dev, "Failed to identify chip capabilities\n");
-		return ret;
+	for (page =3D 0; page < info->pages; page++) {
+		ret =3D pmbus_identify_common(client, data, page);
+		if (ret < 0) {
+			dev_err(dev, "Failed to identify chip capabilities\n");
+			return ret;
+		}
 	}
 	return 0;
 }
--=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
