From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:18 +0000
Subject: [lm-sensors] [PATCH 29/39] hwmon: (ltc4245) Convert to use devm_ functions
Message-Id: <1344352828-25143-30-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4245.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index b99b45b..5207591 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -519,11 +519,9 @@ static int ltc4245_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto out_kzalloc;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -536,7 +534,7 @@ static int ltc4245_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	ret = ltc4245_sysfs_create_groups(client);
 	if (ret)
-		goto out_sysfs_create_groups;
+		return ret;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -548,9 +546,6 @@ static int ltc4245_probe(struct i2c_client *client,
 
 out_hwmon_device_register:
 	ltc4245_sysfs_remove_groups(client);
-out_sysfs_create_groups:
-	kfree(data);
-out_kzalloc:
 	return ret;
 }
 
@@ -560,7 +555,6 @@ static int ltc4245_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	ltc4245_sysfs_remove_groups(client);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
