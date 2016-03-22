From: Tiberiu Breana <tiberiu.a.breana@intel.com>
Date: Tue, 22 Mar 2016 11:41:05 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (max31722) Add alarm support
Message-Id: <1458646865-6416-3-git-send-email-tiberiu.a.breana@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add temperature threshold alarm support for the max31722
sensor driver.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 Documentation/hwmon/max31722 |   7 +++
 drivers/hwmon/max31722.c     | 130 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 131 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/max31722 b/Documentation/hwmon/max31722
index 090da845..e247963 100644
--- a/Documentation/hwmon/max31722
+++ b/Documentation/hwmon/max31722
@@ -25,6 +25,10 @@ Usage Notes
 -----------
 
 This driver uses ACPI to auto-detect devices. See ACPI IDs in the above section.
+The sensor supports a temperature alarm. This is set once the measured
+temperature goes above a user-set threshold (temp1_max) and will be cleared
+once the temperature goes below temp1_min. See the datasheet, page 9,
+"Comparator Mode" for details.
 
 Sysfs entries
 -------------
@@ -32,3 +36,6 @@ Sysfs entries
 The following attribute is supported:
 
 temp1_input		Measured temperature. Read-only.
+temp1_alarm		Temperature alarm. Read-only.
+temp1_min		Minimum temperature threshold. Read-write.
+temp1_max		Maximum temperature threshold. Read-write.
diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
index 13ba906..8e14eed 100644
--- a/drivers/hwmon/max31722.c
+++ b/drivers/hwmon/max31722.c
@@ -11,6 +11,8 @@
 
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
@@ -20,13 +22,20 @@
 #define MAX31722_REG_CFG				0x00
 #define MAX31722_REG_TEMP_LSB				0x01
 #define MAX31722_REG_TEMP_MSB				0x02
+#define MAX31722_REG_THIGH_LSB				0x03
+#define MAX31722_REG_TLOW_LSB				0x05
 #define MAX31722_MAX_REG				0x86
 
 #define MAX31722_MODE_CONTINUOUS			0x00
 #define MAX31722_MODE_STANDBY				0x01
 #define MAX31722_RESOLUTION_11BIT			0x02
 
+/* Minimum and maximum supported temperatures, in millidegrees */
+#define MAX31722_MIN_TEMP				-55000
+#define MAX31722_MAX_TEMP				125000
+
 #define MAX31722_REGMAP_NAME				"max31722_regmap"
+#define MAX31722_GPIO					"max31722_gpio"
 
 #define MAX31722_REGFIELD(name)						    \
 	do {								    \
@@ -39,12 +48,27 @@
 		}							    \
 	} while (0)
 
+enum attr_index {
+	t_input,
+	t_min,
+	t_max,
+	t_alarm,
+	t_num_regs
+};
+
+static const u8 max31722_regs[t_num_regs] = {
+	[t_input]	= MAX31722_REG_TEMP_LSB,
+	[t_min]		= MAX31722_REG_TLOW_LSB,
+	[t_max]		= MAX31722_REG_THIGH_LSB,
+};
+
 struct max31722_data {
 	struct spi_device *spi_device;
 	struct device *hwmon_dev;
 	struct regmap *regmap;
 	struct regmap_field *reg_state;
 	struct regmap_field *reg_resolution;
+	bool alarm_active;
 };
 
 /*
@@ -117,9 +141,9 @@ static ssize_t max31722_show_name(struct device *dev,
 	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
 }
 
-static ssize_t max31722_show_temperature(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t max31722_show_temp(struct device *dev,
+				  struct device_attribute *devattr,
+				  char *buf)
 {
 	int i;
 	int ret;
@@ -127,8 +151,10 @@ static ssize_t max31722_show_temperature(struct device *dev,
 	s16 val;
 	u16 temp;
 	struct max31722_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	ret = regmap_bulk_read(data->regmap, MAX31722_REG_TEMP_LSB, &temp, 2);
+	ret = regmap_bulk_read(data->regmap,
+			       max31722_regs[attr->index], &temp, 2);
 	if (ret < 0) {
 		dev_err(&data->spi_device->dev,
 			"failed to read temperature register\n");
@@ -152,13 +178,79 @@ static ssize_t max31722_show_temperature(struct device *dev,
 	return sprintf(buf, "%d\n", val);
 }
 
+static ssize_t max31722_set_temp(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
+{
+	int i;
+	int ret;
+	int fract;
+	u16 thresh;
+	u8 lsb;
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	long val;
+	struct max31722_data *data = dev_get_drvdata(dev);
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val < MAX31722_MIN_TEMP || val > MAX31722_MAX_TEMP)
+		return -EINVAL;
+	/*
+	* Convert input to a register value. First round down the value to one
+	* that can be represented in the 11 bit resolution.
+	*/
+	val -= val % max31722_milli_table[2];
+
+	fract = val % 1000;
+
+	lsb = 0;
+	for (i = 0 ; i < ARRAY_SIZE(max31722_milli_table) && fract > 0; i++)
+	if (fract - max31722_milli_table[i] >= 0) {
+		fract -= max31722_milli_table[i];
+		lsb += 1 << (3 - i - 1);
+	}
+	lsb <<= 5;
+
+	thresh = (val / 1000) << 8 | lsb;
+	ret = regmap_bulk_write(data->regmap,
+				max31722_regs[attr->index], &thresh, 2);
+	if (ret < 0) {
+		dev_err(&data->spi_device->dev,
+			"failed to write threshold register\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t max31722_show_alarm(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct spi_device *spi_device = to_spi_device(dev);
+	struct max31722_data *data = spi_get_drvdata(spi_device);
+
+	return sprintf(buf, "%d\n", data->alarm_active ? 1 : 0);
+}
+
 static DEVICE_ATTR(name, S_IRUGO, max31722_show_name, NULL);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			  max31722_show_temperature, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, max31722_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, max31722_show_temp,
+			  max31722_set_temp, t_min);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, max31722_show_temp,
+			  max31722_set_temp, t_max);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, max31722_show_alarm, NULL,
+			  t_alarm);
+
 
 static struct attribute *max31722_attributes[] = {
 	&dev_attr_name.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
 	NULL,
 };
 
@@ -166,6 +258,18 @@ static const struct attribute_group max31722_group = {
 	.attrs = max31722_attributes,
 };
 
+static irqreturn_t max31722_irq_handler(int irq, void *private)
+{
+	struct max31722_data *data = private;
+	/*
+	 * The device will issue cyclical interrupts when the
+	 * THIGH/TLOW thresholds are met.
+	 */
+	data->alarm_active = !data->alarm_active;
+
+	return IRQ_HANDLED;
+}
+
 static int max31722_init(struct max31722_data *data)
 {
 	int ret = 0;
@@ -196,6 +300,8 @@ static int max31722_init(struct max31722_data *data)
 	if (ret < 0)
 		goto err;
 
+	data->alarm_active = false;
+
 	return 0;
 
 err:
@@ -223,6 +329,18 @@ static int max31722_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto err_standby;
 
+	if (spi->irq > 0) {
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+						NULL,
+						max31722_irq_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						dev_name(&spi->dev), data);
+		if (ret < 0) {
+			dev_err(&spi->dev, "request irq %d failed\n", spi->irq);
+			goto err_remove_group;
+		}
+	}
+
 	data->hwmon_dev = hwmon_device_register(&spi->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
