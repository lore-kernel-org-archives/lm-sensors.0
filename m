From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Feb 2014 01:03:33 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (max6639) Introduce local dev variable, and reduce noisiness
Message-Id: <1393031014-26259-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Introduce local variable 'dev' in probe function to make code easier
to read. Also drop dev_info message in probe to reduce noisiness
during boot.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6639.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 066e587..52646bb 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -545,11 +545,11 @@ static int max6639_detect(struct i2c_client *client,
 static int max6639_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct max6639_data *data;
 	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct max6639_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -562,22 +562,20 @@ static int max6639_probe(struct i2c_client *client,
 		return err;
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &max6639_group);
+	err = sysfs_create_group(&dev->kobj, &max6639_group);
 	if (err)
 		return err;
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto error_remove;
 	}
 
-	dev_info(&client->dev, "temperature sensor and fan control found\n");
-
 	return 0;
 
 error_remove:
-	sysfs_remove_group(&client->dev.kobj, &max6639_group);
+	sysfs_remove_group(&dev->kobj, &max6639_group);
 	return err;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
