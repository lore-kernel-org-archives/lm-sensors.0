From: info@wore.ma.cx (wore)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: SMSC LPC47M192 SMBus question
Message-Id: <878y3o4qtj.wl@wore.ma.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <87vf6ua498.wl@wore.ma.cx>
In-Reply-To: <87vf6ua498.wl@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm not member of this list, so would you subscribe me to this list?

After I have wrote previous mail, I got infomation from the archive,
then I find my chip via SMBus.
http://archives.andrew.net.au/lm-sensors/msg30861.html


# check i2cdetect

According to PDF page 130,
> The default power on SMBus address is 010110x binary,
> where x reflects the state defined by the A0 pin.

0x2d is 0101101, so it seems it is the chip.

> $ sudo /usr/sbin/i2cdetect 1
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX 0c XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 XX 52 XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX


# check i2cdump

According to PDF page 184,
reg 0x3e is Company ID and default value is 0x55,
reg 0x3f is Stepping and default value is 0x20,

dump seems correct.

> $ sudo /usr/sbin/i2cdump 1 0x2d
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x2d, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 00 00    XXXXXXXXXXXXXX..
> 20: bf 7f c4 c5 c4 c4 1f 20 XX XX XX a7 99 72 ef af    ??????? XXX??r??
> 30: 76 6f 57 57 bf 77 cf f5 a4 bb 7d XX XX XX 55 20    voWW?w????}XXXU
> 40: 09 7f 0f XX XX XX XX 0d XX 80 00 72 00 00 XX 00    ???XXXX?X?.r..X.
> 50: ce bd 1f XX 1a ff fe c6 ed 3a XX XX XX XX XX XX    ???X?.???:XXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX


Then, I began to SMBus only driver on 2.4.29 kernel.
Currently, no function is implemented.
Just check chip corp and exit.

I will complete it by the weekend. 

here's syslog

> smsc47m192.o version 2.9.0 (20041228) Apr 12 2005 10:27:13
> 0x3e rets 0x55

Regards,
wore

-- 
/*
 * smsc47m192.c test by wore <info@wore.ma.cx>
 * based on asb100.c
 */

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/i2c-proc.h>
#include <linux/init.h>
#include "version.h"
#include "sensors_vid.h"

#ifndef I2C_DRIVERID_SMSC47M192
#define I2C_DRIVERID_SMSC47M192 1092
#endif

/* I2C addresses to scan */
static unsigned short normal_i2c[] = { 0x2d, SENSORS_I2C_END };
static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };

/* ISA addresses to scan (none) */
static unsigned int normal_isa[] = { SENSORS_ISA_END };
static unsigned int normal_isa_range[] = { SENSORS_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_1(smsc47m192);
SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: " \
	"{bus, clientaddr, subclientaddr1, subclientaddr2}");


/* For each registered client, we need to keep some data in memory. That
   data is pointed to by client->data. The structure itself is
   dynamically allocated, at the same time the client itself is allocated. */
struct smsc47m192_data {
	struct i2c_client client;
	struct semaphore lock;
	int sysctl_id;
	enum chips type;

	struct semaphore update_lock;
	unsigned long last_updated;	/* In jiffies */

	char valid;		/* !=0 if following fields are valid */
};

static int smsc47m192_attach_adapter(struct i2c_adapter *adapter);
static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
		unsigned short flags, int kind);
static int smsc47m192_detach_client(struct i2c_client *client);

static struct i2c_driver smsc47m192_driver = {
	.name		= "smsc47m192",
	.id		= I2C_DRIVERID_SMSC47M192,
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter	= smsc47m192_attach_adapter,
	.detach_client	= smsc47m192_detach_client,
};

/* -- SENSORS SYSCTL END -- */

static int smsc47m192_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, smsc47m192_detect);
}

static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
		unsigned short flags, int kind)
{
	int err;
	struct i2c_client *new_client;
	struct smsc47m192_data *data;

	/* asb100 is SMBus only */
	if (i2c_is_isa_adapter(adapter)) {
		pr_debug("smsc47m192.o: detect failed, "
				"cannot attach to legacy adapter!\n");
		err = -ENODEV;
		goto ERROR0;
	}

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
		pr_debug("smsc47m192.o: detect failed, "
				"smbus byte data not supported!\n");
		err = -ENODEV;
		goto ERROR0;
	}

	/* OK. For now, we presume we have a valid client. We now create the
	   client structure, even though we cannot fill it completely yet.
	   But it allows us to access asb100_{read,write}_value. */

	if (!(data = kmalloc(sizeof(struct smsc47m192_data), GFP_KERNEL))) {
		pr_debug("asb100.o: detect failed, kmalloc failed!\n");
		err = -ENOMEM;
		goto ERROR0;
	}

	new_client = &data->client;
	new_client->addr = address;
	init_MUTEX(&data->lock);
	new_client->data = data;
	new_client->adapter = adapter;
	new_client->driver = &smsc47m192_driver;
	new_client->flags = 0;

	/* Now, we do the remaining detection. */



        printk("0x3e rets 0x%x\n",
               i2c_smbus_read_byte_data(new_client, 0x3e));

	strcpy(new_client->name, "smsc47m192 chip");
	data->type = kind;

	data->valid = 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto ERROR1;

	/* Initialize the chip */
	/*
	asb100_init_client(new_client);
	*/

	return 0;

ERROR3:

ERROR2:
	i2c_detach_client(new_client);
ERROR1:
	kfree(data);
ERROR0:
	return err;
}

static int smsc47m192_detach_client(struct i2c_client *client)
{
	int err;
	struct smsc47m192_data *data = client->data;

	/* remove sysctl table (primary client only) */
	if ((data))
		i2c_deregister_entry(data->sysctl_id);

	if ((err = i2c_detach_client(client))) {
		printk (KERN_ERR "smsc47m192.o: Client deregistration failed; "
			"client not detached.\n");
		return err;
	}

	if (data) {
		/* primary client */
		kfree(data);
	} else {
		/* subclients */
		kfree(client);
	}

	return 0;
}

static void smsc47m192_init_client(struct i2c_client *client)
{
	struct smsc47m192_data *data = client->data;
	int vid = 0;
}

static void smsc47m192_update_client(struct i2c_client *client)
{
	struct smsc47m192_data *data = client->data;
	int i;

	down(&data->update_lock);

	up(&data->update_lock);
}


static int __init smsc47m192_init(void)
{
	printk(KERN_INFO "smsc47m192.o version %s (%s) %s %s\n",
	       LM_VERSION, LM_DATE, __DATE__, __TIME__);
	return i2c_add_driver(&smsc47m192_driver);
}

static void __exit smsc47m192_exit(void)
{
	i2c_del_driver(&smsc47m192_driver);
}

MODULE_AUTHOR("wore <info@wore.ma.cx>");
MODULE_DESCRIPTION("smsc47m192 driver");
MODULE_LICENSE("GPL");

module_init(smsc47m192_init);
module_exit(smsc47m192_exit);
