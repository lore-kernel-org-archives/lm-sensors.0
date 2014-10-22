From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 22 Oct 2014 09:12:01 +0000
Subject: [lm-sensors] [PATCH 2/3 v2] hwmon: (i5500_temp) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20141022111201.3f6a72cc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Romain Dolbeau <romain@dolbeau.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:
* Thanks to the changes in the previous patch, kzalloc is no longer
  needed.

 drivers/hwmon/i5500_temp.c |   72 +++++++++------------------------------------
 1 file changed, 15 insertions(+), 57 deletions(-)

--- linux-3.17.orig/drivers/hwmon/i5500_temp.c	2014-10-22 10:17:03.102246155 +0200
+++ linux-3.17/drivers/hwmon/i5500_temp.c	2014-10-22 10:22:18.526856485 +0200
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -37,11 +38,6 @@
 #define REG_CTCTRL	0xF7
 #define REG_TSTIMER	0xF8
 
-struct i5500_temp_data {
-	struct device *hwmon_dev;
-	const char *name;
-};
-
 /*
  * Sysfs stuff
  */
@@ -50,7 +46,7 @@ struct i5500_temp_data {
 static ssize_t show_temp(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	long temp;
 	u16 tsthrhi;
 	s8 tsfsc;
@@ -65,7 +61,7 @@ static ssize_t show_temp(struct device *
 static ssize_t show_thresh(struct device *dev,
 			   struct device_attribute *devattr, char *buf)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	int reg = to_sensor_dev_attr(devattr)->index;
 	long temp;
 	u16 tsthr;
@@ -79,7 +75,7 @@ static ssize_t show_thresh(struct device
 static ssize_t show_alarm(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	int nr = to_sensor_dev_attr(devattr)->index;
 	u8 ctsts;
 
@@ -87,21 +83,12 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (unsigned int)ctsts & (1 << nr));
 }
 
-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
-{
-	struct i5500_temp_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_thresh, NULL, 0xE2);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_thresh, NULL, 0xEC);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_thresh, NULL, 0xEE);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static struct attribute *i5500_temp_attributes[] = {
 	&dev_attr_temp1_input.attr,
@@ -110,7 +97,6 @@ static struct attribute *i5500_temp_attr
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&dev_attr_name.attr,
 	NULL
 };
 
@@ -118,6 +104,11 @@ static const struct attribute_group i550
 	.attrs = i5500_temp_attributes,
 };
 
+static const struct attribute_group *i5500_temp_groups[] = {
+	&i5500_temp_group,
+	NULL
+};
+
 static const struct pci_device_id i5500_temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3438) },
 	{ 0 },
@@ -129,58 +120,25 @@ static int i5500_temp_probe(struct pci_d
 			    const struct pci_device_id *id)
 {
 	int err;
-	struct i5500_temp_data *data;
-
-	data = kzalloc(sizeof(struct i5500_temp_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	data->name = "intel5500";
-	dev_set_drvdata(&pdev->dev, data);
+	struct device *hwmon_dev;
 
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable device\n");
-		goto exit_free;
-	}
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&pdev->dev.kobj, &i5500_temp_group);
-	if (err)
-		goto exit_free;
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
+		return err;
 	}
 
-	return 0;
-
- exit_remove:
-	sysfs_remove_group(&pdev->dev.kobj, &i5500_temp_group);
- exit_free:
-	kfree(data);
- exit:
-	return err;
-}
-
-static void i5500_temp_remove(struct pci_dev *pdev)
-{
-	struct i5500_temp_data *data = dev_get_drvdata(&pdev->dev);
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+							   "intel5500", NULL,
+							   i5500_temp_groups);
 
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &i5500_temp_group);
-	kfree(data);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct pci_driver i5500_temp_driver = {
 	.name = "i5500_temp",
 	.id_table = i5500_temp_ids,
 	.probe = i5500_temp_probe,
-	.remove = i5500_temp_remove,
 };
 
 static int __init i5500_temp_init(void)

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
