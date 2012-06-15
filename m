From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:36 +0000
Subject: [lm-sensors] [PATCH 55/95] hwmon: (lm95245) Convert to use devm_ functions
Message-Id: <1339773856-3443-56-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm95245.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 9a46c10..2915fd9 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -462,11 +462,10 @@ static int lm95245_probe(struct i2c_client *new_client,
 	struct lm95245_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm95245_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&new_client->dev, sizeof(struct lm95245_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
 	mutex_init(&data->update_lock);
@@ -477,7 +476,7 @@ static int lm95245_probe(struct i2c_client *new_client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&new_client->dev.kobj, &lm95245_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -489,9 +488,6 @@ static int lm95245_probe(struct i2c_client *new_client,
 
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &lm95245_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -502,7 +498,6 @@ static int lm95245_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm95245_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
