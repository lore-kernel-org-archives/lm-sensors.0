From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:16 +0000
Subject: [lm-sensors] [PATCH 35/95] hwmon: (fam15h_power) Convert to use devm_ functions
Message-Id: <1339773856-3443-36-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/fam15h_power.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 6b13f1a..2d100da 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -187,7 +187,7 @@ static int __devinit fam15h_power_probe(struct pci_dev *pdev,
 					const struct pci_device_id *id)
 {
 	struct fam15h_power_data *data;
-	struct device *dev;
+	struct device *dev = &pdev->dev;
 	int err;
 
 	/*
@@ -197,23 +197,19 @@ static int __devinit fam15h_power_probe(struct pci_dev *pdev,
 	 */
 	tweak_runavg_range(pdev);
 
-	if (!fam15h_power_is_internal_node0(pdev)) {
-		err = -ENODEV;
-		goto exit;
-	}
+	if (!fam15h_power_is_internal_node0(pdev))
+		return -ENODEV;
+
+	data = devm_kzalloc(dev, sizeof(struct fam15h_power_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	data = kzalloc(sizeof(struct fam15h_power_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
 	fam15h_power_init_data(pdev, data);
-	dev = &pdev->dev;
 
 	dev_set_drvdata(dev, data);
 	err = sysfs_create_group(&dev->kobj, &fam15h_power_attr_group);
 	if (err)
-		goto exit_free_data;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -225,9 +221,6 @@ static int __devinit fam15h_power_probe(struct pci_dev *pdev,
 
 exit_remove_group:
 	sysfs_remove_group(&dev->kobj, &fam15h_power_attr_group);
-exit_free_data:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -240,8 +233,6 @@ static void __devexit fam15h_power_remove(struct pci_dev *pdev)
 	data = dev_get_drvdata(dev);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&dev->kobj, &fam15h_power_attr_group);
-	dev_set_drvdata(dev, NULL);
-	kfree(data);
 }
 
 static DEFINE_PCI_DEVICE_TABLE(fam15h_power_id_table) = {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
