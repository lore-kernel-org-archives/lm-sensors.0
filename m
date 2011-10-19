From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Wed, 19 Oct 2011 12:37:41 +0000
Subject: Re: [lm-sensors] smbus-arp module
Message-Id: <4E9EC495.5070305@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111014230322.39baf9f0@endymion.delvare>
In-Reply-To: <20111014230322.39baf9f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le 17/10/2011 22:30, shubhada pugaonkar a =E9crit :
>=20
>=20
> *From:* Jean Delvare <khali@linux-fr.org>
> *To:* shubhada pugaonkar <shubhp2k@yahoo.com>
> *Cc:* lm-sensors@lm-sensors.org; corentin.labbe <corentin.labbe@geomatys.=
fr>
> *Sent:* Saturday, October 15, 2011 12:51 AM
> *Subject:* Re: [lm-sensors] smbus-arp module
>=20
> Please don't top-post.
>=20
> On Fri, 14 Oct 2011 17:25:06 -0700 (PDT), shubhada pugaonkar wrote:
>> It would be great if I could use that code for testing.
>> =20
>> One question:
>> I dont see any of the drivers having ARP support,  does that mean all th=
e smbus controllers have ARP implemented in HW?
>> I looked at intel 82801 smbus controller (thats what I have) datasheet b=
ut the ARP support is nowhere to be seen. Does anyone
>> know any smbus host controllers chip (or specific server) with HW smbus =
ARP?
>=20
>>>I did not dig the matter too much yet but my understanding is that bus
>>>controllers (and thus their drivers) don't have to care about ARP at
>>>all. It is implemented in hardware on the slave side but in software on
>>>the host side, as there is nothing the bus controller can do with the
>>>information anyway.
> If I interpreted this correctly this means I have to rely on OS support. =
 I can try this in Windows machine and see if my slave responds to enumerat=
ion.
> =20
> Meanwhile Corentin, can you also give me the Linux code which I can try?

Hello

I have attached the current state of my try to do a driver for using smbus-=
arp.
For the moment it assign always the same address 0x2C to device that it dis=
covers.

On my computer, it detect a w83791d that already exists as a static address=
 device.
But I have strange result, sometimes the address assigned is not acked and =
sometime acked.
Even if the address assigned is acked, the w83791d always respond and be de=
tected with its default address 0x2D.

WARNING: On my computer, sometimes, after use of this module, I need to pow=
er off for rebooting it. No explanation of why.

This is the output of dmesg when loading the module
[56172.193391] smbusarp.o: sensors_smbusarp_init
[56172.197011] smbusarp.o: smbusarp_detect
[56172.197014] smbusarp.o: smbusarp_detect on adapter SMBus nForce2 adapter=
 at 1c80 adress 0x61
[56172.197071] smbusarp.o: smbusarp_probe
[56172.199009] smbusarp.o: ARP_GEN_RESET_DEV send on SMBus nForce2 adapter =
at 1c80
[56172.205071] smbusarp.o: ARP general GET_UDID block read 0x11
[56172.205075] smbusarp.o: GET_UDID acked on adapter SMBus nForce2 adapter =
at 1c80
[56172.205079] smbusarp.o: GET C1 09 10 50 01 00 00 24
[56172.205082] smbusarp.o: GET2 00 00 00 00 E8 43 92 05
[56172.205085] smbusarp.o: DevCAP=3DC1 Ver=3D9 UDID=3D8
[56172.205087] smbusarp.o: DevCAP address type C0
[56172.205090] smbusarp.o:   Random number device
[56172.205092] smbusarp.o: UDID version 1
[56172.205094] smbusarp.o: Silicon Revision ID 01
[56172.205097] smbusarp.o: VendorID=3D10 50 DevID=3D01 00
[56172.205100] smbusarp.o: Interface=3D0 24 SmbusVer=3D4
[56172.205102] smbusarp.o: Support additional ASF
[56172.205104] smbusarp.o: Subsystem Vendor ID 00 00
[56172.205107] smbusarp.o: Subsystem Device ID 00 00
[56172.205109] smbusarp.o: Vendor Specific ID e8 43 92 05
[56172.205112] smbusarp.o: current gived addr FF
[56172.205114] smbusarp.o: Found free address 2C
[56172.205116] smbusarp.o: Final chosen address 2C
[56172.209015] smbusarp.o: ASSIGN_ADDR 2c acked

Furthermore many questions are unanswered.
- The "scan" for ARP-device is only done at module load, how to do it after=
 ?
