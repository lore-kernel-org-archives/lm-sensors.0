From: info@wore.ma.cx (wore)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: SMSC LPC47M192 SMBus question
Message-Id: <87wtr6ejy1.wl@wore.ma.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <87vf6ua498.wl@wore.ma.cx>
In-Reply-To: <87vf6ua498.wl@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> You might want to get in touch with Tomas Holmqvist, who contacted us
> some times ago for a similar problem:
> http://archives.andrew.net.au/lm-sensors/msg29831.html

Thanks.

> I think I remember that the LPC47M15x and LPC47M192 are mostly compatible
> (would need to verify with the datasheets whether this applied to the
> HWM block as well). If this is the case, it would probably make sense to
> join your forces and write a single driver for both chips.

Oh, really? LPC47M15x and LPC47M192 are compatible?
But, I cannot help writing code, because I do want to check my CPU temp.
Then, I've wrote little code for just check up current temp
and putted it into my local HotSaNIC graph.

My code is really stupid, but it can get temperature so I'm satisfied with it.
Anyway, I will finish by this weekend.

Thanks,
wore
-- 
/*
    smsc47m192.c test by wore <info@wore.ma.cx>
    smsc47m192.c - Part of lm_sensors, Linux kernel modules
                   for hardware monitoring

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
/* 010110x */
static unsigned short normal_i2c[] = { 0x2c, 0x2d, SENSORS_I2C_END };
static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };

/* ISA addresses to scan (none) */
static unsigned int normal_isa[] = { SENSORS_ISA_END };
static unsigned int normal_isa_range[] = { SENSORS_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_1(smsc47m192);

/* Many SMSC47M192 constants specified below */

/* The SMSC47M192 registers */
/* r */
#define SMSC47M192_HMB_CORPID   0x3e
#define SMSC47M192_HMB_SETPPING 0x3f
#define SMSC47M192_HMB_TEMP1    0x26
#define SMSC47M192_HMB_TEMP1_H  0x37
#define SMSC47M192_HMB_TEMP1_L  0x38
#define SMSC47M192_HMB_TEMP2    0x27
#define SMSC47M192_HMB_TEMP2_H  0x39
#define SMSC47M192_HMB_TEMP2_L  0x3a

/* from lm78.c */
#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)

struct smsc47m192_data {
	struct i2c_client client;
	struct semaphore lock;
	int sysctl_id;
	enum chips type;

	struct semaphore update_lock;
	unsigned long last_updated;	/* In jiffies */

	char valid;		/* !=0 if following fields are valid */

	u8 temp[2];
	u8 temp_high[2];
	u8 temp_low[2];
};

static int smsc47m192_attach_adapter(struct i2c_adapter *adapter);
static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
		unsigned short flags, int kind);
static int smsc47m192_detach_client(struct i2c_client *client);

static int smsc47m192_read_value(struct i2c_client *client, u8 reg);
/*
static int smsc47m192_write_value(struct i2c_client *client, u8 reg, u8 value);
*/
static void smsc47m192_update_client(struct i2c_client *client);
static void smsc47m192_init_client(struct i2c_client *client);

static void smsc47m192_temp(struct i2c_client *client, int operation,
			    int ctl_name, int *nrels_mag, long *results);

static int smsc47m192_id = 0;

static struct i2c_driver smsc47m192_driver = {
	.name		= "smsc47m192",
	.id		= I2C_DRIVERID_SMSC47M192,
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter	= smsc47m192_attach_adapter,
	.detach_client	= smsc47m192_detach_client,
};

/* The /proc/sys entries */

/* -- SENSORS SYSCTL START -- */

#define SMSC47M192_SYSCTL_TEMP1 1200
#define SMSC47M192_SYSCTL_TEMP2 1201

/* -- SENSORS SYSCTL END -- */

#define SMSC47M192_SYSCTL_TEMP(nr) {SMSC47M192_SYSCTL_TEMP##nr, \
        "temp" #nr, NULL, 0, 0644, NULL, &i2c_proc_real, &i2c_sysctl_real, \
        NULL, &smsc47m192_temp}

