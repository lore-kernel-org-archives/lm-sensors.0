From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041128193640.GB5855@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all:

I've started a complete re-write of the i2c-i801 SMBus driver.  As
compared to the old one, this one:

1) Supports fewer transaction types... still TODO

2) Does not have any BIOS workaround nastiness.  I am hoping that
I can leave that out and that people who need that can be directed
to just use the old driver.

3) Does not support PEC (not sure who uses it... can also be TODO
if there's interest).

And the primary difference 4) uses interrupts instead of polling.

I'm not exactly a stranger to interrupt-handling, having designed
whole interrupt handling mechanisms for (non-Linux) embedded systems.
*But*, as this is my first shot at it with a Linux driver...  I would
appreciate a close look at those parts.  The design is similar to 
i2c-iop3xx, except where it's different. :)

My test target / dev host shares an IRQ between sound and SMBus;
almost all of my testing was performed with xmms blasting away.

Re performance: this driver does not improve CPU utilization, because
the polling loop on the old one sleeps a lot anyway.  Elapsed time
per transaction did improve by varying degrees, depending on the
transaction type:

OLD:
I2C_SMBUS_QUICK(nodev) 0.00202
I2C_SMBUS_QUICK 0.00203
I2C_SMBUS_BYTE 0.00203
I2C_SMBUS_BYTE_DATA 0.00402
I2C_SMBUS_WORD_DATA 0.00602

NEW:
I2C_SMBUS_QUICK(nodev) 0.00108
I2C_SMBUS_QUICK 0.00107
I2C_SMBUS_BYTE 0.00190
I2C_SMBUS_BYTE_DATA 0.00365
I2C_SMBUS_WORD_DATA 0.00449

(Script for above: http://members.dca.net/mhoffman/sensors/temp/test.pl)

The diff is harder to read than the complete files which are attached...

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
/*
    i2c-i801.c - Part of lm_sensors,
         Linux kernel modules for hardware monitoring

    Copyright (c) 2004 Mark M. Hoffman <mhoffman@lightlink.com>

    derived in part from an older i2c-i801.c:
        Copyright (c) 1998-2002 Frodo Looijaard <frodol@dds.nl>,
                Philip Edelbrock <phil@netroedge.com>, and
                Mark D. Studebaker <mdsxyz123@yahoo.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/* PCI Address Constants */
#define I801_PCI_BAR	0x04
#define I801_PCI_HOSTC	0x40
#define I801_PCI_HOSTC_I2C_EN		(1 << 2)
#define I801_PCI_HOSTC_SMB_SMI_EN	(1 << 1)
#define I801_PCI_HOSTC_HST_EN		(1 << 0)

/*
 * HOST STATUS REGISTER
 */
#define I801_REG_HST_STS	0x00

#define I801_HST_STS_BDS	(1 << 7)
#define I801_HST_STS_IU		(1 << 6)
#define I801_HST_STS_ALERT	(1 << 5)
#define I801_HST_STS_FAIL	(1 << 4)
#define I801_HST_STS_COLL	(1 << 3)
#define I801_HST_STS_DEV	(1 << 2)
#define I801_HST_STS_INTR	(1 << 1)
#define I801_HST_STS_BUSY	(1 << 0)

/* mask for events we normally handle */
#define I801_HST_STS_MASK_NORM ( \
		I801_HST_STS_FAIL | \
		I801_HST_STS_COLL | \
		I801_HST_STS_DEV | \
		I801_HST_STS_INTR)

/* mask for all events */
#define I801_HST_STS_MASK_ALL ( \
		I801_HST_STS_BDS | \
		I801_HST_STS_ALERT | \
		I801_HST_STS_FAIL | \
		I801_HST_STS_COLL | \
		I801_HST_STS_DEV | \
		I801_HST_STS_INTR)

/*
 * HOST CONTROL REGISTER
 */
#define I801_REG_HST_CNT	0x02

#define I801_HST_CNT_START	0x40
#define I801_HST_CNT_INTREN	0x01

/* SMB CMD field values */
#define I801_HST_CNT_QUICK	(0x0 << 2)
#define I801_HST_CNT_BYTE	(0x1 << 2)
#define I801_HST_CNT_BYTE_DATA	(0x2 << 2)
#define I801_HST_CNT_WORD_DATA	(0x3 << 2)
#define I801_HST_CNT_PROC_CALL	(0x4 << 2)
#define I801_HST_CNT_BLOCK	(0x5 << 2)
#define I801_HST_CNT_I2C_READ	(0x6 << 2)
#define I801_HST_CNT_BLOCK_PROC	(0x7 << 2)

