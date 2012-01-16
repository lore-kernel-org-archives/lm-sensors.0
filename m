From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:33 +0000
Subject: [lm-sensors] [PATCH 31/39] hwmon: (via686a) Fix checkpatch issues
Message-Id: <1326703781-14272-32-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: open brace '{' following function declarations go on the next line
ERROR: space prohibited before that close parenthesis ')'
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxV)
ERROR: that open brace { should be on the previous line
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/via686a.c |   78 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 25e9166..c759b1c 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -166,7 +166,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 255);
 }
 
-#define FAN_FROM_REG(val,div) ((val)=0?0:(val)=255?0:1350000/((val)*(div)))
+#define FAN_FROM_REG(val, div) ((val) = 0 ? 0 : (val) = 255 ? 0 : 1350000 / \
+				((val) * (div)))
 
 /******** TEMP CONVERSIONS (Bob Dougherty) *********/
 /* linear fits from HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew)
@@ -200,8 +201,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
  but the function is very linear in the useful range (0-80 deg C), so
  we'll just use linear interpolation for 10-bit readings.)  So, tempLUT
  is the temp at via register values 0-255: */
-static const s16 tempLUT[] -{ -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
+static const s16 tempLUT[] = {
+	-709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	-503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	-362, -350, -339, -327, -316, -305, -295, -285, -275, -265,
 	-255, -246, -237, -229, -220, -212, -204, -196, -188, -180,
@@ -246,8 +247,8 @@ static const s16 tempLUT[]   viaRegVal = -1.160370e-10*val^6 +3.193693e-08*val^5 - 1.464447e-06*val^4
  - 2.525453e-04*val^3 + 1.424593e-02*val^2 + 2.148941e+00*val +7.275808e+01)
  Note that n1: */
-static const u8 viaLUT[] -{ 12, 12, 13, 14, 14, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 22, 23,
+static const u8 viaLUT[] = {
+	12, 12, 13, 14, 14, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 22, 23,
 	23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 39, 40,
 	41, 43, 45, 46, 48, 49, 51, 53, 55, 57, 59, 60, 62, 64, 66,
 	69, 71, 73, 75, 77, 79, 82, 84, 86, 88, 91, 93, 95, 98, 100,
@@ -290,7 +291,7 @@ static inline long TEMP_FROM_REG10(u16 val)
 }
 
 #define DIV_FROM_REG(val) (1 << (val))
-#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
+#define DIV_TO_REG(val) ((val) = 8 ? 3 : (val) = 4 ? 2 : (val) = 1 ? 0 : 1)
 
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
@@ -365,7 +366,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *da,
 	struct via686a_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, nr);
@@ -379,7 +385,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
 	struct via686a_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, nr);
@@ -429,7 +440,12 @@ static ssize_t set_temp_over(struct device *dev, struct device_attribute *da,
 	struct via686a_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_over[nr] = TEMP_TO_REG(val);
@@ -443,7 +459,12 @@ static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *da,
 	struct via686a_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
@@ -471,7 +492,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-				DIV_FROM_REG(data->fan_div[nr])) );
+				DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
 		char *buf) {
@@ -479,21 +500,27 @@ static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
 	return sprintf(buf, "%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+		FAN_FROM_REG(data->fan_min[nr],
+			     DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
 		char *buf) {
 	struct via686a_data *data = via686a_update_device(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
 		const char *buf, size_t count) {
 	struct via686a_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -506,8 +533,13 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 	struct via686a_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	int val = simple_strtol(buf, NULL, 10);
 	int old;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	old = via686a_read_value(data, VIA686A_REG_FANDIV);
@@ -530,10 +562,13 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf) {
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }
+
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
@@ -641,7 +676,8 @@ static int __devinit via686a_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!(data = kzalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct via686a_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
@@ -655,7 +691,8 @@ static int __devinit via686a_probe(struct platform_device *pdev)
 	via686a_init_device(data);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &via686a_group)))
+	err = sysfs_create_group(&pdev->dev.kobj, &via686a_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
@@ -777,11 +814,10 @@ static struct via686a_data *via686a_update_device(struct device *dev)
 	return data;
 }
 
-static const struct pci_device_id via686a_pci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(via686a_pci_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
-	{ 0, }
+	{ }
 };
-
 MODULE_DEVICE_TABLE(pci, via686a_pci_ids);
 
 static int __devinit via686a_device_add(unsigned short address)
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
