From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
Date: Wed, 25 Jun 2008 06:14:58 +0000
Subject: [lm-sensors]  [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <200806250614.m5P6EwPZ020646@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I've finally added some missing features to the driver. There are still
some things unimplemented, such as:

	1. Changing the fan target reached timeout.
	2. Something to set FAN?_RATE_SEL. =20
	3. FAN?_STOP_DUTY
	4. FAN?_JUMP_HIGH_EN and FAN?_JUMP_LOW_EN=20

Mostly because I don't need them, and there is no default name for
these features.

I did add one entry to set/reset the interpolation mode of the auto_point
follower, to make the pwm control act as a P-regulator. Simply because
I like it, it prevents rapid speedups and slowdowns of the fan.

Since the auto_point follower is able to track only one temperature at
a time, I gave a preference to the lowest numbered one. Maybe returning
an error would be better if the user tries to set an impossible value ?

regards,

Mark van Doesburg


--- /tmp/linux-2.6.25.4/drivers/hwmon/f71882fg.c	2008-05-15 17:00:12.000000=
000 +0200
+++ ./f71882fg.c	2008-06-25 07:43:52.000000000 +0200
@@ -57,6 +57,8 @@
 #define F71882FG_REG_IN1_HIGH		0x32
=20
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
+#define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
+#define F71882FG_REG_FAN_FULL_SPEED(nr)	(0xA4 + (16 * (nr)))
 #define F71882FG_REG_FAN_STATUS		0x92
 #define F71882FG_REG_FAN_BEEP		0x93
=20
@@ -70,14 +72,36 @@
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
=20
+#define AUTO_POINT(pwm,point) ((pwm<<4)|(point))
+#define AUTO_POINT_PWM(val) ((val)>>4)
+#define AUTO_POINT_POINT(val) ((val)&15)
+
 static unsigned short force_id;
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
@@ -88,6 +112,7 @@
 static inline void superio_exit(int base);
=20
 static inline u16 fan_from_reg ( u16 reg );
+static inline u16 fan_to_reg ( u16 reg );
=20
 struct f71882fg_data {
 	unsigned short addr;
@@ -104,6 +129,8 @@
 	u8	in_status;
 	u8	in_beep;
 	u16	fan[4];
+	u16	fan_target[4];
+	u16	fan_full_speed[4];
 	u8	fan_status;
 	u8	fan_beep;
 	u8	temp[3];
@@ -114,11 +141,19 @@
 	u8	temp_status;
 	u8	temp_beep;
 	u8	temp_diode_open;
+	u8	pwm[4];
+	u8	pwm_enable;
+	u8	pwm_type;
+	u8	pwm_auto_point_hyst[2];
+	u8	pwm_auto_point_mapping[4];
+	u8	pwm_auto_point_pwm[4][4];
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
@@ -136,6 +171,10 @@
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
@@ -173,6 +212,36 @@
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
@@ -252,21 +321,181 @@
 static struct sensor_device_attribute f71882fg_fan_attr[]  {
 	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
+	SENSOR_ATTR(fan1_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 0),
 	SENSOR_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0),
 	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0),
 	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
+	SENSOR_ATTR(fan2_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 1),
 	SENSOR_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 1),
 	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1),
 	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
+	SENSOR_ATTR(fan3_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 2),
 	SENSOR_ATTR(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 2),
 	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 2),
 	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
+	SENSOR_ATTR(fan4_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed,=20
+		store_fan_full_speed, 3),
 	SENSOR_ATTR(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 3),
