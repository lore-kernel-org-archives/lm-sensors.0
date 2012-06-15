From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:51 +0000
Subject: [lm-sensors] [PATCH 10/95] hwmon: (adm1026) Convert to use devm_ functions
Message-Id: <1339773856-3443-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1026.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 1003219..0f068e7 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -1834,11 +1834,10 @@ static int adm1026_probe(struct i2c_client *client,
 	struct adm1026_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct adm1026_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1026_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -1852,7 +1851,7 @@ static int adm1026_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &adm1026_group);
 	if (err)
-		goto exitfree;
+		return err;
 	if (data->config1 & CFG1_AIN8_9)
 		err = sysfs_create_group(&client->dev.kobj,
 					 &adm1026_group_in8_9);
@@ -1877,9 +1876,6 @@ exitremove:
 		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
 	else
 		sysfs_remove_group(&client->dev.kobj, &adm1026_group_temp3);
-exitfree:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -1892,7 +1888,6 @@ static int adm1026_remove(struct i2c_client *client)
 		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
 	else
 		sysfs_remove_group(&client->dev.kobj, &adm1026_group_temp3);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
