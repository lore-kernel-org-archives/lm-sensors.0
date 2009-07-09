From: lu zhihe <tombowfly@gmail.com>
Date: Thu, 09 Jul 2009 13:41:38 +0000
Subject: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965
Message-Id: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Lu Zhihe <tombowfly@gmail.com>

Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.

Exported the graphics hot spot temperature report via sysfs.

Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
---


Add GM/GME965 IGP temperature report for hwmon.

The GM/GME965 datasheet can get from:
http://www.intel.com/Assets/PDF/datasheet/316273.pdf

The Calibration Fomula comes from a earlier version:
http://www.intel.com/design/chipsets/datashts/313053.htm
Page 358.


diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig
linux-2.6.31-rc2/drivers/hwmon/Kconfig
--- linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig	2009-07-08
23:26:56.000000000 +0000
+++ linux-2.6.31-rc2/drivers/hwmon/Kconfig	2009-07-08 22:49:37.000000000 +0000
@@ -401,6 +401,16 @@ config SENSORS_GL520SM
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl520sm.

+config SENSORS_GM965
+        tristate "Intel GM965 temperature sensor"
+        depends on PCI
+        help
+          If you say yes here you get support for GM965 IGP temperatue
+          sensor.
+
+          This driver can also be built as a module.  If so, the module
+          will be called gm965temp.
+
 config SENSORS_CORETEMP
 	tristate "Intel Core (2) Duo/Solo temperature sensor"
 	depends on X86 && EXPERIMENTAL
diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Makefile
linux-2.6.31-rc2/drivers/hwmon/Makefile
--- linux-2.6.31-rc2.orig/drivers/hwmon/Makefile	2009-07-08
23:27:07.000000000 +0000
+++ linux-2.6.31-rc2/drivers/hwmon/Makefile	2009-07-08 22:48:02.000000000 +0000
@@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_SENSORS_GM965)	+= gm965temp.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c
linux-2.6.31-rc2/drivers/hwmon/gm965temp.c
--- linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c	1970-01-01
00:00:00.000000000 +0000
+++ linux-2.6.31-rc2/drivers/hwmon/gm965temp.c	2009-07-09
20:25:12.000000000 +0000
@@ -0,0 +1,348 @@
+/*
+ * A hwmon driver for the Intel GM/GME965 chipset IGP
+ * temperature sensors
+ *
+ * Copyright (C) 2009 Lu Zhihe <tombowfly at gmail.com>
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#define DRVNAME "gm965temp"
+
+enum { SHOW_TEMP, SHOW_LABEL } SHOW;
+
+#define PCI_DEVICE_ID_INTEL_82965GM       0x2a00
+#define PCI_DEVICE_ID_INTEL_82965GME      0x2a10
+#define GM965_SYSFS_NAME_LEN              16
+
+#define MCHBAR_I965 0x48      /* MCH Memory Mapped Register BAR */
+#define MCHBAR_MASK 0xfffffc000ULL  /* bits 35:14 */
+
+static ssize_t show_label(struct device *dev,
+		struct device_attribute *devattr,
+		char *buf);
+
+static ssize_t show_igp_temp(struct device *dev,
+				struct device_attribute *devattr,
+				char *buf);
+
+struct gm965temp_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+
+	u64 igp_base;
+	unsigned long igp_len;
+	void __iomem *igp_mmio;
+	unsigned long chipset_id;
+};
+
+static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
+{
+	return sprintf(buf, "%s\n", DRVNAME);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_igp_temp, NULL,
SHOW_TEMP);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, SHOW_LABEL);
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static struct attribute *gm965temp_attributes[] = {
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group gm965temp_group = {
+	.attrs = gm965temp_attributes,
+};
+
+static struct platform_device *igp_pdev;
+
+static u8 igp_read_byte(struct gm965temp_data *data, unsigned long offset)
+{
+	return ioread8(data->igp_mmio + offset);
+}
+
+static u16 igp_read_short(struct gm965temp_data *data, unsigned long offset)
+{
+	return ioread16(data->igp_mmio + offset);
+}
+
+static void igp_write_short(struct gm965temp_data *data, unsigned long offset,
+				u16 val)
+{
+	iowrite16(val, data->igp_mmio + offset);
+}
+
+static ssize_t show_label(struct device *dev,
+		struct device_attribute *devattr,
+		char *buf)
+{
+	return sprintf(buf, "GM965 IGP temperature report\n");
+}
+
+#define TSC1	0x1001
+#define TSS1	0x1004
+#define TR1	0x1006
+
+#define TSE	0x8000
+#define TMOV	(0x01 << 10)
+
+#define MAX_RETRIS  3
+
+static ssize_t show_igp_temp(struct device *dev,
+				struct device_attribute *devattr,
+				char *buf)
+{
+	struct gm965temp_data *data = dev_get_drvdata(dev);
+	unsigned short tsc1_val = 0;
+	unsigned char  tr1_val = 0;
+	unsigned short tss1_val = 0;
+	unsigned long temp = 0;
+	int i = 0;
+	i = MAX_RETRIS;
+
+	mutex_lock(&data->update_lock);
+
+	tsc1_val = igp_read_short(data, TSC1);
+
+	if (!(tsc1_val & TSE)) {
+		igp_write_short(data, TSC1, tsc1_val|TSE);
+		tsc1_val = igp_read_short(data, TSC1);
+	} else {
+try_againt:
+		tss1_val = igp_read_short(data, TSS1);
+
+		if (tss1_val & TMOV) {
+			tr1_val = igp_read_byte(data, TR1);
+		if ((tr1_val != 0xFF) && (tr1_val != 0x0))
+			temp = (16*tr1_val*tr1_val - 11071*tr1_val + 1610500)
+				/10;
+		} else {
+			do {
+				mdelay(1);
+				udelay(300);
+				goto try_againt;
+			} while (i--);
+		}
+	}
+
+	mutex_unlock(&data->update_lock);
+	return sprintf(buf, "%d\n", (unsigned int)temp);
+}
+
+static int __devinit gm965temp_hwmon_init(struct platform_device *pdev)
+{
+	int res = 0;
+	struct gm965temp_data *data = platform_get_drvdata(pdev);
+
+	res = device_create_file(&pdev->dev, &dev_attr_name);
+	if (res)
+		goto exit_remove;
+
+	res = sysfs_create_group(&pdev->dev.kobj, &gm965temp_group);
+	if (res)
+		goto exit_dev;
+
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	return res;
+
+exit_remove:
+	sysfs_remove_group(&pdev->dev.kobj, &gm965temp_group);
+exit_dev:
+	device_remove_file(&pdev->dev, &dev_attr_name);
+
+	return res;
+}
+
+static int __devinit gm965temp_add(void)
+{
+	int res = -ENODEV;
+
+	/* only ever going to be one of these */
+	igp_pdev = platform_device_alloc(DRVNAME, 0);
+	if (!igp_pdev)
+		return -ENOMEM;
+
+	res = platform_device_add(igp_pdev);
+	if (res)
+		goto err;
+	return 0;
+
+err:
+	platform_device_put(igp_pdev);
+	return res;
+}
+
+static int __devinit gm965_find_igp_registers(struct gm965temp_data *data,
+					    unsigned long devid)
+{
+	struct pci_dev *pcidev;
+	u32 val32;
+	u64 val64 = 0x0ULL;
+	int res = -ENODEV;
+
+	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+				devid,
+				NULL);
+	if (!pcidev) {
+		printk(KERN_ERR "pci_get_device failed\n");
+		return -ENODEV;
+	}
+
+	if (pci_read_config_dword(pcidev, MCHBAR_I965 + 4, &val32))
+		goto out;
+	val64 = (u64)val32;
+	val64 <<= 32;
+	if (pci_read_config_dword(pcidev, MCHBAR_I965, &val32))
+		goto out;
+
+	val64 |= val32;
+	data->igp_base = val64 & MCHBAR_MASK;
+	data->igp_len = 16*1024;
+
+	data->chipset_id = devid;
+
+	res = 0;
+out:
+	pci_dev_put(pcidev);
+	return res;
+}
+
+static unsigned long chipset_ids[] = {
+	PCI_DEVICE_ID_INTEL_82965GM,
+	PCI_DEVICE_ID_INTEL_82965GME,
+	0
+};
+
+static int __devinit gm965temp_probe(struct platform_device *pdev)
+{
+	struct gm965temp_data *data;
+	struct resource *reso;
+	int i;
+	int res = -ENODEV;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i = 0;
+	do {
+		res = gm965_find_igp_registers(data, chipset_ids[i]);
+		i++;
+	} while (res && chipset_ids[i]);
+
+	if (res)
+		goto err;
+	/* Set up resource regions */
+	reso = request_mem_region(data->igp_base, data->igp_len, DRVNAME);
+	if (!reso) {
+		printk(KERN_ERR "request_mem_region failed\n");
+		res = -EBUSY;
+		goto err;
+	}
+
+	data->igp_mmio = ioremap_nocache(data->igp_base, data->igp_len);
+	if (!data->igp_mmio) {
+		printk(KERN_ERR "ioremap_nocache failed\n");
+		res = -EBUSY;
+		goto err_map_failed;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	mutex_init(&data->update_lock);
+
+	res = gm965temp_hwmon_init(pdev);
+	if (res)
+		goto err_init_failed;
+
+	return res;
+
+err_init_failed:
+	iounmap(data->igp_mmio);
+	platform_set_drvdata(pdev, NULL);
+err_map_failed:
+	release_mem_region(data->igp_base, data->igp_len);
+err:
+	kfree(data);
+	return res;
+}
+
+static int __devexit gm965temp_remove(struct platform_device *pdev)
+{
+	struct gm965temp_data *data = platform_get_drvdata(pdev);
+	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+
+	iounmap(data->igp_mmio);
+	release_mem_region(data->igp_base, data->igp_len);
+	platform_set_drvdata(pdev, NULL);
+	kfree(data);
+	return 0;
+}
+
+static struct platform_driver gm965temp_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRVNAME,
+	},
+	.probe = gm965temp_probe,
+	.remove = __devexit_p(gm965temp_remove),
+};
+
+static int __init gm965temp_init(void)
+{
+	int res;
+
+	res = platform_driver_register(&gm965temp_driver);
+	if (res)
+		return res;
+
+	res = gm965temp_add();
+	if (res)
+		platform_driver_unregister(&gm965temp_driver);
+
+	return res;
+}
+
+static void __exit gm965temp_exit(void)
+{
+	platform_device_unregister(igp_pdev);
+	platform_driver_unregister(&gm965temp_driver);
+}
+
+MODULE_AUTHOR("Lu Zhihe");
+MODULE_DESCRIPTION("Intel GM965 chipset IGP temperature sensor");
+MODULE_LICENSE("GPL");
+
+module_init(gm965temp_init);
+module_exit(gm965temp_exit);
+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