-	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3)
+	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3),
+
+	SENSOR_ATTR(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0),
+	SENSOR_ATTR(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 0),
+	SENSOR_ATTR(pwm1_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 0),
+	SENSOR_ATTR(pwm1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		0),
+	SENSOR_ATTR(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0),
+	SENSOR_ATTR(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(0,0)),
+	SENSOR_ATTR(pwm1_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(0,1)),
+	SENSOR_ATTR(pwm1_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(0,2)),
+	SENSOR_ATTR(pwm1_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(0,3)),
+	SENSOR_ATTR(pwm1_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(0,4)),
+	SENSOR_ATTR(pwm1_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(0,0)),
+	SENSOR_ATTR(pwm1_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(0,1)),
+	SENSOR_ATTR(pwm1_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(0,2)),
+	SENSOR_ATTR(pwm1_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(0,3)),
+
+	SENSOR_ATTR(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 1),
+	SENSOR_ATTR(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 1),
+	SENSOR_ATTR(pwm2_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 1),
+	SENSOR_ATTR(pwm2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		1),
+	SENSOR_ATTR(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 1),
+	SENSOR_ATTR(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(1,0)),
+	SENSOR_ATTR(pwm2_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(1,1)),
+	SENSOR_ATTR(pwm2_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(1,2)),
+	SENSOR_ATTR(pwm2_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(1,3)),
+	SENSOR_ATTR(pwm2_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(1,4)),
+	SENSOR_ATTR(pwm2_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(1,0)),
+	SENSOR_ATTR(pwm2_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(1,1)),
+	SENSOR_ATTR(pwm2_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(1,2)),
+	SENSOR_ATTR(pwm2_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(1,3)),
+
+	SENSOR_ATTR(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 2),
+	SENSOR_ATTR(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 2),
+	SENSOR_ATTR(pwm3_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 2),
+	SENSOR_ATTR(pwm3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		2),
+	SENSOR_ATTR(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 2),
+	SENSOR_ATTR(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(2,0)),
+	SENSOR_ATTR(pwm3_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(2,1)),
+	SENSOR_ATTR(pwm3_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(2,2)),
+	SENSOR_ATTR(pwm3_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(2,3)),
+	SENSOR_ATTR(pwm3_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(2,4)),
+	SENSOR_ATTR(pwm3_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(2,0)),
+	SENSOR_ATTR(pwm3_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(2,1)),
+	SENSOR_ATTR(pwm3_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(2,2)),
+	SENSOR_ATTR(pwm3_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(2,3)),
+
+	SENSOR_ATTR(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 3),
+	SENSOR_ATTR(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 3),
+	SENSOR_ATTR(pwm4_interpolate, S_IRUGO|S_IWUSR,=20
+		show_pwm_interpolate, store_pwm_interpolate, 3),
+	SENSOR_ATTR(pwm4_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst,=20
+		3),
+	SENSOR_ATTR(pwm4_auto_channels_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 3),
+	SENSOR_ATTR(pwm4_auto_point1_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(3,0)),
+	SENSOR_ATTR(pwm4_auto_point2_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(3,1)),
+	SENSOR_ATTR(pwm4_auto_point3_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(3,2)),
+	SENSOR_ATTR(pwm4_auto_point4_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(3,3)),
+	SENSOR_ATTR(pwm4_auto_point5_pwm, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,=20
+		AUTO_POINT(3,4)),
+	SENSOR_ATTR(pwm4_auto_point1_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(3,0)),
+	SENSOR_ATTR(pwm4_auto_point2_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(3,1)),
+	SENSOR_ATTR(pwm4_auto_point3_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(3,2)),
+	SENSOR_ATTR(pwm4_auto_point4_temp, S_IRUGO|S_IWUSR,=20
+		show_pwm_auto_point_temp, store_pwm_auto_point_temp,=20
+		AUTO_POINT(3,3))
 };
=20
=20
@@ -310,6 +539,11 @@
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
@@ -338,6 +572,15 @@
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
@@ -399,9 +642,37 @@
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
+			for(point=3D0;point<4;point++) {
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
@@ -432,6 +703,34 @@
 	return sprintf(buf, "%d\n", speed);
 }
=20
+static ssize_t show_fan_full_speed(struct device *dev,=20
+	struct device_attribute *devattr, char *buf)
+{
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int speed =3D fan_from_reg(data->fan_full_speed[nr]);
+	return sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t store_fan_full_speed(struct device *dev,=20
+	struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
@@ -739,6 +1038,291 @@
 		return sprintf(buf, "0\n");
 }
=20
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
tr,
+	char *buf)
+{
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int val, nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int result, point, pwm;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+
+	pwm=3DAUTO_POINT_PWM(nr);
+	point=3DAUTO_POINT_POINT(nr);
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
+	int point, pwm;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	pwm=3DAUTO_POINT_PWM(nr);
+	point=3DAUTO_POINT_POINT(nr);
+
+	mutex_lock(&data->update_lock);
+	if(data->pwm_enable&(1<<(2*pwm))) {
+		// PWM mode
+		f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm,point), val);
+		printk(KERN_INFO "nr=3D%d writing %d to 0x%x\n",
+			nr, val, F71882FG_REG_POINT_PWM(pwm,point));
+	} else {
+		// RPM mode
+		if(val<29)	// Prevent negative numbers
+			val%5;
+		else
+			val=3D(255-val)*32/val;
+		f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm,point),val);
+		printk(KERN_INFO "RPM nr=3D%d writing %d to 0x%x\n",
+			nr, val, F71882FG_REG_POINT_PWM(pwm,point));
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	if(val)
+		val|=DAta->pwm_auto_point_mapping[nr]|(1<<4);
+	else
+		val&=DAta->pwm_auto_point_mapping[nr]|(~(1<<4));
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
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
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	if(val&1)
+		val=3D1;
+	else if(val&2)
+		val=3D2;
+	else
+		val=3D3;
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
+	int result, point, pwm;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+
+	pwm=3DAUTO_POINT_PWM(nr);
+	point=3DAUTO_POINT_POINT(nr);
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
+	int point, pwm;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	pwm=3DAUTO_POINT_PWM(nr);
+	point=3DAUTO_POINT_POINT(nr);
+
+	mutex_lock(&data->update_lock);
+	printk(KERN_INFO "writing %x\n",F71882FG_REG_POINT_TEMP(pwm,point));
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
