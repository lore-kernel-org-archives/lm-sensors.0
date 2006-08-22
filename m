From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 22 Aug 2006 08:44:52 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor
Message-Id: <20060822104452.22d39b73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C69648.9060808@sh.cvut.cz>
In-Reply-To: <44C69648.9060808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch adds support for the temperature sensor(s) found in AMD K8 CPUs.
> 
> Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
> 
> Info for Jean:
> 
> This patch has only one bigger change compared to older version - the access 
> width to register is now whole 32bits. This is neccessary for future 
> enhancements because addtional reserved bits might be used for temperature, 
> gaining more precision. Trust me ;)

Your code would need further changes to support that anyway. I'm fine
with 32-bit reads anyway.

> The dependency is set to X86 because of usage of cpuid funcs. No need to check 
> for specific procesor because it is in fact PCI driver. The latest version
> works on dual core - dual procesor AMD server and it works fine on my single 
> core Opteron too.
> 
> I'm leaving for next week and something -> on thursday. I would like to get this 
> patch into 2.6.19, so if you have some minor comments please fix the patch as 
> you like.

Sorry for the late answer, here comes my review.

> diff -uprN linux-2.6.18-rc2/drivers/hwmon/k8temp.c linux-2.6.18-rc2-patched/drivers/hwmon/k8temp.c
> --- linux-2.6.18-rc2/drivers/hwmon/k8temp.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.18-rc2-patched/drivers/hwmon/k8temp.c	2006-07-25 23:45:00.274085500 +0200
> @@ -0,0 +1,278 @@
> +/*
> + * k8temp.c - Part of lm_sensors, Linux kernel modules for hardware
> + *               monitoring

No, this is part of the Linux kernel.

> + * Copyright (C) 2006 Rudolf Marek <r.marek at sh.cvut.cz>
> + *
> + * Inspired from the w83785 and amd756 driver.

Typo: drivers.

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
> +#include <linux/pci.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +
> +#define TEMP_FROM_REG(val)	((((val >> 16) & 0xFF) - 49) * 1000)
> +
> +/*
> + * Functions declaration
> + */
> +
> +static struct k8temp_data *k8temp_update_device(struct device *dev);

You can easily reorder the functions not to need this forward declaration.

> +
> +struct k8temp_data {
> +	struct class_device *class_dev;
> +	struct mutex update_lock;
> +	const char *name;
> +	char valid;		/* zero until following fields are valid */
> +	unsigned long last_updated;	/* in jiffies */
> +
> +	/* registers values */
> +	u8 sensors;		/* bit6 place can be changed, bit2 core */

I don't understand this comment.

> +	u32 temp[2][2];		/* core, place */
> +};
> +
> +static struct k8temp_data *k8temp_update_device(struct device *dev);

Duplicate forward declaration.

