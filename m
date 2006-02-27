From: linux@rick.claranet.de (Hartmut Rick)
Date: Mon, 27 Feb 2006 01:07:34 +0000
Subject: [lm-sensors] Hardware monitoring support for SMSC 47M192/47M997
Message-Id: <Pine.LNX.4.63.0602270128360.3209@Laila>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

  I've seen a few inquiries about temperature and voltage
sensor support for the SMSC Super-I/O chips for 2.6 kernels,
but there was no clear statement about who is actually working
on that.

While waiting for support, I tried to set up a driver myself,
and finally managed to produce the attached file 'smsc47m192.c'.

Linking this into the 2.6.15.1 kernel gives me access to
voltages and temperature readings in /sys/bus/i2c/devices/0-002d

I have a Gigabyte K8U motherboard with SMSC 47M997 chip and would
be interested to hear whether this works anywhere else.

The chip supports 8 voltage input channels:
         in0     +2.5V
         in1     VCCP (CPU supply voltage)
         in2     +3.3V
         in3     +5V
         in4     +12V
         in5     HVCC (supply voltage of the LPC47Mxxx chip)
         in6     +1.5V
         in7     +1.8V

and 3 temperatures:
         temp1   remote diode sensor (probably on the CPU)
         temp2   local sensor (inside the 47Mxxx chip)
         temp3   second remote diode sensor (corresponds to
 			'System temperature' on the K8U mainboard)

There are also 2 registers which I called 'temp1_offset' and 
'temp3_offset'. They can be written with an offset which the chip 
adds to the temperature readings temp1_input and temp3_input.
Not particularly useful as such, since adding an offset can easily
be done in software, but I found that it can be used in order to 
identify which temperature readings correspond to CPU and System 
temperatures as shown by the BIOS. When soft-booting into the
BIOS setup, the offsets are still active and I can see
which temperature is different from what it was before.


Best regards,
Hartmut
-------------- next part --------------
/*
    smsc47m192.c - Not yet Part of lm_sensors, Linux kernel modules for hardware
             monitoring

    Copyright (c) 2006  Hartmut Rick <rick at claranet.de> 

	derived from lm78.c and other chip drivers of the lm_sensors package

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
    This driver supports the hardware monitoring block of the
    SMSC LPC47M192 and LPC47M997 Super I/O chips.
*/

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/i2c.h>
#include <linux/hwmon.h>
#include <linux/hwmon-vid.h>
#include <linux/err.h>
#include <asm/io.h>

/* Addresses to scan */
static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };

/* Insmod parameters */
I2C_CLIENT_INSMOD_1(smsc47m192);

/* SMSC47M192 registers */
#define SMSC47M192_REG_IN_MAX(nr) (0x2b + (nr) * 2 + ((nr)>5 ? 0x1d : 0))
#define SMSC47M192_REG_IN_MIN(nr) (0x2c + (nr) * 2 + ((nr)>5 ? 0x1d : 0))
#define SMSC47M192_REG_IN(nr) (0x20 + (nr) + ((nr)>5 ? 0x2a : 0))

#define SMSC47M192_REG_TEMP(nr) (0x25 + (nr) + ((nr)>2 ? 0x2a : 0))
#define SMSC47M192_REG_TEMP_MAX(nr) (0x35 + (nr) * 2 + ((nr)>2 ? 0x1d : 0))
#define SMSC47M192_REG_TEMP_MIN(nr) (0x36 + (nr) * 2 + ((nr)>2 ? 0x1d : 0))
#define SMSC47M192_REG_TEMP_OFFSET(nr) (0x20 - (nr))

#define SMSC47M192_REG_ALARM1 0x41
#define SMSC47M192_REG_ALARM2 0x42

#define SMSC47M192_REG_VID 0x47
#define SMSC47M192_REG_VID4 0x49

#define SMSC47M192_REG_CONFIG 0x40
#define SMSC47M192_REG_COMPANY_ID 0x3e
#define SMSC47M192_REG_VERSION 0x3f

/* generalised scaling with integer rounding */
static inline int SCALE(long val, int mul, int div)
{
        if (val < 0)
                return (val * mul - div / 2) / div;
        else
                return (val * mul + div / 2) / div;
}

