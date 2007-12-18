From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 18 Dec 2007 10:24:04 +0000
Subject: Re: [lm-sensors] Working on adt7475 driver
Message-Id: <47679FC4.2080301@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010904030208050703030800"
List-Id: <lm-sensors.vger.kernel.org>
References: <4705F127.8010600@hhs.nl>
In-Reply-To: <4705F127.8010600@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010904030208050703030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Juerg Haefliger wrote:
> Hi Hans,
> 
> 
> On Nov 16, 2007 12:29 AM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
>> Juerg Haefliger wrote:
>>> Hi Hans,
>>>
>>> Are your students in fact working on this driver? I ordered some
>>> samples of the ADT7475 & ADT7476 and could slap together a demo board
>>> and start working on a driver.
>>>
>> Yes,
>>
>> They are actually working on this, still a demo bord would be good, as on the
>> motherboard they are using for testing (Asus M2N SLI Deluxe) it is the second
>> hwmon chip, mainly used to monitor and control additional fans.
>>
>> I'll ask them to send what they have sofar my way and I'll send it to you, I'll
>> see them again coming wednesday.
> 
> OK I have a demo board with an ADT7476 ready. Whenever there's a
> driver ready that I can play around with, let me know. I have some
> other things I'm currently working on so no pressure.
> 

I'm afraid that the motherboard used by the student has broken down somehow, so 
they can no longer continue their work. I've attached their latest wip, perhaps 
that can come in handy for you when working on a driver. The motherboard has 
been send in for repair once it returns I can use it for testing your work.

Regards,

Hans

--------------010904030208050703030800
Content-Type: text/x-csrc;
 name="adt7475.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adt7475.c"

/*
 * adt7475.c - Part of lm_sensors, Linux kernel modules for hardware
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
 *  New merged Fujitsu Siemens hwmon driver, supporting the Poseidon, Hermes,
 *  Scylla, Hercules and Heimdall chips
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
static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };

/* Insmod parameters */
I2C_CLIENT_INSMOD_1(adt7475);


/* voltage supervision */
#define ADT7475_REG_IN_HIGH(nr) 	(0x21 + (nr))
#define ADT7475_REG_IN_LOW 		0x76

/* voltage low, high limit registers */
#define ADT7475_REG_IN_LOW_LIMIT(nr) 	(0x46 + 2 * (nr))
#define ADT7475_REG_IN_HIGH_LIMIT(nr) 	(0x47 + 2 * (nr))


/* actual fan speed */	
#define ADT7475_REG_FAN_ACT_LOW(nr) 	(0x28 + 2 * (nr))
#define ADT7475_REG_FAN_ACT_HIGH(nr) 	(0x29 + 2 * (nr))

/* ??? fan status registers */
static const u8 ADT7475_REG_FAN_STATE[1] = {1};
	
/* ??? fan ripple / divider registers */	
static const u8 ADT7475_REG_FAN_RIPPLE[1] = {1};

/* fan low, high limit registers */
#define ADT7475_REG_FAN_LOW_LIMIT(nr) 	(0x54 + 2 * (nr))
#define ADT7475_REG_FAN_HIGH_LIMIT(nr) 	(0x55 + 2 * (nr))

/* fan puls register */
#define ADT7475_REG_FAN_PULS 		0x7B


/* actual temperature registers */
#define ADT7475_REG_TEMP_ACT(nr) 	(0x25 + (nr))
#define ADT7475_REG_TEMP_LOW		0x77

/* temperature offset registers, NOTE only for twocomplement-mode*/
#define ADT7475_REG_TEMP_OFFSET(nr)	(0x70 + (nr))

/* ??? temperature state registers */
#define ADT7475_REG_TEMP_STATE(nr) (0x25 + (nr))

/* temperature low, high limit registers */
#define ADT7475_REG_TEMP_LOW_LIMIT(nr) (0x4E + 2 * (nr))
#define ADT7475_REG_TEMP_HIGH_LIMIT(nr) (0x4F + 2 * (nr))


/* (Interrupt) status registers */
#define ADT7475_REG_INTR_STATUS(nr) (0x41 + (nr))

/* Interrupt mask registers */
#define ADT7475_REG_INTR_MASK(nr) (0x74 + (nr))


