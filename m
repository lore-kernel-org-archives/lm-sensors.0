From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 01:26:34 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm90) Create all sysfs groups in one call
Message-Id: <1392513995-30712-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Create all sysfs groups in one call by using sysfs_create_groups
instead of calling sysfs_create_group individually for each group.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |   67 +++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c3bb771..5ddfab0 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -366,6 +366,7 @@ enum lm90_temp11_reg_index {
 
 struct lm90_data {
 	struct device *hwmon_dev;
+	const struct attribute_group *groups[7];
 	struct mutex update_lock;
 	struct regulator *regulator;
 	char valid; /* zero until following fields are valid */
@@ -1411,22 +1412,6 @@ static int lm90_detect(struct i2c_client *client,
 	return 0;
 }
 
-static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
-{
-	struct device *dev = &client->dev;
-
-	if (data->flags & LM90_HAVE_TEMP3)
-		sysfs_remove_group(&dev->kobj, &lm90_temp3_group);
-	if (data->flags & LM90_HAVE_EMERGENCY_ALARM)
-		sysfs_remove_group(&dev->kobj, &lm90_emergency_alarm_group);
-	if (data->flags & LM90_HAVE_EMERGENCY)
-		sysfs_remove_group(&dev->kobj, &lm90_emergency_group);
-	if (data->flags & LM90_HAVE_OFFSET)
-		sysfs_remove_group(&dev->kobj, &lm90_temp2_offset_group);
-	sysfs_remove_group(&dev->kobj, &lm90_pec_group);
-	sysfs_remove_group(&dev->kobj, &lm90_group);
-}
-
 static void lm90_restore_conf(struct i2c_client *client, struct lm90_data *data)
 {
 	/* Restore initial configuration */
@@ -1537,6 +1522,7 @@ static int lm90_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
 	struct lm90_data *data;
 	struct regulator *regulator;
+	int groups = 0;
 	int err;
 
 	regulator = devm_regulator_get(dev, "vcc");
@@ -1583,35 +1569,26 @@ static int lm90_probe(struct i2c_client *client,
 	lm90_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&dev->kobj, &lm90_group);
+	data->groups[groups++] = &lm90_group;
+
+	if (client->flags & I2C_CLIENT_PEC)
+		data->groups[groups++] = &lm90_pec_group;
+
+	if (data->flags & LM90_HAVE_OFFSET)
+		data->groups[groups++] = &lm90_temp2_offset_group;
+
+	if (data->flags & LM90_HAVE_EMERGENCY)
+		data->groups[groups++] = &lm90_emergency_group;
+
+	if (data->flags & LM90_HAVE_EMERGENCY_ALARM)
+		data->groups[groups++] = &lm90_emergency_alarm_group;
+
+	if (data->flags & LM90_HAVE_TEMP3)
+		data->groups[groups++] = &lm90_temp3_group;
+
+	err = sysfs_create_groups(&client->dev.kobj, data->groups);
 	if (err)
 		goto exit_restore;
-	if (client->flags & I2C_CLIENT_PEC) {
-		err = sysfs_create_group(&dev->kobj, &lm90_pec_group);
-		if (err)
-			goto exit_remove_files;
-	}
-	if (data->flags & LM90_HAVE_OFFSET) {
-		err = sysfs_create_group(&dev->kobj, &lm90_temp2_offset_group);
-		if (err)
-			goto exit_remove_files;
-	}
-	if (data->flags & LM90_HAVE_EMERGENCY) {
-		err = sysfs_create_group(&dev->kobj, &lm90_emergency_group);
-		if (err)
-			goto exit_remove_files;
-	}
-	if (data->flags & LM90_HAVE_EMERGENCY_ALARM) {
-		err = sysfs_create_group(&dev->kobj,
-					 &lm90_emergency_alarm_group);
-		if (err)
-			goto exit_remove_files;
-	}
-	if (data->flags & LM90_HAVE_TEMP3) {
-		err = sysfs_create_group(&dev->kobj, &lm90_temp3_group);
-		if (err)
-			goto exit_remove_files;
-	}
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1636,7 +1613,7 @@ static int lm90_probe(struct i2c_client *client,
 exit_unregister:
 	hwmon_device_unregister(data->hwmon_dev);
 exit_remove_files:
-	lm90_remove_files(client, data);
+	sysfs_remove_groups(&client->dev.kobj, data->groups);
 exit_restore:
 	lm90_restore_conf(client, data);
 	regulator_disable(data->regulator);
@@ -1649,7 +1626,7 @@ static int lm90_remove(struct i2c_client *client)
 	struct lm90_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	lm90_remove_files(client, data);
+	sysfs_remove_groups(&client->dev.kobj, data->groups);
 	lm90_restore_conf(client, data);
 	regulator_disable(data->regulator);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
