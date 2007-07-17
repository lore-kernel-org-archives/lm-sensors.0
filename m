From: "Jeff Garrett" <jgarrett@teamhpc.com>
Date: Tue, 17 Jul 2007 15:17:50 +0000
Subject: Re: [lm-sensors] [patch] AMB FB DIMM driver
Message-Id: <1184685470.6529.18.camel@thog>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-MNaHBr/Ja8Cs83H1+mRM"
List-Id: <lm-sensors.vger.kernel.org>
References: <20070523000559.GA7009@jgarrett.org>
In-Reply-To: <20070523000559.GA7009@jgarrett.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--=-MNaHBr/Ja8Cs83H1+mRM
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Darrick, I'm cc'ing you since you aren't subscribed to the list and
since a recent posting suggests you will be interested in this thread.
Some previous (really short) threads:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019782.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/019979.html

Hello, Rudolf,

>Sorry for the delay,

Same here.  Work always seems to get in the way.  :)  Attached is the
next version of the driver.

>>>> static struct sensor_device_attribute temp_input[] = {
>>>> 	SENSOR_ATTR(temp00_input, S_IRUGO, show_temp, NULL, 0),
>>> Without leading zero and decimal please. Maybe you can even do this in 
>>> dynamic fashion. I think there was at least one driver doing it this way, 
>>> but I dont recall right now.
>> 
>> Noted.  Should there be any communication with the user about names
>> then?  For example, in the DSBF-D manual it calls the DIMMs DIMM_00,
>> DIMM_01, etc. based on channel & number. And this would correlate to
>> temp00_input, etc.  In other words, locating a hot DIMM is relatively
>> easy with this information.  If they're called, say,
>> temp{1,2,17,18,33,34,49,50}_input, then a user can still figure out
>> which DIMM is which, but has to realize how to correlate 17 to DIMM_10.
>> It's a little bit more opaque.  And if they're called
>> temp{1,2,3,4,5,6,7,8}_input, it's even more so.

>> So, should there be a separate sysfs attribute, something like
>> temp1_name which may read DIMM_00, for example?

>Yes we have _label (coretemp driver for example). Please fill the label with string.

Done.

>> Also, which of the two options above is preferable [no gaps, or gaps but
>> numbers that are stable...  temp17 always points to the same slot]?

>If we have _label files so perhaps static approach is easiest.

>> I made it kinda sorta dynamic...   i.e. the structs are in data, so they
>> are allocated dynamically, not statically, and initialized when needed.
>> But it still allocates space for 64...

>Ok I dont know if Mark will like it, anyway this may be changed in next iteration.

OK, so I found it easy to switch over to a struct list_head and
dynamically allocate all the sensors.  This made it easy as well to
number them numerically.  So right now, you have temp1_input,
temp2_input, etc.  And there are the _label's as well.

>>>> static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>>>> static struct pci_device_id ambtemp_ids[] = {
>>>> 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x25f0) },
>>> the 0x25f0 should go to the pciids.h Moreover I do not recall if this is 
>>> used also for something else? I mean has this PCI device some other 
>>> function?
>> 
>> It's called the error reporting registers by lspci.  As far as I can
>> tell, it's just a bunch of registers associated to the MCH, and nothing
>> else in the kernel claims it.

>And what about EDAC? (check the edac project please) maybe we need to do same 
>trick as for i2c-viapro driver, return -ENODEV to PCI layer but normally 
>request_region for the MEM region.

You are right.  I had all but forgot about EDAC and they do need access to
the memory error registers, so I've modified it to return -ENODEV.

>> Helps immensely.  I'm a bit new to this.  Thanks very much,

>Good. Sorry for the delays, this week I have first opportunity to have free 
>evening :/

>Hope it helps a bit.

It's great!  Thanks,

Jeff

--=-MNaHBr/Ja8Cs83H1+mRM
Content-Disposition: attachment;
	filename="ambtemp-v3.patch"
Content-Type: text/x-patch;
	charset="utf-8";
	name="ambtemp-v3.patch"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4d1cb5b..151bef2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -128,6 +128,17 @@ config SENSORS_K8TEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called k8temp.
 
+config SENSORS_AMBTEMP
+	tristate "Intel AMB FB-DIMM temperature sensors"
+	depends on X86 && PCI && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the temperature
+	  sensor(s) on the Advanced Memory Buffer on fully buffered
+	  DIMMs.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ambtemp.
+
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
 	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index cfaf338..895d94f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
+obj-$(CONFIG_SENSORS_AMBTEMP)	+= ambtemp.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
 obj-$(CONFIG_SENSORS_LM70)	+= lm70.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
