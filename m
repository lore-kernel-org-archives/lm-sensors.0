From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:47 +0000
Subject: [lm-sensors] [PATCH 5/7] hwmon: (jc42) Convert to use devm_kzalloc
Message-Id: <1329929809-6085-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marginally less code and eliminate the possibility of memory leaks.
Also replace new_client variable with client and introduce dev variable to make
the code a bit easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c |   60 ++++++++++++++++++++-----------------------------
 1 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 7c2a52e..e2ff7fd 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -443,20 +443,19 @@ static const struct attribute_group jc42_group = {
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int jc42_detect(struct i2c_client *new_client,
-		       struct i2c_board_info *info)
+static int jc42_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
 	int i, config, cap, manid, devid;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	cap = i2c_smbus_read_word_swapped(new_client, JC42_REG_CAP);
-	config = i2c_smbus_read_word_swapped(new_client, JC42_REG_CONFIG);
-	manid = i2c_smbus_read_word_swapped(new_client, JC42_REG_MANID);
-	devid = i2c_smbus_read_word_swapped(new_client, JC42_REG_DEVICEID);
+	cap = i2c_smbus_read_word_swapped(client, JC42_REG_CAP);
+	config = i2c_smbus_read_word_swapped(client, JC42_REG_CONFIG);
+	manid = i2c_smbus_read_word_swapped(client, JC42_REG_MANID);
+	devid = i2c_smbus_read_word_swapped(client, JC42_REG_DEVICEID);
 
 	if (cap < 0 || config < 0 || manid < 0 || devid < 0)
 		return -ENODEV;
@@ -475,47 +474,42 @@ static int jc42_detect(struct i2c_client *new_client,
 	return -ENODEV;
 }
 
-static int jc42_probe(struct i2c_client *new_client,
-		      const struct i2c_device_id *id)
+static int jc42_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct jc42_data *data;
 	int config, cap, err;
+	struct device *dev = &client->dev;
 
-	data = kzalloc(sizeof(struct jc42_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(dev, sizeof(struct jc42_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	cap = i2c_smbus_read_word_swapped(new_client, JC42_REG_CAP);
-	if (cap < 0) {
-		err = -EINVAL;
-		goto exit_free;
-	}
+	cap = i2c_smbus_read_word_swapped(client, JC42_REG_CAP);
+	if (cap < 0)
+		return cap;
+
 	data->extended = !!(cap & JC42_CAP_RANGE);
 
-	config = i2c_smbus_read_word_swapped(new_client, JC42_REG_CONFIG);
-	if (config < 0) {
-		err = -EINVAL;
-		goto exit_free;
-	}
+	config = i2c_smbus_read_word_swapped(client, JC42_REG_CONFIG);
+	if (config < 0)
+		return config;
+
 	data->orig_config = config;
 	if (config & JC42_CFG_SHUTDOWN) {
 		config &= ~JC42_CFG_SHUTDOWN;
-		i2c_smbus_write_word_swapped(new_client, JC42_REG_CONFIG,
-					     config);
+		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG, config);
 	}
 	data->config = config;
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &jc42_group);
+	err = sysfs_create_group(&dev->kobj, &jc42_group);
 	if (err)
-		goto exit_free;
+		return err;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -524,10 +518,7 @@ static int jc42_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &jc42_group);
-exit_free:
-	kfree(data);
-exit:
+	sysfs_remove_group(&dev->kobj, &jc42_group);
 	return err;
 }
 
@@ -539,7 +530,6 @@ static int jc42_remove(struct i2c_client *client)
 	if (data->config != data->orig_config)
 		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG,
 					     data->orig_config);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
