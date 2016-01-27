From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
Date: Wed, 27 Jan 2016 02:03:39 +0000
Subject: [lm-sensors] [PATCH v3 15/25] hwmon: (it87) Support up to 6 temperature sensors on IT8620E
Message-Id: <1453860229-23614-16-git-send-email-patchwork@patchwork.roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Add support for the additional temperature sensors on IT8620E.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e02c972ef81e..722d6de62d1c 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -219,7 +219,7 @@ static bool fix_pwm_polarity;
 #define IT87_REG_FAN_DIV       0x0b
 #define IT87_REG_FAN_16BIT     0x0c
=20
-/* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) =
*/
+/* Monitors: 9 voltage (0 to 7, battery), 6 temp (1 to 6), 3 fan (1 to 3) =
*/
=20
 static const u8 IT87_REG_FAN[]         =3D { 0x0d, 0x0e, 0x0f, 0x80, 0x82,=
 0x4c };
 static const u8 IT87_REG_FAN_MIN[]     =3D { 0x10, 0x11, 0x12, 0x84, 0x86,=
 0x4e };
@@ -252,10 +252,12 @@ static const u8 IT87_REG_PWM_DUTY[]    =3D { 0x63, 0x=
6b, 0x73, 0x7b, 0xa3, 0xab };
 #define IT87_REG_AUTO_TEMP(nr, i) (0x60 + (nr) * 8 + (i))
 #define IT87_REG_AUTO_PWM(nr, i)  (0x65 + (nr) * 8 + (i))
=20
+#define IT87_REG_TEMP456_ENABLE	0x77
+
 struct it87_devices {
 	const char *name;
 	const char * const suffix;
-	u16 features;
+	u32 features;
 	u8 peci_mask;
 	u8 old_peci_mask;
 };
@@ -276,6 +278,7 @@ struct it87_devices {
 #define FEAT_AVCC3		(1 << 13)	/* Chip supports in9/AVCC3 */
 #define FEAT_SIX_PWM		(1 << 14)	/* Chip supports 6 pwm chn */
 #define FEAT_PWM_FREQ2		(1 << 15)	/* Separate pwm freq 2 */
+#define FEAT_SIX_TEMP		(1 << 16)	/* Up to 6 temp sensors */
=20
 static const struct it87_devices it87_devices[] =3D {
 	[it87] =3D {
@@ -412,7 +415,8 @@ static const struct it87_devices it87_devices[] =3D {
 		.suffix =3D "E",
 		.features =3D FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
 		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_SIX_FANS
-		  | FEAT_IN7_INTERNAL | FEAT_SIX_PWM | FEAT_PWM_FREQ2,
+		  | FEAT_IN7_INTERNAL | FEAT_SIX_PWM | FEAT_PWM_FREQ2
+		  | FEAT_SIX_TEMP,
 		.peci_mask =3D 0x07,
 	},
 };
@@ -437,6 +441,7 @@ static const struct it87_devices it87_devices[] =3D {
 #define has_avcc3(data)		((data)->features & FEAT_AVCC3)
 #define has_six_pwm(data)	((data)->features & FEAT_SIX_PWM)
 #define has_pwm_freq2(data)	((data)->features & FEAT_PWM_FREQ2)
+#define has_six_temp(data)	((data)->features & FEAT_SIX_TEMP)
=20
 struct it87_sio_data {
 	enum chips type;
@@ -477,7 +482,7 @@ struct it87_data {
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[6][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
-	s8 temp[3][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
+	s8 temp[6][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
 	u8 sensor;		/* Register value (IT87_REG_TEMP_ENABLE) */
 	u8 extra;		/* Register value (IT87_REG_TEMP_EXTRA) */
 	u8 fan_div[3];		/* Register encoding, shifted right */
@@ -704,11 +709,16 @@ static struct it87_data *it87_update_device(struct de=
vice *dev)
 						IT87_REG_FANX_MIN[i]) << 8;
 			}
 		}
-		for (i =3D 0; i < 3; i++) {
+		for (i =3D 0; i < 6; i++) {
 			if (!(data->has_temp & (1 << i)))
 				continue;
 			data->temp[i][0]  				it87_read_value(data, IT87_REG_TEMP(i));
+
+			/* No limits/offset for additional sensors */
+			if (i >=3D 3)
+				continue;
+
 			data->temp[i][1]  				it87_read_value(data, IT87_REG_TEMP_LOW(i));
 			data->temp[i][2] @@ -848,7 +858,7 @@ static SENSOR_DEVICE_ATTR_2(in7_ma=
x, S_IRUGO | S_IWUSR, show_in, set_in,
 static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 8, 0);
 static SENSOR_DEVICE_ATTR_2(in9_input, S_IRUGO, show_in, NULL, 9, 0);
=20
-/* 3 temperatures */
+/* Up to 6 temperatures */
 static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -921,6 +931,9 @@ static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUS=
R, show_temp, set_temp,
 			    2, 2);
 static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGO | S_IWUSR, show_temp,
 			    set_temp, 2, 3);
+static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 3, 0);
+static SENSOR_DEVICE_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 4, 0);
+static SENSOR_DEVICE_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 5, 0);
=20
 static ssize_t show_temp_type(struct device *dev, struct device_attribute =
*attr,
 			      char *buf)
@@ -1828,6 +1841,11 @@ static umode_t it87_temp_is_visible(struct kobject *=
kobj,
 	int i =3D index / 7;	/* temperature index */
 	int a =3D index % 7;	/* attribute index */
=20
+	if (index >=3D 21) {
+		i =3D index - 21 + 3;
+		a =3D 0;
+	}
+
 	if (!(data->has_temp & (1 << i)))
 		return 0;
=20
@@ -1849,7 +1867,7 @@ static struct attribute *it87_attributes_temp[] =3D {
 	&sensor_dev_attr_temp1_offset.dev_attr.attr,	/* 5 */
 	&sensor_dev_attr_temp1_beep.dev_attr.attr,	/* 6 */
=20
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,	/* 7 */
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_type.dev_attr.attr,
@@ -1857,7 +1875,7 @@ static struct attribute *it87_attributes_temp[] =3D {
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_beep.dev_attr.attr,
=20
-	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,	/* 14 */
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
@@ -1865,6 +1883,9 @@ static struct attribute *it87_attributes_temp[] =3D {
 	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_beep.dev_attr.attr,
=20
+	&sensor_dev_attr_temp4_input.dev_attr.attr,	/* 21 */
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
 	NULL
 };
=20
@@ -2710,6 +2731,17 @@ static int it87_probe(struct platform_device *pdev)
 	data->in_internal =3D sio_data->internal;
 	data->has_in =3D 0x3ff & ~sio_data->skip_in;
=20
+	if (has_six_temp(data)) {
+		u8 reg =3D it87_read_value(data, IT87_REG_TEMP456_ENABLE);
+
+		if ((reg & 0x03) >=3D 0x02)
+			data->has_temp |=3D (1 << 3);
+		if (((reg >> 2) & 0x03) >=3D 0x02)
+			data->has_temp |=3D (1 << 4);
+		if (((reg >> 4) & 0x03) >=3D 0x02)
+			data->has_temp |=3D (1 << 5);
+	}
+
 	data->has_beep =3D !!sio_data->beep_pin;
=20
 	/* Initialize the IT87 chip */
--=20
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
