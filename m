From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Sep 2007 16:44:42 +0000
Subject: [lm-sensors] [PATCH] hwmon/thmc50: Don't create temp3 if not enabled
Message-Id: <20070918184442.1bef286f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/hwmon/thmc50.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.23-rc6.orig/drivers/hwmon/thmc50.c	2007-09-18 17:05:29.000000000 +0200
+++ linux-2.6.23-rc6/drivers/hwmon/thmc50.c	2007-09-18 17:13:29.000000000 +0200
@@ -237,7 +237,7 @@ static const struct attribute_group thmc
 };
 
 /* for ADM1022 3rd temperature mode */
-static struct attribute *adm1022_attributes[] = {
+static struct attribute *temp3_attributes[] = {
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
@@ -246,8 +246,8 @@ static struct attribute *adm1022_attribu
 	NULL
 };
 
-static const struct attribute_group adm1022_group = {
-	.attrs = adm1022_attributes,
+static const struct attribute_group temp3_group = {
+	.attrs = temp3_attributes,
 };
 
 static int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
@@ -345,9 +345,9 @@ static int thmc50_detect(struct i2c_adap
 		goto exit_detach;
 
 	/* Register ADM1022 sysfs hooks */
-	if (data->type = adm1022)
+	if (data->has_temp3)
 		if ((err = sysfs_create_group(&client->dev.kobj,
-					      &adm1022_group)))
+					      &temp3_group)))
 			goto exit_remove_sysfs_thmc50;
 
 	/* Register a new directory entry with module sensors */
@@ -360,8 +360,8 @@ static int thmc50_detect(struct i2c_adap
 	return 0;
 
 exit_remove_sysfs:
-	if (data->type = adm1022)
-		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
+	if (data->has_temp3)
+		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 exit_remove_sysfs_thmc50:
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
 exit_detach:
@@ -386,8 +386,8 @@ static int thmc50_detach_client(struct i
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
-	if (data->type = adm1022)
-		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
+	if (data->has_temp3)
+		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 
 	if ((err = i2c_detach_client(client)))
 		return err;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
