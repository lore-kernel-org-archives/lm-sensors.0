From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:54 +0000
Subject: [lm-sensors] [PATCH 05/39] hwmon: (ad7418) Convert to use devm_ functions
Message-Id: <1344352828-25143-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7418.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index a50a6be..57d4a62 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -227,16 +227,13 @@ static int ad7418_probe(struct i2c_client *client,
 	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-					I2C_FUNC_SMBUS_WORD_DATA)) {
-		err = -EOPNOTSUPP;
-		goto exit;
-	}
+					I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
 
-	data = kzalloc(sizeof(struct ad7418_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct ad7418_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 
@@ -268,7 +265,7 @@ static int ad7418_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -280,9 +277,6 @@ static int ad7418_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -291,7 +285,6 @@ static int ad7418_remove(struct i2c_client *client)
 	struct ad7418_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
