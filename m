From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Dec 2012 20:56:03 +0000
Subject: [lm-sensors] [PATCH v5 10/11] hwmon: (nct6775) Add support for weighted fan control
Message-Id: <1355259364-14293-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The NCT677X series support weighted fan control. In this mode, a secondary
temperature source is used in addition to the primary temperature source to
control fan speed. Add support for this feature.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/nct6775 |   19 +++
 drivers/hwmon/nct6775.c     |  280 +++++++++++++++++++++++++++++++++++++++=
+---
 2 files changed, 285 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
index b4fe6bc..3f5587e 100644
--- a/Documentation/hwmon/nct6775
+++ b/Documentation/hwmon/nct6775
@@ -92,6 +92,25 @@ Common fan control attributes
=20
 pwm[1-5]_temp_sel	Temperature source. Value is temperature sensor index.
 			For example, select '1' for temp1_input.
+pwm[1-5]_weight_temp_sel
+			Secondary temperature source. Value is temperature
+			sensor index. For example, select '1' for temp1_input.
+			Set to 0 to disable secondary temperature control.
+
+If secondary temperature functionality is enabled, it is controlled with t=
he
+following attributes.
+
+pwm[1-5]_weight_duty_step
+			Duty step size.
+pwm[1-5]_weight_temp_step
+			Temperature step size. With each step over
+			temp_step_base, the value of weight_duty_step is added
+			to the current pwm value.
+pwm[1-5]_weight_temp_step_base
+			Temperature at which secondary temperature control kicks
+			in.
+pwm[1-5]_weight_temp_step_tol
+			Temperature step tolerance.
=20
 Thermal Cruise mode (2)
 -----------------------
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 636683a..7a0f9bc 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -255,6 +255,17 @@ static const u16 NCT6775_REG_TEMP_SOURCE[] =3D {
 static const u16 NCT6775_REG_TEMP_SEL[] =3D {
 	0x100, 0x200, 0x300, 0x800, 0x900 };
=20
+static const u16 NCT6775_REG_WEIGHT_TEMP_SEL[] =3D {
+	0x139, 0x239, 0x339, 0x839, 0x939 };
+static const u16 NCT6775_REG_WEIGHT_TEMP_STEP[] =3D {
+	0x13a, 0x23a, 0x33a, 0x83a, 0x93a };
+static const u16 NCT6775_REG_WEIGHT_TEMP_STEP_TOL[] =3D {
+	0x13b, 0x23b, 0x33b, 0x83b, 0x93b };
+static const u16 NCT6775_REG_WEIGHT_DUTY_STEP[] =3D {
+	0x13c, 0x23c, 0x33c, 0x83c, 0x93c };
+static const u16 NCT6775_REG_WEIGHT_TEMP_BASE[] =3D {
+	0x13d, 0x23d, 0x33d, 0x83d, 0x93d };
+
 static const u16 NCT6775_REG_TEMP_OFFSET[] =3D { 0x454, 0x455, 0x456 };
=20
 static const u16 NCT6775_REG_AUTO_TEMP[] =3D {
@@ -323,6 +334,9 @@ static const u8 NCT6776_PWM_MODE_MASK[] =3D { 0x01, 0, =
0 };
 static const u16 NCT6776_REG_FAN_MIN[] =3D { 0x63a, 0x63c, 0x63e, 0x640, 0=
x642 };
 static const u16 NCT6776_REG_FAN_PULSES[] =3D { 0x644, 0x645, 0x646, 0, 0 =
};
=20
+static const u16 NCT6776_REG_WEIGHT_DUTY_BASE[] =3D {
+	0x13e, 0x23e, 0x33e, 0x83e, 0x93e };
+
 static const u16 NCT6776_REG_TEMP_CONFIG[11] =3D {
 	0x18, 0x152, 0x252, 0x628, 0x629, 0x62A };
=20
@@ -569,8 +583,9 @@ struct nct6775_data {
 	const u8 *REG_PWM_MODE;
 	const u8 *PWM_MODE_MASK;
=20
-	const u16 *REG_PWM[5];	/* [0]=3Dpwm, [1]=3Dpwm_start, [2]=3Dpwm_floor,
-				 * [3]=3Dpwm_max, [4]=3Dpwm_step
+	const u16 *REG_PWM[7];	/* [0]=3Dpwm, [1]=3Dpwm_start, [2]=3Dpwm_floor,
+				 * [3]=3Dpwm_max, [4]=3Dpwm_step,
+				 * [5]=3Dweight_duty_step, [6]=3Dweight_duty_base
 				 */
 	const u16 *REG_PWM_READ;
=20
@@ -582,6 +597,9 @@ struct nct6775_data {
=20
 	const u16 *REG_TEMP_SOURCE;	/* temp register sources */
 	const u16 *REG_TEMP_SEL;
+	const u16 *REG_WEIGHT_TEMP_SEL;
+	const u16 *REG_WEIGHT_TEMP[3];	/* 0=BAse, 1=3Dtolerance, 2=3Dstep */
+
 	const u16 *REG_TEMP_OFFSET;
=20
 	const u16 *REG_ALARM;
@@ -623,8 +641,9 @@ struct nct6775_data {
 			 * 4->SmartFan III
 			 * 5->enhanced variable thermal cruise (SmartFan IV)
 			 */
-	u8 pwm[5][5];	/* [0]=3Dpwm, [1]=3Dpwm_start, [2]=3Dpwm_floor,
-			 * [3]=3Dpwm_max, [4]=3Dpwm_step
+	u8 pwm[7][5];	/* [0]=3Dpwm, [1]=3Dpwm_start, [2]=3Dpwm_floor,
+			 * [3]=3Dpwm_max, [4]=3Dpwm_step,
+			 * [5]=3Dweight_duty_step, [6]=3Dweight_duty_base
 			 */
=20
 	u8 target_temp[5];
@@ -643,6 +662,10 @@ struct nct6775_data {
 	u8 auto_pwm[5][7];
 	u8 auto_temp[5][7];
 	u8 pwm_temp_sel[5];
+	u8 pwm_weight_temp_sel[5];
+	u8 weight_temp[3][5];	/* 0->temp_step, 1->temp_step_tol,
+				 * 2->temp_base
+				 */
=20
 	u8 vid;
 	u8 vrm;
@@ -969,6 +992,19 @@ static void nct6775_update_pwm(struct device *dev)
 		/* If fan can stop, report floor as 0 */
 		if (reg & 0x80)
 			data->pwm[2][i] =3D 0;
+
+		reg =3D nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
+		data->pwm_weight_temp_sel[i] =3D reg & 0x1f;
+		/* If weight is disabled, report weight source as 0 */
+		if (j =3D 1 && !(reg & 0x80))
+			data->pwm_weight_temp_sel[i] =3D 0;
+
+		/* Weight temp data */
+		for (j =3D 0; j < 3; j++) {
+			data->weight_temp[j][i]
+			  =3D nct6775_read_value(data,
+					       data->REG_WEIGHT_TEMP[j][i]);
+		}
 	}
 }
=20
@@ -1935,9 +1971,9 @@ store_pwm(struct device *dev, struct device_attribute=
 *attr, const char *buf,
 	int nr =3D sattr->nr;
 	int index =3D sattr->index;
 	unsigned long val;
-	int minval[5] =3D { 0, 1, 1, data->pwm[2][nr], 0 };
-	int maxval[5]
-	  =3D { 255, 255, data->pwm[3][nr] ? : 255, 255, 255 };
+	int minval[7] =3D { 0, 1, 1, data->pwm[2][nr], 0, 0, 0 };
+	int maxval[7]
+	  =3D { 255, 255, data->pwm[3][nr] ? : 255, 255, 255, 255, 255 };
 	int err;
 	u8 reg;
=20
@@ -2075,13 +2111,9 @@ store_pwm_enable(struct device *dev, struct device_a=
ttribute *attr,
 }
=20
 static ssize_t
-show_pwm_temp_sel(struct device *dev, struct device_attribute *attr, char =
*buf)
+show_pwm_temp_sel_common(struct nct6775_data *data, char *buf, int src)
 {
-	struct nct6775_data *data =3D nct6775_update_device(dev);
-	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
-	int i, src, sel =3D 0;
-
-	src =3D data->pwm_temp_sel[sattr->index];
+	int i, sel =3D 0;
=20
 	for (i =3D 0; i < NUM_TEMP; i++) {
 		if (!(data->have_temp & (1 << i)))
@@ -2096,6 +2128,16 @@ show_pwm_temp_sel(struct device *dev, struct device_=
attribute *attr, char *buf)
 }
=20
 static ssize_t
+show_pwm_temp_sel(struct device *dev, struct device_attribute *attr, char =
*buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int index =3D sattr->index;
+
+	return show_pwm_temp_sel_common(data, buf, data->pwm_temp_sel[index]);
+}
+
+static ssize_t
 store_pwm_temp_sel(struct device *dev, struct device_attribute *attr,
 		   const char *buf, size_t count)
 {
@@ -2126,6 +2168,56 @@ store_pwm_temp_sel(struct device *dev, struct device=
_attribute *attr,
 }
=20
 static ssize_t
+show_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int index =3D sattr->index;
+
+	return show_pwm_temp_sel_common(data, buf,
+					data->pwm_weight_temp_sel[index]);
+}
+
+static ssize_t
+store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *att=
r,
+			  const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	int nr =3D sattr->index;
+	unsigned long val;
+	int err, reg, src;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	if (val > NUM_TEMP)
+		return -EINVAL;
+	if (val && (!(data->have_temp & (1 << (val - 1))) ||
+		    !data->temp_src[val - 1]))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	if (val) {
+		src =3D data->temp_src[val - 1];
+		data->pwm_weight_temp_sel[nr] =3D src;
+		reg =3D nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
+		reg &=3D 0xe0;
+		reg |=3D (src | 0x80);
+		nct6775_write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
+	} else {
+		data->pwm_weight_temp_sel[nr] =3D 0;
+		reg =3D nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
+		reg &=3D 0x7f;
+		nct6775_write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t
 show_target_temp(struct device *dev, struct device_attribute *attr, char *=
buf)
 {
 	struct nct6775_data *data =3D nct6775_update_device(dev);
@@ -2379,6 +2471,115 @@ static SENSOR_DEVICE_ATTR(fan5_tolerance, S_IWUSR |=
 S_IRUGO,
 /* Smart Fan registers */
=20
 static ssize_t
+show_weight_temp(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+
+	return sprintf(buf, "%d\n", data->weight_temp[index][nr] * 1000);
+}
+
+static ssize_t
+store_weight_temp(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	int nr =3D sattr->nr;
+	int index =3D sattr->index;
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val =3D SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+
+	mutex_lock(&data->update_lock);
+	data->weight_temp[index][nr] =3D val;
+	nct6775_write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
+			    0);
+static SENSOR_DEVICE_ATTR(pwm2_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
+			    1);
+static SENSOR_DEVICE_ATTR(pwm3_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
+			    2);
+static SENSOR_DEVICE_ATTR(pwm4_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
+			    3);
+static SENSOR_DEVICE_ATTR(pwm5_weight_temp_sel, S_IWUSR | S_IRUGO,
+			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
+			    4);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 3, 0);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 4, 0);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 3, 1);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step_tol, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 3, 2);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step_base, S_IWUSR | S_IRUGO,
+			    show_weight_temp, store_weight_temp, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2(pwm1_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 0, 5);
+static SENSOR_DEVICE_ATTR_2(pwm2_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 1, 5);
+static SENSOR_DEVICE_ATTR_2(pwm3_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 2, 5);
+static SENSOR_DEVICE_ATTR_2(pwm4_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 3, 5);
+static SENSOR_DEVICE_ATTR_2(pwm5_weight_duty_step, S_IWUSR | S_IRUGO,
+			    show_pwm, store_pwm, 4, 5);
+
+/* duty_base is not supported on all chips */
+static struct sensor_device_attribute_2 sda_weight_duty_base[] =3D {
+	SENSOR_ATTR_2(pwm1_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 0, 6),
+	SENSOR_ATTR_2(pwm2_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 1, 6),
+	SENSOR_ATTR_2(pwm3_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 2, 6),
+	SENSOR_ATTR_2(pwm4_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 3, 6),
+	SENSOR_ATTR_2(pwm5_weight_duty_base, S_IWUSR | S_IRUGO,
+		      show_pwm, store_pwm, 4, 6),
+};
+
+static ssize_t
 show_fan_time(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct nct6775_data *data =3D nct6775_update_device(dev);
@@ -2524,7 +2725,7 @@ static struct sensor_device_attribute_2 sda_pwm_step[=
] =3D {
 	SENSOR_ATTR_2(pwm5_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4, 4),
 };
=20
-static struct attribute *nct6775_attributes_pwm[5][15] =3D {
+static struct attribute *nct6775_attributes_pwm[5][20] =3D {
 	{
 		&sensor_dev_attr_pwm1.dev_attr.attr,
 		&sensor_dev_attr_pwm1_mode.dev_attr.attr,
@@ -2540,6 +2741,11 @@ static struct attribute *nct6775_attributes_pwm[5][1=
5] =3D {
 		&sensor_dev_attr_pwm1_step_down_time.dev_attr.attr,
 		&sensor_dev_attr_pwm1_start.dev_attr.attr,
 		&sensor_dev_attr_pwm1_floor.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm1_weight_duty_step.dev_attr.attr,
 		NULL
 	},
 	{
@@ -2557,6 +2763,11 @@ static struct attribute *nct6775_attributes_pwm[5][1=
5] =3D {
 		&sensor_dev_attr_pwm2_step_down_time.dev_attr.attr,
 		&sensor_dev_attr_pwm2_start.dev_attr.attr,
 		&sensor_dev_attr_pwm2_floor.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm2_weight_duty_step.dev_attr.attr,
 		NULL
 	},
 	{
@@ -2574,6 +2785,11 @@ static struct attribute *nct6775_attributes_pwm[5][1=
5] =3D {
 		&sensor_dev_attr_pwm3_step_down_time.dev_attr.attr,
 		&sensor_dev_attr_pwm3_start.dev_attr.attr,
 		&sensor_dev_attr_pwm3_floor.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm3_weight_duty_step.dev_attr.attr,
 		NULL
 	},
 	{
@@ -2591,6 +2807,11 @@ static struct attribute *nct6775_attributes_pwm[5][1=
5] =3D {
 		&sensor_dev_attr_pwm4_step_down_time.dev_attr.attr,
 		&sensor_dev_attr_pwm4_start.dev_attr.attr,
 		&sensor_dev_attr_pwm4_floor.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm4_weight_duty_step.dev_attr.attr,
 		NULL
 	},
 	{
@@ -2608,6 +2829,11 @@ static struct attribute *nct6775_attributes_pwm[5][1=
5] =3D {
 		&sensor_dev_attr_pwm5_step_down_time.dev_attr.attr,
 		&sensor_dev_attr_pwm5_start.dev_attr.attr,
 		&sensor_dev_attr_pwm5_floor.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_sel.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_step.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_step_tol.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_temp_step_base.dev_attr.attr,
+		&sensor_dev_attr_pwm5_weight_duty_step.dev_attr.attr,
 		NULL
 	},
 };
@@ -2972,6 +3198,9 @@ static void nct6775_device_remove_files(struct device=
 *dev)
 	for (i =3D 0; i < ARRAY_SIZE(sda_pwm_step); i++)
 		device_remove_file(dev, &sda_pwm_step[i].dev_attr);
=20
+	for (i =3D 0; i < ARRAY_SIZE(sda_weight_duty_base); i++)
+		device_remove_file(dev, &sda_weight_duty_base[i].dev_attr);
+
 	for (i =3D 0; i < ARRAY_SIZE(sda_auto_pwm_arrays); i++)
 		device_remove_file(dev, &sda_auto_pwm_arrays[i].dev_attr);
=20
@@ -3201,6 +3430,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_PWM[2] =3D NCT6775_REG_FAN_STOP_OUTPUT;
 		data->REG_PWM[3] =3D NCT6775_REG_FAN_MAX_OUTPUT;
 		data->REG_PWM[4] =3D NCT6775_REG_FAN_STEP_OUTPUT;
+		data->REG_PWM[5] =3D NCT6775_REG_WEIGHT_DUTY_STEP;
 		data->REG_PWM_READ =3D NCT6775_REG_PWM_READ;
 		data->REG_PWM_MODE =3D NCT6775_REG_PWM_MODE;
 		data->PWM_MODE_MASK =3D NCT6775_PWM_MODE_MASK;
@@ -3212,6 +3442,10 @@ static int nct6775_probe(struct platform_device *pde=
v)
 		data->REG_TEMP_OFFSET =3D NCT6775_REG_TEMP_OFFSET;
 		data->REG_TEMP_SOURCE =3D NCT6775_REG_TEMP_SOURCE;
 		data->REG_TEMP_SEL =3D NCT6775_REG_TEMP_SEL;
+		data->REG_WEIGHT_TEMP_SEL =3D NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_WEIGHT_TEMP[0] =3D NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] =3D NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM =3D NCT6775_REG_ALARM;
=20
 		reg_temp =3D NCT6775_REG_TEMP;
@@ -3259,6 +3493,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_PWM[0] =3D NCT6775_REG_PWM;
 		data->REG_PWM[1] =3D NCT6775_REG_FAN_START_OUTPUT;
 		data->REG_PWM[2] =3D NCT6775_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[5] =3D NCT6775_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] =3D NCT6776_REG_WEIGHT_DUTY_BASE;
 		data->REG_PWM_READ =3D NCT6775_REG_PWM_READ;
 		data->REG_PWM_MODE =3D NCT6776_REG_PWM_MODE;
 		data->PWM_MODE_MASK =3D NCT6776_PWM_MODE_MASK;
@@ -3270,6 +3506,10 @@ static int nct6775_probe(struct platform_device *pde=
v)
 		data->REG_TEMP_OFFSET =3D NCT6775_REG_TEMP_OFFSET;
 		data->REG_TEMP_SOURCE =3D NCT6775_REG_TEMP_SOURCE;
 		data->REG_TEMP_SEL =3D NCT6775_REG_TEMP_SEL;
+		data->REG_WEIGHT_TEMP_SEL =3D NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_WEIGHT_TEMP[0] =3D NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] =3D NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM =3D NCT6775_REG_ALARM;
=20
 		reg_temp =3D NCT6775_REG_TEMP;
@@ -3317,6 +3557,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_PWM[0] =3D NCT6775_REG_PWM;
 		data->REG_PWM[1] =3D NCT6775_REG_FAN_START_OUTPUT;
 		data->REG_PWM[2] =3D NCT6775_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[5] =3D NCT6775_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] =3D NCT6776_REG_WEIGHT_DUTY_BASE;
 		data->REG_PWM_READ =3D NCT6775_REG_PWM_READ;
 		data->REG_PWM_MODE =3D NCT6776_REG_PWM_MODE;
 		data->PWM_MODE_MASK =3D NCT6776_PWM_MODE_MASK;
@@ -3328,6 +3570,10 @@ static int nct6775_probe(struct platform_device *pde=
v)
 		data->REG_TEMP_OFFSET =3D NCT6779_REG_TEMP_OFFSET;
 		data->REG_TEMP_SOURCE =3D NCT6775_REG_TEMP_SOURCE;
 		data->REG_TEMP_SEL =3D NCT6775_REG_TEMP_SEL;
+		data->REG_WEIGHT_TEMP_SEL =3D NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_WEIGHT_TEMP[0] =3D NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] =3D NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM =3D NCT6779_REG_ALARM;
=20
 		reg_temp =3D NCT6779_REG_TEMP;
@@ -3555,6 +3801,12 @@ static int nct6775_probe(struct platform_device *pde=
v)
 			if (err)
 				goto exit_remove;
 		}
+		if (data->REG_PWM[6]) {
+			err =3D device_create_file(dev,
+					&sda_weight_duty_base[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
 	}
 	for (i =3D 0; i < ARRAY_SIZE(sda_auto_pwm_arrays); i++) {
 		struct sensor_device_attribute_2 *attr --=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