/* Configuration Registers */
static const u8 ADT7475_REG_CONFIG[7] = {0x40, 0x73, 0x78, 0x7D, 0x7C, 0x10, 0x11};


/* name */
#define ADT7475_NAME "adt7475"

/*
 * Functions declarations
 */

static int adt7475_attach_adapter(struct i2c_adapter *adapter);
static int adt7475_detach_client(struct i2c_client *client);
static struct adt7475_data *adt7475_update_device(struct device *dev);

/*
 * Driver data (common to all clients)
 */

static struct i2c_driver adt7475_driver = {
	.driver = {
		.name	= ADT7475_NAME,
	},
	.attach_adapter	= adt7475_attach_adapter,
	.detach_client	= adt7475_detach_client,
};

/*
 * Client data (each client gets its own)
 */

struct adt7475_data {
	enum chips kind;
	struct i2c_client client;
	struct class_device *class_dev;
	struct mutex update_lock;
	char valid; /* zero until following fields are valid */
	unsigned long last_updated; /* in jiffies */

	/* register values */
	u8 global_control;	/* ??? global control register */
	u16 in[2];		/* voltage */ 
	u8 in_max[2];		/* high voltage limit */
	u8 in_min[2];		/* low voltage limit */
	u16 temp_act[3];	/* temperature  10 bit */
	u8 temp_status[3];	/* ??? status of sensor */
	u8 config[7];		/* Configuration Register 1-7*/
	u8 temp_max[3];		/* high temp limit */
	u8 temp_min[3];		/* low temp limit */
	u16 fan_act[4];		/* fans revolutions per second */
	u8 fan_status[4];	/* ??? fan status */
	u8 fan_min[4];		/* fan min value for rps */
	u8 fan_max[4];		/* fan max value for rps */
	u8 fan_ripple[4];	/* ??? divider for rps */
	u8 intr_status[2];	/* Interrupt status registers 1+2 */
};

/*
 * Sysfs attr show / store functions
 */

static ssize_t show_in_value(struct device *dev, struct device_attribute *devattr, char *buf)
{
	const int factor[2] = {293, 420};
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", (data->in[attr->index] * factor[attr->index]) / 10);
}

static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
{
	const int factor[2] = {293, 420};
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", (data->in_max[attr->index] * factor[attr->index]) / 10 );
}

static ssize_t store_in_max(struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtol(buf, NULL, 10) / 1000;

	v = SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client, ADT7475_REG_IN_HIGH_LIMIT(attr->index), v);
	data->in_max[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
{
	const int factor[2] = {293, 420};
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", (data->in_min[attr->index] * factor[attr->index]) / 10 );
}

static ssize_t store_in_min(struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtol(buf, NULL, 10) / 1000;

	v = SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client, ADT7475_REG_IN_LOW_LIMIT(attr->index), v);
	data->in_min[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

#define TEMP_FROM_REG_TWOSCOMPLEMENT_8(val)	((((val) & 0x80) ? (((val) & 0x01FF) - 128) : ((val) & 0x01FF)) * 1000)
#define TEMP_FROM_REG_EXTENDED(val)		(((val) - 256) * 250)
#define TEMP_FROM_REG_TWOSCOMPLEMENT_10(val)	((((val) & 0x0200) ? (((val) & 0x01FF) - 512) : ((val) & 0x01FF)) * 250)

static ssize_t show_temp_value(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	if(data->config[4] & 0x01) return sprintf(buf, "%d\n", TEMP_FROM_REG_TWOSCOMPLEMENT_10(data->temp_act[attr->index]));
	else return sprintf(buf, "%d\n", TEMP_FROM_REG_EXTENDED(data->temp_act[attr->index]));
}

static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", TEMP_FROM_REG_TWOSCOMPLEMENT_8( data->temp_max[attr->index]));
}

static ssize_t store_temp_max(struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtol(buf, NULL, 10) / 1000;

	v = SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client, ADT7475_REG_TEMP_HIGH_LIMIT(attr->index), v);
	data->temp_max[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", TEMP_FROM_REG_TWOSCOMPLEMENT_8( data->temp_min[attr->index]));
}

static ssize_t store_temp_min(struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtol(buf, NULL, 10) / 1000;

	v = SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client, ADT7475_REG_TEMP_LOW_LIMIT(attr->index), v);
	data->temp_min[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_temp_fault(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);
	u8 mask = 0x40 << attr->index;

	return sprintf(buf, "%d\n", ((data->intr_status[1] & mask) != 0));
}

/*
static ssize_t show_temp_fault(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fschmd_data *data = fschmd_update_device(dev);

	*//* bit 0 set means sensor working ok, so no fault! *//*
	if (data->temp_status[attr->index] & 0x01)
		return sprintf(buf, "0\n");
	else
		return sprintf(buf, "1\n");
}

static ssize_t show_temp_alarm(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fschmd_data *data = fschmd_update_device(dev);

	*//* only signal an alarm if the sensor is working and alert == 1 *//*
	if ((data->temp_status[attr->index] & 0x03) == 0x03)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}


*/

#define RPM_FROM_REG(val)	(val == 0xFFFF) ? 0 : ((90000*60)/(val))

static ssize_t show_fan_value(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", RPM_FROM_REG(data->fan_act[attr->index]));
}

static ssize_t show_fan_max(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", data->fan_max[attr->index]);
}

static ssize_t store_fan_max(struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtol(buf, NULL, 10) / 1000;

	v = SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client, ADT7475_REG_FAN_HIGH_LIMIT(attr->index), v);
	data->fan_max[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);

	return sprintf(buf, "%d\n", data->fan_min[attr->index]);
}