/* Conversions */

/* smsc47m192 internally scales voltage measurements */
static const u16 nom_mv[] = { 2500, 2250, 3300, 5000, 12000, 3300, 1500, 1800 };

static inline unsigned int IN_FROM_REG(u8 reg, int n)
{
        return SCALE(reg, nom_mv[n], 192);
}

static inline u8 IN_TO_REG(unsigned long val, int n)
{
        return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
}

/* TEMP: mC (-128C to +127C)
   REG: 1C/bit, two's complement */
static inline s8 TEMP_TO_REG(int val)
{
	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
	return nval<0 ? (nval-500)/1000 : (nval+500)/1000;
}

static inline int TEMP_FROM_REG(s8 val)
{
	return val * 1000;
}

/* For each registered SMSC47M192, we need to keep some data in memory. That
   data is pointed to by smsc47m192_list[NR]->data. The structure itself is
   dynamically allocated, at the same time when a new smsc47m192 client is
   allocated. */
struct smsc47m192_data {
	struct i2c_client client;
	struct class_device *class_dev;
	struct semaphore update_lock;
	char valid;		/* !=0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */

	u8 in[8];		/* Register value */
	u8 in_max[8];		/* Register value */
	u8 in_min[8];		/* Register value */
	s8 temp[3];		/* Register value */
	s8 temp_max[3];		/* Register value */
	s8 temp_min[3];		/* Register value */
	s8 temp_offset[2];	/* Register value */
	u16 alarms;		/* Register encoding, combined */
	u8 vid;			/* Register encoding, combined */
	u8 vrm;
};

static int smsc47m192_attach_adapter(struct i2c_adapter *adapter);
static int smsc47m192_detect(struct i2c_adapter *adapter,int address,int kind);
static int smsc47m192_detach_client(struct i2c_client *client);

static struct smsc47m192_data *smsc47m192_update_device(struct device *dev);
static void smsc47m192_init_client(struct i2c_client *client);

static struct i2c_driver smsc47m192_driver = {
	.owner		= THIS_MODULE,
	.name		= "smsc47m192",
	.id		= I2C_DRIVERID_SMSC47M192,
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter	= smsc47m192_attach_adapter,
	.detach_client	= smsc47m192_detach_client,
};

/* Voltages */
static ssize_t show_in(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr],nr));
}

static ssize_t show_in_min(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr],nr));
}

static ssize_t show_in_max(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr],nr));
}

static ssize_t set_in_min(struct device *dev, const char *buf,
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	unsigned long val = simple_strtoul(buf, NULL, 10);

	down(&data->update_lock);
	data->in_min[nr] = IN_TO_REG(val,nr);
	i2c_smbus_write_byte_data(client, SMSC47M192_REG_IN_MIN(nr),
							data->in_min[nr]);
	up(&data->update_lock);
	return count;
}

static ssize_t set_in_max(struct device *dev, const char *buf,
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	unsigned long val = simple_strtoul(buf, NULL, 10);

	down(&data->update_lock);
	data->in_max[nr] = IN_TO_REG(val,nr);
	i2c_smbus_write_byte_data(client, SMSC47M192_REG_IN_MAX(nr),
							data->in_max[nr]);
	up(&data->update_lock);
	return count;
}
	
#define show_in_offset(offset)						\
static ssize_t								\
	show_in##offset (struct device *dev,				\
			struct device_attribute *attr, char *buf)	\
{									\
	return show_in(dev, buf, offset);				\
}									\
static DEVICE_ATTR(in##offset##_input, S_IRUGO, 			\
		show_in##offset, NULL);					\
static ssize_t								\
	show_in##offset##_min (struct device *dev,			\
			struct device_attribute *attr, char *buf)	\
{									\
	return show_in_min(dev, buf, offset);				\
}									\
static ssize_t								\
	show_in##offset##_max (struct device *dev,			\
			struct device_attribute *attr, char *buf)	\
{									\
	return show_in_max(dev, buf, offset);				\
}									\
static ssize_t set_in##offset##_min (struct device *dev,		\
				struct device_attribute *attr,		\
				const char *buf, size_t count)		\
{									\
	return set_in_min(dev, buf, count, offset);			\
}									\
static ssize_t set_in##offset##_max (struct device *dev,		\
				struct device_attribute *attr,		\
				const char *buf, size_t count)		\
{									\
	return set_in_max(dev, buf, count, offset);			\
}									\
static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,			\
		show_in##offset##_min, set_in##offset##_min);		\
