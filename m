From: margit@margit.com (Margit Schubert-While)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: LM85
Message-Id: <4.3.2.7.2.20030211181355.00b62100@mail.dns-host.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
	I took a shot at the LM85 found on eg. Intel D845PE MB among
	others.
	At the moment, this is read-only, providing values for voltages,
	temps, fans, status in /proc/...

	There are "ifdefs" for the I2C ID and SYSCTL's, so doesn't rely
	on changes in the normal include files.
	"inttemp" is the LM85 temp.
	"proctemp" is the processor temp.
	"remtemp" is the temp at the edge of the keep-out zone.
	The rest are obvious.

	The 2V5 reading, at first glance, looks weird, however it is correct.
	The 845PESV has 1V5 here, although the scale muliplier is still 250.

	Register definitions are complete based on the Nat Sem specs at :
	<http://www.national.com/pf/LM/LM85.html>

	lsmod :
Module                  Size  Used by    Not tainted
lm85                    5204   0  (unused)
i2c-proc                7120   0  [lm85]
i2c-dev                 4420   0  (unused)
i2c-i801                4756   0  (unused)
i2c-core               14856   0  [lm85 i2c-proc i2c-dev i2c-i801]

/proc/sys/dev/sensors # ls
	chips  lm85-i2c-0-2e

/proc/sys/dev/sensors/lm85-i2c-0-2e # ls
	12v  3v3  alarms   fan1  fan3  inttemp   remtemp
	2v5  5v   corevcc  fan2  fan4  proctemp  vccp

cat 12v
	0.00 15.93 12.00
cat 2v5
	0.00 3.32 1.49
cat 3v3
	0.00 4.38 3.24
cat 5v
	0.00 6.64 5.05
cat alarms
	0
cat corevcc
	1.500
cat fan1
	0 4112
cat fan2
	0 0
cat fan3
	0 1301
cat fan4
	0 1097
cat inttemp
	-127 127 32
cat proctemp
	-127 127 34
cat remtemp
	-127 127 31
cat vccp
	0.00 2.98 1.45
-------------- next part --------------
/*
	LM85.c - Part of lm_sensors, Linux kernel modules for hardware
		 monitoring
	Copyright (c) 2003	Margit Schubert-While <margitsw@t-online.de>
	Based on LM87:
	Copyright (c) 2000	Frodo Looijaard <frodol@dds.nl>
				Philip Edelbrock <phil@netroedge.com>
				Stephen Rousset <stephen.rousset@rocketlogix.com>
				Dan Eaton <dan.eaton@rocketlogix.com>

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or 
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/


#include <linux/version.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/proc_fs.h>
#include <linux/ioport.h>
#include <linux/sysctl.h>
#include <asm/errno.h>
#include <asm/io.h>
#include <linux/types.h>
#include <linux/i2c.h>
#define LM_DATE "20021208"
#define LM_VERSION "2.7.0"
#include <linux/sensors.h>
#include <linux/sensors_vid.h>
#include <linux/init.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)) || \
    (LINUX_VERSION_CODE = KERNEL_VERSION(2,3,0))
#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
#endif

#ifndef THIS_MODULE
#define THIS_MODULE NULL
#endif

/* LM85 defines if not in i2c/sensors includes */
#ifndef	I2C_DRIVERID_LM85
#define I2C_DRIVERID_LM85	1038
#endif

#ifndef LM85_SYSCTL_2_5V
#define LM85_SYSCTL_2_5V	1000
#define LM85_SYSCTL_VCCP	1001
#define LM85_SYSCTL_3_3V	1002
#define LM85_SYSCTL_5V		1003
#define LM85_SYSCTL_12V		1004
#define LM85_SYSCTL_PROC_TEMP	1005
#define LM85_SYSCTL_INT_TEMP	1006
#define LM85_SYSCTL_REMOTE_TEMP	1007
#define LM85_SYSCTL_FAN1	1100
#define LM85_SYSCTL_FAN2	1101
#define LM85_SYSCTL_FAN3	1102
#define LM85_SYSCTL_FAN4	1103
#define LM85_SYSCTL_ALARMS	2001 /* bitvector */
#define LM85_SYSCTL_VID4	2002

