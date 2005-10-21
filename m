From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 21 Oct 2005 20:20:40 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <43592F7E.300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ah,

Now I understand, Thunderbird somehow chooses application/octet as type=20
for C-source code. Reattaching this time as .txt file.

About patch vs c-code file, I don't have any changes to the kernel build=20
system, one of the blessings of the new buildsystem is that it is very=20
easy to build modules out of tree and that is what I've been doing I've=20
also attached a Makefile.txt for you to build it with.

Thanks & Regards,

Hans



Jean Delvare wrote:
>>>>The driver.
>>>
>>>-ENOPATCH
>>
>>Yes, its a new driver, so nothing to diff against, would a diff against=20
>>/dev/null really make you happier?
>=20
>=20
> No, I mean, there is no attachement at all.
>=20
> And yes, a patch would still make me happier, because it would include
> the relevant changes to the kernel build system so that we can check
> that your code compiles properly, and people could test your driver
> more easily too.
>=20
>=20
>>Can someone please take a look at the driver and give me some proper=20
>>feedback?
>=20
>=20
> Not before you actually send something to us ;)
>=20
> Note that the mailing list is configured to drop any unacceptable
> attachement. Maybe that's what happened. Accepted types are text/plain
> and text/x-patch. Make sure your attachement has the proper type. If
> you think there is a different type we should accept, please let us
> know.
>=20
-------------- next part --------------
/*
    abituguru.c - Part of lm_sensors, Linux kernel modules
                  for hardware monitoring

    Copyright (c) 2005  Hans de Goede <j.w.r.degoede@hhs.nl>

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
    This driver supports the sensor part of the custom Abit uGuru chip found
    on Abit uGuru motherboards. Currently it has been tested on an Abit KV8
    Pro, AV8, AX8 and AN8-SLI. The openguru program this driver is based on
    has also been successfully tested on: Abit AV8 3rd Eye, AN8 Ultra and A=
N7.
   =20
    Unfortunatly there are no specs for this chip, this driver is based on =
the
    (reverse enginered) openguru program by Olle Sandberg <ollebull@gmail.c=
om>.
    You can find the first version of his program which only supports readi=
ng
    the sensors not the min/max values at:
    http://hem.bredband.net/b330708/oguru/oguru.tar.gz
    I would like to express my thanks to Olle, this driver couldnot have be=
en
    written without his efforts.
   =20
    Because of the lack of specs only the sensors part of the uGuru is
    supported. A word of caution to those who want to experiment and see if
    they can figure the voltage / clock programming out, I tried reading and
    only reading banks 0-0x30 with the reading code used for the sensor ban=
ks
    (0x20-0x28) and this resulted in a permanent reprogramming of the volta=
ges,
    luckily I had the sensors part configured so that it would shutdown my
    system on any out of spec voltages which proprably safed my computer (a=
fter
    a reboot I managed to immediatly enter the bios and reload the defaults=
).
    This probably means that the read/write cycle for the non sensor part is
    different from the sensor part.
   =20
    This driver used via686a.c as a skeleleton since that is an ISA only ch=
ip
    like the Abit uGuru (AFAIK).
*/
/*  History:
   =20
    version 0.9:
    -initial release, only reading the sensors is supported.
    version 0.9.1:
    -Olle has done some more reverse engineering, so now reading the min/max
     values and the settings is also supported.
    -modified the driver to work with the new hwmon seperation in 2.6.13,
     As a result this version requires 2.6.13 or higher.
    -simplified the ready code.
    -added a abituguru_wait function which waits for the uguru the reach
     a certain state, use this everywhere instead of having seperate loops
     with there own timeouts scatered over the place.
    -use array sysfs initalisation instead of #define hell.
    -fix rounding of values.
    version 0.9.2:
    -Olle has now reverse engineered the writing of the flags and min/max
     values, so now writing the min/max values is also supported.=20
    -Now that we've seen testing of more mainboards, it turns out that
     the way the volt inputs are hooked up isn't identical for all mainboar=
ds,
     also causing the ranges for the volt inputs to be not constant. Because
     of this conversion for the voltage sensors has been removed, the raw
     register values are now returned. Sample entries for known mainboards
     will be added to sensors.conf .
    -During this testing, it has also been shown that certain addresses in
     bank1 (0x0D) sometimes are attached to a temp sensor and sometimes to a
     volt sensor. Luckily with some tricks this can be detected, so now we
     detect if a sensor is connected and what type for all addresses in ban=
k1.
    version 0.9.3:
    -userspace expects temp and in values to be in milli units, so they are=
 now
     multiplied by 1000 in show and divided by 1000 on set.
    -Now that the min/max values can be written I've been able to trigger s=
ome
     false alarms and have managed to find out how the alarms work, so now
     reading the alarms is supported also.
    version 0.9.4:
    -reshuffle / cleanup (mainly bank1 handling)
    -fix some race conditions
    version 0.9.5:
    -Reading/writing the settings (enable alarm, beep, shutdown) is now also
     supported.
    version 1.0.0:
    -Added support for controling the fan PWM (speed control).
    -Add force param to skip "detection" .
*/

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/pci.h>
#include <linux/jiffies.h>
#include <linux/i2c.h>
#include <linux/i2c-isa.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/init.h>
#include <asm/io.h>

/* This is needed untill this gets merged upstream */
#ifndef __SENSOR_DEVICE_ATTR
#define __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
{	.dev_attr =3D	__ATTR(_name,_mode,_show,_store),	\
	.index =3D	_index,					\
}
#endif

/* Debugging output is enabled for now, since this driver is still in the
   testing fase */
