From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:29 +0000
Subject: [lm-sensors] [PATCH 48/95] hwmon: (lm83) Convert to use devm_ functions
Message-Id: <1339773856-3443-49-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm83.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index cd45b9d..e998034 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -343,11 +343,10 @@ static int lm83_probe(struct i2c_client *new_client,
 	struct lm83_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm83_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&new_client->dev, sizeof(struct lm83_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
 	data->valid = 0;
@@ -362,7 +361,7 @@ static int lm83_probe(struct i2c_client *new_client,
 
 	err = sysfs_create_group(&new_client->dev.kobj, &lm83_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	if (id->driver_data = lm83) {
 		err = sysfs_create_group(&new_client->dev.kobj,
@@ -382,9 +381,6 @@ static int lm83_probe(struct i2c_client *new_client,
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &lm83_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm83_group_opt);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -396,7 +392,6 @@ static int lm83_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &lm83_group);
 	sysfs_remove_group(&client->dev.kobj, &lm83_group_opt);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
