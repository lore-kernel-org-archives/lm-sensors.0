From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 26 Jun 2008 04:09:15 +0000
Subject: [lm-sensors] [patch 3/5 v1] hwmon/pc87360 individual alarm files -
Message-Id: <4863166B.5070809@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080205060505010705090609"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080205060505010705090609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


for no obvious reason, these arent working like the voltage ones.
Im looking into it.
and repeating in case its not in the git-log

--------------080205060505010705090609
Content-Type: text/x-patch;
	name="0003-Add-separate-tempX_min-max-crit_alarm-sysfs-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0003-Add-separate-tempX_min-max-crit_alarm-sysfs-files.patch"

From b630698bdda73e8c7b925026f23dd8a663d6083c Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 17 Jun 2008 23:22:05 -0600
Subject: [PATCH] Add separate tempX_min/max/crit_alarm sysfs-files

Add sysfs-files and callbacks for temp-min/max/crit-alarms
and temp-faults.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   82 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index af3b8b8..37aaaf2 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -845,12 +845,76 @@ static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *att
 }
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
+/* show_temp_min/max_alarm() reads data from the per-channel status
+   register (sec 11.5.12), not the vin event status registers (sec
+   11.5.2) that show_in_alarm() resds (via data->in_alarms) */
+
+static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute
+				   *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t show_temp_max_alarm(struct device *dev, struct device_attribute
+				   *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MAX));
+}
+static ssize_t show_temp_crit_alarm(struct device *dev, struct device_attribute
+				   *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & TEMP_ALM_CRIT));
+}
+
+static struct sensor_device_attribute temp_min_alarm[] = {
+	SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 2),
+};
+static struct sensor_device_attribute temp_max_alarm[] = {
+	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 2),
+};
+static struct sensor_device_attribute temp_crit_alarm[] = {
+	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+};
+
+#define TEMP_FAULT	0x40	/* open diode */
+static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+			       *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & TEMP_FAULT));
+}
+static struct sensor_device_attribute temp_fault[] = {
+	SENSOR_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0),
+	SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1),
+	SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2),
+};
+
 #define TEMP_UNIT_ATTRS(X) \
 	&temp_input[X].dev_attr.attr,	\
 	&temp_status[X].dev_attr.attr,	\
 	&temp_min[X].dev_attr.attr,	\
 	&temp_max[X].dev_attr.attr,	\
-	&temp_crit[X].dev_attr.attr
+	&temp_crit[X].dev_attr.attr,	\
+	&temp_min_alarm[X].dev_attr.attr, \
+	&temp_max_alarm[X].dev_attr.attr, \
+	&temp_crit_alarm[X].dev_attr.attr, \
+	&temp_fault[X].dev_attr.attr
 
 static struct attribute * pc8736x_temp_attr_array[] = {
 	TEMP_UNIT_ATTRS(0),
@@ -1086,7 +1150,15 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 			    || (err = device_create_file(dev,
 					&temp_crit[i].dev_attr))
 			    || (err = device_create_file(dev,
-					&temp_status[i].dev_attr)))
+					&temp_status[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_min_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_max_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_crit_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_fault[i].dev_attr)))
 				goto ERROR3;
 		}
 		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
@@ -1191,6 +1263,10 @@ static void pc87360_write_value(struct pc87360_data *data, u8 ldi, u8 bank,
 #define CHAN_ENA	0x01	/* enabled channel (temp or vin) */
 #define CHAN_ALM_ENA	0x10	/* propagate to alarms-reg ?? (chk val!) */
 #define CHAN_READY	(CHAN_ENA|CHAN_CNVRTD) /* sample ready mask */
+#define TEMP_OTS_OE	0x20	/* OTS Output Enable (unused) */
+
+#define VIN_RW1C_MASK	(CHAN_READY|CHAN_ALM_MAX|CHAN_ALM_MIN ) /* 0x87 */
+#define TEMP_RW1C_MASK	(VIN_RW1C_MASK|TEMP_ALM_CRIT|TEMP_FAULT) /* 0xCF */
 
 static void pc87360_init_device(struct platform_device *pdev,
 				int use_thermistors)
@@ -1241,7 +1317,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 			/* Forcibly enable temperature channel */
 			reg = pc87360_read_value(data, LD_TEMP, i,
 						 PC87365_REG_TEMP_STATUS);
-			if (!(reg & CHAN_ENA)) {
+ 			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling temp%d\n", i+1);
 				pc87360_write_value(data, LD_TEMP, i,
-- 
1.5.5.1


--------------080205060505010705090609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080205060505010705090609--
