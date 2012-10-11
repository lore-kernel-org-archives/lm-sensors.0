From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 14:36:15 +0000
Subject: [lm-sensors] [PATCH 5/7] hwmon: (it87) Save fan registers in 2-dimensional array
Message-Id: <1349966177-25985-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Also unify fan functions to use the same code for 8 and 16 bit fans

This patch reduces code size by approximately 1,200 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |  263 +++++++++++++++++++---------------------------=
----
 1 file changed, 101 insertions(+), 162 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index f2245b5..ee1c4fc 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -251,6 +251,7 @@ struct it87_sio_data {
 struct it87_data {
 	struct device *hwmon_dev;
 	enum chips type;
+	bool has_16bit_fans;
 	u8 revision;
=20
 	unsigned short addr;
@@ -262,8 +263,7 @@ struct it87_data {
 	u16 in_scaled;		/* Internal voltage sensors are scaled */
 	u8 in[9][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
 	u8 has_fan;		/* Bitfield, fans enabled */
-	u16 fan[5];		/* Register values, possibly combined */
-	u16 fan_min[5];		/* Register values, possibly combined */
+	u16 fan[5][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
 	s8 temp[3][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
 	u8 sensor;		/* Register value */
@@ -634,25 +634,21 @@ static int pwm_mode(const struct it87_data *data, int=
 nr)
 }
=20
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			char *buf)
 {
-	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
-	int nr =3D sensor_attr->index;
-
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	int speed;
 	struct it87_data *data =3D it87_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-				DIV_FROM_REG(data->fan_div[nr])));
-}
-static ssize_t show_fan_min(struct device *dev, struct device_attribute *a=
ttr,
-		char *buf)
-{
-	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
-	int nr =3D sensor_attr->index;
=20
-	struct it87_data *data =3D it87_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
-				DIV_FROM_REG(data->fan_div[nr])));
+	speed =3D data->has_16bit_fans ?
+		FAN16_FROM_REG(data->fan[nr][index]) :
+		FAN_FROM_REG(data->fan[nr][index],
+			     DIV_FROM_REG(data->fan_div[nr]));
+	return sprintf(buf, "%d\n", speed);
 }
+
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *a=
ttr,
 		char *buf)
 {
@@ -689,11 +685,13 @@ static ssize_t show_pwm_freq(struct device *dev, stru=
ct device_attribute *attr,
=20
 	return sprintf(buf, "%u\n", pwm_freq[index]);
 }
-static ssize_t set_fan_min(struct device *dev, struct device_attribute *at=
tr,
-		const char *buf, size_t count)
+
+static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
-	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
-	int nr =3D sensor_attr->index;
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
=20
 	struct it87_data *data =3D dev_get_drvdata(dev);
 	long val;
@@ -703,24 +701,36 @@ static ssize_t set_fan_min(struct device *dev, struct=
 device_attribute *attr,
 		return -EINVAL;
=20
 	mutex_lock(&data->update_lock);
-	reg =3D it87_read_value(data, IT87_REG_FAN_DIV);
-	switch (nr) {
-	case 0:
-		data->fan_div[nr] =3D reg & 0x07;
-		break;
-	case 1:
-		data->fan_div[nr] =3D (reg >> 3) & 0x07;
-		break;
-	case 2:
-		data->fan_div[nr] =3D (reg & 0x40) ? 3 : 1;
-		break;
+
+	if (!data->has_16bit_fans) {
+		reg =3D it87_read_value(data, IT87_REG_FAN_DIV);
+		switch (nr) {
+		case 0:
+			data->fan_div[nr] =3D reg & 0x07;
+			break;
+		case 1:
+			data->fan_div[nr] =3D (reg >> 3) & 0x07;
+			break;
+		case 2:
+			data->fan_div[nr] =3D (reg & 0x40) ? 3 : 1;
+			break;
+		}
+		data->fan[nr][index] +		  FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]=
));
+		it87_write_value(data, IT87_REG_FAN_MIN[nr],
+				 data->fan[nr][index]);
+	} else {
+		data->fan[nr][index] =3D FAN16_TO_REG(val);
+		it87_write_value(data, IT87_REG_FAN_MIN[nr],
+				 data->fan[nr][index] & 0xff);
+		it87_write_value(data, IT87_REG_FANX_MIN[nr],
+				 data->fan[nr][index] >> 8);
 	}
