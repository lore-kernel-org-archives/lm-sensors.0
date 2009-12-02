From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:27:56 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: (adt7475) Add support for the
Message-Id: <20091202162756.1803e871@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the Analog Devices ADT7490 chip. This chip is largely
compatible with the ADT7473 and ADT7475, with additional features.
In particular, it has 6 voltage inputs instead of 2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 Documentation/hwmon/adt7475 |   34 ++++++++++--
 drivers/hwmon/Kconfig       |    4 -
 drivers/hwmon/adt7475.c     |  115 ++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 134 insertions(+), 19 deletions(-)

--- linux-2.6.32-rc8.orig/Documentation/hwmon/adt7475	2009-12-02 12:53:17.000000000 +0100
+++ linux-2.6.32-rc8/Documentation/hwmon/adt7475	2009-12-02 13:27:45.000000000 +0100
@@ -10,24 +10,31 @@ Supported chips:
     Prefix: 'adt7475'
     Addresses scanned: I2C 0x2E
     Datasheet: Publicly available at the On Semiconductors website
+  * Analog Devices ADT7490
+    Prefix: 'adt7490'
+    Addresses scanned: I2C 0x2C, 0x2D, 0x2E
+    Datasheet: Publicly available at the On Semiconductors website
 
 Authors:
 	Jordan Crouse
 	Hans de Goede
 	Darrick J. Wong (documentation)
+	Jean Delvare
 
 
 Description
 -----------
 
-This driver implements support for the Analog Devices ADT7473 and ADT7475
-chip family. Both chips differ only in minor details. They will be
-collectively designed by the name "ADT747x" in the rest of this document.
+This driver implements support for the Analog Devices ADT7473, ADT7475 and
+ADT7490 chip family. The ADT7473 and ADT7475 differ only in minor details.
+The ADT7490 has additional features, including extra voltage measurement
+inputs and PECI support. All the supported chips will be collectively
+designed by the name "ADT747x" in the rest of this document.
 
 The ADT747x uses the 2-wire interface compatible with the SMBus 2.0
 specification. Using an analog to digital converter it measures three (3)
-temperatures and two (2) voltages. It has four (4) 16-bit counters for
-measuring fan speed. There are three (3) PWM outputs that can be used
+temperatures and two (2) or more voltages. It has four (4) 16-bit counters
+for measuring fan speed. There are three (3) PWM outputs that can be used
 to control fan speed.
 
 A sophisticated control system for the PWM outputs is designed into the
@@ -45,6 +52,23 @@ The ADT747x samples all inputs continuou
 the registers more often than once every other second. Further,
 configuration data is only read once per minute.
 
+Chip Differences Summary
+------------------------
+
+ADT7473:
+  * 2 voltage inputs
+  * system acoustics optimizations (not implemented)
+
+ADT7475:
+  * 2 voltage inputs
+
+ADT7490:
+  * 6 voltage inputs
+  * 1 Imon input (not implemented)
+  * PECI support (not implemented)
+  * 2 GPIO pins (not implemented)
+  * system acoustics optimizations (not implemented)
+
 Special Features
 ----------------
 
--- linux-2.6.32-rc8.orig/drivers/hwmon/Kconfig	2009-12-02 12:53:17.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/Kconfig	2009-12-02 13:27:45.000000000 +0100
@@ -205,11 +205,11 @@ config SENSORS_ADT7473
 	  will be called adt7473.
 
 config SENSORS_ADT7475
-	tristate "Analog Devices ADT7473 and ADT7475"
+	tristate "Analog Devices ADT7473, ADT7475 and ADT7490"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the Analog Devices
-	  ADT7473 and ADT7475 hardware monitoring chips.
+	  ADT7473, ADT7475 and ADT7490 hardware monitoring chips.
 
 	  This driver can also be build as a module.  If so, the module
 	  will be called adt7475.
--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 12:55:18.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 13:27:55.000000000 +0100
@@ -3,7 +3,8 @@
  * Copyright (C) 2007-2008, Advanced Micro Devices, Inc.
  * Copyright (C) 2008 Jordan Crouse <jordan@cosmicpenguin.net>
  * Copyright (C) 2008 Hans de Goede <hdegoede@redhat.com>
-
+ * Copyright (C) 2009 Jean Delvare <khali@linux-fr.org>
+ *
  * Derived from the lm83 driver by Jean Delvare
  *
  * This program is free software; you can redistribute it and/or modify