diff --git a/drivers/hwmon/ambtemp.c b/drivers/hwmon/ambtemp.c
new file mode 100644
index 0000000..bd6bddb
--- /dev/null
+++ b/drivers/hwmon/ambtemp.c
@@ -0,0 +1,371 @@
+/*
+ * ambtemp.c - Linux kernel module for hardware monitoring
+ *
+ * Copyright (C) 2007 Jeff Garrett <jgarrett@teamhpc.com>
+ *
+ * Inspired from the k8temp driver.  Thanks also to Rudolf Marek.
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
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/pci.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+
+
+/*
+ * Please see the datasheets:
+ *   http://www.intel.com/design/chipsets/datashts/313071.htm
+ *   http://www.intel.com/design/chipsets/datashts/313072.htm
+ */
+#define TEMP_FROM_REG(val)	(500*((unsigned long)val))
+#define AMBASE_LOW_REG		0x48
+#define AMBASE_HIGH_REG		0x4C
+#define AMBASE_MASK		0x000000FFFFFE0000ULL
+
+#define AMB_MAX_DEVS		64
+#define AMB_DEV_LENGTH		2048	/* Length of a single sensor region */
+#define AMB_RGN_LENGTH		(AMB_MAX_DEVS * AMB_DEV_LENGTH)
+
+#define AMB_INDEX(base, off)	((off - base)/AMB_DEV_LENGTH)
+
+#define TEMP_OFFSET		0x385
+
+/*
+ * These differ from their analogues in linux/sysfs.h and linux/hwmon-sysfs.h
+ * by not stringifying _name.  That is, _name is allowed to be runtime
+ * evaluable.
+ */
+#define __ATTR_DYNAMIC(_name,_mode,_show,_store) {			\
+	.attr = { .name = _name, .mode = _mode, .owner = THIS_MODULE },	\
+	.show   = _show,						\
+	.store  = _store,						\
+}
+#define SENSOR_ATTR_DYNAMIC(_name, _mode, _show, _store, _index)	\
+	(struct sensor_device_attribute)				\
+	{ .dev_attr = __ATTR_DYNAMIC(_name, _mode, _show, _store),	\
+	  .index = _index }
+
+
+struct ambtemp_sensor {
+	unsigned int idx;
+	unsigned long value;
+	void __iomem *address;
+
+	/* Sysfs */
+	char *input_file;	/* e.g. "temp1_input" */
+	char *label_file;	/* e.g. "temp1_label" */
+	struct sensor_device_attribute temp_input;
+	struct sensor_device_attribute temp_label;
+	char *label;		/* e.g. "DIMM_00" */
+
+	struct list_head list;
+};
+
+struct ambtemp_data {
+	struct class_device *class_dev;
+	struct mutex update_lock;
+	const char *name;
+	char valid;		/* zero until following fields are valid */
+	unsigned long last_updated;	/* in jiffies */
+
+	/* register values */
+	void __iomem *base;
+	struct ambtemp_sensor temp;
+};
+
+static struct ambtemp_data *ambtemp_update_device(struct device *dev)
+{
+	struct ambtemp_data *data = dev_get_drvdata(dev);
+	struct ambtemp_sensor *p;
+
+	mutex_lock(&data->update_lock);
+
+	if (!data->valid
+		|| time_after(jiffies, data->last_updated + HZ)) {
+
+		/* Read the sensors */
+		list_for_each_entry(p, &data->temp.list, list)
+			p->value = TEMP_FROM_REG(readb(p->address));
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+/*
+ * Sysfs stuff
+ */
+
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct ambtemp_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->name);
+}
+
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct ambtemp_data *data = ambtemp_update_device(dev);
+	struct ambtemp_sensor *p;
+
+	list_for_each_entry(p, &data->temp.list, list)
+		if (p->idx == attr->index)
+			return sprintf(buf, "%ld\n", p->value);
+	return sprintf(buf, "\n");
+}
+
+
+static ssize_t show_label(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct ambtemp_data *data = dev_get_drvdata(dev);
+	struct ambtemp_sensor *p;
+
+	list_for_each_entry(p, &data->temp.list, list)
+		if (p->idx == attr->index)
+			return sprintf(buf, "%s\n", p->label);
+	return sprintf(buf, "\n");
+}
+
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static struct pci_device_id ambtemp_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MCH_AMB) },
+	{ 0 },
+};
+
+MODULE_DEVICE_TABLE(pci, ambtemp_ids);
+
+static int __devinit ambtemp_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *id)
+{
+	int err;
+	u32 low, high;
+	u64 addr;
+	void __iomem *l;
+	
+	struct ambtemp_data *data;
+
+	struct ambtemp_sensor *p, *q;
+	unsigned int idx = 0;
+
+	/* The Error Reporting Registers we piggy back on show up at
+	 * 10.0, 10.1, and 10.2.  We only want the first function.  The
+	 * AMBASE slot on the others is wrong.
+	 */
+	if (PCI_FUNC(pdev->devfn) != 0x00) {
+		/* Go away */
+		err = -ENODEV;
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct ambtemp_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	INIT_LIST_HEAD(&data->temp.list);
+
+	dev_info(&pdev->dev, "Device found\n");
+	dev_dbg(&pdev->dev, "Scanning for sensors...\n");
+
+	/* Reserve the sensor range starting at AMBASE */
+	pci_read_config_dword(pdev, AMBASE_LOW_REG, &low);
+	pci_read_config_dword(pdev, AMBASE_HIGH_REG, &high);
+
+	addr = ((u64)high << 32 | low) & AMBASE_MASK;
+	if (!addr) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	data->base = ioremap(addr, AMB_RGN_LENGTH);
+	if (!data->base) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	for (l = data->base; l < data->base + AMB_RGN_LENGTH;
+	     l += AMB_DEV_LENGTH) {
+		if (readl(l) == 0xFFFFFFFFL)
+			continue;
+
+		p = kzalloc(sizeof(struct ambtemp_sensor), GFP_KERNEL);
+		if (!p) {
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		p->idx = ++idx;
+		p->address = l + TEMP_OFFSET;
+
+		list_add_tail(&p->list, &data->temp.list);
+		dev_dbg(&pdev->dev, "Sensor at offset 0x%02x\n",
+		        AMB_INDEX(data->base, l));
+	}
+
+	data->name = "ambtemp";
+	mutex_init(&data->update_lock);
+	dev_set_drvdata(&pdev->dev, data);
+
+	/* Register sysfs hooks */
+	list_for_each_entry(p, &data->temp.list, list) {
+		p->input_file = kasprintf(GFP_KERNEL, "temp%d_input", p->idx);
+		if (!p->input_file) {
+			err = -ENOMEM;
+			goto exit_remove;
+		}
+
+		p->temp_input = SENSOR_ATTR_DYNAMIC(p->input_file, S_IRUGO,
+						    show_temp, NULL, p->idx);
+
+		err = device_create_file(&pdev->dev, &p->temp_input.dev_attr);
+		if (err)
+			goto exit_remove;
+
+		p->label_file = kasprintf(GFP_KERNEL, "temp%d_label", p->idx);
+		if (!p->label_file) {
+			err = -ENOMEM;
+			goto exit_remove;
+		}
+
+		p->temp_label = SENSOR_ATTR_DYNAMIC(p->label_file, S_IRUGO,
+						    show_label, NULL, p->idx);
+
+		err = device_create_file(&pdev->dev, &p->temp_label.dev_attr);
+		if (err)
+			goto exit_remove;
+
+		p->label = kasprintf(GFP_KERNEL, "DIMM_%02lx",
+		                     AMB_INDEX(data->base, p->address));
+		if (!p->label) {
+			err = -ENOMEM;
+			goto exit_remove;
+		}
+	}
+
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
+		goto exit_remove;
+
+	data->class_dev = hwmon_device_register(&pdev->dev);
+
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_remove;
+	}
+
+	/* Let others bind to this PCI device */
+	return -ENODEV;
+
+exit_remove:
+	list_for_each_entry_safe(p, q, &data->temp.list, list) {
+		if (p->input_file) {
+			device_remove_file(&pdev->dev, &p->temp_input.dev_attr);
+			kfree(p->input_file);
+		}
+
+		if (p->label_file) {
+			device_remove_file(&pdev->dev, &p->temp_label.dev_attr);
+			kfree(p->label_file);
+		}
+
+		kfree(p->label);
+		list_del(&p->list);
+		kfree(p);
+	}
+
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	dev_set_drvdata(&pdev->dev, NULL);
+	kfree(data);
+exit:
+	return err;
+}
+
+static void __devexit ambtemp_remove(struct pci_dev *pdev)
+{
+	struct ambtemp_data *data = dev_get_drvdata(&pdev->dev);
+	struct ambtemp_sensor *p, *q;
+
+	if (!data)
+		return;
+
+	hwmon_device_unregister(data->class_dev);
+	list_for_each_entry_safe(p, q, &data->temp.list, list) {
+		if (p->input_file) {
+			device_remove_file(&pdev->dev, &p->temp_input.dev_attr);
+			kfree(p->input_file);
+		}
+
+		if (p->label_file) {
+			device_remove_file(&pdev->dev, &p->temp_label.dev_attr);
+			kfree(p->label_file);
+		}
+
+		kfree(p->label);
+		list_del(&p->list);
+		kfree(p);
+	}
+
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	iounmap(data->base);
+	kfree(data);
+}
+
+static struct pci_driver ambtemp_driver = {
+	.name = "ambtemp",
+	.id_table = ambtemp_ids,
+	.probe = ambtemp_probe,
+	.remove = __devexit_p(ambtemp_remove),
+};
+
+static int __init ambtemp_init(void)
+{
+	return pci_register_driver(&ambtemp_driver);
+}
+
+static void __exit ambtemp_exit(void)
+{
+	pci_unregister_driver(&ambtemp_driver);
+}
+
+MODULE_AUTHOR("Jeff Garrett <jgarrett@teamhpc.com>");
+MODULE_DESCRIPTION("Intel AMB temperature monitor");
+MODULE_LICENSE("GPL");
+
+module_init(ambtemp_init)
+module_exit(ambtemp_exit)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4712e26..9b55239 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2146,6 +2146,7 @@
 
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
+#define PCI_DEVICE_ID_INTEL_MCH_AMB	0x25F0
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
 #define PCI_DEVICE_ID_INTEL_PXHD_1	0x0321
 #define PCI_DEVICE_ID_INTEL_PXH_0	0x0329

--=-MNaHBr/Ja8Cs83H1+mRM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-MNaHBr/Ja8Cs83H1+mRM--
