From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 19 Jun 2014 15:29:11 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (fam15h_power) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1403191751.23194.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/fam15h_power.c | 51 ++++++++------------------------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 6040121..7e36aa9 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -45,7 +45,7 @@ MODULE_LICENSE("GPL");
 #define REG_TDP_LIMIT3			0xe8
 
 struct fam15h_power_data {
-	struct device *hwmon_dev;
+	struct pci_dev *pdev;
 	unsigned int tdp_to_watts;
 	unsigned int base_tdp;
 	unsigned int processor_pwr_watts;
@@ -57,8 +57,8 @@ static ssize_t show_power(struct device *dev,
 	u32 val, tdp_limit, running_avg_range;
 	s32 running_avg_capture;
 	u64 curr_pwr_watts;
-	struct pci_dev *f4 = to_pci_dev(dev);
 	struct fam15h_power_data *data = dev_get_drvdata(dev);
+	struct pci_dev *f4 = data->pdev;
 
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
 				  REG_TDP_RUNNING_AVERAGE, &val);
@@ -96,23 +96,13 @@ static ssize_t show_power_crit(struct device *dev,
 }
 static DEVICE_ATTR(power1_crit, S_IRUGO, show_power_crit, NULL);
 
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "fam15h_power\n");
-}
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 static struct attribute *fam15h_power_attrs[] = {
 	&dev_attr_power1_input.attr,
 	&dev_attr_power1_crit.attr,
-	&dev_attr_name.attr,
 	NULL
 };
 
-static const struct attribute_group fam15h_power_attr_group = {
-	.attrs	= fam15h_power_attrs,
-};
+ATTRIBUTE_GROUPS(fam15h_power);
 
 static bool fam15h_power_is_internal_node0(struct pci_dev *f4)
 {
@@ -202,7 +192,7 @@ static int fam15h_power_probe(struct pci_dev *pdev,
 {
 	struct fam15h_power_data *data;
 	struct device *dev = &pdev->dev;
-	int err;
+	struct device *hwmon_dev;
 
 	/*
 	 * though we ignore every other northbridge, we still have to
@@ -219,34 +209,12 @@ static int fam15h_power_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	fam15h_power_init_data(pdev, data);
+	data->pdev = pdev;
 
-	dev_set_drvdata(dev, data);
-	err = sysfs_create_group(&dev->kobj, &fam15h_power_attr_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_group;
-	}
-
-	return 0;
-
-exit_remove_group:
-	sysfs_remove_group(&dev->kobj, &fam15h_power_attr_group);
-	return err;
-}
-
-static void fam15h_power_remove(struct pci_dev *pdev)
-{
-	struct device *dev;
-	struct fam15h_power_data *data;
-
-	dev = &pdev->dev;
-	data = dev_get_drvdata(dev);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&dev->kobj, &fam15h_power_attr_group);
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "fam15h_power",
+							   data,
+							   fam15h_power_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct pci_device_id fam15h_power_id_table[] = {
@@ -260,7 +228,6 @@ static struct pci_driver fam15h_power_driver = {
 	.name = "fam15h_power",
 	.id_table = fam15h_power_id_table,
 	.probe = fam15h_power_probe,
-	.remove = fam15h_power_remove,
 	.resume = fam15h_power_resume,
 };
 
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
