From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 May 2011 14:47:59 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: Remove pkgtemp driver
Message-Id: <1305902880-11414-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After the merge of pkgtemp functionality into the coretemp driver,
the pkgtemp driver is no longer necessary. Remove it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/hwmon/pkgtemp |   36 ----
 drivers/hwmon/Kconfig       |    7 -
 drivers/hwmon/Makefile      |    1 -
 drivers/hwmon/pkgtemp.c     |  444 -------------------------------------------
 4 files changed, 0 insertions(+), 488 deletions(-)
 delete mode 100644 Documentation/hwmon/pkgtemp
 delete mode 100644 drivers/hwmon/pkgtemp.c

diff --git a/Documentation/hwmon/pkgtemp b/Documentation/hwmon/pkgtemp
deleted file mode 100644
index c8e1fb0..0000000
--- a/Documentation/hwmon/pkgtemp
+++ /dev/null
@@ -1,36 +0,0 @@
-Kernel driver pkgtemp
-===========
-
-Supported chips:
-  * Intel family
-    Prefix: 'pkgtemp'
-    CPUID:
-    Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
-               Volume 3A: System Programming Guide
-
-Author: Fenghua Yu
-
-Description
------------
-
-This driver permits reading package level temperature sensor embedded inside
-Intel CPU package. The sensors can be in core, uncore, memory controller, or
-other components in a package. The feature is first implemented in Intel Sandy
-Bridge platform.
-
-Temperature is measured in degrees Celsius and measurement resolution is
-1 degree C. Valid temperatures are from 0 to TjMax degrees C, because the actual
-value of temperature register is in fact a delta from TjMax.
-
-Temperature known as TjMax is the maximum junction temperature of package.
-We get this from MSR_IA32_TEMPERATURE_TARGET. If the MSR is not accessible,
-we define TjMax as 100 degrees Celsius. At this temperature, protection
-mechanism will perform actions to forcibly cool down the package. Alarm
-may be raised, if the temperature grows enough (more than TjMax) to trigger
-the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
-
-temp1_input	  - Package temperature (in millidegrees Celsius).
-temp1_max        - All cooling devices should be turned on.
-temp1_crit	  - Maximum junction temperature (in millidegrees Celsius).
-temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
-		    Correct CPU operation is no longer guaranteed.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4abd373..43221be 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -408,13 +408,6 @@ config SENSORS_CORETEMP
 	  sensor inside your CPU. Most of the family 6 CPUs
 	  are supported. Check Documentation/hwmon/coretemp for details.
 
-config SENSORS_PKGTEMP
-	tristate "Intel processor package temperature sensor"
-	depends on X86 && EXPERIMENTAL
-	help
-	  If you say yes here you get support for the package level temperature
-	  sensor inside your CPU. Check documentation/driver for details.
-
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"
 	select IPMI_SI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 21c9b17..28e8d52 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
