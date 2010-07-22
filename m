From: Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 22 Jul 2010 16:21:57 +0000
Subject: [lm-sensors] [PATCH 2/5] Package Level Thermal Control and Power
Message-Id: <20100722162157.GA21512@linux-os.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <94E56C79ECC49A4B87113985F1FEBA8D03F8AE2A4B@bgsmsx502.gar.corp.intel.com> <4C485DF1.5050407@linux.intel.com>
In-Reply-To: <4C485DF1.5050407@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Huaxu Wan <huaxu.wan@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

This patch adds a hwmon driver for package level thermal control. The driver
dumps package level thermal information through sysfs interface so that upp=
er
level application (e.g. lm_sensor) can retrive the information.

Instead of having the package level hwmon code in coretemp, I write a seper=
ate
driver pkgtemp because:

First, package level thermal sensors include not only sensors for each core,
but also sensors for uncore, memory controller or other components in the
package. Logically it will be clear to have a seperate hwmon driver for pac=
kage
level hwmon to monitor wider range of sensors in a package. Merging package
thermal driver into core thermal driver doesn't make sense and may mislead.

Secondly, merging the two drivers together may cause coding mess. It's easi=
er
to include various package level sensors info if more sensor information is
implemented. Coretemp code needs to consider a lot of legacy machine cases.
Pkgtemp code only considers platform starting from Sandy Bridge.

On a 1Sx4Cx2T Sandy Bridge platform, lm-sensors dumps the pkgtemp and coret=
emp:

