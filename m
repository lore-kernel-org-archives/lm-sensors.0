From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:49 +0000
Subject: [lm-sensors] [PATCH 7/7] hwmon: (ltc4261) Convert to use devm_kzalloc
Message-Id: <1329929809-6085-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marginally less code and eliminate the possibility of memory leaks.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4261.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index ab1bfbf..069b7d3 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -235,11 +235,9 @@ static int ltc4261_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
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
@@ -250,7 +248,7 @@ static int ltc4261_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&client->dev.kobj, &ltc4261_group);
 	if (ret)
-		goto out_sysfs_create_group;
+		return ret;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -262,9 +260,6 @@ static int ltc4261_probe(struct i2c_client *client,
 
 out_hwmon_device_register:
 	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
-out_sysfs_create_group:
-	kfree(data);
-out_kzalloc:
 	return ret;
 }
 
@@ -275,8 +270,6 @@ static int ltc4261_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
 
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
