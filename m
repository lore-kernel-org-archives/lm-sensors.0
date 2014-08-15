From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Aug 2014 16:32:41 +0000
Subject: [lm-sensors] [RFT PATCH] hwmon: (k10temp) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1408120361-26570-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code
and reduce code size.

Cc: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Would be great if someone with access to hardware can test this patch
and let me know if it works. Thanks!

 drivers/hwmon/k10temp.c | 124 +++++++++++++++++++-----------------------------
 1 file changed, 48 insertions(+), 76 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 730bdf7..1e7bdcd 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -77,7 +77,7 @@ static ssize_t show_temp(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	u32 regval;
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = dev_get_drvdata(dev);
 
 	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model = 0x60) {
 		amd_nb_smu_index_read(pdev, PCI_DEVFN(0, 0),
@@ -103,7 +103,7 @@ static ssize_t show_temp_crit(struct device *dev,
 	u32 regval;
 	int value;
 
-	pci_read_config_dword(to_pci_dev(dev),
+	pci_read_config_dword(dev_get_drvdata(dev),
 			      REG_HARDWARE_THERMAL_CONTROL, &regval);
 	value = ((regval >> 16) & 0x7f) * 500 + 52000;
 	if (show_hyst)
@@ -111,17 +111,43 @@ static ssize_t show_temp_crit(struct device *dev,
 	return sprintf(buf, "%d\n", value);
 }
 
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "k10temp\n");
-}
-
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
 static DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static umode_t k10temp_is_visible(struct kobject *kobj,
+				  struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = dev_get_drvdata(dev);
+
+	if (index >= 2) {
+		u32 reg_caps, reg_htc;
+
+		pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES,
+				      &reg_caps);
+		pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL,
+				      &reg_htc);
+		if (!(reg_caps & NB_CAP_HTC) || !(reg_htc & HTC_ENABLE))
+			return 0;
+	}
+	return attr->mode;
+}
+
+static struct attribute *k10temp_attrs[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group k10temp_group = {
+	.attrs = k10temp_attrs,
+	.is_visible = k10temp_is_visible,
+};
+__ATTRIBUTE_GROUPS(k10temp);
 
 static bool has_erratum_319(struct pci_dev *pdev)
 {
@@ -160,76 +186,23 @@ static bool has_erratum_319(struct pci_dev *pdev)
 static int k10temp_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
-	struct device *hwmon_dev;
-	u32 reg_caps, reg_htc;
 	int unreliable = has_erratum_319(pdev);
-	int err;
-
-	if (unreliable && !force) {
-		dev_err(&pdev->dev,
-			"unreliable CPU thermal sensor; monitoring disabled\n");
-		err = -ENODEV;
-		goto exit;
-	}
-
-	err = device_create_file(&pdev->dev, &dev_attr_temp1_input);
-	if (err)
-		goto exit;
-	err = device_create_file(&pdev->dev, &dev_attr_temp1_max);
-	if (err)
-		goto exit_remove;
-
-	pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES, &reg_caps);
-	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, &reg_htc);
-	if ((reg_caps & NB_CAP_HTC) && (reg_htc & HTC_ENABLE)) {
-		err = device_create_file(&pdev->dev,
-				&sensor_dev_attr_temp1_crit.dev_attr);
-		if (err)
-			goto exit_remove;
-		err = device_create_file(&pdev->dev,
-				&sensor_dev_attr_temp1_crit_hyst.dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	err = device_create_file(&pdev->dev, &dev_attr_name);
-	if (err)
-		goto exit_remove;
-
-	hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(hwmon_dev)) {
-		err = PTR_ERR(hwmon_dev);
-		goto exit_remove;
-	}
-	pci_set_drvdata(pdev, hwmon_dev);
+	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
 
-	if (unreliable && force)
-		dev_warn(&pdev->dev,
+	if (unreliable) {
+		if (!force) {
+			dev_err(dev,
+				"unreliable CPU thermal sensor; monitoring disabled\n");
+			return -ENODEV;
+		}
+		dev_warn(dev,
 			 "unreliable CPU thermal sensor; check erratum 319\n");
-	return 0;
-
-exit_remove:
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	device_remove_file(&pdev->dev, &dev_attr_temp1_input);
-	device_remove_file(&pdev->dev, &dev_attr_temp1_max);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_crit.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_crit_hyst.dev_attr);
-exit:
-	return err;
-}
+	}
 
-static void k10temp_remove(struct pci_dev *pdev)
-{
-	hwmon_device_unregister(pci_get_drvdata(pdev));
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	device_remove_file(&pdev->dev, &dev_attr_temp1_input);
-	device_remove_file(&pdev->dev, &dev_attr_temp1_max);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_crit.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_crit_hyst.dev_attr);
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "k10temp", pdev,
+							   k10temp_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct pci_device_id k10temp_id_table[] = {
@@ -250,7 +223,6 @@ static struct pci_driver k10temp_driver = {
 	.name = "k10temp",
 	.id_table = k10temp_id_table,
 	.probe = k10temp_probe,
-	.remove = k10temp_remove,
 };
 
 module_pci_driver(k10temp_driver);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
