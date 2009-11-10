From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 10 Nov 2009 08:08:16 +0000
Subject: [lm-sensors] [PATCH] k10temp: temperature sensor for AMD Family
Message-Id: <4AF91F70.10106@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This adds a driver for the internal temperature sensor of AMD Family 10h
and 11h CPUs.

The driver correctly detects Family 10h CPUs that do not have a reliable
sensor (erratum 319).

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
I did not merge this driver into k8temp because the K10 sensor interface
is completely different from the K8 one; there wouldn't actually be any
common code worth sharing.

--- linux-2.6/drivers/hwmon/Kconfig
+++ linux-2.6/drivers/hwmon/Kconfig
@@ -222,6 +222,18 @@ config SENSORS_K8TEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called k8temp.
 
+config SENSORS_K10TEMP
+	tristate "AMD Phenom/Sempron/Turion/Opteron temperature sensor"
+	depends on X86 && PCI
+	help
+	  If you say yes here you get support for the temperature
+	  sensor(s) inside your CPU. Supported are later revisions of
+	  the AMD Family 10h and all revisions of the AMD Family 11h
+	  microarchitectures.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called k10temp.
+
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
 	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
--- linux-2.6/drivers/hwmon/Makefile
+++ linux-2.6/drivers/hwmon/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
+obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
 obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
 obj-$(CONFIG_SENSORS_LIS3_SPI)	+= lis3lv02d.o lis3lv02d_spi.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
--- /dev/null
+++ linux-2.6/drivers/hwmon/k10temp.c
@@ -0,0 +1,140 @@
+/*
+ * k10temp.c - AMD Family 10h/11h hardware monitoring
+ *
+ * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *
+ * AMD documentation (see <http://developer.amd.com/documentation/guides/>):
+ * #31116: BIOS and Kernel Developer's Guide For AMD Family 10h Processors
+ * #41256: BIOS and Kernel Developer's Guide For AMD Family 11h Processors
+ * #41322: Revision Guide for AMD Family 10h Processors
+ * #41788: Revision Guide for AMD Family 11h Processors
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/processor.h>
+
+MODULE_DESCRIPTION("AMD Family 10h/11h CPU core temperature monitor");
+MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_LICENSE("GPL");
+
+#define REG_REPORTED_TEMPERATURE	0xa4
+#define CURTMP_TO_MILLIDEGREES(regval)	(((regval) >> 21) * (1000 / 8))
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	u32 regval;
+
+	pci_read_config_dword(to_pci_dev(dev),
+			      REG_REPORTED_TEMPERATURE, &regval);
+	return sprintf(buf, "%u\n", CURTMP_TO_MILLIDEGREES(regval));
+}
+
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "k10temp\n");
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static bool __devinit has_erratum_319(void)
+{
+	/*
+	 * Erratum 319: The thermal sensor of older Family 10h processors
+	 *              (B steppings) is unreliable.
+	 */
+	return boot_cpu_data.x86 = 0x10 && boot_cpu_data.x86_model <= 2;
+}
+
+static int __devinit k10temp_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *id)
+{
+	struct device *hwmon_dev;
+	int err;
+
+	if (has_erratum_319()) {
+		err = -ENODEV;
+		goto error;
+	}
+
+	err = device_create_file(&pdev->dev,
+				 &sensor_dev_attr_temp1_input.dev_attr);
+	if (err)
+		goto error;
+
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
+		goto error_remove1;
+
+	hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		goto error_remove2;
+	}
+
+	dev_set_drvdata(&pdev->dev, hwmon_dev);
+	return 0;
+
+error_remove2:
+	device_remove_file(&pdev->dev, &dev_attr_name);
+error_remove1:
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_input.dev_attr);
+error:
+	return err;
+}
+
+static void __devexit k10temp_remove(struct pci_dev *pdev)
+{
+	hwmon_device_unregister(dev_get_drvdata(&pdev->dev));
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static struct pci_device_id k10temp_id_table[] = {
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, k10temp_id_table);
+
+static struct pci_driver k10temp_driver = {
+	.name = "k10temp",
+	.id_table = k10temp_id_table,
+	.probe = k10temp_probe,
+	.remove = __devexit_p(k10temp_remove),
+};
+
+static int __init k10temp_init(void)
+{
+	return pci_register_driver(&k10temp_driver);
+}
+
+static void __exit k10temp_exit(void)
+{
+	pci_unregister_driver(&k10temp_driver);
+}
+
+module_init(k10temp_init)
+module_exit(k10temp_exit)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
