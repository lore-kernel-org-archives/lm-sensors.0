From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 13 Apr 2010 22:59:29 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (ltc4245) expose all GPIO pins as
Message-Id: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for exposing all GPIO pins as analog voltages. Though this is
not an ideal use of the chip, some hardware engineers may decide that the
LTC4245 meets their design requirements when studying the datasheet.

The GPIO pins are sampled in round-robin fashion, meaning that a slow
reader will see stale data. A userspace application can detect this,
because it will get -EAGAIN when reading from a sysfs file which contains
stale data.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 Documentation/hwmon/ltc4245 |   13 +++++-
 drivers/hwmon/Kconfig       |   10 +++++
 drivers/hwmon/ltc4245.c     |   95 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
index 86b5880..1c0599f 100644
--- a/Documentation/hwmon/ltc4245
+++ b/Documentation/hwmon/ltc4245
@@ -72,9 +72,20 @@ in6_min_alarm		5v  output undervoltage alarm
 in7_min_alarm		3v  output undervoltage alarm
 in8_min_alarm		Vee (-12v) output undervoltage alarm
 
-in9_input		GPIO voltage data
+in9_input		GPIO voltage data (see note 1)
+in10_input		GPIO voltage data (see note 1)
+in11_input		GPIO voltage data (see note 1)
 
 power1_input		12v power usage (mW)
 power2_input		5v  power usage (mW)
 power3_input		3v  power usage (mW)
 power4_input		Vee (-12v) power usage (mW)
+
+
+Note 1
+------
+
+If you have configured your kernel with CONFIG_SENSORS_LTC4245_EXTRA_GPIOS=y
+then all three GPIO voltage lines will be sampled in round-robin fashion. If
+the data becomes stale, -EAGAIN will be returned when you read the sysfs
+attribute containing the sensor reading.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e4595e6..e9c99cb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -623,6 +623,16 @@ config SENSORS_LTC4245
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc4245.
 
+config SENSORS_LTC4245_EXTRA_GPIOS
+	bool "LTC4245: sample all GPIO pins as analog voltages"
+	depends on SENSORS_LTC4245
+	default n
+	help
+	  If you say yes here, the LTC4245 driver will read all of the GPIO
+	  pins in rotation, reporting them as extra voltage channels.
+
+	  Please read the Documentation/hwmon/ltc4245 file for more details.
+
 config SENSORS_LM95241
 	tristate "National Semiconductor LM95241 sensor chip"
 	depends on I2C
diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 84e6f32..33fdc02 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -60,8 +60,70 @@ struct ltc4245_data {
 
 	/* Voltage registers */
 	u8 vregs[0x0d];
+
+	/* GPIO ADC registers */
+	unsigned int last_gpio;
+	int gpios[3];
 };
 
+#ifdef CONFIG_SENSORS_LTC4245_EXTRA_GPIOS
+/*
+ * Update the readings from all three GPIO pins. This means that the old
+ * readings will be delayed.
+ *
+ * LOCKING: must hold data->update_lock
+ */
+static void ltc4245_update_gpios(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+	u8 gpio_curr, gpio_next, gpio, ctl;
+	int i;
+
+	/*
+	 * If the last reading was 10 seconds ago, then we mark all old GPIO
+	 * readings as stale by setting them to zero volts
+	 */
+	if (time_after(jiffies, data->last_updated + 10 * HZ)) {
+		dev_dbg(&client->dev, "Marking GPIOs invalid\n");
+		for (i = 0; i < ARRAY_SIZE(data->gpios); i++)
+			data->gpios[i] = -EAGAIN;
+	}
+
+	/* Read the GPIO voltage from the GPIOADC register */
+	gpio_curr = data->last_gpio;
+	data->gpios[gpio_curr] = data->vregs[LTC4245_GPIOADC - 0x10];
+
+	/* Find the next GPIO pin to read */
+	gpio_next = (data->last_gpio + 1) % ARRAY_SIZE(data->gpios);
+
+	/*
+	 * Calculate the correct setting for the GPIO register so it will
+	 * sample the next GPIO pin
+	 */
+	gpio = (data->cregs[LTC4245_GPIO] & 0x3f) | ((gpio_next + 1) << 6);
+	ctl = data->cregs[LTC4245_CONTROL];
+
+	/* Update the GPIO register */
+	i2c_smbus_write_byte_data(client, LTC4245_CONTROL, ctl | 0x80);
+	i2c_smbus_write_byte_data(client, LTC4245_GPIO, gpio);
+	i2c_smbus_write_byte_data(client, LTC4245_CONTROL, ctl);
+
+	/* Update saved data */
+	data->cregs[LTC4245_GPIO] = gpio;
+	data->last_gpio = gpio_next;
+}
+#else
+static void ltc4245_update_gpios(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+
+	/* Just copy the data from the the GPIOADC register */
+	data->gpios[0] = data->vregs[LTC4245_GPIOADC - 0x10];
+}
+#endif
+
 static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -93,6 +155,9 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 				data->vregs[i] = val;
 		}
 
+		/* Update GPIO readings */
+		ltc4245_update_gpios(dev);
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -233,6 +298,22 @@ static ssize_t ltc4245_show_alarm(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", (reg & mask) ? 1 : 0);
 }
 
+static ssize_t ltc4245_show_gpio(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	int val = data->gpios[attr->index];
+
+	/* handle stale GPIO's */
+	if (val < 0)
+		return val;
+
+	/* Convert to millivolts and print */
+	return snprintf(buf, PAGE_SIZE, "%u\n", val * 10);
+}
+
 /* These macros are used below in constructing device attribute objects
  * for use with sysfs_create_group() to make a sysfs device file
  * for each register.
@@ -254,6 +335,10 @@ static ssize_t ltc4245_show_alarm(struct device *dev,
 	static SENSOR_DEVICE_ATTR_2(name, S_IRUGO, \
 	ltc4245_show_alarm, NULL, (mask), reg)
 
+#define LTC4245_GPIO(name, gpio_num) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show_gpio, NULL, gpio_num)
+
 /* Construct a sensor_device_attribute structure for each register */
 
 /* Input voltages */
@@ -293,7 +378,11 @@ LTC4245_ALARM(in7_min_alarm,	(1 << 2),	LTC4245_FAULT2);
 LTC4245_ALARM(in8_min_alarm,	(1 << 3),	LTC4245_FAULT2);
 
 /* GPIO voltages */
-LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC);
+LTC4245_GPIO(in9_input,				0);
+#ifdef CONFIG_SENSORS_LTC4245_EXTRA_GPIOS
+LTC4245_GPIO(in10_input,			1);
+LTC4245_GPIO(in11_input,			2);
+#endif
 
 /* Power Consumption (virtual) */
 LTC4245_POWER(power1_input,			LTC4245_12VSENSE);
@@ -336,6 +425,10 @@ static struct attribute *ltc4245_attributes[] = {
 	&sensor_dev_attr_in8_min_alarm.dev_attr.attr,
 
 	&sensor_dev_attr_in9_input.dev_attr.attr,
+#ifdef CONFIG_SENSORS_LTC4245_EXTRA_GPIOS
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+#endif
 
 	&sensor_dev_attr_power1_input.dev_attr.attr,
 	&sensor_dev_attr_power2_input.dev_attr.attr,
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
