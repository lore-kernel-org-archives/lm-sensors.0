From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:58 +0000
Subject: [lm-sensors] [PATCH 09/39] hwmon: (ads7828) Convert to use devm_ functions
Message-Id: <1344352828-25143-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ads7828.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index bf3fdf4..1f9e8af 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -154,7 +154,6 @@ static int ads7828_remove(struct i2c_client *client)
 	struct ads7828_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &ads7828_group);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -217,11 +216,10 @@ static int ads7828_probe(struct i2c_client *client,
 	struct ads7828_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct ads7828_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct ads7828_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -229,7 +227,7 @@ static int ads7828_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &ads7828_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -241,9 +239,6 @@ static int ads7828_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &ads7828_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