#define ABIT_UGURU_DEBUG	1
/* Banks */
#define ABIT_UGURU_ALARM_BANK	0x20 /* 3 bytes, 2 bytes bank1, 1 byte bank2 =
*/
#define ABIT_UGURU_SENSOR_BANK1	0x21 /* volt and temp */
#define ABIT_UGURU_FAN_PWM	0x24 /* 3x 5 bytes */
#define ABIT_UGURU_SENSOR_BANK2	0x26 /* fans */
/* uGuru sensor bank 1 flags */			     /* Alarm if: */
#define ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE	0x01 /*  temp over warn */
#define ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE	0x02 /*  volt over max */
#define ABIT_UGURU_VOLT_LOW_ALARM_ENABLE	0x04 /*  volt under min */
#define ABIT_UGURU_TEMP_HIGH_ALARM_FLAG		0x10 /* temp is over warn */
#define ABIT_UGURU_VOLT_HIGH_ALARM_FLAG		0x20 /* volt is over max */
#define ABIT_UGURU_VOLT_LOW_ALARM_FLAG		0x40 /* volt is under min */
/* uGuru sensor bank 2 flags */			     /* Alarm if: */
#define ABIT_UGURU_FAN_LOW_ALARM_ENABLE		0x01 /*   fan under min */
/* uGuru sensor bank common flags */
#define ABIT_UGURU_BEEP_ENABLE			0x08 /* beep if alarm */
#define ABIT_UGURU_SHUTDOWN_ENABLE		0x80 /* shutdown if alarm */
/* uGuru fan PWM (speed control) flags */
#define ABIT_UGURU_FAN_PWM_ENABLE		0x80 /* enable speed control */
/* Values used for conversion */
#define ABIT_UGURU_FAN_MAX	15300 /* RPM */
/* Bank1 sensor types */
#define ABIT_UGURU_IN_SENSOR	0
#define ABIT_UGURU_TEMP_SENSOR	1
#define ABIT_UGURU_NC		2

/* All the variables below are named identical to the oguru and oguru2 prog=
rams
   reverse engineered by Olle Sandberg, hence the names might not be 100%
   logical. I could come up with better names, but I prefer keeping the nam=
es
   identical so that this driver can be compared with his work more easily.=
 */
/* Two i/o-ports are used by uGuru */
#define ABIT_UGURU_BASE		0x00E0
#define ABIT_UGURU_CMD		0x00 /* Used to tell uGuru what to read and to read=
 the actual data */
#define ABIT_UGURU_DATA		0x04 /* Mostly used to check if uGuru is busy */
/* uGuru status' */
#define ABIT_UGURU_STATUS_WRITE	0x00 /* Ready to be written */
#define ABIT_UGURU_STATUS_READ	0x01 /* Ready to be read */
#define ABIT_UGURU_STATUS_INPUT	0x08 /* More input */
#define ABIT_UGURU_STATUS_READY	0x09 /* Ready to be written */


/* Insmod parameters */
static int force;
module_param(force, bool, 0);
MODULE_PARM_DESC(force, "Set to one to force detection.");

/* For the Abit uGuru, we need to keep some data in memory.
   The structure is dynamically allocated, at the same time when a new
   abituguru client is allocated. */
struct abituguru_data {
	struct i2c_client client;
	struct class_device *class_dev;
	struct semaphore update_lock;
	char uguru_ready;	/* is the uguru in ready state? */
	char valid;		/* !=3D0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */

	/* Bank 1 data */
	u8 bank1_sensors[2];	/* number of [0] in, [1] temp sensors */
	u8 bank1_address[2][16];/* addresses of [0] in, [1] temp sensors */
	/* This array holds 16 x 4 entries for all the sensors in bank 1
	   (flags,min,max,value for voltage/..,warn,shutdown,.. for temp). */
	u8 bank1_regs[16*4];
	/* The sysfs attr for the bank1 sensors are generated automaticly */
	struct sensor_device_attribute bank1_attr[16*3];

	/* Bank 2 data, the highest number of fans currently know to be
	   attached is 6, thus 6 x 3 entries (flags, min, value). */
	u8 bank2_regs[6*3];

	/* Alarms 2 bytes for bank1, 1 byte for bank2 */
	u8 alarm_regs[3];
=09
	/* Fan PWM (speed control) 3x5 bytes */
	u8 fan_pwm_regs[3*5];
};

static int abituguru_detect(struct i2c_adapter *adapter);
static int abituguru_detach_client(struct i2c_client *client);
/* Danger Will Robinson, danger! This function downs the update_lock semaph=
ore
   in the abituguru_data struct but doesn't up it, the caller must up
   it when it is done with the returned data! */
static struct abituguru_data *abituguru_update_device(struct device *dev);

/* wait till the uguru is in the specified state */
static int abituguru_wait(struct i2c_client *client, u8 state)
{
	/* 250 was determined by trial and error, 200 works most of the time
	   but not always. I assume this is cpu-speed independent, since
	   the ISA-bus and not the CPU should be the bottleneck. */
	int lockup_cnt =3D 250;
	 =20
	while (inb_p(client->addr + ABIT_UGURU_DATA) !=3D state)
	{
	  lockup_cnt--;
	  if (lockup_cnt =3D 0)
	    return -EIO;
	}
=09
	return 0;
}

/* Put the uguru in ready for input state, this code assumes that
   the uguru is not already in this state.
   It is the callers responsibility to make sure it isn't! */
static int abituguru_ready(struct i2c_client *client)
{
	struct abituguru_data *data =3D i2c_get_clientdata(client);

	/* Reset? / Prepare for next read/write cycle */
	outb_p(0x00, client->addr + ABIT_UGURU_DATA);

	/* Wait till the uguru is ready */
	if (abituguru_wait(client, ABIT_UGURU_STATUS_READY))
		return -EIO;

	/* Cmd port MUST be read now and should contain 0xAC */
	if (inb_p(client->addr + ABIT_UGURU_CMD) !=3D 0xAC)
		return -EIO;

#if ABIT_UGURU_DEBUG	=09
	/* After this the ABIT_UGURU_DATA port should contain
	   ABIT_UGURU_STATUS_INPUT */
	if (inb_p(client->addr + ABIT_UGURU_DATA) !=3D=20
	      ABIT_UGURU_STATUS_INPUT)
		return -EIO;
#endif=09
=09
	data->uguru_ready =3D 1;
	return 0;
}

