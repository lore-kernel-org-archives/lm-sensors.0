From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 May 2009 09:06:06 +0000
Subject: [lm-sensors] PATCH [4/4]: hwmon: f71882fg add support for the
Message-Id: <4A1FA57E.4040503@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030504070608090204030104"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030504070608090204030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add support for the hwmon part of the Fintek f71858fg superio IC to the
f71882fg driver. Many thanks to Jelle de Jong for lending me a motherboard
with this superio on it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------030504070608090204030104
Content-Type: text/plain; name="hwmon-f71882fg-04-add-f71858fg-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hwmon-f71882fg-04-add-f71858fg-support.patch"

hwmon: f71882fg add support for the f71858fg

Add support for the hwmon part of the Fintek f71858fg superio IC to the
f71882fg driver. Many thanks to Jelle de Jong for lending me a motherboard 
with this superio on it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up vanilla-2.6.30-rc6-git2/Documentation/hwmon/f71882fg.f71858fg vanilla-2.6.30-rc6-git2/Documentation/hwmon/f71882fg
--- vanilla-2.6.30-rc6-git2/Documentation/hwmon/f71882fg.f71858fg	2009-05-29 10:44:23.000000000 +0200
+++ vanilla-2.6.30-rc6-git2/Documentation/hwmon/f71882fg	2009-05-29 10:50:55.000000000 +0200
@@ -2,14 +2,18 @@ Kernel driver f71882fg
 ======================
 
 Supported chips:
-  * Fintek F71882FG and F71883FG
-    Prefix: 'f71882fg'
+  * Fintek F71858FG
+    Prefix: 'f71858fg'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Available from the Fintek website
   * Fintek F71862FG and F71863FG
     Prefix: 'f71862fg'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Available from the Fintek website
+  * Fintek F71882FG and F71883FG
+    Prefix: 'f71882fg'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
   * Fintek F8000
     Prefix: 'f8000'
     Addresses scanned: none, address read from Super I/O config space
@@ -66,13 +70,13 @@ printed when loading the driver.
 
 Three different fan control modes are supported; the mode number is written
 to the pwm#_enable file. Note that not all modes are supported on all
-chips, and some modes may only be available in RPM / PWM mode on the F8000.
+chips, and some modes may only be available in RPM / PWM mode.
 Writing an unsupported mode will result in an invalid parameter error.
 
 * 1: Manual mode
   You ask for a specific PWM duty cycle / DC voltage or a specific % of
   fan#_full_speed by writing to the pwm# file. This mode is only
-  available on the F8000 if the fan channel is in RPM mode.
+  available on the F71858FG / F8000 if the fan channel is in RPM mode.
 
 * 2: Normal auto mode
   You can define a number of temperature/fan speed trip points, which % the
diff -up vanilla-2.6.30-rc6-git2/drivers/hwmon/Kconfig.f71858fg vanilla-2.6.30-rc6-git2/drivers/hwmon/Kconfig
--- vanilla-2.6.30-rc6-git2/drivers/hwmon/Kconfig.f71858fg	2009-05-29 10:16:57.000000000 +0200
+++ vanilla-2.6.30-rc6-git2/drivers/hwmon/Kconfig	2009-05-29 10:18:12.000000000 +0200
@@ -306,11 +306,11 @@ config SENSORS_F71805F
 	  will be called f71805f.
 
 config SENSORS_F71882FG
-	tristate "Fintek F71862FG, F71882FG and F8000"
+	tristate "Fintek F71858FG, F71862FG, F71882FG and F8000"
 	depends on EXPERIMENTAL
 	help
 	  If you say yes here you get support for hardware monitoring
-	  features of the Fintek F71882FG/F71883FG, F71862FG/71863FG
+	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG
 	  and F8000 Super-I/O chips.
 
 	  This driver can also be built as a module.  If so, the module
