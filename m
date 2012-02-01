From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:04 +0000
Subject: [lm-sensors] [PATCH 16/24] hwmon: (vt1211) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-17-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Juerg Haefliger <juergh@gmail.com>
---
 drivers/hwmon/vt1211.c |   43 +++++++++----------------------------------
 1 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index c2c5c72..4deab6d 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -138,7 +138,6 @@ struct vt1211_data {
 	u8  pwm_auto_temp[4];
 	u8  pwm_auto_pwm[2][4];
 	u8  vid;		/* Read once at init time */
-	u8  vrm;
 	u8  uch_config;		/* Read once at init time */
 	u16 alarms;
 };
@@ -854,39 +853,15 @@ static ssize_t set_pwm_auto_point_pwm(struct device *dev,
 }
 
 /* ---------------------------------------------------------------------
- * Miscellaneous sysfs interfaces (VRM, VID, name, and (legacy) alarms)
+ * Miscellaneous sysfs interfaces (VID, name, and (legacy) alarms)
  * --------------------------------------------------------------------- */
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	struct vt1211_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
-{
-	struct vt1211_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-
-	data->vrm = val;
-
-	return count;
-}
-
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct vt1211_data *data = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 
 static ssize_t show_name(struct device *dev,
@@ -1076,7 +1051,6 @@ static struct sensor_device_attribute_2 vt1211_sysfs_fan_pwm[] = {
 };
 
 static struct device_attribute vt1211_sysfs_misc[] = {
-	__ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm),
 	__ATTR(cpu0_vid, S_IRUGO, show_vid, NULL),
 	__ATTR(name, S_IRUGO, show_name, NULL),
 	__ATTR(alarms, S_IRUGO, show_alarms, NULL),
@@ -1088,9 +1062,6 @@ static struct device_attribute vt1211_sysfs_misc[] = {
 
 static void __devinit vt1211_init_device(struct vt1211_data *data)
 {
-	/* set VRM */
-	data->vrm = vid_which_vrm();
-
 	/* Read (and initialize) UCH config */
 	data->uch_config = vt1211_read8(data, VT1211_REG_UCH_CONFIG);
 	if (uch_config > -1) {
@@ -1194,9 +1165,13 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 		if (err)
 			goto EXIT_DEV_REMOVE;
 	}
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
-		err = device_create_file(dev,
-		       &vt1211_sysfs_misc[i]);
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(dev, &vt1211_sysfs_misc[0]);
+		if (err)
+			goto EXIT_DEV_REMOVE;
+	}
+	for (i = 1; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
+		err = device_create_file(dev, &vt1211_sysfs_misc[i]);
 		if (err)
 			goto EXIT_DEV_REMOVE;
 	}
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
