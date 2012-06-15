From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:25 +0000
Subject: [lm-sensors] [PATCH 44/95] hwmon: (lm75) Convert to use devm_ functions
Message-Id: <1339773856-3443-45-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm75.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index a83f206..291edff 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -156,7 +156,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -EIO;
 
-	data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct lm75_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -174,7 +174,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	status = lm75_read_value(client, LM75_REG_CONF);
 	if (status < 0) {
 		dev_dbg(&client->dev, "Can't read config? %d\n", status);
-		goto exit_free;
+		return status;
 	}
 	data->orig_conf = status;
 	new = status & ~clr_mask;
@@ -186,7 +186,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register sysfs hooks */
 	status = sysfs_create_group(&client->dev.kobj, &lm75_group);
 	if (status)
-		goto exit_free;
+		return status;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -201,8 +201,6 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
-exit_free:
-	kfree(data);
 	return status;
 }
 
@@ -213,7 +211,6 @@ static int lm75_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
