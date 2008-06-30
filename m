From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
Date: Mon, 30 Jun 2008 21:02:05 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <200806302102.m5UL25Bd020777@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Hans,

I'm sorry for the previous mail, I got the parameters for ATTR_2 reversed.
So here are the patches again, and now it works.

Regards,

Mark.


--- /tmp/linux-2.6.25.4/drivers/hwmon/f71882fg.c	2008-05-15 17:00:12.000000=
000 +0200
+++ attr2	2008-06-30 22:57:54.000000000 +0200
@@ -194,79 +194,79 @@
 	__ATTR( name, S_IRUGO, show_name, NULL ),
 };
=20
-static struct sensor_device_attribute f71882fg_in_temp_attr[] +static stru=
ct sensor_device_attribute_2 f71882fg_in_temp_attr[]  {
-	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
-	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
-	SENSOR_ATTR(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max, 1),
-	SENSOR_ATTR(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep, 1),
-	SENSOR_ATTR(in1_alarm, S_IRUGO, show_in_alarm, NULL, 1),
-	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
-	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
-	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
-	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
-	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
-	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
-	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
-	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
-	SENSOR_ATTR(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 0),
-	SENSOR_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 0),
-	SENSOR_ATTR(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 0),
-	SENSOR_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0),
-	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
-	SENSOR_ATTR(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0),
-	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0),
-	SENSOR_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0),
-	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
-	SENSOR_ATTR(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 1),
-	SENSOR_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 1),
-	SENSOR_ATTR(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 1),
-	SENSOR_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 1),
-	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
-	SENSOR_ATTR(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 1),
-	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 1),
-	SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1),
-	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
-	SENSOR_ATTR(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 2),
-	SENSOR_ATTR(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 2),
-	SENSOR_ATTR(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 2),
-	SENSOR_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 2),
-	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
-	SENSOR_ATTR(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 2),
-	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 2),
-	SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2)
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
+	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max, 0, 1),
+	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep, 0, =
1),
+	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
+	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 0, 4),
+	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 0, 5),
+	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
+	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
+	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
+	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 0),
+	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 0),
+	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 0),
+	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 0),
+	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 1),
+	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 1),
+	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 1),
+	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 1),
+	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 2),
+	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 2),
+	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 2),
+	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 2),
+	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2)
 };
=20
-static struct sensor_device_attribute f71882fg_fan_attr[] +static struct s=
ensor_device_attribute_2 f71882fg_fan_attr[]  {
-	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
-	SENSOR_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0),
-	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0),
-	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
-	SENSOR_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 1),
-	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1),
-	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
-	SENSOR_ATTR(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 2),
-	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 2),
-	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
-	SENSOR_ATTR(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 3),
-	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3)
+	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
+	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 0),
+	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
+	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
+	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 1),
+	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
+	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 2),
+	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 3),
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
 };
=20
=20
@@ -423,7 +423,7 @@
 	char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int speed =3D fan_from_reg(data->fan[nr]);
=20
 	if (speed =3D FAN_MIN_DETECT)
@@ -436,7 +436,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->fan_beep & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -448,7 +448,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int val =3D simple_strtoul(buf, NULL, 10);
=20
 	mutex_lock(&data->update_lock);
@@ -467,7 +467,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->fan_status & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -479,7 +479,7 @@
 	char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n", data->in[nr] * 8);
 }
@@ -513,7 +513,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->in_beep & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -525,7 +525,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int val =3D simple_strtoul(buf, NULL, 10);
=20
 	mutex_lock(&data->update_lock);
@@ -544,7 +544,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->in_status & (1 << nr))
 		return sprintf(buf, "1\n");
@@ -556,7 +556,7 @@
 	char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n", data->temp[nr] * 1000);
 }
@@ -565,7 +565,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n", data->temp_high[nr] * 1000);
 }
@@ -574,7 +574,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int val =3D simple_strtoul(buf, NULL, 10) / 1000;
=20
 	if (val > 255)
