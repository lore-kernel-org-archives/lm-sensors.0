From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:30 +0000
Subject: [lm-sensors] [PATCH 28/39] hwmon: (smsc47m192) Fix checkpatch issues
Message-Id: <1326703781-14272-29-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m192.c |   74 ++++++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 40b2667..95761bd 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -1,6 +1,6 @@
 /*
     smsc47m192.c - Support for hardware monitoring block of
-                   SMSC LPC47M192 and compatible Super I/O chips
+		SMSC LPC47M192 and compatible Super I/O chips
 
     Copyright (C) 2006  Hartmut Rick <linux@rick.claranet.de>
 
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
@@ -170,7 +170,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
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
@@ -187,7 +192,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
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
@@ -249,7 +259,12 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
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
@@ -266,7 +281,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
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
@@ -293,22 +313,27 @@ static ssize_t set_temp_offset(struct device *dev, struct device_attribute
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
 		/* offset[0] and offset[1] share the same register,
 			SFR bit 4 activates offset[0] */
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
@@ -349,7 +374,14 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
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
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
@@ -458,13 +490,13 @@ static void smsc47m192_init_client(struct i2c_client *client)
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
@@ -532,14 +564,16 @@ static int smsc47m192_probe(struct i2c_client *client,
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
 
@@ -624,7 +658,7 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 		data->alarms = i2c_smbus_read_byte_data(client,
 						SMSC47M192_REG_ALARM1) |
 			       (i2c_smbus_read_byte_data(client,
-		       				SMSC47M192_REG_ALARM2) << 8);
+						SMSC47M192_REG_ALARM2) << 8);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
