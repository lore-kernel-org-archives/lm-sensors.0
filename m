From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Tue, 11 Aug 2009 08:13:34 +0000
Subject: [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
Message-Id: <20090811185416.GB32002@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From 2d11a9f666b7477cc8faca0f055f4477f328516f Mon Sep 17 00:00:00 2001
From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Tue, 11 Aug 2009 14:28:32 -0400
Subject: [PATCH] Intersil ISL29020 ALS driver
ALS driver will read the latest Lux measurement based on the light brightness and will report the LUX output through sysfs interface.

Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>

---
 drivers/hwmon/Kconfig    |   11 ++
 drivers/hwmon/Makefile   |    1 +
 drivers/hwmon/isl29020.c |  237 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+), 0 deletions(-)
 create mode 100755 drivers/hwmon/isl29020.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..c89f1f6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1017,6 +1017,17 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
+config SENSORS_ISL29020
+	tristate "Intersil ISL29020 ALS"
+	depends on I2C_MRST
+	default n
+	help
+	  If you say yes here you get support for the ALS Devices
+	  Ambient Light Sensor monitoring chip.
+	  Range values can be configured using sysfs.
+	  Lux Data are  accessible via sysfs.
+
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	default n
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b793dce..3b1e424 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
+obj-$(CONFIG_SENSORS_LIS331DL)	+= lis331dl.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/isl29020.c b/drivers/hwmon/isl29020.c
new file mode 100755
index 0000000..162dcb1
--- /dev/null
+++ b/drivers/hwmon/isl29020.c
@@ -0,0 +1,237 @@
+/*
+ * isl29020.c - Intersil  ALS Driver
+ *
+ * Copyright (C) 2008 Intel Corp
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
+MODULE_DESCRIPTION("intersil isl29020 ALS Driver");
+MODULE_LICENSE("GPL v2");
+
+#define ALS_MIN_RANGE_VAL 0
+#define ALS_MAX_RANGE_VAL 5
+#define POWER_STA_ENABLE 1
+#define POWER_STA_DISABLE 0
+
+struct als_data {
+	struct device *hwmon_dev;
+};
+
+static unsigned int i2c_write_current_data(struct i2c_client *client,
+					unsigned int reg, unsigned int value)
+{
+	int ret_val;
+
+	ret_val = i2c_smbus_write_byte_data(client, reg, value);
+	return ret_val;
+}
+
+static ssize_t als_sensing_range_show(struct device *dev,
+			struct device_attribute *attr,  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int  val;
+
+	val = i2c_smbus_read_byte_data(client, 0x00);
+	return sprintf(buf, "%d000\n", 1 << (2 * (val & 3)));
+
+}
+
+static ssize_t als_lux_output_data_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int ret_val, val;
+	unsigned long int lux, max_count;
+	int tempv1, tempv2;
+
+	max_count = 65535;
+	tempv1 = i2c_smbus_read_byte_data(client, 0x02); /* MSB data */
+	tempv2 = i2c_smbus_read_byte_data(client, 0x01); /* LSB data */
+	ret_val = tempv1;
+	ret_val = (ret_val << 8 | tempv2);
+	val = i2c_smbus_read_byte_data(client, 0x00);
+	lux = ((((1 << (2 * (val & 3))))*1000) * ret_val) / max_count;
+	return sprintf(buf, "%ld\n", lux);
+}
+
+static ssize_t als_sensing_range_store(struct device *dev,
+		struct device_attribute *attr, const  char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int ret_val;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+	ret_val = i2c_smbus_read_byte_data(client, 0x00);
+	ret_val = ret_val & 0xFC; /*reset the bit before setting them */
+	if (val < 1 || val > 4)
+		return -EINVAL;
+	i2c_write_current_data(client, 0x00, ret_val | (val - 1));
+	return count;
+}
+
+static ssize_t als_power_status_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_smbus_read_byte_data(client, 0x00);
+	ret_val = ret_val & 0x80;
+	if (ret_val = 0x80)
+		ret_val = 1;
+	return sprintf(buf, "%x", ret_val);
+}
+
+static ssize_t als_power_status_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = 0;
+	char curr_val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	curr_val = i2c_smbus_read_byte_data(client, 0x00);
+	if (val = POWER_STA_ENABLE)
+		curr_val = curr_val | 0x80;
+	else if (val = POWER_STA_DISABLE)
+		curr_val = curr_val & 0x7F;
+	else
+		return -EINVAL;
+	i2c_write_current_data(client, 0x00, curr_val);
+	return count;
+}
+
+static DEVICE_ATTR(sensing_range, S_IRUGO | S_IWUSR,
+	als_sensing_range_show, als_sensing_range_store);
+static DEVICE_ATTR(lux_output, S_IRUGO, als_lux_output_data_show, NULL);
+static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
+	als_power_status_show, als_power_status_store);
+
+static struct attribute *mid_att_als[] = {
+	&dev_attr_sensing_range.attr,
+	&dev_attr_lux_output.attr,
+	&dev_attr_power_state.attr,
+	NULL
+};
+
+static struct attribute_group m_als_gr = {
+	.name = "isl29020",
+	.attrs = mid_att_als
+};
+
+static void als_set_default_config(struct i2c_client *client)
+{
+	i2c_write_current_data(client, 0x00, 0xc0);
+}
+
+static int  isl29020_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	int res;
+	struct als_data *data;
+
+	data = kzalloc(sizeof(struct als_data), GFP_KERNEL);
+	if (data = NULL) {
+		printk(KERN_WARNING " isl29020: Memory initialization failed");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(client, data);
+
+	res = sysfs_create_group(&client->dev.kobj, &m_als_gr);
+	if (res) {
+		printk(KERN_WARNING "isl29020: device create file failed!!\n");
+		goto als_error1;
+	}
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
+		data->hwmon_dev = NULL;
+		sysfs_remove_group(&client->dev.kobj, &m_als_gr);
+		printk(KERN_ALERT "isl29020:unable to register hwmon device\n");
+		goto als_error1;
+	}
+	dev_info(&client->dev, "%s isl29020: ALS chip found \n", client->name);
+	als_set_default_config(client);
+	return res;
+
+als_error1:
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
+	return res;
+}
+
+static int isl29020_remove(struct i2c_client *client)
+{
+	struct als_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &m_als_gr);
+	kfree(data);
+	return 0;
+}
+
+static struct i2c_device_id isl29020_id[] = {
+	{ "i2c_als", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, isl29020_id);
+
+static struct i2c_driver isl29020_driver = {
+	.driver = {
+	.name = "isl29020",
+	},
+	.probe = isl29020_probe,
+	.remove = isl29020_remove,
+	.id_table = isl29020_id,
+};
+
+static int __init sensor_isl29020_init(void)
+{
+	int res;
+
+	res = i2c_add_driver(&isl29020_driver);
+	return res;
+}
+
+static void  __exit sensor_isl29020_exit(void)
+{
+	i2c_del_driver(&isl29020_driver);
+}
+
+module_init(sensor_isl29020_init);
+module_exit(sensor_isl29020_exit);
-- 
1.6.0.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
