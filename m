From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:39 +0000
Subject: [lm-sensors] [PATCH 58/95] hwmon: (max1668) Convert to use devm_ functions
Message-Id: <1339773856-3443-59-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1668.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index 335b183..666d9f6 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -411,7 +411,8 @@ static int max1668_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct max1668_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct max1668_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -422,7 +423,7 @@ static int max1668_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &max1668_group_common);
 	if (err)
-		goto error_free;
+		return err;
 
 	if (data->type = max1668 || data->type = max1989) {
 		err = sysfs_create_group(&client->dev.kobj,
@@ -444,8 +445,6 @@ error_sysrem1:
 		sysfs_remove_group(&client->dev.kobj, &max1668_group_unique);
 error_sysrem0:
 	sysfs_remove_group(&client->dev.kobj, &max1668_group_common);
-error_free:
-	kfree(data);
 	return err;
 }
 
@@ -459,7 +458,6 @@ static int max1668_remove(struct i2c_client *client)
 
 	sysfs_remove_group(&client->dev.kobj, &max1668_group_common);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