@@ -592,7 +592,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n",
 		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
@@ -602,7 +602,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int val =3D simple_strtoul(buf, NULL, 10) / 1000;
 	ssize_t ret =3D count;
=20
@@ -642,7 +642,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n", data->temp_ovt[nr] * 1000);
 }
@@ -651,7 +651,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int val =3D simple_strtoul(buf, NULL, 10) / 1000;
=20
 	if (val > 255)
@@ -669,7 +669,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n",
 		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
@@ -679,7 +679,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	return sprintf(buf, "%d\n", data->temp_type[nr]);
 }
@@ -688,7 +688,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->temp_beep & (1 << (nr + 1)))
 		return sprintf(buf, "1\n");
@@ -700,7 +700,7 @@
 	*devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
 	int val =3D simple_strtoul(buf, NULL, 10);
=20
 	mutex_lock(&data->update_lock);
@@ -719,7 +719,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->temp_status & (1 << (nr + 1)))
 		return sprintf(buf, "1\n");
@@ -731,7 +731,7 @@
 	*devattr, char *buf)
 {
 	struct f71882fg_data *data =3D f71882fg_update_device(dev);
-	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
=20
 	if (data->temp_diode_open & (1 << (nr + 1)))
 		return sprintf(buf, "1\n");



--- attr2	2008-06-30 22:57:54.000000000 +0200
+++ f71882fg.c	2008-06-30 22:54:22.000000000 +0200
@@ -57,6 +57,8 @@
 #define F71882FG_REG_IN1_HIGH		0x32
=20
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
+#define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
+#define F71882FG_REG_FAN_FULL_SPEED(nr)	(0xA4 + (16 * (nr)))
 #define F71882FG_REG_FAN_STATUS		0x92
 #define F71882FG_REG_FAN_BEEP		0x93
=20
@@ -70,6 +72,18 @@
 #define F71882FG_REG_TEMP_TYPE		0x6B
 #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
=20
+
+#define F71882FG_REG_PWM(nr)            (0xA3 + (16 * (nr)))
+#define F71882FG_REG_PWM_TYPE		0x94
+#define F71882FG_REG_PWM_ENABLE         0x96
+
+#define F71882FG_REG_FAN_HYST0		0x98
+#define F71882FG_REG_FAN_HYST1		0x99
+
+#define F71882FG_REG_POINT_PWM(pwm,point)	(0xAA + point + (16 * (pwm)))
+#define F71882FG_REG_POINT_TEMP(pwm,point)	(0xA6 + point + (16 * (pwm)))
+#define F71882FG_REG_POINT_MAPPING(nr)		(0xAF + 16*(nr))
+
 #define	F71882FG_REG_START		0x01
=20
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
@@ -78,6 +92,12 @@
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
=20
+static int fan_mode[4]=3D{0, 0, 0, 0};
+module_param_array(fan_mode, int, NULL, 0);
+MODULE_PARM_DESC(fan_mode,=20
+	"List of fan modes (for four fans) (0=3Ddon't change, 1=3Dpwm, 2=3Drpm");
+
+
 static struct platform_device *f71882fg_pdev =3D NULL;
=20
 /* Super-I/O Function prototypes */
@@ -88,6 +108,7 @@
 static inline void superio_exit(int base);
=20
 static inline u16 fan_from_reg ( u16 reg );
+static inline u16 fan_to_reg ( u16 reg );
=20
 struct f71882fg_data {
 	unsigned short addr;
@@ -104,6 +125,8 @@
 	u8	in_status;
 	u8	in_beep;
 	u16	fan[4];
+	u16	fan_target[4];
+	u16	fan_full_speed[4];
 	u8	fan_status;
 	u8	fan_beep;
 	u8	temp[3];
@@ -114,11 +137,19 @@
 	u8	temp_status;
 	u8	temp_beep;
 	u8	temp_diode_open;
+	u8	pwm[4];
+	u8	pwm_enable;
+	u8	pwm_type;
+	u8	pwm_auto_point_hyst[2];
+	u8	pwm_auto_point_mapping[4];
+	u8	pwm_auto_point_pwm[4][5];
+	u8	pwm_auto_point_temp[4][4];
 };
=20
 static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
 static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
 static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);
