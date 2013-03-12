From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 12 Mar 2013 10:38:47 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (adt7x10) Add alarm interrupt support
Message-Id: <1363084727-2372-3-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This allows an userspace application to poll() on the alarm files to get
notified in case of a temperature threshold event.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v2:
	* None
Changes since v1:
	* Switch from level triggered and interrupt mode to edge triggered and
	  comparator mode. In interrupt mode the status register get's cleared after
	  the first read and so the _alarm files will always read 0, which is not
	  really what we want.
	* Use dev_name(dev) for the interrupt name, instead of 'name' which will be
	  NULL for I2C devices
---
 drivers/hwmon/adt7310.c |  4 ++--
 drivers/hwmon/adt7410.c |  4 ++--
 drivers/hwmon/adt7x10.c | 41 ++++++++++++++++++++++++++++++++++++++---
 drivers/hwmon/adt7x10.h |  4 ++--
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index f8ea629..b70a481 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -90,13 +90,13 @@ static const struct adt7x10_ops adt7310_spi_ops = {
 
 static int adt7310_spi_probe(struct spi_device *spi)
 {
-	return adt7x10_probe(&spi->dev, spi_get_device_id(spi)->name,
+	return adt7x10_probe(&spi->dev, spi_get_device_id(spi)->name, spi->irq,
 			&adt7310_spi_ops);
 }
 
 static int adt7310_spi_remove(struct spi_device *spi)
 {
-	return adt7x10_remove(&spi->dev);
+	return adt7x10_remove(&spi->dev, spi->irq);
 }
 
 static const struct spi_device_id adt7310_id[] = {
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index d294445..0dc066a 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -47,12 +47,12 @@ static int adt7410_i2c_probe(struct i2c_client *client,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	return adt7x10_probe(&client->dev, NULL, &adt7410_i2c_ops);
+	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
 }
 
 static int adt7410_i2c_remove(struct i2c_client *client)
 {
-	return adt7x10_remove(&client->dev);
+	return adt7x10_remove(&client->dev, client->irq);
 }
 
 static const struct i2c_device_id adt7410_ids[] = {
diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 84b3dfc..98141f4 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -30,6 +30,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include "adt7x10.h"
 
@@ -112,6 +113,25 @@ static const u8 ADT7X10_REG_TEMP[4] = {
 	ADT7X10_T_CRIT,			/* critical */
 };
 
+static irqreturn_t adt7x10_irq_handler(int irq, void *private)
+{
+	struct device *dev = private;
+	int status;
+
+	status = adt7x10_read_byte(dev, ADT7X10_STATUS);
+	if (status < 0)
+		return IRQ_HANDLED;
+
+	if (status & ADT7X10_STAT_T_HIGH)
+		sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
+	if (status & ADT7X10_STAT_T_LOW)
+		sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
+	if (status & ADT7X10_STAT_T_CRIT)
+		sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");
+
+	return IRQ_HANDLED;
+}
+
 static int adt7x10_temp_ready(struct device *dev)
 {
 	int i, status;
@@ -359,7 +379,7 @@ static const struct attribute_group adt7x10_group = {
 	.attrs = adt7x10_attributes,
 };
 
-int adt7x10_probe(struct device *dev, const char *name,
+int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
 {
 	struct adt7x10_data *data;
@@ -387,8 +407,10 @@ int adt7x10_probe(struct device *dev, const char *name,
 	 * Set to 16 bit resolution, continous conversion and comparator mode.
 	 */
 	data->config = data->oldconfig;
-	data->config &= ~ADT7X10_MODE_MASK;
+	data->config &= ~(ADT7X10_MODE_MASK | ADT7X10_CT_POLARITY |
+			ADT7X10_INT_POLARITY);
 	data->config |= ADT7X10_FULL | ADT7X10_RESOLUTION | ADT7X10_EVENT_MODE;
+
 	if (data->config != data->oldconfig) {
 		ret = adt7x10_write_byte(dev, ADT7X10_CONFIG, data->config);
 		if (ret)
@@ -422,8 +444,18 @@ int adt7x10_probe(struct device *dev, const char *name,
 		goto exit_remove_name;
 	}
 
+	if (irq > 0) {
+		ret = request_threaded_irq(irq, NULL, adt7x10_irq_handler,
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				dev_name(dev), dev);
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
@@ -435,10 +467,13 @@ exit_restore:
 }
 EXPORT_SYMBOL_GPL(adt7x10_probe);
 
-int adt7x10_remove(struct device *dev)
+int adt7x10_remove(struct device *dev, int irq)
 {
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 
+	if (irq > 0)
+		free_irq(irq, dev);
+
 	hwmon_device_unregister(data->hwmon_dev);
 	if (data->name)
 		device_remove_file(dev, &dev_attr_name);
diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
index 803d9b9..d491c69 100644
--- a/drivers/hwmon/adt7x10.h
+++ b/drivers/hwmon/adt7x10.h
@@ -23,9 +23,9 @@ struct adt7x10_ops {
 	int (*write_word)(struct device *, u8 reg, u16 data);
 };
 
-int adt7x10_probe(struct device *dev, const char *name,
+int adt7x10_probe(struct device *dev, const char *name, int irq,
 	const struct adt7x10_ops *ops);
-int adt7x10_remove(struct device *dev);
+int adt7x10_remove(struct device *dev, int irq);
 
 #ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops adt7x10_dev_pm_ops;
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
