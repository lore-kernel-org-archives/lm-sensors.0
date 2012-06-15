From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:34 +0000
Subject: [lm-sensors] [PATCH 53/95] hwmon: (lm93) Convert to use devm_ functions
Message-Id: <1339773856-3443-54-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm93.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 67e8fe2..bf94618 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -2738,15 +2738,13 @@ static int lm93_probe(struct i2c_client *client,
 	} else {
 		dev_dbg(&client->dev, "detect failed, "
 			"smbus byte and/or word data not supported!\n");
-		err = -ENODEV;
-		goto err_out;
+		return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(struct lm93_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct lm93_data), GFP_KERNEL);
 	if (!data) {
 		dev_dbg(&client->dev, "out of memory!\n");
-		err = -ENOMEM;
-		goto err_out;
+		return -ENOMEM;
 	}
 	i2c_set_clientdata(client, data);
 
@@ -2760,7 +2758,7 @@ static int lm93_probe(struct i2c_client *client,
 
 	err = sysfs_create_group(&client->dev.kobj, &lm93_attr_grp);
 	if (err)
-		goto err_free;
+		return err;
 
 	/* Register hwmon driver class */
 	data->hwmon_dev = hwmon_device_register(&client->dev);
@@ -2770,9 +2768,6 @@ static int lm93_probe(struct i2c_client *client,
 	err = PTR_ERR(data->hwmon_dev);
 	dev_err(&client->dev, "error registering hwmon device.\n");
 	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
-err_free:
-	kfree(data);
-err_out:
 	return err;
 }
 
@@ -2783,7 +2778,6 @@ static int lm93_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