- The module have a list of free adress, but each hwmon driver "scan" only =
a subset of possible address (ex w83791d scan 0x2c, 0x2d, 0x2e, 0x2f). What=
 happen if I give another address?

--

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/hwmon.h>
#include <linux/hwmon-vid.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>

#define ARP_DEVICE_DEFAULT_ADDRESS     0x61
/* ARP Commands */
#define ARP_PREPARE_TO_ARP	0x01
#define ARP_GEN_RESET_DEV	0x02
#define ARP_GEN_GET_UDID	0x03
#define ARP_ASSIGN_ADDR		0x04

#define ADDRESS_ARP_FREE        0
#define ADDRESS_ARP_RESERVED    1
#define ADDRESS_ARP_USED	2

#define UDID_LENGTH     0x11
#define SMBUS_ADDRESS_SIZE      0x80

static u8 reserved[] =3D
/* As defined by SMBus Spec. Appendix C */
	{0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x28,
	0x37, ARP_DEVICE_DEFAULT_ADDRESS,
/* As defined by SMBus Spec. Sect. 5.2 */
	0x01, 0x02, 0x03, 0x04, 0x05,
	0x06, 0x07, 0x78, 0x79, 0x7a, 0x7b,
	0x7c, 0x7d, 0x7e, 0x7f,
/* Common PC addresses (bad idea) */
	0x2d, 0x48, 0x49, /* sensors */
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* eeproms */
	0x69, /* clock chips */
/* Must end in 0 which is also reserved */
	0x00};

/* Addresses to scan */
static const unsigned short normal_i2c[] =3D { ARP_DEVICE_DEFAULT_ADDRESS,
						I2C_CLIENT_END };

/* Insmod parameters */
/*I2C_CLIENT_INSMOD_1(smbusarp);*/
static int smbusarp_probe(struct i2c_client *client,
			const struct i2c_device_id *id);
static int smbusarp_remove(struct i2c_client *client);
static int smbusarp_detect(struct i2c_client *client,
			struct i2c_board_info *info);

struct smbusarp_data {
	struct device *hwmon_dev;
	u8 bank;
	u8 address_pool[SMBUS_ADDRESS_SIZE];
};