#define LM85_ALARM_2V5		0x0001
#define LM85_ALARM_VCCP		0x0002
#define LM85_ALARM_3V3		0x0004
#define LM85_ALARM_5V0		0x0008
#define LM85_ALARM_PROC_TEMP	0x0010
#define LM85_ALARM_INT_TEMP	0x0020
#define LM85_ALARM_REMOTE_TEMP	0x0040
#define LM85_ALARM_STATUS2	0x0080
#define LM85_ALARM_12V		0x0100
#define LM85_ALARM_RESERVED	0x0200
#define LM85_ALARM_FAN1		0x0400
#define LM85_ALARM_FAN2		0x0800
#define LM85_ALARM_FAN3		0x1000
#define LM85_ALARM_FAN4		0x2000
#define LM85_ALARM_REM1		0x4000
#define LM85_ALARM_REM2		0x8000
#endif

/* Addresses to scan */
static unsigned short normal_i2c[] = { SENSORS_I2C_END };
static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, SENSORS_I2C_END };
static unsigned int normal_isa[] = { SENSORS_ISA_END };
static unsigned int normal_isa_range[] = { SENSORS_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_1(lm85);

/* The following is the calculation for the register offset
 * for the monitored items minimum and maximum locations.
 */
#define LM85_REG_IN(nr)		(0x20 + (nr))
#define LM85_REG_IN_MIN(nr)	(0x44 + ((nr) * 2))
#define LM85_REG_IN_MAX(nr)	(0x45 + ((nr) * 2))
#define LM85_REG_IN_FAN_LSB(nr)	(0x28 + ((nr) * 2))
#define LM85_REG_IN_FAN_MSB(nr)	(0x29 + ((nr) * 2))

	/* The LM85 registers */

	/* These are read-only */
#define LM85_REG_2_5V			0x20	/* Scaled */
#define LM85_REG_VCCP			0x21	/* Scaled */
#define LM85_REG_3_3V			0x22	/* Scaled */
#define LM85_REG_5V			0x23	/* Scaled */
#define LM85_REG_12V			0x24	/* Scaled */
#define LM85_REG_PROC_TEMP		0x25	/* Processor temp */
#define LM85_REG_INT_TEMP		0x26	/* LM85 temp. */
#define LM85_REG_REMOTE_TEMP		0x27	/* Remote temp, Edge of keep-out area*/
#define LM85_REG_TACH1_LSB		0x28	/* MSB 15-8 + LSB 7-2 = */
#define LM85_REG_TACH1_MSB		0x29	/* 1 Rev time @ 90 KHz	*/
#define LM85_REG_TACH2_LSB		0x2A	/* When LSB is read, MSB is */
#define LM85_REG_TACH2_MSB		0x2B	/* latched/pegged until read */
#define LM85_REG_TACH3_LSB		0x2C
#define LM85_REG_TACH3_MSB		0x2D
#define LM85_REG_TACH4_LSB		0x2E
#define LM85_REG_TACH4_MSB		0x2F

	/* These are read/write */
#define LM85_REG_FAN1_PWM		0x30
#define LM85_REG_FAN2_PWM		0x31
#define LM85_REG_FAN3_PWM		0x32

	/* These are read-only */
#define LM85_REG_COMPANY_ID		0x3E	/* = 0x01 for NS LM85 */
#define LM85_REG_VERS_STEP		0x3F	/* 4 bits version, 4 bits stepping */

	/* These are read/write */
#define LM85_REG_CONFIG			0x40

	/* These are read-only */
#define LM85_REG_INT1_STAT		0x41	/* Status 1 */
#define LM85_REG_INT2_STAT		0x42	/* Status 2 */
#define LM85_REG_VID4			0x43	/* Processor core voltage scaled */

	/* These are read/write */
#define LM85_REG_2_5V_LOW		0x44
#define LM85_REG_2_5V_HIGH		0x45
#define LM85_REG_VCCP_LOW		0x46
#define LM85_REG_VCCP_HIGH		0x47
#define LM85_REG_3_3V_LOW		0x48
#define LM85_REG_3_3V_HIGH		0x49
#define LM85_REG_5V_LOW			0x4A
#define LM85_REG_5V_HIGH		0x4B
#define LM85_REG_12V_LOW		0x4C
#define LM85_REG_12V_HIGH		0x4D
#define LM85_REG_PROC_TEMP_LOW		0x4E
#define LM85_REG_PROC_TEMP_HIGH		0x4F
#define LM85_REG_INT_TEMP_LOW		0x50
#define LM85_REG_INT_TEMP_HIGH		0x51
#define LM85_REG_REMOTE_TEMP_LOW	0x52
#define LM85_REG_REMOTE_TEMP_HIGH	0x53
#define LM85_REG_TACH1_LSB_LOW		0x54
#define LM85_REG_TACH1_MSB_LOW		0x55
#define LM85_REG_TACH2_LSB_LOW		0x56
#define LM85_REG_TACH2_MSB_LOW		0x57
#define LM85_REG_TACH3_LSB_LOW		0x58
#define LM85_REG_TACH3_MSB_LOW		0x59
#define LM85_REG_TACH4_LSB_LOW		0x5A
#define LM85_REG_TACH4_MSB_LOW		0x5B

#define LM85_REG_FAN1_CONFIG		0x5C
#define LM85_REG_FAN2_CONFIG		0x5D
#define LM85_REG_FAN3_CONFIG		0x5E
#define LM85_REG_FAN1_RANGE		0x5F
#define LM85_REG_FAN2_RANGE		0x60
#define LM85_REG_FAN3_RANGE		0x61
#define LM85_REG_SPIKE1			0x62	/* 3 bits Min/off, 1 bit res, 4 bits Zone 1 */
#define LM85_REG_SPIKE2			0x63	/* 4 bits Zone 2, 4 bits Zone 3 */
#define LM85_REG_FAN1_PWM_LOW		0x64
#define LM85_REG_FAN2_PWM_LOW		0x65
#define LM85_REG_FAN3_PWM_LOW		0x66
#define LM85_REG_PROC_FAN_TEMP_LIMIT	0x67
#define LM85_REG_INT_FAN_TEMP_LIMIT	0x68
#define LM85_REG_REMOTE_FAN_TEMP_LIMIT	0x69
#define LM85_REG_PROC_TEMP_ABS_LIMIT	0x6A
#define LM85_REG_INT_TEMP_ABS_LIMIT	0x6B
#define LM85_REG_REMOTE_TEMP_ABS_LIMIT	0x6C
#define LM85_REG_PROC_INT_HYTERESIS	0x6D	/* 4 bits Proc, 4 bits Intern */
#define LM85_REG_REMOTE_HYTERESIS	0x6E	/* 4 bits Remote, 4 bits Reserved */
#define LM85_REG_XOR_TEST_TREE		0x6F
#define LM85_REG_TACH_MONITOR_MODE	0x74	/* 2 bits res, 2 bits for T3/4, T2, T1 */
#define LM85_REG_FAN_SPIN_UP		0x75


#define LM85_SYSCTL_BASE		1000	/* Base value for sysctl */

#define TEMP_FROM_REG(temp)	(temp)

#define TEMP_LIMIT_FROM_REG(val) ((val)>0x80?(val)-0x100:(val))

#define TEMP_LIMIT_TO_REG(val) SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
						((val)+5)/10),0,255)

