From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 15:54:48 +0000
Subject: [lm-sensors] [PATH] coretemp driver - take2
Message-Id: <20070312165448.c340ab28.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45AAA204.5030905@assembler.cz>
In-Reply-To: <45AAA204.5030905@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sun, 14 Jan 2007 22:35:00 +0100, Rudolf Marek wrote:
> Hello all,
>=20
> It seems there is no agreement how to deal with the unified MSR access.=20
> Therefore I have reverted the change back, so there is no dependency to M=
SR=20
> support in kernel. I'm attaching both patches to one mail, and starting n=
ew=20
> thread for this. In the old one, there are simply too many drivers.

It seems that changed recently:
  http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=B077ffb3b767c3efb44d00b998385a9cb127255c

This introduces exported functions rdmsr_on_cpu() and wrmsr_on_cpu()
(check in arch/i386/lib/msr-on-cpu.c) which I think is what you need?

One thing I'm not happy with is the fact that you create one separate
platform device for every temperature sensor, it makes the sensors
output a bit confusing. But I guess it's not possible to support CPU
hotplug otherwise, so, so be it.

I'm not even sure if platform devices are the way to go... After all
the CPU cores are already represented in the driver tree:
  /sys/devices/system/cpu/cpu0
  /sys/devices/system/cpu/cpu1
I guess that in theory we should add our stuff there, either in a
subdirectory as cpufreq does, or as a child class device. I'm not too
sure how it'll fit with our hwmon class and libsensors though, so I'm
fine postponing this cleanup to later.

Other than that, your driver appears to work well on my Intel Pentium M
T2600 :)

On the code itself:

