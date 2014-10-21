From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 21 Oct 2014 07:09:17 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (i5500_temp) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20141021090917.2692f17b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_kzalloc and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Romain Dolbeau <romain@dolbeau.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/i5500_temp.c |   69 +++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)

--- linux-3.17.orig/drivers/hwmon/i5500_temp.c	2014-10-19 22:06:08.460835707 +0200
+++ linux-3.17/drivers/hwmon/i5500_temp.c	2014-10-19 22:43:55.647695623 +0200
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -38,9 +39,8 @@
 #define REG_TSTIMER	0xF8
 
 struct i5500_temp_data {
-	struct device *hwmon_dev;
+	struct pci_dev *pdev;
 	struct mutex update_lock;
-	const char *name;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
 
@@ -56,7 +56,7 @@ static struct i5500_temp_data *
 i5500_temp_update_device(struct device *dev)
 {
 	struct i5500_temp_data *data = dev_get_drvdata(dev);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = data->pdev;
 
 	mutex_lock(&data->update_lock);
 
@@ -113,21 +113,12 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (unsigned int)data->ctsts & (1 << nr));
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
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_thresh, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_thresh, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_thresh, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static struct attribute *i5500_temp_attributes[] = {
 	&dev_attr_temp1_input.attr,
@@ -136,7 +127,6 @@ static struct attribute *i5500_temp_attr
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&dev_attr_name.attr,
 	NULL
 };
 
@@ -144,6 +134,11 @@ static const struct attribute_group i550
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
@@ -156,58 +151,34 @@ static int i5500_temp_probe(struct pci_d
 {
 	int err;
 	struct i5500_temp_data *data;
+	struct device *hwmon_dev;
 
-	data = kzalloc(sizeof(struct i5500_temp_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct i5500_temp_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	data->name = "intel5500";
 	mutex_init(&data->update_lock);
-	dev_set_drvdata(&pdev->dev, data);
+	data->pdev = pdev;
 
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
+							   "intel5500",
+							   data,
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