=20
-	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(data, IT87_REG_FAN_MIN[nr], data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *at=
tr,
 		const char *buf, size_t count)
 {
@@ -739,7 +749,7 @@ static ssize_t set_fan_div(struct device *dev, struct d=
evice_attribute *attr,
 	old =3D it87_read_value(data, IT87_REG_FAN_DIV);
=20
 	/* Save fan min limit */
-	min =3D FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
+	min =3D FAN_FROM_REG(data->fan[nr][1], DIV_FROM_REG(data->fan_div[nr]));
=20
 	switch (nr) {
 	case 0:
@@ -760,8 +770,8 @@ static ssize_t set_fan_div(struct device *dev, struct d=
evice_attribute *attr,
 	it87_write_value(data, IT87_REG_FAN_DIV, val);
=20
 	/* Restore fan min limit */
-	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(data, IT87_REG_FAN_MIN[nr], data->fan_min[nr]);
+	data->fan[nr][1] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	it87_write_value(data, IT87_REG_FAN_MIN[nr], data->fan[nr][1]);
=20
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1034,17 +1044,23 @@ static ssize_t set_auto_temp(struct device *dev,
 	return count;
 }
=20
-#define show_fan_offset(offset)					\
-static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
-		show_fan, NULL, offset - 1);			\
-static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		show_fan_min, set_fan_min, offset - 1);		\
-static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		show_fan_div, set_fan_div, offset - 1);
+static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0);
+static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGOWU, show_fan, set_fan, 0, 1);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGOWU, show_fan_div, set_fan_div, =
0);
+
+static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 1, 0);
+static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGOWU, show_fan, set_fan, 1, 1);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGOWU, show_fan_div, set_fan_div, =
1);
+
+static SENSOR_DEVICE_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 2, 0);
+static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGOWU, show_fan, set_fan, 2, 1);
+static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGOWU, show_fan_div, set_fan_div, =
2);
+
+static SENSOR_DEVICE_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 3, 0);
+static SENSOR_DEVICE_ATTR_2(fan4_min, S_IRUGOWU, show_fan, set_fan, 3, 1);
=20
-show_fan_offset(1);
-show_fan_offset(2);
-show_fan_offset(3);
+static SENSOR_DEVICE_ATTR_2(fan5_input, S_IRUGO, show_fan, NULL, 4, 0);
+static SENSOR_DEVICE_ATTR_2(fan5_min, S_IRUGOWU, show_fan, set_fan, 4, 1);
=20
 #define show_pwm_offset(offset)						\
 static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
@@ -1088,65 +1104,6 @@ show_pwm_offset(1);
 show_pwm_offset(2);
 show_pwm_offset(3);
