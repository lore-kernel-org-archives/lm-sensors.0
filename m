From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:41 +0000
Subject: [lm-sensors] [PATCH 60/95] hwmon: (max6642) Convert to use devm_ functions
Message-Id: <1339773856-3443-61-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Per Dalen <per.dalen@appeartv.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6642.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 4298909..bf236c0 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -286,11 +286,10 @@ static int max6642_probe(struct i2c_client *new_client,
 	struct max6642_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct max6642_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&new_client->dev, sizeof(struct max6642_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
 	mutex_init(&data->update_lock);
@@ -301,7 +300,7 @@ static int max6642_probe(struct i2c_client *new_client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&new_client->dev.kobj, &max6642_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -313,9 +312,6 @@ static int max6642_probe(struct i2c_client *new_client,
 
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &max6642_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -326,7 +322,6 @@ static int max6642_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &max6642_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
