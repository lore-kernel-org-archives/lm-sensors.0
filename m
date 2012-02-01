From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:09 +0000
Subject: [lm-sensors] [PATCH 21/24] hwmon: (w83793) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-22-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/hwmon/w83793.c |   37 ++++---------------------------------
 1 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 834e49d..b74ca71 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -224,7 +224,6 @@ struct w83793_data {
 					 */
 
 	u8 bank;
-	u8 vrm;
 	u8 vid[2];
 	u8 in[10][3];		/* Register value, read/high/low */
 	u8 in_low_bits[3];	/* Additional resolution for VCore A/B Vtt */
@@ -323,13 +322,6 @@ static struct i2c_driver w83793_driver = {
 };
 
 static ssize_t
-show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w83793_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t
 show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83793_data *data = w83793_update_device(dev);
@@ -337,23 +329,7 @@ show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
 
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid[index], data->vrm));
-}
-
-static ssize_t
-store_vrm(struct device *dev, struct device_attribute *attr,
-	  const char *buf, size_t count)
-{
-	struct w83793_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-
-	data->vrm = val;
-	return count;
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid[index]));
 }
 
 #define ALARM_STATUS			0
@@ -1186,7 +1162,6 @@ static struct sensor_device_attribute_2 w83793_vid[] = {
 	SENSOR_ATTR_2(cpu0_vid, S_IRUGO, show_vid, NULL, NOT_USED, 0),
 	SENSOR_ATTR_2(cpu1_vid, S_IRUGO, show_vid, NULL, NOT_USED, 1),
 };
-static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, store_vrm);
 
 static struct sensor_device_attribute_2 sda_single_files[] = {
 	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
@@ -1571,7 +1546,6 @@ static int w83793_remove(struct i2c_client *client)
 
 	for (i = 0; i < ARRAY_SIZE(w83793_vid); i++)
 		device_remove_file(dev, &w83793_vid[i].dev_attr);
-	device_remove_file(dev, &dev_attr_vrm);
 
 	for (i = 0; i < ARRAY_SIZE(w83793_left_fan); i++)
 		device_remove_file(dev, &w83793_left_fan[i].dev_attr);
@@ -1816,6 +1790,9 @@ static int w83793_probe(struct i2c_client *client,
 			goto exit_remove;
 	}
 
+	if (data->has_vid && vid_which_vrm() = 0)
+		data->has_vid = 0;
+
 	for (i = 0; i < ARRAY_SIZE(w83793_vid); i++) {
 		if (!(data->has_vid & (1 << i)))
 			continue;
@@ -1823,12 +1800,6 @@ static int w83793_probe(struct i2c_client *client,
 		if (err)
 			goto exit_remove;
 	}
-	if (data->has_vid) {
-		data->vrm = vid_which_vrm();
-		err = device_create_file(dev, &dev_attr_vrm);
-		if (err)
-			goto exit_remove;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
 		err = device_create_file(dev, &sda_single_files[i].dev_attr);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
