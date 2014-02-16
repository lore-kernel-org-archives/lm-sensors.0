From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 02:16:10 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (ltc4245) Use device managed function to register hwmon device
Message-Id: <1392516972-27576-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This simplifies the code and reduces code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4245.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index d4172933..2c6da5d 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -512,24 +512,10 @@ static int ltc4245_probe(struct i2c_client *client,
 	/* Add sysfs hooks */
 	ltc4245_sysfs_add_groups(data);
 
-	hwmon_dev = hwmon_device_register_with_groups(&client->dev,
-						      client->name, data,
-						      data->groups);
-	if (IS_ERR(hwmon_dev))
-		return PTR_ERR(hwmon_dev);
-
-	i2c_set_clientdata(client, hwmon_dev);
-
-	return 0;
-}
-
-static int ltc4245_remove(struct i2c_client *client)
-{
-	struct device *hwmon_dev = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(hwmon_dev);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id ltc4245_id[] = {
@@ -544,7 +530,6 @@ static struct i2c_driver ltc4245_driver = {
 		.name	= "ltc4245",
 	},
 	.probe		= ltc4245_probe,
-	.remove		= ltc4245_remove,
 	.id_table	= ltc4245_id,
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
