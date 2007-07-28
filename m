From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 28 Jul 2007 18:54:30 +0000
Subject: [lm-sensors] FSC Scylla (and Poseidon,
Message-Id: <46AB90E6.4000801@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050809070706070404070708"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809070706070404070708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

As some of you know I've been working on a unified driver for the Fujitsu 
Siemens hwmon chip family. Attached is the resulting driver. I would be much 
obliged if some of you could test this.

To test drop the attached fscscy.c and Makefile in a dir, type make and then 
insmod fscscy.ko

The easiest way to then read the settings is by using the 3.0 sensors branch, 
which comes with dyn chipsupport:
remove your current lm-sensors userspace package (for example on Fedora do rpm 
-e lm_sensors --nodeps)
svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
cd lm-sensors-3.0.0
make
sudo make install
sudo ldconfig

lm_sensors-2.x will not work, and probably do funky things as it expects the 
old very different 2.4 fscscy driver, so resuing the fscscy name wasn't a good 
idea after all, suggestions welcome.

Note 1: I have not been able to test this driver myself as I currently do not 
have access to the fscher equiped machine I was using, I will get access to 
that again in a few weeks, but for now I just hope this works.

Note 2: I will be away on vacation for 6 days starting coming monday, so I will 
be reading my mail tomorrow (Sunday) and maybe monday morning and then things 
will go quiet for 6 days.

Thanks for testing & Regards,

Hans

--------------050809070706070404070708
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

obj-m += fscscy.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

--------------050809070706070404070708
Content-Type: text/x-csrc;
 name="fscscy.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="fscscy.c"

/*
 * fscscy.c - Part of lm_sensors, Linux kernel modules for hardware
 * monitoring
 * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
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

/* 
 *  New merged Fujitsu Siemens hwmon driver, supporting the Scylla, Poseidon,
 *  Hermes and Heimdall chips
 *
 *  Based on the original 2.4 fscscy, 2.6 fscpos, 2.6 fscher and 2.6
 *  (candidate) fschmd drivers:
 *  Copyright (C) 2006 Thilo Cestonaro <thilo.cestonaro.external@fujitsu-siemens.com>
 *  Copyright (C) 2003, 2004 Reinhard Nissl <rnissl@gmx.de>
 *  Copyright (C) 2000 Hermann Jung <hej@odn.de>
 *  Copyright (C) 1998, 1999 Frodo Looijaard <frodol@dds.nl>
 *  and Philip Edelbrock <phil@netroedge.com>
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/i2c.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>
#include <linux/sysfs.h>

/* Addresses to scan */
static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };

/* Insmod parameters */
I2C_CLIENT_INSMOD_4(fscscy, fscpos, fscher, fschmd);

/*
 * The FSCSCY registers and other defines
 */

/* chip identification */
#define FSCSCY_REG_IDENT_0		0x00
#define FSCSCY_REG_IDENT_1		0x01
#define FSCSCY_REG_IDENT_2		0x02
#define FSCSCY_REG_REVISION		0x03

/* global control and status */
#define FSCSCY_REG_EVENT_STATE		0x04
#define FSCSCY_REG_CONTROL		0x05

/* watchdog (support to be implemented) */
#define FSCSCY_REG_WDOG_PRESET		0x28
#define FSCSCY_REG_WDOG_STATE		0x23
#define FSCSCY_REG_WDOG_CONTROL		0x21

/* voltage supervision */
#define FSCSCY_REG_VOLT_12		0x45
#define FSCSCY_REG_VOLT_5		0x42
#define FSCSCY_REG_VOLT_BATT		0x48

/* minimum pwm at which the fan is driven (pwm can by increased depending on
   the temp. Notice that for the scy some fans share there minimum speed.
   Also notice that with the scy the sensor order is different then with the
   other chips, this order was in the 2.4 driver and kept for consistency. */
static const u8 FSCSCY_REG_FAN_MIN[4][6] = {
	{ 0x65, 0x65, 0x55, 0xa5, 0x55, 0xa5 },		/* scy */
	{ 0x55, 0x65 },					/* pos */
	{ 0x55, 0x65, 0xb5 },				/* her */
	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 } };		/* hmd */