+static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val);
=20
 /* Sysfs in*/
 static ssize_t show_in(struct device *dev, struct device_attribute *devatt=
r,
@@ -136,6 +167,10 @@
 /* Sysfs Fan */
 static ssize_t show_fan(struct device *dev, struct device_attribute *devat=
tr,
 	char *buf);
+static ssize_t show_fan_full_speed(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_fan_full_speed(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count);
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
 	*devattr, char *buf);
 static ssize_t store_fan_beep(struct device *dev, struct device_attribute
@@ -173,6 +208,36 @@
 static ssize_t show_name(struct device *dev, struct device_attribute *deva=
ttr,
 	char *buf);
=20
+/* PWM and Auto point control */
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
tr,
+	char *buf);
+static ssize_t store_pwm(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count);
+static ssize_t show_pwm_enable(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count);
+static ssize_t show_pwm_interpolate(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_interpolate(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_channel(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_channel(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_pwm(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_pwm(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_temp(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_temp(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count);
+
 static int __devinit f71882fg_probe(struct platform_device * pdev);
 static int __devexit f71882fg_remove(struct platform_device *pdev);
 static int __init f71882fg_init(void);
@@ -252,21 +317,181 @@
 static struct sensor_device_attribute_2 f71882fg_fan_attr[]  {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
+	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 0, 0),
 	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 0),
 	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
 	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
+	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 0, 1),
 	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 1),
 	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
+	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 0, 2),
 	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 2),
 	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 0, 3),
 	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 3),
-	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
+
+	SENSOR_ATTR_2(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 0),
+	SENSOR_ATTR_2(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 0, 0),
+	SENSOR_ATTR_2(pwm1_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		0, 0),
+	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		4, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		3, 0),
+
+	SENSOR_ATTR_2(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 1),
+	SENSOR_ATTR_2(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 0, 1),
+	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		0, 1),
+	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		4, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		3, 1),
+
+	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 0, 2),
+	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		0, 2),
+	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		4, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		3, 2),
+
+	SENSOR_ATTR_2(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 3),
+	SENSOR_ATTR_2(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 0, 3),
+	SENSOR_ATTR_2(pwm4_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		0, 3),
+	SENSOR_ATTR_2(pwm4_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		4, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		3, 3)
 };
=20
=20
@@ -310,6 +535,11 @@
 	return reg ? (1500000 / reg) : 0;
 }
=20
+static inline u16 fan_to_reg(u16 fan)
+{
+	return fan ? (1500000/fan) : 0;
+}
+
 static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg)
 {
 	u8 val;
@@ -338,6 +568,15 @@
 	outb(val, data->addr + DATA_REG_OFFSET);
 }
