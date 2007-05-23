From: Jeffrey Garrett <jgarrett@teamhpc.com>
Date: Wed, 23 May 2007 00:05:59 +0000
Subject: [lm-sensors] AMB FB DIMM driver
Message-Id: <20070523000559.GA7009@jgarrett.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a rough approximation of a driver for the Intel AMB FB-DIMM
temperature sensors...

There is a somewhat lonely, but relevant ticket at
http://www.lm-sensors.org/ticket/2143

The sensors exposed on the 5000P chipsets are located in a contiguous
range of memory spanning 128k.  Logically, this space is split into 2k
blocks, each of which representing a potential DIMM.  The temperature
of a DIMM in this PCIish space is at function 3, offset 0x85.  That is,
you just have to read [base addr] + 2048*[dimm idx] + 3*256 + 0x85.
The temperature is in 0.5 deg C.  So for example, 0x10 = 8C.

To find the base address of this contiguous area of memory, all you have
to do is look at your PCI configuration...  It's exposed at device 16,
function 0, offset 0x48.  This is the device 0x8086:0x25f0.

To find your sensors, one can scan the 128k area of memory for what
"looks" right.  The ticket suggested looking for a vendor id of 0x8086
(Intel) starting the particular 2k slot.  This works on the DSBF-D, but
I have a Tyan board which is less agreeable.  But on both boards, the
non-DIMM areas in that space have vendor id:device id equal to
0xffff:0xffff.  In other words, we can just look for anything not all
ones.  I haven't found anything on paper that justifies this, but it
works on the boards I have.  ;)

The attached driver does pretty much just this:  it's linked to the
0x8086:0x25f0 id, and it looks in the configuration space for the base
address, and scans for valid areas.  It then exposes this via sysfs.
I used k8temp as a template.

It is a bit rough right now.  It did work with a recent vintage 2.6.20
kernel, on at least two different boards.

Comments/criticisms/flames welcome.

Thanks,
Jeff Garrett
TeamHPC

--ZPt4rx8FFjLCG7dd
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="ambtemp.c"

/*
 * ambtemp.c - Linux kernel module for hardware monitoring
 *
 * Copyright (C) 2007 Jeff Garrett <jgarrett@teamhpc.com>
 *
 * Inspired (stolen?) from the k8temp driver.
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
#include <asm/bitops.h>


#define TEMP_FROM_REG(val)  ((((u16)(val)) * 500))
#define AMBASE_HIGH         0x48
#define AMB_EXTENT          0x20000
#define TEMP_OFFSET         ((3*256)+0x85)

struct ambtemp_data {
	struct class_device *class_dev;
	struct mutex update_lock;
	const char *name;
	char valid;		/* zero until following fields are valid */
	unsigned long last_updated;	/* in jiffies */

	/* register values */
	void __iomem *base;
	u64 valid_sensors;	/* bitmap for which sensors are present */
	u8  temp[64];		/* all 64 possible sensors */
};

static struct ambtemp_data *ambtemp_update_device(struct device *dev)
{
	struct ambtemp_data *data = dev_get_drvdata(dev);
	int i;

	mutex_lock(&data->update_lock);

