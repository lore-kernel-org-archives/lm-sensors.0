From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:43 +0000
Subject: [lm-sensors] [PATCH 62/95] hwmon: (ltc4151) Convert to use devm_ functions
Message-Id: <1339773856-3443-63-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Per Dalen <per.dalen@appeartv.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4151.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
index 4d005b2..8496baa 100644
--- a/drivers/hwmon/ltc4151.c
+++ b/drivers/hwmon/ltc4151.c
@@ -181,11 +181,9 @@ static int ltc4151_probe(struct i2c_client *client,
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
@@ -193,7 +191,7 @@ static int ltc4151_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&client->dev.kobj, &ltc4151_group);
 	if (ret)
-		goto out_sysfs_create_group;
+		return ret;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -205,9 +203,6 @@ static int ltc4151_probe(struct i2c_client *client,
 
 out_hwmon_device_register:
 	sysfs_remove_group(&client->dev.kobj, &ltc4151_group);
-out_sysfs_create_group:
-	kfree(data);
-out_kzalloc:
 	return ret;
 }
 
@@ -218,8 +213,6 @@ static int ltc4151_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &ltc4151_group);
 
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
