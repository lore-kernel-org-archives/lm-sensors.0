From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 01 Jul 2014 14:29:28 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (ad7314) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404224968.17487.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ad7314.c | 48 +++++++-----------------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index f4f9b21..1dcce9a 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -36,7 +36,6 @@ enum ad7314_variant {
 
 struct ad7314_data {
 	struct spi_device	*spi_dev;
-	struct device		*hwmon_dev;
 	u16 rx ____cacheline_aligned;
 };
 
@@ -87,62 +86,30 @@ static ssize_t ad7314_show_temperature(struct device *dev,
 	}
 }
 
-static ssize_t ad7314_show_name(struct device *dev,
-				struct device_attribute *devattr, char *buf)
-{
-	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
-}
-
-static DEVICE_ATTR(name, S_IRUGO, ad7314_show_name, NULL);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 			  ad7314_show_temperature, NULL, 0);
 
-static struct attribute *ad7314_attributes[] = {
-	&dev_attr_name.attr,
+static struct attribute *ad7314_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group ad7314_group = {
-	.attrs = ad7314_attributes,
-};
+ATTRIBUTE_GROUPS(ad7314);
 
 static int ad7314_probe(struct spi_device *spi_dev)
 {
-	int ret;
 	struct ad7314_data *chip;
+	struct device *hwmon_dev;
 
 	chip = devm_kzalloc(&spi_dev->dev, sizeof(*chip), GFP_KERNEL);
 	if (chip = NULL)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi_dev, chip);
-
-	ret = sysfs_create_group(&spi_dev->dev.kobj, &ad7314_group);
-	if (ret < 0)
-		return ret;
-
-	chip->hwmon_dev = hwmon_device_register(&spi_dev->dev);
-	if (IS_ERR(chip->hwmon_dev)) {
-		ret = PTR_ERR(chip->hwmon_dev);
-		goto error_remove_group;
-	}
 	chip->spi_dev = spi_dev;
-
-	return 0;
-error_remove_group:
-	sysfs_remove_group(&spi_dev->dev.kobj, &ad7314_group);
-	return ret;
-}
-
-static int ad7314_remove(struct spi_device *spi_dev)
-{
-	struct ad7314_data *chip = spi_get_drvdata(spi_dev);
-
-	hwmon_device_unregister(chip->hwmon_dev);
-	sysfs_remove_group(&spi_dev->dev.kobj, &ad7314_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&spi_dev->dev,
+							   spi_dev->modalias,
+							   chip, ad7314_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct spi_device_id ad7314_id[] = {
@@ -159,7 +126,6 @@ static struct spi_driver ad7314_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7314_probe,
-	.remove = ad7314_remove,
 	.id_table = ad7314_id,
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
