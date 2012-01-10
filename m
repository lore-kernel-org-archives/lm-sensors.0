From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 22:01:40 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon (lm83): fix checkpatch issues
Message-Id: <1326232900-326-2-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

resolved:
ERROR: trailing whitespace
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead
ERROR: do not use assignment in if condition

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm83.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 8290476..5e7ab4c 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -124,7 +124,7 @@ static struct lm83_data *lm83_update_device(struct device *dev);
 /*
  * Driver data (common to all clients)
  */
- 
+
 static const struct i2c_device_id lm83_id[] = {
 	{ "lm83", lm83 },
 	{ "lm82", lm82 },
@@ -179,8 +179,13 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm83_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
 	int nr = attr->index;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = TEMP_TO_REG(val);
@@ -355,12 +360,14 @@ static int lm83_probe(struct i2c_client *new_client,
 	 * declare 1 and 3 common, and then 2 and 4 only for the LM83.
 	 */
 
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm83_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm83_group);
+	if (err)
 		goto exit_free;
 
 	if (id->driver_data = lm83) {
-		if ((err = sysfs_create_group(&new_client->dev.kobj,
-					      &lm83_group_opt)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					      &lm83_group_opt);
+		if (err)
 			goto exit_remove_files;
 	}
 
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
