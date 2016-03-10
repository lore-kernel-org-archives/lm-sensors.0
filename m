From: Pascal Sachs <Pascal.Sachs@sensirion.com>
Date: Thu, 10 Mar 2016 14:56:43 +0000
Subject: [lm-sensors] [PATCH 1/1] hwmon: add support for Sensirion SHT3x sensors
Message-Id: <157916ADD54A1D4ABFF27DDF0233870C956E1A93@S-EXCH01.sensirion.lokal>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pascal Sachs <Pascal.Sachs@sensirion.com>, David Frey <David.Frey@sensirion.com>

From: David Frey <david.frey@sensirion.com>

This driver implements support for the Sensirion SHT3x-DIS chip,
a humidity and temperature sensor. Temperature is measured
in degrees Celsius, relative humidity is expressed as a percentage.
In the sysfs interface, all values are scaled by 1000,
i.e. the value for 31.5 degrees Celsius is 31500.

Signed-off-by: Pascal Sachs <pascal.sachs@sensirion.com>
---
Patch was generated against kernel v4.5-rc7

 Documentation/hwmon/sht3x           |  42 ++++
 drivers/hwmon/Kconfig               |  10 +
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/sht3x.c               | 389 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/sht3x.h |  23 +++
 5 files changed, 465 insertions(+)
 create mode 100644 Documentation/hwmon/sht3x
 create mode 100644 drivers/hwmon/sht3x.c
 create mode 100644 include/linux/platform_data/sht3x.h

diff --git a/Documentation/hwmon/sht3x b/Documentation/hwmon/sht3x
new file mode 100644
index 0000000..6023862
--- /dev/null
+++ b/Documentation/hwmon/sht3x
@@ -0,0 +1,42 @@
+Kernel driver sht3x
+=========+
+Supported chips:
+  * Sensirion SHT3x-DIS
+    Prefix: 'sht3x'
+    Addresses scanned: none
+    Datasheet: http://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/Humidity/Sensirion_Humidity_Datasheet_SHT3x_DIS.pdf
+
+Author:
+  David Frey <david.frey@sensirion.com>
+
+Description
+-----------
+
+This driver implements support for the Sensirion SHT3x-DIS chip, a humidity
+and temperature sensor. Temperature is measured in degrees celsius, relative
+humidity is expressed as a percentage. In the sysfs interface, all values are
+scaled by 1000, i.e. the value for 31.5 degrees celsius is 31500.
+
+The device communicates with the I2C protocol. Sensors can have the I2C
+addresses 0x44 or 0x45, depending on the wiring. See
+Documentation/i2c/instantiating-devices for methods to instantiate the device.
+
+There are two options configurable by means of sht3x_platform_data:
+1. blocking (pull the I2C clock line down while performing the measurement) or
+   non-blocking mode. Blocking mode will guarantee the fastest result but
+   the I2C bus will be busy during that time. By default, non-blocking mode
+   is used. Make sure clock-stretching works properly on your device if you
+   want to use blocking mode.
+2. high or low accuracy. High accuracy is used by default and using it is
+   strongly recommended.
+
+sysfs-Interface
+---------------
+
+temp1_input:      temperature input
+humidity1_input:  humidity input
+high_alert_set:   temperature and humidity at which to set the high alert
+high_alert_clear: temperature and humidity at which to clear the high alert
+low_alert_clear:  temperature and humidity at which to clear the low alert
+low_alert_set:    temperature and humidity at which to set the low alert
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 60fb80b..4722b76 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1235,6 +1235,16 @@ config SENSORS_SHTC1
          This driver can also be built as a module.  If so, the module
          will be called shtc1.

+config SENSORS_SHT3x
+       tristate "Sensiron humidity and temperature sensors. SHT3x and compat."
+       depends on I2C
+       help
+         If you say yes here you get support for the Sensiron SHT30 and SHT31
+         humidity and temperature sensors.
+
+         This driver can also be built as a module.  If so, the module
+         will be called sht3x.
+
 config SENSORS_S3C
        tristate "Samsung built-in ADC"
        depends on S3C_ADC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 30c94df..8f19eab 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_SENSORS_SCH5636)       += sch5636.o
 obj-$(CONFIG_SENSORS_SHT15)    += sht15.o
 obj-$(CONFIG_SENSORS_SHT21)    += sht21.o
 obj-$(CONFIG_SENSORS_SHTC1)    += shtc1.o
+obj-$(CONFIG_SENSORS_SHT3x)    += sht3x.o
 obj-$(CONFIG_SENSORS_SIS5595)  += sis5595.o
 obj-$(CONFIG_SENSORS_SMM665)   += smm665.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