/* actual fan speed */	
static const u8 FSCSCY_REG_FAN_ACT[4][6] = {
	{ 0x6b, 0x6c, 0x0e, 0xab, 0x5c, 0xbb },		/* scy */
	{ 0x0e, 0x6b, 0xab },				/* pos */
	{ 0x0e, 0x6b, 0xbb },				/* her */
	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb } };		/* hmd */

/* fan status registers */
static const u8 FSCSCY_REG_FAN_STATE[4][6] = {
	{ 0x62, 0x61, 0x0d, 0xa2, 0x52, 0xb2 },		/* scy */
	{ 0x0d, 0x62, 0xa2 },				/* pos */
	{ 0x0d, 0x62, 0xb2 },				/* her */
	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 } };		/* hmd */
	
/* fan ripple / divider registers */	
static const u8 FSCSCY_REG_FAN_RIPPLE[4][6] = {
	{ 0x6f, 0x6f, 0x0f, 0xaf, 0x0f, 0xbf },		/* scy */
	{ 0x0f, 0x6f, 0xaf },				/* pos */
	{ 0x0f, 0x6f, 0xbf },				/* her */
	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf } };		/* hmd */

static const int FSCSCY_NO_FAN_SENSORS[4] = { 6, 3, 3, 5 };


/* actual temperature registers */
static const u8 FSCSCY_REG_TEMP_ACT[4][5] = {
	{ 0x64, 0xD0, 0x32, 0x35 },			/* scy */
	{ 0x64, 0x32, 0x35 },				/* pos */
	{ 0x64, 0x32, 0x35 },				/* her */
	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 } };		/* hmd */

/* temperature state registers */
static const u8 FSCSCY_REG_TEMP_STATE[4][5] = {
	{ 0x71, 0xd1, 0x81, 0x91 },			/* scy */
	{ 0x71, 0x81, 0x91 },				/* pos */
	{ 0x71, 0x81, 0x91 },				/* her */
	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 } };		/*������hmd */

/* temperature high limit registers, FSC does not document these. Proven to be
   there with field testing on the fscher, already supported / used in the
   fscscy 2.4 driver. FSC has confirmed that the fschmd has registers at these
   addresses, but doesn't want to confirm they are the same as with the fscher?
   For the fscpos these still needs to be tested / confirmed. */
static const u8 FSCSCY_REG_TEMP_LIMIT[4][5] = {
	{ 0x76, 0xd6, 0x86, 0x96 },			/* scy */
	{ 0x76, 0x86, 0x96 },				/* pos */
	{ 0x76, 0x86, 0x96 },				/* her */
	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 } };		/*������hmd */	

/* These were found through experimenting with an fscher, currently they are
   not used, but we keep them around for future reference.
static const u8 FSCHER_REG_TEMP_AUTOP1[] =	{ 0x73, 0x83, 0x93 };
static const u8 FSCHER_REG_TEMP_AUTOP2[] =	{ 0x75, 0x85, 0x95 }; */

static const int FSCSCY_NO_TEMP_SENSORS[4] = { 4, 3, 3, 5 }; 

#define FSCSCY_NAME "fscscy"

/*
 * Functions declarations
 */

static int fscscy_attach_adapter(struct i2c_adapter *adapter);
static int fscscy_detach_client(struct i2c_client *client);
static struct fscscy_data *fscscy_update_device(struct device *dev);

/*
 * Driver data (common to all clients)
 */

static struct i2c_driver fscscy_driver = {
	.driver = {
		.name	= FSCSCY_NAME,
	},
	.attach_adapter	= fscscy_attach_adapter,
	.detach_client	= fscscy_detach_client,
};

/*
 * Client data (each client gets its own)
 */

struct fscscy_data {
	enum chips kind;
	struct i2c_client client;
	struct class_device *class_dev;
	struct mutex update_lock;
	char valid; /* zero until following fields are valid */
	unsigned long last_updated; /* in jiffies */

	/* register values */
	u8 global_control;	/* global control register */
	u8 volt[3];		/* 12, 5, battery voltage */ 
	u8 temp_act[5];		/* temperature */
	u8 temp_status[5];	/* status of sensor */
	u8 temp_max[6];		/* high temp limit, notice: undocumented! */
	u8 fan_act[6];		/* fans revolutions per second */
	u8 fan_status[6];	/* fan status */
	u8 fan_min[6];		/* fan min value for rps */
	u8 fan_ripple[6];	/* divider for rps */
};

/*
 * Sysfs attr show / store functions
 */

