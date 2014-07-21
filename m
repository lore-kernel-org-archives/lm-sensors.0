From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 21 Jul 2014 10:36:15 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (max1111) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405938975.1757.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/max1111.c | 65 +++++++++----------------------------------------
 1 file changed, 12 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index f67d71e..6191409 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -38,7 +38,7 @@ enum chips { max1110, max1111, max1112, max1113 };
 
 struct max1111_data {
 	struct spi_device	*spi;
-	struct device		*hwmon_dev;
+	const struct attribute_group *groups[3];
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
 	uint8_t tx_buf[MAX1111_TX_BUF_SIZE];
@@ -90,17 +90,6 @@ int max1111_read_channel(int channel)
 EXPORT_SYMBOL(max1111_read_channel);
 #endif
 
-/*
- * NOTE: SPI devices do not have a default 'name' attribute, which is
- * likely to be used by hwmon applications to distinguish between
- * different devices, explicitly add a name attribute here.
- */
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
-}
-
 static ssize_t show_adc(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -122,7 +111,6 @@ static ssize_t show_adc(struct device *dev,
 #define MAX1111_ADC_ATTR(_id)		\
 	SENSOR_DEVICE_ATTR(in##_id##_input, S_IRUGO, show_adc, NULL, _id)
 
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static MAX1111_ADC_ATTR(0);
 static MAX1111_ADC_ATTR(1);
 static MAX1111_ADC_ATTR(2);
@@ -133,7 +121,6 @@ static MAX1111_ADC_ATTR(6);
 static MAX1111_ADC_ATTR(7);
 
 static struct attribute *max1111_attributes[] = {
-	&dev_attr_name.attr,
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
@@ -182,7 +169,9 @@ static int setup_transfer(struct max1111_data *data)
 static int max1111_probe(struct spi_device *spi)
 {
 	enum chips chip = spi_get_device_id(spi)->driver_data;
+	struct device *dev = &spi->dev;
 	struct max1111_data *data;
+	struct device *hwmon_dev;
 	int err;
 
 	spi->bits_per_word = 8;
@@ -191,7 +180,7 @@ static int max1111_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
-	data = devm_kzalloc(&spi->dev, sizeof(struct max1111_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct max1111_data), GFP_KERNEL);
 	if (data = NULL)
 		return -ENOMEM;
 
@@ -218,51 +207,22 @@ static int max1111_probe(struct spi_device *spi)
 		return err;
 
 	mutex_init(&data->drvdata_lock);
-
 	data->spi = spi;
-	spi_set_drvdata(spi, data);
 
-	err = sysfs_create_group(&spi->dev.kobj, &max1111_attr_group);
-	if (err) {
-		dev_err(&spi->dev, "failed to create attribute group\n");
-		return err;
-	}
-	if (chip = max1110 || chip = max1112) {
-		err = sysfs_create_group(&spi->dev.kobj, &max1110_attr_group);
-		if (err) {
-			dev_err(&spi->dev,
-				"failed to create extended attribute group\n");
-			goto err_remove;
-		}
-	}
+	/* sysfs hooks */
+	data->groups[0] = &max1111_attr_group;
+	if (chip = max1110 || chip = max1112)
+		data->groups[1] = &max1110_attr_group;
 
-	data->hwmon_dev = hwmon_device_register(&spi->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		dev_err(&spi->dev, "failed to create hwmon device\n");
-		err = PTR_ERR(data->hwmon_dev);
-		goto err_remove;
-	}
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, spi->modalias,
+							   data, data->groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 #ifdef CONFIG_SHARPSL_PM
 	the_max1111 = data;
 #endif
 	return 0;
-
-err_remove:
-	sysfs_remove_group(&spi->dev.kobj, &max1110_attr_group);
-	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
-	return err;
-}
-
-static int max1111_remove(struct spi_device *spi)
-{
-	struct max1111_data *data = spi_get_drvdata(spi);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&spi->dev.kobj, &max1110_attr_group);
-	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
-	mutex_destroy(&data->drvdata_lock);
-	return 0;
 }
 
 static const struct spi_device_id max1111_ids[] = {
@@ -281,7 +241,6 @@ static struct spi_driver max1111_driver = {
 	},
 	.id_table	= max1111_ids,
 	.probe		= max1111_probe,
-	.remove		= max1111_remove,
 };
 
 module_spi_driver(max1111_driver);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
