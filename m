From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:41 +0000
Subject: [lm-sensors] [PATCH 02/79] hwmon: (atxp1) Fix checkpatch issues
Message-Id: <1327373398-997-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: else should follow close brace '}'
ERROR: "foo * bar" should be "foo *bar"
WARNING: braces {} are not necessary for single statement blocks
WARNING: line over 80 characters
WARNING: please, no space before tabs
WARNING: please, no spaces at the start of a line
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Cc: Sebastian Witt <se.witt@gmx.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/atxp1.c |  158 +++++++++++++++++++++++++++++--------------------
 1 files changed, 93 insertions(+), 65 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index e69036a..58af6aa 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -1,22 +1,22 @@
 /*
-    atxp1.c - kernel module for setting CPU VID and general purpose
-                     I/Os using the Attansic ATXP1 chip.
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
-
-*/
+ * atxp1.c - kernel module for setting CPU VID and general purpose
+ *	     I/Os using the Attansic ATXP1 chip.
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
+ *
+ */
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -48,7 +48,7 @@ static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
 static int atxp1_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id);
 static int atxp1_remove(struct i2c_client *client);
-static struct atxp1_data * atxp1_update_device(struct device *dev);
+static struct atxp1_data *atxp1_update_device(struct device *dev);
 static int atxp1_detect(struct i2c_client *client, struct i2c_board_info *info);
 
 static const struct i2c_device_id atxp1_id[] = {
@@ -83,7 +83,7 @@ struct atxp1_data {
 	u8 vrm;			/* Detected CPU VRM */
 };
 
-static struct atxp1_data * atxp1_update_device(struct device *dev)
+static struct atxp1_data *atxp1_update_device(struct device *dev)
 {
 	struct i2c_client *client;
 	struct atxp1_data *data;
@@ -97,7 +97,8 @@ static struct atxp1_data * atxp1_update_device(struct device *dev)
 
 		/* Update local register data */
 		data->reg.vid = i2c_smbus_read_byte_data(client, ATXP1_VID);
-		data->reg.cpu_vid = i2c_smbus_read_byte_data(client, ATXP1_CVID);
+		data->reg.cpu_vid = i2c_smbus_read_byte_data(client,
+							     ATXP1_CVID);
 		data->reg.gpio1 = i2c_smbus_read_byte_data(client, ATXP1_GPIO1);
 		data->reg.gpio2 = i2c_smbus_read_byte_data(client, ATXP1_GPIO2);
 
@@ -110,29 +111,37 @@ static struct atxp1_data * atxp1_update_device(struct device *dev)
 }
 
 /* sys file functions for cpu0_vid */
-static ssize_t atxp1_showvcore(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t atxp1_showvcore(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
 
 	data = atxp1_update_device(dev);
 
-	size = sprintf(buf, "%d\n", vid_from_reg(data->reg.vid & ATXP1_VIDMASK, data->vrm));
+	size = sprintf(buf, "%d\n", vid_from_reg(data->reg.vid & ATXP1_VIDMASK,
+						 data->vrm));
 
 	return size;
 }
 
-static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t atxp1_storevcore(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
 	int vid, cvid;
-	unsigned int vcore;
+	unsigned long vcore;
+	int err;
 
 	client = to_i2c_client(dev);
 	data = atxp1_update_device(dev);
 
-	vcore = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &vcore);
+	if (err)
+		return err;
+
 	vcore /= 25;
 	vcore *= 25;
 
@@ -144,7 +153,10 @@ static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *att
 		return -1;
 	}
 
-	/* If output enabled, use control register value. Otherwise original CPU VID */
+	/*
+	 * If output enabled, use control register value.
+	 * Otherwise original CPU VID
+	 */
 	if (data->reg.vid & ATXP1_VIDENA)
 		cvid = data->reg.vid & ATXP1_VIDMASK;
 	else
@@ -154,18 +166,17 @@ static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *att
 	if (vid = cvid)
 		return count;
 
-	dev_dbg(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
+	dev_dbg(dev, "Setting VCore to %d mV (0x%02x)\n", (int)vcore, vid);
 
 	/* Write every 25 mV step to increase stability */
 	if (cvid > vid) {
-		for (; cvid >= vid; cvid--) {
-        		i2c_smbus_write_byte_data(client, ATXP1_VID, cvid | ATXP1_VIDENA);
-		}
-	}
-	else {
-		for (; cvid <= vid; cvid++) {
-        		i2c_smbus_write_byte_data(client, ATXP1_VID, cvid | ATXP1_VIDENA);
-		}
+		for (; cvid >= vid; cvid--)
+			i2c_smbus_write_byte_data(client,
+						ATXP1_VID, cvid | ATXP1_VIDENA);
+	} else {
+		for (; cvid <= vid; cvid++)
+			i2c_smbus_write_byte_data(client,
+						ATXP1_VID, cvid | ATXP1_VIDENA);
 	}
 
 	data->valid = 0;
@@ -173,13 +184,16 @@ static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-/* CPU core reference voltage
-    unit: millivolt
-*/
-static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);
+/*
+ * CPU core reference voltage
+ * unit: millivolt
+ */
+static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore,
+		   atxp1_storevcore);
 
 /* sys file functions for GPIO1 */
