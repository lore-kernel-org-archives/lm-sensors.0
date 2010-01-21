From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 14:05:04 +0000
Subject: [lm-sensors] [PATCH 5/8] hwmon: (it87) Add support for beep on alarm
Message-Id: <20100121150504.3518c597@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

The IT87xxF chips support beeping on alarm, if properly wired and
configured. There is one control bit for each input type (temperature,
fan, voltage.) Let the user see and change them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |    4 +
 drivers/hwmon/it87.c     |  122 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-21 13:27:03.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-21 14:27:47.000000000 +0100
@@ -128,6 +128,7 @@ superio_exit(void)
 #define IT87_SIO_GPIO5_REG	0x29
 #define IT87_SIO_PINX2_REG	0x2c	/* Pin selection */
 #define IT87_SIO_VID_REG	0xfc	/* VID value */
+#define IT87_SIO_BEEP_PIN_REG	0xf6	/* Beep pin mapping */
 
 /* Update battery voltage after every reading if true */
 static int update_vbat;
@@ -187,6 +188,7 @@ static const u8 IT87_REG_FANX_MIN[]	= {
 
 #define IT87_REG_VIN_ENABLE    0x50
 #define IT87_REG_TEMP_ENABLE   0x51
+#define IT87_REG_BEEP_ENABLE   0x5c
 
 #define IT87_REG_CHIPID        0x58
 
@@ -246,6 +248,7 @@ struct it87_sio_data {
 	/* Values read from Super-I/O config space */
 	u8 revision;
 	u8 vid_value;
+	u8 beep_pin;
 	/* Features skipped based on config or DMI */
 	u8 skip_vid;
 	u8 skip_fan;
@@ -279,6 +282,7 @@ struct it87_data {
 	u8 vid;			/* Register encoding, combined */
 	u8 vrm;
 	u32 alarms;		/* Register encoding, combined */
+	u8 beeps;		/* Register encoding */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 fan_ctl;		/* Register value */
 
@@ -919,6 +923,55 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 17);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 18);
 
+static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%u\n", (data->beeps >> bitnr) & 1);
+}
+static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct it87_data *data = dev_get_drvdata(dev);
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0
+	 || (val != 0 && val != 1))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->beeps = it87_read_value(data, IT87_REG_BEEP_ENABLE);
+	if (val)
+		data->beeps |= (1 << bitnr);
+	else
+		data->beeps &= ~(1 << bitnr);
+	it87_write_value(data, IT87_REG_BEEP_ENABLE, data->beeps);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR,
+			  show_beep, set_beep, 1);
+static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR(in5_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR(in6_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR(in7_beep, S_IRUGO, show_beep, NULL, 1);
+/* fanX_beep writability is set later */
+static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(fan4_beep, S_IRUGO, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(fan5_beep, S_IRUGO, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
+			  show_beep, set_beep, 2);
+static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO, show_beep, NULL, 2);
+
 static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -1014,6 +1067,26 @@ static const struct attribute_group it87
 	.attrs = it87_attributes,
 };
 
+static struct attribute *it87_attributes_beep[] = {
+	&sensor_dev_attr_in0_beep.dev_attr.attr,
+	&sensor_dev_attr_in1_beep.dev_attr.attr,
+	&sensor_dev_attr_in2_beep.dev_attr.attr,
+	&sensor_dev_attr_in3_beep.dev_attr.attr,
+	&sensor_dev_attr_in4_beep.dev_attr.attr,
+	&sensor_dev_attr_in5_beep.dev_attr.attr,
+	&sensor_dev_attr_in6_beep.dev_attr.attr,
+	&sensor_dev_attr_in7_beep.dev_attr.attr,
+
+	&sensor_dev_attr_temp1_beep.dev_attr.attr,
+	&sensor_dev_attr_temp2_beep.dev_attr.attr,
+	&sensor_dev_attr_temp3_beep.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group it87_group_beep = {
+	.attrs = it87_attributes_beep,
+};
+
 static struct attribute *it87_attributes_fan16[5][3+1] = { {
 	&sensor_dev_attr_fan1_input16.dev_attr.attr,
 	&sensor_dev_attr_fan1_min16.dev_attr.attr,
@@ -1107,6 +1180,14 @@ static const struct attribute_group it87
 	{ .attrs = it87_attributes_pwm[2] },
 };
 
+static struct attribute *it87_attributes_fan_beep[] = {
+	&sensor_dev_attr_fan1_beep.dev_attr.attr,
+	&sensor_dev_attr_fan2_beep.dev_attr.attr,
+	&sensor_dev_attr_fan3_beep.dev_attr.attr,
+	&sensor_dev_attr_fan4_beep.dev_attr.attr,
+	&sensor_dev_attr_fan5_beep.dev_attr.attr,
+};
+
 static struct attribute *it87_attributes_vid[] = {
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
@@ -1174,6 +1255,10 @@ static int __init it87_find(unsigned sho
 	if (sio_data->type = it87) {
 		/* The IT8705F doesn't have VID pins at all */
 		sio_data->skip_vid = 1;
+
+		/* The IT8705F has a different LD number for GPIO */
+		superio_select(5);
+		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	} else {
 		int reg;
 
@@ -1207,7 +1292,11 @@ static int __init it87_find(unsigned sho
 			pr_info("it87: in3 is VCC (+5V)\n");
 		if (reg & (1 << 1))
 			pr_info("it87: in7 is VCCH (+5V Stand-By)\n");
+
+		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	}
+	if (sio_data->beep_pin)
+		pr_info("it87: Beeping is supported\n");
 
 	/* Disable specific features based on DMI strings */
 	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
@@ -1240,10 +1329,15 @@ static void it87_remove_files(struct dev
 	int i;
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
+	if (sio_data->beep_pin)
+		sysfs_remove_group(&dev->kobj, &it87_group_beep);
 	for (i = 0; i < 5; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		sysfs_remove_group(&dev->kobj, &fan_group[i]);
+		if (sio_data->beep_pin)
+			sysfs_remove_file(&dev->kobj,
+					  it87_attributes_fan_beep[i]);
 	}
 	for (i = 0; i < 3; i++) {
 		if (sio_data->skip_pwm & (1 << 0))
@@ -1263,6 +1357,7 @@ static int __devinit it87_probe(struct p
 	const struct attribute_group *fan_group;
 	int err = 0, i;
 	int enable_pwm_interface;
+	int fan_beep_need_rw;
 	static const char *names[] = {
 		"it87",
 		"it8712",
@@ -1311,14 +1406,40 @@ static int __devinit it87_probe(struct p
 	if ((err = sysfs_create_group(&dev->kobj, &it87_group)))
 		goto ERROR2;
 
+	if (sio_data->beep_pin) {
+		err = sysfs_create_group(&dev->kobj, &it87_group_beep);
+		if (err)
+			goto ERROR4;
+	}
+
 	/* Do not create fan files for disabled fans */
 	fan_group = it87_get_fan_group(data);
+	fan_beep_need_rw = 1;
 	for (i = 0; i < 5; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		err = sysfs_create_group(&dev->kobj, &fan_group[i]);
 		if (err)
 			goto ERROR4;
+
+		if (sio_data->beep_pin) {
+			err = sysfs_create_file(&dev->kobj,
+						it87_attributes_fan_beep[i]);
+			if (err)
+				goto ERROR4;
+			if (!fan_beep_need_rw)
+				continue;
+
+			/* As we have a single beep enable bit for all fans,
+			 * only the first enabled fan has a writable attribute
+			 * for it. */
+			if (sysfs_chmod_file(&dev->kobj,
+					     it87_attributes_fan_beep[i],
+					     S_IRUGO | S_IWUSR))
+				dev_dbg(dev, "chmod +w fan%d_beep failed\n",
+					i + 1);
+			fan_beep_need_rw = 0;
+		}
 	}
 
 	if (enable_pwm_interface) {
@@ -1609,6 +1730,7 @@ static struct it87_data *it87_update_dev
 			it87_read_value(data, IT87_REG_ALARM1) |
 			(it87_read_value(data, IT87_REG_ALARM2) << 8) |
 			(it87_read_value(data, IT87_REG_ALARM3) << 16);
+		data->beeps = it87_read_value(data, IT87_REG_BEEP_ENABLE);
 
 		data->fan_main_ctrl = it87_read_value(data,
 				IT87_REG_FAN_MAIN_CTRL);
--- linux-2.6.33-rc4.orig/Documentation/hwmon/it87	2009-12-18 08:33:45.000000000 +0100
+++ linux-2.6.33-rc4/Documentation/hwmon/it87	2010-01-21 13:41:11.000000000 +0100
@@ -136,6 +136,10 @@ registers are read whenever any data is
 seconds since the last update). This means that you can easily miss
 once-only alarms.
 
+Out-of-limit readings can also result in beeping, if the chip is properly
+wired and configured. Beeping can be enabled or disabled per sensor type
+(temperatures, voltages and fans.)
+
 The IT87xx only updates its values each 1.5 seconds; reading it more often
 will do no harm, but will return 'old' values.
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