=20
+static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val)
+{
+	outb(reg++, data->addr + ADDR_REG_OFFSET);
+	outb(val>>8, data->addr + DATA_REG_OFFSET);
+	outb(reg, data->addr + ADDR_REG_OFFSET);
+	outb(val&255, data->addr + DATA_REG_OFFSET);
+}
+
+
 static struct f71882fg_data *f71882fg_update_device(struct device * dev)
 {
 	struct f71882fg_data *data =3D dev_get_drvdata(dev);
@@ -399,9 +638,37 @@
=20
 		data->fan_status =3D f71882fg_read8(data,
 						F71882FG_REG_FAN_STATUS);
-		for (nr =3D 0; nr < 4; nr++)
+		data->pwm_type =3D f71882fg_read8(data,
+						F71882FG_REG_PWM_TYPE);
+		data->pwm_enable =3D f71882fg_read8(data,
+						F71882FG_REG_PWM_ENABLE);
+		data->pwm_auto_point_hyst[0] =3D f71882fg_read8(data,
+						F71882FG_REG_FAN_HYST0);
+		data->pwm_auto_point_hyst[1] =3D f71882fg_read8(data,
+						F71882FG_REG_FAN_HYST1);
+		for (nr =3D 0; nr < 4; nr++) {
+			int point;
 			data->fan[nr] =3D f71882fg_read16(data,
-						F71882FG_REG_FAN(nr));
+				F71882FG_REG_FAN(nr));
+			data->fan_target[nr] =3D f71882fg_read16(data,
+				F71882FG_REG_FAN_TARGET(nr));
+			data->fan_full_speed[nr] =3D f71882fg_read16(data,
+				F71882FG_REG_FAN_FULL_SPEED(nr));
+			data->pwm[nr] =3D f71882fg_read8(data,
+				F71882FG_REG_PWM(nr));
+			data->pwm_auto_point_mapping[nr] =3D f71882fg_read8(data,
+				F71882FG_REG_POINT_MAPPING(nr));
+			for(point=3D0;point<5;point++) {
+				data->pwm_auto_point_pwm[nr][point]+					f71882fg_read8(data,
+						F71882FG_REG_POINT_PWM(nr,
+							point));
+				data->pwm_auto_point_temp[nr][point]+					f71882fg_read8(data,
+						F71882FG_REG_POINT_TEMP(nr,
+							point));
+			}
+                }
=20
 		data->in_status =3D f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
@@ -432,6 +699,34 @@
 	return sprintf(buf, "%d\n", speed);
 }
