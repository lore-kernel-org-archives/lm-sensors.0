From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:31 +0000
Subject: [lm-sensors] [PATCH 50/95] hwmon: (lm87) Convert to use devm_ functions
Message-Id: <1339773856-3443-51-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm87.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 314d147..16e45d7 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -898,11 +898,9 @@ static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct lm87_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct lm87_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	data->valid = 0;
@@ -923,7 +921,7 @@ static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &lm87_group);
 	if (err)
-		goto exit_free;
+		goto exit_stop;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
 		err = sysfs_create_group(&client->dev.kobj, &lm87_group_in6);
@@ -972,10 +970,8 @@ static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 exit_remove:
 	lm87_remove_files(client);
-exit_free:
+exit_stop:
 	lm87_write_value(client, LM87_REG_CONFIG, data->config);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -987,7 +983,6 @@ static int lm87_remove(struct i2c_client *client)
 	lm87_remove_files(client);
 
 	lm87_write_value(client, LM87_REG_CONFIG, data->config);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
