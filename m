From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:00 +0000
Subject: [lm-sensors] [PATCH 19/95] hwmon: (adt7470) Convert to use devm_ functions
Message-Id: <1339773856-3443-20-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7470.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 54ec890..39ecb1a 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1256,11 +1256,10 @@ static int adt7470_probe(struct i2c_client *client,
 	struct adt7470_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct adt7470_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct adt7470_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->num_temp_sensors = -1;
 	data->auto_update_interval = AUTO_UPDATE_INTERVAL;
@@ -1277,7 +1276,7 @@ static int adt7470_probe(struct i2c_client *client,
 	data->attrs.attrs = adt7470_attr;
 	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1299,9 +1298,6 @@ exit_unregister:
 	hwmon_device_unregister(data->hwmon_dev);
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -1313,7 +1309,6 @@ static int adt7470_remove(struct i2c_client *client)
 	wait_for_completion(&data->auto_update_stop);
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