static int abituguru_send_address(struct i2c_client *client,
	u8 bank_addr, u8 sensor_addr)
{
	struct abituguru_data *data =3D i2c_get_clientdata(client);

 	/* When we're called the uguru normally will be ready for the first
	   input and thus in ABIT_UGURU_STATUS_INPUT state. If however
	   something went wrong previously it might not be, so then we try to
	   force it into ready state. If/when the uguru is ready we send the
	   bank address, after this the uguru is no longer "ready". */
	if (!data->uguru_ready && (abituguru_ready(client) !=3D 0))
		return -EIO;
	outb_p(bank_addr, client->addr + ABIT_UGURU_DATA);
	data->uguru_ready =3D 0;

	/* Wait till the uguru is ABIT_UGURU_STATUS_INPUT state again and send
	   the sensor addr */
	if (abituguru_wait(client, ABIT_UGURU_STATUS_INPUT))
		return -EIO;
	outb_p(sensor_addr, client->addr + ABIT_UGURU_CMD);
=09
	return 0;
}

static int abituguru_read(struct i2c_client *client,
	u8 bank_addr, u8 sensor_addr, u8 *buf, int count)
{
	int bytes_read =3D 0;
=09
	/* Send the address */
	if (abituguru_send_address(client, bank_addr, sensor_addr))
		return -EIO;
=09
	/* And read the data */
	while((bytes_read < count) &&
	      (abituguru_wait(client, ABIT_UGURU_STATUS_READ)=3D0)) {
		buf[bytes_read] =3D inb(client->addr + ABIT_UGURU_CMD);
		bytes_read++;
	}

	/* Last put the chip back in ready state */
	abituguru_ready(client);

	return bytes_read;
}

static int abituguru_write(struct i2c_client *client,
	u8 bank_addr, u8 sensor_addr, u8 *buf, int count)
{
	int bytes_written =3D 0;

	/* Send the address */
	if (abituguru_send_address(client, bank_addr, sensor_addr))
		return -EIO;

	/* And write the data */
	while((bytes_written < count) &&
	      (abituguru_wait(client, ABIT_UGURU_STATUS_WRITE)=3D0)) {
		outb(buf[bytes_written], client->addr + ABIT_UGURU_CMD);
		bytes_written++;
	}
=09
	/* Now we need to wait till the chip is ready to be read again,
	   don't ask why */
	if (abituguru_wait(client, ABIT_UGURU_STATUS_READ))
		return -EIO;
=09
	/* Cmd port MUST be read now and should contain 0xAC */
	if (inb_p(client->addr + ABIT_UGURU_CMD) !=3D 0xAC)
		return -EIO;
=09
	/* Last put the chip back in ready state */
	abituguru_ready(client);

	return bytes_written;
}

/* Detect sensor type. Temp and Volt sensors are enabled with
   different masks and will ignore enable masks not meant for them.
   This enables us to test what kindoff sensor we're dealing with.
   By setting the alarm treshholds so that we will always get an
   alarm for sensor type X and then enabling the sensor as sensor type
   X, if we then get an alarm it is a sensor of type X. */
static int abituguru_detect_sensor_type(struct i2c_client *client,
	u8 sensor_addr)
{
	u8 orig_settings[3];
	u8 buf[3];
	u8 val;
	int ret =3D ABIT_UGURU_NC;
=09
	/* First read the sensor and the current settings */
	if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1, sensor_addr, &val,
		1) !=3D 1)	return -EIO;
	if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1+1, sensor_addr,
		orig_settings, 3) !=3D 3)	return -EIO;
=09
	/* Test val is sane / usable for sensor type detection. */
	if ((val < 10u) || (val > 245u))
		return -1; /* ? */
=09
	/* Volt sensor test, enable volt low alarm, set min value ridicously
	   high. If its a volt sensor this should always give us an alarm. */
	buf[0]=ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
	buf[1]%4;
	buf[2]%5;
	if (abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
		buf,3) !=3D 3)	return -EIO;
	/* Now we need 20 ms to give the uguru time to read the sensors
	   and raise the alarm */
	set_current_state(TASK_UNINTERRUPTIBLE);
	schedule_timeout(HZ/50);
	/* Check for alarm and check the alarm is a volt low alarm. */
	if ( (abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0, buf, 3) =3D 3) &&
	     (buf[sensor_addr/8] & (0x01<<(sensor_addr%8)) ) &&
	     (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1+1,
		sensor_addr, buf, 3) =3D 3) &&
	     (buf[0] & ABIT_UGURU_VOLT_LOW_ALARM_FLAG) ) {
		abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2,
			sensor_addr, orig_settings, 3);
		return ABIT_UGURU_IN_SENSOR;
	}

	/* Temp sensor test, enable sensor as a temp sensor, set beep value
	   ridicously low (but not too low, otherwise uguru ignores it).
	   If its a temp sensor this should always give us an alarm. */
	buf[0]=ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE;
	buf[1]=3D5;
	buf[2]=10;
	if (abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
		buf,3) !=3D 3)	return -EIO;
	/* Now we need 20 ms to give the uguru time to read the sensors
	   and raise the alarm */
	set_current_state(TASK_UNINTERRUPTIBLE);
	schedule_timeout(HZ/50);
	/* Check for alarm and check the alarm is a temp high alarm. */
	if ( (abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0, buf, 3) =3D 3) &&
	     (buf[sensor_addr/8] & (0x01<<(sensor_addr%8)) ) &&
	     (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1+1,
		sensor_addr, buf, 3) =3D 3) &&
	     (buf[0] & ABIT_UGURU_TEMP_HIGH_ALARM_FLAG) )
		ret =3D ABIT_UGURU_TEMP_SENSOR;
=09
	/* Restore original settings */
	abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
		orig_settings, 3);
=09
	return ret;
}

/* following are the sysfs callback functions */
static ssize_t show_bank1_reg(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid)
		ret =3D sprintf(buf, "%d\n", data->bank1_regs[attr->index]*1000);
	up(&data->update_lock);
	return ret;
}

static ssize_t show_bank2_reg(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid)
		ret =3D sprintf(buf, "%d\n",  (data->bank2_regs[attr->index]*
			ABIT_UGURU_FAN_MAX + 128) / 255);
	up(&data->update_lock);
	return ret;
}

