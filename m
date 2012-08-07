From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:53 +0000
Subject: [lm-sensors] [PATCH 04/39] hwmon: (ad7414) Convert to use devm_ functions
Message-Id: <1344352828-25143-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7414.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 06d2d60..b420fb3 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -185,16 +185,13 @@ static int ad7414_probe(struct i2c_client *client,
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
-		err = -EOPNOTSUPP;
-		goto exit;
-	}
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EOPNOTSUPP;
 
-	data = kzalloc(sizeof(struct ad7414_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct ad7414_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->lock);
@@ -214,7 +211,7 @@ static int ad7414_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &ad7414_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -226,9 +223,6 @@ static int ad7414_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -238,7 +232,6 @@ static int __devexit ad7414_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
