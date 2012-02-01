From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:02 +0000
Subject: [lm-sensors] [PATCH 14/24] hwmon: (smsc47m192) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-15-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Rick <linux@rick.claranet.de>
---
 Documentation/hwmon/smsc47m192 |    7 +++----
 drivers/hwmon/smsc47m192.c     |   38 +++++++++-----------------------------
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/Documentation/hwmon/smsc47m192 b/Documentation/hwmon/smsc47m192
index 6d54ecb..43f95a5 100644
--- a/Documentation/hwmon/smsc47m192
+++ b/Documentation/hwmon/smsc47m192
@@ -95,9 +95,8 @@ temp[2-3]_input_fault - diode fault flags for temperature inputs 2 and 3.
 		  sensor are open or shorted, or any of the two is shorted
 		  to ground or Vcc. '1' indicates a diode fault.
 
-cpu0_vid	- CPU voltage as received from the CPU
+cpu0_vid	- CPU voltage as received from the CPU. Only supported if vrm
+		  is known to the system.
 
-vrm		- CPU VID standard used for decoding CPU voltage
-
-		  The *_min, *_max, *_offset and vrm files can be read and
+		  The *_min, *_max, and *_offset files can be read and
 		  written, all others are read-only.
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 4705a8b..4a11c14 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -109,7 +109,6 @@ struct smsc47m192_data {
 	s8 temp_offset[3];	/* Register value */
 	u16 alarms;		/* Register encoding, combined */
 	u8 vid;			/* Register encoding, combined */
-	u8 vrm;
 };
 
 static int smsc47m192_probe(struct i2c_client *client,
@@ -363,33 +362,10 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct smsc47m192_data *data = smsc47m192_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct smsc47m192_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct smsc47m192_data *data = dev_get_drvdata(dev);
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
 /* Alarms */
 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -461,9 +437,6 @@ static struct attribute *smsc47m192_attributes[] = {
 	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
-
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	NULL
 };
 
@@ -561,7 +534,6 @@ static int smsc47m192_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, data);
-	data->vrm = vid_which_vrm();
 	mutex_init(&data->update_lock);
 
 	/* Initialize the SMSC47M192 chip */
@@ -572,6 +544,12 @@ static int smsc47m192_probe(struct i2c_client *client,
 	if (err)
 		goto exit_free;
 
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove_files;
+	}
+
 	/* Pin 110 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
 	if (!(config & 0x20)) {
@@ -590,6 +568,7 @@ static int smsc47m192_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove_files:
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
 exit_free:
@@ -603,6 +582,7 @@ static int smsc47m192_remove(struct i2c_client *client)
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
