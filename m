From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:59 +0000
Subject: [lm-sensors] [PATCH 78/95] hwmon: (tmp421) Convert to use devm_ functions
Message-Id: <1339773856-3443-79-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp421.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 8fac87a..6a8ded2 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -267,7 +267,8 @@ static int tmp421_probe(struct i2c_client *client,
 	struct tmp421_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct tmp421_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct tmp421_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -277,11 +278,11 @@ static int tmp421_probe(struct i2c_client *client,
 
 	err = tmp421_init_client(client);
 	if (err)
-		goto exit_free;
+		return err;
 
 	err = sysfs_create_group(&client->dev.kobj, &tmp421_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -293,10 +294,6 @@ static int tmp421_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &tmp421_group);
-
-exit_free:
-	kfree(data);
-
 	return err;
 }
 
@@ -307,8 +304,6 @@ static int tmp421_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &tmp421_group);
 
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