#define I801_REG_HST_CMD	0x03
#define I801_REG_XMIT_SLVA	0x04
#define I801_REG_HST_D0		0x05
#define I801_REG_HST_D1		0x06
#define I801_REG_HOST_BLOCK_DB	0x07
#define I801_REG_PEC		0x08
#define I801_REG_RCV_SLVA	0x09
#define I801_REG_SLV_DATA	0x0a
#define I801_REG_AUX_STS	0x0c
#define I801_REG_AUX_CTL	0x0d
#define I801_REG_SMLINK_PIN_CTL	0x0e
#define I801_REG_SMBUS_PIN_CTL	0x0f

/* remaining regs on >= ICH3 only */
#define I801_REG_SLV_STS	0x10
#define I801_REG_SLV_CMD	0x11
#define I801_REG_NOTIFY_DADDR	0x14
#define I801_REG_NOTIFY_DLOW	0x16
#define I801_REG_NOTIFY_DHIGH	0x17

-------------- next part --------------
/*
    i2c-i801.c - Part of lm_sensors,
	 Linux kernel modules for hardware monitoring

    Copyright (c) 2004 Mark M. Hoffman <mhoffman@lightlink.com>

    derived in part from an older i2c-i801.c:
	Copyright (c) 1998-2002 Frodo Looijaard <frodol@dds.nl>,
		Philip Edelbrock <phil@netroedge.com>, and
		Mark D. Studebaker <mdsxyz123@yahoo.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/*
	PCI/ID		IO	BB	Name	AKA
	---------------------------------------------------
	8086:2413	16	no	ICH	82801AA
	8086:2423	16	no	ICH0	82801AB
	8086:2443	16	no	ICH2	82801BA
	8086:2443	16	no	ICH2M	82801BAM
	8086:2483	32	no	ICH3S	82801CA
	8086:2483	32	no	ICH3M	82801CAM
	8086:24c3	32	yes	ICH4	82801DB
	8086:24c3	32	yes	ICH4M	82801DBM
	8086:24d3	32	yes	ICH5	82801EB
	8086:24d3	32	yes	ICH5R	82801ER
	8086:25a4	32	yes	ICH(?)	6300ESB
	8086:266a	32	yes	ICH6	82801FB
	8086:266a	32	yes	ICH6R	82801FR
	8086:266a	32	yes	ICH6W	82801FW
	8086:266a	32	yes	ICH6RW	82801FRW

	IO indicates the size of the port region
	BB indicates the existence of a block buffer
*/

//#define DEBUG 1

#include <linux/config.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/stddef.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/ioport.h>
#include <linux/interrupt.h>
#include <linux/init.h>
#include <linux/i2c.h>
#include <asm/io.h>
#include "i2c-i801.h"

struct i2c_i801_algo_data {
	spinlock_t lock;
	wait_queue_head_t waitq;
	int status; /* copy of h/w register */
};

/* I/O port base address & size */
/* TODO: bundle these into i2c_i801_algo_data structure */
static unsigned i801_smba;
static unsigned i801_iosize;

static inline u8 i801_read(u8 reg)
{
	return inb(i801_smba + reg);
}

static inline void i801_write(u8 reg, u8 data)
{
	outb(data, i801_smba + reg);
}

static struct pci_dev *I801_dev; /* TODO: remove */

static void i801_abort(struct i2c_adapter *adap)
{
	/* TODO: add code here */
}

/* fetch & consume host status out of algo_data */
static inline int i801_get_status(struct i2c_i801_algo_data *algo_data)
{
	unsigned long flags;
        int status;

	spin_lock_irqsave(&algo_data->lock, flags);
	status = algo_data->status;
	algo_data->status = 0;
	spin_unlock_irqrestore(&algo_data->lock, flags);

	return status;
}

static int i801_transaction(struct i2c_adapter *adap, int smbcmd)
{
	struct i2c_i801_algo_data *algo_data = adap->algo_data;
	int interrupted, status, ret = 0;

	/* TODO: add status check / bus reset code here */

	/* start the transaction */
	i801_write(I801_REG_HST_CNT, 
			smbcmd | I801_HST_CNT_INTREN | I801_HST_CNT_START);

	interrupted = wait_event_interruptible_timeout(algo_data->waitq,
			((status = i801_get_status(algo_data))
				& I801_HST_STS_MASK_NORM),
			HZ/2);

	if (unlikely(interrupted < 0)) {
		dev_dbg(&I801_dev->dev, "Transfer interrupted, aborting!\n");
		ret = -ERESTARTSYS;

	} else if (likely(I801_HST_STS_INTR =
			(status & I801_HST_STS_MASK_NORM))) {
		ret = 0;

	} else if (status & I801_HST_STS_FAIL) {
		dev_dbg(&I801_dev->dev, "Transaction failed!\n");
		ret = -1;

	} else if (status & I801_HST_STS_COLL) {
		dev_dbg(&I801_dev->dev, "Bus collision!\n");
		ret = -1;

	} else if (status & I801_HST_STS_DEV) {
		dev_dbg(&I801_dev->dev, "No response from client!\n");
		ret = -1;

	} else {
		dev_dbg(&I801_dev->dev, "Host bus timeout!\n");
		ret = -1;
	}

	if (unlikely(ret))
		i801_abort(adap);

	return ret;
}

