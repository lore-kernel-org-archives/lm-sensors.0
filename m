From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Apr 2014 04:36:15 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (tmp102) Introduce dev variable in probe function
Message-Id: <1397277376-27502-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The pointer to client->dev is used several times in the probe function.
Simplify code by introducing a separate variable for it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp102.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 6748b45..5ea99a2 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -162,17 +162,18 @@ static const struct attribute_group tmp102_attr_group = {
 static int tmp102_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct tmp102 *tmp102;
 	int status;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(&client->dev,
+		dev_err(dev,
 			"adapter doesn't support SMBus word transactions\n");
 		return -ENODEV;
 	}
 
-	tmp102 = devm_kzalloc(&client->dev, sizeof(*tmp102), GFP_KERNEL);
+	tmp102 = devm_kzalloc(dev, sizeof(*tmp102), GFP_KERNEL);
 	if (!tmp102)
 		return -ENOMEM;
 
@@ -180,54 +181,53 @@ static int tmp102_probe(struct i2c_client *client,
 
 	status = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
 	if (status < 0) {
-		dev_err(&client->dev, "error reading config register\n");
+		dev_err(dev, "error reading config register\n");
 		return status;
 	}
 	tmp102->config_orig = status;
 	status = i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
 					      TMP102_CONFIG);
 	if (status < 0) {
-		dev_err(&client->dev, "error writing config register\n");
+		dev_err(dev, "error writing config register\n");
 		goto fail_restore_config;
 	}
 	status = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
 	if (status < 0) {
-		dev_err(&client->dev, "error reading config register\n");
+		dev_err(dev, "error reading config register\n");
 		goto fail_restore_config;
 	}
 	status &= ~TMP102_CONFIG_RD_ONLY;
 	if (status != TMP102_CONFIG) {
-		dev_err(&client->dev, "config settings did not stick\n");
+		dev_err(dev, "config settings did not stick\n");
 		status = -ENODEV;
 		goto fail_restore_config;
 	}
 	tmp102->last_update = jiffies - HZ;
 	mutex_init(&tmp102->lock);
 
-	status = sysfs_create_group(&client->dev.kobj, &tmp102_attr_group);
+	status = sysfs_create_group(&dev->kobj, &tmp102_attr_group);
 	if (status) {
-		dev_dbg(&client->dev, "could not create sysfs files\n");
+		dev_dbg(dev, "could not create sysfs files\n");
 		goto fail_restore_config;
 	}
-	tmp102->hwmon_dev = hwmon_device_register(&client->dev);
+	tmp102->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(tmp102->hwmon_dev)) {
-		dev_dbg(&client->dev, "unable to register hwmon device\n");
+		dev_dbg(dev, "unable to register hwmon device\n");
 		status = PTR_ERR(tmp102->hwmon_dev);
 		goto fail_remove_sysfs;
 	}
 
-	tmp102->tz = thermal_zone_of_sensor_register(&client->dev, 0,
-						     &client->dev,
+	tmp102->tz = thermal_zone_of_sensor_register(dev, 0, dev,
 						     tmp102_read_temp, NULL);
 	if (IS_ERR(tmp102->tz))
 		tmp102->tz = NULL;
 
-	dev_info(&client->dev, "initialized\n");
+	dev_info(dev, "initialized\n");
 
 	return 0;
 
 fail_remove_sysfs:
-	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
+	sysfs_remove_group(&dev->kobj, &tmp102_attr_group);
 fail_restore_config:
 	i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
 				     tmp102->config_orig);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