-obj-$(CONFIG_SENSORS_PKGTEMP)	+= pkgtemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
deleted file mode 100644
index 21c817d..0000000
--- a/drivers/hwmon/pkgtemp.c
+++ /dev/null
@@ -1,444 +0,0 @@
-/*
- * pkgtemp.c - Linux kernel module for processor package hardware monitoring
- *
- * Copyright (C) 2010 Fenghua Yu <fenghua.yu@intel.com>
- *
- * Inspired from many hwmon drivers especially coretemp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301 USA.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/jiffies.h>
-#include <linux/hwmon.h>
-#include <linux/sysfs.h>
-#include <linux/hwmon-sysfs.h>
-#include <linux/err.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
-#include <linux/platform_device.h>
-#include <linux/cpu.h>
-#include <asm/msr.h>
-#include <asm/processor.h>
-#include <asm/smp.h>
-
-#define DRVNAME	"pkgtemp"
-
-enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAME };
-
-/*
- * Functions declaration
- */
-
-static struct pkgtemp_data *pkgtemp_update_device(struct device *dev);
-
-struct pkgtemp_data {
-	struct device *hwmon_dev;
-	struct mutex update_lock;
-	const char *name;
-	u32 id;
-	u16 phys_proc_id;
-	char valid;		/* zero until following fields are valid */
-	unsigned long last_updated;	/* in jiffies */
-	int temp;
-	int tjmax;
-	int ttarget;
-	u8 alarm;
-};
-
-/*
- * Sysfs stuff
- */
-
-static ssize_t show_name(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
-{
-	int ret;
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct pkgtemp_data *data = dev_get_drvdata(dev);
-
-	if (attr->index = SHOW_NAME)
-		ret = sprintf(buf, "%s\n", data->name);
-	else	/* show label */
-		ret = sprintf(buf, "physical id %d\n",
-			      data->phys_proc_id);
-	return ret;
-}
-
-static ssize_t show_alarm(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
-{
-	struct pkgtemp_data *data = pkgtemp_update_device(dev);
-	/* read the Out-of-spec log, never clear */
-	return sprintf(buf, "%d\n", data->alarm);
-}
-
-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct pkgtemp_data *data = pkgtemp_update_device(dev);
-	int err = 0;
-
-	if (attr->index = SHOW_TEMP)
-		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
-	else if (attr->index = SHOW_TJMAX)
-		err = sprintf(buf, "%d\n", data->tjmax);
-	else
-		err = sprintf(buf, "%d\n", data->ttarget);
-	return err;
-}
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, SHOW_TEMP);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL, SHOW_TJMAX);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL, SHOW_TTARGET);
-static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
-
-static struct attribute *pkgtemp_attributes[] = {
-	&sensor_dev_attr_name.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	&dev_attr_temp1_crit_alarm.attr,
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group pkgtemp_group = {
-	.attrs = pkgtemp_attributes,
-};
-
-static struct pkgtemp_data *pkgtemp_update_device(struct device *dev)
-{
-	struct pkgtemp_data *data = dev_get_drvdata(dev);
-	unsigned int cpu;
-	int err;
-
-	mutex_lock(&data->update_lock);
-
-	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
-		u32 eax, edx;
-
-		data->valid = 0;
-		cpu = data->id;
-		err = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_STATUS,
-				   &eax, &edx);
-		if (!err) {
-			data->alarm = (eax >> 5) & 1;
-			data->temp = data->tjmax - (((eax >> 16)
-							& 0x7f) * 1000);
-			data->valid = 1;
-		} else
-			dev_dbg(dev, "Temperature data invalid (0x%x)\n", eax);
-
-		data->last_updated = jiffies;
-	}
-
-	mutex_unlock(&data->update_lock);
-	return data;
-}
-
-static int get_tjmax(int cpu, struct device *dev)
-{
-	int default_tjmax = 100000;
-	int err;
-	u32 eax, edx;
-	u32 val;
-
-	/* IA32_TEMPERATURE_TARGET contains the TjMax value */
-	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
-	if (!err) {
-		val = (eax >> 16) & 0xff;
-		if ((val > 80) && (val < 120)) {
-			dev_info(dev, "TjMax is %d C.\n", val);
-			return val * 1000;
-		}
-	}
-	dev_warn(dev, "Unable to read TjMax from CPU.\n");
-	return default_tjmax;
-}
-
-static int __devinit pkgtemp_probe(struct platform_device *pdev)
-{
-	struct pkgtemp_data *data;
-	int err;
-	u32 eax, edx;
-#ifdef CONFIG_SMP
-	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
-#endif
-
-	data = kzalloc(sizeof(struct pkgtemp_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		dev_err(&pdev->dev, "Out of memory\n");
-		goto exit;
-	}
-
-	data->id = pdev->id;
-#ifdef CONFIG_SMP
-	data->phys_proc_id = c->phys_proc_id;
-#endif
-	data->name = "pkgtemp";
-	mutex_init(&data->update_lock);
-
-	/* test if we can access the THERM_STATUS MSR */
-	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_PACKAGE_THERM_STATUS,
-				&eax, &edx);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Unable to access THERM_STATUS MSR, giving up\n");
-		goto exit_free;
-	}
-
-	data->tjmax = get_tjmax(data->id, &pdev->dev);
-	platform_set_drvdata(pdev, data);
-
-	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TARGET,
-				&eax, &edx);
-	if (err) {
-		dev_warn(&pdev->dev, "Unable to read"
-				" IA32_TEMPERATURE_TARGET MSR\n");
-	} else {
-		data->ttarget = data->tjmax - (((eax >> 8) & 0xff) * 1000);
-		err = device_create_file(&pdev->dev,
-				&sensor_dev_attr_temp1_max.dev_attr);
-		if (err)
-			goto exit_free;
-	}
-
-	err = sysfs_create_group(&pdev->dev.kobj, &pkgtemp_group);
-	if (err)
-		goto exit_dev;
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		dev_err(&pdev->dev, "Class registration failed (%d)\n",
-			err);
-		goto exit_class;
-	}
-
-	return 0;
-
-exit_class:
-	sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
-exit_dev:
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
-exit_free:
-	kfree(data);
-exit:
-	return err;
-}
-
-static int __devexit pkgtemp_remove(struct platform_device *pdev)
-{
-	struct pkgtemp_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-	return 0;
-}
-
-static struct platform_driver pkgtemp_driver = {
-	.driver = {
-		.owner = THIS_MODULE,
-		.name = DRVNAME,
-	},
-	.probe = pkgtemp_probe,
-	.remove = __devexit_p(pkgtemp_remove),
-};
-
-struct pdev_entry {
-	struct list_head list;
-	struct platform_device *pdev;
-	unsigned int cpu;
-#ifdef CONFIG_SMP
-	u16 phys_proc_id;
-#endif
-};
-
-static LIST_HEAD(pdev_list);
-static DEFINE_MUTEX(pdev_list_mutex);
-
-static int __cpuinit pkgtemp_device_add(unsigned int cpu)
-{
-	int err;
-	struct platform_device *pdev;
-	struct pdev_entry *pdev_entry;
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
-
-	if (!cpu_has(c, X86_FEATURE_PTS))
-		return 0;
-
-	mutex_lock(&pdev_list_mutex);
-
-#ifdef CONFIG_SMP
-	/* Only keep the first entry in each package */
-	list_for_each_entry(pdev_entry, &pdev_list, list) {
-		if (c->phys_proc_id = pdev_entry->phys_proc_id) {
-			err = 0;        /* Not an error */
-			goto exit;
-		}
-	}
-#endif
-
-	pdev = platform_device_alloc(DRVNAME, cpu);
-	if (!pdev) {
-		err = -ENOMEM;
-		pr_err("Device allocation failed\n");
-		goto exit;
-	}
-
-	pdev_entry = kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
-	if (!pdev_entry) {
-		err = -ENOMEM;
-		goto exit_device_put;
-	}
-
-	err = platform_device_add(pdev);
-	if (err) {
-		pr_err("Device addition failed (%d)\n", err);
-		goto exit_device_free;
-	}
-
-#ifdef CONFIG_SMP
-	pdev_entry->phys_proc_id = c->phys_proc_id;
-#endif
-	pdev_entry->pdev = pdev;
-	pdev_entry->cpu = cpu;
-	list_add_tail(&pdev_entry->list, &pdev_list);
-	mutex_unlock(&pdev_list_mutex);
-
-	return 0;
-
-exit_device_free:
-	kfree(pdev_entry);
-exit_device_put:
-	platform_device_put(pdev);
-exit:
-	mutex_unlock(&pdev_list_mutex);
-	return err;
-}
-
-static void __cpuinit pkgtemp_device_remove(unsigned int cpu)
-{
-	struct pdev_entry *p;
-	unsigned int i;
-	int err;
-
-	mutex_lock(&pdev_list_mutex);
-	list_for_each_entry(p, &pdev_list, list) {
-		if (p->cpu != cpu)
-			continue;
-
-		platform_device_unregister(p->pdev);
-		list_del(&p->list);
-		mutex_unlock(&pdev_list_mutex);
-		kfree(p);
-		for_each_cpu(i, cpu_core_mask(cpu)) {
-			if (i != cpu) {
-				err = pkgtemp_device_add(i);
-				if (!err)
-					break;
-			}
-		}
-		return;
-	}
-	mutex_unlock(&pdev_list_mutex);
-}
-
-static int __cpuinit pkgtemp_cpu_callback(struct notifier_block *nfb,
-				 unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (unsigned long) hcpu;
-
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		pkgtemp_device_add(cpu);
-		break;
-	case CPU_DOWN_PREPARE:
-		pkgtemp_device_remove(cpu);
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block pkgtemp_cpu_notifier __refdata = {
-	.notifier_call = pkgtemp_cpu_callback,
-};
-
-static int __init pkgtemp_init(void)
-{
-	int i, err = -ENODEV;
-
-	/* quick check if we run Intel */
-	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)
-		goto exit;
-
-	err = platform_driver_register(&pkgtemp_driver);
-	if (err)
-		goto exit;
-
-	for_each_online_cpu(i)
-		pkgtemp_device_add(i);
-
-#ifndef CONFIG_HOTPLUG_CPU
-	if (list_empty(&pdev_list)) {
-		err = -ENODEV;
-		goto exit_driver_unreg;
-	}
-#endif
-
-	register_hotcpu_notifier(&pkgtemp_cpu_notifier);
-	return 0;
-
-#ifndef CONFIG_HOTPLUG_CPU
-exit_driver_unreg:
-	platform_driver_unregister(&pkgtemp_driver);
-#endif
-exit:
-	return err;
-}
-
-static void __exit pkgtemp_exit(void)
-{
-	struct pdev_entry *p, *n;
-
-	unregister_hotcpu_notifier(&pkgtemp_cpu_notifier);
-	mutex_lock(&pdev_list_mutex);
-	list_for_each_entry_safe(p, n, &pdev_list, list) {
-		platform_device_unregister(p->pdev);
-		list_del(&p->list);
-		kfree(p);
-	}
-	mutex_unlock(&pdev_list_mutex);
-	platform_driver_unregister(&pkgtemp_driver);
-}
-
-MODULE_AUTHOR("Fenghua Yu <fenghua.yu@intel.com>");
-MODULE_DESCRIPTION("Intel processor package temperature monitor");
-MODULE_LICENSE("GPL");
-
-module_init(pkgtemp_init)
-module_exit(pkgtemp_exit)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
