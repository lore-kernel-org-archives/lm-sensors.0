From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: ATI i2c bus driver
Message-Id: <20040106230826.3d485d0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040102115144.219b5579.khali@linux-fr.org>
In-Reply-To: <20040102115144.219b5579.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, I got some code from the Gatos project. I took i2c-savage4 and
edited it in accordance with what I found there, but I can't get it to
work. If anyone could take a look and tell me where I'm wrong...

Registers are here:
http://cvs.sourceforge.net/viewcvs.py/gatos/ati.2/radeon_reg.h?rev=1.14&view=auto

I use these:

#define RADEON_GPIO_DVI_DDC                 0x0064
#define RADEON_GPIO_VGA_DDC                 0x0060
#       define RADEON_GPIO_Y_0              (1 <<  8)
#       define RADEON_GPIO_Y_1              (1 <<  9)
#       define RADEON_GPIO_EN_0             (1 << 16)
#       define RADEON_GPIO_EN_1             (1 << 17)

Also tried these but didn't help:

#define RADEON_GPIO_MONID                   0x0068
#define RADEON_GPIO_CRT2_DDC                0x006c

Code is here:
http://cvs.sourceforge.net/viewcvs.py/gatos/ati.2/radeon_driver.c?rev=1.17&view=auto

Functions I took my code from are RADEONI2CGetBits, RADEONI2CPutBits and
RADEONI2cInit. One thing I noticed is that set{scl,sda} seem to be
inverted.

Attached is my driver. It doesn't work. Whatever base register I try
(DVI, VGA, CRT2...), both SDA and SCL lines are stuck to low (so says
i2c-algo-bit with bit_test=1). So I'm obviously missing something, maybe
because I never worked on this kind of hardware before. Any help
appreciated.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
/*
    i2c-radeon.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring
    Copyright (C) 1998-2004  The LM Sensors Team
    
    Based on i2c-savage4.c.

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

#include <linux/module.h>
#include <linux/pci.h>
#include <linux/i2c.h>
#include <linux/i2c-algo-bit.h>
#include <linux/init.h>
#include <asm/io.h>
#include <asm/param.h> /* for HZ */
#include "version.h"

/* Radeon defines */
#define RADEON_GPIO_VGA_DDC	0x0060
#define RADEON_GPIO_DVI_DDC	0x0064

/* bit locations in the registers */
#define I2C_SDA_IN		(1 <<  8)
#define I2C_SCL_IN		(1 <<  9)
#define I2C_SCL_OUT		(1 << 17) /* inverted */
#define I2C_SDA_OUT		(1 << 16) /* inverted */

/* delays */
#define CYCLE_DELAY	10
#define TIMEOUT		(HZ / 2)


static void config_radeon(struct pci_dev *dev);

static unsigned long ioaddr;

static void radeon_dvi_setscl(void *data, int val)
{
	unsigned int r;
	r = readl(ioaddr + RADEON_GPIO_DVI_DDC);
	if(val)
		r &= ~I2C_SCL_OUT;
	else
		r |= I2C_SCL_OUT;
	writel(r, ioaddr + RADEON_GPIO_DVI_DDC);
	readl(ioaddr + RADEON_GPIO_DVI_DDC);	/* flush posted write */
}

static void radeon_dvi_setsda(void *data, int val)
{
	unsigned int r;
	r = readl(ioaddr + RADEON_GPIO_DVI_DDC);
	if(val)
		r &= ~I2C_SDA_OUT;
	else
		r |= I2C_SDA_OUT;
	writel(r, ioaddr + RADEON_GPIO_DVI_DDC);
	readl(ioaddr + RADEON_GPIO_DVI_DDC);	/* flush posted write */
}

static int radeon_dvi_getscl(void *data)
{
	return (0 != (readl(ioaddr + RADEON_GPIO_DVI_DDC) & I2C_SCL_IN));
}

static int radeon_dvi_getsda(void *data)
{
	return (0 != (readl(ioaddr + RADEON_GPIO_DVI_DDC) & I2C_SDA_IN));
}

