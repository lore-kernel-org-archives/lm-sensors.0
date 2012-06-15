From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:15 +0000
Subject: [lm-sensors] [PATCH 34/95] hwmon: (f75375s) Convert to use devm_ functions
Message-Id: <1339773856-3443-35-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f75375s.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index ece4159..f7dba22 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -838,7 +838,8 @@ static int f75375_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
-	data = kzalloc(sizeof(struct f75375_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct f75375_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -848,7 +849,7 @@ static int f75375_probe(struct i2c_client *client,
 
 	err = sysfs_create_group(&client->dev.kobj, &f75375_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	if (data->kind != f75373) {
 		err = sysfs_chmod_file(&client->dev.kobj,
@@ -875,8 +876,6 @@ static int f75375_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &f75375_group);
-exit_free:
-	kfree(data);
 	return err;
 }
 
@@ -885,7 +884,6 @@ static int f75375_remove(struct i2c_client *client)
 	struct f75375_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &f75375_group);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
