From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Tue, 11 Aug 2009 08:19:23 +0000
Subject: [lm-sensors] Compass Driver Honeywell HMC6352 device
Message-Id: <20090811185813.GC32002@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From f06c004fe53f67326ceb9524d0e43d7fe6abed0f Mon Sep 17 00:00:00 2001
From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Tue, 11 Aug 2009 13:14:30 -0400
Subject: [PATCH] Honeywell HMC6352 compass
This driver will report the heading values in degrees to the sysfs interface.The vlaues returned are head . e.g. 245.6

Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>

---
 drivers/hwmon/Kconfig   |    9 ++
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/hmc6352.c |  249 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+), 0 deletions(-)
 create mode 100755 drivers/hwmon/hmc6352.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..cdbe553 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -992,6 +992,15 @@ config SENSORS_LIS3_SPI
 	  will be called lis3lv02d and a specific module for the SPI transport
 	  is called lis3lv02d_spi.
 
+config SENSORS_HMC6352
+	tristate "Honeywell HMC6352 compass"
+	depends on I2C_MRST
+	default n
+	help
+	  If you say yes here you get support for the Compass  Devices
+	  Device can be configured using sysfs.
+	  heading  data can be   accessible via sysfs.
+
 config SENSORS_APPLESMC
 	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
 	depends on INPUT && X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b793dce..6df7c60 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
