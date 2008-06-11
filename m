From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
Date: Wed, 11 Jun 2008 05:20:13 +0000
Subject: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <200806110520.m5B5KDgO018954@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I've added fan/pwm control to the f71882fg driver in
linux-2.6.25.4. There's no hardware speed control yet, I intend
to add that later. Since this chip is able to work in RPM and
PWM controlled mode I needed to extend the possible input for
/sys/class/hwmon/hwmon*/pwm*_enable, where the extra value control PWM
vs. RPM mode.

This also raises a question. RPM control seems to be the most appropriate
version of fan control, but I need to add a maximum expected RPM value
to the driver. I was thinking about /sys/class/hwmon/hwmon./fan*_max,
but I would like like some feedback on that.

Please CC me when reacting to this post, since I'm not on the list.

Kind regards,

Mark van Doesburg.


--- /tmp/linux-2.6.25.4/drivers/hwmon/f71882fg.c	2008-05-15 17:00:12.000000=
000 +0200
+++ drivers/hwmon/f71882fg.c	2008-06-11 06:59:42.000000000 +0200
@@ -57,6 +57,7 @@
 #define F71882FG_REG_IN1_HIGH		0x32
=20
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
+#define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
 #define F71882FG_REG_FAN_STATUS		0x92
 #define F71882FG_REG_FAN_BEEP		0x93
=20
@@ -70,6 +71,11 @@
 #define F71882FG_REG_TEMP_TYPE		0x6B
 #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
=20
+
+#define F71882FG_REG_PWM(nr)            (0xA3 + (16 * (nr)))
+#define F71882FG_REG_PWM_TYPE		0x94
+#define F71882FG_REG_PWM_ENABLE         0x96
+
 #define	F71882FG_REG_START		0x01
=20
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
@@ -88,6 +94,7 @@
 static inline void superio_exit(int base);
=20
 static inline u16 fan_from_reg ( u16 reg );
+static inline u16 fan_to_reg ( u16 reg );
=20
 struct f71882fg_data {
 	unsigned short addr;
@@ -104,6 +111,7 @@
 	u8	in_status;
 	u8	in_beep;
 	u16	fan[4];
+	u16	fan_target[4];
 	u8	fan_status;
 	u8	fan_beep;
 	u8	temp[3];
@@ -114,11 +122,15 @@
 	u8	temp_status;
 	u8	temp_beep;
 	u8	temp_diode_open;
+	u8	pwm[4];
+	u8	pwm_enable;
+	u8	pwm_type;
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
@@ -136,6 +148,10 @@
 /* Sysfs Fan */
 static ssize_t show_fan(struct device *dev, struct device_attribute *devat=
tr,
 	char *buf);
+static ssize_t show_fan_target(struct device *dev, struct device_attribute
+	*devattr, char *buf);
+static ssize_t store_fan_target(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count);
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
 	*devattr, char *buf);
 static ssize_t store_fan_beep(struct device *dev, struct device_attribute
@@ -173,6 +189,15 @@
 static ssize_t show_name(struct device *dev, struct device_attribute *deva=
ttr,
 	char *buf);
=20
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
tr,
+	char *buf);
+static ssize_t store_pwm(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count);
+static ssize_t show_pwm_enable(struct device *dev,=20
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count);
+
 static int __devinit f71882fg_probe(struct platform_device * pdev);
 static int __devexit f71882fg_remove(struct platform_device *pdev);
 static int __init f71882fg_init(void);
@@ -252,21 +277,41 @@
 static struct sensor_device_attribute f71882fg_fan_attr[]  {
 	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
+	SENSOR_ATTR(fan1_target, S_IRUGO|S_IWUSR, show_fan_target,
+		store_fan_target, 0),
 	SENSOR_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0),
 	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0),
 	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
+	SENSOR_ATTR(fan2_target, S_IRUGO|S_IWUSR, show_fan_target,
+		store_fan_target, 1),
 	SENSOR_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 1),
 	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1),
 	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