static ssize_t show_in_value(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	const int max_reading[3] = { 14200, 6600, 3300 };
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	return sprintf(buf, "%d\n", (data->volt[attr->index] *
		max_reading[attr->index]) / 255);
}


#define TEMP_FROM_REG(val)	(((val) - 128) * 1000)

static ssize_t show_temp_value(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	return sprintf(buf, "%d\n",
		TEMP_FROM_REG(data->temp_act[attr->index]));
}

static ssize_t show_temp_max(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	return sprintf(buf, "%d\n", TEMP_FROM_REG(
		data->temp_max[attr->index]));
}

static ssize_t store_temp_max(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtoul(buf, NULL, 10) / 1000;

	SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client,
		FSCSCY_REG_TEMP_LIMIT[data->kind][attr->index], v);
	data->temp_max[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_temp_fault(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	/* bit 0 set means sensor working ok, so no fault! */
	if (data->temp_status[attr->index] & 0x01)
		return sprintf(buf, "0\n");
	else
		return sprintf(buf, "1\n");
}

static ssize_t show_temp_alarm(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	/* only signal an alarm if the sensor is working and alert == 1 */
	if ((data->temp_status[attr->index] & 0x03) == 0x03)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}


#define RPM_FROM_REG(val)	(val*60)

static ssize_t show_fan_value(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	return sprintf(buf, "%u\n", RPM_FROM_REG(data->fan_act[attr->index]));
}

static ssize_t show_fan_div(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	/* bits 2..7 reserved => mask with 3 */  
	return sprintf(buf, "%d\n", 1 << (data->fan_ripple[attr->index] & 3));
}

static ssize_t store_fan_div(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);
	/* supported values: 2, 4, 8 */
	unsigned long v = simple_strtoul(buf, NULL, 10);

	switch (v) {
		case 2: v = 1; break;
		case 4: v = 2; break;
		case 8: v = 3; break;
		default:
			dev_err(&data->client.dev, "fan_div value %lu not "
				 "supported. Choose one of 2, 4 or 8!\n", v);
			return -EINVAL;
	}

	mutex_lock(&data->update_lock);

	/* bits 2..7 reserved => mask with 0x03 */
	data->fan_ripple[attr->index] &= ~0x03;
	data->fan_ripple[attr->index] |= v;

	i2c_smbus_write_byte_data(&data->client,
		FSCSCY_REG_FAN_RIPPLE[data->kind][attr->index],
		data->fan_ripple[attr->index]);

	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_fan_alarm(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = fscscy_update_device(dev);

	if (data->fan_status[attr->index] & 0x04)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}


static ssize_t show_pwm_auto_point1_pwm(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int val = fscscy_update_device(dev)->fan_min[attr->index];

	/* 0 = allow turning off, 1-255 = 50-100% */
	if (val)
		val = val / 2 + 128;
	
	return sprintf(buf, "%d\n", val);
}

static ssize_t store_pwm_auto_point1_pwm(struct device *dev,
	struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fscscy_data *data = i2c_get_clientdata(to_i2c_client(dev));
	unsigned long v = simple_strtoul(buf, NULL, 10);
	
	/* register: 0 = allow turning off, 1-255 = 50-100% */
	if (v) {
		SENSORS_LIMIT(v, 128, 255);
		v = (v - 128) * 2 + 1;
	}

	mutex_lock(&data->update_lock);

	i2c_smbus_write_byte_data(&data->client,
		FSCSCY_REG_FAN_MIN[data->kind][attr->index], v);
	data->fan_min[attr->index] = v;

	mutex_unlock(&data->update_lock);
	
	return count;
}


/* The FSC hwmon family has the ability to force an attached alert led to flash
   from software, we export this as an alert_led sysfs attr */
static ssize_t show_alert_led(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct fscscy_data *data = fscscy_update_device(dev);

	if (data->global_control & 0x01)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}

static ssize_t store_alert_led(struct device *dev,
	struct device_attribute *devattr, const char *buf, size_t count)
{
	struct fscscy_data *data = fscscy_update_device(dev);
	unsigned long v = simple_strtoul(buf, NULL, 10);

	mutex_lock(&data->update_lock);
	
	if (v)
		data->global_control |= 0x01;
	else
		data->global_control &= ~0x01;

	i2c_smbus_write_byte_data(&data->client, FSCSCY_REG_CONTROL, v);
	mutex_unlock(&data->update_lock);

	return count;
}

static struct sensor_device_attribute fscscy_attr[] = {
	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
	SENSOR_ATTR(in1_input, 0444, show_in_value, NULL, 1),
	SENSOR_ATTR(in2_input, 0444, show_in_value, NULL, 2),
	SENSOR_ATTR(alert_led, 0644, show_alert_led, store_alert_led, 0),
};

static struct sensor_device_attribute fscscy_temp_attr[] = {
	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
	SENSOR_ATTR(temp1_max,   0644, show_temp_max, store_temp_max, 0),
	SENSOR_ATTR(temp1_fault, 0444, show_temp_fault, NULL, 0),
	SENSOR_ATTR(temp1_alarm, 0444, show_temp_alarm, NULL, 0),
	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
	SENSOR_ATTR(temp2_max,   0644, show_temp_max, store_temp_max, 1),
	SENSOR_ATTR(temp2_fault, 0444, show_temp_fault, NULL, 1),
	SENSOR_ATTR(temp2_alarm, 0444, show_temp_alarm, NULL, 1),
	SENSOR_ATTR(temp3_input, 0444, show_temp_value, NULL, 2),
	SENSOR_ATTR(temp3_max,   0644, show_temp_max, store_temp_max, 2),
	SENSOR_ATTR(temp3_fault, 0444, show_temp_fault, NULL, 2),
	SENSOR_ATTR(temp3_alarm, 0444, show_temp_alarm, NULL, 2),
	SENSOR_ATTR(temp4_input, 0444, show_temp_value, NULL, 3),
	SENSOR_ATTR(temp4_max,   0644, show_temp_max, store_temp_max, 3),
	SENSOR_ATTR(temp4_fault, 0444, show_temp_fault, NULL, 3),
	SENSOR_ATTR(temp4_alarm, 0444, show_temp_alarm, NULL, 3),
	SENSOR_ATTR(temp5_input, 0444, show_temp_value, NULL, 4),
	SENSOR_ATTR(temp5_max,   0644, show_temp_max, store_temp_max, 4),
	SENSOR_ATTR(temp5_fault, 0444, show_temp_fault, NULL, 4),
	SENSOR_ATTR(temp5_alarm, 0444, show_temp_alarm, NULL, 4),
};

static struct sensor_device_attribute fscscy_fan_attr[] = {
	SENSOR_ATTR(fan1_input, 0444, show_fan_value, NULL, 0),
	SENSOR_ATTR(fan1_div,   0644, show_fan_div, store_fan_div, 0),
	SENSOR_ATTR(fan1_alarm, 0444, show_fan_alarm, NULL, 0),
	SENSOR_ATTR(pwm1_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
		store_pwm_auto_point1_pwm, 0),
	SENSOR_ATTR(fan2_input, 0444, show_fan_value, NULL, 1),
	SENSOR_ATTR(fan2_div,   0644, show_fan_div, store_fan_div, 1),
	SENSOR_ATTR(fan2_alarm, 0444, show_fan_alarm, NULL, 1),
	SENSOR_ATTR(pwm2_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
		store_pwm_auto_point1_pwm, 1),
	SENSOR_ATTR(fan3_input, 0444, show_fan_value, NULL, 2),
	SENSOR_ATTR(fan3_div,   0644, show_fan_div, store_fan_div, 2),
	SENSOR_ATTR(fan3_alarm, 0444, show_fan_alarm, NULL, 2),
	SENSOR_ATTR(pwm3_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
		store_pwm_auto_point1_pwm, 2),
	SENSOR_ATTR(fan4_input, 0444, show_fan_value, NULL, 3),
	SENSOR_ATTR(fan4_div,   0644, show_fan_div, store_fan_div, 3),
	SENSOR_ATTR(fan4_alarm, 0444, show_fan_alarm, NULL, 3),
	SENSOR_ATTR(pwm4_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
		store_pwm_auto_point1_pwm, 3),
	SENSOR_ATTR(fan5_input, 0444, show_fan_value, NULL, 4),
	SENSOR_ATTR(fan5_div,   0644, show_fan_div, store_fan_div, 4),
	SENSOR_ATTR(fan5_alarm, 0444, show_fan_alarm, NULL, 4),
	SENSOR_ATTR(pwm5_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
		store_pwm_auto_point1_pwm, 4),
	SENSOR_ATTR(fan6_input, 0444, show_fan_value, NULL, 5),
	SENSOR_ATTR(fan6_div,   0644, show_fan_div, store_fan_div, 5),
	SENSOR_ATTR(fan6_alarm, 0444, show_fan_alarm, NULL, 5),
	SENSOR_ATTR(pwm6_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
		store_pwm_auto_point1_pwm, 5),
};


/*
 * Real code
 */

static int fscscy_detect(struct i2c_adapter *adapter, int address, int kind)
{
	struct i2c_client *new_client;
	struct fscscy_data *data;
	u8 revision;
	const char *names[4] = { "Scylla", "Poseidon", "Hermes", "Heimdall" };
	/* We cannot just use FSCSCY_NO_FAN_SENSORS * 4, because the fscpos
	   doesn't have a FAN_MIN register for its third (last) fan */
	int fan_sysfs_attr = 0, i, err = 0;

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		return 0;

	/* OK. For now, we presume we have a valid client. We now create the
	 * client structure, even though we cannot fill it completely yet.
	 * But it allows us to access i2c_smbus_read_byte_data. */
	if (!(data = kzalloc(sizeof(struct fscscy_data), GFP_KERNEL)))
		return -ENOMEM;

	/* The common I2C client data is placed right before the
	 * Poseidon-specific data. */
	new_client = &data->client;
	i2c_set_clientdata(new_client, data);
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &fscscy_driver;
	new_client->flags = 0;
	strlcpy(new_client->name, FSCSCY_NAME, I2C_NAME_SIZE);
	data->valid = 0;
	mutex_init(&data->update_lock);

	/* Detect & Identify the chip */
	if (kind <= 0) {
		char id[4];
		
		id[0] = i2c_smbus_read_byte_data(new_client,
				FSCSCY_REG_IDENT_0);
		id[1] = i2c_smbus_read_byte_data(new_client,
				FSCSCY_REG_IDENT_1);
		id[2] = i2c_smbus_read_byte_data(new_client,
				FSCSCY_REG_IDENT_2);
		id[3] = 0;
		
		if (!strcmp(id, "SCY")) {
			data->kind = fscscy;
			fan_sysfs_attr = 6 * 4;
		} else if (!strcmp(id, "PEG")) {
			data->kind = fscpos;
			fan_sysfs_attr = 2 * 4 + 3;
		} else if (!strcmp(id, "HER")) {
			data->kind = fscher;
			fan_sysfs_attr = 3 * 4;
		} else if (!strcmp(id, "HMD")) {
			data->kind = fschmd;
			fan_sysfs_attr = 5 * 4;
		} else
			goto exit_free;
	} else
		data->kind = kind;

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto exit_free;
		
	for (i = 0; i < ARRAY_SIZE(fscscy_attr); i++) {
		err = device_create_file(&new_client->dev,
					&fscscy_attr[i].dev_attr);
		if (err)
			goto exit_remove_files;
	}

	for (i = 0; i < (FSCSCY_NO_TEMP_SENSORS[data->kind] * 4); i++) {
		err = device_create_file(&new_client->dev,
					&fscscy_temp_attr[i].dev_attr);
		if (err)
			goto exit_remove_files;
	}

	for (i = 0; i < fan_sysfs_attr; i++) {
		err = device_create_file(&new_client->dev,
					&fscscy_fan_attr[i].dev_attr);
		if (err)
			goto exit_remove_files;
	}

	data->class_dev = hwmon_device_register(&new_client->dev);
	if (IS_ERR(data->class_dev)) {
		err = PTR_ERR(data->class_dev);
		goto exit_remove_files;
	}

	revision = i2c_smbus_read_byte_data(new_client, FSCSCY_REG_REVISION);
	printk(KERN_INFO "fscscy: Detected FSC %s chip, revision: %d\n",
		names[data->kind], (int) revision);

	return 0;

exit_remove_files:
	for (i = 0; i < ARRAY_SIZE(fscscy_attr); i++)
		device_remove_file(&new_client->dev, &fscscy_attr[i].dev_attr);
	for (i = 0; i < (FSCSCY_NO_TEMP_SENSORS[data->kind] * 4); i++)
		device_remove_file(&new_client->dev,
					&fscscy_temp_attr[i].dev_attr);
	for (i = 0; i < fan_sysfs_attr; i++)
		device_remove_file(&new_client->dev,
					&fscscy_fan_attr[i].dev_attr);
	i2c_detach_client(new_client);
exit_free:
	kfree(data);
	return err;
}

static int fscscy_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter->class & I2C_CLASS_HWMON))
		return 0;
	return i2c_probe(adapter, &addr_data, fscscy_detect);
}