static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,			\
		show_in##offset##_max, set_in##offset##_max);

show_in_offset(0);
show_in_offset(1);
show_in_offset(2);
show_in_offset(3);
show_in_offset(4);
show_in_offset(5);
show_in_offset(6);
show_in_offset(7);

/* Temperatures */
static ssize_t show_temp(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr-1]));
}

static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr-1]));
}

static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr-1]));
}

static ssize_t set_temp_min(struct device *dev, const char *buf,
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	long val = simple_strtol(buf, NULL, 10);

	down(&data->update_lock);
	data->temp_min[nr-1] = TEMP_TO_REG(val);
	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MIN(nr),
						data->temp_min[nr-1]);
	up(&data->update_lock);
	return count;
}

static ssize_t set_temp_max(struct device *dev, const char *buf,
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	long val = simple_strtol(buf, NULL, 10);

	down(&data->update_lock);
	data->temp_max[nr-1] = TEMP_TO_REG(val);
	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MAX(nr),
						data->temp_max[nr-1]);
	up(&data->update_lock);
	return count;
}

static ssize_t show_temp_offset(struct device *dev, char *buf, int nr)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_offset[nr>>1]));
}

static ssize_t set_temp_offset(struct device *dev, const char *buf,
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	long val = simple_strtol(buf, NULL, 10);

	down(&data->update_lock);
	data->temp_offset[nr>>1] = TEMP_TO_REG(val);
	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_OFFSET(1+(nr>>1)),
						data->temp_offset[nr>>1]);
	up(&data->update_lock);
	return count;
}

#define show_temp_index(index)					\
static ssize_t							\
	show_temp##index (struct device *dev,			\
		struct device_attribute *attr, char *buf)	\
{								\
	return show_temp(dev, buf, index);			\
}								\
static DEVICE_ATTR(temp##index##_input, S_IRUGO, 		\
			show_temp##index, NULL);		\
static ssize_t							\
	show_temp##index##_min (struct device *dev,		\
		struct device_attribute *attr, char *buf)	\
{								\
	return show_temp_min(dev, buf, index);			\
}								\
static ssize_t							\
	show_temp##index##_max (struct device *dev,		\
		struct device_attribute *attr, char *buf)	\
{								\
	return show_temp_max(dev, buf, index);			\
}								\
static ssize_t set_temp##index##_min (struct device *dev,	\
			struct device_attribute *attr,		\
			const char *buf, size_t count)		\
{								\
	return set_temp_min(dev, buf, count, index);		\
}								\
static ssize_t set_temp##index##_max (struct device *dev,	\
			struct device_attribute *attr,		\
			const char *buf, size_t count)		\
{								\
	return set_temp_max(dev, buf, count, index);		\
}								\
static DEVICE_ATTR(temp##index##_min, S_IRUGO | S_IWUSR,	\
		show_temp##index##_min, set_temp##index##_min);	\
static DEVICE_ATTR(temp##index##_max, S_IRUGO | S_IWUSR,	\
		show_temp##index##_max, set_temp##index##_max);

show_temp_index(1);
show_temp_index(2);
show_temp_index(3);

#define show_temp_offset_index(index)				\
static ssize_t							\
	show_temp##index##_offset (struct device *dev,		\
		struct device_attribute *attr, char *buf)	\
{								\
	return show_temp_offset(dev, buf, index);		\
}								\
static ssize_t set_temp##index##_offset (struct device *dev,	\
			struct device_attribute *attr,		\
			const char *buf, size_t count)		\
{								\
	return set_temp_offset(dev, buf, count, index);		\
}								\
static DEVICE_ATTR(temp##index##_offset, S_IRUGO | S_IWUSR,	\
		show_temp##index##_offset, set_temp##index##_offset);

show_temp_offset_index(1);
show_temp_offset_index(3);

/* VID */
static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
								char *buf)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
}
static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);

