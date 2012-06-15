From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:56 +0000
Subject: [lm-sensors] [PATCH 75/95] hwmon: (thmc50) Convert to use devm_ functions
Message-Id: <1339773856-3443-76-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/thmc50.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index add9f01..2f78e3f 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -361,11 +361,11 @@ static int thmc50_probe(struct i2c_client *client,
 	struct thmc50_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct thmc50_data),
+			    GFP_KERNEL);
 	if (!data) {
-		pr_debug("thmc50: detect failed, kzalloc failed!\n");
-		err = -ENOMEM;
-		goto exit;
+		pr_debug("thmc50: detect failed, devm_kzalloc failed!\n");
+		return -ENOMEM;
 	}
 
 	i2c_set_clientdata(client, data);
@@ -377,7 +377,7 @@ static int thmc50_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &thmc50_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	/* Register ADM1022 sysfs hooks */
 	if (data->has_temp3) {
@@ -400,9 +400,6 @@ exit_remove_sysfs:
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 exit_remove_sysfs_thmc50:
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -415,8 +412,6 @@ static int thmc50_remove(struct i2c_client *client)
 	if (data->has_temp3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 
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
