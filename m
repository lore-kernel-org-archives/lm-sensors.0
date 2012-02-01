From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:56 +0000
Subject: [lm-sensors] [PATCH 08/24] hwmon: (dme1737) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-9-git-send-email-linux@roeck-us.net>
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
 Documentation/hwmon/dme1737 |    6 +++---
 drivers/hwmon/dme1737.c     |   37 ++++---------------------------------
 2 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/Documentation/hwmon/dme1737 b/Documentation/hwmon/dme1737
index 4d29351..67f2d58 100644
--- a/Documentation/hwmon/dme1737
+++ b/Documentation/hwmon/dme1737
@@ -214,9 +214,9 @@ permissions and a short description:
 Name				Perm	Description
 ----				----	-----------
 cpu0_vid			RO	CPU core reference voltage in
-					millivolts.
-vrm				RW	Voltage regulator module version
-					number.
+					millivolts. Only supported if a
+					valid vrm value is provided by the
+					hwmon-vid module.
 
 in[0-7]_input			RO	Measured voltage in millivolts.
 in[0-7]_min			RW	Low limit for voltage input.
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index e7c6a19..c171160 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -234,7 +234,6 @@ struct dme1737_data {
 	s8  temp_offset[3];
 	u8  config;
 	u8  config2;
-	u8  vrm;
 	u16 fan[6];
 	u16 fan_min[6];
 	u8  fan_max[2];
@@ -1467,36 +1466,12 @@ exit:
  * Miscellaneous sysfs attributes
  * --------------------------------------------------------------------- */
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct dme1737_data *data = i2c_get_clientdata(client);
-
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
-{
-	struct dme1737_data *data = dev_get_drvdata(dev);
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err)
-		return err;
-
-	data->vrm = val;
-	return count;
-}
-
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct dme1737_data *data = dme1737_update_device(dev);
 
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr,
@@ -1641,7 +1616,6 @@ SENSOR_DEVICE_ATTR_PWM_5TO6(6);
 
 /* Misc */
 
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);   /* for ISA devices */
 
@@ -1735,7 +1709,6 @@ static const struct attribute_group dme1737_temp_offset_group = {
  * DME1737
  */
 static struct attribute *dme1737_vid_attr[] = {
-	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
 	NULL
 };
@@ -2301,8 +2274,10 @@ static int dme1737_init_device(struct device *dev)
 	/* Chip-dependent features */
 	switch (data->type) {
 	case dme1737:
-		data->has_features |= HAS_TEMP_OFFSET | HAS_VID | HAS_ZONE3 |
+		data->has_features |= HAS_TEMP_OFFSET | HAS_ZONE3 |
 			HAS_ZONE_HYST | HAS_PWM_MIN;
+		if (vid_which_vrm() > 0)
+			data->has_features |= HAS_VID;
 		break;
 	case sch311x:
 		data->has_features |= HAS_TEMP_OFFSET | HAS_ZONE3 |
@@ -2373,10 +2348,6 @@ static int dme1737_init_device(struct device *dev)
 	data->pwm_acz[1] = 2;	/* pwm2 -> zone2 */
 	data->pwm_acz[2] = 4;	/* pwm3 -> zone3 */
 
-	/* Set VRM */
-	if (data->has_features & HAS_VID)
-		data->vrm = vid_which_vrm();
-
 	return 0;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
