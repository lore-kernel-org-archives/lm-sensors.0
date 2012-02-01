From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:50 +0000
Subject: [lm-sensors] [PATCH 02/24] hwmon: (adm1025) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c |   38 +++++++++-----------------------------
 1 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index b8557f9..a9b2c26 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -155,7 +155,6 @@ struct adm1025_data {
 	s8 temp_max[2];		/* register value */
 	u16 alarms;		/* register values, combined */
 	u8 vid;			/* register values, combined */
-	u8 vrm;
 };
 
 /*
@@ -350,32 +349,10 @@ static ssize_t
 show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
-	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t
-show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct adm1025_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
-{
-	struct adm1025_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-
-	data->vrm = val;
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
 /*
  * Real code
  */
@@ -411,8 +388,6 @@ static struct attribute *adm1025_attributes[] = {
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_fault.dev_attr.attr,
 	&dev_attr_alarms.attr,
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	NULL
 };
 
@@ -494,6 +469,12 @@ static int adm1025_probe(struct i2c_client *client,
 	if (err)
 		goto exit_free;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove;
+	}
+
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
 	if (!(config & 0x20)) {
@@ -511,6 +492,7 @@ static int adm1025_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
 exit_free:
@@ -522,11 +504,8 @@ exit:
 static void adm1025_init_client(struct i2c_client *client)
 {
 	u8 reg;
-	struct adm1025_data *data = i2c_get_clientdata(client);
 	int i;
 
-	data->vrm = vid_which_vrm();
-
 	/*
 	 * Set high limits
 	 * Usually we avoid setting limits on driver init, but it happens
@@ -566,6 +545,7 @@ static int adm1025_remove(struct i2c_client *client)
 	struct adm1025_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
