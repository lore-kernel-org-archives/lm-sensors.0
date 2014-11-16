From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Nov 2014 18:23:15 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm95234) Add support for LM95233
Message-Id: <1416162195-25193-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM95233 is similar to LM95234, but it only supports two
instead of four external temperature sensors.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm95234 | 15 ++++++---
 drivers/hwmon/lm95234.c     | 78 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 66 insertions(+), 27 deletions(-)

diff --git a/Documentation/hwmon/lm95234 b/Documentation/hwmon/lm95234
index a0e95dd..32b777e 100644
--- a/Documentation/hwmon/lm95234
+++ b/Documentation/hwmon/lm95234
@@ -2,6 +2,10 @@ Kernel driver lm95234
 ========== 
 Supported chips:
+  * National Semiconductor / Texas Instruments LM95233
+    Addresses scanned: I2C 0x18, 0x2a, 0x2b
+    Datasheet: Publicly available at the Texas Instruments website
+               http://www.ti.com/product/lm95233
   * National Semiconductor / Texas Instruments LM95234
     Addresses scanned: I2C 0x18, 0x4d, 0x4e
     Datasheet: Publicly available at the Texas Instruments website
@@ -13,11 +17,12 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-LM95234 is an 11-bit digital temperature sensor with a 2-wire System Management
-Bus (SMBus) interface and TrueTherm technology that can very accurately monitor
-the temperature of four remote diodes as well as its own temperature.
-The four remote diodes can be external devices such as microprocessors,
-graphics processors or diode-connected 2N3904s. The LM95234's TruTherm
+LM95233 and LM95234 are 11-bit digital temperature sensors with a 2-wire
+System Management Bus (SMBus) interface and TrueTherm technology
+that can very accurately monitor the temperature of two (LM95233)
+or four (LM95234) remote diodes as well as its own temperature.
+The remote diodes can be external devices such as microprocessors,
+graphics processors or diode-connected 2N3904s. The chip's TruTherm
 beta compensation technology allows sensing of 90 nm or 65 nm process
 thermal diodes accurately.
 
diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index 411202b..0b3b0f1 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -1,7 +1,7 @@
 /*
  * Driver for Texas Instruments / National Semiconductor LM95234
  *
- * Copyright (c) 2013 Guenter Roeck <linux@roeck-us.net>
+ * Copyright (c) 2013, 2014 Guenter Roeck <linux@roeck-us.net>
  *
  * Derived from lm95241.c
  * Copyright (C) 2008, 2010 Davide Rizzo <elpa.rizzo@gmail.com>
@@ -30,7 +30,10 @@
 
 #define DRVNAME "lm95234"
 
-static const unsigned short normal_i2c[] = { 0x18, 0x4d, 0x4e, I2C_CLIENT_END };
+enum chips { lm95233, lm95234 };
+
+static const unsigned short normal_i2c[] = {
+	0x18, 0x2a, 0x2b, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /* LM95234 registers */
 #define LM95234_REG_MAN_ID		0xFE
@@ -53,11 +56,13 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4d, 0x4e, I2C_CLIENT_END };
 #define LM95234_REG_TCRIT_HYST		0x5a
 
 #define NATSEMI_MAN_ID			0x01
+#define LM95233_CHIP_ID			0x89
 #define LM95234_CHIP_ID			0x79
 
 /* Client data (each client gets its own) */
 struct lm95234_data {
 	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	unsigned long last_updated, interval;	/* in jiffies */
 	bool valid;		/* false until following fields are valid */
@@ -564,35 +569,23 @@ static SENSOR_DEVICE_ATTR(temp5_offset, S_IWUSR | S_IRUGO, show_offset,
 static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
 		   set_interval);
 
-static struct attribute *lm95234_attrs[] = {
+static struct attribute *lm95234_common_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
-	&sensor_dev_attr_temp4_input.dev_attr.attr,
-	&sensor_dev_attr_temp5_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
-	&sensor_dev_attr_temp4_fault.dev_attr.attr,
-	&sensor_dev_attr_temp5_fault.dev_attr.attr,
 	&sensor_dev_attr_temp2_type.dev_attr.attr,
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
-	&sensor_dev_attr_temp4_type.dev_attr.attr,
-	&sensor_dev_attr_temp5_type.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
-	&sensor_dev_attr_temp4_max.dev_attr.attr,
-	&sensor_dev_attr_temp5_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp5_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
@@ -601,18 +594,43 @@ static struct attribute *lm95234_attrs[] = {
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+	&dev_attr_update_interval.attr,
+	NULL
+};
+
+static const struct attribute_group lm95234_common_group = {
+	.attrs = lm95234_common_attrs,
+};
+
+static struct attribute *lm95234_attrs[] = {
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp5_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_type.dev_attr.attr,
+	&sensor_dev_attr_temp5_type.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp5_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp5_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_offset.dev_attr.attr,
 	&sensor_dev_attr_temp5_offset.dev_attr.attr,
-	&dev_attr_update_interval.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(lm95234);
+
+static const struct attribute_group lm95234_group = {
+	.attrs = lm95234_attrs,
+};
 
 static int lm95234_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	int address = client->addr;
 	int mfg_id, chip_id, val;
+	const char *name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -622,8 +640,20 @@ static int lm95234_detect(struct i2c_client *client,
 		return -ENODEV;
 
 	chip_id = i2c_smbus_read_byte_data(client, LM95234_REG_CHIP_ID);
-	if (chip_id != LM95234_CHIP_ID)
+	switch (chip_id) {
+	case LM95233_CHIP_ID:
+		if (address != 0x18 && address != 0x2a && address != 0x2b)
+			return -ENODEV;
+		name = "lm95233";
+		break;
+	case LM95234_CHIP_ID:
+		if (address != 0x18 && address != 0x4d && address != 0x4e)
+			return -ENODEV;
+		name = "lm95234";
+		break;
+	default:
 		return -ENODEV;
+	}
 
 	val = i2c_smbus_read_byte_data(client, LM95234_REG_STATUS);
 	if (val & 0x30)
@@ -645,7 +675,7 @@ static int lm95234_detect(struct i2c_client *client,
 	if (val & 0xe1)
 		return -ENODEV;
 
-	strlcpy(info->type, "lm95234", I2C_NAME_SIZE);
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 	return 0;
 }
 
@@ -698,15 +728,19 @@ static int lm95234_probe(struct i2c_client *client,
 	if (err < 0)
 		return err;
 
+	data->groups[0] = &lm95234_common_group;
+	if (id->driver_data = lm95234)
+		data->groups[1] = &lm95234_group;
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-							   data,
-							   lm95234_groups);
+							   data, data->groups);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 /* Driver data (common to all clients) */
 static const struct i2c_device_id lm95234_id[] = {
-	{ "lm95234", 0 },
+	{ "lm95233", lm95233 },
+	{ "lm95234", lm95234 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm95234_id);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