#define ALARMS_FROM_REG(val) (val)


#ifdef MODULE
extern int init_module(void);
extern int cleanup_module(void);
#endif				/* MODULE */

/* For each registered LM85, we need to keep some data in memory. That
   data is pointed to by LM85_list[NR]->data. The structure itself is
   dynamically allocated, at the same time when a new LM85 client is
   allocated. */
struct lm85_data {
	int			sysctl_id;
	enum chips		type;

	struct semaphore	update_lock;
	char			valid;		/* !=0 if following fields are valid */
	unsigned long		last_updated;	/* In jiffies */

	u8	in[5];		/* Scaled Register value */
	u8	in_min[5];	/* Scaled Register value */
	u8	in_max[5];	/* Scaled Register value */
	u8	proctemp;	/* Scaled Register value */
	u8	proctemp_min;	/* Scaled Register value */
	u8	proctemp_max;	/* Scaled Register value */
	u8	inttemp;	/* Scaled Register value */
	u8	inttemp_min;	/* Scaled Register value */
	u8	inttemp_max;	/* Scaled Register value */
	u8	remtemp;	/* Scaled Register value */
	u8	remtemp_min;	/* Scaled Register value */
	u8	remtemp_max;	/* Scaled Register value */
	u16	fan1;		/* Register value */
	u16	fan1_min;	/* Register value */
	u16	fan2;		/* Register value */
	u16	fan2_min;	/* Register value */
	u16	fan3;		/* Register value */
	u16	fan3_min;	/* Register value */
	u16	fan4;		/* Register value */
	u16	fan4_min;	/* Register value */
	u16	alarms;		/* Register encoding, combined */
	u8	vid4;		/* Register value combined */
	u8	spare;		/* Spare */
};

