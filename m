From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 06:33:47 +0000
Subject: [lm-sensors] [PATCH 07/15] hwmon: (it87) Add support for 6th fan of IT8620E
Message-Id: <1427697235-23566-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

IT8620E supports up to 6 fan tachometers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 51 ++++++++++++++++++++++++++++++++++++------------=
---
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index ee6d30960fce..24e9369f1b74 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -215,11 +215,11 @@ static bool fix_pwm_polarity;
=20
 /* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) =
*/
=20
-static const u8 IT87_REG_FAN[]		=3D { 0x0d, 0x0e, 0x0f, 0x80, 0x82 };
-static const u8 IT87_REG_FAN_MIN[]	=3D { 0x10, 0x11, 0x12, 0x84, 0x86 };
-static const u8 IT87_REG_FANX[]		=3D { 0x18, 0x19, 0x1a, 0x81, 0x83 };
-static const u8 IT87_REG_FANX_MIN[]	=3D { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
-static const u8 IT87_REG_TEMP_OFFSET[]	=3D { 0x56, 0x57, 0x59 };
+static const u8 IT87_REG_FAN[]		=3D {0x0d, 0x0e, 0x0f, 0x80, 0x82, 0x4c};
+static const u8 IT87_REG_FAN_MIN[]	=3D {0x10, 0x11, 0x12, 0x84, 0x86, 0x4e=
};
+static const u8 IT87_REG_FANX[]		=3D {0x18, 0x19, 0x1a, 0x81, 0x83, 0x4d};
+static const u8 IT87_REG_FANX_MIN[]	=3D {0x1b, 0x1c, 0x1d, 0x85, 0x87, 0x4=
f};
+static const u8 IT87_REG_TEMP_OFFSET[]	=3D {0x56, 0x57, 0x59};
=20
 #define IT87_REG_FAN_MAIN_CTRL 0x13
 #define IT87_REG_FAN_CTL       0x14
@@ -263,6 +263,7 @@ struct it87_devices {
 #define FEAT_FIVE_FANS		(1 << 8)	/* Supports five fans */
 #define FEAT_VID		(1 << 9)	/* Set if chip supports VID */
 #define FEAT_IN7_INTERNAL	(1 << 10)	/* Set if in7 is internal */
+#define FEAT_SIX_FANS		(1 << 11)	/* Supports six fans */
=20
 static const struct it87_devices it87_devices[] =3D {
 	[it87] =3D {
@@ -380,7 +381,7 @@ static const struct it87_devices it87_devices[] =3D {
 	[it8620] =3D {
 		.name =3D "it8620",
 		.features =3D FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_SIX_FANS
 		  | FEAT_IN7_INTERNAL,
 		.peci_mask =3D 0x07,
 		.suffix =3D "E",
@@ -398,9 +399,11 @@ static const struct it87_devices it87_devices[] =3D {
 				(((data)->features & FEAT_TEMP_OLD_PECI) && \
 				 ((data)->old_peci_mask & (1 << nr)))
 #define has_fan16_config(data)	((data)->features & FEAT_FAN16_CONFIG)
-#define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
+#define has_five_fans(data)	((data)->features & (FEAT_FIVE_FANS | \
+						     FEAT_SIX_FANS))
 #define has_vid(data)		((data)->features & FEAT_VID)
 #define has_in7_internal(data)	((data)->features & FEAT_IN7_INTERNAL)
+#define has_six_fans(data)	((data)->features & FEAT_SIX_FANS)
=20
 struct it87_sio_data {
 	enum chips type;
@@ -437,7 +440,7 @@ struct it87_data {
 	u16 in_scaled;		/* Internal voltage sensors are scaled */
 	u8 in[10][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
 	u8 has_fan;		/* Bitfield, fans enabled */
-	u16 fan[5][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
+	u16 fan[6][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
 	s8 temp[3][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
 	u8 sensor;		/* Register value (IT87_REG_TEMP_ENABLE) */
@@ -1276,6 +1279,10 @@ static SENSOR_DEVICE_ATTR_2(fan5_input, S_IRUGO, sho=
w_fan, NULL, 4, 0);
 static SENSOR_DEVICE_ATTR_2(fan5_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
 			    4, 1);
=20
+static SENSOR_DEVICE_ATTR_2(fan6_input, S_IRUGO, show_fan, NULL, 5, 0);
+static SENSOR_DEVICE_ATTR_2(fan6_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
+			    5, 1);
+
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 0);
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
@@ -1406,6 +1413,7 @@ static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_a=
larm, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 7);
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 16);
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 17);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 18);
@@ -1456,6 +1464,7 @@ static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO, show_be=
ep, set_beep, 0);
 static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO, show_beep, set_beep, 0);
 static SENSOR_DEVICE_ATTR(fan4_beep, S_IRUGO, show_beep, set_beep, 0);
 static SENSOR_DEVICE_ATTR(fan5_beep, S_IRUGO, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(fan6_beep, S_IRUGO, show_beep, set_beep, 0);
 static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
 			  show_beep, set_beep, 2);
 static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
@@ -1659,7 +1668,7 @@ static struct attribute *it87_attributes_temp_beep[] =
=3D {
 	&sensor_dev_attr_temp3_beep.dev_attr.attr,
 };
=20
-static struct attribute *it87_attributes_fan[5][3+1] =3D { {
+static struct attribute *it87_attributes_fan[6][3+1] =3D { {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
@@ -1684,14 +1693,20 @@ static struct attribute *it87_attributes_fan[5][3+1=
] =3D { {
 	&sensor_dev_attr_fan5_min.dev_attr.attr,
 	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
 	NULL
+}, {
+	&sensor_dev_attr_fan6_input.dev_attr.attr,
+	&sensor_dev_attr_fan6_min.dev_attr.attr,
+	&sensor_dev_attr_fan6_alarm.dev_attr.attr,
+	NULL
 } };
=20
-static const struct attribute_group it87_group_fan[5] =3D {
+static const struct attribute_group it87_group_fan[6] =3D {
 	{ .attrs =3D it87_attributes_fan[0] },
 	{ .attrs =3D it87_attributes_fan[1] },
 	{ .attrs =3D it87_attributes_fan[2] },
 	{ .attrs =3D it87_attributes_fan[3] },
 	{ .attrs =3D it87_attributes_fan[4] },
+	{ .attrs =3D it87_attributes_fan[5] },
 };
=20
 static const struct attribute *it87_attributes_fan_div[] =3D {
@@ -1773,6 +1788,7 @@ static struct attribute *it87_attributes_fan_beep[] =
=3D {
 	&sensor_dev_attr_fan3_beep.dev_attr.attr,
 	&sensor_dev_attr_fan4_beep.dev_attr.attr,
 	&sensor_dev_attr_fan5_beep.dev_attr.attr,
+	&sensor_dev_attr_fan6_beep.dev_attr.attr,
 };
=20
 static struct attribute *it87_attributes_vid[] =3D {
@@ -2154,7 +2170,7 @@ static void it87_remove_files(struct device *dev)
 			sysfs_remove_file(&dev->kobj,
 					  it87_attributes_temp_beep[i]);
 	}
-	for (i =3D 0; i < 5; i++) {
+	for (i =3D 0; i < 6; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		sysfs_remove_group(&dev->kobj, &it87_group_fan[i]);
@@ -2311,7 +2327,7 @@ static int it87_probe(struct platform_device *pdev)
=20
 	/* Do not create fan files for disabled fans */
 	fan_beep_need_rw =3D 1;
-	for (i =3D 0; i < 5; i++) {
+	for (i =3D 0; i < 6; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		err =3D sysfs_create_group(&dev->kobj, &it87_group_fan[i]);
@@ -2556,9 +2572,10 @@ static void it87_init_device(struct platform_device =
*pdev)
 	}
 	data->has_fan =3D (data->fan_main_ctrl >> 4) & 0x07;
=20
+	tmp =3D it87_read_value(data, IT87_REG_FAN_16BIT);
+
 	/* Set tachometers to 16-bit mode if needed */
 	if (has_fan16_config(data)) {
-		tmp =3D it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (~tmp & 0x07 & data->has_fan) {
 			dev_dbg(&pdev->dev,
 				"Setting fan1-3 to 16-bit mode\n");
@@ -2569,13 +2586,17 @@ static void it87_init_device(struct platform_device=
 *pdev)
=20
 	/* Check for additional fans */
 	if (has_five_fans(data)) {
-		tmp =3D it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (tmp & (1 << 4))
 			data->has_fan |=3D (1 << 3); /* fan4 enabled */
 		if (tmp & (1 << 5))
 			data->has_fan |=3D (1 << 4); /* fan5 enabled */
 	}
=20
+	if (has_six_fans(data)) {
+		if (tmp & (1 << 2))
+			data->has_fan |=3D (1 << 5); /* fan6 enabled */
+	}
+
 	/* Fan input pins may be used for alternative functions */
 	data->has_fan &=3D ~sio_data->skip_fan;
=20
@@ -2641,7 +2662,7 @@ static struct it87_data *it87_update_device(struct de=
vice *dev)
 		if (data->type =3D it8603)
 			data->in[9][0] =3D it87_read_value(data, 0x2f);
=20
-		for (i =3D 0; i < 5; i++) {
+		for (i =3D 0; i < 6; i++) {
 			/* Skip disabled fans */
 			if (!(data->has_fan & (1 << i)))
 				continue;
--=20
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
