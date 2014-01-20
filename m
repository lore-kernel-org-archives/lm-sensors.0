From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jan 2014 18:38:45 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm63) Create all sysfs groups in one call
Message-Id: <1390243126-19519-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We can create all sysfs groups in one call by using sysfs_create_groups
instead of using sysfs_create_group individually for each group.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch is purely to prepare for the next patch in the series.
Both could be merged, though I think it makes sense to keep it separate
to show the sequence of changes.

 drivers/hwmon/lm63.c |   38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 438e612..b56cb9f 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -157,6 +157,7 @@ enum chips { lm63, lm64, lm96163 };
 struct lm63_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
+	const struct attribute_group *groups[4];
 	char valid; /* zero until following fields are valid */
 	char lut_valid; /* zero until lut fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -1105,10 +1106,12 @@ static void lm63_init_client(struct i2c_client *client)
 static int lm63_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm63_data *data;
+	int groups = 0;
 	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm63_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm63_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1125,22 +1128,18 @@ static int lm63_probe(struct i2c_client *client,
 	lm63_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &lm63_group);
+	data->groups[groups++] = &lm63_group;
+	if (data->config & 0x04)	/* tachometer enabled */
+		data->groups[groups++] = &lm63_group_fan1;
+
+	if (data->kind = lm96163)
+		data->groups[groups++] = &lm63_group_lm96163;
+
+	err = sysfs_create_groups(&dev->kobj, data->groups);
 	if (err)
 		return err;
-	if (data->config & 0x04) { /* tachometer enabled */
-		err = sysfs_create_group(&client->dev.kobj, &lm63_group_fan1);
-		if (err)
-			goto exit_remove_files;
-	}
-	if (data->kind = lm96163) {
-		err = sysfs_create_group(&client->dev.kobj,
-					 &lm63_group_lm96163);
-		if (err)
-			goto exit_remove_files;
-	}
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
@@ -1149,10 +1148,7 @@ static int lm63_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &lm63_group);
-	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
-	if (data->kind = lm96163)
-		sysfs_remove_group(&client->dev.kobj, &lm63_group_lm96163);
+	sysfs_remove_groups(&dev->kobj, data->groups);
 	return err;
 }
 
@@ -1161,11 +1157,7 @@ static int lm63_remove(struct i2c_client *client)
 	struct lm63_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm63_group);
-	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
-	if (data->kind = lm96163)
-		sysfs_remove_group(&client->dev.kobj, &lm63_group_lm96163);
-
+	sysfs_remove_groups(&client->dev.kobj, data->groups);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