static ctl_table smsc47m192_dir_table_template[] = {
  SMSC47M192_SYSCTL_TEMP(1),
  SMSC47M192_SYSCTL_TEMP(2),
  {0}
};

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

	pr_debug("smsc47m192.o: smsc47m192_detect\n");
	/* asb100 is SMBus only */
	if (i2c_is_isa_adapter(adapter)) {
		pr_debug("smsc47m192.o: detect failed, "
				"cannot attach to legacy adapter!\n");
		err = -ENODEV;
		goto ERROR0;
	}
	printk(KERN_INFO "smsc47m192.o: pass SMBus only\n");

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
		pr_debug("smsc47m192.o: detect failed, "
				"smbus byte data not supported!\n");
		err = -ENODEV;
		goto ERROR0;
	}
	printk(KERN_INFO "smsc47m192.o: pass SMBus func check\n");

	/* OK. For now, we presume we have a valid client. We now create the
	   client structure, even though we cannot fill it completely yet.
	   But it allows us to access smsc47m192_{read,write}_value. */

	if (!(data = kmalloc(sizeof(struct smsc47m192_data), GFP_KERNEL))) {
		pr_debug("smsc47m192.o: detect failed, kmalloc failed!\n");
		err = -ENOMEM;
		goto ERROR0;
	}
	printk(KERN_INFO "smsc47m192.o: pass kmalloc\n");

	new_client = &data->client;
	new_client->addr = address;
	init_MUTEX(&data->lock);
	new_client->data = data;
	new_client->adapter = adapter;
	new_client->driver = &smsc47m192_driver;
	new_client->flags = 0;

        printk(KERN_INFO "0x3e rets 0x%x\n",
               i2c_smbus_read_byte_data(new_client, 0x3e));

	strcpy(new_client->name, "smsc47m192 chip");
	data->type = kind;

	new_client->id = smsc47m192_id++;
	data->valid = 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto ERROR1;

	/* Initialize the chip */
	smsc47m192_init_client(new_client);

	if ((data->sysctl_id = i2c_register_entry(new_client, "smsc47m192",
		smsc47m192_dir_table_template, THIS_MODULE)) < 0) {
	  err = data->sysctl_id;
	  goto ERROR3;
	}
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


static int smsc47m192_read_value(struct i2c_client *client, u8 reg)
{
	struct smsc47m192_data *data = client->data;
	struct i2c_client *cl;
	int res;

	down(&data->lock);

	res = i2c_smbus_read_byte_data(client, reg & 0xff);

	up(&data->lock);

	return res;
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

        if (time_after(jiffies - data->last_updated, HZ + HZ / 2) ||
	    time_before(jiffies, data->last_updated) || !data->valid) {

	  /* 2 temperature inputs */
	  data->temp[0] = smsc47m192_read_value(client, SMSC47M192_HMB_TEMP1);
	  data->temp[1] = smsc47m192_read_value(client, SMSC47M192_HMB_TEMP2);

	  data->temp_high[0] = smsc47m192_read_value(client, SMSC47M192_HMB_TEMP1_H);
	  data->temp_high[1] = smsc47m192_read_value(client, SMSC47M192_HMB_TEMP2_H);

	  data->temp_low[0] = smsc47m192_read_value(client, SMSC47M192_HMB_TEMP1_L);
	  data->temp_low[1] = smsc47m192_read_value(client, SMSC47M192_HMB_TEMP2_L);
						     
	  data->last_updated = jiffies;
	  data->valid = 1;
	}
	up(&data->update_lock);
}

static void smsc47m192_temp(struct i2c_client *client, int operation,
			    int ctl_name, int *nrels_mag, long *results)
{
	struct smsc47m192_data *data = client->data;
	int nr = ctl_name - SMSC47M192_SYSCTL_TEMP1;

        if (operation = SENSORS_PROC_REAL_INFO) {
	  *nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_READ) {
	  smsc47m192_update_client(client);
	  results[0] = TEMP_FROM_REG(data->temp_high[nr]);
	  results[1] = TEMP_FROM_REG(data->temp_low[nr]);
	  results[2] = TEMP_FROM_REG(data->temp[nr]);
	  *nrels_mag = 3;
	}
}
static int __init sm_smsc47m192_init(void)
{
  int r;
	printk(KERN_INFO "smsc47m192.o version %s (%s) %s %s\n",
	       LM_VERSION, LM_DATE, __DATE__, __TIME__);
	r = i2c_add_driver(&smsc47m192_driver);
	printk(KERN_INFO "i2c_add_driver returns %d\n", r);
	return r;
}

static void __exit sm_smsc47m192_exit(void)
{
	i2c_del_driver(&smsc47m192_driver);
}

MODULE_AUTHOR("wore <info@wore.ma.cx>");
MODULE_DESCRIPTION("smsc47m192 driver");
MODULE_LICENSE("GPL");

module_init(sm_smsc47m192_init);
module_exit(sm_smsc47m192_exit);