+obj-$(CONFIG_SENSORS_HMC6352)	+= hmc6352.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/hmc6352.c b/drivers/hwmon/hmc6352.c
new file mode 100755
index 0000000..fa4b838
--- /dev/null
+++ b/drivers/hwmon/hmc6352.c
@@ -0,0 +1,249 @@
+/*
+ * hmc6352.c - Honeywell  Compass Driver
+ *
+ * Copyright (C) 2009 Intel Corp
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
+
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
+MODULE_DESCRIPTION("hmc6352 Compass Driver");
+MODULE_LICENSE("GPL v2");
+
+/* internal return values */
+#define COMP_CALIB_START 1
+#define COMP_CALIB_STOP 2
+#define COMP_SLEEP_MODE  0
+#define COMP_ACTIVE_MODE 1
+
+struct compass_data {
+	struct device *hwmon_dev;
+};
+
+static ssize_t compass_calibration_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+	unsigned long val;
+	char  cmd[] = {0x43};
+	char  cmd1[] = {0x45};
+	struct i2c_msg msg[] = {
+		{ client->addr, 0, 1, cmd },
+	};
+	struct i2c_msg msg1[] = {
+		{ client->addr, 0, 1, cmd1 },
+	};
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+	if (val = COMP_CALIB_START) {
+		client->addr = 0x21;
+		ret = i2c_transfer(client->adapter, msg, 1);
+		if (ret != 1) {
+			printk(KERN_WARNING "hmc6352_comp : i2c callib start \
+							cmd failed \n");
+			return ret;
+		}
+	} else if (val = COMP_CALIB_STOP) {
+		client->addr = 0x21;
+		ret = i2c_transfer(client->adapter, msg1, 1);
+		if (ret != 1) {
+			printk(KERN_WARNING " hmc6352_comp : i2c callib stop \
+							cmd failed \n");
+			return ret;
+		}
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t compass_heading_data_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+
+	struct i2c_client *client = to_i2c_client(dev);
+	char  cmd[] = {0x41};
+	unsigned char  i2c_data[2] = {0, 0};
+	unsigned int ret, ret_val;
+	struct i2c_msg msg[] = {
+		{ client->addr, 0, 1, cmd },
+	};
+	struct i2c_msg msg1[] = {
+		{ client->addr, I2C_M_RD, 2, i2c_data },
+	};
+
+	client->addr = 0x21;
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret != 1) {
+		printk(KERN_WARNING "hmc6352 : i2c cmd  0x41 failed \n");
+		return ret;
+	}
+	msleep(10); /* sending 0x41 cmd we need to wait for 7-10 milli second*/
+	ret = i2c_transfer(client->adapter, msg1, 1);
+	if (ret != 1) {
+		printk(KERN_WARNING "hmc6352 : i2c read data cmd failed \n");
+		return ret;
+	}
+	ret_val = i2c_data[0];
+	ret_val = ((ret_val << 8) | i2c_data[1]);
+	return sprintf(buf, "%d.%d\n", ret_val/10, ret_val%10);
+}
+
+static ssize_t compass_power_mode_store(struct device *dev,
+		struct device_attribute *attr, const  char *buf, size_t count)
+{
+
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	unsigned int ret;
+	char  cmd[] = {0x53};
+	char  cmd1[] = {0x57};
+	struct i2c_msg msg[] = {
+		{ client->addr, 0, 1, cmd },
+	};
+	struct i2c_msg msg1[] = {
+		{ client->addr, 0, 1, cmd1 },
+	};
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val = COMP_SLEEP_MODE) {
+		ret = i2c_transfer(client->adapter, msg, 1);
+		if (ret != 1)
+			printk(KERN_WARNING "hmc6352: i2c cmd  sleep mode \
+								failed \n");
+	} else if (val = COMP_ACTIVE_MODE) {
+		ret = i2c_transfer(client->adapter, msg1, 1);
+		if (ret != 1)
+			printk(KERN_WARNING "hmc6352: i2c cmd  active mode \
+								failed \n");
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR(heading, S_IRUGO, compass_heading_data_show, NULL);
+static DEVICE_ATTR(calibration, S_IWUSR, NULL, compass_calibration_store);
+static DEVICE_ATTR(power_state, S_IWUSR, NULL, compass_power_mode_store);
+
+static struct attribute *mid_att_compass[] = {
+	&dev_attr_heading.attr,
+	&dev_attr_calibration.attr,
+	&dev_attr_power_state.attr,
+	NULL
+};
+
+static struct attribute_group m_compass_gr = {
+	.name = "hmc6352",
+	.attrs = mid_att_compass
+};
+
+static int  hmc6352_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	int res;
+	struct compass_data *data;
+
+	data = kzalloc(sizeof(struct compass_data), GFP_KERNEL);
+	if (data = NULL) {
+		printk(KERN_WARNING "hmc6352: Memory initialization failed");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(client, data);
+
+	res = sysfs_create_group(&client->dev.kobj, &m_compass_gr);
+	if (res) {
+		printk(KERN_WARNING "hmc6352: device_create_file failed!!\n");
+		goto compass_error1;
+	}
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
+		data->hwmon_dev = NULL;
+		printk(KERN_WARNING "hmc6352: fail to register hwmon device\n");
+		sysfs_remove_group(&client->dev.kobj, &m_compass_gr);
+		goto compass_error1;
+	}
+	dev_info(&client->dev, "%s HMC6352 compass chip found \n",
+		client->name);
+	return res;
+
+compass_error1:
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
+	return res;
+}
+
+static int hmc6352_remove(struct i2c_client *client)
+{
+	struct compass_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &m_compass_gr);
+	kfree(data);
+	return 0;
+}
+
+static struct i2c_device_id hmc6352_id[] = {
+	{ "i2c_compass", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, hmc6352_id);
+
+static struct i2c_driver hmc6352_driver = {
+	.driver = {
+	.name = "hmc6352",
+	},
+	.probe = hmc6352_probe,
+	.remove = hmc6352_remove,
+	.id_table = hmc6352_id,
+};
+
+static int __init sensor_hmc6352_init(void)
+{
+	int res;
+
+	res = i2c_add_driver(&hmc6352_driver);
+	return res;
+}
+
+static void  __exit sensor_hmc6352_exit(void)
+{
+	i2c_del_driver(&hmc6352_driver);
+}
+
+module_init(sensor_hmc6352_init);
+module_exit(sensor_hmc6352_exit);
-- 
1.6.0.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