=20
+static ssize_t show_fan_full_speed(struct device *dev,=20
+	struct device_attribute *devattr, char *buf)
+{
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int speed =3D fan_from_reg(data->fan_full_speed[nr]);
+	return sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t store_fan_full_speed(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if(data->pwm_enable&(1<<(2*nr)))
+		count=3D-EINVAL;
+	else
+		f71882fg_write16(data, F71882FG_REG_FAN_FULL_SPEED(nr),=20
+			fan_to_reg(val));
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
@@ -739,6 +1034,276 @@
 		return sprintf(buf, "0\n");
 }
=20
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
tr,
+	char *buf)
+{
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int val, nr =3D to_sensor_dev_attr_2(devattr)->index;
+	if(data->pwm_enable&(1<<(2*nr)))
+		// PWM mode
+		val=DAta->pwm[nr];
+	else
+		// RPM mode
+		val%5*fan_from_reg(data->fan_target[nr])
+			/fan_from_reg(data->fan_full_speed[nr]);
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute *deva=
ttr,=20
+	const char *buf, size_t count)
+{
+	// struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if(data->pwm_enable&(1<<(2*nr)))
+		// PWM mode
+		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
+	else {
+		// RPM mode
+		int target=3Dval*fan_from_reg(data->fan_full_speed[nr])/255;
+		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr),=20
+			fan_to_reg(target));
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_enable(struct device *dev,=20
+	struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+
+	if(2&(data->pwm_enable>>(2*nr)))
+		result=3D1;
+	else
+		result=3D2;
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	if(val<0 || val>2)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	switch(val) {
+	case 1: data->pwm_enable|=3D2<<(2*nr); break;	// Manual
+	case 2: data->pwm_enable&=3D~(2<<(2*nr)); break;	// Temperature ctrl
+	}
+	switch(fan_mode[nr]) {
+	case 1: data->pwm_enable|=3D1<<(2*nr); break;	// RPM mode
+	case 2: data->pwm_enable&=3D~(1<<(2*nr)); break;	// Duty cycle mode
+	}
+	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
+	mutex_unlock(&data->update_lock);
+	if(!val)
+		store_pwm(dev,devattr,"255",4);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_pwm(struct device *dev,=20
+	struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int pwm =3D to_sensor_dev_attr_2(devattr)->index;
+	int point =3D to_sensor_dev_attr_2(devattr)->nr;
+
+	if(data->pwm_enable&(1<<(2*pwm))) {
+		// PWM mode
+		result=DAta->pwm_auto_point_pwm[pwm][point];
+	} else {
+		// RPM mode
+		result2*255/(32+data->pwm_auto_point_pwm[pwm][point]);
+	}
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_pwm(struct device *dev,=20
+	struct device_attribute *devattr,=20
+	const char *buf, size_t count)
+{
+	// struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int pwm =3D to_sensor_dev_attr_2(devattr)->index;
+	int point =3D to_sensor_dev_attr_2(devattr)->nr;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if(data->pwm_enable&(1<<(2*pwm))) {
+		// PWM mode
+		f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm,point), val);
+	} else {
+		// RPM mode
+		if(val<29)	// Prevent negative numbers
+			val%5;
+		else
+			val=3D(255-val)*32/val;
+		f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm,point),val);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev,=20
+	struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+
+	switch(nr) {
+	case 0: result=DAta->pwm_auto_point_hyst[0]&15; break;
+	case 1: result=DAta->pwm_auto_point_hyst[0]>>4; break;
+	case 2: result=DAta->pwm_auto_point_hyst[1]&15; break;
+	case 3: result=DAta->pwm_auto_point_hyst[1]>>4; break;
+	default: result=3D-1;
+	}
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,=20
+	struct device_attribute *devattr,=20
+	const char *buf, size_t count)
+{
+	// struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	val&=15;
+	switch(nr) {
+	case 0: val=3D(data->pwm_auto_point_hyst[0]&0xf0)|val; break;
+	case 1: val=3D(data->pwm_auto_point_hyst[0]&0x0f)|(val<<4); break;
+	case 2: val=3D(data->pwm_auto_point_hyst[1]&0xf0)|val; break;
+	case 3: val=3D(data->pwm_auto_point_hyst[1]&0x0f)|(val<<4); break;
+	}
+
+	mutex_lock(&data->update_lock);
+	if(nr=3D0 || nr=3D1)
+		f71882fg_write8(data, F71882FG_REG_FAN_HYST0, val);=20
+	else
+		f71882fg_write8(data, F71882FG_REG_FAN_HYST1, val);=20
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_interpolate(struct device *dev,=20
+	struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+
+	result=3D1&(data->pwm_auto_point_mapping[nr]>>4);
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_interpolate(struct device *dev,=20
+	struct device_attribute *devattr,=20
+	const char *buf, size_t count)
+{
+	// struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	if(val)
+		val=DAta->pwm_auto_point_mapping[nr]|(1<<4);
+	else
+		val=DAta->pwm_auto_point_mapping[nr]&(~(1<<4));
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);=20
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+static ssize_t show_pwm_auto_point_channel(struct device *dev,=20
+	struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+
+	result=3D1<<(data->pwm_auto_point_mapping[nr]&3);
+	result>>=3D1;
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_channel(struct device *dev,=20
+	struct device_attribute *devattr,=20
+	const char *buf, size_t count)
+{
+	// struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr_2(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	switch(val) {
+	case 1: val=3D1; break;
+	case 2: val=3D2; break;
+	case 4: val=3D3; break;
+	default: return -EINVAL;
+	}
+	val|=DAta->pwm_auto_point_mapping[nr]&0xfc;
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);=20
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_temp(struct device *dev,=20
+	struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int pwm =3D to_sensor_dev_attr_2(devattr)->index;
+	int point =3D to_sensor_dev_attr_2(devattr)->nr;
+
+	result=DAta->pwm_auto_point_temp[pwm][point];
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_temp(struct device *dev,=20
+	struct device_attribute *devattr,=20
+	const char *buf, size_t count)
+{
+	// struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int pwm =3D to_sensor_dev_attr_2(devattr)->index;
+	int point =3D to_sensor_dev_attr_2(devattr)->nr;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_POINT_TEMP(pwm,point), val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+
 static ssize_t show_name(struct device *dev, struct device_attribute *deva=
ttr,
 	char *buf)
 {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
