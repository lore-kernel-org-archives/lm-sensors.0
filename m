From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Feb 2014 01:21:48 +0000
Subject: [lm-sensors] [PATCH v2 2/4] hwmon: (lm63) Introduce 'dev' variable to point to client->dev
Message-Id: <1391390510-19238-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

client->dev is used multiple times in several functions.
Introduce dev variable pointing to it to simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm63.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 7ff4fc7..55b7d98 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -1038,6 +1038,7 @@ static int lm63_detect(struct i2c_client *client,
 static void lm63_init_client(struct i2c_client *client)
 {
 	struct lm63_data *data = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
 	u8 convrate;
 
 	data->config = i2c_smbus_read_byte_data(client, LM63_REG_CONFIG1);
@@ -1046,7 +1047,7 @@ static void lm63_init_client(struct i2c_client *client)
 
 	/* Start converting if needed */
 	if (data->config & 0x40) { /* standby */
-		dev_dbg(&client->dev, "Switching to operational mode\n");
+		dev_dbg(dev, "Switching to operational mode\n");
 		data->config &= 0xA7;
 		i2c_smbus_write_byte_data(client, LM63_REG_CONFIG1,
 					  data->config);
@@ -1099,13 +1100,13 @@ static void lm63_init_client(struct i2c_client *client)
 
 	/* Show some debug info about the LM63 configuration */
 	if (data->kind = lm63)
-		dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
+		dev_dbg(dev, "Alert/tach pin configured for %s\n",
 			(data->config & 0x04) ? "tachometer input" :
 			"alert output");
-	dev_dbg(&client->dev, "PWM clock %s kHz, output frequency %u Hz\n",
+	dev_dbg(dev, "PWM clock %s kHz, output frequency %u Hz\n",
 		(data->config_fan & 0x08) ? "1.4" : "360",
 		((data->config_fan & 0x08) ? 700 : 180000) / data->pwm1_freq);
-	dev_dbg(&client->dev, "PWM output active %s, %s mode\n",
+	dev_dbg(dev, "PWM output active %s, %s mode\n",
 		(data->config_fan & 0x10) ? "low" : "high",
 		(data->config_fan & 0x20) ? "manual" : "auto");
 }
@@ -1113,10 +1114,11 @@ static void lm63_init_client(struct i2c_client *client)
 static int lm63_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm63_data *data;
 	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm63_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm63_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1133,27 +1135,25 @@ static int lm63_probe(struct i2c_client *client,
 	lm63_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &lm63_group);
+	err = sysfs_create_group(&dev->kobj, &lm63_group);
 	if (err)
 		return err;
 	if (data->config & 0x04) { /* tachometer enabled */
-		err = sysfs_create_group(&client->dev.kobj, &lm63_group_fan1);
+		err = sysfs_create_group(&dev->kobj, &lm63_group_fan1);
 		if (err)
 			goto exit_remove_files;
 	}
 	if (data->kind = lm96163) {
-		err = sysfs_create_group(&client->dev.kobj,
-					 &lm63_group_temp2_type);
+		err = sysfs_create_group(&dev->kobj, &lm63_group_temp2_type);
 		if (err)
 			goto exit_remove_files;
 
-		err = sysfs_create_group(&client->dev.kobj,
-					 &lm63_group_extra_lut);
+		err = sysfs_create_group(&dev->kobj, &lm63_group_extra_lut);
 		if (err)
 			goto exit_remove_files;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
@@ -1162,11 +1162,11 @@ static int lm63_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &lm63_group);
-	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
+	sysfs_remove_group(&dev->kobj, &lm63_group);
+	sysfs_remove_group(&dev->kobj, &lm63_group_fan1);
 	if (data->kind = lm96163) {
-		sysfs_remove_group(&client->dev.kobj, &lm63_group_temp2_type);
-		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
+		sysfs_remove_group(&dev->kobj, &lm63_group_temp2_type);
+		sysfs_remove_group(&dev->kobj, &lm63_group_extra_lut);
 	}
 	return err;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
