From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Mon, 05 Oct 2009 11:44:14 +0000
Subject: [lm-sensors] I2C support STMicroeletronics LIS302Dx three-axis
Message-Id: <20091005222838.GA10236@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090917215312.GA6974@intel.com>
In-Reply-To: <20090917215312.GA6974@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From 49fc14f67760c6f5ba0d3f33538af948f87c7b66 Mon Sep 17 00:00:00 2001
From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Mon, 5 Oct 2009 18:22:33 -0400
Subject: [PATCH] I2C glue layer for lis3lv02d STMicroelectronics digital accelerometer
This patch will support I2C interface for ST Macroelectronics 3 axis digital accelerometer.

Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
---
 drivers/hwmon/Kconfig         |   14 ++++++
 drivers/hwmon/Makefile        |    1 +
 drivers/hwmon/lis3lv02d_i2c.c |  103 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100755 drivers/hwmon/lis3lv02d_i2c.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6857560..c5e2760 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -983,6 +983,20 @@ config SENSORS_LIS3_SPI
 	  will be called lis3lv02d and a specific module for the SPI transport
 	  is called lis3lv02d_spi.
 
+config SENSORS_LIS3_I2C
+	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
+	depends on I2C && INPUT
+	select INPUT_POLLDEV
+	default n
+	help
+	  This driver provides support for the LIS3LV02Dx accelerometer connected
+	  via I2C. The accelerometer data is readable via
+	  /sys/devices/platform/lis3lv02d.
+
+	  This driver can also be built as modules.  If so, the core module
+	  will be called lis3lv02d and a specific module for the I2C transport
+	  is called lis3lv02d_i2c.
+
 config SENSORS_APPLESMC
 	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
 	depends on INPUT && X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9f46cb0..cc2c12d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
 obj-$(CONFIG_SENSORS_LIS3_SPI)	+= lis3lv02d.o lis3lv02d_spi.o
+obj-$(CONFIG_SENSORS_LIS3_I2C)	+= lis3lv02d.o lis3lv02d_i2c.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
 obj-$(CONFIG_SENSORS_LM70)	+= lm70.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
new file mode 100755
index 0000000..0be5cd0
--- /dev/null
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -0,0 +1,103 @@
+/*
+ * lis3lv02d_i2c - I2C glue layer for LIS[32]02DL varients
+ *
+ * Copyright (c) 2009  Kalhan Trisal <kalhan.trisal@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include "lis3lv02d.h"
+
+
+static int lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
+{
+	int ret;
+	ret = i2c_smbus_read_byte_data(lis3->bus_priv, reg);
+
+	*v = (u8) ret;
+	return ret;
+}
+
+static int lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 val)
+{
+
+	return  i2c_smbus_write_byte_data(lis3->bus_priv, reg, val);
+}
+
+static int lis3_i2c_init(struct lis3lv02d *lis3)
+{
+	u8 reg;
+	int ret;
+
+	/* power up the device */
+	ret = lis3->read(lis3, CTRL_REG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	reg |= CTRL1_PD0;
+	return lis3->write(lis3, CTRL_REG1, reg);
+}
+
+static struct axis_conversion lis3lv02d_axis_normal = { 1, 2, 3 };
+
+static int  lis302dl_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	lis3_dev.bus_priv = client;
+	lis3_dev.init = lis3_i2c_init;
+	lis3_dev.read = lis3_i2c_read;
+	lis3_dev.write = lis3_i2c_write;
+	lis3_dev.irq = client->irq;
+	lis3_dev.ac = lis3lv02d_axis_normal;
+	lis3_dev.pdata = client->dev.platform_data;
+	i2c_set_clientdata(client, &lis3_dev);
+	return lis3lv02d_init_device(&lis3_dev);
+}
+
+static int lis302dl_remove(struct i2c_client *client)
+{
+	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
+	lis3lv02d_joystick_disable();
+	lis3lv02d_poweroff(lis3);
+	return 0;
+}
+
+static struct i2c_device_id lis302dl_id[] = {
+	{ "lis302dl", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, lis302dl_id);
+
+static struct i2c_driver lis302dl_driver = {
+	.driver = {
+	.name = "lis302dl_i2c",
+	},
+	.probe = lis302dl_probe,
+	.remove = lis302dl_remove,
+	.id_table = lis302dl_id,
+};
+
+static int __init sensor_lis302dl_init(void)
+{
+	return  i2c_add_driver(&lis302dl_driver);
+}
+
+static void  __exit sensor_lis302dl_exit(void)
+{
+	i2c_del_driver(&lis302dl_driver);
+}
+
+module_init(sensor_lis302dl_init);
+module_exit(sensor_lis302dl_exit);
+
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com>");
+MODULE_DESCRIPTION("LIS[32]02DL I2C glue layer");
+MODULE_LICENSE("GPL");
+
-- 
1.6.0.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
