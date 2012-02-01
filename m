From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:10 +0000
Subject: [lm-sensors] [PATCH 22/24] hwmon: (lm78) Make cpu0_vid conditional
Message-Id: <1328123472-27816-23-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm78.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index f6bc414..521c6ff 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -433,7 +433,7 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *da,
 			char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
@@ -511,7 +511,6 @@ static struct attribute *lm78_attributes[] = {
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
-	&dev_attr_cpu0_vid.attr,
 
 	NULL
 };
@@ -676,6 +675,12 @@ static int lm78_i2c_probe(struct i2c_client *client,
 	if (err)
 		goto ERROR3;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto ERROR4;
+	}
+
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
@@ -685,6 +690,7 @@ static int lm78_i2c_probe(struct i2c_client *client,
 	return 0;
 
 ERROR4:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &lm78_group);
 ERROR3:
 	kfree(data);
@@ -696,6 +702,7 @@ static int lm78_i2c_remove(struct i2c_client *client)
 	struct lm78_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &lm78_group);
 	kfree(data);
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
