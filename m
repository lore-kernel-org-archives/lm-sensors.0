From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:05 +0000
Subject: [lm-sensors] [PATCH 24/95] hwmon: (atxp1) Convert to use devm_ functions
Message-Id: <1339773856-3443-25-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/atxp1.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 58af6aa..aecb9ea 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -345,11 +345,10 @@ static int atxp1_probe(struct i2c_client *new_client,
 	struct atxp1_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct atxp1_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&new_client->dev, sizeof(struct atxp1_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	/* Get VRM */
 	data->vrm = vid_which_vrm();
@@ -362,7 +361,7 @@ static int atxp1_probe(struct i2c_client *new_client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -377,9 +376,6 @@ static int atxp1_probe(struct i2c_client *new_client,
 
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &atxp1_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 };
 
@@ -390,8 +386,6 @@ static int atxp1_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
 
-	kfree(data);
-
 	return 0;
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
