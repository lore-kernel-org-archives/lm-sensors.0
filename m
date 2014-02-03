From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Feb 2014 01:21:47 +0000
Subject: [lm-sensors] [PATCH v2 1/4] hwmon: (lm63) Add additional sysfs group for temp2_type attribute
Message-Id: <1391390510-19238-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With the new hwmon API, we can only add groups of attributes, not individual
attributes. To prepare for the use of the new API, add an additional sensor
group for the temp2_type attribute and register it with sysfs_create_group
instead of device_create_file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Do not merge temp2_type attribute with extra_lut group but create separate
    group instead.

 drivers/hwmon/lm63.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index b4ad598..7ff4fc7 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -915,6 +915,15 @@ static struct attribute *lm63_attributes[] = {
 	NULL
 };
 
+static struct attribute *lm63_attributes_temp2_type[] = {
+	&dev_attr_temp2_type.attr,
+	NULL
+};
+
+static const struct attribute_group lm63_group_temp2_type = {
+	.attrs = lm63_attributes_temp2_type,
+};
+
 static struct attribute *lm63_attributes_extra_lut[] = {
 	&sensor_dev_attr_pwm1_auto_point9_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point9_temp.dev_attr.attr,
@@ -1133,7 +1142,8 @@ static int lm63_probe(struct i2c_client *client,
 			goto exit_remove_files;
 	}
 	if (data->kind = lm96163) {
-		err = device_create_file(&client->dev, &dev_attr_temp2_type);
+		err = sysfs_create_group(&client->dev.kobj,
+					 &lm63_group_temp2_type);
 		if (err)
 			goto exit_remove_files;
 
@@ -1155,7 +1165,7 @@ exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
 	if (data->kind = lm96163) {
-		device_remove_file(&client->dev, &dev_attr_temp2_type);
+		sysfs_remove_group(&client->dev.kobj, &lm63_group_temp2_type);
 		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
 	}
 	return err;
@@ -1169,7 +1179,7 @@ static int lm63_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
 	if (data->kind = lm96163) {
-		device_remove_file(&client->dev, &dev_attr_temp2_type);
+		sysfs_remove_group(&client->dev.kobj, &lm63_group_temp2_type);
 		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
 	}
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