static const struct i2c_device_id smbusarp_id[] =3D {
	{ "smbusarp", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, smbusarp_id);

static struct i2c_driver smbusarp_driver =3D {
	.class		=3D I2C_CLASS_HWMON,
	.driver =3D {
		   .name =3D "smbusarp",
	},
	.probe		=3D smbusarp_probe,
	.remove		=3D smbusarp_remove,
	.id_table	=3D smbusarp_id,
	.detect		=3D smbusarp_detect,
	.address_list	=3D normal_i2c,
};
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
/* give a free address*/
static u8 get_free_address(u8 *pool)
{
	u8 i;
	return 0x2c;/* TODO temporary for test, return always the same address */
	for (i =3D 0; i < 0x7f; i++) {
		if (pool[i] =3D=3D ADDRESS_ARP_FREE)
			return i;
	}
	return 0;
}

/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
static int smbusarp_remove(struct i2c_client *client)
{
	struct smbusarp_data *data =3D i2c_get_clientdata(client);

	hwmon_device_unregister(data->hwmon_dev);

	if (data !=3D NULL)
		kfree(data);

	return 0;
}


/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
static int smbusarp_detect(struct i2c_client *client,
			struct i2c_board_info *info)
{
	struct i2c_adapter *adapter =3D client->adapter;
	unsigned short address =3D client->addr;
	printk(KERN_INFO "smbusarp.o: smbusarp_detect\n");

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		return -ENODEV;

	strlcpy(info->type, "smbusarp", I2C_NAME_SIZE);
	printk(KERN_INFO "smbusarp.o: smbusarp_detect on adapter %s adress 0x%02x\=
n",
		client->adapter->name, address);
	return 0;
}

/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
static void smbusarp_print_uuid_info(u8 *blk)
{
	if (blk =3D=3D NULL)
		return;
	printk(KERN_INFO "smbusarp.o: GET %02X %02X %02X %02X %02X %02X %02X %02X\=
n",
		blk[0], blk[1], blk[2], blk[3],
		blk[4], blk[5], blk[6], blk[7]);
	printk(KERN_INFO "smbusarp.o: GET2 %02X %02X %02X %02X %02X %02X %02X %02X=
\n",
		blk[8], blk[9], blk[10], blk[11],
		blk[12], blk[13], blk[14], blk[15]);
	printk(KERN_INFO "smbusarp.o: DevCAP=3D%X Ver=3D%X UDID=3D%x\n",
		blk[0], blk[1], blk[1] & 0x38);
	if ((blk[0] & 0x3E) > 0)
		printk(KERN_INFO "smbusarp.o: DevCAP ERROR\n");
	if ((blk[1] & 0xC0) > 0)
		printk(KERN_INFO "smbusarp.o: Ver ERROR\n");
	/*smbus spec page 35*/
	printk(KERN_INFO "smbusarp.o: DevCAP address type %X\n",
						(blk[0] & 0xC0));
	switch (blk[0] & 0xC0) {
	case 0x00:
		printk(KERN_INFO "smbusarp.o:   Fixed Address device");
	break;
	case 0x40:
		printk(KERN_INFO "smbusarp.o:   Dynamic and persistent address device");
	break;
	case 0x80:
		printk(KERN_INFO "smbusarp.o:   Dynamic and volatile address device");
	break;
	case 0xC0:
		printk(KERN_INFO "smbusarp.o:   Random number device");
	break;
	default:
		printk(KERN_INFO "smbusarp.o: unknown address type\n");
	break;
	}
	if (((blk[1] & 0x38) >> 3) =3D=3D 0x01)
		printk(KERN_INFO "smbusarp.o: UDID version 1\n");
	else
		printk(KERN_INFO "smbusarp.o: unknown UDID version %x\n",
						((blk[1] & 0x38) >> 3));
	printk(KERN_INFO "smbusarp.o: Silicon Revision ID %02X\n",
						(blk[1] & 0x07));
	/*smbus spec page 37*/
	printk(KERN_INFO "smbusarp.o: VendorID=3D%02X %02X DevID=3D%02X %02X\n",
		blk[2], blk[3],  blk[4], blk[5]);
	printk(KERN_INFO "smbusarp.o: Interface=3D%X %X SmbusVer=3D%X\n",
		blk[6], blk[7],  blk[7] & 0x0F);
	if ((blk[7] & 0x20) =3D=3D 0x20)
		printk(KERN_INFO "smbusarp.o: Support additional ASF\n");
	if ((blk[7] & 0x40) =3D=3D 0x40)
		printk(KERN_INFO "smbusarp.o: Support additional IPMI\n");
	if ((blk[7] & 0x10) =3D=3D 0x10)
		printk(KERN_INFO "smbusarp.o: Support additional OEM\n");
	printk(KERN_INFO "smbusarp.o: Subsystem Vendor ID %02x %02x\n",
		blk[8], blk[9]);
	printk(KERN_INFO "smbusarp.o: Subsystem Device ID %02x %02x\n",
		blk[10], blk[11]);
	printk(KERN_INFO "smbusarp.o: Vendor Specific ID %02x %02x %02x %02x\n",
		blk[12], blk[13], blk[14], blk[15]);

}

/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D*/
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D*/
static int get_uuid_and_assign_addr(struct i2c_client *client,
				const struct i2c_device_id *id,
				struct smbusarp_data *data)
{
	u8 blk[I2C_SMBUS_BLOCK_MAX];
	s32 ret;
	u8 addr;

	/*smbus2.0 spec stage 6*/
	ret =3D i2c_smbus_read_block_data(client, ARP_GEN_GET_UDID, blk);
	printk(KERN_INFO "smbusarp.o: ARP general GET_UDID block read 0x%02x\n", r=
et);
	if (ret !=3D UDID_LENGTH) {
		printk(KERN_INFO "smbusarp.o: No ARP response on adapter %s\n",
			client->adapter->name);
		return -ENODEV;
	} else
		 printk(KERN_INFO "smbusarp.o: GET_UDID acked on adapter %s\n",
			client->adapter->name);
	/* debug, analyze of data*/
	smbusarp_print_uuid_info(blk);

	/*smbus2.0 stage 8 slot=3D16 see page 42*/
	addr =3D blk[16];
	printk(KERN_INFO "smbusarp.o: current gived addr %X\n", blk[16]);
	if (addr !=3D 0xFF) {
		/*smbus stage 9*/
		if ((blk[0] & 0xC0) > 0) {
			printk(KERN_INFO "smbusarp.o: stage10\n");
			/*smbus stage 10*/
			/*
			if (data->address_pool[addr] =3D=3D ADDRESS_ARP_FREE) {
				printk(KERN_INFO "smbusarp.o: \
				Requested a free addr \n");
			} else {
				printk(KERN_INFO "smbusarp.o: \
					Requested a non free address\n");
				addr =3D 0xFF;
			}*/
		}
		/*00 said addr fixed*/
	}
	if (addr =3D=3D 0xFF) {
		/*smbus2.0 stage 11*/
		addr =3D get_free_address(data->address_pool);
		if (addr =3D=3D 0) {
			printk(KERN_INFO "smbusarp.o: no address available");
			/*TODO invalid error code*/
			return -ENODEV;
		}
		printk(KERN_INFO "smbusarp.o: Found free address %02X\n", addr);
	}

	blk[16] =3D addr;
	printk(KERN_INFO "smbusarp.o: Final chosen address %02X\n", addr);
	/*smbus2.0 stage 12*/
	/*on assigne une addresse*/
	ret =3D i2c_smbus_write_block_data(client, ARP_ASSIGN_ADDR,
		UDID_LENGTH, blk);
	if (ret < 0) {
		printk(KERN_INFO "smbusarp.o: ASSIGN_ADDR %02x notacked err=3D%d\n", addr=
, ret);
		addr =3D 0x30;
		blk[16] =3D addr;
		printk(KERN_INFO "smbusarp.o: Final chosen address %02x on retry\n", addr=
);
		ret =3D i2c_smbus_write_block_data(client, ARP_ASSIGN_ADDR,
			UDID_LENGTH, blk);
		if (ret < 0) {
			printk(KERN_INFO "smbusarp.o: ASSIGN_ADDR %02x notacked bis err=3D%d\n",=
 addr, ret);
			return -ENODEV;
			}
	} else {
		printk(KERN_INFO "smbusarp.o: ASSIGN_ADDR %02x acked\n", addr);
		data->address_pool[addr] =3D ADDRESS_ARP_USED;
	}
	return 0;
}

/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D*/
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D*/
static int smbusarp_probe(struct i2c_client *client,
	const struct i2c_device_id *id)
{
	struct smbusarp_data *data;
	/*u8 blk[I2C_SMBUS_BLOCK_MAX];*/
	int ret =3D -1;
	int i;
	printk(KERN_INFO "smbusarp.o: smbusarp_probe\n");

	data =3D kzalloc(sizeof(struct smbusarp_data), GFP_KERNEL);
	if (!data)
		return -ENOMEM;

	i2c_set_clientdata(client, data);

	for (i =3D 0; i < SMBUS_ADDRESS_SIZE; i++)
		data->address_pool[i] =3D ADDRESS_ARP_FREE;

	/* smbus2.0 page 39 said that an enumerator can send reset, but without th=
at i receive nothing*/
	ret =3D i2c_smbus_write_byte(client, ARP_GEN_RESET_DEV);
	printk(KERN_INFO "smbusarp.o: ARP_GEN_RESET_DEV send on %s\n",
		client->adapter->name);


	/*smbus2.0 spec stage 2*/
	ret =3D i2c_smbus_write_byte(client, ARP_PREPARE_TO_ARP);
	if (ret < 0) {
		printk(KERN_INFO "smbusarp.o: PREPARE_TO_ARP send error on %s err=3D%d\n",
			client->adapter->name, ret);
		ret =3D i2c_smbus_read_byte(client);/* TO FINISH*/
		printk(KERN_INFO "smbusarp.o: i2c_smbus_read_byte %d\n", ret);
		kfree(data);
		return -ENODEV; /* Packet wasn't acked */
	}
	ret =3D get_uuid_and_assign_addr(client, id, data);
	/*TODO check ret*/

	data->hwmon_dev =3D hwmon_device_register(&client->dev);
	if (IS_ERR(data->hwmon_dev)) {
		printk(KERN_INFO "smbusarp.o: hwmon_device_register error\n");
		kfree(data);
		return PTR_ERR(data->hwmon_dev);
	}

	return 0;
}




static int __init sensors_smbusarp_init(void)
{
	printk(KERN_INFO "smbusarp.o: sensors_smbusarp_init\n");
	return i2c_add_driver(&smbusarp_driver);
}

static void __exit sensors_smbusarp_exit(void)
{
	printk(KERN_INFO "smbusarp.o: sensors_smbusarp_exit\n");
	i2c_del_driver(&smbusarp_driver);
}

MODULE_AUTHOR("LABBE Corentin");
MODULE_DESCRIPTION("smbusarp driver");
MODULE_LICENSE("GPL");

module_init(sensors_smbusarp_init);
module_exit(sensors_smbusarp_exit);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
