From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:00 +0000
Subject: [lm-sensors] [PATCH 11/39] hwmon: (adt7411) Convert to use devm_ functions
Message-Id: <1344352828-25143-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7411.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 71bacc5..fe72c69 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -283,7 +283,7 @@ static int __devinit adt7411_probe(struct i2c_client *client,
 	struct adt7411_data *data;
 	int ret;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -294,14 +294,14 @@ static int __devinit adt7411_probe(struct i2c_client *client,
 	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
 				 ADT7411_CFG1_START_MONITOR, 1);
 	if (ret < 0)
-		goto exit_free;
+		return ret;
 
 	/* force update on first occasion */
 	data->next_update = jiffies;
 
 	ret = sysfs_create_group(&client->dev.kobj, &adt7411_attr_grp);
 	if (ret)
-		goto exit_free;
+		return ret;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -315,8 +315,6 @@ static int __devinit adt7411_probe(struct i2c_client *client,
 
  exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
- exit_free:
-	kfree(data);
 	return ret;
 }
 
@@ -326,7 +324,6 @@ static int __devexit adt7411_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