diff -up vanilla-2.6.30-rc6-git2/drivers/hwmon/f71882fg.c.f71858fg vanilla-2.6.30-rc6-git2/drivers/hwmon/f71882fg.c
--- vanilla-2.6.30-rc6-git2/drivers/hwmon/f71882fg.c.f71858fg	2009-05-29 10:16:01.000000000 +0200
+++ vanilla-2.6.30-rc6-git2/drivers/hwmon/f71882fg.c	2009-05-29 10:55:25.000000000 +0200
@@ -32,6 +32,7 @@
 
 #define DRVNAME "f71882fg"
 
+#define SIO_F71858FG_LD_HWM	0x02	/* Hardware monitor logical device */
 #define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
@@ -44,6 +45,7 @@
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
 #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
+#define SIO_F71858_ID		0x0507  /* Chipset ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
@@ -70,6 +72,7 @@
 #define F71882FG_REG_TEMP_HIGH(nr)	(0x81 + 2 * (nr))
 #define F71882FG_REG_TEMP_STATUS	0x62
 #define F71882FG_REG_TEMP_BEEP		0x63
+#define F71882FG_REG_TEMP_CONFIG	0x69
 #define F71882FG_REG_TEMP_HYST(nr)	(0x6C + (nr))
 #define F71882FG_REG_TEMP_TYPE		0x6B
 #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
@@ -92,9 +95,10 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71862fg, f71882fg, f8000 };
+enum chips { f71858fg, f71862fg, f71882fg, f8000 };
 
 static const char *f71882fg_names[] = {
+	"f71858fg",
 	"f71862fg",
 	"f71882fg",
 	"f8000",
@@ -136,7 +140,7 @@ struct f71882fg_data {
 	/* Note: all models have only 3 temperature channels, but on some
 	   they are addressed as 0-2 and on others as 1-3, so for coding
 	   convenience we reserve space for 4 channels */
-	u8	temp[4];
+	u16	temp[4];
 	u8	temp_ovt[4];
 	u8	temp_high[4];
 	u8	temp_hyst[2]; /* 2 hysts stored per reg */
@@ -144,6 +148,7 @@ struct f71882fg_data {
 	u8	temp_status;
 	u8	temp_beep;
 	u8	temp_diode_open;
+	u8	temp_config;
 	u8	pwm[4];
 	u8	pwm_enable;
 	u8	pwm_auto_point_hyst[2];
@@ -252,6 +257,50 @@ static struct platform_driver f71882fg_d
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
+/* Temp and in attr for the f71858fg */
+static struct sensor_device_attribute_2 f71858fg_in_temp_attr[] = {
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 0),
+	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 0),
+	SENSOR_ATTR_2(temp1_max_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 0),
+	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		0, 0),
+	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 4),
+	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 1),
+	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 1),
+	SENSOR_ATTR_2(temp2_max_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 1),
+	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		0, 1),
+	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 5),
+	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 2),
+	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
+		store_temp_max_hyst, 0, 2),
+	SENSOR_ATTR_2(temp3_max_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 2),
+	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		0, 2),
+	SENSOR_ATTR_2(temp3_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 6),
+	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
+};
+
 /* Temp and in attr common to both the f71862fg and f71882fg */
 static struct sensor_device_attribute_2 f718x2fg_in_temp_attr[] = {
 	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
@@ -476,22 +525,8 @@ static struct sensor_device_attribute_2 
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
 };
 
-/* Fan / PWM attr for the f71882fg */
-static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
-	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 0),
-	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 1),
-	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 2),
-	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
-	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
-		      show_fan_full_speed,
-		      store_fan_full_speed, 0, 3),
-	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 3),
-	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
-
+/* Fan / PWM attr common to both the f71882fg and f71858fg */
+static struct sensor_device_attribute_2 f71882fg_f71858fg_fan_attr[] = {
 	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 0),