static ssize_t store_bank1_reg(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	int val =3D (simple_strtoul(buf, NULL, 10) + 500) / 1000;
	ssize_t ret =3D -EIO;
	if (data->valid && (data->bank1_regs[attr->index] !=3D val)) {
		u8 buf[3];
		memcpy (buf, &data->bank1_regs[attr->index & ~3], 3);
		buf[attr->index&3] =3D val;
		if (abituguru_write(&data->client,
			ABIT_UGURU_SENSOR_BANK1+2, attr->index/4, buf, 3) =3D 3)
			ret =3D count;
		data->valid =3D 0;
	}=09
	up(&data->update_lock);
	return ret;
}

static ssize_t store_bank2_reg(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	unsigned long user_val =3D simple_strtoul(buf, NULL, 10);
	u8 reg_val =3D (user_val*255 + ABIT_UGURU_FAN_MAX/2) /
		ABIT_UGURU_FAN_MAX;
	ssize_t ret =3D -EIO;
	if (data->valid && (data->bank2_regs[attr->index] !=3D reg_val)) {
		u8 buf[2];
		buf[0] =3D data->bank2_regs[(attr->index/3)*3];
		buf[1] =3D reg_val;
		if (abituguru_write(&data->client,
			ABIT_UGURU_SENSOR_BANK2+2, attr->index/3, buf, 2) =3D 2)
			ret =3D count;
		data->valid =3D 0;
	}
	up(&data->update_lock);
	return ret;
}

static ssize_t show_alarm_bank1(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		int i, alarm =3D 0;
		for (i=3D0; i<data->bank1_sensors[attr->index]; i++) {
			u8 address =3D data->bank1_address[attr->index][i];
			if (data->alarm_regs[address/8] & (0x01<<(address%8)))
				alarm |=3D 0x01 << i;
		}
		ret =3D sprintf(buf, "%d\n", alarm);
	}
	up(&data->update_lock);
	return ret;
}

static ssize_t show_alarm_bank2(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid)
		ret =3D sprintf(buf, "%d\n", (int)data->alarm_regs[2]);
	up(&data->update_lock);
	return ret;
}

/* sysfs utility functions for uguru settings */
static ssize_t show_bank1_settings(struct device *dev,
	struct device_attribute *devattr, u8 setting, char *buf)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		int i, mask =3D 0;
		for (i=3D0; i<data->bank1_sensors[attr->index]; i++) {
			u8 address =3D data->bank1_address[attr->index][i];
			if (data->bank1_regs[address*4] & setting)
				mask |=3D 0x01 << i;
		}
		ret =3D sprintf(buf, "%d\n", mask);
	}
	up(&data->update_lock);
	return ret;
}

static ssize_t show_bank2_settings(struct device *dev, u8 setting, char *bu=
f)
{
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		int i, mask =3D 0;
		for (i=3D0; i<6; i++) {
			if (data->bank2_regs[i*3] & setting)
				mask |=3D 0x01 << i;
		}
		ret =3D sprintf(buf, "%d\n", mask);
	}
	up(&data->update_lock);
	return ret;
}

static ssize_t store_bank1_settings(struct device *dev,
	struct device_attribute *devattr, u8 setting, const char *buf,
	size_t count)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	int i, mask =3D simple_strtoul(buf, NULL, 10);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		ret =3D count;
		for (i=3D0; i<data->bank1_sensors[attr->index]; i++) {
			u8 buf[3], dirty =3D 0;
			u8 address =3D data->bank1_address[attr->index][i];
			memcpy (buf, &data->bank1_regs[address*4], 3);
			/* check if we need to enable the feature */
			if ((mask&(0x01<<i)) && ((buf[0]&setting)!=3Dsetting)) {
				buf[0] |=3D setting;
				dirty =3D 1;
			}
			/* check if we need to disable the feature */
			if (!(mask&(0x01<<i)) && (buf[0]&setting)) {
				buf[0] &=3D ~setting;
				dirty =3D 1;
			}
			if (dirty) {
				if (abituguru_write(&data->client,
					ABIT_UGURU_SENSOR_BANK1+2, address,
					buf, 3) !=3D 3)
					ret =3D -EIO;
				data->valid =3D 0;
			}
		}
	}
	up(&data->update_lock);
	return ret;
}

static ssize_t store_bank2_settings(struct device *dev, u8 setting,
	const char *buf, size_t count)
{
	struct abituguru_data *data =3D abituguru_update_device(dev);
	int i, mask =3D simple_strtoul(buf, NULL, 10);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		ret =3D count;
		for (i=3D0; i<6; i++) {
			u8 buf[2], dirty =3D 0;
			memcpy (buf, &data->bank2_regs[i*3], 2);
			/* check if we need to enable the feature */
			if ((mask&(0x01<<i)) && ((buf[0]&setting)!=3Dsetting)) {
				buf[0] |=3D setting;
				dirty =3D 1;
			}
			/* check if we need to disable the feature */
			if (!(mask&(0x01<<i)) && (buf[0]&setting)) {
				buf[0] &=3D ~setting;
				dirty =3D 1;
			}
			if (dirty) {
				if (abituguru_write(&data->client,
					ABIT_UGURU_SENSOR_BANK2+2, i,
					buf, 2) !=3D 2)
					ret =3D -EIO;
				data->valid =3D 0;
			}
		}
	}
	up(&data->update_lock);
	return ret;
}

/* endof sysfs utility functions for uguru settings, continuation of
   normal sysfs callback functions: enables */
static ssize_t show_enable_in(struct device *dev,  =20
	struct device_attribute *devattr, char *buf)
{
	return show_bank1_settings(dev, devattr,
		ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE|
		ABIT_UGURU_VOLT_LOW_ALARM_ENABLE, buf);
}

static ssize_t show_enable_temp(struct device *dev,  =20
	struct device_attribute *devattr, char *buf)
{
	return show_bank1_settings(dev, devattr,
		ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE, buf);
}

static ssize_t show_enable_fan(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	return show_bank2_settings(dev, ABIT_UGURU_FAN_LOW_ALARM_ENABLE,
		buf);
}

static ssize_t store_enable_in(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	return store_bank1_settings(dev, devattr,
		ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE|
		ABIT_UGURU_VOLT_LOW_ALARM_ENABLE, buf, count);
}

