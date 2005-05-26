From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 26 May 2005 21:05:58 +0000
Subject: [lm-sensors] Asus bus multiplexing driver - take1
Message-Id: <42961E01.5080705@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I worked a bit on the Asus multiplexing driver.
I cannot continue any further it must be tested.

But before I would like to ask others here to check it and catch some stupid mistakes first :)

Thanks.

I'm attaching build environment too.

regards

Rudolf

/*
 * (C) 2005 Rudolf Marek <r.marek@sh.cvut.cz>
 *
 * Heavily based on i2c-amd756-s4882.c
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
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/i2c.h>
#include <asm/io.h>
#include <linux/pci.h>

extern struct i2c_adapter i801_smbus;

/* dont forget to put EXPORT_SYMBOL_GPL(i801_smbus) into i2c-i801.c */

#define GPIO_OUTPUT2_REG_HIGH 0x39

static struct i2c_adapter *asus_adapter;
static struct i2c_algorithm *asus_algo;

static int muxbase;

/* Wrapper access functions for multiplexed SMBus */
static struct semaphore asus_lock;

void mux_switch(u8 what) {
u8 val;
		
val = inb(muxbase+GPIO_OUTPUT2_REG_HIGH);

/*write to bits 2 and 3

This needs to be checked if it works as expected
*/

outb((val & ~0xC) | ((what & 2) << 2), muxbase + GPIO_OUTPUT2_REG_HIGH );

}
/* We remember the last used channels combination so as to only switch
   channels when it is really needed. This greatly reduces the SMBus
   overhead, but also assumes that nobody will be writing to the PCA9556
   in our back. */
static u8 last_channels;

static inline s32 i801_access_channel(struct i2c_adapter * adap, u16 addr,
					unsigned short flags, char read_write,
					u8 command, int size,
					union i2c_smbus_data * data,
					u8 channels)
{
	int error;

	down(&asus_lock);

	if (last_channels != channels) {
		mux_switch(channels);
		last_channels = channels;
	}
	error = i801_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
					      command, size, data);
	up(&asus_lock);
	return error;
}

static s32 i801_access_virt1(struct i2c_adapter * adap, u16 addr,
			       unsigned short flags, char read_write,
			       u8 command, int size,
			       union i2c_smbus_data * data)
{
	return i801_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x2);
}


static s32 i801_access_virt0(struct i2c_adapter * adap, u16 addr,
			       unsigned short flags, char read_write,
			       u8 command, int size,
			       union i2c_smbus_data * data)
{

	return i801_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x00);
}


static int __devinit asus_sb_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	int i;
	int error;
	int asus_server_board_hides_smbus_devices = 0;

        struct pci_dev *smbdev = NULL;
	
	/* we are here because INTEL ISA Brigde is present */
	
	while (smbdev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4, smbdev)) {

		if (unlikely(smbdev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
			switch(smbdev->subsystem_device) {
				case 0x8117:
				asus_server_board_hides_smbus_devices = 1;
				break;
                       }
       		}
    	}
	 /* we know this is our board */

	error = -ENODEV;

	if (!asus_server_board_hides_smbus_devices)
		return error;

	pci_read_config_dword(dev, 0x58, &muxbase);
	
	if (muxbase=0) { // error
		dev_err(&dev->dev, "Base adr is not set\n");
		return error;
	}
	

	if (!request_region(muxbase, 64, "GPIOs")) {
  		dev_err(&dev->dev, "Could not allocate I/O space\n");
		return error;
	}
	

	/* Unregister physical bus */
	error = i2c_del_adapter(&i801_smbus);
	if (error) {
		if (error = -EINVAL)
			error = -ENODEV;
		else
			dev_err(&i801_smbus.dev, "Physical bus removal "
				"failed\n");
		goto ERROR0;
	}

	dev_info(&dev->dev, "Enabling SMBus multiplexing for ASUS server motherboard\n");
	init_MUTEX(&asus_lock);

	/* Define the 2 virtual adapters and algorithms structures */
	if (!(asus_adapter = kmalloc(2 * sizeof(struct i2c_adapter),
				      GFP_KERNEL))) {
		error = -ENOMEM;
		goto ERROR1;
	}
	if (!(asus_algo = kmalloc(2 * sizeof(struct i2c_algorithm),
				   GFP_KERNEL))) {
		error = -ENOMEM;
		goto ERROR2;
	}

	/* Fill in the new structures */
	asus_algo[0] = *(i801_smbus.algo);
	asus_algo[1] = *(i801_smbus.algo);

	asus_algo[0].smbus_xfer = i801_access_virt0;
	asus_algo[1].smbus_xfer = i801_access_virt1;

	asus_adapter[0] = i801_smbus;
	asus_adapter[1] = i801_smbus;
	asus_adapter[0].algo = asus_algo;
	asus_adapter[1].algo = asus_algo+1;
		
	for (i=0;i<2;i++) {
		error = i2c_add_adapter(asus_adapter+i);
		if (error) {
			dev_err(&i801_smbus.dev,
			       "Virtual adapter %d registration "
			       "failed, module not inserted\n", i);
			for (i--; i >= 0; i--)
				i2c_del_adapter(asus_adapter+i);
			goto ERROR3;
		}
	}
	return 0;

ERROR3:
	kfree(asus_algo);
	asus_algo = NULL;
ERROR2:
	kfree(asus_adapter);
	asus_adapter = NULL;
ERROR1:
	i2c_add_adapter(&i801_smbus);
ERROR0:
	return error;
}

static void __devexit asus_sb_remove(struct pci_dev *dev)
{

	if (asus_adapter) {
		int i;

		for (i = 0; i < 2; i++)
		i2c_del_adapter(asus_adapter+i);
		kfree(asus_adapter);
		asus_adapter = NULL;
	}
	if (asus_algo) {
		kfree(asus_algo);
		asus_algo = NULL;
	}

	/* Restore physical bus */
	if (i2c_add_adapter(&i801_smbus))
		dev_err(&i801_smbus.dev, "Physical bus restoration "
			"failed\n");
	release_region(muxbase, 64);
}


static struct pci_device_id asus_sb_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1) },
	{ 0, }
};

MODULE_DEVICE_TABLE (pci, asus_sb_ids);


static struct pci_driver asus_sb_driver = {
	.name		= "asus_sb_smbus",
	.id_table	= asus_sb_ids,
	.probe		= asus_sb_probe,
	.remove		= __devexit_p(asus_sb_remove),
};

static int __init i2c_asus_sb_init(void)
{
	return pci_register_driver(&asus_sb_driver);
}

static void __exit i2c_asus_sb_exit(void)
{
	pci_unregister_driver(&asus_sb_driver);
}

MODULE_AUTHOR ("Rudolf Marek <r.marek@sh.cvut.cz>");
MODULE_LICENSE("GPL");

module_init(i2c_asus_sb_init);
module_exit(i2c_asus_sb_exit);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hideandseek_mux.tar.gz
Type: application/x-gzip
Size: 2773 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050526/83b6108c/hideandseek_mux.tar.gz