-static ssize_t atxp1_showgpio1(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t atxp1_showgpio1(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -191,21 +205,26 @@ static ssize_t atxp1_showgpio1(struct device *dev, struct device_attribute *attr
 	return size;
 }
 
-static ssize_t atxp1_storegpio1(struct device *dev, struct device_attribute *attr, const char*buf, size_t count)
+static ssize_t atxp1_storegpio1(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
-	unsigned int value;
+	unsigned long value;
+	int err;
 
 	client = to_i2c_client(dev);
 	data = atxp1_update_device(dev);
 
-	value = simple_strtoul(buf, NULL, 16);
+	err = kstrtoul(buf, 16, &value);
+	if (err)
+		return err;
 
 	value &= ATXP1_GPIO1MASK;
 
 	if (value != (data->reg.gpio1 & ATXP1_GPIO1MASK)) {
-		dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
+		dev_info(dev, "Writing 0x%x to GPIO1.\n", (unsigned int)value);
 
 		i2c_smbus_write_byte_data(client, ATXP1_GPIO1, value);
 
@@ -215,13 +234,15 @@ static ssize_t atxp1_storegpio1(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-/* GPIO1 data register
-    unit: Four bit as hex (e.g. 0x0f)
-*/
+/*
+ * GPIO1 data register
+ * unit: Four bit as hex (e.g. 0x0f)
+ */
 static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
 
 /* sys file functions for GPIO2 */
-static ssize_t atxp1_showgpio2(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t atxp1_showgpio2(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -233,19 +254,22 @@ static ssize_t atxp1_showgpio2(struct device *dev, struct device_attribute *attr
 	return size;
 }
 
-static ssize_t atxp1_storegpio2(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t atxp1_storegpio2(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
-	struct atxp1_data *data;
-	struct i2c_client *client;
-	unsigned int value;
-
-	client = to_i2c_client(dev);
-	data = atxp1_update_device(dev);
+	struct atxp1_data *data = atxp1_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long value;
+	int err;
 
-	value = simple_strtoul(buf, NULL, 16) & 0xff;
+	err = kstrtoul(buf, 16, &value);
+	if (err)
+		return err;
+	value &= 0xff;
 
 	if (value != data->reg.gpio2) {
-		dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
+		dev_info(dev, "Writing 0x%x to GPIO1.\n", (unsigned int)value);
 
 		i2c_smbus_write_byte_data(client, ATXP1_GPIO2, value);
 
@@ -255,9 +279,10 @@ static ssize_t atxp1_storegpio2(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-/* GPIO2 data register
-    unit: Eight bit as hex (e.g. 0xff)
-*/
+/*
+ * GPIO2 data register
+ * unit: Eight bit as hex (e.g. 0xff)
+ */
 static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
 
 static struct attribute *atxp1_attributes[] = {
@@ -290,8 +315,10 @@ static int atxp1_detect(struct i2c_client *new_client,
 	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0)))
 		return -ENODEV;
 
-	/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
-	 * showing the same as register 0x00 */
+	/*
+	 * No vendor ID, now checking if registers 0x10,0x11 (non-existent)
+	 * showing the same as register 0x00
+	 */
 	temp = i2c_smbus_read_byte_data(new_client, 0x00);
 
 	if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
@@ -333,7 +360,8 @@ static int atxp1_probe(struct i2c_client *new_client,
 	mutex_init(&data->update_lock);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
@@ -357,7 +385,7 @@ exit:
 
 static int atxp1_remove(struct i2c_client *client)
 {
-	struct atxp1_data * data = i2c_get_clientdata(client);
+	struct atxp1_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