@@ -39,6 +40,9 @@
 
 /* 7475 Common Registers */
 
+#define REG_VTT			0x1E	/* ADT7490 only */
+#define REG_EXTEND3		0x1F	/* ADT7490 only */
+
 #define REG_VOLTAGE_BASE	0x20
 #define REG_TEMP_BASE		0x25
 #define REG_TACH_BASE		0x28
@@ -79,6 +83,11 @@
 #define REG_CONFIG5		0x7C
 #define REG_CONFIG4		0x7D
 
+#define REG_STATUS4		0x81	/* ADT7490 only */
+
+#define REG_VTT_MIN		0x84	/* ADT7490 only */
+#define REG_VTT_MAX		0x86	/* ADT7490 only */
+
 #define CONFIG4_MAXDUTY		0x08
 
 #define CONFIG5_TWOSCOMP	0x01
@@ -119,11 +128,12 @@
 
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-I2C_CLIENT_INSMOD_2(adt7473, adt7475);
+I2C_CLIENT_INSMOD_3(adt7473, adt7475, adt7490);
 
 static const struct i2c_device_id adt7475_id[] = {
 	{ "adt7473", adt7473 },
 	{ "adt7475", adt7475 },
+	{ "adt7490", adt7490 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adt7475_id);
@@ -139,7 +149,7 @@ struct adt7475_data {
 	u8 config4;
 	u8 config5;
 	u8 has_voltage;
-	u16 alarms;
+	u32 alarms;
 	u16 voltage[3][6];
 	u16 temp[7][3];
 	u16 tach[2][4];
@@ -306,10 +316,17 @@ static ssize_t set_voltage(struct device
 
 	data->voltage[sattr->nr][sattr->index] = volt2reg(sattr->index, val);
 
-	if (sattr->nr = MIN)
-		reg = VOLTAGE_MIN_REG(sattr->index);
-	else
-		reg = VOLTAGE_MAX_REG(sattr->index);
+	if (sattr->index < ADT7475_VOLTAGE_COUNT) {
+		if (sattr->nr = MIN)
+			reg = VOLTAGE_MIN_REG(sattr->index);
+		else
+			reg = VOLTAGE_MAX_REG(sattr->index);
+	} else {
+		if (sattr->nr = MIN)
+			reg = REG_VTT_MIN;
+		else
+			reg = REG_VTT_MAX;
+	}
 
 	i2c_smbus_write_byte_data(client, reg,
 				  data->voltage[sattr->nr][sattr->index] >> 2);
@@ -818,6 +835,12 @@ static ssize_t set_pwm_at_crit(struct de
 	return count;
 }
 
+static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MAX, 0);
+static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MIN, 0);
+static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, show_voltage, NULL, ALARM, 0);
 static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 1);
 static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_voltage,
 			    set_voltage, MAX, 1);
@@ -830,6 +853,24 @@ static SENSOR_DEVICE_ATTR_2(in2_max, S_I
 static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_voltage,
 			    set_voltage, MIN, 2);
 static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_voltage, NULL, ALARM, 2);
+static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_voltage, NULL, INPUT, 3);
+static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MAX, 3);
+static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MIN, 3);
+static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, show_voltage, NULL, ALARM, 3);
+static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_voltage, NULL, INPUT, 4);
+static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MAX, 4);
+static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MIN, 4);
+static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, show_voltage, NULL, ALARM, 8);
+static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_voltage, NULL, INPUT, 5);
+static SENSOR_DEVICE_ATTR_2(in5_max, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MAX, 5);
+static SENSOR_DEVICE_ATTR_2(in5_min, S_IRUGO | S_IWUSR, show_voltage,
+			    set_voltage, MIN, 5);
+static SENSOR_DEVICE_ATTR_2(in5_alarm, S_IRUGO, show_voltage, NULL, ALARM, 31);
 static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_alarm, S_IRUGO, show_temp, NULL, ALARM, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_temp, NULL, FAULT, 0);
@@ -1009,7 +1050,29 @@ static struct attribute *adt7475_attrs[]
 	NULL,
 };
 
+/* Attributes specific to the ADT7490 */
+static struct attribute *adt7490_attrs[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	NULL
+};
+
 static struct attribute_group adt7475_attr_group = { .attrs = adt7475_attrs };
