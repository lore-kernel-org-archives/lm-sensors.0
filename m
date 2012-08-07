From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:13 +0000
Subject: [lm-sensors] [PATCH 24/39] hwmon: (lm95241) Convert to use devm_ functions
Message-Id: <1344352828-25143-25-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm95241.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index bd8cdb7..4b68fb2 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -391,11 +391,10 @@ static int lm95241_probe(struct i2c_client *new_client,
 	struct lm95241_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm95241_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&new_client->dev, sizeof(struct lm95241_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
 	mutex_init(&data->update_lock);
@@ -406,7 +405,7 @@ static int lm95241_probe(struct i2c_client *new_client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&new_client->dev.kobj, &lm95241_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -418,9 +417,6 @@ static int lm95241_probe(struct i2c_client *new_client,
 
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &lm95241_group);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -431,7 +427,6 @@ static int lm95241_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm95241_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
