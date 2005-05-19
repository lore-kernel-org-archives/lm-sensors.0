From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: stub for driver testing (was Re: lm87 ported to Linux 2.6)
Message-Id: <20040824034244.GA23169@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

(CCs trimmed on purpose)

* Jean Delvare <khali@linux-fr.org> [2004-08-23 21:52:06 +0200]:
> This first patch is untested beyond compilation, as I don't own a LM87
> myself. This is why I rely on you for testing. The more testers there

Attached is a quick hack that makes this (testing a driver for h/w you
don't own) a little easier.  It would be even more useful if it wrote to
a file instead of spamming all those printks - I'll do that if people
want it.

You'll probably need to pass force_foo parameters to the chip driver to
get it to attach. Also be warned: if the driver has any polling loops
which wait for some byte/data to change, this bus stub could lock it up.

Stuff like this probably isn't appropriate for kernel.org (Greg?)
Maybe it belongs in a new directory in the sensors CVS?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
# Handy out-of-kernel Makefile by Gerd Knorr / LWN.net
#
ifneq ($(KERNELRELEASE),)
	obj-m := i2c-stub.o
else
	KDIR := /lib/modules/$(shell uname -r)/build
	PWD  := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
endif

-------------- next part --------------
/*
    i2c-stub.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring

    Copyright (c) 2004 Mark M. Hoffman <mhoffman@lightlink.com>

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

#define DEBUG 1

#include <linux/config.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/i2c.h>

static u8  stub_bytes[256];
static u16 stub_words[256];

/* Return -1 on error. */
static s32 stub_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
	char read_write, u8 command, int size, union i2c_smbus_data * data)
{
	s32 ret;

	switch (size) {

	case I2C_SMBUS_QUICK:
		dev_dbg(&adap->dev, "smbus quick - addr 0x%02x\n", addr);
		ret = 0;
		break;

	case I2C_SMBUS_BYTE_DATA:
		if (read_write = I2C_SMBUS_WRITE) {
			stub_bytes[command] = data->byte;
			dev_dbg(&adap->dev, "smbus byte data - addr 0x%02x, "
					"wrote 0x%02x at 0x%02x.\n",
					addr, data->byte, command);
		} else {
			data->byte = stub_bytes[command];
			dev_dbg(&adap->dev, "smbus byte data - addr 0x%02x, "
					"read  0x%02x at 0x%02x.\n",
					addr, data->byte, command);
		}

		ret = 0;
		break;

	case I2C_SMBUS_WORD_DATA:
		if (read_write = I2C_SMBUS_WRITE) {
			stub_words[command] = data->word;
			dev_dbg(&adap->dev, "smbus word data - addr 0x%02x, "
					"wrote 0x%04x at 0x%02x.\n",
					addr, data->word, command);
		} else {
			data->word = stub_words[command];
			dev_dbg(&adap->dev, "smbus word data - addr 0x%02x, "
					"read  0x%04x at 0x%02x.\n",
					addr, data->word, command);
		}

		ret = 0;
		break;

	default:
		dev_dbg(&adap->dev, "Unsupported I2C/SMBus command\n");
		ret = -1;
		break;
	} /* switch (size) */

	return ret;
}

static u32 stub_func(struct i2c_adapter *adapter)
{
	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE_DATA |
		I2C_FUNC_SMBUS_WORD_DATA;
}

static struct i2c_algorithm smbus_algorithm = {
	.name		= "Non-I2C SMBus adapter",
	.id		= I2C_ALGO_SMBUS,
	.functionality	= stub_func,
	.smbus_xfer	= stub_xfer,
};

static struct i2c_adapter stub_adapter = {
	.owner		= THIS_MODULE,
	.class		= I2C_CLASS_HWMON,
	.algo		= &smbus_algorithm,
	.name		= "SMBus stub driver",
};

static int __init i2c_stub_init(void)
{
	printk(KERN_INFO "i2c-stub loaded\n");
	return i2c_add_adapter(&stub_adapter);
}

static void __exit i2c_stub_exit(void)
{
	i2c_del_adapter(&stub_adapter);
}

MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
MODULE_DESCRIPTION("I2C stub driver");
MODULE_LICENSE("GPL");

module_init(i2c_stub_init);
module_exit(i2c_stub_exit);