+static struct attribute_group adt7490_attr_group = { .attrs = adt7490_attrs };
 
 static int adt7475_detect(struct i2c_client *client, int kind,
 			  struct i2c_board_info *info)
@@ -1032,9 +1095,11 @@ static int adt7475_detect(struct i2c_cli
 		name = "adt7473";
 	else if (devid = 0x75 && client->addr = 0x2e)
 		name = "adt7475";
+	else if ((devid2 & 0xfc) = 0x6c)
+		name = "adt7490";
 	else {
 		dev_dbg(&adapter->dev,
-			"Couldn't detect an ADT7473 or ADT7475 part at "
+			"Couldn't detect an ADT7473/75/90 part at "
 			"0x%02x\n", (unsigned int)client->addr);
 		return -ENODEV;
 	}
@@ -1059,6 +1124,9 @@ static int adt7475_probe(struct i2c_clie
 
 	/* Initialize device-specific values */
 	switch (id->driver_data) {
+	case adt7490:
+		data->has_voltage = 0x3f;	/* in0 to in5 */
+		break;
 	default:
 		data->has_voltage = 0x06;	/* in1, in2 */
 	}
@@ -1072,6 +1140,13 @@ static int adt7475_probe(struct i2c_clie
 	if (ret)
 		goto efree;
 
+	if (id->driver_data = adt7490) {
+		ret = sysfs_create_group(&client->dev.kobj,
+					 &adt7490_attr_group);
+		if (ret)
+			goto eremove;
+	}
+
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
@@ -1082,6 +1157,8 @@ static int adt7475_probe(struct i2c_clie
 
 eremove:
 	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
+	if (data->has_voltage & 0x39)
+		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
 efree:
 	kfree(data);
 	return ret;
@@ -1093,6 +1170,8 @@ static int adt7475_remove(struct i2c_cli
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
+	if (data->has_voltage & 0x39)
+		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
 	kfree(data);
 
 	return 0;
@@ -1177,7 +1256,7 @@ static struct adt7475_data *adt7475_upda
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7475_data *data = i2c_get_clientdata(client);
-	u8 ext;
+	u16 ext;
 	int i;
 
 	mutex_lock(&data->lock);
@@ -1188,7 +1267,8 @@ static struct adt7475_data *adt7475_upda
 		data->alarms = adt7475_read(REG_STATUS2) << 8;
 		data->alarms |= adt7475_read(REG_STATUS1);
 
-		ext = adt7475_read(REG_EXTEND1);
+		ext = (adt7475_read(REG_EXTEND2) << 8) |
+			adt7475_read(REG_EXTEND1);
 		for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++) {
 			if (!(data->has_voltage & (1 << i)))
 				continue;
@@ -1197,11 +1277,17 @@ static struct adt7475_data *adt7475_upda
 				((ext >> (i * 2)) & 3);
 		}
 
-		ext = adt7475_read(REG_EXTEND2);
 		for (i = 0; i < ADT7475_TEMP_COUNT; i++)
 			data->temp[INPUT][i]  				(adt7475_read(TEMP_REG(i)) << 2) |
-				((ext >> ((i + 1) * 2)) & 3);
+				((ext >> ((i + 5) * 2)) & 3);
+
+		if (data->has_voltage & (1 << 5)) {
+			data->alarms |= adt7475_read(REG_STATUS4) << 24;
+			ext = adt7475_read(REG_EXTEND3);
+			data->voltage[INPUT][5] = adt7475_read(REG_VTT) << 2 |
+				((ext >> 4) & 3);
+		}
 
 		for (i = 0; i < ADT7475_TACH_COUNT; i++)
 			data->tach[INPUT][i] @@ -1230,6 +1316,11 @@ static struct adt7475_data *adt7475_upda
 				adt7475_read(VOLTAGE_MAX_REG(i)) << 2;
 		}
 
+		if (data->has_voltage & (1 << 5)) {
+			data->voltage[MIN][5] = adt7475_read(REG_VTT_MIN) << 2;
+			data->voltage[MAX][5] = adt7475_read(REG_VTT_MAX) << 2;
+		}
+
 		for (i = 0; i < ADT7475_TEMP_COUNT; i++) {
 			/* Adjust values so they match the input precision */
 			data->temp[MIN][i] 
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