static void radeon_vga_setscl(void *data, int val)
{
	unsigned int r;
	r = readl(ioaddr + RADEON_GPIO_VGA_DDC);
	if(val)
		r &= ~I2C_SCL_OUT;
	else
		r |= I2C_SCL_OUT;
	writel(r, ioaddr + RADEON_GPIO_VGA_DDC);
	readl(ioaddr + RADEON_GPIO_VGA_DDC);	/* flush posted write */
}

static void radeon_vga_setsda(void *data, int val)
{
	unsigned int r;
	r = readl(ioaddr + RADEON_GPIO_VGA_DDC);
	if(val)
		r &= ~I2C_SDA_OUT;
	else
		r |= I2C_SDA_OUT;
	writel(r, ioaddr + RADEON_GPIO_VGA_DDC);
	readl(ioaddr + RADEON_GPIO_VGA_DDC);	/* flush posted write */
}

static int radeon_vga_getscl(void *data)
{
	return (0 != (readl(ioaddr + RADEON_GPIO_VGA_DDC) & I2C_SCL_IN));
}

static int radeon_vga_getsda(void *data)
{
	return (0 != (readl(ioaddr + RADEON_GPIO_VGA_DDC) & I2C_SDA_IN));
}

/* Configures the chip */

void config_radeon(struct pci_dev *dev)
{
	unsigned int cadr;

	/* map memory */
	cadr = dev->resource[0].start;
	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
	ioaddr = (unsigned long)ioremap_nocache(cadr, 0x0001000);
	if(ioaddr) {
//		writel(0x8160, ioaddr + RADEON_GPIO_DVI_DDC2);
//		writel(0x00000020, ioaddr + RADEON_GPIO_DVI_DDC);
		radeon_dvi_setscl(NULL, 1);
		radeon_dvi_setsda(NULL, 1);
		radeon_vga_setscl(NULL, 1);
		radeon_vga_setsda(NULL, 1);
		printk(KERN_INFO "i2c-radeon.o: Using Radeon at 0x%lx\n", ioaddr);
	}
}


static struct i2c_algo_bit_data radeon_dvi_bit_data = {
	.setsda		= radeon_dvi_setsda,
	.setscl		= radeon_dvi_setscl,
	.getsda		= radeon_dvi_getsda,
	.getscl		= radeon_dvi_getscl,
	.udelay		= CYCLE_DELAY,
	.mdelay		= CYCLE_DELAY,
	.timeout	= TIMEOUT
};

static struct i2c_algo_bit_data radeon_vga_bit_data = {
	.setsda		= radeon_vga_setsda,
	.setscl		= radeon_vga_setscl,
	.getsda		= radeon_vga_getsda,
	.getscl		= radeon_vga_getscl,
	.udelay		= CYCLE_DELAY,
	.mdelay		= CYCLE_DELAY,
	.timeout	= TIMEOUT
};

static struct i2c_adapter radeon_i2c_adapter = {
	.owner		= THIS_MODULE,
	.name		= "ATI Radeon",
	.id		= I2C_HW_B_SAVG, /* FIXME */
	.algo_data	= &radeon_vga_bit_data,
};

static struct pci_device_id radeon_ids[] __devinitdata = {
	{
		.vendor		= 0x1002,
		.device		= 0x4C59,
		.subvendor	= PCI_ANY_ID,
		.subdevice	= PCI_ANY_ID,
	},
	{ 0 }
};

static int __devinit radeon_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	config_radeon(dev);
	return i2c_bit_add_bus(&radeon_i2c_adapter);
}

static void __devexit radeon_remove(struct pci_dev *dev)
{
	i2c_bit_del_bus(&radeon_i2c_adapter);
}

static int __init i2c_radeon_init(void)
{
	struct pci_dev *dev;
	const struct pci_device_id *id;

	printk(KERN_DEBUG "i2c-radeon.o init\n");

	pci_for_each_dev(dev) {
		id = pci_match_device(radeon_ids, dev);
		if(id && radeon_probe(dev, id) >= 0)
			return 0;
	}
	return -ENODEV;
}

static void __exit i2c_radeon_exit(void)
{
	radeon_remove(NULL);
	iounmap((void *)ioaddr);
}

MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
MODULE_DESCRIPTION("ATI Radeon I2C bus driver");
MODULE_LICENSE("GPL");

module_init(i2c_radeon_init);
module_exit(i2c_radeon_exit);