static ssize_t store_enable_temp(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	return store_bank1_settings(dev, devattr,
		ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE, buf, count);
}

static ssize_t store_enable_fan(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	return store_bank2_settings(dev, ABIT_UGURU_FAN_LOW_ALARM_ENABLE, buf,
		count);
}

/* beeps */
static ssize_t show_beep_bank1(struct device *dev,  =20
	struct device_attribute *devattr, char *buf)
{
	return show_bank1_settings(dev, devattr, ABIT_UGURU_BEEP_ENABLE, buf);
}

static ssize_t show_beep_bank2(struct device *dev,  =20
	struct device_attribute *devattr, char *buf)
{
	return show_bank2_settings(dev, ABIT_UGURU_BEEP_ENABLE, buf);
}

static ssize_t store_beep_bank1(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	return store_bank1_settings(dev, devattr, ABIT_UGURU_BEEP_ENABLE, buf,
		count);
}

static ssize_t store_beep_bank2(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	return store_bank2_settings(dev, ABIT_UGURU_BEEP_ENABLE, buf, count);
}

/* shutdowns */
static ssize_t show_shutdown_bank1(struct device *dev,  =20
	struct device_attribute *devattr, char *buf)
{
	return show_bank1_settings(dev, devattr, ABIT_UGURU_SHUTDOWN_ENABLE,
		buf);
}

static ssize_t show_shutdown_bank2(struct device *dev,  =20
	struct device_attribute *devattr, char *buf)
{
	return show_bank2_settings(dev, ABIT_UGURU_SHUTDOWN_ENABLE, buf);
}

static ssize_t store_shutdown_bank1(struct device *dev, struct device_attri=
bute
	*devattr, const char *buf, size_t count)
{
	return store_bank1_settings(dev, devattr, ABIT_UGURU_SHUTDOWN_ENABLE,
		buf, count);
}

static ssize_t store_shutdown_bank2(struct device *dev, struct device_attri=
bute
	*devattr, const char *buf, size_t count)
{
	return store_bank2_settings(dev,ABIT_UGURU_SHUTDOWN_ENABLE,buf,count);
}

/* Fan PWM (speed control) */
static ssize_t show_fan_pwm_reg(struct device *dev,
        struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid)
		ret =3D sprintf(buf, "%d\n",
			(int)data->fan_pwm_regs[attr->index]);
	up(&data->update_lock);
	return ret;
}
       =20
static ssize_t store_fan_pwm_reg(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	int val =3D simple_strtoul(buf, NULL, 10);
	ssize_t ret =3D -EIO;
	if (data->valid && (data->fan_pwm_regs[attr->index] !=3D val)) {
		u8 buf[5];
		memcpy (buf, &data->fan_pwm_regs[(attr->index/5)*5], 5);
		buf[attr->index%5] =3D val;
		if (abituguru_write(&data->client,
			ABIT_UGURU_FAN_PWM+1, attr->index/5, buf, 5) =3D 5)
			ret =3D count;
		data->valid =3D 0;
	}=09
	up(&data->update_lock);
	return ret;
}

static ssize_t show_fan_pwm_sensor(struct device *dev,
        struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		/* We need to walk to the temp sensor addresses to find what
		   the userspace id of the configured temp sensor is. */
		int i;
		for (i=3D0; i<data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR]; i++) {
			if (data->bank1_address[ABIT_UGURU_TEMP_SENSOR][i] =3D
			    (data->fan_pwm_regs[attr->index] & 0x0F)) {
				ret =3D sprintf(buf, "%d\n", i+1);
				break;
			}
		}
	}
	up(&data->update_lock);
	return ret;
}
       =20
static ssize_t store_fan_pwm_sensor(struct device *dev, struct device_attri=
bute
	*devattr, const char *buf, size_t count)
{
	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
	struct abituguru_data *data =3D abituguru_update_device(dev);
	unsigned long val =3D simple_strtoul(buf, NULL, 10) - 1;
	ssize_t ret =3D count;
	if (!data->valid)
		ret =3D -EIO;
	else if (val < data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR]) {
		u8 buf[5];
		u8 address =3D data->bank1_address[ABIT_UGURU_TEMP_SENSOR][val];
		memcpy (buf, &data->fan_pwm_regs[attr->index], 5);
		buf[0] =3D (buf[0]&0xF0) | address;
		if (buf[0] !=3D data->fan_pwm_regs[attr->index]) {
			if (abituguru_write(&data->client, ABIT_UGURU_FAN_PWM+1,
				attr->index/5, buf, 5) !=3D 5)
				ret =3D -EIO;
			data->valid =3D 0;
		}
	}
	up(&data->update_lock);
	return ret;
}

static ssize_t show_enable_fan_pwm(struct device *dev,
        struct device_attribute *devattr, char *buf)
{
	struct abituguru_data *data =3D abituguru_update_device(dev);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		int i, mask =3D 0;
		for (i=3D0; i<3; i++) {
			if (data->fan_pwm_regs[i*5]&ABIT_UGURU_FAN_PWM_ENABLE)
				mask |=3D 0x01 << i;
		}
		ret =3D sprintf(buf, "%d\n", mask);
	}
	up(&data->update_lock);
	return ret;
}
       =20
static ssize_t store_enable_fan_pwm(struct device *dev, struct device_attri=
bute
	*devattr, const char *buf, size_t count)
{
	struct abituguru_data *data =3D abituguru_update_device(dev);
	int i, mask =3D simple_strtoul(buf, NULL, 10);
	ssize_t ret =3D -EIO;
	if (data->valid) {
		ret =3D count;
		for (i=3D0; i<3; i++) {
			u8 buf[5], dirty =3D 0;
			memcpy (buf, &data->fan_pwm_regs[i*5], 5);
			/* check if we need to enable */
			if ( (mask&(0x01<<i)) &&
			    !(buf[0]&ABIT_UGURU_FAN_PWM_ENABLE)) {
				buf[0] |=3D ABIT_UGURU_FAN_PWM_ENABLE;
				dirty =3D 1;
			}
			/* check if we need to disable */
			if (!(mask&(0x01<<i)) &&
			     (buf[0]&ABIT_UGURU_FAN_PWM_ENABLE)) {
				buf[0] &=3D ~ABIT_UGURU_FAN_PWM_ENABLE;
				dirty =3D 1;
			}
			if (dirty) {
				if (abituguru_write(&data->client,
					ABIT_UGURU_FAN_PWM+1, i,
					buf, 5) !=3D 5)
					ret =3D -EIO;
				data->valid =3D 0;
			}
		}
	}
	up(&data->update_lock);
	return ret;
}