> Index: linux-2.6.20-rc4/drivers/hwmon/coretemp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null	1970-01-01 00:00:00.000000000 +0=
000
> +++ linux-2.6.20-rc4/drivers/hwmon/coretemp.c	2007-01-14 21:49:52.7648717=
60 +0100
> @@ -0,0 +1,472 @@
> +/*
> + * coretemp.c - Linux kernel module for hardware monitoring
> + *
> + * Copyright (C) 2006 Rudolf Marek <r.marek at assembler.cz>

You can add 2007 now.

> + *
> + * Inspired from many hwmon drivers
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
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
> +#define DRVNAME		"coretemp"
> +
> +/*
> +   Following part ripped from the msr.c. It should be merged with generi=
c MSR
> +   infrastructure (once ready)
> +*/
> +
> +static inline int rdmsr_eio(u32 reg, u32 *eax, u32 *edx)
> +{
> +	int err;
> +
> +	err =3D rdmsr_safe(reg, eax, edx);
> +	if (err)
> +		err =3D -EIO;
> +	return err;
> +}
> +
> +#ifdef CONFIG_SMP
> +
> +struct msr_command {
> +	int cpu;
> +	int err;
> +	u32 reg;
> +	u32 data[2];
> +};
> +
> +static void msr_smp_rdmsr(void *cmd_block)
> +{
> +	struct msr_command *cmd =3D (struct msr_command *)cmd_block;
> +
> +	if (cmd->cpu =3D smp_processor_id())
> +		cmd->err =3D rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
> +}
> +
> +static inline int msr_read(int cpu, u32 reg, u32 * eax, u32 * edx)
> +{
> +	struct msr_command cmd;
> +	int ret;
> +
> +	preempt_disable();
> +	if (cpu =3D smp_processor_id()) {
> +		ret =3D rdmsr_eio(reg, eax, edx);
> +	} else {
> +		cmd.cpu =3D cpu;
> +		cmd.reg =3D reg;
> +
> +		smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
> +
> +		*eax =3D cmd.data[0];
> +		*edx =3D cmd.data[1];
> +
> +		ret =3D cmd.err;
> +	}
> +	preempt_enable();
> +	return ret;
> +}
> +
> +#else				/* ! CONFIG_SMP */
> +
> +static inline int msr_read(int cpu, u32 reg, u32 *eax, u32 *edx)
> +{
> +	return rdmsr_eio(reg, eax, edx);
> +}
> +
> +#endif				/* ! CONFIG_SMP */
> +
> +/* cut here */
> +
> +typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_LABEL, SHOW_NAME } SHOW;
> +
> +/*
> + * Functions declaration
> + */
> +
> +static struct coretemp_data *coretemp_update_device(struct device *dev);
> +
> +struct coretemp_data {
> +	struct class_device *class_dev;
> +	struct mutex update_lock;
> +	const char *name;
> +	u32 id;
> +	char valid;		/* zero until following fields are valid */
> +	unsigned long last_updated;	/* in jiffies */
> +	int temp;
> +	int tjmax;
> +	/* registers values */
> +	u32 therm_status;
> +};
> +
> +static struct coretemp_data *coretemp_update_device(struct device *dev);
> +
> +/*
> + * Sysfs stuff
> + */
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +			  *devattr, char *buf)
> +{
> +	int ret;
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct coretemp_data *data =3D dev_get_drvdata(dev);
> +
> +	if (attr->index =3D SHOW_NAME)
> +		ret =3D sprintf(buf, "%s\n", data->name);
> +	else	/* show label */
> +		ret =3D sprintf(buf, "Core %d\n", data->id);
> +	return ret;
> +}
> +
> +static ssize_t show_alarm(struct device *dev, struct device_attribute
> +			  *devattr, char *buf)
> +{
> +	struct coretemp_data *data =3D coretemp_update_device(dev);
> +	/* read the Out-of-spec log, never clear */
> +	return sprintf(buf, "%d\n", (data->therm_status >> 5) & 1);
> +}
> +
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct coretemp_data *data =3D coretemp_update_device(dev);
> +	return sprintf(buf, "%d\n",
> +		       attr->index =3D
> +		       SHOW_TEMP ? data->temp : data->tjmax);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
> +			  SHOW_TEMP);
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
> +			  SHOW_TJMAX);
> +static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LA=
BEL);
> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
> +
> +static struct attribute *coretemp_attributes[] =3D {
> +	&sensor_dev_attr_name.dev_attr.attr,
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&dev_attr_temp1_crit_alarm.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group coretemp_group =3D {
> +	.attrs =3D coretemp_attributes,
> +};
> +
> +static struct coretemp_data *coretemp_update_device(struct device *dev)
> +{
> +	struct coretemp_data *data =3D dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> +		u32 eax, edx;
> +
> +		data->valid =3D 0;
> +		msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> +		data->therm_status =3D eax;
> +
> +		/* update only if data has been valid */
> +		if (eax & 0x80000000) {
> +			data->temp =3D data->tjmax - (((data->therm_status >> 16)
> +							& 0x7f) * 1000);
> +			data->valid =3D 1;
> +		}

When could the data not be valid? I think it's a problem that we may
return an old cached value to user-space and don't even let the user
know.

> +		data->last_updated =3D jiffies;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return data;
> +}
> +
> +static int __devinit coretemp_probe(struct platform_device *pdev)
> +{
> +	struct coretemp_data *data;
> +	struct cpuinfo_x86 *c =3D &(cpu_data)[pdev->id];
> +	int err;
> +	u32 eax, edx;
> +
> +	if (!(data =3D kzalloc(sizeof(struct coretemp_data), GFP_KERNEL))) {
> +		err =3D -ENOMEM;
> +		dev_err(&pdev->dev, "Out of memory\n");
> +		goto exit;
> +	}
> +
> +	data->id =3D pdev->id;
> +	data->name =3D "coretemp";
> +	mutex_init(&data->update_lock);
> +	/* Tjmax default is 100C */

100 degrees C.

> +	data->tjmax =3D 100000;
> +
> +	/* Some processors have Tjmax 85 following magic should detect it=20
> +	   Intel won't disclose the information without signed NDA, but
> +	   individuals cannot sign it. Catch(ed) 22.
> +	*/
> +
> +	if (((c->x86_model =3D 0xf) && (c->x86_mask > 3 )) ||

Remove the space before closing parenthesis.

> +		(c->x86_model =3D 0xe))  {
> +

No blank line here.

> +		err =3D msr_read(data->id, 0xee, &eax, &edx);
> +		if (err) {
> +			dev_warn(&pdev->dev,
> +				 "Unable to access MSR 0xEE, Tjmax left at %d\n",
> +				 data->tjmax);

Maybe data->tjmax/1000? "100000" will sound weird to the user.

Also, when is this supposed to happen?

> +		} else if (eax & 0x40000000) {
> +			data->tjmax =3D 85000;
> +		}
> +	}
> +
> +	/* test if we can access the THERM_STATUS MSR */
> +	err =3D msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> +
> +	if (err) {

No blank like between action and error check please.

> +		dev_err(&pdev->dev,
> +			"Unable to access THERM_STATUS MSR, giving up\n");
> +		goto exit_free;
> +	}

Don't you want to do that test before you attempt to find the Tjmax
value?

> +	platform_set_drvdata(pdev, data);
> +
> +	if ((err =3D sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
> +		goto exit_free;
> +
> +	data->class_dev =3D hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err =3D PTR_ERR(data->class_dev);
> +		dev_err(&pdev->dev, "Class registration failed (%d)\n",
> +			err);
> +		goto exit_class;
> +	}
> +
> +	dev_warn(&pdev->dev, "This driver uses undocumented features of Core "
> +			"CPU (Intel will not disclose the information to "
> +			"individuals). Temperature might be wrong!\n");

This warning doesn't belong there, it's driver-wide and not device
specific, so I think you should move it to coretemp_init. It will avoid
that you print it multiple times.

> +	return 0;
> +
> +exit_class:
> +	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int __devexit coretemp_remove(struct platform_device *pdev)
> +{
> +	struct coretemp_data *data =3D platform_get_drvdata(pdev);
> +
> +	hwmon_device_unregister(data->class_dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct platform_driver coretemp_driver =3D {
> +	.driver =3D {
> +		   .owner =3D THIS_MODULE,
> +		   .name =3D DRVNAME,
> +		   },

Indentation.

> +	.probe =3D coretemp_probe,
> +	.remove =3D __devexit_p(coretemp_remove),
> +};
> +
> +struct pdev_entry {
> +	struct list_head list;
> +	struct platform_device *pdev;
> +	unsigned int cpu;
> +};
> +
> +static LIST_HEAD(pdev_list);
> +static DEFINE_MUTEX(pdev_list_mutex);
> +
> +static int __cpuinit coretemp_devices_add(unsigned int cpu)

Should be named coretemp_device_add (no S) - it only adds one device at
a time.

> +{
> +	int err;
> +	struct platform_device *pdev;
> +	struct pdev_entry *pdev_entry;
> +
> +	pdev =3D platform_device_alloc(DRVNAME, cpu);
> +	if (!pdev) {
> +		err =3D -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto exit;
> +

Extra blank line.

> +	}
> +
> +	pdev_entry =3D kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
> +

No blank line here please.

> +	if (!pdev_entry) {
> +		err =3D -ENOMEM;
> +		goto exit_device_put;
> +	}
> +
> +	err =3D platform_device_add(pdev);
> +

Nor here.

> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> +		       err);
> +		goto exit_device_free;
> +	}
> +
> +	pdev_entry->pdev =3D pdev;
> +	pdev_entry->cpu =3D cpu;
> +	mutex_lock(&pdev_list_mutex);
> +	list_add_tail(&pdev_entry->list, &pdev_list);
> +	mutex_unlock(&pdev_list_mutex);
> +
> +	return 0;
> +
> +exit_device_free:
> +	kfree(pdev_entry);
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit:
> +	return err;
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +void coretemp_devices_remove(unsigned int cpu)
> +{
> +	struct pdev_entry *p, *n;
> +	mutex_lock(&pdev_list_mutex);
> +	list_for_each_entry_safe(p, n, &pdev_list, list) {
> +		if (p->cpu =3D cpu) {
> +			platform_device_unregister(p->pdev);
> +			list_del(&p->list);
> +			kfree(p);
> +		}
> +	}
> +	mutex_unlock(&pdev_list_mutex);
> +}
> +
> +static int coretemp_cpu_callback(struct notifier_block *nfb,
> +				 unsigned long action, void *hcpu)
> +{
> +	unsigned int cpu =3D (unsigned long) hcpu;
> +
> +	switch (action) {
> +	case CPU_ONLINE:
> +		coretemp_devices_add(cpu);
> +		break;
> +	case CPU_DEAD:
> +		coretemp_devices_remove(cpu);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block __cpuinitdata coretemp_cpu_notifier =3D {
> +	.notifier_call =3D coretemp_cpu_callback,
> +};
> +#endif				/* !CONFIG_HOTPLUG_CPU */
> +
> +static int __init coretemp_init(void)
> +{
> +	int i, err =3D -ENODEV;
> +	struct pdev_entry *p, *n;
> +
> +	/* quick check if we run Intel */
> +	if (cpu_data[0].x86_vendor !=3D X86_VENDOR_INTEL)
> +		goto exit;
> +
> +	err =3D platform_driver_register(&coretemp_driver);
> +	if (err)
> +		goto exit;
> +
> +	for_each_online_cpu(i) {
> +		struct cpuinfo_x86 *c =3D &(cpu_data)[i];
> +
> +		/* check if family 6, models e, f */
> +		if ((c->cpuid_level < 0) || (c->x86 !=3D 0x6) ||
> +		    !((c->x86_model =3D 0xe) || (c->x86_model =3D 0xf))) {
> +
> +			/* supported CPU not found, but report the unknown
> +			   family 6 CPU */
> +			if ((c->x86 =3D 0x6) && (c->x86_model > 0xf))
> +				printk(KERN_WARNING DRVNAME ": Unknown CPU, please"
> + 			   " report to the lm-sensors at lm-sensors.org\n");

Errr, no, please don't do that. When Intel releases a new CPU, we don't
want millions of users to report on our mailing list. When such a CPU is
available, we'll know soon enough, I think.

> +			continue;
> +		}
> +
> +		err =3D coretemp_devices_add(i);
> +		if (err)
> +			goto exit_driver;
> +	}
> +	if (list_empty(&pdev_list)) {
> +		err =3D -ENODEV;
> +		goto exit_driver_unreg;
> +	}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +	register_hotcpu_notifier(&coretemp_cpu_notifier);
> +#endif
> +	return 0;
> +
> +exit_driver:

That label isn't very explicit, maybe "exit_devices_unreg"?

> +	mutex_lock(&pdev_list_mutex);
> +	list_for_each_entry_safe(p, n, &pdev_list, list) {
> +		platform_device_unregister(p->pdev);
> +		list_del(&p->list);
> +		kfree(p);
> +	}
> +	mutex_unlock(&pdev_list_mutex);
> +exit_driver_unreg:
> +	platform_driver_unregister(&coretemp_driver);
> +exit:
> +	return err;
> +}
> +
> +static void __exit coretemp_exit(void)
> +{
> +	struct pdev_entry *p, *n;
> +#ifdef CONFIG_HOTPLUG_CPU
> +	unregister_hotcpu_notifier(&coretemp_cpu_notifier);
> +#endif
> +	mutex_lock(&pdev_list_mutex);
> +	list_for_each_entry_safe(p, n, &pdev_list, list) {
> +		platform_device_unregister(p->pdev);
> +		list_del(&p->list);
> +		kfree(p);
> +	}
> +	mutex_unlock(&pdev_list_mutex);
> +	platform_driver_unregister(&coretemp_driver);
> +}
> +
> +MODULE_AUTHOR("Rudolf Marek <r.marek at assembler.cz>");
> +MODULE_DESCRIPTION("Intel Core temperature monitor");
> +MODULE_LICENSE("GPL");
> +
> +module_init(coretemp_init)
> +module_exit(coretemp_exit)
> Index: linux-2.6.20-rc4/drivers/hwmon/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.20-rc4.orig/drivers/hwmon/Kconfi=
g	2007-01-07 06:45:51.000000000 +0100
> +++ linux-2.6.20-rc4/drivers/hwmon/Kconfig	2007-01-14 21:40:33.336991782 =
+0100
> @@ -156,6 +156,14 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called atxp1.
> =20
> +config SENSORS_CORETEMP
> +	tristate "Intel Core (2) Duo/Solo temperature sensor"
> +	depends on HWMON && X86 && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the temperature
> +	  sensor inside your CPU. Supported all are all known variants
> +	  of Intel Core family.

"All known variants" is something which may change over time.

> +
>  config SENSORS_DS1621
>  	tristate "Dallas Semiconductor DS1621 and DS1625"
>  	depends on HWMON && I2C
> Index: linux-2.6.20-rc4/drivers/hwmon/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.20-rc4.orig/drivers/hwmon/Makefi=
le	2007-01-07 06:45:51.000000000 +0100
> +++ linux-2.6.20-rc4/drivers/hwmon/Makefile	2007-01-14 21:29:41.899868496=
 +0100
> @@ -21,6 +21,7 @@
>  obj-$(CONFIG_SENSORS_ADM9240)	+=3D adm9240.o
>  obj-$(CONFIG_SENSORS_AMS)	+=3D ams/
>  obj-$(CONFIG_SENSORS_ATXP1)	+=3D atxp1.o
> +obj-$(CONFIG_SENSORS_CORETEMP)	+=3D coretemp.o
>  obj-$(CONFIG_SENSORS_DS1621)	+=3D ds1621.o
>  obj-$(CONFIG_SENSORS_F71805F)	+=3D f71805f.o
>  obj-$(CONFIG_SENSORS_FSCHER)	+=3D fscher.o

Very nice driver otherwise, well done!

> Index: linux-2.6.20-rc4/Documentation/hwmon/coretemp
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null	1970-01-01 00:00:00.000000000 +0=
000
> +++ linux-2.6.20-rc4/Documentation/hwmon/coretemp	2007-01-14 22:01:58.766=
244221 +0100
> @@ -0,0 +1,37 @@
> +Kernel driver coretemp
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +  * All Intel Core family
> +    Prefix: 'coretemp'
> +    Addresses scanned: CPUID (family 0x6, models 0xe, 0xf)

These aren't addresses. Feel free to use a different label, we don't
have to stick to what I2C drivers needed in all other drivers.

> +    Datasheet: Intel 64 and IA-32 Architectures Software Developer's Man=
ual
> +               Volume 3A: System Programming Guide
> +
> +Author: Rudolf Marek
> +Contact: Rudolf Marek <r.marek at assembler.cz>

Instead of Contact here, please add an entry in MAINTAINERS, this is
where people are supposed to look.

> +
> +Description
> +-----------
> +
> +This driver permits reading temperature sensor embedded inside Intel Cor=
e CPU.
> +Temperature is measured in degrees Celsius and measurement resolution is
> +1 degree C. Valid temperatures are from 0 to TjMax degrees C, because
> +the actual temperature is in fact a delta from TjMax.

No, the actual temperature is, well... a real temperature. What you
mean is that the value reported in the CPU register is a delta from
TjMax.

> +
> +Temperature known as TjMax is the maximum junction temperature of proces=
sor.
> +Intel defines this temperature as 85C or 100C. At this temperature, prot=
ection
> +mechanism will perform actions to forcibly cool down the processor. Alarm
> +may be raised, if the temperature grows enough (more than TjMax) to trig=
ger
> +the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
> +
> +temp1_input	 - Core temperature (in milidegrees of Celsius).
> +temp1_crit	 - Maximum junction temperature  (in milidegrees of Celsius).

millidegrees Celsius (two Ls, no of)

> +temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
> +		   Correct CPU operation is no longer guaranteed.
> +temp1_label	 - Contains string with the "Core X", where X is processor
> +		   number.

s/with the //

> +
> +The TjMax temperature is set to 85C if undocumented model specific regis=
ter
> +(UMSR) 0xee has bit 30 set. If not the TjMax is 100C as documented in pr=
ocessor
> +datasheet. Intel will not disclose this information to individuals.

s/C/degrees C/

Can you please update your driver to use the new public MSR functions
and fix the minor issues I listed? Then it's ready for -mm as far as I
am concerned.

--=20
Jean Delvare

