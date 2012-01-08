From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:13 +0000
Subject: [lm-sensors] [PATCH 10/17 v2] hwmon: (adt7470) fix checkpatch issues
Message-Id: <1326047660-20539-10-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
ERROR: that open brace { should be on the previous line
#1135: FILE: adt7470.c:1135:
+static struct attribute *adt7470_attr[] +{

ERROR: do not use assignment in if condition
#1279: FILE: adt7470.c:1279:
+	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/adt7470.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index c6d1ce0..cad7f1a 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1131,8 +1131,7 @@ static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
 
-static struct attribute *adt7470_attr[] -{
+static struct attribute *adt7470_attr[] = {
 	&dev_attr_alarm_mask.attr,
 	&dev_attr_num_temp_sensors.attr,
 	&dev_attr_auto_update_interval.attr,
@@ -1276,7 +1275,8 @@ static int adt7470_probe(struct i2c_client *client,
 
 	/* Register sysfs hooks */
 	data->attrs.attrs = adt7470_attr;
-	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
+	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
