From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:26 +0000
Subject: [lm-sensors] [PATCH 45/95] hwmon: (lm77) Convert to use devm_ functions
Message-Id: <1339773856-3443-46-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Also rename new_client variable, and define new variable for client->dev, to
improve code readability.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm77.c |   73 +++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 0fca861..f82acf6 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -267,10 +267,9 @@ static const struct attribute_group lm77_group = {
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm77_detect(struct i2c_client *new_client,
-		       struct i2c_board_info *info)
+static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
 	int i, cur, conf, hyst, crit, min, max;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
@@ -292,18 +291,18 @@ static int lm77_detect(struct i2c_client *new_client,
 	 */
 
 	/* addresses cycling */
-	cur = i2c_smbus_read_word_data(new_client, 0);
-	conf = i2c_smbus_read_byte_data(new_client, 1);
-	hyst = i2c_smbus_read_word_data(new_client, 2);
-	crit = i2c_smbus_read_word_data(new_client, 3);
-	min = i2c_smbus_read_word_data(new_client, 4);
-	max = i2c_smbus_read_word_data(new_client, 5);
+	cur = i2c_smbus_read_word_data(client, 0);
+	conf = i2c_smbus_read_byte_data(client, 1);
+	hyst = i2c_smbus_read_word_data(client, 2);
+	crit = i2c_smbus_read_word_data(client, 3);
+	min = i2c_smbus_read_word_data(client, 4);
+	max = i2c_smbus_read_word_data(client, 5);
 	for (i = 8; i <= 0xff; i += 8) {
-		if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
-		 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
-		 || i2c_smbus_read_word_data(new_client, i + 3) != crit
-		 || i2c_smbus_read_word_data(new_client, i + 4) != min
-		 || i2c_smbus_read_word_data(new_client, i + 5) != max)
+		if (i2c_smbus_read_byte_data(client, i + 1) != conf
+		 || i2c_smbus_read_word_data(client, i + 2) != hyst
+		 || i2c_smbus_read_word_data(client, i + 3) != crit
+		 || i2c_smbus_read_word_data(client, i + 4) != min
+		 || i2c_smbus_read_word_data(client, i + 5) != max)
 			return -ENODEV;
 	}
 
@@ -320,17 +319,17 @@ static int lm77_detect(struct i2c_client *new_client,
 		return -ENODEV;
 
 	/* 0x06 and 0x07 return the last read value */
-	cur = i2c_smbus_read_word_data(new_client, 0);
-	if (i2c_smbus_read_word_data(new_client, 6) != cur
-	 || i2c_smbus_read_word_data(new_client, 7) != cur)
+	cur = i2c_smbus_read_word_data(client, 0);
+	if (i2c_smbus_read_word_data(client, 6) != cur
+	 || i2c_smbus_read_word_data(client, 7) != cur)
 		return -ENODEV;
-	hyst = i2c_smbus_read_word_data(new_client, 2);
-	if (i2c_smbus_read_word_data(new_client, 6) != hyst
-	 || i2c_smbus_read_word_data(new_client, 7) != hyst)
+	hyst = i2c_smbus_read_word_data(client, 2);
+	if (i2c_smbus_read_word_data(client, 6) != hyst
+	 || i2c_smbus_read_word_data(client, 7) != hyst)
 		return -ENODEV;
-	min = i2c_smbus_read_word_data(new_client, 4);
-	if (i2c_smbus_read_word_data(new_client, 6) != min
-	 || i2c_smbus_read_word_data(new_client, 7) != min)
+	min = i2c_smbus_read_word_data(client, 4);
+	if (i2c_smbus_read_word_data(client, 6) != min
+	 || i2c_smbus_read_word_data(client, 7) != min)
 		return -ENODEV;
 
 	strlcpy(info->type, "lm77", I2C_NAME_SIZE);
@@ -338,31 +337,29 @@ static int lm77_detect(struct i2c_client *new_client,
 	return 0;
 }
 
-static int lm77_probe(struct i2c_client *new_client,
-		      const struct i2c_device_id *id)
+static int lm77_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm77_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm77_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(dev, sizeof(struct lm77_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM77 chip */
-	lm77_init_client(new_client);
+	lm77_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm77_group);
+	err = sysfs_create_group(&dev->kobj, &lm77_group);
 	if (err)
-		goto exit_free;
+		return err;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -371,10 +368,7 @@ static int lm77_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm77_group);
-exit_free:
-	kfree(data);
-exit:
+	sysfs_remove_group(&dev->kobj, &lm77_group);
 	return err;
 }
 
@@ -383,7 +377,6 @@ static int lm77_remove(struct i2c_client *client)
 	struct lm77_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm77_group);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
