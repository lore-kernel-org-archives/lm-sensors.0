From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:48 +0000
Subject: [lm-sensors] [PATCH 09/79] hwmon: (pcf8591) Fix checkpatch issues
Message-Id: <1327373398-997-10-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: do not use assignment in if condition
ERROR: spaces required around that ':' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxV)
WARNING: line over 80 characters
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pcf8591.c |  139 +++++++++++++++++++++++++++++------------------
 1 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 2041155..4174c74 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -1,22 +1,22 @@
 /*
-    Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
-    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
-    the help of Jean Delvare <khali@linux-fr.org>
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
+ * Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
+ * Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
+ * the help of Jean Delvare <khali@linux-fr.org>
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
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -39,28 +39,34 @@ MODULE_PARM_DESC(input_mode,
 	" 2 = single ended and differential mixed\n"
 	" 3 = two differential inputs\n");
 
-/* The PCF8591 control byte
-      7    6    5    4    3    2    1    0
-   |  0 |AOEF|   AIP   |  0 |AINC|  AICH   | */
+/*
+ * The PCF8591 control byte
+ *      7    6    5    4    3    2    1    0
+ *   |  0 |AOEF|   AIP   |  0 |AINC|  AICH   |
+ */
 
 /* Analog Output Enable Flag (analog output active if 1) */
 #define PCF8591_CONTROL_AOEF		0x40
 
-/* Analog Input Programming
-   0x00 = four single ended inputs
-   0x10 = three differential inputs
-   0x20 = single ended and differential mixed
-   0x30 = two differential inputs */
+/*
+ * Analog Input Programming
+ * 0x00 = four single ended inputs
+ * 0x10 = three differential inputs
+ * 0x20 = single ended and differential mixed
+ * 0x30 = two differential inputs
+ */
 #define PCF8591_CONTROL_AIP_MASK	0x30
 
 /* Autoincrement Flag (switch on if 1) */
 #define PCF8591_CONTROL_AINC		0x04
 
-/* Channel selection
-   0x00 = channel 0
-   0x01 = channel 1
-   0x02 = channel 2
-   0x03 = channel 3 */
+/*
+ * Channel selection
+ * 0x00 = channel 0
+ * 0x01 = channel 1
+ * 0x02 = channel 2
+ * 0x03 = channel 3
+ */
 #define PCF8591_CONTROL_AICH_MASK	0x03
 
 /* Initial values */
@@ -68,7 +74,7 @@ MODULE_PARM_DESC(input_mode,
 #define PCF8591_INIT_AOUT	0	/* DAC out = 0 */
 
 /* Conversions */
-#define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
+#define REG_TO_SIGNED(reg)	(((reg) & 0x80) ? ((reg) - 256) : (reg))
 
 struct pcf8591_data {
 	struct device *hwmon_dev;
@@ -83,7 +89,9 @@ static int pcf8591_read_channel(struct device *dev, int channel);
 
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\
-static ssize_t show_in##channel##_input(struct device *dev, struct device_attribute *attr, char *buf)	\
+static ssize_t show_in##channel##_input(struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
 {									\
 	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
 }									\
@@ -95,39 +103,57 @@ show_in_channel(1);
 show_in_channel(2);
 show_in_channel(3);
 
-static ssize_t show_out0_ouput(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_out0_ouput(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%d\n", data->aout * 10);
 }
 
-static ssize_t set_out0_output(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_out0_output(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
-	unsigned int value;
+	unsigned long val;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
-	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
-		data->aout = value;
-		i2c_smbus_write_byte_data(client, data->control, data->aout);
-		return count;
-	}
-	return -EINVAL;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	val /= 10;
+	if (val > 255)
+		return -EINVAL;
+
+	data->aout = val;
+	i2c_smbus_write_byte_data(client, data->control, data->aout);
+	return count;
 }
 
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO,
 		   show_out0_ouput, set_out0_output);
 
-static ssize_t show_out0_enable(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_out0_enable(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
 }
 
-static ssize_t set_out0_enable(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_out0_enable(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	if (val)
@@ -174,7 +200,8 @@ static int pcf8591_probe(struct i2c_client *client,
 	struct pcf8591_data *data;
 	int err;
 
-	if (!(data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -192,15 +219,15 @@ static int pcf8591_probe(struct i2c_client *client,
 
 	/* Register input2 if not in "two differential inputs" mode */
 	if (input_mode != 3) {
-		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in2_input)))
+		err = device_create_file(&client->dev, &dev_attr_in2_input);
+		if (err)
 			goto exit_sysfs_remove;
 	}
 
 	/* Register input3 only in "four single ended inputs" mode */
 	if (input_mode = 0) {
-		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in3_input)))
+		err = device_create_file(&client->dev, &dev_attr_in3_input);
+		if (err)
 			goto exit_sysfs_remove;
 	}
 
@@ -241,8 +268,10 @@ static void pcf8591_init_client(struct i2c_client *client)
 
 	i2c_smbus_write_byte_data(client, data->control, data->aout);
 
-	/* The first byte transmitted contains the conversion code of the
-	   previous read cycle. FLUSH IT! */
+	/*
+	 * The first byte transmitted contains the conversion code of the
+	 * previous read cycle. FLUSH IT!
+	 */
 	i2c_smbus_read_byte(client);
 }
 
@@ -259,8 +288,10 @@ static int pcf8591_read_channel(struct device *dev, int channel)
 			      | channel;
 		i2c_smbus_write_byte(client, data->control);
 
-		/* The first byte transmitted contains the conversion code of
-		   the previous read cycle. FLUSH IT! */
+		/*
+		 * The first byte transmitted contains the conversion code of
+		 * the previous read cycle. FLUSH IT!
+		 */
 		i2c_smbus_read_byte(client);
 	}
 	value = i2c_smbus_read_byte(client);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
