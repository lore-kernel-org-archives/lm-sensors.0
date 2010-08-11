From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 15:09:25 +0000
Subject: [lm-sensors] [PATCH 2/6] hwmon: (pc87427) Minor style cleanups
Message-Id: <20100811170925.7bfbc4f9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Follow the best practice of the day.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/pc87427.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/hwmon/pc87427.c	2010-07-04 08:34:57.000000000 +0200
+++ linux-2.6.35-rc3/drivers/hwmon/pc87427.c	2010-07-04 19:57:04.000000000 +0200
@@ -217,9 +217,8 @@ done:
 static ssize_t show_fan_input(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87427_data *data = pc87427_update_device(dev);
-	int nr = attr->index;
+	int nr = to_sensor_dev_attr(devattr)->index;
 
 	return sprintf(buf, "%lu\n", fan_from_reg(data->fan[nr]));
 }
@@ -227,9 +226,8 @@ static ssize_t show_fan_input(struct dev
 static ssize_t show_fan_min(struct device *dev, struct device_attribute
 			    *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87427_data *data = pc87427_update_device(dev);
-	int nr = attr->index;
+	int nr = to_sensor_dev_attr(devattr)->index;
 
 	return sprintf(buf, "%lu\n", fan_from_reg(data->fan_min[nr]));
 }
@@ -237,9 +235,8 @@ static ssize_t show_fan_min(struct devic
 static ssize_t show_fan_alarm(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87427_data *data = pc87427_update_device(dev);
-	int nr = attr->index;
+	int nr = to_sensor_dev_attr(devattr)->index;
 
 	return sprintf(buf, "%d\n", !!(data->fan_status[nr]
 				       & FAN_STATUS_LOSPD));
@@ -248,9 +245,8 @@ static ssize_t show_fan_alarm(struct dev
 static ssize_t show_fan_fault(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87427_data *data = pc87427_update_device(dev);
-	int nr = attr->index;
+	int nr = to_sensor_dev_attr(devattr)->index;
 
 	return sprintf(buf, "%d\n", !!(data->fan_status[nr]
 				       & FAN_STATUS_STALL));
@@ -260,11 +256,13 @@ static ssize_t set_fan_min(struct device
 			   *devattr, const char *buf, size_t count)
 {
 	struct pc87427_data *data = dev_get_drvdata(dev);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	int nr = to_sensor_dev_attr(devattr)->index;
+	unsigned long val;
 	int iobase = data->address[LD_FAN];
 
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
 	mutex_lock(&data->lock);
 	outb(BANK_FM(nr), iobase + PC87427_REG_BANK);
 	/* The low speed limit registers are read-only while monitoring
@@ -441,7 +439,8 @@ static int __devinit pc87427_probe(struc
 	struct resource *res;
 	int i, err;
 
-	if (!(data = kzalloc(sizeof(struct pc87427_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct pc87427_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		printk(KERN_ERR DRVNAME ": Out of memory\n");
 		goto exit;
@@ -464,13 +463,15 @@ static int __devinit pc87427_probe(struc
 	pc87427_init_device(&pdev->dev);
 
 	/* Register sysfs hooks */
-	if ((err = device_create_file(&pdev->dev, &dev_attr_name)))
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
 		goto exit_release_region;
 	for (i = 0; i < 8; i++) {
 		if (!(data->fan_enabled & (1 << i)))
 			continue;
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &pc87427_group_fan[i])))
+		err = sysfs_create_group(&pdev->dev.kobj,
+					 &pc87427_group_fan[i]);
+		if (err)
 			goto exit_remove_files;
 	}
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
