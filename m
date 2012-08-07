From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:25 +0000
Subject: [lm-sensors] [PATCH 36/39] hwmon: (w83l786ng) Convert to use devm_ functions
Message-Id: <1344352828-25143-37-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83l786ng.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 5850b77..c99c8a0 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -668,11 +668,10 @@ w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int i, err = 0;
 	u8 reg_tmp;
 
-	data = kzalloc(sizeof(struct w83l786ng_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct w83l786ng_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -708,8 +707,6 @@ w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &w83l786ng_group);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -721,8 +718,6 @@ w83l786ng_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &w83l786ng_group);
 
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
