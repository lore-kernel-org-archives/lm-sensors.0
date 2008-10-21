From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 14:24:35 +0000
Subject: [lm-sensors] PATCH: f71882fg add support for the f71862fg superio
Message-Id: <48FDE623.5000002@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070206070405080808090401"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206070405080808090401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for the Fintek f71862fg superio monitoring functions to
the f71882fg driver.

This support has been tested without problems on a Jetway J9F2 by
Tony McConnell.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------070206070405080808090401
Content-Type: text/plain;
 name="f71882fg-add-f71862fg-support-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="f71882fg-add-f71862fg-support-v2.patch"

This patch adds support for the Fintek f71862fg superio monitoring functions to
the f71882fg driver.

This support has been tested without problems on a Jetway J9F2 by
Tony McConnell.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.cleaned-up	2008-10-21 14:40:35.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2008-10-21 14:48:46.000000000 +0200
@@ -43,6 +43,7 @@
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
 #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
+#define SIO_F71862_ID		0x0601	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 
 #define REGION_LENGTH		8
@@ -51,10 +52,10 @@
 
 #define F71882FG_REG_PECI		0x0A
 
-#define F71882FG_REG_IN_STATUS		0x12
-#define F71882FG_REG_IN_BEEP		0x13
+#define F71882FG_REG_IN_STATUS		0x12 /* f71882fg only */
+#define F71882FG_REG_IN_BEEP		0x13 /* f71882fg only */
 #define F71882FG_REG_IN(nr)		(0x20  + (nr))
-#define F71882FG_REG_IN1_HIGH		0x32
+#define F71882FG_REG_IN1_HIGH		0x32 /* f71882fg only */
 
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
 #define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
@@ -97,6 +98,13 @@
 		 "(0=don't change, 1=pwm, 2=rpm)\n"
 		 "Note: this needs a write to pwm#_enable to take effect");
 
+enum chips { f71862fg, f71882fg };
+
+static const char *f71882fg_names[] = {
+	"f71862fg",
+	"f71882fg",
+};
+
 static struct platform_device *f71882fg_pdev;
 
 /* Super-I/O Function prototypes */
@@ -106,8 +114,13 @@
 static inline void superio_select(int base, int ld);
 static inline void superio_exit(int base);
 
+struct f71882fg_sio_data {
+	enum chips type;
+};
+
 struct f71882fg_data {
 	unsigned short addr;
+	enum chips type;
 	struct device *hwmon_dev;
 
 	struct mutex update_lock;
@@ -241,15 +254,10 @@
 
 DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] =
+static struct sensor_device_attribute_2 f718x2fg_in_temp_attr[] =
 {
 	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
 	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
-	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max,
-		0, 1),
-	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep,
-		0, 1),
-	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
 	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
 	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 0, 4),
@@ -301,7 +309,15 @@
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2)
 };
 
-static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
+static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] = {
+	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max,
+		0, 1),
+	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep,
+		0, 1),
+	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
+};
+
+static struct sensor_device_attribute_2 f718x2fg_fan_attr[] = {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
 	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO|S_IWUSR,
 		      show_fan_full_speed,
@@ -323,13 +339,6 @@
 	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 2),
 	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
-	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
-	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
-		      show_fan_full_speed,
-		      store_fan_full_speed, 0, 3),
-	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 3),
-	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
 
 	SENSOR_ATTR_2(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 0),
 	SENSOR_ATTR_2(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
@@ -339,6 +348,75 @@
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 0),
+
+	SENSOR_ATTR_2(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 1),
+	SENSOR_ATTR_2(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 1),
+	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 1),
+
+	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 2),
+	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 2),
+};
+
+static struct sensor_device_attribute_2 f71862fg_fan_attr[] = {
+	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
+
+	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
+};
+
+static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
+	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 3),
+	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 3),
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
+
 	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 0),
