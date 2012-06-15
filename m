From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:01 +0000
Subject: [lm-sensors] [PATCH 20/95] hwmon: (adt7475) Convert to use devm_ functions
Message-Id: <1339773856-3443-21-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7475.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index df29d13..861c756 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1260,7 +1260,7 @@ static int adt7475_probe(struct i2c_client *client,
 	int i, ret = 0, revision;
 	u8 config2, config3;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (data = NULL)
 		return -ENOMEM;
 
@@ -1344,7 +1344,7 @@ static int adt7475_probe(struct i2c_client *client,
 
 	ret = sysfs_create_group(&client->dev.kobj, &adt7475_attr_group);
 	if (ret)
-		goto efree;
+		return ret;
 
 	/* Features that can be disabled individually */
 	if (data->has_fan4) {
@@ -1410,8 +1410,6 @@ static int adt7475_probe(struct i2c_client *client,
 
 eremove:
 	adt7475_remove_files(client, data);
-efree:
-	kfree(data);
 	return ret;
 }
 
@@ -1421,7 +1419,6 @@ static int adt7475_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	adt7475_remove_files(client, data);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
