From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:59 +0000
Subject: [lm-sensors] [PATCH 18/95] hwmon: (adt7462) Convert to use devm_ functions
Message-Id: <1339773856-3443-19-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7462.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 339269f..baee482 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -1931,11 +1931,10 @@ static int adt7462_probe(struct i2c_client *client,
 	struct adt7462_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct adt7462_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct adt7462_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->lock);
@@ -1946,7 +1945,7 @@ static int adt7462_probe(struct i2c_client *client,
 	data->attrs.attrs = adt7462_attr;
 	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1958,9 +1957,6 @@ static int adt7462_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -1970,7 +1966,6 @@ static int adt7462_remove(struct i2c_client *client)
 
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