static ssize_t store_fan_min(struct device *dev, struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = i2c_get_clientdata(to_i2c_client(dev));
	long v = simple_strtol(buf, NULL, 10) / 1000;

	v = SENSORS_LIMIT(v, -128, 127);
	v += 128;

	mutex_lock(&data->update_lock);
	i2c_smbus_write_byte_data(&data->client, ADT7475_REG_FAN_LOW_LIMIT(attr->index), v);
	data->fan_min[attr->index] = v;
	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_fan_fault(struct device *dev, struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct adt7475_data *data = adt7475_update_device(dev);
	u8 mask = 0x02 << attr->index;

	return sprintf(buf, "%d\n", (data->config[1] & mask));
}

/*
static ssize_t show_fan_div(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fschmd_data *data = fschmd_update_device(dev);

	*//* bits 2..7 reserved => mask with 3 *//*  
	return sprintf(buf, "%d\n", 1 << (data->fan_ripple[attr->index] & 3));
}

static ssize_t store_fan_div(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fschmd_data *data = fschmd_update_device(dev);
	*//* supported values: 2, 4, 8 *//*
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

	*//* bits 2..7 reserved => mask with 0x03 *//*
	data->fan_ripple[attr->index] &= ~0x03;
	data->fan_ripple[attr->index] |= v;

	i2c_smbus_write_byte_data(&data->client,
		FSCHMD_REG_FAN_RIPPLE[data->kind][attr->index],
		data->fan_ripple[attr->index]);

	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t show_fan_alarm(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fschmd_data *data = fschmd_update_device(dev);

	if (data->fan_status[attr->index] & 0x04)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}


static ssize_t show_pwm_auto_point1_pwm(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int val = fschmd_update_device(dev)->fan_min[attr->index];

	*//* 0 = allow turning off, 1-255 = 50-100% *//*
	if (val)
		val = val / 2 + 128;
	
	return sprintf(buf, "%d\n", val);
}

static ssize_t store_pwm_auto_point1_pwm(struct device *dev,
	struct device_attribute *devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct fschmd_data *data = i2c_get_clientdata(to_i2c_client(dev));
	unsigned long v = simple_strtoul(buf, NULL, 10);
	
	*//* register: 0 = allow turning off, 1-255 = 50-100% *//*
	if (v) {
		SENSORS_LIMIT(v, 128, 255);
		v = (v - 128) * 2 + 1;
	}

	mutex_lock(&data->update_lock);

	i2c_smbus_write_byte_data(&data->client,
		FSCHMD_REG_FAN_MIN[data->kind][attr->index], v);
	data->fan_min[attr->index] = v;

	mutex_unlock(&data->update_lock);
	
	return count;
}
*/

/* The FSC hwmon family has the ability to force an attached alert led to flash
   from software, we export this as an alert_led sysfs attr */
/*static ssize_t show_alert_led(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct fschmd_data *data = fschmd_update_device(dev);

	if (data->global_control & 0x01)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}

static ssize_t store_alert_led(struct device *dev,
	struct device_attribute *devattr, const char *buf, size_t count)
{
	struct fschmd_data *data = fschmd_update_device(dev);
	unsigned long v = simple_strtoul(buf, NULL, 10);

	mutex_lock(&data->update_lock);
	
	if (v)
		data->global_control |= 0x01;
	else
		data->global_control &= ~0x01;

	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_CONTROL, v);
	mutex_unlock(&data->update_lock);

	return count;
}*/

static struct sensor_device_attribute adt7475_in_attr[] = {
	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
	SENSOR_ATTR(in0_min,   0644, show_in_min, store_in_min, 0),
	SENSOR_ATTR(in0_max,   0644, show_in_max, store_in_max, 0),
	SENSOR_ATTR(in0_fault,   0444, show_in_fault, NULL, 0),
	SENSOR_ATTR(in1_input, 0444, show_in_value, NULL, 1),
	SENSOR_ATTR(in1_min,   0644, show_in_min, store_in_min, 1),
	SENSOR_ATTR(in1_max,   0644, show_in_max, store_in_max, 1),
	SENSOR_ATTR(in1_fault,   0444, show_in_fault, NULL, 1),
	//SENSOR_ATTR(alert_led, 0644, show_alert_led, store_alert_led, 0),
};

static struct sensor_device_attribute adt7475_temp_attr[] = {
	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
	SENSOR_ATTR(temp1_min,   0644, show_temp_min, store_temp_min, 0),
	SENSOR_ATTR(temp1_max,   0644, show_temp_max, store_temp_max, 0),
	//SENSOR_ATTR(temp1_fault, 0444, show_temp_fault, NULL, 0),
	//SENSOR_ATTR(temp1_alarm, 0444, show_temp_alarm, NULL, 0),
	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
	SENSOR_ATTR(temp2_min,   0644, show_temp_min, store_temp_min, 1),
	SENSOR_ATTR(temp2_max,   0644, show_temp_max, store_temp_max, 1),
	//SENSOR_ATTR(temp2_fault, 0444, show_temp_fault, NULL, 1),
	//SENSOR_ATTR(temp2_alarm, 0444, show_temp_alarm, NULL, 1),
	SENSOR_ATTR(temp3_input, 0444, show_temp_value, NULL, 2),
	SENSOR_ATTR(temp3_min,   0644, show_temp_min, store_temp_min, 2),
	SENSOR_ATTR(temp3_max,   0644, show_temp_max, store_temp_max, 2),
	//SENSOR_ATTR(temp3_fault, 0444, show_temp_fault, NULL, 2),
	//SENSOR_ATTR(temp3_alarm, 0444, show_temp_alarm, NULL, 2),
};

static struct sensor_device_attribute adt7475_fan_attr[] = {
	SENSOR_ATTR(fan1_input, 0444, show_fan_value, NULL, 0),
	SENSOR_ATTR(fan1_min,   0644, show_fan_min, store_fan_min, 0),
	SENSOR_ATTR(fan1_max,   0644, show_fan_max, store_fan_max, 0),
	//SENSOR_ATTR(fan1_div,   0644, show_fan_div, store_fan_div, 0),
	//SENSOR_ATTR(fan1_alarm, 0444, show_fan_alarm, NULL, 0),
	//SENSOR_ATTR(pwm1_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm, store_pwm_auto_point1_pwm, 0),
	SENSOR_ATTR(fan2_input, 0444, show_fan_value, NULL, 1),
	SENSOR_ATTR(fan2_min,   0644, show_fan_min, store_fan_min, 1),
	SENSOR_ATTR(fan2_max,   0644, show_fan_max, store_fan_max, 1),
	//SENSOR_ATTR(fan2_div,   0644, show_fan_div, store_fan_div, 1),
	//SENSOR_ATTR(fan2_alarm, 0444, show_fan_alarm, NULL, 1),
	//SENSOR_ATTR(pwm2_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,store_pwm_auto_point1_pwm, 1),
	SENSOR_ATTR(fan3_input, 0444, show_fan_value, NULL, 2),
	SENSOR_ATTR(fan3_min,   0644, show_fan_min, store_fan_min, 2),
	SENSOR_ATTR(fan3_max,   0644, show_fan_max, store_fan_max, 2),
	//SENSOR_ATTR(fan3_div,   0644, show_fan_div, store_fan_div, 2),
	//SENSOR_ATTR(fan3_alarm, 0444, show_fan_alarm, NULL, 2),
	//SENSOR_ATTR(pwm3_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm, store_pwm_auto_point1_pwm, 2),
	SENSOR_ATTR(fan4_input, 0444, show_fan_value, NULL, 3),
	SENSOR_ATTR(fan4_min,   0644, show_fan_min, store_fan_min, 3),
	SENSOR_ATTR(fan4_max,   0644, show_fan_max, store_fan_max, 3),
	//SENSOR_ATTR(fan4_div,   0644, show_fan_div, store_fan_div, 3),
	//SENSOR_ATTR(fan4_alarm, 0444, show_fan_alarm, NULL, 3),
	//SENSOR_ATTR(pwm4_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,store_pwm_auto_point1_pwm, 3),
};


/*
 * Real code
 */

static int adt7475_detect(struct i2c_adapter *adapter, int address, int kind)
{
	struct i2c_client *new_client;
	struct adt7475_data *data;
	u8 revision;
	int i, err = 0;

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		return 0;

	/* OK. For now, we presume we have a valid client. We now create the
	 * client structure, even though we cannot fill it completely yet.
	 * But it allows us to access i2c_smbus_read_byte_data. */
	if (!(data = kzalloc(sizeof(struct adt7475_data), GFP_KERNEL)))
		return -ENOMEM;

	/* The common I2C client data is placed right before the
	 * Poseidon-specific data. */
	new_client = &data->client;
	i2c_set_clientdata(new_client, data);
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &adt7475_driver;
	new_client->flags = 0;
	strlcpy(new_client->name, ADT7475_NAME, I2C_NAME_SIZE);
	data->valid = 0;
	mutex_init(&data->update_lock);

	/* i2c kind goes from 1-4, we want from 0-3 to address arrays */
	data->kind = kind - 1;

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto exit_free;

	/* Add attributes */
	for(i = 0; i < ARRAY_SIZE(adt7475_in_attr); ++i) 
	{
		err = device_create_file(&new_client->dev, &adt7475_in_attr[i].dev_attr);
		if (err) goto exit_remove_files;
	}

	for(i = 0; i < ARRAY_SIZE(adt7475_temp_attr); ++i) 
	{
		err = device_create_file(&new_client->dev, &adt7475_temp_attr[i].dev_attr);
		if (err) goto exit_remove_files;
	}

	for(i = 0; i < ARRAY_SIZE(adt7475_fan_attr); ++i) 
	{
		err = device_create_file(&new_client->dev,&adt7475_fan_attr[i].dev_attr);
		if (err) goto exit_remove_files;
	}

	data->class_dev = hwmon_device_register(&new_client->dev);
	if (IS_ERR(data->class_dev)) {
		err = PTR_ERR(data->class_dev);
		goto exit_remove_files;
	}

	// ??? revision = i2c_smbus_read_byte_data(new_client, ADT7475_REG_REVISION);
	printk(KERN_INFO "adt7475: Detected adt7475 chip\n");

	return 0;

exit_remove_files:
	for(i = 0; i < ARRAY_SIZE(adt7475_in_attr); ++i) device_remove_file(&new_client->dev, &adt7475_in_attr[i].dev_attr);
	for(i = 0; i < ARRAY_SIZE(adt7475_temp_attr); ++i) device_remove_file(&new_client->dev, &adt7475_temp_attr[i].dev_attr);
	for(i = 0; i < ARRAY_SIZE(adt7475_fan_attr); ++i) device_remove_file(&new_client->dev, &adt7475_fan_attr[i].dev_attr);

	i2c_detach_client(new_client);
exit_free:
	kfree(data);
	return err;
}

static int adt7475_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter->class & I2C_CLASS_HWMON)) return 0;
	return i2c_probe(adapter, &addr_data, adt7475_detect);
}

