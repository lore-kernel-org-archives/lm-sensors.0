From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:11 +0000
Subject: [lm-sensors] [PATCH 22/39] hwmon: (g760a) Convert to use devm_ functions
Message-Id: <1344352828-25143-23-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/g760a.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index ebcd269..8b2106f 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -207,7 +207,8 @@ static int g760a_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	data = kzalloc(sizeof(struct g760a_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct g760a_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -223,7 +224,7 @@ static int g760a_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &g760a_group);
 	if (err)
-		goto error_sysfs_create_group;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -235,9 +236,6 @@ static int g760a_probe(struct i2c_client *client,
 
 error_hwmon_device_register:
 	sysfs_remove_group(&client->dev.kobj, &g760a_group);
-error_sysfs_create_group:
-	kfree(data);
-
 	return err;
 }
 
@@ -246,8 +244,6 @@ static int g760a_remove(struct i2c_client *client)
 	struct g760a_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &g760a_group);
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
