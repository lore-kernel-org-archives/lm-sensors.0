From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 02 Jul 2014 12:31:21 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (ads7871) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404304281.15238.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

The update_lock mutex is not used, so remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ads7871.c | 65 ++++++++++++-------------------------------------
 1 file changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 3eff73b..d025d13 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -66,14 +66,12 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/mutex.h>
 #include <linux/delay.h>
 
 #define DEVICE_NAME	"ads7871"
 
 struct ads7871_data {
-	struct device	*hwmon_dev;
-	struct mutex	update_lock;
+	struct spi_device *spi;
 };
 
 static int ads7871_read_reg8(struct spi_device *spi, int reg)
@@ -101,7 +99,8 @@ static int ads7871_write_reg8(struct spi_device *spi, int reg, u8 val)
 static ssize_t show_voltage(struct device *dev,
 		struct device_attribute *da, char *buf)
 {
-	struct spi_device *spi = to_spi_device(dev);
+	struct ads7871_data *pdata = dev_get_drvdata(dev);
+	struct spi_device *spi = pdata->spi;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int ret, val, i = 0;
 	uint8_t channel, mux_cnv;
@@ -139,12 +138,6 @@ static ssize_t show_voltage(struct device *dev,
 	}
 }
 
-static ssize_t ads7871_show_name(struct device *dev,
-				 struct device_attribute *devattr, char *buf)
-{
-	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
-}
-
 static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);
 static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);
@@ -154,9 +147,7 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_voltage, NULL, 5);
 static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);
 static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);
 
-static DEVICE_ATTR(name, S_IRUGO, ads7871_show_name, NULL);
-
-static struct attribute *ads7871_attributes[] = {
+static struct attribute *ads7871_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
@@ -165,21 +156,18 @@ static struct attribute *ads7871_attributes[] = {
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in7_input.dev_attr.attr,
-	&dev_attr_name.attr,
 	NULL
 };
 
-static const struct attribute_group ads7871_group = {
-	.attrs = ads7871_attributes,
-};
+ATTRIBUTE_GROUPS(ads7871);
 
 static int ads7871_probe(struct spi_device *spi)
 {
-	int ret, err;
+	struct device *dev = &spi->dev;
+	int ret;
 	uint8_t val;
 	struct ads7871_data *pdata;
-
-	dev_dbg(&spi->dev, "probe\n");
+	struct device *hwmon_dev;
 
 	/* Configure the SPI bus */
 	spi->mode = (SPI_MODE_0);
@@ -193,7 +181,7 @@ static int ads7871_probe(struct spi_device *spi)
 	ads7871_write_reg8(spi, REG_OSC_CONTROL, val);
 	ret = ads7871_read_reg8(spi, REG_OSC_CONTROL);
 
-	dev_dbg(&spi->dev, "REG_OSC_CONTROL write:%x, read:%x\n", val, ret);
+	dev_dbg(dev, "REG_OSC_CONTROL write:%x, read:%x\n", val, ret);
 	/*
 	 * because there is no other error checking on an SPI bus
 	 * we need to make sure we really have a chip
@@ -201,37 +189,16 @@ static int ads7871_probe(struct spi_device *spi)
 	if (val != ret)
 		return -ENODEV;
 
-	pdata = devm_kzalloc(&spi->dev, sizeof(struct ads7871_data),
-			     GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(struct ads7871_data), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	err = sysfs_create_group(&spi->dev.kobj, &ads7871_group);
-	if (err < 0)
-		return err;
-
-	spi_set_drvdata(spi, pdata);
+	pdata->spi = spi;
 
-	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
-	if (IS_ERR(pdata->hwmon_dev)) {
-		err = PTR_ERR(pdata->hwmon_dev);
-		goto error_remove;
-	}
-
-	return 0;
-
-error_remove:
-	sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
-	return err;
-}
-
-static int ads7871_remove(struct spi_device *spi)
-{
-	struct ads7871_data *pdata = spi_get_drvdata(spi);
-
-	hwmon_device_unregister(pdata->hwmon_dev);
-	sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, spi->modalias,
+							   pdata,
+							   ads7871_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct spi_driver ads7871_driver = {
@@ -239,9 +206,7 @@ static struct spi_driver ads7871_driver = {
 		.name = DEVICE_NAME,
 		.owner = THIS_MODULE,
 	},
-
 	.probe = ads7871_probe,
-	.remove = ads7871_remove,
 };
 
 module_spi_driver(ads7871_driver);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