static s32 i801_access(struct i2c_adapter * adap, u16 addr,
	unsigned short flags, char read_write, u8 command,
	int size, union i2c_smbus_data * data)
{
	s32 ret;
	int smbcmd;

	switch (size) {
	case I2C_SMBUS_QUICK:
		i801_write(I801_REG_XMIT_SLVA, 
			((addr & 0x7f) << 1) | (read_write & 0x01));
		smbcmd = I801_HST_CNT_QUICK;
		break;

	case I2C_SMBUS_BYTE:
		i801_write(I801_REG_XMIT_SLVA,
			((addr & 0x7f) << 1) | (read_write & 0x01));
		if (read_write = I2C_SMBUS_WRITE)
			i801_write(I801_REG_HST_CMD, command);
		smbcmd = I801_HST_CNT_BYTE;
		break;

	case I2C_SMBUS_BYTE_DATA:
		i801_write(I801_REG_XMIT_SLVA,
			((addr & 0x7f) << 1) | (read_write & 0x01));
		i801_write(I801_REG_HST_CMD, command);
		if (read_write = I2C_SMBUS_WRITE)
			i801_write(I801_REG_HST_D0, data->byte);
		smbcmd = I801_HST_CNT_BYTE_DATA;
		break;

	case I2C_SMBUS_WORD_DATA:
		i801_write(I801_REG_XMIT_SLVA,
			((addr & 0x7f) << 1) | (read_write & 0x01));
		i801_write(I801_REG_HST_CMD, command);
		if (read_write = I2C_SMBUS_WRITE) {
			i801_write(I801_REG_HST_D0, data->word & 0xff);
			i801_write(I801_REG_HST_D1, data->word >> 8 & 0xff);
		}
		smbcmd = I801_HST_CNT_WORD_DATA;
		break;

	default:
		dev_err(&I801_dev->dev, "Unsupported transaction %d\n", size);
		return -1;
	}

	if ((ret = i801_transaction(adap, smbcmd)))
		return -1;

	if ((read_write = I2C_SMBUS_WRITE) || (smbcmd = I801_HST_CNT_QUICK))
		return 0;

	switch (smbcmd) {
	case I801_HST_CNT_BYTE:
	case I801_HST_CNT_BYTE_DATA:
		data->byte = i801_read(I801_REG_HST_D0);
		break;

	case I801_HST_CNT_WORD_DATA:
		data->word = (i801_read(I801_REG_HST_D1) << 8) +
				i801_read(I801_REG_HST_D0);
		break;
	}
	return 0;
}
	
static u32 i801_func(struct i2c_adapter *adapter)
{
	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA;
}

/*
 * pass the interrupt status back through algo_data
 * some events that can occur are not handled by this driver (e.g. SMBALERT)
 * these are quietly ACK'ed, without waking anyone
 */
static irqreturn_t i801_isr(int irq, void *dev_id, struct pt_regs *regs)
{
	u8 status = i801_read(I801_REG_HST_STS);

	/* bail if it's not ours */
	if (unlikely(!(status & I801_HST_STS_MASK_ALL)))
		return IRQ_NONE;

	dev_dbg(&I801_dev->dev, "IRQ status: 0x%02x\n", status);

	/* ACK */
	i801_write(I801_REG_HST_STS, (status & I801_HST_STS_MASK_ALL));

	if (likely(status & I801_HST_STS_MASK_NORM)) {
		struct i2c_adapter *adap = dev_id;
		struct i2c_i801_algo_data *algo_data = adap->algo_data;
		unsigned long flags;

		spin_lock_irqsave(&algo_data->lock, flags);
		algo_data->status = status;
		spin_unlock_irqrestore(&algo_data->lock, flags);
		wake_up_interruptible(&algo_data->waitq);
	}

	return IRQ_HANDLED;
}

static struct i2c_algorithm i801_algorithm = {
	.name		= "i801 I2C Algorithm",
	.id		= I2C_ALGO_SMBUS,
	.smbus_xfer	= i801_access,
	.functionality	= i801_func,
};

static struct i2c_i801_algo_data i801_algo_data;
	