#ifdef MODULE
static
#else
extern
#endif
int __init sensors_lm85_init(void);
static int __init lm85_cleanup(void);

static int lm85_attach_adapter(struct i2c_adapter *adapter);
static int lm85_detect(struct i2c_adapter *adapter, int address,
			unsigned short flags, int kind);
static int lm85_detach_client(struct i2c_client *client);
static int lm85_command(struct i2c_client *client, unsigned int cmd,
			void *arg);
static void lm85_inc_use(struct i2c_client *client);
static void lm85_dec_use(struct i2c_client *client);

static int lm85_read_value(struct i2c_client *client, u8 register);
static int lm85_write_value(struct i2c_client *client, u8 register,
				u8 value);
static void lm85_update_client(struct i2c_client *client);
static void lm85_init_client(struct i2c_client *client);


static void lm85_in(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void lm85_fan(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void lm85_temp(struct i2c_client *client, int operation,
			 int ctl_name, int *nrels_mag, long *results);
static void lm85_alarms(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void lm85_vid4(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);

/* I choose here for semi-static LM85 allocation. Complete dynamic
   allocation could also be used; the code needed for this would probably
   take more memory than the datastructure takes now. */
static int lm85_id = 0;

static struct i2c_driver LM85_driver = {
	"LM85 sensor driver",		/* name */
	I2C_DRIVERID_LM85,		/* id */
	I2C_DF_NOTIFY,			/* flags */
	&lm85_attach_adapter,		/* attach_adapter */
	&lm85_detach_client,		/* detach_adapter */
	&lm85_command,			/* command */
	&lm85_inc_use,			/* inc_use */
	&lm85_dec_use			/* dec_use */
};

/* Used by LM85_init/cleanup */
static int __initdata lm85_initialized = 0;

/* The /proc/sys entries */
/* These files are created for each detected LM85. This is just a template;
   though at first sight, you might think we could use a statically
   allocated list, we need some way to get back to the parent - which
   is done through one of the 'extra' fields which are initialized 
   when a new copy is allocated. */

static ctl_table LM85_dir_table_template[] = {
	{LM85_SYSCTL_2_5V,	"2v5", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_in},
	{LM85_SYSCTL_VCCP,	"vccp", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_in},
	{LM85_SYSCTL_3_3V,	"3v3", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_in},
	{LM85_SYSCTL_5V,	"5v", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_in},
	{LM85_SYSCTL_12V,	"12v", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_in},
	{LM85_SYSCTL_PROC_TEMP, "proctemp", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_temp},
	{LM85_SYSCTL_INT_TEMP,	"inttemp", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_temp},
	{LM85_SYSCTL_REMOTE_TEMP, "remtemp", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_temp},
	{LM85_SYSCTL_FAN1,	"fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_fan},
	{LM85_SYSCTL_FAN2,	"fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_fan},
	{LM85_SYSCTL_FAN3,	"fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_fan},
	{LM85_SYSCTL_FAN4,	"fan4", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_fan},
	{LM85_SYSCTL_ALARMS,	"alarms", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_alarms},
	{LM85_SYSCTL_VID4,	"corevcc", NULL, 0, 0644, NULL, &i2c_proc_real,
		&i2c_sysctl_real, NULL, &lm85_vid4},

	{0}
};

int lm85_attach_adapter(struct i2c_adapter *adapter)
{
	int error;
	struct i2c_client_address_data	lm85_client_data;

	lm85_client_data.normal_i2c		= addr_data.normal_i2c;
	lm85_client_data.normal_i2c_range	= addr_data.normal_i2c_range;
	lm85_client_data.probe			= addr_data.probe;
	lm85_client_data.probe_range		= addr_data.probe_range;
	lm85_client_data.ignore			= addr_data.ignore;
	lm85_client_data.ignore_range		= addr_data.ignore_range;
	lm85_client_data.force			= addr_data.forces->force;

	error = i2c_probe(adapter, &lm85_client_data, lm85_detect);
	i2c_detect(adapter, &addr_data, lm85_detect);

	return error;
}

static int lm85_detect(struct i2c_adapter *adapter, int address,
			unsigned short flags, int kind)
{
	int i;
	struct i2c_client *new_client;
	struct lm85_data *data;
	int err = 0;
	const char *type_name = "";
	const char *client_name = "";

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		goto ERROR0;

	/* OK. For now, we presume we have a valid client. We now create the
	   client structure, even though we cannot fill it completely yet.
	   But it allows us to access LM85_{read,write}_value. */

	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
				   sizeof(struct lm85_data),
				   GFP_KERNEL))) {
		err = -ENOMEM;
		goto ERROR0;
	}

	data = (struct lm85_data *) (new_client + 1);
	new_client->addr = address;
	new_client->data = data;
	new_client->adapter = adapter;
	new_client->driver = &LM85_driver;
	new_client->flags = 0;

	/* Now, we do the remaining detection. */

	if (kind < 0) {
		if (((lm85_read_value(new_client, LM85_REG_CONFIG) & 0x80)
			!= 0x00) ||
		    (lm85_read_value(new_client, LM85_REG_COMPANY_ID) != 0x01))
			goto ERROR1;
	}

	/* Fill in the remaining client fields and put into the global list */
	type_name = "lm85";
	client_name = "LM85 chip";
	strcpy(new_client->name, client_name);
	data->type = kind;

	new_client->id = lm85_id++;
	data->valid = 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto ERROR3;

	/* Register a new directory entry with module sensors */
	if ((i = i2c_register_entry(new_client,
					type_name,
					LM85_dir_table_template,
					THIS_MODULE)) < 0) {
		err = i;
		goto ERROR4;
	}
	data->sysctl_id = i;

	/* Initialize the LM85 chip */
	lm85_init_client(new_client);
	return 0;

/* OK, this is not exactly good programming practice, usually. But it is
   very code-efficient in this case. */

      ERROR4:
	i2c_detach_client(new_client);
      ERROR3:
      ERROR1:
	kfree(new_client);
      ERROR0:
	return err;
}

int lm85_detach_client(struct i2c_client *client)
{
	int err;

	i2c_deregister_entry(((struct lm85_data *) (client->data))->
				 sysctl_id);

	if ((err = i2c_detach_client(client))) {
		printk
		    ("lm85.o: Client deregistration failed, client not detached.\n");
		return err;
	}

	kfree(client);

	return 0;

}

/* No commands defined yet */
int lm85_command(struct i2c_client *client, unsigned int cmd, void *arg)
{
	return 0;
}

void lm85_inc_use(struct i2c_client *client)
{
#ifdef MODULE
	MOD_INC_USE_COUNT;
#endif
}

void lm85_dec_use(struct i2c_client *client)
{
#ifdef MODULE
	MOD_DEC_USE_COUNT;
#endif
}

int lm85_read_value(struct i2c_client *client, u8 reg)
{
	return 0xFF & i2c_smbus_read_byte_data(client, reg);
}

int lm85_write_value(struct i2c_client *client, u8 reg, u8 value)
{
	return i2c_smbus_write_byte_data(client, reg, value);
}

/* Called when we have found a new LM85. It should set limits, etc. */
void lm85_init_client(struct i2c_client *client)
{
/*
	struct lm85_data *data = client->data;
*/

/*
	lm85_write_value(client, LM85_REG_TACH_MONITOR_MODE, 0x0);
*/

	/* Start monitoring */
	lm85_write_value(client, LM85_REG_CONFIG, 0x01);
}

void lm85_update_client(struct i2c_client *client)
{
	struct lm85_data	*data = client->data;
	int 			i;
	u8			lsb, msb;

	down(&data->update_lock);

	if ((jiffies - data->last_updated > 2*HZ) ||  /* 2 sec cache */
            (jiffies < data->last_updated)      || 
             !data->valid) {
		for (i = 0; i < 5; i++) {  
		 data->in[i] = 
		    lm85_read_value(client,LM85_REG_IN(i));
		 data->in_min[i] = 
		    lm85_read_value(client,LM85_REG_IN_MIN(i));
		 data->in_max[i] = 
		    lm85_read_value(client,LM85_REG_IN_MAX(i));
		}

		data->proctemp = 
		    lm85_read_value(client,LM85_REG_PROC_TEMP);
		data->proctemp_min = 
		    lm85_read_value(client,LM85_REG_PROC_TEMP_LOW);
		data->proctemp_max = 
		    lm85_read_value(client,LM85_REG_PROC_TEMP_HIGH);
		data->inttemp = 
		    lm85_read_value(client,LM85_REG_INT_TEMP);
		data->inttemp_min = 
		    lm85_read_value(client,LM85_REG_INT_TEMP_LOW);
		data->inttemp_max = 
		    lm85_read_value(client,LM85_REG_INT_TEMP_HIGH);
		data->remtemp = 
		    lm85_read_value(client,LM85_REG_REMOTE_TEMP);
		data->remtemp_min = 
		    lm85_read_value(client,LM85_REG_REMOTE_TEMP_LOW);
		data->remtemp_max = 
		    lm85_read_value(client,LM85_REG_REMOTE_TEMP_HIGH);

		lsb = lm85_read_value(client,LM85_REG_TACH1_LSB);
		msb = lm85_read_value(client,LM85_REG_TACH1_MSB);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan1 = 0;
		} else {
			data->fan1 = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH2_LSB);
		msb = lm85_read_value(client,LM85_REG_TACH2_MSB);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan2 = 0;
		} else {
			data->fan2 = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH3_LSB);
		msb = lm85_read_value(client,LM85_REG_TACH3_MSB);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan3 = 0;
		} else {
			data->fan3 = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH4_LSB);
		msb = lm85_read_value(client,LM85_REG_TACH4_MSB);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan4 = 0;
		} else {
			data->fan4 = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH1_LSB_LOW);
		msb = lm85_read_value(client,LM85_REG_TACH1_MSB_LOW);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan1_min = 0;
		} else {
			data->fan1_min = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH2_LSB_LOW);
		msb = lm85_read_value(client,LM85_REG_TACH2_MSB_LOW);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan2_min = 0;
		} else {
			data->fan2_min = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH3_LSB_LOW);
		msb = lm85_read_value(client,LM85_REG_TACH3_MSB_LOW);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan3_min = 0;
		} else {
			data->fan3_min = (lsb >> 2) + (msb << 8);
		}
		lsb = lm85_read_value(client,LM85_REG_TACH4_LSB_LOW);
		msb = lm85_read_value(client,LM85_REG_TACH4_MSB_LOW);
		if ( lsb = 0xff && msb = 0xff ) {
			data->fan4_min = 0;
		} else {
			data->fan4_min = (lsb >> 2) + (msb << 8);
		}

		data->alarms 			lm85_read_value(client, LM85_REG_INT1_STAT) +
			(lm85_read_value(client, LM85_REG_INT2_STAT) << 8);

		data->vid4 			lm85_read_value(client, LM85_REG_VID4) & 0x1f;