/* Sysfs attr, the entries for the temp and in sensors are missing, these a=
re
   generated automaticly, because we don't know how many temp and in sensors
   there are in bank1, luckily we can probe the uguru to find out if a sens=
or
   is not connected, temp or in. */
static struct sensor_device_attribute abituguru_sysfs_attr[] =3D {
	__SENSOR_DEVICE_ATTR(fan1_input,       0444, show_bank2_reg, NULL, 2),
	__SENSOR_DEVICE_ATTR(fan1_min,         0644, show_bank2_reg,
		store_bank2_reg, 1),
	__SENSOR_DEVICE_ATTR(fan1_temp_sensor, 0644, show_fan_pwm_sensor,
		store_fan_pwm_sensor, 0),
	__SENSOR_DEVICE_ATTR(fan1_pwm_min,     0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 1),
	__SENSOR_DEVICE_ATTR(fan1_pwm_max,     0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 2),
	__SENSOR_DEVICE_ATTR(fan1_temp_min,    0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 3),
	__SENSOR_DEVICE_ATTR(fan1_temp_max,    0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 4),
	__SENSOR_DEVICE_ATTR(fan2_input,       0444, show_bank2_reg, NULL, 5),
	__SENSOR_DEVICE_ATTR(fan2_min,         0644, show_bank2_reg,
		store_bank2_reg, 4),
	__SENSOR_DEVICE_ATTR(fan2_temp_sensor, 0644, show_fan_pwm_sensor,
		store_fan_pwm_sensor, 5),
	__SENSOR_DEVICE_ATTR(fan2_pwm_min,     0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 6),
	__SENSOR_DEVICE_ATTR(fan2_pwm_max,     0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 7),
	__SENSOR_DEVICE_ATTR(fan2_temp_min,    0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 8),
	__SENSOR_DEVICE_ATTR(fan2_temp_max,    0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 9),
	__SENSOR_DEVICE_ATTR(fan3_input,       0444, show_bank2_reg, NULL, 8),
	__SENSOR_DEVICE_ATTR(fan3_min,         0644, show_bank2_reg,
		store_bank2_reg, 7),
	__SENSOR_DEVICE_ATTR(fan3_temp_sensor, 0644, show_fan_pwm_sensor,
		store_fan_pwm_sensor, 10),
	__SENSOR_DEVICE_ATTR(fan3_pwm_min,     0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 11),
	__SENSOR_DEVICE_ATTR(fan3_pwm_max,     0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 12),
	__SENSOR_DEVICE_ATTR(fan3_temp_min,    0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 13),
	__SENSOR_DEVICE_ATTR(fan3_temp_max,    0644, show_fan_pwm_reg,
		store_fan_pwm_reg, 14),
	__SENSOR_DEVICE_ATTR(fan4_input,       0444, show_bank2_reg, NULL, 11),
	__SENSOR_DEVICE_ATTR(fan4_min,         0644, show_bank2_reg,
		store_bank2_reg, 10),
	__SENSOR_DEVICE_ATTR(fan5_input,       0444, show_bank2_reg, NULL, 14),
	__SENSOR_DEVICE_ATTR(fan5_min,         0644, show_bank2_reg,
		store_bank2_reg, 13),
	__SENSOR_DEVICE_ATTR(fan6_input,       0444, show_bank2_reg, NULL, 17),
	__SENSOR_DEVICE_ATTR(fan6_min,         0644, show_bank2_reg,
		store_bank2_reg, 16),
	__SENSOR_DEVICE_ATTR(alarm_in,         0444, show_alarm_bank1, NULL,0),
	__SENSOR_DEVICE_ATTR(alarm_temp,       0444, show_alarm_bank1, NULL,1),
	__SENSOR_DEVICE_ATTR(alarm_fan,        0444, show_alarm_bank2, NULL,0),
	__SENSOR_DEVICE_ATTR(enable_in,        0644, show_enable_in,
		store_enable_in, 0),
	__SENSOR_DEVICE_ATTR(enable_temp,      0644, show_enable_temp,
		store_enable_temp, 1),
	__SENSOR_DEVICE_ATTR(enable_fan,       0644, show_enable_fan,
		store_enable_fan, 0),
	__SENSOR_DEVICE_ATTR(enable_fan_pwm,   0644, show_enable_fan_pwm,
		store_enable_fan_pwm, 0),
	__SENSOR_DEVICE_ATTR(beep_in,          0644, show_beep_bank1,
		store_beep_bank1, 0),
	__SENSOR_DEVICE_ATTR(beep_temp,        0644, show_beep_bank1,
		store_beep_bank1, 1),
	__SENSOR_DEVICE_ATTR(beep_fan,         0644, show_beep_bank2,
		store_beep_bank2, 0),
	__SENSOR_DEVICE_ATTR(shutdown_in,      0644, show_shutdown_bank1,
		store_shutdown_bank1, 0),
	__SENSOR_DEVICE_ATTR(shutdown_temp,    0644, show_shutdown_bank1,
		store_shutdown_bank1, 1),
	__SENSOR_DEVICE_ATTR(shutdown_fan,     0644, show_shutdown_bank2,
		store_shutdown_bank2, 0)
};

/* Const names for use in the dynamicly genererated in and temp sysfs attr,
   16 is a bit over kill since there are know known mainboards with 16 in
   or temp sensors, but better safe then sorry. */
