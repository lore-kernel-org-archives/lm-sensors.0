From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 03 Aug 2014 03:42:34 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (via686a) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1407037354.30587.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/via686a.c | 53 +++++++------------------------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index a995986..140c42f 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -315,8 +315,6 @@ static inline long TEMP_FROM_REG10(u16 val)
  */
 struct via686a_data {
 	unsigned short addr;
-	const char *name;
-	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -336,7 +334,6 @@ struct via686a_data {
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_probe(struct platform_device *pdev);
-static int via686a_remove(struct platform_device *pdev);
 
 static inline int via686a_read_value(struct via686a_data *data, u8 reg)
 {
@@ -693,15 +690,7 @@ static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 15);
 static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
 
-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
-{
-	struct via686a_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", data->name);
-}
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
-static struct attribute *via686a_attributes[] = {
+static struct attribute *via686a_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
@@ -746,13 +735,10 @@ static struct attribute *via686a_attributes[] = {
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
-	&dev_attr_name.attr,
 	NULL
 };
 
-static const struct attribute_group via686a_group = {
-	.attrs = via686a_attributes,
-};
+ATTRIBUTE_GROUPS(via686a);
 
 static struct platform_driver via686a_driver = {
 	.driver = {
@@ -760,15 +746,14 @@ static struct platform_driver via686a_driver = {
 		.name	= "via686a",
 	},
 	.probe		= via686a_probe,
-	.remove		= via686a_remove,
 };
 
 /* This is called when the module is loaded */
 static int via686a_probe(struct platform_device *pdev)
 {
 	struct via686a_data *data;
+	struct device *hwmon_dev;
 	struct resource *res;
-	int err;
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -784,40 +769,16 @@ static int via686a_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
 	data->addr = res->start;
-	data->name = "via686a";
 	mutex_init(&data->update_lock);
 
 	/* Initialize the VIA686A chip */
 	via686a_init_device(data);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&pdev->dev.kobj, &via686a_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
-	return err;
-}
-
-static int via686a_remove(struct platform_device *pdev)
-{
-	struct via686a_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+							   "via686a", data,
+							   via686a_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct pci_device_id via686a_pci_ids[] = {
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
