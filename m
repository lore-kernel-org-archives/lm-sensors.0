From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: NCLV-D SMBus - proposal to a solution
Message-Id: <42696FDD.6090508@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4262C492.10808@sh.cvut.cz>
In-Reply-To: <4262C492.10808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Seems you reply got filtered from spamfilter but thanks to Phil, he catches it
from time to time. It seems that footers with chinese
get marked as probable spam in most cases.

>This is the answer from ASUS:
>So far most server boards with W83792(A)D follow the same SMBus
>topology. You do not need to pay attention to this issue.

Ok I have here a quick and dirty shot that implements the multiplexing driver.
It is a more scatch than the real thing but it reflect how it will be done.

I followed the driver made by Jean. This is more is different it has a "mux"
in ISA IO space. The asus MB is detected in two phases. (ISA bridge and
then subsystem ID of SMBUS)

Please comment the idea. I'm still busy theese days so I cant work on this in
next two weeks I think. But maybe Chunhao or someone from Winbond want to do
that earlier.

Thanks

regards

Rudolf

extern struct i2c_adapter i801_smbus;

static struct i2c_adapter *asus_adapter;
static struct i2c_algorithm *asus_algo;

static int muxbase;

/* Wrapper access functions for multiplexed SMBus */
static struct semaphore i801_lock;

void mux_switch(int what) {

//here should be the mux switching code similar to one bellow
//we should switch the bus according specs


//		+               val=inb((region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);

//		+               val&=~0x4; /* GPIO42 : 0 (Low) */

//		+               val|=0x8;  /* GPIO43 : 1 (High) */

//		+               outb(val, (region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);

//		+               printk(KERN_INFO "PCI: Canceling ASUS hide and seek played
with SMBus monitoring chi
		


outb(muxbase+addr, whatbits)

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

//	/* We exclude the non-multiplexed addresses */
//	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
//		return -1;
//
	down(&i801_lock);

	if (last_channels != channels) { //this is wise ;)
		mux_switch(channels);
		last_channels = channels;
	}
	error = i801_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
					      command, size, data);

UNLOCK:
	up(&i801_lock);
	return error;
}

static s32 i801_access_virt1(struct i2c_adapter * adap, u16 addr,
			       unsigned short flags, char read_write,
			       u8 command, int size,
			       union i2c_smbus_data * data)
{
	/* CPU0: channels 1 and 0 enabled */
	return i801_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x1);
}


static s32 i801_access_virt0(struct i2c_adapter * adap, u16 addr,
			       unsigned short flags, char read_write,
			       u8 command, int size,
			       union i2c_smbus_data * data)
{

	return i801_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x00);
}


//static int __init i801_asus_init(void)
//{

static int __devinit asus_sb_probe(struct pci_dev *dev, const struct
pci_device_id *id)
{
	int i, error;
	int asus_server_board_hides_smbus_devices=0;
	union i2c_smbus_data ioconfig;

        struct pci_dev *smbdev = NULL;
	
	//we are here because INTEL ISA Brigde is present
	
   while (smbdev = pci_get_device(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ESB_4, smbdev)) {

       if (unlikely(smbdev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {

                       switch(smbdev->subsystem_device) {

                       case 0x8117:
                               asus_server_board_hides_smbus_devices = 1;

                               break;

                       }

       }

    }

//we know this is our board
if (asus_server_board_hides_smbus_devices!=1) return -ENODEV;
//get GPIO base
        pci_read_config_dword(dev, 0x58, &muxbase);
	
	if (muxbase=0) { // error
	}
//register
  if (!request_region(muxbase, 0xDONTKNOW, "GPIO MUX")) {
  //error
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

	printk(KERN_INFO "Enabling SMBus multiplexing for ASUS\n");
	init_MUTEX(&i801_lock);

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


		error = i2c_add_adapter(asus_adapter+0);
		
		error = i2c_add_adapter(asus_adapter+1);

		if (error) {
			dev_err(&i801_smbus.dev,
			       "Virtual adapter %d registration "
			       "failed, module not inserted\n", i);
			for (i--; i >= 0; i--)
				i2c_del_adapter(asus_adapter+i);
			goto ERROR3;
		}
	
//REDO ERR HANDLING
//return -ENODEV because we want only part of the device same as i2c-viapro.c
	return 0;

ERROR3:
	kfree(asus_algo);
	asus_algo = NULL;
ERROR2:
	kfree(asus_adapter);
	asus_adapter = NULL;
ERROR1:
	i2c_del_adapter(&i801_smbus);
ERROR0:
	return error;
}

static void __devexit asus_sb_remove(struct pci_dev *dev)
{

//this needs redo too
	if (asus_adapter) {
		int i;

		for (i = 0; i < 5; i++)
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

MODULE_LICENSE("GPL");

module_init(i2c_asus_sb_init);
module_exit(i2c_asus_sb_exit);