+	SENSOR_ATTR(fan3_target, S_IRUGO|S_IWUSR, show_fan_target,
+		store_fan_target, 2),
 	SENSOR_ATTR(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 2),
 	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 2),
 	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
+	SENSOR_ATTR(fan4_target, S_IRUGO|S_IWUSR, show_fan_target,
+		store_fan_target, 3),
 	SENSOR_ATTR(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 3),
-	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3)
+	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3),
+	SENSOR_ATTR(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0),
+	SENSOR_ATTR(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 1),
+	SENSOR_ATTR(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 2),
+	SENSOR_ATTR(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 3),
+	SENSOR_ATTR(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 0),
+	SENSOR_ATTR(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 1),=20
+	SENSOR_ATTR(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 2),
+	SENSOR_ATTR(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,=20
+		store_pwm_enable, 3)
 };
=20
=20
@@ -310,6 +355,11 @@
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
@@ -338,6 +388,15 @@
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
@@ -399,9 +458,18 @@
=20
 		data->fan_status =3D f71882fg_read8(data,
 						F71882FG_REG_FAN_STATUS);
-		for (nr =3D 0; nr < 4; nr++)
+		data->pwm_type =3D f71882fg_read8(data,
+						F71882FG_REG_PWM_TYPE);
+		data->pwm_enable =3D f71882fg_read8(data,
+						F71882FG_REG_PWM_ENABLE);
+		for (nr =3D 0; nr < 4; nr++) {
 			data->fan[nr] =3D f71882fg_read16(data,
 						F71882FG_REG_FAN(nr));
+			data->fan_target[nr] =3D f71882fg_read16(data,
+						F71882FG_REG_FAN_TARGET(nr));
+			data->pwm[nr] =3D f71882fg_read8(data,
+						F71882FG_REG_PWM(nr));
+                }
=20
 		data->in_status =3D f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
@@ -432,6 +500,30 @@
 	return sprintf(buf, "%d\n", speed);
 }
=20
+static ssize_t show_fan_target(struct device *dev,=20
+	struct device_attribute *devattr, char *buf)
+{
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int speed =3D fan_from_reg(data->fan_target[nr]);
+	return sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t store_fan_target(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+	val=FAn_to_reg(val);
+
+	mutex_lock(&data->update_lock);
+	f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr), val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
@@ -739,6 +831,73 @@
 		return sprintf(buf, "0\n");
 }
=20
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
tr,
+	char *buf)
+{
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	return sprintf(buf, "%d\n", data->pwm[nr]);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_enable(struct device *dev,=20
+struct device_attribute *devattr,
+	char *buf)
+{
+	int result;
+	struct f71882fg_data *data =3D f71882fg_update_device(dev);
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+
+	switch(3&(data->pwm_enable>>(2*nr))) {
+	case 0: result=3D2; break; // Temperature controlled (RPM mode)
+	case 1: result=3D3; break; // Temperature controlled (DUTY CYCLE mode)
+	case 2: result=3D4; break; // Manual mode (RPM control)
+	default: result=3D1; break; // Manual mode (DUTY CYCLE)
+	}
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+	*devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data =3D dev_get_drvdata(dev);
+	int reg;
+	int nr =3D to_sensor_dev_attr(devattr)->index;
+	int val =3D simple_strtoul(buf, NULL, 10);
+
+	switch(val) {
+	case 1: reg=3D3; break; // Manual mode (DUTY CYCLE)
+	case 2: reg=3D0; break; // Temperature controlled (RPM mode)
+	case 3: reg=3D1; break; // Temperature controlled (DUTY CYCLE mode)
+	case 4: reg=3D2; break; // Manual mode (RPM control)
+	default: val=3D0; reg=3D3; break; // Manual mode 100% duty cycle
+	}
+
+	mutex_lock(&data->update_lock);
+	data->pwm_enable&=3D~(3<<(2*nr));
+	data->pwm_enable|=3Dreg<<(2*nr);
+	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
+	if(!val)
+		f71882fg_write8(data, F71882FG_REG_PWM(nr), 255);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_name(struct device *dev, struct device_attribute *deva=
ttr,
 	char *buf)
 {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