/*
		data->fan1 = 
		    ( lm85_read_value(client,LM85_REG_TACH1_LSB) >>2 ) +
		data->fan1 = 
		    ( lm85_read_value(client,LM85_REG_TACH1_LSB) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH1_MSB) <<8 );
		data->fan2 = 
		    ( lm85_read_value(client,LM85_REG_TACH2_LSB) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH2_MSB) <<8 );
		data->fan3 = 
		    ( lm85_read_value(client,LM85_REG_TACH3_LSB) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH3_MSB) <<8 );
		data->fan4 = 
		    ( lm85_read_value(client,LM85_REG_TACH4_LSB) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH4_MSB) <<8 );
		data->fan1_min = 
		    ( lm85_read_value(client,LM85_REG_TACH1_LSB_LOW) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH1_MSB_LOW) <<8 );
		data->fan2_min = 
		    ( lm85_read_value(client,LM85_REG_TACH2_LSB_LOW) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH2_MSB_LOW) <<8 );
		data->fan3_min = 
		    ( lm85_read_value(client,LM85_REG_TACH3_LSB_LOW) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH3_MSB_LOW) <<8 );
		data->fan4_min = 
		    ( lm85_read_value(client,LM85_REG_TACH4_LSB_LOW) >>2 ) +
		    ( lm85_read_value(client,LM85_REG_TACH4_MSB_LOW) <<8 );
*/

		data->last_updated = jiffies;
		data->valid = 1;
	}
	up(&data->update_lock);
}