static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
								char *buf)
{
        struct smsc47m192_data *data = smsc47m192_update_device(dev);
        return sprintf(buf, "%d\n", data->vrm);
}

static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
        struct i2c_client *client = to_i2c_client(dev);
        struct smsc47m192_data *data = i2c_get_clientdata(client);
        data->vrm = simple_strtoul(buf, NULL, 10);
        return count;
}
static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);

/* Alarms */
static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
								char *buf)
{
	struct smsc47m192_data *data = smsc47m192_update_device(dev);
	return sprintf(buf, "%u\n", data->alarms);
}
static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

/* This function is called when:
    * smsc47m192_driver is inserted (when this module is loaded), for each
      available adapter
    * when a new adapter is inserted (and smsc47m192_driver is still present) */
static int smsc47m192_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter->class & I2C_CLASS_HWMON))
		return 0;
	return i2c_probe(adapter, &addr_data, smsc47m192_detect);
}

/* This function is called by i2c_probe */
static int smsc47m192_detect(struct i2c_adapter *adapter, int address, int kind)
{
	struct i2c_client *new_client;
	struct smsc47m192_data *data;
	int err=0;
	int version;

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		goto ERROR0;

	if (!(data = kzalloc(sizeof(struct smsc47m192_data), GFP_KERNEL))) {
		err = -ENOMEM;
		goto ERROR0;
	}

	new_client = &data->client;
	i2c_set_clientdata(new_client, data);
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &smsc47m192_driver;
	new_client->flags = 0;

        if (kind = 0)
                kind = smsc47m192;

	/* Detection criteria from sensors_detect script */
	if (kind < 0) {
		if (	i2c_smbus_read_byte_data(new_client,
					SMSC47M192_REG_COMPANY_ID) = 0x55
			&& ((version=i2c_smbus_read_byte_data(new_client,
					SMSC47M192_REG_VERSION)) & 0xf0) = 0x20
			&& (i2c_smbus_read_byte_data(new_client,
					SMSC47M192_REG_VID) & 0x70) = 0x00
			&& (i2c_smbus_read_byte_data(new_client,
					SMSC47M192_REG_VID4) & 0xfe) = 0x80
		) {
			dev_info(&adapter->dev,"found SMSC47M192 or SMSC47M997,"
				" version 2, stepping A%d\n",version&0x0f);
		} else {
			dev_dbg(&adapter->dev,
				"SMSC47M192 detection failed at 0x%02x.\n",
								address);
			goto ERROR2;
		}
	}

	/* Fill in the remaining client fields and put into the global list */
	strlcpy(new_client->name, "smsc47m192", I2C_NAME_SIZE);
	data->valid = 0;
	data->vrm = 90;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto ERROR2;

	/* Initialize the SMSC47M192 chip */
	smsc47m192_init_client(new_client);

	/* Register sysfs hooks */
	data->class_dev = hwmon_device_register(&new_client->dev);
	if (IS_ERR(data->class_dev)) {
		err = PTR_ERR(data->class_dev);
		goto ERROR3;
	}

	device_create_file(&new_client->dev, &dev_attr_in0_input);
	device_create_file(&new_client->dev, &dev_attr_in0_min);
	device_create_file(&new_client->dev, &dev_attr_in0_max);
	device_create_file(&new_client->dev, &dev_attr_in1_input);
	device_create_file(&new_client->dev, &dev_attr_in1_min);
	device_create_file(&new_client->dev, &dev_attr_in1_max);
	device_create_file(&new_client->dev, &dev_attr_in2_input);
	device_create_file(&new_client->dev, &dev_attr_in2_min);
	device_create_file(&new_client->dev, &dev_attr_in2_max);
	device_create_file(&new_client->dev, &dev_attr_in3_input);
	device_create_file(&new_client->dev, &dev_attr_in3_min);
	device_create_file(&new_client->dev, &dev_attr_in3_max);
	device_create_file(&new_client->dev, &dev_attr_in4_input);
	device_create_file(&new_client->dev, &dev_attr_in4_min);
	device_create_file(&new_client->dev, &dev_attr_in4_max);
	device_create_file(&new_client->dev, &dev_attr_in5_input);
	device_create_file(&new_client->dev, &dev_attr_in5_min);
	device_create_file(&new_client->dev, &dev_attr_in5_max);
	device_create_file(&new_client->dev, &dev_attr_in6_input);
	device_create_file(&new_client->dev, &dev_attr_in6_min);
	device_create_file(&new_client->dev, &dev_attr_in6_max);
	device_create_file(&new_client->dev, &dev_attr_in7_input);
	device_create_file(&new_client->dev, &dev_attr_in7_min);
	device_create_file(&new_client->dev, &dev_attr_in7_max);
	device_create_file(&new_client->dev, &dev_attr_temp1_input);
	device_create_file(&new_client->dev, &dev_attr_temp1_max);
	device_create_file(&new_client->dev, &dev_attr_temp1_min);
	device_create_file(&new_client->dev, &dev_attr_temp1_offset);
	device_create_file(&new_client->dev, &dev_attr_temp2_input);
	device_create_file(&new_client->dev, &dev_attr_temp2_max);
	device_create_file(&new_client->dev, &dev_attr_temp2_min);
	device_create_file(&new_client->dev, &dev_attr_temp3_input);
	device_create_file(&new_client->dev, &dev_attr_temp3_max);
	device_create_file(&new_client->dev, &dev_attr_temp3_min);
	device_create_file(&new_client->dev, &dev_attr_temp3_offset);
	device_create_file(&new_client->dev, &dev_attr_alarms);
	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
	device_create_file(&new_client->dev, &dev_attr_vrm);

	return 0;

ERROR3:
	i2c_detach_client(new_client);
ERROR2:
	kfree(data);
ERROR0:
	return err;
}

