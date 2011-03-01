From: Keerthy <j-keerthy@ti.com>
Date: Tue, 01 Mar 2011 13:54:36 +0000
Subject: [lm-sensors] [PATCH 2/2 v5] hwmon: twl4030: Hwmon Driver for
Message-Id: <1298986956-31255-1-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com
Cc: mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, j-keerthy@ti.com, linux-omap@vger.kernel.org

This driver exposes the sysfs nodes of the TWL4030 MADC module.
All the voltage channel values are expressed in terms of mV. Channel 13
and channel 14 are reserved. There are channels which represent
temperature and current the output is represented by celcius
and mA respectively.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

V5:
Included the required header files which were indirectly
included through other header files.

V4:
No Change

V3:
Corrected channel 15 index

V2:
Changed the names of the sysfs attributes compliant to current,
voltage and temperature attributes.

V1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg44542.html

 Documentation/hwmon/twl4030-madc-hwmon |   45 +++++++++
 drivers/hwmon/Kconfig                  |   10 ++
 drivers/hwmon/Makefile                 |    1 +
 drivers/hwmon/twl4030-madc-hwmon.c     |  157 ++++++++++++++++++++++++++++++++
 4 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
 create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c

diff --git a/Documentation/hwmon/twl4030-madc-hwmon b/Documentation/hwmon/twl4030-madc-hwmon
new file mode 100644
index 0000000..ef79843
--- /dev/null
+++ b/Documentation/hwmon/twl4030-madc-hwmon
@@ -0,0 +1,45 @@
+Kernel driver twl4030-madc
+============+
+Supported chips:
+	* Texas Instruments TWL4030
+	Prefix: 'twl4030-madc'
+
+
+Authors:
+	J Keerthy <j-keerthy@ti.com>
+
+Description
+-----------
+
+The Texas Instruments TWL4030 is a Power Management and Audio Circuit. Among
+other things it contains a 10-bit A/D converter MADC. The converter has 16
+channels which can be used in different modes.
+
+
+See this table for the meaning of the different channels
+
+Channel Signal
+------------------------------------------
+0	Battery type(BTYPE)
+1	BCI: Battery temperature (BTEMP)
+2	GP analog input
+3	GP analog input
+4	GP analog input
+5	GP analog input
+6	GP analog input
+7	GP analog input
+8	BCI: VBUS voltage(VBUS)
+9	Backup Battery voltage (VBKP)
+10	BCI: Battery charger current (ICHG)
+11	BCI: Battery charger voltage (VCHG)
+12	BCI: Main battery voltage (VBAT)
+13	Reserved
+14	Reserved
+15	VRUSB Supply/Speaker left/Speaker right polarization level
+
+
+The Sysfs nodes will represent the voltage in the units of mV,
+the temperature channel shows the converted temperature in
+degree celcius. The Battery charging current channel represents
+battery charging current in mA.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 297bc9a..cb3d895 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -941,6 +941,16 @@ config SENSORS_TMP421
 	  This driver can also be built as a module.  If so, the module
 	  will be called tmp421.
 
+config SENSORS_TWL4030_MADC
+	tristate "Texas Instruments TWL4030 MADC Hwmon"
+	depends on TWL4030_MADC
+	help
+	If you say yes here you get hwmon support for triton
+	TWL4030-MADC.
+
+	This driver can also be built as a module. If so it will be called
+	twl4030-madc-hwmon.
+
 config SENSORS_VIA_CPUTEMP
 	tristate "VIA CPU temperature sensor"
 	depends on X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index dde02d9..bc7d740 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
+obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
new file mode 100644
index 0000000..97e22be
--- /dev/null
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -0,0 +1,157 @@
+/*
+ *
+ * TWL4030 MADC Hwmon driver-This driver monitors the real time
+ * conversion of analog signals like battery temperature,
+ * battery type, battery level etc. User can ask for the conversion on a
+ * particular channel using the sysfs nodes.
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * J Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c/twl.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030-madc.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/stddef.h>
+#include <linux/sysfs.h>
+#include <linux/err.h>
+#include <linux/types.h>
+
+/*
+ * sysfs hook function
+ */
+static ssize_t madc_read(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct twl4030_madc_request req;
+	long val;
+
+	req.channels = (1 << attr->index);
+	req.method = TWL4030_MADC_SW2;
+	req.func_cb = NULL;
+	val = twl4030_madc_conversion(&req);
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "%d\n", req.rbuf[attr->index]);
+}
+
+/* sysfs nodes to read individual channels from user side */
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, madc_read, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, madc_read, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, madc_read, NULL, 8);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, madc_read, NULL, 9);
+static SENSOR_DEVICE_ATTR(curr10_input, S_IRUGO, madc_read, NULL, 10);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
+static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
+static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
+
+static struct attribute *twl4030_madc_attributes[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_curr10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_in15_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group twl4030_madc_group = {
+	.attrs = twl4030_madc_attributes,
+};
+
+static int __devinit twl4030_madc_hwmon_probe(struct platform_device *pdev)
+{
+	int ret;
+	int status;
+	struct device *hwmon;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_group);
+	if (ret)
+		goto err_sysfs;
+	hwmon = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(hwmon)) {
+		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
+		status = PTR_ERR(hwmon);
+		goto err_reg;
+	}
+
+	return 0;
+
+err_reg:
+	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
+err_sysfs:
+
+	return ret;
+}
+
+static int __devexit twl4030_madc_hwmon_remove(struct platform_device *pdev)
+{
+	hwmon_device_unregister(&pdev->dev);
+	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
+
+	return 0;
+}
+
+static struct platform_driver twl4030_madc_hwmon_driver = {
+	.probe = twl4030_madc_hwmon_probe,
+	.remove = __exit_p(twl4030_madc_hwmon_remove),
+	.driver = {
+		   .name = "twl4030_madc_hwmon",
+		   .owner = THIS_MODULE,
+		   },
+};
+
+static int __init twl4030_madc_hwmon_init(void)
+{
+	return platform_driver_register(&twl4030_madc_hwmon_driver);
+}
+
+module_init(twl4030_madc_hwmon_init);
+
+static void __exit twl4030_madc_hwmon_exit(void)
+{
+	platform_driver_unregister(&twl4030_madc_hwmon_driver);
+}
+
+module_exit(twl4030_madc_hwmon_exit);
+
+MODULE_DESCRIPTION("TWL4030 ADC Hwmon driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("J Keerthy");
+MODULE_ALIAS("twl4030_madc_hwmon");
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
