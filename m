From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:30 +0000
Subject: [lm-sensors] [PATCH 49/95] hwmon: (lm85) Convert to use devm_ functions
Message-Id: <1339773856-3443-50-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm85.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 864c7d9..9f2dd77 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1387,7 +1387,7 @@ static int lm85_probe(struct i2c_client *client,
 	struct lm85_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm85_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct lm85_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1419,7 +1419,7 @@ static int lm85_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &lm85_group);
 	if (err)
-		goto err_kfree;
+		return err;
 
 	/* minctl and temp_off exist on all chips except emc6d103s */
 	if (data->type != emc6d103s) {
@@ -1466,8 +1466,6 @@ static int lm85_probe(struct i2c_client *client,
 	/* Error out and cleanup code */
  err_remove_files:
 	lm85_remove_files(client, data);
- err_kfree:
-	kfree(data);
 	return err;
 }
 
@@ -1476,7 +1474,6 @@ static int lm85_remove(struct i2c_client *client)
 	struct lm85_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	lm85_remove_files(client, data);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