	if (!data->valid
		|| time_after(jiffies, data->last_updated + HZ)) {

		/* Read the sensors */
		for (i = 0; i < 64; i++)
			if (test_bit(i, &data->valid_sensors))
				data->temp[i] = readb(data->base + 2048*i + TEMP_OFFSET);

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
	struct ambtemp_data *data = dev_get_drvdata(dev);

	return sprintf(buf, "%s\n", data->name);
}


static ssize_t show_temp(struct device *dev,
			 struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr =
		to_sensor_dev_attr(devattr);
	int sensor = attr->index;
	struct ambtemp_data *data = ambtemp_update_device(dev);

	return sprintf(buf, "%d\n",
			   TEMP_FROM_REG(data->temp[sensor]));
}


/* There are a total of 4 channels, with 16 possible AMBs per channel */
static struct sensor_device_attribute temp_input[] = {
	SENSOR_ATTR(temp00_input, S_IRUGO, show_temp, NULL, 0),
	SENSOR_ATTR(temp01_input, S_IRUGO, show_temp, NULL, 1),
	SENSOR_ATTR(temp02_input, S_IRUGO, show_temp, NULL, 2),
	SENSOR_ATTR(temp03_input, S_IRUGO, show_temp, NULL, 3),
	SENSOR_ATTR(temp04_input, S_IRUGO, show_temp, NULL, 4),
	SENSOR_ATTR(temp05_input, S_IRUGO, show_temp, NULL, 5),
	SENSOR_ATTR(temp06_input, S_IRUGO, show_temp, NULL, 6),
	SENSOR_ATTR(temp07_input, S_IRUGO, show_temp, NULL, 7),
	SENSOR_ATTR(temp08_input, S_IRUGO, show_temp, NULL, 8),
	SENSOR_ATTR(temp09_input, S_IRUGO, show_temp, NULL, 9),
	SENSOR_ATTR(temp0a_input, S_IRUGO, show_temp, NULL, 10),
	SENSOR_ATTR(temp0b_input, S_IRUGO, show_temp, NULL, 11),
	SENSOR_ATTR(temp0c_input, S_IRUGO, show_temp, NULL, 12),
	SENSOR_ATTR(temp0d_input, S_IRUGO, show_temp, NULL, 13),
	SENSOR_ATTR(temp0e_input, S_IRUGO, show_temp, NULL, 14),
	SENSOR_ATTR(temp0f_input, S_IRUGO, show_temp, NULL, 15),
	SENSOR_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 16),
	SENSOR_ATTR(temp11_input, S_IRUGO, show_temp, NULL, 17),
	SENSOR_ATTR(temp12_input, S_IRUGO, show_temp, NULL, 18),
	SENSOR_ATTR(temp13_input, S_IRUGO, show_temp, NULL, 19),
	SENSOR_ATTR(temp14_input, S_IRUGO, show_temp, NULL, 20),
	SENSOR_ATTR(temp15_input, S_IRUGO, show_temp, NULL, 21),
	SENSOR_ATTR(temp16_input, S_IRUGO, show_temp, NULL, 22),
	SENSOR_ATTR(temp17_input, S_IRUGO, show_temp, NULL, 23),
	SENSOR_ATTR(temp18_input, S_IRUGO, show_temp, NULL, 24),
	SENSOR_ATTR(temp19_input, S_IRUGO, show_temp, NULL, 25),
	SENSOR_ATTR(temp1a_input, S_IRUGO, show_temp, NULL, 26),
	SENSOR_ATTR(temp1b_input, S_IRUGO, show_temp, NULL, 27),
	SENSOR_ATTR(temp1c_input, S_IRUGO, show_temp, NULL, 28),
	SENSOR_ATTR(temp1d_input, S_IRUGO, show_temp, NULL, 29),
	SENSOR_ATTR(temp1e_input, S_IRUGO, show_temp, NULL, 30),
	SENSOR_ATTR(temp1f_input, S_IRUGO, show_temp, NULL, 31),
	SENSOR_ATTR(temp20_input, S_IRUGO, show_temp, NULL, 32),
	SENSOR_ATTR(temp21_input, S_IRUGO, show_temp, NULL, 33),
	SENSOR_ATTR(temp22_input, S_IRUGO, show_temp, NULL, 34),
	SENSOR_ATTR(temp23_input, S_IRUGO, show_temp, NULL, 35),
	SENSOR_ATTR(temp24_input, S_IRUGO, show_temp, NULL, 36),
	SENSOR_ATTR(temp25_input, S_IRUGO, show_temp, NULL, 37),
	SENSOR_ATTR(temp26_input, S_IRUGO, show_temp, NULL, 38),
	SENSOR_ATTR(temp27_input, S_IRUGO, show_temp, NULL, 39),
	SENSOR_ATTR(temp28_input, S_IRUGO, show_temp, NULL, 40),
	SENSOR_ATTR(temp29_input, S_IRUGO, show_temp, NULL, 41),
	SENSOR_ATTR(temp2a_input, S_IRUGO, show_temp, NULL, 42),
	SENSOR_ATTR(temp2b_input, S_IRUGO, show_temp, NULL, 43),
	SENSOR_ATTR(temp2c_input, S_IRUGO, show_temp, NULL, 44),
	SENSOR_ATTR(temp2d_input, S_IRUGO, show_temp, NULL, 45),
	SENSOR_ATTR(temp2e_input, S_IRUGO, show_temp, NULL, 46),
	SENSOR_ATTR(temp2f_input, S_IRUGO, show_temp, NULL, 47),
	SENSOR_ATTR(temp30_input, S_IRUGO, show_temp, NULL, 48),
	SENSOR_ATTR(temp31_input, S_IRUGO, show_temp, NULL, 49),
	SENSOR_ATTR(temp32_input, S_IRUGO, show_temp, NULL, 50),
	SENSOR_ATTR(temp33_input, S_IRUGO, show_temp, NULL, 51),
	SENSOR_ATTR(temp34_input, S_IRUGO, show_temp, NULL, 52),
	SENSOR_ATTR(temp35_input, S_IRUGO, show_temp, NULL, 53),
	SENSOR_ATTR(temp36_input, S_IRUGO, show_temp, NULL, 54),
	SENSOR_ATTR(temp37_input, S_IRUGO, show_temp, NULL, 55),
	SENSOR_ATTR(temp38_input, S_IRUGO, show_temp, NULL, 56),
	SENSOR_ATTR(temp39_input, S_IRUGO, show_temp, NULL, 57),
	SENSOR_ATTR(temp3a_input, S_IRUGO, show_temp, NULL, 58),
	SENSOR_ATTR(temp3b_input, S_IRUGO, show_temp, NULL, 59),
	SENSOR_ATTR(temp3c_input, S_IRUGO, show_temp, NULL, 60),
	SENSOR_ATTR(temp3d_input, S_IRUGO, show_temp, NULL, 61),
	SENSOR_ATTR(temp3e_input, S_IRUGO, show_temp, NULL, 62),
	SENSOR_ATTR(temp3f_input, S_IRUGO, show_temp, NULL, 63),
};

