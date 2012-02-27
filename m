From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Feb 2012 20:59:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Restore original configuration if probe function fails
Message-Id: <1330376387-30456-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The lm90 driver restores the original chip configuration in its exit function.
However, the chip configuration is not restored if the probe function fails.
Restore it there as well.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index d2dd5f9..178de29 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1313,6 +1313,15 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
 	sysfs_remove_group(&dev->kobj, &lm90_group);
 }
 
+static void lm90_restore_conf(struct i2c_client *client, struct lm90_data *data)
+{
+	/* Restore initial configuration */
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
+				  data->convrate_orig);
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
+				  data->config_orig);
+}
+
 static void lm90_init_client(struct i2c_client *client)
 {
 	u8 config, convrate;
@@ -1399,7 +1408,7 @@ static int lm90_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&dev->kobj, &lm90_group);
 	if (err)
-		goto exit_free;
+		goto exit_restore;
 	if (client->flags & I2C_CLIENT_PEC) {
 		err = device_create_file(dev, &dev_attr_pec);
 		if (err)
@@ -1438,7 +1447,8 @@ static int lm90_probe(struct i2c_client *client,
 
 exit_remove_files:
 	lm90_remove_files(client, data);
-exit_free:
+exit_restore:
+	lm90_restore_conf(client, data);
 	kfree(data);
 exit:
 	return err;
@@ -1450,12 +1460,7 @@ static int lm90_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	lm90_remove_files(client, data);
-
-	/* Restore initial configuration */
-	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
-				  data->convrate_orig);
-	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
-				  data->config_orig);
+	lm90_restore_conf(client, data);
 
 	kfree(data);
 	return 0;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