static int fscscy_detach_client(struct i2c_client *client)
{
	struct fscscy_data *data = i2c_get_clientdata(client);
	int i, err;

	hwmon_device_unregister(data->class_dev);
	for (i = 0; i < ARRAY_SIZE(fscscy_attr); i++)
		device_remove_file(&client->dev, &fscscy_attr[i].dev_attr);
	for (i = 0; i < (FSCSCY_NO_TEMP_SENSORS[data->kind] * 4); i++)
		device_remove_file(&client->dev,
					&fscscy_temp_attr[i].dev_attr);
	for (i = 0; i < (FSCSCY_NO_FAN_SENSORS[data->kind] * 4); i++)
		device_remove_file(&client->dev,
					&fscscy_fan_attr[i].dev_attr);

	if ((err = i2c_detach_client(client)))
		return err;

	kfree(data);
	return 0;
}

static struct fscscy_data *fscscy_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct fscscy_data *data = i2c_get_clientdata(client);
	int i;

	mutex_lock(&data->update_lock);

	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {

		dev_dbg(&client->dev, "Starting fscscy update\n");
		
		for (i = 0; i < FSCSCY_NO_TEMP_SENSORS[data->kind]; i++) {
			data->temp_act[i] = i2c_smbus_read_byte_data(client,
					FSCSCY_REG_TEMP_ACT[data->kind][i]);
			data->temp_status[i] = i2c_smbus_read_byte_data(client,
					FSCSCY_REG_TEMP_STATE[data->kind][i]);
			data->temp_max[i] = i2c_smbus_read_byte_data(client,
					FSCSCY_REG_TEMP_LIMIT[data->kind][i]);
				
			/* reset alarm if the alarm condition is gone,
			   the chip doesn't do this itself */
			if ((data->temp_status[i] & 0x02) &&
					data->temp_act[i] < data->temp_max[i])
				i2c_smbus_write_byte_data(client,
					FSCSCY_REG_TEMP_STATE[data->kind][i],
					0x02);
		}
					
		for (i = 0; i < FSCSCY_NO_FAN_SENSORS[data->kind]; i++) {
			data->fan_act[i] = i2c_smbus_read_byte_data(client,
					FSCSCY_REG_FAN_ACT[data->kind][i]);
			data->fan_status[i] = i2c_smbus_read_byte_data(client,
					FSCSCY_REG_FAN_STATE[data->kind][i]);
			data->fan_ripple[i] = i2c_smbus_read_byte_data(client,
					FSCSCY_REG_FAN_RIPPLE[data->kind][i]);

			/* The fscpos third doesn't have a fan_min */
			if (FSCSCY_REG_FAN_MIN[data->kind][i])
				data->fan_min[i] = i2c_smbus_read_byte_data(
					client,
					FSCSCY_REG_FAN_MIN[data->kind][i]);

			/* reset fan status if speed is back to > 0 */
			if ((data->fan_status[i] & 0x04) && data->fan_act[i])
				i2c_smbus_write_byte_data(client,
					FSCSCY_REG_FAN_STATE[data->kind][i],
					0x04);
		}

		data->global_control = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_CONTROL);

		data->volt[0] = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_VOLT_12);
		data->volt[1] = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_VOLT_5);
		data->volt[2] = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_VOLT_BATT);

		/* To be implemented in the future
		data->watchdog[0] = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_WDOG_PRESET);
		data->watchdog[1] = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_WDOG_STATE);
		data->watchdog[2] = i2c_smbus_read_byte_data(client,
						FSCSCY_REG_WDOG_CONTROL); */

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);

	return data;
}

static int __init fscscy_init(void)
{
	return i2c_add_driver(&fscscy_driver);
}

static void __exit fscscy_exit(void)
{
	i2c_del_driver(&fscscy_driver);
}

MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
MODULE_DESCRIPTION("FSC Scylla (and Poseidon, Hermes and Heimdall) driver");
MODULE_LICENSE("GPL");

module_init(fscscy_init);
module_exit(fscscy_exit);

--------------050809070706070404070708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050809070706070404070708--
