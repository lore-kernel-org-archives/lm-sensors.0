From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 15 Feb 2013 16:57:17 +0000
Subject: [lm-sensors] [PATCH 8/9] hwmon: (adt7x10) Add alarm interrupt support
Message-Id: <1360947438-2550-8-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

This allows a userspace application to poll() on the alarm files to get notified
in case of an temperature threshold event.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7310.c |  4 ++--
 drivers/hwmon/adt7410.c |  4 ++--
 drivers/hwmon/adt7x10.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/hwmon/adt7x10.h |  4 ++--
 4 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index 0483e6c..dcd8d5a 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -127,13 +127,13 @@ static const struct adt7410_ops adt7310_spi_ops = {
 
 static int adt7310_spi_probe(struct spi_device *spi)
 {
-	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name,
+	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name, spi->irq,
 			&adt7310_spi_ops);
 }
 
 static int adt7310_spi_remove(struct spi_device *spi)
 {
-	return adt7410_remove(&spi->dev);
+	return adt7410_remove(&spi->dev, spi->irq);
 }
 
 static const struct spi_device_id adt7310_id[] = {
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 13734c5..35880c6 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -84,12 +84,12 @@ static int adt7410_i2c_probe(struct i2c_client *client,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	return adt7410_probe(&client->dev, NULL, &adt7410_i2c_ops);
+	return adt7410_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
 }
 
 static int adt7410_i2c_remove(struct i2c_client *client)
 {
-	return adt7410_remove(&client->dev);
+	return adt7410_remove(&client->dev, client->irq);
 }
 
 static const struct i2c_device_id adt7410_id[] = {
diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2598aaf..d042596 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -30,6 +30,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include "adt7x10.h"
 
@@ -112,6 +113,26 @@ static const u8 ADT7410_REG_TEMP[4] = {
 	ADT7410_T_CRIT,			/* critical */
 };
 
+static irqreturn_t adt7410_irq_handler(int irq, void *private)
+{
+	struct device *dev = private;
+	u8 status;
+	int ret;
+
+	ret = adt7410_read_byte(dev, ADT7410_STATUS, &status);
+	if (ret)
+		return IRQ_HANDLED;
+
+	if (status & ADT7410_STAT_T_HIGH)
+		sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
+	if (status & ADT7410_STAT_T_LOW)
+		sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
+	if (status & ADT7410_STAT_T_CRIT)
+		sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");
+
+	return IRQ_HANDLED;
+}
+
 /*
  * adt7410 register access by I2C
  */
@@ -359,7 +380,7 @@ static const struct attribute_group adt7410_group = {
 	.attrs = adt7410_attributes,
 };
 
-int adt7410_probe(struct device *dev, const char *name,
+int adt7410_probe(struct device *dev, const char *name, int irq,
 	const struct adt7410_ops *ops)
 {
 	struct adt7410_data *data;
@@ -383,11 +404,17 @@ int adt7410_probe(struct device *dev, const char *name,
 		return ret;
 	}
 	/*
-	 * Set to 16 bit resolution, continous conversion and comparator mode.
+	 * Set to 16 bit resolution and continous conversion
 	 */
 	data->config = data->oldconfig;
-	data->config &= ~ADT7410_MODE_MASK;
-	data->config |= ADT7410_FULL | ADT7410_RESOLUTION | ADT7410_EVENT_MODE;
+	data->config &= ~(ADT7410_MODE_MASK | ADT7410_CT_POLARITY |
+			ADT7410_INT_POLARITY);
+	data->config |= ADT7410_FULL | ADT7410_RESOLUTION;
+
+	/* If we are not using interrupts use comperator mode */
+	if (irq <= 0)
+		data->config |= ADT7410_EVENT_MODE;
+
 	if (data->config != data->oldconfig) {
 		ret = adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
 		if (ret)
@@ -421,8 +448,17 @@ int adt7410_probe(struct device *dev, const char *name,
 		goto exit_remove_name;
 	}
 
+	if (irq > 0) {
+		ret = request_threaded_irq(irq, NULL, adt7410_irq_handler,
+				IRQF_TRIGGER_LOW | IRQF_ONESHOT, name, dev);
+		if (ret)
+			goto exit_hwmon_device_unregister;
+	}
+
 	return 0;
 
+exit_hwmon_device_unregister:
+	hwmon_device_unregister(data->hwmon_dev);
 exit_remove_name:
 	if (name)
 		device_remove_file(dev, &dev_attr_name);
@@ -434,10 +470,13 @@ exit_restore:
 }
 EXPORT_SYMBOL_GPL(adt7410_probe);
 
-int adt7410_remove(struct device *dev)
+int adt7410_remove(struct device *dev, int irq)
 {
 	struct adt7410_data *data = dev_get_drvdata(dev);
 
+	if (irq > 0)
+		free_irq(irq, dev);
+
 	hwmon_device_unregister(data->hwmon_dev);
 	if (data->name)
 		device_remove_file(dev, &dev_attr_name);
diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
index 17c8053..173b094 100644
--- a/drivers/hwmon/adt7x10.h
+++ b/drivers/hwmon/adt7x10.h
@@ -32,9 +32,9 @@ struct adt7410_ops {
 	int (*write_byte)(struct device *, u8 reg, u8 data);
 };
 
-int adt7410_probe(struct device *dev, const char *name,
+int adt7410_probe(struct device *dev, const char *name, int irq,
 	const struct adt7410_ops *ops);
-int adt7410_remove(struct device *dev);
+int adt7410_remove(struct device *dev, int irq);
 
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
