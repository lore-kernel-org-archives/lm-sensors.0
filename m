From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Apr 2014 03:45:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm70) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1397187944-1662-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups API to attach attributes
to hwmon device, simplify code, and reduce code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm70.c |   62 ++++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 505a59e..97204dc 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -47,7 +47,7 @@
 #define LM70_CHIP_LM74		3	/* NS LM74 */
 
 struct lm70 {
-	struct device *hwmon_dev;
+	struct spi_device *spi;
 	struct mutex lock;
 	unsigned int chip;
 };
@@ -56,11 +56,11 @@ struct lm70 {
 static ssize_t lm70_sense_temp(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct spi_device *spi = to_spi_device(dev);
+	struct lm70 *p_lm70 = dev_get_drvdata(dev);
+	struct spi_device *spi = p_lm70->spi;
 	int status, val = 0;
 	u8 rxbuf[2];
 	s16 raw = 0;
-	struct lm70 *p_lm70 = spi_get_drvdata(spi);
 
 	if (mutex_lock_interruptible(&p_lm70->lock))
 		return -ERESTARTSYS;
@@ -121,21 +121,20 @@ out:
 
 static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
 
-static ssize_t lm70_show_name(struct device *dev, struct device_attribute
-			      *devattr, char *buf)
-{
-	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
-}
+static struct attribute *lm70_attrs[] = {
+	&dev_attr_temp1_input.attr,
+	NULL
+};
 
-static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
+ATTRIBUTE_GROUPS(lm70);
 
 /*----------------------------------------------------------------------*/
 
 static int lm70_probe(struct spi_device *spi)
 {
 	int chip = spi_get_device_id(spi)->driver_data;
+	struct device *hwmon_dev;
 	struct lm70 *p_lm70;
-	int status;
 
 	/* signaling is SPI_MODE_0 */
 	if (spi->mode & (SPI_CPOL | SPI_CPHA))
@@ -149,46 +148,14 @@ static int lm70_probe(struct spi_device *spi)
 
 	mutex_init(&p_lm70->lock);
 	p_lm70->chip = chip;
+	p_lm70->spi = spi;
 
-	spi_set_drvdata(spi, p_lm70);
-
-	status = device_create_file(&spi->dev, &dev_attr_temp1_input);
-	if (status)
-		goto out_dev_create_temp_file_failed;
-	status = device_create_file(&spi->dev, &dev_attr_name);
-	if (status)
-		goto out_dev_create_file_failed;
-
-	/* sysfs hook */
-	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
-	if (IS_ERR(p_lm70->hwmon_dev)) {
-		dev_dbg(&spi->dev, "hwmon_device_register failed.\n");
-		status = PTR_ERR(p_lm70->hwmon_dev);
-		goto out_dev_reg_failed;
-	}
-
-	return 0;
-
-out_dev_reg_failed:
-	device_remove_file(&spi->dev, &dev_attr_name);
-out_dev_create_file_failed:
-	device_remove_file(&spi->dev, &dev_attr_temp1_input);
-out_dev_create_temp_file_failed:
-	return status;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&spi->dev,
+							   spi->modalias,
+							   p_lm70, lm70_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static int lm70_remove(struct spi_device *spi)
-{
-	struct lm70 *p_lm70 = spi_get_drvdata(spi);
-
-	hwmon_device_unregister(p_lm70->hwmon_dev);
-	device_remove_file(&spi->dev, &dev_attr_temp1_input);
-	device_remove_file(&spi->dev, &dev_attr_name);
-
-	return 0;
-}
-
-
 static const struct spi_device_id lm70_ids[] = {
 	{ "lm70",   LM70_CHIP_LM70 },
 	{ "tmp121", LM70_CHIP_TMP121 },
@@ -205,7 +172,6 @@ static struct spi_driver lm70_driver = {
 	},
 	.id_table = lm70_ids,
 	.probe	= lm70_probe,
-	.remove	= lm70_remove,
 };
 
 module_spi_driver(lm70_driver);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
