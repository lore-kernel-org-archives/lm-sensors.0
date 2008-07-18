From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 18 Jul 2008 21:08:13 +0000
Subject: [lm-sensors] AMD Phenom temperature driver
Message-Id: <4881063D.60906@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000109000500060003010905"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109000500060003010905
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I think I put all parties up in CC. Thanks to Andreas, I have received missing 
information about the TControlMax temperature. It means we can get further to a 
new driver.

I did some experimental driver which works fine (attached as k8temp.c) Kryzstof 
Went even further and made changes to original k8temp driver.

I will go for vacation soonish (middle of next week) and I'm very busy, but at 
least we can start. I will write a short list of things which needs to be 
discussed in the meanwhile:

1) driver name

AMD proposes the change to amdtemp (from k8temp) I think we can merge the 
drivers together, it should be still simple.

Jean, please do you remember how autoloading/driver name change is handled in 
the kernel? I have some feeling that it should be simple to handle. Please confirm.

The name change can be done if we know that old name will work, so we dont break 
too much things around.

2) Maximum temperature.

The new Phenom temperature is non-physical it means we must know the limit so we 
know when we cross it.

Therefore our new driver must export either temp1_max or temp1_crit. The 
TcontrolMax is for all fam 10h CPUs 70 degrees.

The Intel driver has temp1_max as maximum temperature from which all fans must 
start cooling. The temp1_crit is when the CPU will fail.

I think the thremtrip_l is asserted for much higher temperatures, I think we can 
go for temp1_max.

We can put the TcontrolMax into a variable, because for future revisions we may 
need cpuid to put there right value.

3) Errata #319

I think all CPU revisions still may have problem with the temp sensor inside the 
CPU (not the diode interface which is analog and works fine).

Please can someone test mine k8temp.c attached, and report back the values you 
got? If we detect a CPU with the errata we should print a warning to syslog.

4) Kryzstof driver.

Kryzstof already posted to me some changes for driver merger. Please can you 
repost them in form of patch here to mailing list? Please avoid white space 
changes. AMD suggest to call K10 fam10 because it is in fact family 10h
and not K10. From CPUID perspective it is more model then family to make it worse ;)

5) merged driver architecture

For the different code conditions I would propose some amdfam variable with
model code (0xe) 0xf 0x10 and some

if data->amdfam = FAM_E ...

Now the neat trick how the PCI driver teach about CPUID. There is a register 
with CPUID inside function 3 (offset FC), we can read the CPUID from there, and 
get the model for 10h and fh model eh and older do not have this register.

We cannot use cpuid_eax, because we may have two processors with different 
erratas and we need to know which is which PCI device. The old K8temp driver 
simply ignored this - the module code may be executed on different CPU other 
then PCI device we are operating on (multi CPU system not multicore).

  Therefore we can do:

1) for PCI ID of "old" family put amdfam with 0xf
2) for new fill 10h and save CPUID from the register FC
3) check the errata, print warning
4) future versions may need the cpuid info for different TcontolMax
5) for fam10 create new get temps funs, new formula

6) enhancements for older k8temp

this should be done in separate patch.
6a) print warning about sensors inaccurancy for all model 0xf
6b) extend scale to .00 .25 .50 .75
6c) the automatic core detecting may detect single core cpu which were in fact 
dualcore but with disabled core. Typically the second core has -49. For some 
reason it gets printed on mine sempron G2 fam 0fh

Of course this are just mine ideas, feel free to come with even better ideas ;)

The code is very welcomed too, I can try to at least review it when I will have 
some free time. I can code this too but free time window is two/three weeks far.

Thanks,
Rudolf

--------------000109000500060003010905
Content-Type: text/x-csrc;
 name="k8temp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k8temp.c"

/*
 * k10temp.c - Linux kernel module for hardware monitoring
 *
 * Copyright (C) 2008 Rudolf Marek <r.marek@assembler.cz>
 *
 * Inspired from the k8temp driver.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 */

#include <linux/module.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/pci.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>

/* 1000 / 8 = 125 no mask because we shift from bit 31 */
#define TEMP_FROM_REG(val)	(((val) >> 21) * 125)
#define REG_TEMP	0xa4

struct k10temp_data {
	struct device *hwmon_dev;
	struct mutex update_lock;
	const char *name;
	char valid;		/* zero until following fields are valid */
	unsigned long last_updated;	/* in jiffies */

	/* registers values */
	u32 temp;		/* raw value */
};

static struct k10temp_data *k10temp_update_device(struct device *dev)
{
	struct k10temp_data *data = dev_get_drvdata(dev);
	struct pci_dev *pdev = to_pci_dev(dev);
	u8 tmp;

	mutex_lock(&data->update_lock);

	if (!data->valid
	    || time_after(jiffies, data->last_updated + HZ)) {


		pci_read_config_dword(pdev, REG_TEMP, &data->temp);

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);
	return data;
}

/*
 * Sysfs stuff
 */

static ssize_t show_name(struct device *dev, struct device_attribute
			 *devattr, char *buf)
{
	struct k10temp_data *data = dev_get_drvdata(dev);

	return sprintf(buf, "%s\n", data->name);
}


static ssize_t show_temp(struct device *dev,
			 struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute_2 *attr =
	    to_sensor_dev_attr_2(devattr);
	int core = attr->nr;
	int place = attr->index;
	struct k10temp_data *data = k10temp_update_device(dev);

	return sprintf(buf, "%d\n",
		       TEMP_FROM_REG(data->temp));
}

/* core, place */

static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

static struct pci_device_id k10temp_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1203) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, k10temp_ids);

static int __devinit k10temp_probe(struct pci_dev *pdev,
				  const struct pci_device_id *id)
{
	int err;
	u8 scfg;
	u32 temp;
	struct k10temp_data *data;

	if (!(data = kzalloc(sizeof(struct k10temp_data), GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}

	data->name = "k10temp";
	mutex_init(&data->update_lock);
	dev_set_drvdata(&pdev->dev, data);

	/* Register sysfs hooks */
	err = device_create_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	if (err)
		goto exit_remove;

	err = device_create_file(&pdev->dev, &dev_attr_name);
	if (err)
		goto exit_remove;

	data->hwmon_dev = hwmon_device_register(&pdev->dev);

	if (IS_ERR(data->hwmon_dev)) {
		err = PTR_ERR(data->hwmon_dev);
		goto exit_remove;
	}

	return 0;

exit_remove:
	device_remove_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	device_remove_file(&pdev->dev, &dev_attr_name);
exit_free:
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
exit:
	return err;
}

static void __devexit k10temp_remove(struct pci_dev *pdev)
{
	struct k10temp_data *data = dev_get_drvdata(&pdev->dev);

	hwmon_device_unregister(data->hwmon_dev);
	device_remove_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	device_remove_file(&pdev->dev, &dev_attr_name);
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
}

static struct pci_driver k10temp_driver = {
	.name = "k10temp",
	.id_table = k10temp_ids,
	.probe = k10temp_probe,
	.remove = __devexit_p(k10temp_remove),
};

static int __init k10temp_init(void)
{
	return pci_register_driver(&k10temp_driver);
}

static void __exit k10temp_exit(void)
{
	pci_unregister_driver(&k10temp_driver);
}

MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
MODULE_DESCRIPTION("AMD K10 core temperature monitor");
MODULE_LICENSE("GPL");

module_init(k10temp_init)
module_exit(k10temp_exit)

--------------000109000500060003010905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000109000500060003010905--
