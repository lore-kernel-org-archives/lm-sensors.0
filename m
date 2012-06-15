From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:54 +0000
Subject: [lm-sensors] [PATCH 13/95] hwmon: (adm9240) Convert to use devm_ functions
Message-Id: <1339773856-3443-14-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm9240.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index c3c2865..5a78d10 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -650,11 +650,9 @@ static int adm9240_probe(struct i2c_client *new_client,
 	struct adm9240_data *data;
 	int err;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&new_client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
 	mutex_init(&data->update_lock);
@@ -664,7 +662,7 @@ static int adm9240_probe(struct i2c_client *new_client,
 	/* populate sysfs filesystem */
 	err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -676,9 +674,6 @@ static int adm9240_probe(struct i2c_client *new_client,
 
 exit_remove:
 	sysfs_remove_group(&new_client->dev.kobj, &adm9240_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -689,7 +684,6 @@ static int adm9240_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
