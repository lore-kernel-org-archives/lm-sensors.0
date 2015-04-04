From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:55:02 +0000
Subject: [lm-sensors] [PATCH 11/22] hwmon: (it87) Use is_visible for voltage sensors
Message-Id: <1428184513-22380-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by more than 300 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 124 +++++++++++++++++++++++------------------------=
----
 1 file changed, 56 insertions(+), 68 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 8169a4fb225b..5e4ef232b03a 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -458,6 +458,7 @@ struct it87_data {
 	unsigned long last_updated;	/* In jiffies */
=20
 	u16 in_scaled;		/* Internal voltage sensors are scaled */
+	u16 has_in;		/* Bitfield, voltage sensors enabled */
 	u8 in[10][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[6][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
@@ -469,6 +470,7 @@ struct it87_data {
 	u8 vid;			/* Register encoding, combined */
 	u8 vrm;
 	u32 alarms;		/* Register encoding, combined */
+	bool has_beep;		/* true if beep supported */
 	u8 beeps;		/* Register encoding */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 fan_ctl;		/* Register value */
@@ -1726,74 +1728,85 @@ static ssize_t show_name(struct device *dev, struct=
 device_attribute
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
=20
-static struct attribute *it87_attributes_in[10][5] =3D {
+static umode_t it87_in_is_visible(struct kobject *kobj,
+				  struct attribute *attr, int index)
 {
+	struct device *dev =3D container_of(kobj, struct device, kobj);
+	struct it87_data *data =3D dev_get_drvdata(dev);
+	int i =3D index / 5;	/* voltage index */
+	int a =3D index % 5;	/* attribute index */
+
+	if (index >=3D 40) {	/* in8, in9 only have input attributes */
+		i =3D index - 40 + 8;
+		a =3D 0;
+	}
+
+	if (!(data->has_in & (1 << i)))
+		return 0;
+
+	if (a =3D 4 && !data->has_beep)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *it87_attributes_in[] =3D {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in0_beep.dev_attr.attr,	/* 4 */
+
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
 	&sensor_dev_attr_in1_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in1_beep.dev_attr.attr,	/* 9 */
+
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
 	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in2_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in2_beep.dev_attr.attr,	/* 14 */
+
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in3_beep.dev_attr.attr,	/* 19 */
+
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in4_beep.dev_attr.attr,	/* 24 */
+
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in5_min.dev_attr.attr,
 	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in5_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in5_beep.dev_attr.attr,	/* 29 */
+
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in6_min.dev_attr.attr,
 	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&sensor_dev_attr_in6_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in6_beep.dev_attr.attr,	/* 34 */
+
 	&sensor_dev_attr_in7_input.dev_attr.attr,
 	&sensor_dev_attr_in7_min.dev_attr.attr,
 	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in7_alarm.dev_attr.attr,
-	NULL
-}, {
-	&sensor_dev_attr_in8_input.dev_attr.attr,
-	NULL
-}, {
-	&sensor_dev_attr_in9_input.dev_attr.attr,
-	NULL
-} };
+	&sensor_dev_attr_in7_beep.dev_attr.attr,	/* 39 */
+
+	&sensor_dev_attr_in8_input.dev_attr.attr,	/* 40 */
+
+	&sensor_dev_attr_in9_input.dev_attr.attr,	/* 41 */
+};
=20
-static const struct attribute_group it87_group_in[10] =3D {
-	{ .attrs =3D it87_attributes_in[0] },
-	{ .attrs =3D it87_attributes_in[1] },
-	{ .attrs =3D it87_attributes_in[2] },
-	{ .attrs =3D it87_attributes_in[3] },
-	{ .attrs =3D it87_attributes_in[4] },
-	{ .attrs =3D it87_attributes_in[5] },
-	{ .attrs =3D it87_attributes_in[6] },
-	{ .attrs =3D it87_attributes_in[7] },
-	{ .attrs =3D it87_attributes_in[8] },
-	{ .attrs =3D it87_attributes_in[9] },
+static const struct attribute_group it87_group_in =3D {
+	.attrs =3D it87_attributes_in,
+	.is_visible =3D it87_in_is_visible,
 };
=20
 static struct attribute *it87_attributes_temp[3][6] =3D {
@@ -1843,19 +1856,6 @@ static const struct attribute_group it87_group =3D {
 	.attrs =3D it87_attributes,
 };
=20
-static struct attribute *it87_attributes_in_beep[] =3D {
-	&sensor_dev_attr_in0_beep.dev_attr.attr,
-	&sensor_dev_attr_in1_beep.dev_attr.attr,
-	&sensor_dev_attr_in2_beep.dev_attr.attr,
-	&sensor_dev_attr_in3_beep.dev_attr.attr,
-	&sensor_dev_attr_in4_beep.dev_attr.attr,
-	&sensor_dev_attr_in5_beep.dev_attr.attr,
-	&sensor_dev_attr_in6_beep.dev_attr.attr,
-	&sensor_dev_attr_in7_beep.dev_attr.attr,
-	NULL,
-	NULL,
-};
-
 static struct attribute *it87_attributes_temp_beep[] =3D {
 	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 	&sensor_dev_attr_temp2_beep.dev_attr.attr,
@@ -2407,14 +2407,8 @@ static void it87_remove_files(struct device *dev)
 	int i;
=20
 	sysfs_remove_group(&dev->kobj, &it87_group);
-	for (i =3D 0; i < 10; i++) {
-		if (sio_data->skip_in & (1 << i))
-			continue;
-		sysfs_remove_group(&dev->kobj, &it87_group_in[i]);
-		if (it87_attributes_in_beep[i])
-			sysfs_remove_file(&dev->kobj,
-					  it87_attributes_in_beep[i]);
-	}
+	sysfs_remove_group(&dev->kobj, &it87_group_in);
+
 	for (i =3D 0; i < 3; i++) {
 		if (!(data->has_temp & (1 << i)))
 			continue;
@@ -2707,6 +2701,10 @@ static int it87_probe(struct platform_device *pdev)
 			data->has_temp &=3D ~(1 << 2);
 	}
=20
+	data->has_in =3D 0x3ff & ~sio_data->skip_in;
+
+	data->has_beep =3D !!sio_data->beep_pin;
+
 	/* Initialize the IT87 chip */
 	it87_init_device(pdev);
=20
@@ -2715,19 +2713,9 @@ static int it87_probe(struct platform_device *pdev)
 	if (err)
 		return err;
=20
-	for (i =3D 0; i < 10; i++) {
-		if (sio_data->skip_in & (1 << i))
-			continue;
-		err =3D sysfs_create_group(&dev->kobj, &it87_group_in[i]);
-		if (err)
-			goto error;
-		if (sio_data->beep_pin && it87_attributes_in_beep[i]) {
-			err =3D sysfs_create_file(&dev->kobj,
-						it87_attributes_in_beep[i]);
-			if (err)
-				goto error;
-		}
-	}
+	err =3D sysfs_create_group(&dev->kobj, &it87_group_in);
+	if (err)
+		goto error;
=20
 	for (i =3D 0; i < 3; i++) {
 		if (!(data->has_temp & (1 << i)))
--=20
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
