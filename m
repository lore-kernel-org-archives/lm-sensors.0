From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:17 +0000
Subject: [lm-sensors] [PATCH 14/17 v2] hwmon: (ad7418) fix checkpatch issues
Message-Id: <1326047660-20539-14-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


fixed:
WARNING: simple_strtol is obsolete, use kstrtol instead
#170: FILE: ad7418.c:170:
+	long temp = simple_strtol(buf, NULL, 10);

ERROR: do not use assignment in if condition
#231: FILE: ad7418.c:231:
+	if (!(data = kzalloc(sizeof(struct ad7418_data), GFP_KERNEL))) {

ERROR: do not use assignment in if condition
#264: FILE: ad7418.c:264:
+	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))

total: 2 errors, 1 warnings, 308 lines checked

ad7418.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/ad7418.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index 8cb718c..0ebd8ed 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -167,7 +167,11 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ad7418_data *data = i2c_get_clientdata(client);
-	long temp = simple_strtol(buf, NULL, 10);
+	long temp;
+	int ret = kstrtol(buf, 10, &temp);
+
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&data->lock);
 	data->temp[attr->index] = LM75_TEMP_TO_REG(temp);
@@ -228,7 +231,8 @@ static int ad7418_probe(struct i2c_client *client,
 		goto exit;
 	}
 
-	if (!(data = kzalloc(sizeof(struct ad7418_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct ad7418_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -261,7 +265,8 @@ static int ad7418_probe(struct i2c_client *client,
 	ad7418_init_client(client);
 
 	/* Register sysfs hooks */
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
