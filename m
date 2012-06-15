From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:05 +0000
Subject: [lm-sensors] [PATCH 84/95] hwmon: (w83792d) Convert to use devm_ functions
Message-Id: <1339773856-3443-85-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83792d.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index ffb5fdf..9d5e7a2 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1422,11 +1422,9 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct device *dev = &client->dev;
 	int i, val1, err;
 
-	data = kzalloc(sizeof(struct w83792d_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto ERROR0;
-	}
+	data = devm_kzalloc(dev, sizeof(struct w83792d_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	data->valid = 0;
@@ -1434,7 +1432,7 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	err = w83792d_detect_subclients(client);
 	if (err)
-		goto ERROR1;
+		return err;
 
 	/* Initialize the chip */
 	w83792d_init_client(client);
@@ -1448,7 +1446,7 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&dev->kobj, &w83792d_group);
 	if (err)
-		goto ERROR3;
+		goto i2c_unregister;
 
 	/*
 	 * Read GPIO enable register to check if pins for fan 4,5 are used as
@@ -1493,14 +1491,11 @@ exit_remove_files:
 	sysfs_remove_group(&dev->kobj, &w83792d_group);
 	for (i = 0; i < ARRAY_SIZE(w83792d_group_fan); i++)
 		sysfs_remove_group(&dev->kobj, &w83792d_group_fan[i]);
-ERROR3:
+i2c_unregister:
 	if (data->lm75[0] != NULL)
 		i2c_unregister_device(data->lm75[0]);
 	if (data->lm75[1] != NULL)
 		i2c_unregister_device(data->lm75[1]);
-ERROR1:
-	kfree(data);
-ERROR0:
 	return err;
 }
 
@@ -1521,7 +1516,6 @@ w83792d_remove(struct i2c_client *client)
 	if (data->lm75[1] != NULL)
 		i2c_unregister_device(data->lm75[1]);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
