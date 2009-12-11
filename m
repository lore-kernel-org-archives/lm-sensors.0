From: Juerg Haefliger <juergh@gmail.com>
Date: Fri, 11 Dec 2009 17:43:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <191fb4ca0912110943r52eaf7d9qf4717456a0ec35c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org>
In-Reply-To: <20090609083406.GE25316@prithivi.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> This is a driver for the on-die digital temperature sensor of
> VIA's recent CPU models.
>
> [JD: Misc clean-ups.]
>
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> Cc: Juerg Haefliger <juergh@gmail.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Harald, Juerg, all: this is the driver I intend to push to Linus for
> kernel 2.6.33. It is based on Harald's driver, to which I applied
> almost all the fixes I had suggested in my review back in June. I do
> not own a VIA-based system myself so I couldn't test it. I would
> appreciate if someone could test it and report, just to make sure I
> didn't accidentally break the driver with my clean-ups. Thanks.

I can't test it. I don't have a C7 CPU, only a C3.

...juerg



> I didn't pick Justin's modified driver because its indentation didn't
> match what the kernel wants, and I didn't want to waste my time
> re-indenting it.
>
> Still missing in this driver are:
> * Warnings that should be printed for CPU models with known errata.
> * Support for Vcore (or is it VID?) reporting.
> Both can be added on top of the current driver, using incremental
> patches.
>
>  drivers/hwmon/Kconfig       |    8
>  drivers/hwmon/Makefile      |    1
>  drivers/hwmon/via-cputemp.c |  356 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 365 insertions(+)
>  create mode 100644 drivers/hwmon/via-cputemp.c
>
> --- linux-2.6.33-rc0.orig/drivers/hwmon/Kconfig 2009-12-10 18:57:39.000000000 +0100
> +++ linux-2.6.33-rc0/drivers/hwmon/Kconfig      2009-12-10 18:57:44.000000000 +0100
> @@ -822,6 +822,14 @@ config SENSORS_TMP421
>          This driver can also be built as a module.  If so, the module
>          will be called tmp421.
>
> +config SENSORS_VIA_CPUTEMP
> +       tristate "VIA CPU temperature sensor"
> +       depends on X86
> +       help
> +         If you say yes here you get support for the temperature
> +         sensor inside your CPU. Supported all are all known variants
> +         of the VIA C7 and Nano.
> +
>  config SENSORS_VIA686A
>        tristate "VIA686A"
>        depends on PCI
> --- linux-2.6.33-rc0.orig/drivers/hwmon/Makefile        2009-12-10 18:57:39.000000000 +0100
> +++ linux-2.6.33-rc0/drivers/hwmon/Makefile     2009-12-10 18:57:44.000000000 +0100
> @@ -88,6 +88,7 @@ obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc4
>  obj-$(CONFIG_SENSORS_THMC50)   += thmc50.o
>  obj-$(CONFIG_SENSORS_TMP401)   += tmp401.o
>  obj-$(CONFIG_SENSORS_TMP421)   += tmp421.o
> +obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
>  obj-$(CONFIG_SENSORS_VIA686A)  += via686a.o
>  obj-$(CONFIG_SENSORS_VT1211)   += vt1211.o
>  obj-$(CONFIG_SENSORS_VT8231)   += vt8231.o
> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.33-rc0/drivers/hwmon/via-cputemp.c        2009-12-10 19:54:27.000000000 +0100
> @@ -0,0 +1,356 @@
> +/*
> + * via-cputemp.c - Driver for VIA CPU core temperature monitoring
> + * Copyright (C) 2009 VIA Technologies, Inc.
> + *
> + * based on existing coretemp.c, which is
> + *
> + * Copyright (C) 2007 Rudolf Marek <r.marek@assembler.cz>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpu.h>
> +#include <asm/msr.h>
> +#include <asm/processor.h>
> +
> +#define DRVNAME        "via_cputemp"
> +
> +enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;
> +
> +/*
> + * Functions declaration
> + */
> +
> +struct via_cputemp_data {
> +       struct device *hwmon_dev;
> +       const char *name;
> +       u32 id;
> +       u32 msr;
> +};
> +
> +/*
> + * Sysfs stuff
> + */
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +                         *devattr, char *buf)
> +{
> +       int ret;
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct via_cputemp_data *data = dev_get_drvdata(dev);
> +
> +       if (attr->index = SHOW_NAME)
> +               ret = sprintf(buf, "%s\n", data->name);
> +       else    /* show label */
> +               ret = sprintf(buf, "Core %d\n", data->id);
> +       return ret;
> +}
> +
> +static ssize_t show_temp(struct device *dev,
> +                        struct device_attribute *devattr, char *buf)
> +{
> +       struct via_cputemp_data *data = dev_get_drvdata(dev);
> +       u32 eax, edx;
> +       int err;
> +
> +       err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
> +       if (err)
> +               return -EAGAIN;
> +
> +       return sprintf(buf, "%lu\n", ((unsigned long)eax & 0xffffff) * 1000);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
> +                         SHOW_TEMP);
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
> +
> +static struct attribute *via_cputemp_attributes[] = {
> +       &sensor_dev_attr_name.dev_attr.attr,
> +       &sensor_dev_attr_temp1_label.dev_attr.attr,
> +       &sensor_dev_attr_temp1_input.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group via_cputemp_group = {
> +       .attrs = via_cputemp_attributes,
> +};
> +
> +static int __devinit via_cputemp_probe(struct platform_device *pdev)
> +{
> +       struct via_cputemp_data *data;
> +       struct cpuinfo_x86 *c = &cpu_data(pdev->id);
> +       int err;
> +       u32 eax, edx;
> +
> +       data = kzalloc(sizeof(struct via_cputemp_data), GFP_KERNEL);
> +       if (!data) {
> +               err = -ENOMEM;
> +               dev_err(&pdev->dev, "Out of memory\n");
> +               goto exit;
> +       }
> +
> +       data->id = pdev->id;
> +       data->name = "via-cputemp";
> +
> +       switch (c->x86_model) {
> +       case 0xA:
> +               /* C7 A */
> +       case 0xD:
> +               /* C7 D */
> +               data->msr = 0x1169;
> +               break;
> +       case 0xF:
> +               /* Nano */
> +               data->msr = 0x1423;
> +               break;
> +       default:
> +               err = -ENODEV;
> +               goto exit_free;
> +       }
> +
> +       /* test if we can access the TEMPERATURE MSR */
> +       err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
> +       if (err) {
> +               dev_err(&pdev->dev,
> +                       "Unable to access TEMPERATURE MSR, giving up\n");
> +               goto exit_free;
> +       }
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       err = sysfs_create_group(&pdev->dev.kobj, &via_cputemp_group);
> +       if (err)
> +               goto exit_free;
> +
> +       data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +       if (IS_ERR(data->hwmon_dev)) {
> +               err = PTR_ERR(data->hwmon_dev);
> +               dev_err(&pdev->dev, "Class registration failed (%d)\n",
> +                       err);
> +               goto exit_remove;
> +       }
> +
> +       return 0;
> +
> +exit_remove:
> +       sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
> +exit_free:
> +       platform_set_drvdata(pdev, NULL);
> +       kfree(data);
> +exit:
> +       return err;
> +}
> +
> +static int __devexit via_cputemp_remove(struct platform_device *pdev)
> +{
> +       struct via_cputemp_data *data = platform_get_drvdata(pdev);
> +
> +       hwmon_device_unregister(data->hwmon_dev);
> +       sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
> +       platform_set_drvdata(pdev, NULL);
> +       kfree(data);
> +       return 0;
> +}
> +
> +static struct platform_driver via_cputemp_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = DRVNAME,
> +       },
> +       .probe = via_cputemp_probe,
> +       .remove = __devexit_p(via_cputemp_remove),
> +};
> +
> +struct pdev_entry {
> +       struct list_head list;
> +       struct platform_device *pdev;
> +       unsigned int cpu;
> +};
> +
> +static LIST_HEAD(pdev_list);
> +static DEFINE_MUTEX(pdev_list_mutex);
> +
> +static int __cpuinit via_cputemp_device_add(unsigned int cpu)
> +{
> +       int err;
> +       struct platform_device *pdev;
> +       struct pdev_entry *pdev_entry;
> +
> +       pdev = platform_device_alloc(DRVNAME, cpu);
> +       if (!pdev) {
> +               err = -ENOMEM;
> +               printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +               goto exit;
> +       }
> +
> +       pdev_entry = kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
> +       if (!pdev_entry) {
> +               err = -ENOMEM;
> +               goto exit_device_put;
> +       }
> +
> +       err = platform_device_add(pdev);
> +       if (err) {
> +               printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> +                      err);
> +               goto exit_device_free;
> +       }
> +
> +       pdev_entry->pdev = pdev;
> +       pdev_entry->cpu = cpu;
> +       mutex_lock(&pdev_list_mutex);
> +       list_add_tail(&pdev_entry->list, &pdev_list);
> +       mutex_unlock(&pdev_list_mutex);
> +
> +       return 0;
> +
> +exit_device_free:
> +       kfree(pdev_entry);
> +exit_device_put:
> +       platform_device_put(pdev);
> +exit:
> +       return err;
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void via_cputemp_device_remove(unsigned int cpu)
> +{
> +       struct pdev_entry *p, *n;
> +       mutex_lock(&pdev_list_mutex);
> +       list_for_each_entry_safe(p, n, &pdev_list, list) {
> +               if (p->cpu = cpu) {
> +                       platform_device_unregister(p->pdev);
> +                       list_del(&p->list);
> +                       kfree(p);
> +               }
> +       }
> +       mutex_unlock(&pdev_list_mutex);
> +}
> +
> +static int __cpuinit via_cputemp_cpu_callback(struct notifier_block *nfb,
> +                                unsigned long action, void *hcpu)
> +{
> +       unsigned int cpu = (unsigned long) hcpu;
> +
> +       switch (action) {
> +       case CPU_ONLINE:
> +       case CPU_DOWN_FAILED:
> +               via_cputemp_device_add(cpu);
> +               break;
> +       case CPU_DOWN_PREPARE:
> +               via_cputemp_device_remove(cpu);
> +               break;
> +       }
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block via_cputemp_cpu_notifier __refdata = {
> +       .notifier_call = via_cputemp_cpu_callback,
> +};
> +#endif                         /* !CONFIG_HOTPLUG_CPU */
> +
> +static int __init via_cputemp_init(void)
> +{
> +       int i, err;
> +       struct pdev_entry *p, *n;
> +
> +       if (cpu_data(0).x86_vendor != X86_VENDOR_CENTAUR) {
> +               printk(KERN_DEBUG DRVNAME ": Not a VIA CPU\n");
> +               err = -ENODEV;
> +               goto exit;
> +       }
> +
> +       err = platform_driver_register(&via_cputemp_driver);
> +       if (err)
> +               goto exit;
> +
> +       for_each_online_cpu(i) {
> +               struct cpuinfo_x86 *c = &cpu_data(i);
> +
> +               if (c->x86 != 6)
> +                       continue;
> +
> +               if (c->x86_model < 0x0a)
> +                       continue;
> +
> +               if (c->x86_model > 0x0f) {
> +                       printk(KERN_WARNING DRVNAME ": Unknown CPU "
> +                               "model 0x%x\n", c->x86_model);
> +                       continue;
> +               }
> +
> +               err = via_cputemp_device_add(i);
> +               if (err)
> +                       goto exit_devices_unreg;
> +       }
> +       if (list_empty(&pdev_list)) {
> +               err = -ENODEV;
> +               goto exit_driver_unreg;
> +       }
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +       register_hotcpu_notifier(&via_cputemp_cpu_notifier);
> +#endif
> +       return 0;
> +
> +exit_devices_unreg:
> +       mutex_lock(&pdev_list_mutex);
> +       list_for_each_entry_safe(p, n, &pdev_list, list) {
> +               platform_device_unregister(p->pdev);
> +               list_del(&p->list);
> +               kfree(p);
> +       }
> +       mutex_unlock(&pdev_list_mutex);
> +exit_driver_unreg:
> +       platform_driver_unregister(&via_cputemp_driver);
> +exit:
> +       return err;
> +}
> +
> +static void __exit via_cputemp_exit(void)
> +{
> +       struct pdev_entry *p, *n;
> +#ifdef CONFIG_HOTPLUG_CPU
> +       unregister_hotcpu_notifier(&via_cputemp_cpu_notifier);
> +#endif
> +       mutex_lock(&pdev_list_mutex);
> +       list_for_each_entry_safe(p, n, &pdev_list, list) {
> +               platform_device_unregister(p->pdev);
> +               list_del(&p->list);
> +               kfree(p);
> +       }
> +       mutex_unlock(&pdev_list_mutex);
> +       platform_driver_unregister(&via_cputemp_driver);
> +}
> +
> +MODULE_AUTHOR("Harald Welte <HaraldWelte@viatech.com>");
> +MODULE_DESCRIPTION("VIA CPU temperature monitor");
> +MODULE_LICENSE("GPL");
> +
> +module_init(via_cputemp_init)
> +module_exit(via_cputemp_exit)
>
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