new file mode 100644
index 0000000..2e78c44
--- /dev/null
+++ b/drivers/hwmon/sht3x.c
@@ -0,0 +1,389 @@
+/* Sensirion SHT3x-DIS humidity and temperature sensor driver.
+ * The SHT3x comes in many different versions, this driver is for the
+ * I2C version only.
+ *
+ * Copyright (C) 2015 Sensirion AG, Switzerland
+ * Author: David Frey <david.frey@sensirion.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <asm/page.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_data/sht3x.h>
+
+/* commands (high precision mode) */
+static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
+static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
+
+/* commands (low power mode) */
+static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
+static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
+
+static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xF3, 0x2D };
+
+#define HIGH_ALERT_SET_NAME "high_alert_set"
+#define HIGH_ALERT_CLEAR_NAME "high_alert_clear"
+#define LOW_ALERT_SET_NAME "low_alert_set"
+#define LOW_ALERT_CLEAR_NAME "low_alert_clear"
+
+/* delays for non-blocking i2c commands, both in us */
+#define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
+#define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
+
+#define SHT3X_WORD_LEN         2
+#define SHT3X_CMD_LENGTH       SHT3X_WORD_LEN
+#define SHT3X_CRC8_LEN         1
+#define SHT3X_RESPONSE_LENGTH  6
+#define SHT3X_THRESHOLD_LENGTH 2
+#define SHT3X_THRESHOLD_COUNT \
+       (sizeof(threshold_commands) / sizeof(struct sht3x_alert_commands))
+#define SHT3X_CRC8_LEN         1
+#define SHT3X_CRC8_POLYNOMIAL  0x31
+#define SHT3X_CRC8_INIT        0xFF
+
+DECLARE_CRC8_TABLE(sht3x_crc8_table);
+
+struct sht3x_alert_commands {
+       const char *threshold_name;
+       const char read_command[SHT3X_CMD_LENGTH];
+       const char write_command[SHT3X_CMD_LENGTH];
+};
+
+const struct sht3x_alert_commands threshold_commands[] = {
+       { HIGH_ALERT_SET_NAME,   {0xe1, 0x1f}, {0x61, 0x1d} },
+       { HIGH_ALERT_CLEAR_NAME, {0xe1, 0x14}, {0x61, 0x16} },
+       { LOW_ALERT_SET_NAME,    {0xe1, 0x02}, {0x61, 0x00} },
+       { LOW_ALERT_CLEAR_NAME,  {0xe1, 0x09}, {0x61, 0x0B} },
+};
+
+struct sht3x_data {
+       struct i2c_client *client;
+       struct mutex update_lock;
+
+       const unsigned char *command;
+       unsigned int nonblocking_wait_time;     /* in us */
+
+       struct sht3x_platform_data setup;
+
+       int temperature;        /* 1000 * temperature in dgr C */
+       int humidity;           /* 1000 * relative humidity in %RH */
+};
+
+
+static const struct sht3x_alert_commands*
+find_commands(const char *threshold_name)
+{
+       int i;
+
+       for (i = 0; i < SHT3X_THRESHOLD_COUNT; i++) {
+               if (strcmp(threshold_name, threshold_commands[i].threshold_name)
+                               = 0)
+                       return &threshold_commands[i];
+       }
+       return 0;
+}
+
+static int sht3x_read_from_command(struct i2c_client *client,
+                                  const char *command,
+                                  char *buf, int length,
+                                  unsigned int wait_time)
+{
+       int ret = i2c_master_send(client, command, SHT3X_CMD_LENGTH);
+
+       if (ret != SHT3X_CMD_LENGTH) {
+               dev_err(&client->dev, "failed to send command: %d\n", ret);
+               return ret < 0 ? ret : -EIO;
+       }
+
+       if (wait_time)
+               usleep_range(wait_time, wait_time + 1000);
+
+       ret = i2c_master_recv(client, buf, length);
+       if (ret != length) {
+               dev_err(&client->dev, "failed to read values: %d\n", ret);
+               return ret < 0 ? ret : -EIO;
+       }
+
+       return 0;
+}
+
+static int sht3x_extract_temperature(u16 raw)
+{
+       /*
+        * From datasheet:
+        * T = -45 + 175 * ST / 2^16
+        * Adapted for integer fixed point (3 digit) arithmetic.
+        */
+       return ((21875 * (int)raw) >> 13) - 45000;
+}
+
+static int sht3x_extract_humidity(u16 raw)
+{
+       /*
+        * From datasheet:
+        * RH = 100 * SRH / 2^16
+        * Adapted for integer fixed point (3 digit) arithmetic.
+        */
+       return ((12500 * (int)raw) >> 13);
+}
+
+/* sysfs attributes */
+static struct sht3x_data *sht3x_update_client(struct device *dev)
+{
+       struct sht3x_data *data = dev_get_drvdata(dev);
+       struct i2c_client *client = data->client;
+       unsigned char buf[SHT3X_RESPONSE_LENGTH];
+       u16 val;
+       int ret = 0;
+       /*
+        * In blocking mode (clock stretching mode) the I2C bus
+        * is blocked for other traffic, thus the call to i2c_master_recv()
+        * will wait until the data is ready. For non blocking mode, we
+        * have to wait ourselves.
+        */
+       unsigned int wait_time = data->setup.blocking_io ?
+                       0 : data->nonblocking_wait_time;
+
+       mutex_lock(&data->update_lock);
+
+       ret = sht3x_read_from_command(client, data->command,
+                                     buf, sizeof(buf), wait_time);
+       if (ret)
+               goto out;
+
+       val = be16_to_cpup((__be16 *) buf);
+       data->temperature = sht3x_extract_temperature(val);
+       val = be16_to_cpup((__be16 *) (buf + 3));
+       data->humidity = sht3x_extract_humidity(val);
+
+out:
+       mutex_unlock(&data->update_lock);
+
+       return ret = 0 ? data : ERR_PTR(ret);
+}
+
+static ssize_t temp1_input_show(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct sht3x_data *data = sht3x_update_client(dev);
+
+       if (IS_ERR(data))
+               return PTR_ERR(data);
+
+       return sprintf(buf, "%d\n", data->temperature);
+}
+
+static ssize_t humidity1_input_show(struct device *dev,
+                                   struct device_attribute *attr, char *buf)
+{
+       struct sht3x_data *data = sht3x_update_client(dev);
+
+       if (IS_ERR(data))
+               return PTR_ERR(data);
+
+       return sprintf(buf, "%d\n", data->humidity);
+}
+
+static ssize_t alert_show(struct device *dev,
+                         struct device_attribute *attr,
+                         char *buf)
+{
+       char buffer[SHT3X_WORD_LEN];
+       u16 raw;
+       int temperature, humidity;
+       struct sht3x_data *data = dev_get_drvdata(dev);
+       struct i2c_client *client = data->client;
+       const struct sht3x_alert_commands *commands +               find_commands(attr->attr.name);
+
+       int ret = sht3x_read_from_command(client, commands->read_command,
+                                         buffer, sizeof(buffer), 0);
+       if (ret)
+               return ret;
+
+       raw = be16_to_cpup((__be16 *) buffer);
+       /*
+        * top 7 bits are the humidity MSB,
+        * lower 9 bits are temperature MSB
+        */
+       temperature = sht3x_extract_temperature((raw & 0x01ff) << 7);
+       humidity = sht3x_extract_humidity(raw & 0xfe00);
+
+       return scnprintf(buf, PAGE_SIZE, "%d %d\n", temperature, humidity);
+}
+
+static ssize_t alert_store(struct device *dev,
+                          struct device_attribute *attr,
+                          const char *buf,
+                          size_t count)
+{
+       char buffer[2 * SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
+       char *position = buffer;
+       u16 raw;
+       int temperature, humidity;
+       struct sht3x_data *data = dev_get_drvdata(dev);
+       struct i2c_client *client = data->client;
+       const struct sht3x_alert_commands *commands +               find_commands(attr->attr.name);
+
+       int ret = sscanf(buf, "%d %d", &temperature, &humidity);
+
+       if (ret != SHT3X_THRESHOLD_LENGTH) {
+               dev_err(&client->dev, "wrong number of arguments: %d", ret);
+               return -EINVAL;
+       }
+       if (temperature < -45000 || temperature > 130000) {
+               dev_err(&client->dev, "temperature out of range");
+               return -EINVAL;
+       }
+       if (humidity < 0 || humidity > 100000) {
+               dev_err(&client->dev, "humidity out of range");
+               return -EINVAL;
+       }
+
+       memcpy(position, commands->write_command, SHT3X_CMD_LENGTH);
+       position += SHT3X_CMD_LENGTH;
+       /*
+        * ST = (T + 45) / 175 * 2^16
+        * SRH = RH / 100 * 2^16
+        * adapted for fixed point arithmetic and packed the same as
+        * in alert_show()
+        */
+       raw = ((temperature + 45000) * 24543) >> (16 + 7);
+       raw |= ((humidity * 42950) >> 16) & 0xfe00;
+       *(__be16 *)(position) = cpu_to_be16(raw);
+       position[SHT3X_WORD_LEN] = crc8(sht3x_crc8_table,
+                                       position, SHT3X_WORD_LEN,
+                                       SHT3X_CRC8_INIT);
+
+       ret = i2c_master_send(client, buffer, sizeof(buffer));
+       if (ret != sizeof(buffer)) {
+               dev_err(&client->dev, "failed to set alert threshold\n");
+               return ret < 0 ? ret : -EIO;
+       }
+       return count;
+}
+
+static DEVICE_ATTR_RO(temp1_input);
+static DEVICE_ATTR_RO(humidity1_input);
+static DEVICE_ATTR(high_alert_set, 0664, alert_show, alert_store);
+static DEVICE_ATTR(high_alert_clear, 0664, alert_show, alert_store);
+static DEVICE_ATTR(low_alert_set, 0664, alert_show, alert_store);
+static DEVICE_ATTR(low_alert_clear, 0664, alert_show, alert_store);
+
+static struct attribute *sht3x_attrs[] = {
+       &dev_attr_temp1_input.attr,
+       &dev_attr_humidity1_input.attr,
+       &dev_attr_high_alert_set.attr,
+       &dev_attr_high_alert_clear.attr,
+       &dev_attr_low_alert_set.attr,
+       &dev_attr_low_alert_clear.attr,
+       NULL
+};
+
+ATTRIBUTE_GROUPS(sht3x);
+
+static void sht3x_select_command(struct sht3x_data *data)
+{
+       if (data->setup.high_precision) {
+               data->command = data->setup.blocking_io ?
+                               sht3x_cmd_measure_blocking_hpm :
+                               sht3x_cmd_measure_nonblocking_hpm;
+               data->nonblocking_wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
+
+       } else {
+               data->command = data->setup.blocking_io ?
+                               sht3x_cmd_measure_blocking_lpm :
+                               sht3x_cmd_measure_nonblocking_lpm;
+               data->nonblocking_wait_time = SHT3X_NONBLOCKING_WAIT_TIME_LPM;
+       }
+}
+
+static int sht3x_probe(struct i2c_client *client,
+                      const struct i2c_device_id *id)
+{
+       int ret;
+       char status_reg[2];
+       struct sht3x_data *data;
+       struct device *hwmon_dev;
+       struct i2c_adapter *adap = client->adapter;
+       struct device *dev = &client->dev;
+
+       if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
+               dev_err(dev, "plain i2c transactions not supported\n");
+               return -ENODEV;
+       }
+
+       ret = i2c_master_send(client, sht3x_cmd_read_status_reg,
+                             SHT3X_CMD_LENGTH);
+       if (ret != SHT3X_CMD_LENGTH) {
+               dev_err(dev, "could not send read_status_reg command: %d\n",
+                       ret);
+               return ret < 0 ? ret : -ENODEV;
+       }
+       ret = i2c_master_recv(client, status_reg, sizeof(status_reg));
+       if (ret != sizeof(status_reg)) {
+               dev_err(dev, "could not read status register: %d\n", ret);
+               return -ENODEV;
+       }
+
+       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+       if (!data)
+               return -ENOMEM;
+
+       data->setup.blocking_io = false;
+       data->setup.high_precision = true;
+       data->client = client;
+       crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
+
+       if (client->dev.platform_data)
+               data->setup = *(struct sht3x_platform_data *)dev->platform_data;
+       sht3x_select_command(data);
+       mutex_init(&data->update_lock);
+
+       hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+                       client->name,
+                       data, sht3x_groups);
+       if (IS_ERR(hwmon_dev))
+               dev_dbg(dev, "unable to register hwmon device\n");
+
+       return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+/* device ID table */
+static const struct i2c_device_id sht3x_id[] = {
+       {"sht3x", 0},
+       {}
+};
+
+MODULE_DEVICE_TABLE(i2c, sht3x_id);
+
+static struct i2c_driver sht3x_i2c_driver = {
+       .driver.name = "sht3x",
+       .probe       = sht3x_probe,
+       .id_table    = sht3x_id,
+};
+
+module_i2c_driver(sht3x_i2c_driver);
+
+MODULE_AUTHOR("David Frey <david.frey@sensirion.com>");
+MODULE_DESCRIPTION("Sensirion SHT3x humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/sht3x.h b/include/linux/platform_data/sht3x.h
new file mode 100644
index 0000000..c8be876
--- /dev/null
+++ b/include/linux/platform_data/sht3x.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2015 Sensirion AG, Switzerland
+ * Author: David Frey <david.frey@sensirion.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __SHT3X_H_
+#define __SHT3X_H_
+
+struct sht3x_platform_data {
+       bool blocking_io;
+       bool high_precision;
+};
+#endif /* __SHT3X_H_ */
--
1.9.1
________________________________
Confidentiality: The information contained in this email message and all attachments transmitted with it is legally privileged and confidential information intended only for the use of the addressee. If you have received this email in error, please immediately notify us and delete this email and any attachments from your system. Thank you.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