static const char * const abituguru_bank1_name[2][3*16] =3D { {
	"in0_input",	"in0_min",	"in0_max",
	"in1_input",	"in1_min",	"in1_max",
	"in2_input",	"in2_min",	"in2_max",
	"in3_input",	"in3_min",	"in3_max",
	"in4_input",	"in4_min",	"in4_max",
	"in5_input",	"in5_min",	"in5_max",
	"in6_input",	"in6_min",	"in6_max",
	"in7_input",	"in7_min",	"in7_max",
	"in8_input",	"in8_min",	"in8_max",
	"in9_input",	"in9_min",	"in9_max",
	"in10_input",	"in10_min",	"in10_max",
	"in11_input",	"in11_min",	"in11_max",
	"in12_input",	"in12_min",	"in12_max",
	"in13_input",	"in13_min",	"in13_max",
	"in14_input",	"in14_min",	"in14_max",
	"in15_input",	"in15_min",	"in15_max" }, {
	"temp1_input",	"temp1_max",	"temp1_max_hyst",
	"temp2_input",	"temp2_max",	"temp2_max_hyst",
	"temp3_input",	"temp3_max",	"temp3_max_hyst",
	"temp4_input",	"temp4_max",	"temp4_max_hyst",
	"temp5_input",	"temp5_max",	"temp5_max_hyst",
	"temp6_input",	"temp6_max",	"temp6_max_hyst",
	"temp7_input",	"temp7_max",	"temp7_max_hyst",
	"temp8_input",	"temp8_max",	"temp8_max_hyst",
	"temp9_input",	"temp9_max",	"temp9_max_hyst",
	"temp10_input",	"temp10_max",	"temp10_max_hyst",
	"temp11_input",	"temp11_max",	"temp11_max_hyst",
	"temp12_input",	"temp12_max",	"temp12_max_hyst",
	"temp13_input",	"temp13_max",	"temp13_max_hyst",
	"temp14_input",	"temp14_max",	"temp14_max_hyst",
	"temp15_input",	"temp15_max",	"temp15_max_hyst",
	"temp16_input",	"temp16_max",	"temp16_max_hyst" }
};

/* The driver. I choose to use type i2c_driver, as at is identical to both
   smbus_driver and isa_driver, and clients could be of either kind */
static struct i2c_driver abituguru_driver =3D {
	.owner		=3D THIS_MODULE,
	.name		=3D "abituguru",
	.id		=3D 0, /* This is optional */
	.flags		=3D I2C_DF_NOTIFY,
	.attach_adapter	=3D abituguru_detect,
	.detach_client	=3D abituguru_detach_client,
};