@@ -377,14 +455,6 @@
 	SENSOR_ATTR_2(pwm1_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
 
-	SENSOR_ATTR_2(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 1),
-	SENSOR_ATTR_2(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-		      store_pwm_enable, 0, 1),
-	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO|S_IWUSR,
-		      show_pwm_interpolate, store_pwm_interpolate, 0, 1),
-	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
-		      show_pwm_auto_point_channel,
-		      store_pwm_auto_point_channel, 0, 1),
 	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 1),
@@ -423,14 +493,6 @@
 	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
 
-	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
-	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-		      store_pwm_enable, 0, 2),
-	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,
-		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
-	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
-		      show_pwm_auto_point_channel,
-		      store_pwm_auto_point_channel, 0, 2),
 	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 2),
@@ -601,14 +663,19 @@
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr, reg, reg2;
+	int nr_fans = (data->type == f71862fg) ? 3 : 4;
 
 	mutex_lock(&data->update_lock);
 
 	/* Update once every 60 seconds */
 	if ( time_after(jiffies, data->last_limits + 60 * HZ ) ||
 			!data->valid) {
-		data->in1_max = f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
-		data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
+		if (data->type == f71882fg) {
+			data->in1_max =
+				f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
+			data->in_beep =
+				f71882fg_read8(data, F71882FG_REG_IN_BEEP);
+		}
 
 		/* Get High & boundary temps*/
 		for (nr = 0; nr < 3; nr++) {
@@ -649,24 +716,42 @@
 						      F71882FG_REG_FAN_HYST0);
 		data->pwm_auto_point_hyst[1] = f71882fg_read8(data,
 						      F71882FG_REG_FAN_HYST1);
-		for (nr = 0; nr < 4; nr++) {
-			int point;
-
+		for (nr = 0; nr < nr_fans; nr++) {
 			data->pwm_auto_point_mapping[nr] =
 			    f71882fg_read8(data,
 					   F71882FG_REG_POINT_MAPPING(nr));
 
-			for (point = 0; point < 5; point++) {
-				data->pwm_auto_point_pwm[nr][point] =
-				    f71882fg_read8(data,
-						   F71882FG_REG_POINT_PWM
-						   (nr, point));
-			}
-			for (point = 0; point < 4; point++) {
-				data->pwm_auto_point_temp[nr][point] =
-				    f71882fg_read8(data,
-						   F71882FG_REG_POINT_TEMP
-						   (nr, point));
+			if (data->type == f71882fg) {
+				int point;
+				for (point = 0; point < 5; point++) {
+					data->pwm_auto_point_pwm[nr][point] =
+						f71882fg_read8(data,
+							F71882FG_REG_POINT_PWM
+							(nr, point));
+				}
+				for (point = 0; point < 4; point++) {
+					data->pwm_auto_point_temp[nr][point] =
+						f71882fg_read8(data,
+							F71882FG_REG_POINT_TEMP
+							(nr, point));
+				}
+			} else {
+				data->pwm_auto_point_pwm[nr][1] =
+					f71882fg_read8(data,
+						F71882FG_REG_POINT_PWM
+						(nr, 1));
+				data->pwm_auto_point_pwm[nr][4] =
+					f71882fg_read8(data,
+						F71882FG_REG_POINT_PWM
+						(nr, 4));
+				data->pwm_auto_point_temp[nr][0] =
+					f71882fg_read8(data,
+						F71882FG_REG_POINT_TEMP
+						(nr, 0));
+				data->pwm_auto_point_temp[nr][3] =
+					f71882fg_read8(data,
+						F71882FG_REG_POINT_TEMP
+						(nr, 3));
 			}
 		}
 		data->last_limits = jiffies;
@@ -684,7 +769,7 @@
 
 		data->fan_status = f71882fg_read8(data,
 						F71882FG_REG_FAN_STATUS);
-		for (nr = 0; nr < 4; nr++) {
+		for (nr = 0; nr < nr_fans; nr++) {
 			data->fan[nr] = f71882fg_read16(data,
 						F71882FG_REG_FAN(nr));
 			data->fan_target[nr] =
@@ -696,7 +781,8 @@
 			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
 		}
 
-		data->in_status = f71882fg_read8(data,
+		if (data->type == f71882fg)
+			data->in_status = f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
 		for (nr = 0; nr < 9; nr++)
 			data->in[nr] = f71882fg_read8(data,
@@ -1144,13 +1230,15 @@
 		data->pwm_enable &= ~(2 << (2 * nr));
 		break;		/* Temperature ctrl */
 	}
-	switch (fan_mode[nr]) {
-	case 1:
-		data->pwm_enable |= 1 << (2 * nr);
-		break;		/* Duty cycle mode */
-	case 2:
-		data->pwm_enable &= ~(1 << (2 * nr));
-		break;		/* RPM mode */
+	if (data->type == f71882fg) {
+		switch (fan_mode[nr]) {
+		case 1:
+			data->pwm_enable |= 1 << (2 * nr);
+			break;		/* Duty cycle mode */
+		case 2:
+			data->pwm_enable &= ~(1 << (2 * nr));
+			break;		/* RPM mode */
+		}
 	}
 	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
 	mutex_unlock(&data->update_lock);
@@ -1386,7 +1474,8 @@
 static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
 	char *buf)
 {
-	return sprintf(buf, DRVNAME "\n");
+	struct f71882fg_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", f71882fg_names[data->type]);
 }
 
 static int __devinit f71882fg_create_sysfs_files(struct platform_device *pdev,
@@ -1405,6 +1494,7 @@
 static int __devinit f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
+	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
 	int err;
 	u8 start_reg;
 
@@ -1413,6 +1503,7 @@
 		return -ENOMEM;
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
+	data->type = sio_data->type;
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
@@ -1423,15 +1514,35 @@
 
 	start_reg = f71882fg_read8(data, F71882FG_REG_START);
 	if (start_reg & 0x01) {
-		err = f71882fg_create_sysfs_files(pdev, f71882fg_in_temp_attr,
-					ARRAY_SIZE(f71882fg_in_temp_attr));
+		err = f71882fg_create_sysfs_files(pdev, f718x2fg_in_temp_attr,
+					ARRAY_SIZE(f718x2fg_in_temp_attr));
 		if (err)
 			goto exit_unregister_sysfs;
+
+		if (data->type == f71882fg) {
+			err = f71882fg_create_sysfs_files(pdev,
+					f71882fg_in_temp_attr,
+					ARRAY_SIZE(f71882fg_in_temp_attr));
+			if (err)
+				goto exit_unregister_sysfs;
+		}
 	}
 
 	if (start_reg & 0x02) {
-		err = f71882fg_create_sysfs_files(pdev, f71882fg_fan_attr,
+		err = f71882fg_create_sysfs_files(pdev, f718x2fg_fan_attr,
+					ARRAY_SIZE(f718x2fg_fan_attr));
+		if (err)
+			goto exit_unregister_sysfs;
+
+		if (data->type == f71862fg) {
+			err = f71882fg_create_sysfs_files(pdev,
+					f71862fg_fan_attr,
+					ARRAY_SIZE(f71862fg_fan_attr));
+		} else {
+			err = f71882fg_create_sysfs_files(pdev,
+					f71882fg_fan_attr,
 					ARRAY_SIZE(f71882fg_fan_attr));
+		}
 		if (err)
 			goto exit_unregister_sysfs;
 	}
@@ -1462,10 +1573,20 @@
 
 	device_remove_file(&pdev->dev, &dev_attr_name);
 
+	for (i = 0; i < ARRAY_SIZE(f718x2fg_in_temp_attr); i++)
+		device_remove_file(&pdev->dev,
+					&f718x2fg_in_temp_attr[i].dev_attr);
+
 	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
 		device_remove_file(&pdev->dev,
 					&f71882fg_in_temp_attr[i].dev_attr);
 
+	for (i = 0; i < ARRAY_SIZE(f718x2fg_fan_attr); i++)
+		device_remove_file(&pdev->dev, &f718x2fg_fan_attr[i].dev_attr);
+
+	for (i = 0; i < ARRAY_SIZE(f71862fg_fan_attr); i++)
+		device_remove_file(&pdev->dev, &f71862fg_fan_attr[i].dev_attr);
+
 	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
 		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
 
@@ -1474,11 +1595,12 @@
 	return 0;
 }
 
-static int __init f71882fg_find(int sioaddr, unsigned short *address)
+static int __init f71882fg_find(int sioaddr, unsigned short *address,
+	struct f71882fg_sio_data *sio_data)
 {
 	int err = -ENODEV;
 	u16 devid;
-	u8 start_reg;
+	u8 reg;
 	struct f71882fg_data data;
 
 	superio_enter(sioaddr);
@@ -1490,7 +1612,14 @@
 	}
 
 	devid = force_id ? force_id : superio_inw(sioaddr, SIO_REG_DEVID);
-	if (devid != SIO_F71882_ID) {
+	switch (devid) {
+	case SIO_F71862_ID:
+		sio_data->type = f71862fg;
+		break;
+	case SIO_F71882_ID:
+		sio_data->type = f71882fg;
+		break;
+	default:
 		printk(KERN_INFO DRVNAME ": Unsupported Fintek device\n");
 		goto exit;
 	}
@@ -1510,23 +1639,35 @@
 	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
 	data.addr = *address;
-	start_reg = f71882fg_read8(&data, F71882FG_REG_START);
-	if (!(start_reg & 0x03)) {
+	reg = f71882fg_read8(&data, F71882FG_REG_START);
+	if (!(reg & 0x03)) {
 		printk(KERN_WARNING DRVNAME
 			": Hardware monitoring not activated\n");
 		goto exit;
 	}
 
+	/* If it is a 71862 and the fan / pwm part is enabled sanity check
+	   the pwm settings */
+	if (sio_data->type == f71862fg && (reg & 0x02)) {
+		reg = f71882fg_read8(&data, F71882FG_REG_PWM_ENABLE);
+		if ((reg & 0x15) != 0x15) {
+			printk(KERN_ERR DRVNAME
+				": Invalid (reserved) pwm settings: 0x%02x\n",
+				(unsigned int)reg);
+			goto exit;
+		}
+	}
 	err = 0;
-	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x, revision %d\n",
-		(unsigned int)*address,
+	printk(KERN_INFO DRVNAME ": Found %s chip at %#x, revision %d\n",
+		f71882fg_names[sio_data->type],	(unsigned int)*address,
 		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
 exit:
 	superio_exit(sioaddr);
 	return err;
 }
 
-static int __init f71882fg_device_add(unsigned short address)
+static int __init f71882fg_device_add(unsigned short address,
+	const struct f71882fg_sio_data *sio_data)
 {
 	struct resource res = {
 		.start	= address,
@@ -1546,6 +1687,13 @@
 		goto exit_device_put;
 	}
 
+	err = platform_device_add_data(f71882fg_pdev, sio_data,
+				       sizeof(struct f71882fg_sio_data));
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+
 	err = platform_device_add(f71882fg_pdev);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device addition failed\n");
@@ -1564,15 +1712,19 @@
 {
 	int err = -ENODEV;
 	unsigned short address;
+	struct f71882fg_sio_data sio_data;
+
+	memset(&sio_data, 0, sizeof(sio_data));
 
-	if (f71882fg_find(0x2e, &address) && f71882fg_find(0x4e, &address))
+	if (f71882fg_find(0x2e, &address, &sio_data) &&
+	    f71882fg_find(0x4e, &address, &sio_data))
 		goto exit;
 
 	err = platform_driver_register(&f71882fg_driver);
 	if (err)
 		goto exit;
 
-	err = f71882fg_device_add(address);
+	err = f71882fg_device_add(address, &sio_data);
 	if (err)
 		goto exit_driver;
 

--------------070206070405080808090401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070206070405080808090401--