> +
> +/*
> + * Sysfs stuff
> + */
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +			 *devattr, char *buf)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute_2 *attr > +	    to_sensor_dev_attr_2(devattr);
> +	int core = attr->nr;
> +	int place = attr->index;
> +	struct k8temp_data *data = k8temp_update_device(dev);
> +	
> +	return sprintf(buf, "%d\n",
> +		       TEMP_FROM_REG(data->temp[core][place]));
> +}
> +
> +/* core, place */
> +
> +static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
> +static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
> +static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
> +static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +
> +static struct k8temp_data *k8temp_update_device(struct device *dev)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u8 tmp;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (!data->valid
> +	    || time_after(jiffies, data->last_updated + HZ * 2)) {
> +

No blank line here.

What's the rationale for limiting the updates to every other second?
For such a simple driver, and PCI accesses, which I guess are fast, I
would think every second is OK.

> +		dev_dbg(&pdev->dev, "Updating k8temp data.\n");
> +
> +		pci_read_config_byte(pdev, 0xe4, &tmp);
> +		tmp &= ~0x44;		/* Select sensor 0, core0 */
> +		pci_write_config_byte(pdev, 0xe4, tmp);
> +		pci_read_config_dword(pdev, 0xe4, &data->temp[0][0]);
> +
> +		if (data->sensors & 0x40) {
> +			tmp |= 0x40;	/* Select sensor 1, core0 */
> +			pci_write_config_byte(pdev, 0xe4, tmp);
> +			pci_read_config_dword(pdev, 0xe4,
> +					      &data->temp[0][1]);
> +		}
> +
> +		if (data->sensors & 0x4) {
> +			tmp &= ~0x40;	/* Select sensor 0, core1 */
> +			tmp |= 0x4;
> +			pci_write_config_byte(pdev, 0xe4, tmp);
> +			pci_read_config_dword(pdev, 0xe4,
> +					      &data->temp[1][0]);
> +
> +			if (data->sensors & 0x40) {
> +				tmp |= 0x40;	/* Select sensor 1, core1 */
> +				pci_write_config_byte(pdev, 0xe4, tmp);
> +				pci_read_config_dword(pdev, 0xe4,
> +						      &data->temp[1][1]);
> +			}
> +		}

Maybe you could have defines for registers and bits, to make the code
a bit clearer.

> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return data;
> +}
> +
> +static struct pci_device_id k8temp_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
> +	{ 0 },
> +};
> +
> +static int __devinit k8temp_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *id)
> +{
> +	int err;
> +	u8 tmp, temp;

"tmp" is a poor name a too similar to "temp" so it's confusing. Please
find a better name.

> +	struct k8temp_data *data;
> +	u32 cpuid = cpuid_eax(1);
> +
> +	/* this feature should be available since SH-C0 core */
> +	if ((cpuid = 0xf40) || (cpuid = 0xf50) || (cpuid = 0xf51)) {
> +		err = -ENODEV;
> +		goto exit;
> +	}

Isn't this test a bit weak? Are you sure these are the only unsupported
K8 out there? What about (cpuid <= 0xf51) instead? Or even better
(cpuid < {first supported})?

> +
> +	if (!(data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	pci_read_config_byte(pdev, 0xe4, &tmp);
> +	tmp &= ~0x44;		/* Select sensor 0, core0 */
> +	pci_write_config_byte(pdev, 0xe4, tmp);
> +	pci_read_config_byte(pdev, 0xe4, &tmp);
> +
> +	if (tmp & 0x44) {
> +		dev_err(&pdev->dev, "Configuration bits stuck at 1!\n");
> +		err = -ENODEV;
> +		goto exit_free;
> +	}
> +
> +	tmp |= 0x44;
> +	pci_write_config_byte(pdev, 0xe4, tmp);
> +
> +	/* now we know if we can change core and/or sensor */
> +	pci_read_config_byte(pdev, 0xe4, &data->sensors);
> +
> +	if (data->sensors & 0x40) {
> +		tmp &= ~0x4;	/* Select sensor 1, core0 */
> +		pci_write_config_byte(pdev, 0xe4, tmp);
> +		pci_read_config_byte(pdev, 0xe6, &temp);
> +		if (!temp)	/* if temp is 0 -49C is not likely */
> +			data->sensors &= ~0x40;
> +	}
> +
> +	if (data->sensors & 0x4) {
> +		tmp &= ~0x40;	/* Select sensor 0, core1 */
> +		tmp |= 0x4;

This one belongs to the previous block.

> +		pci_write_config_byte(pdev, 0xe4, tmp);
> +		pci_read_config_byte(pdev, 0xe6, &temp);
> +		if (!temp)	/* if temp is 0 -49C is not likely */
> +			data->sensors &= ~0x4;
> +	}
> +
> +	data->name = "k8temp";
> +	mutex_init(&data->update_lock);
> +	dev_set_drvdata(&pdev->dev, data);
> +
> +	/* Register sysfs hooks */
> +	data->class_dev = hwmon_device_register(&pdev->dev);
> +

No blank line here.

> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto exit_free;
> +	}
> +
> +	device_create_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_input.dev_attr);
> +
> +	/* sensor can be changed and reports something */
> +	if (data->sensors & 0x40)
> +		device_create_file(&pdev->dev,
> +				   &sensor_dev_attr_temp2_input.dev_attr);
> +
> +	/* core can be changed and reports something */
> +	if (data->sensors & 0x4) {
> +		device_create_file(&pdev->dev,
> +				   &sensor_dev_attr_temp3_input.dev_attr);
> +
> +		if (data->sensors & 0x40)
> +			device_create_file(&pdev->dev,
> +					   &sensor_dev_attr_temp4_input.
> +					   dev_attr);
> +	}
> +
> +	device_create_file(&pdev->dev, &dev_attr_name);

According to the new laws you must check the return value of
device_create_file. Do not forget to remove the already created files
on error.

You should also create the files first, before registering with the
hwmon class.

> +	return 0;
> +
> +exit_free:
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static void __devexit k8temp_remove(struct pci_dev *pdev)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(&pdev->dev);
> +
> +	hwmon_device_unregister(data->class_dev);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp2_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp3_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp4_input.dev_attr);
> +	device_remove_file(&pdev->dev, &dev_attr_name);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	kfree(data);
> +}
> +
> +static struct pci_driver k8temp_driver = {
> +	.name = "k8temp",
> +	.id_table = k8temp_ids,
> +	.probe = k8temp_probe,
> +	.remove = __devexit_p(k8temp_remove),
> +};
> +
> +static int __init k8temp_init(void)
> +{
> +	return pci_module_init(&k8temp_driver);
> +}
> +
> +static void __exit k8temp_exit(void)
> +{
> +	pci_unregister_driver(&k8temp_driver);
> +}
> +
> +MODULE_AUTHOR("Rudolf Marek <r.marek at sh.cvut.cz>");
> +MODULE_DESCRIPTION("k8 core temperature monitor");

AMD K8.

> +MODULE_LICENSE("GPL");
> +
> +module_init(k8temp_init)
> +module_exit(k8temp_exit)
> diff -uprN linux-2.6.18-rc2/drivers/hwmon/Kconfig linux-2.6.18-rc2-patched/drivers/hwmon/Kconfig
> --- linux-2.6.18-rc2/drivers/hwmon/Kconfig	2006-07-15 23:53:08.000000000 +0200
> +++ linux-2.6.18-rc2-patched/drivers/hwmon/Kconfig	2006-07-25 23:18:59.008512500 +0200
> @@ -94,6 +94,16 @@ config SENSORS_ADM9240
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm9240.
>  
> +config SENSORS_K8TEMP
> +	tristate "AMD K8 processor sensor"
> +	depends on HWMON && X86 && EXPERIMENTAL

Depends on PCI as well.

> +	help
> +	  If you say yes here you get support for the temperature
> +	  sensor(s) inside your AMD K8 CPU.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called k8temp.
> +

Looks quite good, and it works very well for me too (single core,
single sensor). Please fix the remaining issues and we can merge that
driver.

Can we have a documentation file for that driver?

Thanks,
-- 
Jean Delvare