/* This is called when the module is loaded */
static int abituguru_detect(struct i2c_adapter *adapter)
{
	struct i2c_client *new_client;
	struct abituguru_data *data;
	int i,res,err =3D 0;
	const char client_name[] =3D "abituguru";
	/* El weirdo probe order, to keep the sysfs order identical to the
	   BIOS and window-appliction listing order. */
	const u8 probe_order[16] =3D { 0x00,0x01,0x03,0x04,0x0A,0x08,0x0E,0x02,
		0x09,0x06,0x05,0x0B,0x0F,0x0D,0x07,0x0C };
	u8 data_val;

	/* Make sure we are probing the ISA bus!!  */
	if (!i2c_is_isa_adapter(adapter)) {
		dev_err(&adapter->dev,
		"abituguru_detect called for an I2C bus adapter?!?\n");
		err =3D -ENODEV;
		goto ERROR0;
	}

	/* Reserve our 2 ISA addresses */
	if (!request_region(ABIT_UGURU_BASE+ABIT_UGURU_CMD, 1,
		abituguru_driver.name)) {
		dev_err(&adapter->dev, "ISA-address %x already in use!\n",
			ABIT_UGURU_BASE + ABIT_UGURU_CMD);
		err =3D -EBUSY;
		goto ERROR0;
	}
	if (!request_region(ABIT_UGURU_BASE+ABIT_UGURU_DATA, 1,
		abituguru_driver.name)) {
		dev_err(&adapter->dev, "ISA-address %x already in use!\n",
			ABIT_UGURU_BASE + ABIT_UGURU_DATA);
		err =3D -EBUSY;
		goto ERROR1;
	}

	/* Malloc our data and initialise the static parts. */
	if (!(data =3D kmalloc(sizeof(struct abituguru_data), GFP_KERNEL))) {
		err =3D -ENOMEM;
		goto ERROR2;
	}
	memset(data, 0, sizeof(struct abituguru_data));
	new_client =3D &data->client;
	i2c_set_clientdata(new_client, data);
	new_client->addr =3D ABIT_UGURU_BASE;
	new_client->adapter =3D adapter;
	new_client->driver =3D &abituguru_driver;
	new_client->flags =3D 0;
	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
	init_MUTEX(&data->update_lock);

	/* See if there is an uguru there. After a reboot uGuru will hold 0x00
	   at DATA and 0xAC at CMD. When this driver has already been loaded
	   once DATA will hold 0x08 that's why we need to test both. */
	data_val =3D inb_p(ABIT_UGURU_BASE + ABIT_UGURU_DATA);
	if ( ((data_val =3D 0x00) || (data_val =3D 0x08)) &&
	     (inb_p(ABIT_UGURU_BASE + ABIT_UGURU_CMD) =3D 0xAC)) {
	     	/* Probably found uGuru, see if its ready */
		if (data_val =3D ABIT_UGURU_STATUS_INPUT)
			data->uguru_ready =3D 1;
	} else if (force) {
		/* User forced goahead, see if it the uGuru is in waiting
		   for input state, and ifso force a read to make sure it
		   is ready for the ready cycle */
		printk(KERN_WARNING "No Abit uGuru found, asuming one is present because =
of \"force\" parameter\n");
		if (data_val =3D ABIT_UGURU_STATUS_INPUT) {
			u8 dummy;
			data->uguru_ready =3D 1;
			abituguru_read(new_client, ABIT_UGURU_SENSOR_BANK2,
				0, &dummy, 1);
		}
	} else {
		/* No uGuru found */
		err =3D -ENODEV;
		goto ERROR3;
	}
=09
	/* Do a test read of the uGuru to see if one really is there,
	   note that this won't read bank1 since we didn't detect
	   the bank1 sensors yet. */
	abituguru_update_device(&new_client->dev);
	if (!data->valid) {
		err =3D -ENODEV;
		goto ERROR3;
	}
	up(&data->update_lock);
	data->valid =3D 0;

	/* Tell the I2C layer a new client has arrived */
	if ((err =3D i2c_attach_client(new_client)))
		goto ERROR3;

	/* Register sysfs hooks */
	data->class_dev =3D hwmon_device_register(&new_client->dev);
	if (IS_ERR(data->class_dev)) {
		err =3D PTR_ERR(data->class_dev);
		goto ERROR4;
	}
	/* Detect sensor types and register the sysfs hooks for bank1 */
	for (i=3D0; i<16; i++) {
		data->bank1_attr[i*3   ].dev_attr.attr.mode  =3D 0444;
		data->bank1_attr[i*3   ].dev_attr.attr.owner =3D THIS_MODULE;
		data->bank1_attr[i*3   ].dev_attr.show  =3D show_bank1_reg;
		data->bank1_attr[i*3   ].dev_attr.store =3D NULL;
		data->bank1_attr[i*3   ].index =3D probe_order[i]*4 + 3;
		data->bank1_attr[i*3 +1].dev_attr.attr.mode  =3D 0644;
		data->bank1_attr[i*3 +1].dev_attr.attr.owner =3D THIS_MODULE;
		data->bank1_attr[i*3 +1].dev_attr.show  =3D show_bank1_reg;
		data->bank1_attr[i*3 +1].dev_attr.store =3D store_bank1_reg;
		data->bank1_attr[i*3 +1].index =3D probe_order[i]*4 + 1;
		data->bank1_attr[i*3 +2].dev_attr.attr.mode  =3D 0644;
		data->bank1_attr[i*3 +2].dev_attr.attr.owner =3D THIS_MODULE;
		data->bank1_attr[i*3 +2].dev_attr.show  =3D show_bank1_reg;
		data->bank1_attr[i*3 +2].dev_attr.store =3D store_bank1_reg;
		data->bank1_attr[i*3 +2].index =3D probe_order[i]*4 + 2;
	=09
		res =3D abituguru_detect_sensor_type(new_client, probe_order[i]);
		if (res < 0) {
			printk(KERN_WARNING "Couldnot determine sensor type for sensorbank1 sens=
or %d, skipping sensor\n", i);
			continue;
		}
	=09
		if (res !=3D ABIT_UGURU_NC) {
			data->bank1_attr[i*3   ].dev_attr.attr.name 				abituguru_bank1_name[res=
][
					data->bank1_sensors[res]*3   ];
			data->bank1_attr[i*3 +1].dev_attr.attr.name 				abituguru_bank1_name[res=
][
					data->bank1_sensors[res]*3 +1];
			data->bank1_attr[i*3 +2].dev_attr.attr.name 				abituguru_bank1_name[res=
][
					data->bank1_sensors[res]*3 +2];
			data->bank1_address[res][data->bank1_sensors[res]] 				probe_order[i];
			data->bank1_sensors[res]++;

			device_create_file(&new_client->dev,
				&data->bank1_attr[i*3   ].dev_attr);
			device_create_file(&new_client->dev,
				&data->bank1_attr[i*3 +1].dev_attr);
			device_create_file(&new_client->dev,
				&data->bank1_attr[i*3 +2].dev_attr);
		}
	}
	/* Fan and misc hooks */
	for (i=3D0; i<40; i++)
		device_create_file(&new_client->dev,
			&abituguru_sysfs_attr[i].dev_attr);

	return 0;

ERROR4:
	if (i2c_detach_client(new_client))
		dev_err(&new_client->dev,
		"Client deregistration failed, client not detached.\n");
ERROR3:
	kfree(data);
ERROR2:
	release_region(ABIT_UGURU_BASE + ABIT_UGURU_DATA, 1);
ERROR1:
	release_region(ABIT_UGURU_BASE + ABIT_UGURU_CMD, 1);
ERROR0:
	return err;
}

static int abituguru_detach_client(struct i2c_client *client)
{
	int err;
	struct abituguru_data *data =3D i2c_get_clientdata(client);

	hwmon_device_unregister(data->class_dev);

	if ((err =3D i2c_detach_client(client))) {
		dev_err(&client->dev,
		"Client deregistration failed, client not detached.\n");
		return err;
	}

	release_region(client->addr + ABIT_UGURU_DATA, 1);
	release_region(client->addr + ABIT_UGURU_CMD, 1);
	kfree(data);

	return 0;
}

/* Danger Will Robinson, danger! This function downs the update_lock semaph=
ore
   in the abituguru_data struct but doesn't up it, the caller must up
   it when it is done with the returned data! */
static struct abituguru_data *abituguru_update_device(struct device *dev)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct abituguru_data *data =3D i2c_get_clientdata(client);
	int i;

	down(&data->update_lock);

	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
	    || !data->valid) {
	    	data->valid =3D 0;
		if (abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0,
			data->alarm_regs, 3) !=3D 3)
			return data;
		for (i =3D 0; i < 16; i++) {
			if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1,
				i, &data->bank1_regs[i*4+3], 1) !=3D 1)
				return data;
			if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1+1,
				i, &data->bank1_regs[i*4], 3) !=3D 3)
				return data;
		}
		for (i =3D 0; i < 3; i++) {
			if (abituguru_read(client, ABIT_UGURU_FAN_PWM,
				i, &data->fan_pwm_regs[i*5], 5) !=3D 5)
				return data;
		}
		for (i =3D 0; i < 6; i++) {
			if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK2,
				i, &data->bank2_regs[i*3+2], 1) !=3D 1)
				return data;
			if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK2+1,
				i, &data->bank2_regs[i*3], 2) !=3D 2)
				return data;
		}
		data->last_updated =3D jiffies;
	    	data->valid =3D 1;
	}
	return data;
}

static int __init sm_abituguru_init(void)
{
	return i2c_isa_add_driver(&abituguru_driver);
}

static void __exit sm_abituguru_exit(void)
{
	i2c_isa_del_driver(&abituguru_driver);
}

MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
MODULE_DESCRIPTION("Abit uGuru Sensor device");
MODULE_LICENSE("GPL");

module_init(sm_abituguru_init);
module_exit(sm_abituguru_exit);
-------------- next part --------------
obj-m +=3D abituguru.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) clean