static struct i2c_adapter i801_adapter = {
	.owner		= THIS_MODULE,
	.class		= I2C_CLASS_HWMON,
	.algo		= &i801_algorithm,
	.name		= "i2c-i801",
	.algo_data	= &i801_algo_data,
};

static int __devinit i801_probe(struct pci_dev *pcidev,
		const struct pci_device_id *id)
{
	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
	int ret;
	unsigned char temp;

	if (i801_smba) {
		dev_err(&pcidev->dev, "Only one device supported.\n");
		return -EBUSY;
	}

	if ((ret = pci_enable_device(pcidev))) {
		dev_err(&pcidev->dev, "Couldn't enable device!\n");
		return ret;
	}

	I801_dev = pcidev; /* TODO: remove */

	/* the older chipsets in this family have a smaller IO region */
	if ((pcidev->device = PCI_DEVICE_ID_INTEL_82801AA_3) ||
			(pcidev->device = PCI_DEVICE_ID_INTEL_82801AB_3) ||
			(pcidev->device = PCI_DEVICE_ID_INTEL_82801BA_2))
		i801_iosize = 16;
	else
		i801_iosize = 32;

	/* grab IO space */
	i801_smba = pci_resource_start(pcidev, I801_PCI_BAR);
	if(!i801_smba) {
		dev_err(&pcidev->dev, "SMBus base address not initialized!\n");
		return -ENODEV;
	}

	if (!request_region(i801_smba, i801_iosize, i801_adapter.name)) {
		dev_err(&pcidev->dev, "SMBus registers 0x%04x-0x%04x "
				"already in use!\n", i801_smba,
				i801_smba + i801_iosize - 1);
		i801_smba = 0;
		return -ENODEV;
	}

	init_waitqueue_head(&algo_data->waitq);
	spin_lock_init(&algo_data->lock);

	/* grab interrupt */
	if ((ret = request_irq(pcidev->irq, i801_isr, SA_SHIRQ,
			i801_adapter.name, &i801_adapter))) {
		dev_err(&pcidev->dev, "request irq %d failed!\n", pcidev->irq);
		goto OUT1;
	}

	dev_info(&pcidev->dev, "SMBus base address: 0x%04x, IRQ: %d\n",
			i801_smba, pcidev->irq);

	/* default: SMBus, no SMI#, enable host controller */
	pci_write_config_byte(pcidev, I801_PCI_HOSTC, 0x01);
	pci_read_config_byte(pcidev, I801_PCI_HOSTC, &temp);

	/* set up the driverfs linkage to our parent device */
	i801_adapter.dev.parent = &pcidev->dev;

	if ((ret = i2c_add_adapter(&i801_adapter))) {
		dev_err(&pcidev->dev, "Couldn't register adapter!\n");
		goto OUT2;
	} else 
		return 0;

OUT2:
	free_irq(pcidev->irq, &i801_adapter);
OUT1:
	release_region(i801_smba, i801_iosize);
	i801_smba = 0;
	return ret;
}

static void __devexit i801_remove(struct pci_dev *pcidev)
{
	if (i801_smba) {
		i2c_del_adapter(&i801_adapter);
		release_region(i801_smba, i801_iosize);
		free_irq(pcidev->irq, &i801_adapter);
		i801_smba = 0;
	}
}

#define INTEL_SMBUS_DEVICE(id) { \
	.vendor = PCI_VENDOR_ID_INTEL, .device = (id), \
	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID }

static struct pci_device_id i801_ids[] = {
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_82801AA_3), /* ICH */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_82801AB_3), /* ICH0 */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_82801BA_2), /* ICH2 (M) */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_82801CA_3), /* ICH3 (S,W) */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_82801DB_3), /* ICH4 (M) */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_82801EB_3), /* ICH5 (R) */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_ESB_4),     /* ICH??? */
	INTEL_SMBUS_DEVICE(PCI_DEVICE_ID_INTEL_ICH6_16),   /* ICH6 (R,W,RW) */
	{ 0, }
};

MODULE_DEVICE_TABLE (pci, i801_ids);

static struct pci_driver i801_driver = {
	.name		= "i801_smbus",
	.id_table	= i801_ids,
	.probe		= i801_probe,
	.remove		= __devexit_p(i801_remove),
};

static int __init i801_init(void)
{
	return pci_register_driver(&i801_driver);
}

static void __exit i801_exit(void)
{
	pci_unregister_driver(&i801_driver);
}

MODULE_AUTHOR ("Mark M. Hoffman <mhoffman@lightlink.com>");
MODULE_DESCRIPTION("i801 SMBus driver");
MODULE_LICENSE("GPL");

module_init(i801_init);
module_exit(i801_exit);