static int adt7475_detach_client(struct i2c_client *client)
{
	struct adt7475_data *data = i2c_get_clientdata(client);
	int i, err;

	hwmon_device_unregister(data->class_dev);

	for(i = 0; i < ARRAY_SIZE(adt7475_in_attr); ++i) device_remove_file(&client->dev, &adt7475_in_attr[i].dev_attr);
	for(i = 0; i < ARRAY_SIZE(adt7475_temp_attr); ++i) device_remove_file(&client->dev, &adt7475_temp_attr[i].dev_attr);
	for(i = 0; i < ARRAY_SIZE(adt7475_fan_attr); ++i) device_remove_file(&client->dev, &adt7475_fan_attr[i].dev_attr);


	if ((err = i2c_detach_client(client)))
		return err;

	kfree(data);
	return 0;
}

static struct adt7475_data *adt7475_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adt7475_data *data = i2c_get_clientdata(client);
	u8 reg_in_low, reg_temp_low, fan_act_low;
	int i;

	mutex_lock(&data->update_lock);

	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) 
	{	
		/* Read voltage */
		/* First read low byte because otherwise the high-registers will be frozen */
		reg_in_low = i2c_smbus_read_byte_data(client, ADT7475_REG_IN_LOW);
		for(i = 0; i < 2; i++)
		{
			/* Read high voltage */
			data->in[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_IN_HIGH(i)) << 2 | (reg_in_low >> (2 + 2 * i) & 0x03);

			/* Read high limit, low limit voltage */
			data->in_max[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_IN_HIGH_LIMIT(i));
			data->in_min[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_IN_LOW_LIMIT(i));
		}

		/* Read Temperatures */
		/* First read low byte because otherwise the high-registers will be frozen */
		reg_temp_low = i2c_smbus_read_byte_data(client, ADT7475_REG_TEMP_LOW);
		for(i = 0; i < 3; i++)
		{
			/* Read high temp*/
			data->temp_act[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_TEMP_ACT(i)) << 2 | (reg_temp_low >> (6 - 2 * i)& 0x03);

			/* Read high limit, low limit temperatures */
			data->temp_max[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_TEMP_HIGH_LIMIT(i));
			data->temp_min[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_TEMP_LOW_LIMIT(i));
		}

		/* Read fan speeds */
// !!! Er is geen maximale fan speed, dit is een 16 bit waarde
// !!! Need to read the HIGH register first to activate the fan measurement! adt7475 manual page 28
		/* First read low byte because otherwise the high-registers will be frozen */
		for(i = 0; i < 4; i++)
		{
			fan_act_low = i2c_smbus_read_byte_data(client, ADT7475_REG_FAN_ACT_LOW(i));
			data->fan_act[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_FAN_ACT_HIGH(i)) << 8 | fan_act_low;

			// lees minimale fan waarde. 16bit

		}

		/* Read Configuration Registers */
		for(i = 0; i < ARRAY_SIZE(ADT7475_REG_CONFIG); i++)
			data->config[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_CONFIG[i]);

		/* Read Status Registers */
		for(i = 0; i < 2; i++)
			data->intr_status[i] = i2c_smbus_read_byte_data(client, ADT7475_REG_INTR_STATUS(i));

		/* ??? Read Global */
		// data->global_control = i2c_smbus_read_byte_data(client, ADT7475_REG_CONTROL);

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);

	return data;
}

static int __init adt7475_init(void)
{
	printk(KERN_INFO "adt7475 driver loaded\n");
	return i2c_add_driver(&adt7475_driver);
}

static void __exit adt7475_exit(void)
{
	printk(KERN_INFO "adt7475 driver unloaded\n");
	i2c_del_driver(&adt7475_driver);
}

MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
MODULE_DESCRIPTION("ADT7475 driver");
MODULE_LICENSE("GPL");

module_init(adt7475_init);
module_exit(adt7475_exit);

--------------010904030208050703030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010904030208050703030800--
