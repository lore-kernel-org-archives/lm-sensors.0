From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 20:20:40 +0000
Subject: [lm-sensors] [RFC PATCH] hwmon: (it87) Support PECI for additional chips
Message-Id: <1351628440-12206-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Extend support for reporting and selecting PECI temperature sensors
to IT8718, IT8720, IT8782, and IT8783. For IT8721, report the sensor
type for temp2 as Intel PECI (6) if the chip is configured to report
the PCH temperature.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Untested, so this one deserved extra scrutiny if accepted.

 drivers/hwmon/it87.c |   48 ++++++++++++++++++++++++++++++++++++++--------=
--
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 9023c3b..6a1410b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -231,7 +231,8 @@ static const u8 IT87_REG_TEMP_OFFSET[]	=3D { 0x56, 0x57=
, 0x59 };
 struct it87_devices {
 	const char *name;
 	u16 features;
-	u16 peci_mask;
+	u8 peci_mask;
+	u8 old_peci_mask;
 };
=20
 #define FEAT_12MV_ADC		(1 << 0)
@@ -240,6 +241,7 @@ struct it87_devices {
 #define FEAT_16BIT_FANS		(1 << 3)
 #define FEAT_TEMP_OFFSET	(1 << 4)
 #define FEAT_TEMP_PECI		(1 << 5)
+#define FEAT_TEMP_OLD_PECI	(1 << 6)
=20
 static const struct it87_devices it87_devices[] =3D {
 	[it87] =3D {
@@ -256,17 +258,22 @@ static const struct it87_devices it87_devices[] =3D {
 	},
 	[it8718] =3D {
 		.name =3D "it8718",
-		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
+		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
+		  | FEAT_TEMP_OLD_PECI,
+		.old_peci_mask =3D 0x4,
 	},
 	[it8720] =3D {
 		.name =3D "it8720",
-		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
+		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
+		  | FEAT_TEMP_OLD_PECI,
+		.old_peci_mask =3D 0x4,
 	},
 	[it8721] =3D {
 		.name =3D "it8721",
 		.features =3D FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI,
 		.peci_mask =3D 0x05,
+		.old_peci_mask =3D 0x02,	/* Actually reports PCH */
 	},
 	[it8728] =3D {
 		.name =3D "it8728",
@@ -276,11 +283,15 @@ static const struct it87_devices it87_devices[] =3D {
 	},
 	[it8782] =3D {
 		.name =3D "it8782",
-		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
+		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
+		  | FEAT_TEMP_OLD_PECI,
+		.old_peci_mask =3D 0x4,
 	},
 	[it8783] =3D {
 		.name =3D "it8783",
-		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
+		.features =3D FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
+		  | FEAT_TEMP_OLD_PECI,
+		.old_peci_mask =3D 0x4,
 	},
 };
=20
@@ -291,6 +302,9 @@ static const struct it87_devices it87_devices[] =3D {
 #define has_temp_offset(data)	((data)->features & FEAT_TEMP_OFFSET)
 #define has_temp_peci(data, nr)	(((data)->features & FEAT_TEMP_PECI) && \
 				 ((data)->peci_mask & (1 << nr)))
+#define has_temp_old_peci(data, nr) \
+				(((data)->features & FEAT_TEMP_OLD_PECI) && \
+				 ((data)->old_peci_mask & (1 << nr)))
=20
 struct it87_sio_data {
 	enum chips type;
@@ -315,7 +329,8 @@ struct it87_data {
 	struct device *hwmon_dev;
 	enum chips type;
 	u16 features;
-	u16 peci_mask;
+	u8 peci_mask;
+	u8 old_peci_mask;
=20
 	unsigned short addr;
 	const char *name;
@@ -329,7 +344,8 @@ struct it87_data {
 	u16 fan[5][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
 	s8 temp[3][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
-	u8 sensor;		/* Register value */
+	u8 sensor;		/* Register value (IT87_REG_TEMP_ENABLE) */
+	u8 extra;		/* Register value (IT87_REG_TEMP_EXTRA) */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u8 vrm;
@@ -623,8 +639,10 @@ static ssize_t show_temp_type(struct device *dev, stru=
ct device_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct it87_data *data =3D it87_update_device(dev);
 	u8 reg =3D data->sensor;	    /* In case value is updated while used */
+	u8 extra =3D data->extra;
=20
-	if (has_temp_peci(data, nr) && (reg >> 6 =3D nr + 1))
+	if ((has_temp_peci(data, nr) && (reg >> 6 =3D nr + 1))
+	    || (has_temp_old_peci(data, nr) && (extra & 0x80)))
 		return sprintf(buf, "6\n");  /* Intel PECI */
 	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
@@ -641,7 +659,7 @@ static ssize_t set_temp_type(struct device *dev, struct=
 device_attribute *attr,
=20
 	struct it87_data *data =3D dev_get_drvdata(dev);
 	long val;
-	u8 reg;
+	u8 reg, extra;
=20
 	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
@@ -651,6 +669,9 @@ static ssize_t set_temp_type(struct device *dev, struct=
 device_attribute *attr,
 	reg &=3D ~(8 << nr);
 	if (has_temp_peci(data, nr) && (reg >> 6 =3D nr + 1 || val =3D 6))
 		reg &=3D 0x3f;
+	extra =3D it87_read_value(data, IT87_REG_TEMP_EXTRA);
+	if (has_temp_old_peci(data, nr) && ((extra & 0x80) || val =3D 6))
+		extra &=3D 0x7f;
 	if (val =3D 2) {	/* backwards compatibility */
 		dev_warn(dev,
 			 "Sensor type 2 is deprecated, please use 4 instead\n");
@@ -663,12 +684,17 @@ static ssize_t set_temp_type(struct device *dev, stru=
ct device_attribute *attr,
 		reg |=3D 8 << nr;
 	else if (has_temp_peci(data, nr) && val =3D 6)
 		reg |=3D (nr + 1) << 6;
+	else if (has_temp_old_peci(data, nr) && val =3D 6)
+		extra |=3D 0x80;
 	else if (val !=3D 0)
 		return -EINVAL;
=20
 	mutex_lock(&data->update_lock);
 	data->sensor =3D reg;
+	data->extra =3D extra;
 	it87_write_value(data, IT87_REG_TEMP_ENABLE, data->sensor);
+	if (has_temp_old_peci(data, nr))
+		it87_write_value(data, IT87_REG_TEMP_EXTRA, data->extra);
 	data->valid =3D 0;	/* Force cache refresh */
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1980,6 +2006,7 @@ static int __devinit it87_probe(struct platform_devic=
e *pdev)
 	data->type =3D sio_data->type;
 	data->features =3D it87_devices[sio_data->type].features;
 	data->peci_mask =3D it87_devices[sio_data->type].peci_mask;
+	data->old_peci_mask =3D it87_devices[sio_data->type].old_peci_mask;
 	data->name =3D it87_devices[sio_data->type].name;
 	/*
 	 * IT8705F Datasheet 0.4.1, 3h =3D Version G.
@@ -2461,6 +2488,7 @@ static struct it87_data *it87_update_device(struct de=
vice *dev)
 			it87_update_pwm_ctrl(data, i);
=20
 		data->sensor =3D it87_read_value(data, IT87_REG_TEMP_ENABLE);
+		data->extra =3D it87_read_value(data, IT87_REG_TEMP_EXTRA);
 		/*
 		 * The IT8705F does not have VID capability.
 		 * The IT8718F and later don't use IT87_REG_VID for the
--=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