static int smsc47m192_detach_client(struct i2c_client *client)
{
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	int err;

	hwmon_device_unregister(data->class_dev);

	if ((err = i2c_detach_client(client)))
		return err;

	kfree(data);

	return 0;
}

static void smsc47m192_init_client(struct i2c_client *client)
{
	u8 config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);

	/* Start monitoring */
	if (!(config & 0x01))
		i2c_smbus_write_byte_data(client, SMSC47M192_REG_CONFIG,
				 (config & 0xf7) | 0x01);
}

static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct smsc47m192_data *data = i2c_get_clientdata(client);
	int i, config;

	down(&data->update_lock);

	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
	    || !data->valid) {

		dev_dbg(&client->dev, "Starting smsc47m192 update\n");

		for (i = 0; i <= 7; i++) {
			data->in[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_IN(i));
			data->in_min[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_IN_MIN(i));
			data->in_max[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_IN_MAX(i));
		}
		for (i = 0; i < 3; i++) {
			data->temp[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_TEMP(i+1));
			data->temp_max[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_TEMP_MAX(i+1));
			data->temp_min[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_TEMP_MIN(i+1));
		}
		for (i = 0; i < 2; i++)
			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_TEMP_OFFSET(i+1));

		data->vid = i2c_smbus_read_byte_data(client, SMSC47M192_REG_VID)
									& 0x0f;
		config = i2c_smbus_read_byte_data(client,SMSC47M192_REG_CONFIG);
		if (config & 0x20)
			data->vid |= (i2c_smbus_read_byte_data(client,
					SMSC47M192_REG_VID4) & 0x01) << 4;
		data->alarms = i2c_smbus_read_byte_data(client,
							SMSC47M192_REG_ALARM1)
				+ (i2c_smbus_read_byte_data(client,
						SMSC47M192_REG_ALARM2) << 8);
		data->last_updated = jiffies;
		data->valid = 1;
	}

	up(&data->update_lock);

	return data;
}

static int __init sm_smsc47m192_init(void)
{
	int res;

	res = i2c_add_driver(&smsc47m192_driver);
	if (res)
		return res;

	return 0;
}

static void __exit sm_smsc47m192_exit(void)
{
	i2c_del_driver(&smsc47m192_driver);
}

MODULE_AUTHOR("Hartmut Rick <linux at rick.claranet.de>");
MODULE_DESCRIPTION("SMSC47M192 driver");
MODULE_LICENSE("GPL");

module_init(sm_smsc47m192_init);
module_exit(sm_smsc47m192_exit);
