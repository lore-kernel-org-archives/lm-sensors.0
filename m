From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:19 +0000
Subject: [lm-sensors] [PATCH 38/95] hwmon: (gl520sm) Convert to use devm_ functions
Message-Id: <1339773856-3443-39-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gl520sm.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 5ff452b..a21ff25 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -779,11 +779,10 @@ static int gl520_probe(struct i2c_client *client,
 	struct gl520_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct gl520_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct gl520_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -794,7 +793,7 @@ static int gl520_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &gl520_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	if (data->two_temps)
 		err = sysfs_create_group(&client->dev.kobj, &gl520_group_temp2);
@@ -816,9 +815,6 @@ exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -870,7 +866,6 @@ static int gl520_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
