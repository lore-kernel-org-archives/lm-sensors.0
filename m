From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:50 +0000
Subject: [lm-sensors] [PATCH 11/79] hwmon: (smsc47m192) Fix checkpatch issues
Message-Id: <1327373398-997-12-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '>' (ctx:VxV)
NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
WARNING: please, no space before tabs
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Hartmut Rick <linux@rick.claranet.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m192.c |  132 ++++++++++++++++++++++++++++---------------
 1 files changed, 86 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 8f88908..4705a8b 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -1,25 +1,25 @@
 /*
-    smsc47m192.c - Support for hardware monitoring block of
-                   SMSC LPC47M192 and compatible Super I/O chips
-
-    Copyright (C) 2006  Hartmut Rick <linux@rick.claranet.de>
-
-    Derived from lm78.c and other chip drivers.
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * smsc47m192.c - Support for hardware monitoring block of
+ *		  SMSC LPC47M192 and compatible Super I/O chips
+ *
+ * Copyright (C) 2006  Hartmut Rick <linux@rick.claranet.de>
+ *
+ * Derived from lm78.c and other chip drivers.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -37,16 +37,16 @@
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
 /* SMSC47M192 registers */
-#define SMSC47M192_REG_IN(nr)		((nr)<6 ? (0x20 + (nr)) : \
+#define SMSC47M192_REG_IN(nr)		((nr) < 6 ? (0x20 + (nr)) : \
 					(0x50 + (nr) - 6))
-#define SMSC47M192_REG_IN_MAX(nr)	((nr)<6 ? (0x2b + (nr) * 2) : \
+#define SMSC47M192_REG_IN_MAX(nr)	((nr) < 6 ? (0x2b + (nr) * 2) : \
 					(0x54 + (((nr) - 6) * 2)))
-#define SMSC47M192_REG_IN_MIN(nr)	((nr)<6 ? (0x2c + (nr) * 2) : \
+#define SMSC47M192_REG_IN_MIN(nr)	((nr) < 6 ? (0x2c + (nr) * 2) : \
 					(0x55 + (((nr) - 6) * 2)))
 static u8 SMSC47M192_REG_TEMP[3] =	{ 0x27, 0x26, 0x52 };
 static u8 SMSC47M192_REG_TEMP_MAX[3] =	{ 0x39, 0x37, 0x58 };
 static u8 SMSC47M192_REG_TEMP_MIN[3] =	{ 0x3A, 0x38, 0x59 };
-#define SMSC47M192_REG_TEMP_OFFSET(nr)	((nr)=2 ? 0x1e : 0x1f)
+#define SMSC47M192_REG_TEMP_OFFSET(nr)	((nr) = 2 ? 0x1e : 0x1f)
 #define SMSC47M192_REG_ALARM1		0x41
 #define SMSC47M192_REG_ALARM2		0x42
 #define SMSC47M192_REG_VID		0x47
@@ -80,8 +80,10 @@ static inline u8 IN_TO_REG(unsigned long val, int n)
 	return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
 }
 
-/* TEMP: 0.001 degC units (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 0.001 degC units (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static inline s8 TEMP_TO_REG(int val)
 {
 	return SENSORS_LIMIT(SCALE(val, 1, 1000), -128000, 127000);
@@ -170,7 +172,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, nr);
@@ -187,7 +194,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, nr);
@@ -249,7 +261,12 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = TEMP_TO_REG(val);
@@ -266,7 +283,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = TEMP_TO_REG(val);
@@ -293,22 +315,29 @@ static ssize_t set_temp_offset(struct device *dev, struct device_attribute
 	struct i2c_client *client = to_i2c_client(dev);
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = TEMP_TO_REG(val);
-	if (nr>1)
+	if (nr > 1)
 		i2c_smbus_write_byte_data(client,
 			SMSC47M192_REG_TEMP_OFFSET(nr), data->temp_offset[nr]);
 	else if (data->temp_offset[nr] != 0) {
-		/* offset[0] and offset[1] share the same register,
-			SFR bit 4 activates offset[0] */
+		/*
+		 * offset[0] and offset[1] share the same register,
+		 * SFR bit 4 activates offset[0]
+		 */
 		i2c_smbus_write_byte_data(client, SMSC47M192_REG_SFR,
-					(sfr & 0xef) | (nr=0 ? 0x10 : 0));
+					(sfr & 0xef) | (nr = 0 ? 0x10 : 0));
 		data->temp_offset[1-nr] = 0;
 		i2c_smbus_write_byte_data(client,
 			SMSC47M192_REG_TEMP_OFFSET(nr), data->temp_offset[nr]);
-	} else if ((sfr & 0x10) = (nr=0 ? 0x10 : 0))
+	} else if ((sfr & 0x10) = (nr = 0 ? 0x10 : 0))
 		i2c_smbus_write_byte_data(client,
 					SMSC47M192_REG_TEMP_OFFSET(nr), 0);
 	mutex_unlock(&data->update_lock);
@@ -349,7 +378,14 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct smsc47m192_data *data = dev_get_drvdata(dev);
-	data->vrm = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm = val;
 	return count;
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
@@ -458,13 +494,13 @@ static void smsc47m192_init_client(struct i2c_client *client)
 						(sfr & 0xfd) | 0x02);
 	if (!(config & 0x01)) {
 		/* initialize alarm limits */
-		for (i=0; i<8; i++) {
+		for (i = 0; i < 8; i++) {
 			i2c_smbus_write_byte_data(client,
 				SMSC47M192_REG_IN_MIN(i), 0);
 			i2c_smbus_write_byte_data(client,
 				SMSC47M192_REG_IN_MAX(i), 0xff);
 		}
-		for (i=0; i<3; i++) {
+		for (i = 0; i < 3; i++) {
 			i2c_smbus_write_byte_data(client,
 				SMSC47M192_REG_TEMP_MIN[i], 0x80);
 			i2c_smbus_write_byte_data(client,
@@ -532,14 +568,16 @@ static int smsc47m192_probe(struct i2c_client *client,
 	smsc47m192_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &smsc47m192_group)))
+	err = sysfs_create_group(&client->dev.kobj, &smsc47m192_group);
+	if (err)
 		goto exit_free;
 
 	/* Pin 110 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
 	if (!(config & 0x20)) {
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					      &smsc47m192_group_in4)))
+		err = sysfs_create_group(&client->dev.kobj,
+					 &smsc47m192_group_in4);
+		if (err)
 			goto exit_remove_files;
 	}
 
@@ -606,8 +644,10 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 		for (i = 1; i < 3; i++)
 			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
 						SMSC47M192_REG_TEMP_OFFSET(i));
-		/* first offset is temp_offset[0] if SFR bit 4 is set,
-					temp_offset[1] otherwise */
+		/*
+		 * first offset is temp_offset[0] if SFR bit 4 is set,
+		 * temp_offset[1] otherwise
+		 */
 		if (sfr & 0x10) {
 			data->temp_offset[0] = data->temp_offset[1];
 			data->temp_offset[1] = 0;
@@ -624,7 +664,7 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 		data->alarms = i2c_smbus_read_byte_data(client,
 						SMSC47M192_REG_ALARM1) |
 			       (i2c_smbus_read_byte_data(client,
-		       				SMSC47M192_REG_ALARM2) << 8);
+						SMSC47M192_REG_ALARM2) << 8);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
