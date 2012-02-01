From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:11 +0000
Subject: [lm-sensors] [PATCH 23/24] hwmon: (lm93) Make cpu0_vid and cpu1_vid conditional
Message-Id: <1328123472-27816-24-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only create the cpu[01]_vid attributes if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/lm93.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 67e8fe2..50bfb6c 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -309,11 +309,11 @@ struct lm93_data {
 
 /*
  * VID:	mV
- * REG: 6-bits, right justified, *always* using Intel VRM/VRD 10
+ * REG: 6-bits, right justified.
  */
 static int LM93_VID_FROM_REG(u8 reg)
 {
-	return vid_from_reg((reg & 0x3f), 100);
+	return vid_from_reg(reg & 0x3f);
 }
 
 /* min, max, and nominal register values, per channel (u8) */
@@ -2605,8 +2605,6 @@ static struct attribute *lm93_attrs[] = {
 	&sensor_dev_attr_pwm2_auto_spinup_time.dev_attr.attr,
 	&dev_attr_pwm_auto_prochot_ramp.attr,
 	&dev_attr_pwm_auto_vrdhot_ramp.attr,
-	&sensor_dev_attr_cpu0_vid.dev_attr.attr,
-	&sensor_dev_attr_cpu1_vid.dev_attr.attr,
 	&sensor_dev_attr_prochot1.dev_attr.attr,
 	&sensor_dev_attr_prochot2.dev_attr.attr,
 	&sensor_dev_attr_prochot1_avg.dev_attr.attr,
@@ -2630,6 +2628,16 @@ static struct attribute_group lm93_attr_grp = {
 	.attrs = lm93_attrs,
 };
 
+static struct attribute *lm93_vid_attrs[] = {
+	&sensor_dev_attr_cpu0_vid.dev_attr.attr,
+	&sensor_dev_attr_cpu1_vid.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group lm93_vid_attr_grp = {
+	.attrs = lm93_vid_attrs,
+};
+
 static void lm93_init_client(struct i2c_client *client)
 {
 	int i;
@@ -2762,13 +2770,23 @@ static int lm93_probe(struct i2c_client *client,
 	if (err)
 		goto err_free;
 
+	if (vid_which_vrm()) {
+		err = sysfs_create_group(&client->dev.kobj, &lm93_vid_attr_grp);
+		if (err)
+			goto err_remove;
+	}
+
 	/* Register hwmon driver class */
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		dev_err(&client->dev, "error registering hwmon device.\n");
+		goto err_remove;
+	}
+	return 0;
 
-	err = PTR_ERR(data->hwmon_dev);
-	dev_err(&client->dev, "error registering hwmon device.\n");
+err_remove:
+	sysfs_remove_group(&client->dev.kobj, &lm93_vid_attr_grp);
 	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
 err_free:
 	kfree(data);
@@ -2781,6 +2799,7 @@ static int lm93_remove(struct i2c_client *client)
 	struct lm93_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm93_vid_attr_grp);
 	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
 
 	kfree(data);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