pkgtemp-isa-0000
Adapter: ISA adapter
Physical package id 0: +33.0=B0C  (high =3D +79.0=B0C, crit =3D +99.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +32.0=B0C  (high =3D +79.0=B0C, crit =3D +99.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +32.0=B0C  (high =3D +79.0=B0C, crit =3D +99.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +32.0=B0C  (high =3D +79.0=B0C, crit =3D +99.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +32.0=B0C  (high =3D +79.0=B0C, crit =3D +99.0=B0C)

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---

 arch/x86/configs/i386_defconfig   |    1=20
 arch/x86/configs/x86_64_defconfig |    1=20
 drivers/hwmon/Kconfig             |    7=20
 drivers/hwmon/Makefile            |    1=20
 drivers/hwmon/pkgtemp.c           |  456 +++++++++++++++++++++++++++++++++=
+++++
 5 files changed, 466 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defcon=
fig
index d28fad1..e3a3243 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1471,6 +1471,7 @@ CONFIG_HWMON=3Dy
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_CORETEMP is not set
+# CONFIG_SENSORS_PKGTEMP is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 # CONFIG_SENSORS_LM75 is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_de=
fconfig
index 6c86acd..4251f83 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1456,6 +1456,7 @@ CONFIG_HWMON=3Dy
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_CORETEMP is not set
+# CONFIG_SENSORS_PKGTEMP is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 # CONFIG_SENSORS_LM75 is not set
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e19cf8e..3a858e8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -407,6 +407,13 @@ config SENSORS_CORETEMP
 	  sensor inside your CPU. Most of the family 6 CPUs
 	  are supported. Check documentation/driver for details.
=20
+config SENSORS_PKGTEMP
+	tristate "Intel processor package temperature sensor"
+	depends on X86 && PCI && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the package level temperature
+	  sensor inside your CPU. Check documentation/driver for details.
+
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"
 	select IPMI_SI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2138ceb..879814e 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_AMS)	+=3D ams/
 obj-$(CONFIG_SENSORS_ASC7621)	+=3D asc7621.o
 obj-$(CONFIG_SENSORS_ATXP1)	+=3D atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+=3D coretemp.o
+obj-$(CONFIG_SENSORS_PKGTEMP)	+=3D pkgtemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+=3D dme1737.o
 obj-$(CONFIG_SENSORS_DS1621)	+=3D ds1621.o
 obj-$(CONFIG_SENSORS_EMC1403)	+=3D emc1403.o
diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
new file mode 100644
index 0000000..fcfe2df
--- /dev/null
+++ b/drivers/hwmon/pkgtemp.c
@@ -0,0 +1,456 @@
+/*
+ * pkgtemp.c - Linux kernel module for processor package hardware monitori=
ng
+ *
+ * Copyright (C) 2010 Fenghua Yu <fenghua.yu@intel.com>
+ *
+ * Inspired from many hwmon drivers especially coretemp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/sysfs.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/cpu.h>
+#include <linux/pci.h>
+#include <asm/msr.h>
+#include <asm/processor.h>
+
+#define DRVNAME	"pkgtemp"
+
+enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAME } SHOW;
+
+/*
+ * Functions declaration
+ */
+
+static struct pkgtemp_data *pkgtemp_update_device(struct device *dev);
+
+struct pkgtemp_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	const char *name;
+	u32 id;
+	u16 phys_proc_id;
+	char valid;		/* zero until following fields are valid */
+	unsigned long last_updated;	/* in jiffies */
+	int temp;
+	int tjmax;
+	int ttarget;
+	u8 alarm;
+};
+
+/*
+ * Sysfs stuff
+ */
+
+static ssize_t show_name(struct device *dev, struct device_attribute
+			  *devattr, char *buf)
+{
+	int ret;
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct pkgtemp_data *data =3D dev_get_drvdata(dev);
+
+	if (attr->index =3D SHOW_NAME)
+		ret =3D sprintf(buf, "%s\n", data->name);
+	else	/* show label */
+		ret =3D sprintf(buf, "Physical package id %d\n",
+			      data->phys_proc_id);
+	return ret;
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute
+			  *devattr, char *buf)
+{
+	struct pkgtemp_data *data =3D pkgtemp_update_device(dev);
+	/* read the Out-of-spec log, never clear */
+	return sprintf(buf, "%d\n", data->alarm);
+}
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct pkgtemp_data *data =3D pkgtemp_update_device(dev);
+	int err =3D 0;
+
+	if (attr->index =3D SHOW_TEMP)
+		err =3D data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
+	else if (attr->index =3D SHOW_TJMAX)
+		err =3D sprintf(buf, "%d\n", data->tjmax);
+	else
+		err =3D sprintf(buf, "%d\n", data->ttarget);
+	return err;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, SHOW_TEMP=
);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL, SHOW_TJMAX=
);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL, SHOW_TTARGE=
T);
+static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABE=
L);
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
+
+static struct attribute *pkgtemp_attributes[] =3D {
+	&sensor_dev_attr_name.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&dev_attr_temp1_crit_alarm.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group pkgtemp_group =3D {
+	.attrs =3D pkgtemp_attributes,
+};
+
+static struct pkgtemp_data *pkgtemp_update_device(struct device *dev)
+{
+	struct pkgtemp_data *data =3D dev_get_drvdata(dev);
+	unsigned int cpu;
+	int err;
+
+	mutex_lock(&data->update_lock);
+
+	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
+		u32 eax, edx;
+
+		data->valid =3D 0;
+		cpu =3D data->id;
+		err =3D rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_STATUS,
+				   &eax, &edx);
+		if (!err) {
+			data->alarm =3D (eax >> 5) & 1;
+			data->temp =3D data->tjmax - (((eax >> 16)
+							& 0x7f) * 1000);
+			data->valid =3D 1;
+		} else
+			dev_dbg(dev, "Temperature data invalid (0x%x)\n", eax);
+
+		data->last_updated =3D jiffies;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+static int get_tjmax(int cpu, struct device *dev)
+{
+	int default_tjmax =3D 100000;
+	int err;
+	u32 eax, edx;
+	u32 val;
+
+	/* IA32_TEMPERATURE_TARGET contains the TjMax value */
+	err =3D rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+	if (!err) {
+		val =3D (eax >> 16) & 0xff;
+		if ((val > 80) && (val < 120)) {
+			dev_info(dev, "TjMax is %d C.\n", val);
+			return val * 1000;
+		}
+	}
+	dev_warn(dev, "Unable to read TjMax from CPU.\n");
+	return default_tjmax;
+}
+
+static int __devinit pkgtemp_probe(struct platform_device *pdev)
+{
+	struct pkgtemp_data *data;
+	int err;
+	u32 eax, edx;
+#ifdef CONFIG_SMP
+	struct cpuinfo_x86 *c =3D &cpu_data(pdev->id);
+#endif
+
+	data =3D kzalloc(sizeof(struct pkgtemp_data), GFP_KERNEL);
+	if (!data) {
+		err =3D -ENOMEM;
+		dev_err(&pdev->dev, "Out of memory\n");
+		goto exit;
+	}
+
+	data->id =3D pdev->id;
+#ifdef CONFIG_SMP
+	data->phys_proc_id =3D c->phys_proc_id;
+#endif
+	data->name =3D "pkgtemp";
+	mutex_init(&data->update_lock);
+
+	/* test if we can access the THERM_STATUS MSR */
+	err =3D rdmsr_safe_on_cpu(data->id, MSR_IA32_PACKAGE_THERM_STATUS,
+				&eax, &edx);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Unable to access THERM_STATUS MSR, giving up\n");
+		goto exit_free;
+	}
+
+	data->tjmax =3D get_tjmax(data->id, &pdev->dev);
+	platform_set_drvdata(pdev, data);
+
+	err =3D rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TARGET,
+				&eax, &edx);
+	if (err) {
+		dev_warn(&pdev->dev, "Unable to read"
+				" IA32_TEMPERATURE_TARGET MSR\n");
+	} else {
+		data->ttarget =3D data->tjmax - (((eax >> 8) & 0xff) * 1000);
+		err =3D device_create_file(&pdev->dev,
+				&sensor_dev_attr_temp1_max.dev_attr);
+		if (err)
+			goto exit_free;
+	}
+
+	err =3D sysfs_create_group(&pdev->dev.kobj, &pkgtemp_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err =3D PTR_ERR(data->hwmon_dev);
+		dev_err(&pdev->dev, "Class registration failed (%d)\n",
+			err);
+		goto exit_class;
+	}
+
+	return 0;
+
+exit_class:
+	sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int __devexit pkgtemp_remove(struct platform_device *pdev)
+{
+	struct pkgtemp_data *data =3D platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
+	platform_set_drvdata(pdev, NULL);
+	kfree(data);
+	return 0;
+}
+
+static struct platform_driver pkgtemp_driver =3D {
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name =3D DRVNAME,
+	},
+	.probe =3D pkgtemp_probe,
+	.remove =3D __devexit_p(pkgtemp_remove),
+};
+
+struct pdev_entry {
+	struct list_head list;
+	struct platform_device *pdev;
+	unsigned int cpu;
+#ifdef CONFIG_SMP
+	u16 phys_proc_id;
+#endif
+};
+
+static LIST_HEAD(pdev_list);
+static DEFINE_MUTEX(pdev_list_mutex);
+
+static int __cpuinit pkgtemp_device_add(unsigned int cpu)
+{
+	int err;
+	struct platform_device *pdev;
+	struct pdev_entry *pdev_entry;
+#ifdef CONFIG_SMP
+	struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+#endif
+
+	mutex_lock(&pdev_list_mutex);
+
+#ifdef CONFIG_SMP
+	/* Only keep the first entry in each package */
+	list_for_each_entry(pdev_entry, &pdev_list, list) {
+		if (c->phys_proc_id =3D pdev_entry->phys_proc_id) {
+			err =3D 0;        /* Not an error */
+			goto exit;
+		}
+	}
+#endif
+
+	pdev =3D platform_device_alloc(DRVNAME, cpu);
+	if (!pdev) {
+		err =3D -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		goto exit;
+	}
+
+	pdev_entry =3D kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
+	if (!pdev_entry) {
+		err =3D -ENOMEM;
+		goto exit_device_put;
+	}
+
+	err =3D platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
+		       err);
+		goto exit_device_free;
+	}
+
+#ifdef CONFIG_SMP
+	pdev_entry->phys_proc_id =3D c->phys_proc_id;
+#endif
+	pdev_entry->pdev =3D pdev;
+	pdev_entry->cpu =3D cpu;
+	list_add_tail(&pdev_entry->list, &pdev_list);
+	mutex_unlock(&pdev_list_mutex);
+
+	return 0;
+
+exit_device_free:
+	kfree(pdev_entry);
+exit_device_put:
+	platform_device_put(pdev);
+exit:
+	mutex_unlock(&pdev_list_mutex);
+	return err;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void pkgtemp_device_remove(unsigned int cpu)
+{
+	struct pdev_entry *p, *n;
+	unsigned int i;
+	int err;
+
+	mutex_lock(&pdev_list_mutex);
+	list_for_each_entry_safe(p, n, &pdev_list, list) {
+		if (p->cpu !=3D cpu)
+			continue;
+
+		platform_device_unregister(p->pdev);
+		list_del(&p->list);
+		kfree(p);
+		for_each_cpu(i, cpu_core_mask(cpu)) {
+			if (i !=3D cpu) {
+				err =3D pkgtemp_device_add(i);
+				if (!err)
+					break;
+			}
+		}
+		break;
+	}
+	mutex_unlock(&pdev_list_mutex);
+}
+
+static int __cpuinit pkgtemp_cpu_callback(struct notifier_block *nfb,
+				 unsigned long action, void *hcpu)
+{
+	unsigned int cpu =3D (unsigned long) hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
+		pkgtemp_device_add(cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+		pkgtemp_device_remove(cpu);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pkgtemp_cpu_notifier __refdata =3D {
+	.notifier_call =3D pkgtemp_cpu_callback,
+};
+#endif				/* !CONFIG_HOTPLUG_CPU */
+
+static int __init pkgtemp_init(void)
+{
+	int i, err =3D -ENODEV;
+	struct pdev_entry *p, *n;
+
+	/* quick check if we run Intel */
+	if (cpu_data(0).x86_vendor !=3D X86_VENDOR_INTEL)
+		goto exit;
+
+	err =3D platform_driver_register(&pkgtemp_driver);
+	if (err)
+		goto exit;
+
+	for_each_online_cpu(i) {
+		struct cpuinfo_x86 *c =3D &cpu_data(i);
+
+		if (!cpu_has(c, X86_FEATURE_PTS))
+			continue;
+
+		err =3D pkgtemp_device_add(i);
+		if (err)
+			goto exit_devices_unreg;
+	}
+	if (list_empty(&pdev_list)) {
+		err =3D -ENODEV;
+		goto exit_driver_unreg;
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	register_hotcpu_notifier(&pkgtemp_cpu_notifier);
+#endif
+	return 0;
+
+exit_devices_unreg:
+	mutex_lock(&pdev_list_mutex);
+	list_for_each_entry_safe(p, n, &pdev_list, list) {
+		platform_device_unregister(p->pdev);
+		list_del(&p->list);
+		kfree(p);
+	}
+	mutex_unlock(&pdev_list_mutex);
+exit_driver_unreg:
+	platform_driver_unregister(&pkgtemp_driver);
+exit:
+	return err;
+}
+
+static void __exit pkgtemp_exit(void)
+{
+	struct pdev_entry *p, *n;
+#ifdef CONFIG_HOTPLUG_CPU
+	unregister_hotcpu_notifier(&pkgtemp_cpu_notifier);
+#endif
+	mutex_lock(&pdev_list_mutex);
+	list_for_each_entry_safe(p, n, &pdev_list, list) {
+		platform_device_unregister(p->pdev);
+		list_del(&p->list);
+		kfree(p);
+	}
+	mutex_unlock(&pdev_list_mutex);
+	platform_driver_unregister(&pkgtemp_driver);
+}
+
+MODULE_AUTHOR("Fenghua Yu <fenghua.yu@intel.com>");
+MODULE_DESCRIPTION("Intel processor package temperature monitor");
+MODULE_LICENSE("GPL");
+
+module_init(pkgtemp_init)
+module_exit(pkgtemp_exit)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