static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

static struct pci_device_id ambtemp_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x25f0) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, ambtemp_ids);

static int __devinit ambtemp_probe(struct pci_dev *pdev,
				  const struct pci_device_id *id)
{
	int err;
	int i;
	void *addr;
	unsigned long c;
	
	struct ambtemp_data *data;

	/* The Error Reporting Registers we piggy back on show up at
	 * 10.0, 10.1, and 10.2.  We only want the first function.  The
	 * AMBASE slot on the others is wrong.
	 */
	if (!(PCI_SLOT(pdev->devfn) == 0x10 && PCI_FUNC(pdev->devfn) == 0x00))
	{
		/* Go away */
		err = 0;
		goto exit;
	}

	if (!(data = kzalloc(sizeof(struct ambtemp_data), GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}

	printk(KERN_INFO "ambtemp: Device found at %04x:%02x.%01x\n", 
		pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
	printk(KERN_INFO "ambtemp: Scanning for sensors...\n");

	/* Reserve the sensor range starting at AMBASE */
	pci_read_config_dword(pdev, AMBASE_HIGH, &addr);
	data->base = ioremap(addr, AMB_EXTENT);
	if (!data->base)
	{
		err = -EBUSY;
		goto exit;
	}

	for (i = 0; i < 64; i++)
	{
		c = readl(data->base + 2048*i);
		if (c != 0xffffffffl)
		{
			set_bit(i, &data->valid_sensors);
			printk(KERN_INFO "ambtemp: Sensor at offset 0x%02x\n", i);
		}
	}

	data->name = "ambtemp";
	mutex_init(&data->update_lock);
	dev_set_drvdata(&pdev->dev, data);

	/* Register sysfs hooks */
	for (i = 0; i < ARRAY_SIZE(temp_input); i++)
		if (test_bit(i, &data->valid_sensors))
		{
			err = device_create_file(&pdev->dev, &temp_input[i].dev_attr);
			if (err)
				goto exit_remove;
		}

	err = device_create_file(&pdev->dev, &dev_attr_name);
	if (err)
		goto exit_remove;

	data->class_dev = hwmon_device_register(&pdev->dev);

	if (IS_ERR(data->class_dev)) {
		err = PTR_ERR(data->class_dev);
		goto exit_remove;
	}

	return 0;

exit_remove:
	for (i = 0; i < ARRAY_SIZE(temp_input); i++)
		device_remove_file(&pdev->dev, &temp_input[i].dev_attr);

	device_remove_file(&pdev->dev, &dev_attr_name);
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
exit:
	return err;
}

static void __devexit ambtemp_remove(struct pci_dev *pdev)
{
	int i;
	struct ambtemp_data *data = dev_get_drvdata(&pdev->dev);

	hwmon_device_unregister(data->class_dev);
	for (i = 0; i < ARRAY_SIZE(temp_input); i++)
		device_remove_file(&pdev->dev, &temp_input[i].dev_attr);

	device_remove_file(&pdev->dev, &dev_attr_name);
	dev_set_drvdata(&pdev->dev, NULL);

	iounmap(data->base);
	kfree(data);
}

static struct pci_driver ambtemp_driver = {
	.name = "ambtemp",
	.id_table = ambtemp_ids,
	.probe = ambtemp_probe,
	.remove = __devexit_p(ambtemp_remove),
};

static int __init ambtemp_init(void)
{
	return pci_register_driver(&ambtemp_driver);
}

static void __exit ambtemp_exit(void)
{
	pci_unregister_driver(&ambtemp_driver);
}

MODULE_AUTHOR("Jeff Garrett <jgarrett@teamhpc.com>");
MODULE_DESCRIPTION("Intel AMB temperature monitor");
MODULE_LICENSE("GPL");

module_init(ambtemp_init)
module_exit(ambtemp_exit)

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--ZPt4rx8FFjLCG7dd--
