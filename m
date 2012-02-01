From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:55 +0000
Subject: [lm-sensors] [PATCH 07/24] hwmon: (atxp1) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.

Driver detection no longer fails if vrm is unknown. Instead, the cpu0_vid
attribute is not created in that case.

Replace the new_client variable with client to make code easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Witt <se.witt@gmx.net>
---
 drivers/hwmon/atxp1.c |   62 ++++++++++++++++++++----------------------------
 1 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 58af6aa..a99e771 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -80,7 +80,6 @@ struct atxp1_data {
 		u8 gpio1;   /* General purpose I/O register 1 */
 		u8 gpio2;   /* General purpose I/O register 2 */
 	} reg;
-	u8 vrm;			/* Detected CPU VRM */
 };
 
 static struct atxp1_data *atxp1_update_device(struct device *dev)
@@ -119,8 +118,8 @@ static ssize_t atxp1_showvcore(struct device *dev,
 
 	data = atxp1_update_device(dev);
 
-	size = sprintf(buf, "%d\n", vid_from_reg(data->reg.vid & ATXP1_VIDMASK,
-						 data->vrm));
+	size = sprintf(buf, "%d\n",
+		       vid_from_reg(data->reg.vid & ATXP1_VIDMASK));
 
 	return size;
 }
@@ -146,11 +145,10 @@ static ssize_t atxp1_storevcore(struct device *dev,
 	vcore *= 25;
 
 	/* Calculate VID */
-	vid = vid_to_reg(vcore, data->vrm);
-
+	vid = vid_to_reg(vcore);
 	if (vid < 0) {
 		dev_err(dev, "VID calculation failed.\n");
-		return -1;
+		return vid;
 	}
 
 	/*
@@ -288,7 +286,6 @@ static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
 static struct attribute *atxp1_attributes[] = {
 	&dev_attr_gpio1.attr,
 	&dev_attr_gpio2.attr,
-	&dev_attr_cpu0_vid.attr,
 	NULL
 };
 
@@ -298,10 +295,10 @@ static const struct attribute_group atxp1_group = {
 
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int atxp1_detect(struct i2c_client *new_client,
+static int atxp1_detect(struct i2c_client *client,
 			struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
 
 	u8 temp;
 
@@ -309,37 +306,28 @@ static int atxp1_detect(struct i2c_client *new_client,
 		return -ENODEV;
 
 	/* Detect ATXP1, checking if vendor ID registers are all zero */
-	if (!((i2c_smbus_read_byte_data(new_client, 0x3e) = 0) &&
-	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
-	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
-	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0)))
+	if (!((i2c_smbus_read_byte_data(client, 0x3e) = 0) &&
+	     (i2c_smbus_read_byte_data(client, 0x3f) = 0) &&
+	     (i2c_smbus_read_byte_data(client, 0xfe) = 0) &&
+	     (i2c_smbus_read_byte_data(client, 0xff) = 0)))
 		return -ENODEV;
 
 	/*
 	 * No vendor ID, now checking if registers 0x10,0x11 (non-existent)
 	 * showing the same as register 0x00
 	 */
-	temp = i2c_smbus_read_byte_data(new_client, 0x00);
-
-	if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
-	      (i2c_smbus_read_byte_data(new_client, 0x11) = temp)))
-		return -ENODEV;
+	temp = i2c_smbus_read_byte_data(client, 0x00);
 
-	/* Get VRM */
-	temp = vid_which_vrm();
-
-	if ((temp != 90) && (temp != 91)) {
-		dev_err(&adapter->dev, "atxp1: Not supporting VRM %d.%d\n",
-				temp / 10, temp % 10);
+	if (!((i2c_smbus_read_byte_data(client, 0x10) = temp) &&
+	      (i2c_smbus_read_byte_data(client, 0x11) = temp)))
 		return -ENODEV;
-	}
 
 	strlcpy(info->type, "atxp1", I2C_NAME_SIZE);
 
 	return 0;
 }
 
-static int atxp1_probe(struct i2c_client *new_client,
+static int atxp1_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
 	struct atxp1_data *data;
@@ -351,32 +339,33 @@ static int atxp1_probe(struct i2c_client *new_client,
 		goto exit;
 	}
 
-	/* Get VRM */
-	data->vrm = vid_which_vrm();
-
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	data->valid = 0;
 
 	mutex_init(&data->update_lock);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group);
+	err = sysfs_create_group(&client->dev.kobj, &atxp1_group);
 	if (err)
 		goto exit_free;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove_files;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
-	dev_info(&new_client->dev, "Using VRM: %d.%d\n",
-			 data->vrm / 10, data->vrm % 10);
-
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &atxp1_group);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
+	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
 exit_free:
 	kfree(data);
 exit:
@@ -388,6 +377,7 @@ static int atxp1_remove(struct i2c_client *client)
 	struct atxp1_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
 
 	kfree(data);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