/* The next few functions are the call-back functions of the /proc/sys and
   sysctl files. Which function is used is defined in the ctl_table in
   the extra1 field.
   Each function must return the magnitude (power of 10 to divide the data
   with) if it is called with operation=SENSORS_PROC_REAL_INFO. It must
   put a maximum of *nrels elements in results reflecting the data of this
   file, and set *nrels to the number it actually put in it, if operation=
   SENSORS_PROC_REAL_READ. Finally, it must get upto *nrels elements from
   results and write them to the chip, if operations=SENSORS_PROC_REAL_WRITE.
   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
   large enough (by checking the incoming value of *nrels). This is not very
   good practice, but as long as you put less than about 5 values in results,
   you can assume it is large enough. */
void lm85_in(struct i2c_client *client, int operation, int ctl_name,
		int *nrels_mag, long *results)
{

	struct lm85_data	*data = client->data;
	int			nr = ctl_name - LM85_SYSCTL_BASE;
	long			scales[5] = { 250, 225, 330, 500, 1200 };

	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 2;
	else if (operation = SENSORS_PROC_REAL_READ) {
		lm85_update_client(client);
		results[0] 			((long)data->in_min[nr] * scales[nr]) / 192;
		results[1] 			((long)data->in_max[nr] * scales[nr]) / 192;
		results[2] 			((long)data->in[nr] * scales[nr]) / 192;
		*nrels_mag = 3;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
/* MSW NO WRITE
		if (*nrels_mag >= 1) {
			data->in_min[nr] 			    (results[0] * 192) / scales[nr];
			lm85_write_value(client, LM85_REG_IN_MIN(nr),
					    data->in_min[nr]);
		}
		if (*nrels_mag >= 2) {
			data->in_max[nr] 			    (results[1] * 192) / scales[nr];
			lm85_write_value(client, LM85_REG_IN_MAX(nr),
					    data->in_max[nr]);
		}
*/
	}
}

