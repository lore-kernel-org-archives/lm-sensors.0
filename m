From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 19 Aug 2006 15:28:05 +0000
Subject: [lm-sensors] [patch 1/3] pc87360 - fix unchecked
Message-Id: <44E72E05.9070203@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


1- code-move (prep patch)
    moves code for get-set-decl tuples for 3 items: cpu0_vid, vrm, alarms_in
    up, to just after the get-set-decl tuple for Voltages.
    These items are already 'activated' together with the rest of the 
voltage attributes
    , so the move tightens the grouping thats made explicit in next patch.

Signed-off-by:   Jim Cromie  <jim.cromie at gmail.com>

[jimc at harpo hwmon-stuff]$ diffstat diff.ab-1.20060818.185514
 pc87360.c |   56 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs ab-0/drivers/hwmon/pc87360.c ab-1/drivers/hwmon/pc87360.c
--- ab-0/drivers/hwmon/pc87360.c	2006-08-14 21:19:24.000000000 -0600
+++ ab-1/drivers/hwmon/pc87360.c	2006-08-18 17:35:53.000000000 -0600
@@ -471,6 +471,34 @@ static struct sensor_device_attribute in
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->vrm);
+}
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	data->vrm = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_alarms);
+}
+static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -589,34 +617,6 @@ static struct sensor_device_attribute th
 		    show_therm_crit, set_therm_crit, 2+11),
 };
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
-}
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	data->vrm = simple_strtoul(buf, NULL, 10);
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
-static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_alarms);
-}
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
-
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);