@@ -605,6 +640,24 @@ static struct sensor_device_attribute_2 
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 2),
 	SENSOR_ATTR_2(pwm3_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
+};
+
+/* Fan / PWM attr found on the f71882fg but not on the f71858fg */
+static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
+	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 0),
+	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 1),
+	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 2),
+
+	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 3),
+	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 3),
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
 
 	SENSOR_ATTR_2(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 3),
 	SENSOR_ATTR_2(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
@@ -855,13 +908,22 @@ static void f71882fg_write16(struct f718
 	outb(val & 255, data->addr + DATA_REG_OFFSET);
 }
 
+static u16 f71882fg_read_temp(struct f71882fg_data *data, int nr)
+{
+	if (data->type == f71858fg)
+		return f71882fg_read16(data, F71882FG_REG_TEMP(nr));
+	else
+		return f71882fg_read8(data, F71882FG_REG_TEMP(nr));
+}
+
 static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr, reg = 0, reg2;
 	int nr_fans = (data->type == f71882fg) ? 4 : 3;
-	int nr_ins = (data->type == f8000) ? 3 : 9;
-	int temp_start = (data->type == f8000) ? 0 : 1;
+	int nr_ins = (data->type == f71858fg || data->type == f8000) ? 3 : 9;
+	int temp_start =
+	    (data->type == f71858fg || data->type == f8000) ? 0 : 1;
 
 	mutex_lock(&data->update_lock);
 
@@ -884,14 +946,17 @@ static struct f71882fg_data *f71882fg_up
 		}
 
 		if (data->type != f8000) {
-			data->fan_beep = f71882fg_read8(data,
-						F71882FG_REG_FAN_BEEP);
-			data->temp_beep = f71882fg_read8(data,
-						F71882FG_REG_TEMP_BEEP);
 			data->temp_hyst[0] = f71882fg_read8(data,
 						F71882FG_REG_TEMP_HYST(0));
 			data->temp_hyst[1] = f71882fg_read8(data,
 						F71882FG_REG_TEMP_HYST(1));
+		}
+
+		if (data->type == f71862fg || data->type == f71882fg) {
+			data->fan_beep = f71882fg_read8(data,
+						F71882FG_REG_FAN_BEEP);
+			data->temp_beep = f71882fg_read8(data,
+						F71882FG_REG_TEMP_BEEP);
 			/* Have to hardcode type, because temp1 is special */
 			reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
 			data->temp_type[2] = (reg & 0x04) ? 2 : 4;
@@ -902,10 +967,10 @@ static struct f71882fg_data *f71882fg_up
 			data->temp_type[1] = 6 /* PECI */;
 		else if ((reg2 & 0x03) == 0x02)
 			data->temp_type[1] = 5 /* AMDSI */;
-		else if (data->type != f8000)
+		else if (data->type == f71862fg || data->type == f71882fg)
 			data->temp_type[1] = (reg & 0x02) ? 2 : 4;
 		else
-			data->temp_type[1] = 2; /* F8000 only supports BJT */
+			data->temp_type[1] = 2; /* Only supports BJT */
 
 		data->pwm_enable = f71882fg_read8(data,
 						  F71882FG_REG_PWM_ENABLE);
@@ -962,8 +1027,7 @@ static struct f71882fg_data *f71882fg_up
 		data->temp_diode_open = f71882fg_read8(data,
 						F71882FG_REG_TEMP_DIODE_OPEN);
 		for (nr = temp_start; nr < 3 + temp_start; nr++)
-			data->temp[nr] = f71882fg_read8(data,
-						F71882FG_REG_TEMP(nr));
+			data->temp[nr] = f71882fg_read_temp(data, nr);
 
 		data->fan_status = f71882fg_read8(data,
 						F71882FG_REG_FAN_STATUS);
@@ -1166,8 +1230,22 @@ static ssize_t show_temp(struct device *
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int sign, temp;
+
+	if (data->type == f71858fg) {
+		if ((data->temp_config & 3) == 3)
+			sign = data->temp[nr] & 0x0001;
+		else
+			sign = data->temp[nr] & 0x8000;
+
+		temp = (data->temp[nr] >> 5) & 0x3ff;
+		temp *= 125;
+		if (sign)
+			temp -= 128000;
+	} else
+		temp = data->temp[nr] * 1000;
 
-	return sprintf(buf, "%d\n", data->temp[nr] * 1000);
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t show_temp_max(struct device *dev, struct device_attribute
@@ -1460,6 +1538,12 @@ static ssize_t store_pwm_enable(struct d
 	} else {
 		switch (val) {
 		case 1:
+			/* The f71858fg does not support manual RPM mode */
+			if (data->type == f71858fg &&
+			    ((data->pwm_enable >> 2 * nr) & 1)) {
+				count = -EINVAL;
+				goto leave;
+			}
 			data->pwm_enable |= 2 << (2 * nr);
 			break;		/* Manual */
 		case 2:
@@ -1618,7 +1702,8 @@ static ssize_t show_pwm_auto_point_chann
 	int result;
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int temp_start = (data->type == f8000) ? 0 : 1;
+	int temp_start =
+	    (data->type == f71858fg || data->type == f8000) ? 0 : 1;
 
 	result = 1 << ((data->pwm_auto_point_mapping[nr] & 3) - temp_start);
 
@@ -1631,7 +1716,8 @@ static ssize_t store_pwm_auto_point_chan
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
-	int temp_start = (data->type == f8000) ? 0 : 1;
+	int temp_start =
+	    (data->type == f71858fg || data->type == f8000) ? 0 : 1;
 	long val = simple_strtol(buf, NULL, 10);
 
 	switch (val) {
@@ -1745,6 +1831,20 @@ static int __devinit f71882fg_probe(stru
 
 	if (start_reg & 0x01) {
 		switch (data->type) {
+		case f71858fg:
+			data->temp_config =
+				f71882fg_read8(data, F71882FG_REG_TEMP_CONFIG);
+			if (data->temp_config & 0x10)
+				/* The f71858fg temperature alarms behave as
+				   the f8000 alarms in this mode */
+				err = f71882fg_create_sysfs_files(pdev,
+					f8000_in_temp_attr,
+					ARRAY_SIZE(f8000_in_temp_attr));
+			else
+				err = f71882fg_create_sysfs_files(pdev,
+					f71858fg_in_temp_attr,
+					ARRAY_SIZE(f71858fg_in_temp_attr));
+			break;
 		case f71882fg:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71882fg_in_temp_attr,
@@ -1773,6 +1873,12 @@ static int __devinit f71882fg_probe(stru
 
 		/* Sanity check the pwm settings */
 		switch (data->type) {
+		case f71858fg:
+			err = 0;
+			for (i = 0; i < nr_fans; i++)
+				if (((data->pwm_enable >> i * 2) & 3) == 3)
+					err = 1;
+			break;
 		case f71862fg:
 			err = (data->pwm_enable & 0x15) != 0x15;
 			break;
@@ -1806,6 +1912,13 @@ static int __devinit f71882fg_probe(stru
 			err = f71882fg_create_sysfs_files(pdev,
 					f71882fg_fan_attr,
 					ARRAY_SIZE(f71882fg_fan_attr));
+			if (err)
+				goto exit_unregister_sysfs;
+			/* fall through! */
+		case f71858fg:
+			err = f71882fg_create_sysfs_files(pdev,
+					f71882fg_f71858fg_fan_attr,
+					ARRAY_SIZE(f71882fg_f71858fg_fan_attr));
 			break;
 		case f8000:
 			err = f71882fg_create_sysfs_files(pdev,
@@ -1890,6 +2003,9 @@ static int __init f71882fg_find(int sioa
 
 	devid = force_id ? force_id : superio_inw(sioaddr, SIO_REG_DEVID);
 	switch (devid) {
+	case SIO_F71858_ID:
+		sio_data->type = f71858fg;
+		break;
 	case SIO_F71862_ID:
 		sio_data->type = f71862fg;
 		break;
@@ -1904,7 +2020,11 @@ static int __init f71882fg_find(int sioa
 		goto exit;
 	}
 
-	superio_select(sioaddr, SIO_F71882FG_LD_HWM);
+	if (sio_data->type == f71858fg)
+		superio_select(sioaddr, SIO_F71858FG_LD_HWM);
+	else
+		superio_select(sioaddr, SIO_F71882FG_LD_HWM);
+
 	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
 		printk(KERN_WARNING DRVNAME ": Device not activated\n");
 		goto exit;

--------------030504070608090204030104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030504070608090204030104--