void lm85_temp(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct lm85_data *data = client->data;

	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		lm85_update_client(client);
		switch(ctl_name) {
		case LM85_SYSCTL_PROC_TEMP:
			results[0] = TEMP_LIMIT_FROM_REG(data->proctemp_min);
			results[1] = TEMP_LIMIT_FROM_REG(data->proctemp_max);
			results[2] = TEMP_FROM_REG(data->proctemp);
			break;
		case LM85_SYSCTL_INT_TEMP:
			results[0] = TEMP_LIMIT_FROM_REG(data->inttemp_min);
			results[1] = TEMP_LIMIT_FROM_REG(data->inttemp_max);
			results[2] = TEMP_FROM_REG(data->inttemp);
			break;
		case LM85_SYSCTL_REMOTE_TEMP:
			results[0] = TEMP_LIMIT_FROM_REG(data->remtemp_min);
			results[1] = TEMP_LIMIT_FROM_REG(data->remtemp_max);
			results[2] = TEMP_FROM_REG(data->remtemp);
			break;
		}
		*nrels_mag = 3;
	}
}

void lm85_fan(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct lm85_data *data = client->data;

	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		lm85_update_client(client);
		switch(ctl_name) {
		case LM85_SYSCTL_FAN1:
			results[0] = (data->fan1_min=0?0:5400000/data->fan1_min);
			results[1] = (data->fan1=0?0:5400000/data->fan1);
			break;
		case LM85_SYSCTL_FAN2:
			results[0] = (data->fan2_min=0?0:5400000/data->fan2_min);
			results[1] = (data->fan2=0?0:5400000/data->fan2);
			break;
		case LM85_SYSCTL_FAN3:
			results[0] = (data->fan3_min=0?0:5400000/data->fan3_min);
			results[1] = (data->fan3=0?0:5400000/data->fan3);
			break;
		case LM85_SYSCTL_FAN4:
			results[0] = (data->fan4_min=0?0:5400000/data->fan4_min);
			results[1] = (data->fan4=0?0:5400000/data->fan4);
			break;
		}
		*nrels_mag = 2;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
/* MSW NO WRITE
		if (*nrels_mag >= 0) {
			if (ctl_name = LM85_SYSCTL_FAN1) {
			 data->fan_min = FAN_TO_REG(results[0],
						   DIV_FROM_REG
						   (data->fan_div));
			 lm85_write_value(client, LM85_REG_FAN1_AIN1_LIMIT,
					    data->fan_min);
			} else {
			 data->fan2_min = FAN_TO_REG(results[0],
						   DIV_FROM_REG
						   (data->fan2_div));
			 lm85_write_value(client, LM85_REG_FAN2_AIN2_LIMIT,
					    data->fan2_min);
			}
		}
*/
	}
}