=20
-/* A different set of callbacks for 16-bit fans */
-static ssize_t show_fan16(struct device *dev, struct device_attribute *att=
r,
-		char *buf)
-{
-	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
-	int nr =3D sensor_attr->index;
-	struct it87_data *data =3D it87_update_device(dev);
-	return sprintf(buf, "%d\n", FAN16_FROM_REG(data->fan[nr]));
-}
-
-static ssize_t show_fan16_min(struct device *dev, struct device_attribute =
*attr,
-		char *buf)
-{
-	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
-	int nr =3D sensor_attr->index;
-	struct it87_data *data =3D it87_update_device(dev);
-	return sprintf(buf, "%d\n", FAN16_FROM_REG(data->fan_min[nr]));
-}
-
-static ssize_t set_fan16_min(struct device *dev, struct device_attribute *=
attr,
-		const char *buf, size_t count)
-{
-	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
-	int nr =3D sensor_attr->index;
-	struct it87_data *data =3D dev_get_drvdata(dev);
-	long val;
-
-	if (kstrtol(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	mutex_lock(&data->update_lock);
-	data->fan_min[nr] =3D FAN16_TO_REG(val);
-	it87_write_value(data, IT87_REG_FAN_MIN[nr],
-			 data->fan_min[nr] & 0xff);
-	it87_write_value(data, IT87_REG_FANX_MIN[nr],
-			 data->fan_min[nr] >> 8);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-
-/*
- * We want to use the same sysfs file names as 8-bit fans, but we need
- * different variable names, so we have to use SENSOR_ATTR instead of
- * SENSOR_DEVICE_ATTR.
- */
-#define show_fan16_offset(offset) \
-static struct sensor_device_attribute sensor_dev_attr_fan##offset##_input1=
6 \
-	=3D SENSOR_ATTR(fan##offset##_input, S_IRUGO,		\
-		show_fan16, NULL, offset - 1);			\
-static struct sensor_device_attribute sensor_dev_attr_fan##offset##_min16 \
-	=3D SENSOR_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,	\
-		show_fan16_min, set_fan16_min, offset - 1)
-
-show_fan16_offset(1);
-show_fan16_offset(2);
-show_fan16_offset(3);
-show_fan16_offset(4);
-show_fan16_offset(5);
-
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *at=
tr,
 		char *buf)
@@ -1445,73 +1402,47 @@ static struct attribute *it87_attributes_temp_beep[=
] =3D {
 	&sensor_dev_attr_temp3_beep.dev_attr.attr,
 };
=20
-static struct attribute *it87_attributes_fan16[5][3+1] =3D { {
-	&sensor_dev_attr_fan1_input16.dev_attr.attr,
-	&sensor_dev_attr_fan1_min16.dev_attr.attr,
+static struct attribute *it87_attributes_fan[5][3+1] =3D { {
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
 	NULL
 }, {
-	&sensor_dev_attr_fan2_input16.dev_attr.attr,
-	&sensor_dev_attr_fan2_min16.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	NULL
 }, {
-	&sensor_dev_attr_fan3_input16.dev_attr.attr,
-	&sensor_dev_attr_fan3_min16.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
 	NULL
 }, {
-	&sensor_dev_attr_fan4_input16.dev_attr.attr,
-	&sensor_dev_attr_fan4_min16.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
 	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
 	NULL
 }, {
-	&sensor_dev_attr_fan5_input16.dev_attr.attr,
-	&sensor_dev_attr_fan5_min16.dev_attr.attr,
+	&sensor_dev_attr_fan5_input.dev_attr.attr,
+	&sensor_dev_attr_fan5_min.dev_attr.attr,
 	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
 	NULL
 } };
=20
-static const struct attribute_group it87_group_fan16[5] =3D {
-	{ .attrs =3D it87_attributes_fan16[0] },
-	{ .attrs =3D it87_attributes_fan16[1] },
-	{ .attrs =3D it87_attributes_fan16[2] },
-	{ .attrs =3D it87_attributes_fan16[3] },
-	{ .attrs =3D it87_attributes_fan16[4] },
+static const struct attribute_group it87_group_fan[5] =3D {
+	{ .attrs =3D it87_attributes_fan[0] },
+	{ .attrs =3D it87_attributes_fan[1] },
+	{ .attrs =3D it87_attributes_fan[2] },
+	{ .attrs =3D it87_attributes_fan[3] },
+	{ .attrs =3D it87_attributes_fan[4] },
 };
=20
-static struct attribute *it87_attributes_fan[3][4+1] =3D { {
-	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan1_min.dev_attr.attr,
+static const struct attribute *it87_attributes_fan_div[] =3D {
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
-	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
-	NULL
-}, {
-	&sensor_dev_attr_fan2_input.dev_attr.attr,
-	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
-	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
-	NULL
-}, {
-	&sensor_dev_attr_fan3_input.dev_attr.attr,
-	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
-	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
-	NULL
-} };
-
-static const struct attribute_group it87_group_fan[3] =3D {
-	{ .attrs =3D it87_attributes_fan[0] },
-	{ .attrs =3D it87_attributes_fan[1] },
-	{ .attrs =3D it87_attributes_fan[2] },
 };
=20
-static const struct attribute_group *
-it87_get_fan_group(const struct it87_data *data)
-{
-	return has_16bit_fans(data) ? it87_group_fan16 : it87_group_fan;
-}
-
 static struct attribute *it87_attributes_pwm[3][4+1] =3D { {
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
@@ -1870,7 +1801,6 @@ static void it87_remove_files(struct device *dev)
 {
 	struct it87_data *data =3D platform_get_drvdata(pdev);
 	struct it87_sio_data *sio_data =3D dev->platform_data;
-	const struct attribute_group *fan_group =3D it87_get_fan_group(data);
 	int i;
=20
 	sysfs_remove_group(&dev->kobj, &it87_group);
@@ -1893,10 +1823,13 @@ static void it87_remove_files(struct device *dev)
 	for (i =3D 0; i < 5; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
-		sysfs_remove_group(&dev->kobj, &fan_group[i]);
+		sysfs_remove_group(&dev->kobj, &it87_group_fan[i]);
 		if (sio_data->beep_pin)
 			sysfs_remove_file(&dev->kobj,
 					  it87_attributes_fan_beep[i]);
+		if (i < 3 && !data->has_16bit_fans)
+			sysfs_remove_file(&dev->kobj,
+					  it87_attributes_fan_div[i]);
 	}
 	for (i =3D 0; i < 3; i++) {
 		if (sio_data->skip_pwm & (1 << 0))
@@ -1917,7 +1850,6 @@ static int __devinit it87_probe(struct platform_devic=
e *pdev)
 	struct resource *res;
 	struct device *dev =3D &pdev->dev;
 	struct it87_sio_data *sio_data =3D dev->platform_data;
-	const struct attribute_group *fan_group;
 	int err =3D 0, i;
 	int enable_pwm_interface;
 	int fan_beep_need_rw;
@@ -2022,15 +1954,21 @@ static int __devinit it87_probe(struct platform_dev=
ice *pdev)
 	}
=20
 	/* Do not create fan files for disabled fans */
-	fan_group =3D it87_get_fan_group(data);
 	fan_beep_need_rw =3D 1;
 	for (i =3D 0; i < 5; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
-		err =3D sysfs_create_group(&dev->kobj, &fan_group[i]);
+		err =3D sysfs_create_group(&dev->kobj, &it87_group_fan[i]);
 		if (err)
 			goto error;
=20
+		if (i < 3 && !data->has_16bit_fans) {
+			err =3D sysfs_create_file(&dev->kobj,
+						it87_attributes_fan_div[i]);
+			if (err)
+				goto error;
+		}
+
 		if (sio_data->beep_pin) {
 			err =3D sysfs_create_file(&dev->kobj,
 						it87_attributes_fan_beep[i]);
@@ -2261,9 +2199,10 @@ static void __devinit it87_init_device(struct platfo=
rm_device *pdev)
 				 data->fan_main_ctrl);
 	}
 	data->has_fan =3D (data->fan_main_ctrl >> 4) & 0x07;
+	data->has_16bit_fans =3D has_16bit_fans(data);
=20
 	/* Set tachometers to 16-bit mode if needed */
-	if (has_16bit_fans(data)) {
+	if (data->has_16bit_fans) {
 		tmp =3D it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (~tmp & 0x07 & data->has_fan) {
 			dev_dbg(&pdev->dev,
@@ -2349,15 +2288,15 @@ static struct it87_data *it87_update_device(struct =
device *dev)
 			if (!(data->has_fan & (1 << i)))
 				continue;
=20
-			data->fan_min[i] +			data->fan[i][1]  				it87_read_value(data, IT87_RE=
G_FAN_MIN[i]);
-			data->fan[i] =3D it87_read_value(data,
+			data->fan[i][0] =3D it87_read_value(data,
 				       IT87_REG_FAN[i]);
 			/* Add high byte if in 16-bit mode */
-			if (has_16bit_fans(data)) {
-				data->fan[i] |=3D it87_read_value(data,
+			if (data->has_16bit_fans) {
+				data->fan[i][0] |=3D it87_read_value(data,
 						IT87_REG_FANX[i]) << 8;
-				data->fan_min[i] |=3D it87_read_value(data,
+				data->fan[i][1] |=3D it87_read_value(data,
 						IT87_REG_FANX_MIN[i]) << 8;
 			}
 		}
@@ -2375,7 +2314,7 @@ static struct it87_data *it87_update_device(struct de=
vice *dev)
 		}
=20
 		/* Newer chips don't have clock dividers */
-		if ((data->has_fan & 0x07) && !has_16bit_fans(data)) {
+		if ((data->has_fan & 0x07) && !data->has_16bit_fans) {
 			i =3D it87_read_value(data, IT87_REG_FAN_DIV);
 			data->fan_div[0] =3D i & 0x07;
 			data->fan_div[1] =3D (i >> 3) & 0x07;
--=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
