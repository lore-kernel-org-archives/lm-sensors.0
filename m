From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:40 +0000
Subject: [lm-sensors] [PATCH 59/95] hwmon: (max6639) Convert to use devm_ functions
Message-Id: <1339773856-3443-60-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6639.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index de8f7ad..6e60036 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -548,11 +548,10 @@ static int max6639_probe(struct i2c_client *client,
 	struct max6639_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct max6639_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct max6639_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -560,12 +559,12 @@ static int max6639_probe(struct i2c_client *client,
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client);
 	if (err < 0)
-		goto error_free;
+		return err;
 
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &max6639_group);
 	if (err)
-		goto error_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -579,9 +578,6 @@ static int max6639_probe(struct i2c_client *client,
 
 error_remove:
 	sysfs_remove_group(&client->dev.kobj, &max6639_group);
-error_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -592,7 +588,6 @@ static int max6639_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &max6639_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