void lm85_alarms(struct i2c_client *client, int operation, int ctl_name,
		    int *nrels_mag, long *results)
{
	struct lm85_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		lm85_update_client(client);
		results[0] = ALARMS_FROM_REG(data->alarms);
		*nrels_mag = 1;
	}
}

void lm85_vid4(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct lm85_data *data = client->data;

	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 3;
	else if (operation = SENSORS_PROC_REAL_READ) {
		lm85_update_client(client);
		results[0] = 1850 - (data->vid4 * 25);
		*nrels_mag = 1;
	}
}

int __init sensors_lm85_init(void)
{
	int res;

	printk("lm85.o version %s (%s)\n", LM_VERSION, LM_DATE);
	lm85_initialized = 0;

	if ((res = i2c_add_driver(&LM85_driver))) {
		printk
		    ("lm85.o: Driver registration failed, module not inserted.\n");
		lm85_cleanup();
		return res;
	}
	lm85_initialized++;
	return 0;
}

int __init lm85_cleanup(void)
{
	int res;

	if (lm85_initialized >= 1) {
		if ((res = i2c_del_driver(&LM85_driver))) {
			printk
			    ("lm85.o: Driver deregistration failed, module not removed.\n");
			return res;
		}
		lm85_initialized--;
	}
	return 0;
}

EXPORT_NO_SYMBOLS;

#ifdef MODULE
#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

MODULE_AUTHOR
    ("Margit Schubert-While <margitsw@t-online.de>");

MODULE_DESCRIPTION("LM85 driver");

int init_module(void)
{
	return sensors_lm85_init();
}

int cleanup_module(void)
{
	return lm85_cleanup();
}

#endif				/* MODULE */
