From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 24 Jan 2006 15:18:58 +0000
Subject: [lm-sensors] Patch: abituguru driver version 1.1.1
Message-Id: <43D64562.1030205@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AD5940.1090900@hhs.nl>
In-Reply-To: <43AD5940.1090900@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Hans,

lm-sensors kernel patch: nobody cared!

I will try to review your work.
Here we go. Quite big driver. I will now give some remarks that are general=
 for the driver:

1) CodingStyle is sometimes different than what you did in a driver, typica=
lly no spaces between operators
2) we need dev_dbg dev_warn etc structures
3) history belongs to do documentation and cannot be acceptred in the drive=
r by mainline kernel folks
4) we need a "datasheet" for uGuru, something that Olle already wrote. Plea=
se extend it and make it part
   of documentation. It was very hard to read the driver without knowing wh=
at bank registers are doing
5) You should consider separating some arrays to structures or unions, it m=
akes very difficult to understand what is going on, when the names for
    referencies and actual values are similar.
6) Try to use some macros for repetitive code. (or for conversion of values=
, not neccessary for whole bunch of functions),
   it may happen that the macro will explain what the array magic reference=
 is doing ;)
7) sync to mainstream lm-sensors technology -> mutex stuff and maybe to ref=
lect the ISA and sysfs changes?
8) I think comments are important especially when there is no datasheet, pl=
ease can you add some? Like what for are those generic functions
   etc etc...

I did not review the userspace part. -ENOTIME. I already spent more than 3 =
hours on this and I really have to finish all stuff round my final
thesis. The review did not go to every single detail of the driver, it was =
simply too complicated to see what is done in some tricky parts.
When we are ready with kernel patch, you should add yourself as the maintai=
ner of this driver. Also you will be responsible for user support
of uGuru because YOU are the expert.

The alarms proposal sounds good to me, but I would like others here come up=
 with the comments.

Please check my comments in the driver.

I hope this helps.
regards
Rudolf


Hans de Goede wrote:
>=20
> obj-m +=3D abituguru.o
>=20
> all:
> 	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules
>=20
> clean:
> 	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) clean
>=20
>=20
> ------------------------------------------------------------------------
>=20
> /*
>     abituguru.c - Part of lm_sensors, Linux kernel modules
>                   for hardware monitoring
>=20
>     Copyright (c) 2005  Hans de Goede <j.w.r.degoede at hhs.nl>
>=20
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
>     the Free Software Foundation; either version 2 of the License, or
>     (at your option) any later version.
>=20
>     This program is distributed in the hope that it will be useful,
>     but WITHOUT ANY WARRANTY; without even the implied warranty of
>     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>     GNU General Public License for more details.
>=20
>     You should have received a copy of the GNU General Public License
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> */
> /*
>     This driver supports the sensor part of the custom Abit uGuru chip fo=
und
>     on Abit uGuru motherboards. Currently it has been tested on an Abit K=
V8
>     Pro, AV8, AX8 and AN8-SLI. The openguru program this driver is based =
on
>     has also been successfully tested on: Abit AV8 3rd Eye, AN8 Ultra and=
 AN7.
>    =20
>     Unfortunatly there are no specs for this chip, this driver is based o=
n the
>     (reverse enginered) openguru program by Olle Sandberg <ollebull at gm=
ail.com>.
>     You can find the first version of his program which only supports rea=
ding
>     the sensors not the min/max values at:
>     http://hem.bredband.net/b330708/oguru/oguru.tar.gz
>     I would like to express my thanks to Olle, this driver couldnot have =
been
>     written without his efforts.
>    =20
>     Because of the lack of specs only the sensors part of the uGuru is
>     supported. A word of caution to those who want to experiment and see =
if
>     they can figure the voltage / clock programming out, I tried reading =
and
>     only reading banks 0-0x30 with the reading code used for the sensor b=
anks
>     (0x20-0x28) and this resulted in a permanent reprogramming of the vol=
tages,
>     luckily I had the sensors part configured so that it would shutdown my
>     system on any out of spec voltages which proprably safed my computer =
(after
>     a reboot I managed to immediatly enter the bios and reload the defaul=
ts).
>     This probably means that the read/write cycle for the non sensor part=
 is
>     different from the sensor part.
>    =20
>     This driver used via686a.c as a skeleleton since that is an ISA only =
chip
>     like the Abit uGuru (AFAIK).

This info should go to Documentation/hwmon/uguru file. I asked Olle also fo=
r a one with
register set. Please can you move all info there and create there simple da=
tasheet?


> */
> /*  History:
>    =20
>     version 0.9:
>     -initial release, only reading the sensors is supported.
>     version 0.9.1:
>     -Olle has done some more reverse engineering, so now reading the min/=
max
>      values and the settings is also supported.
>     -modified the driver to work with the new hwmon seperation in 2.6.14,
>      As a result this version requires 2.6.14 or higher.
>     -simplified the ready code.
>     -added a abituguru_wait function which waits for the uguru the reach
>      a certain state, use this everywhere instead of having seperate loops
>      with there own timeouts scatered over the place.
>     -use array sysfs initalisation instead of #define hell.
>     -fix rounding of values.
>     version 0.9.2:
>     -Olle has now reverse engineered the writing of the flags and min/max
>      values, so now writing the min/max values is also supported.=20
>     -Now that we've seen testing of more mainboards, it turns out that
>      the way the volt inputs are hooked up isn't identical for all mainbo=
ards,
>      also causing the ranges for the volt inputs to be not constant. Beca=
use
>      of this conversion for the voltage sensors has been removed, the raw
>      register values are now returned. Sample entries for known mainboards
>      will be added to sensors.conf .
>     -During this testing, it has also been shown that certain addresses in
>      bank1 (0x0D) sometimes are attached to a temp sensor and sometimes t=
o a
>      volt sensor. Luckily with some tricks this can be detected, so now we
>      detect if a sensor is connected and what type for all addresses in b=
ank1.
>     version 0.9.3:
>     -userspace expects temp and in values to be in milli units, so they a=
re now
>      multiplied by 1000 in show and divided by 1000 on set.
>     -Now that the min/max values can be written I've been able to trigger=
 some
>      false alarms and have managed to find out how the alarms work, so now
>      reading the alarms is supported also.
>     version 0.9.4:
>     -reshuffle / cleanup (mainly bank1 handling)
>     -fix some race conditions
>     version 0.9.5:
>     -Reading/writing the settings (enable alarm, beep, shutdown) is now a=
lso
>      supported.
>     version 1.0.0:
>     -Added support for controling the fan PWM (speed control).
>     -Add force param to skip "detection" .
>     version 1.0.1:
>     -Set min/max values during volt sensor type detect a little more sane
>      (245 250 instead of 254 255), this seems to fix some detection issue=
s.
>     -Fixed a possible race where we could be called during bank1 sensor t=
ype
>      detection.
>     -Added debuging output all over the place since some testers are havi=
ng
>      trouble.
>     -Changed ABIT_UGURU_DEBUG define to ABIT_UGURU_DEBUG_LEVEL, which
>      controls the amount of debugging output instead of just turning debu=
gging
>      on/off.
>     version 1.0.2:
>     -2 users are reporting the following error:
>      abituguru: error: timeout exceeded waiting for more input state (ban=
k: 32)
>      This always happens with bank 32 (0x20 / alarm).
>      Raise the time out in abituguru_wait as an attempt to fix this.
>     -2 users are reporting the following error:
>      abituguru: error: CMD reg doesnot hold 0xAC after ready command
>      Change the code to wait a while for CMD reg to hold 0xAC instead of
>      reading and testing it only once as an attempt to fix this.
>     -1 user needs to use the force parameter at debugging output in case
>      the normal detect code fails to help improve the detect code.=20
>     version 1.0.3:
>     -Fix the detect issue (needs force param) 1 test-user was reporting.
>     -Raise number of tries before giving up when waiting for CMD to hold
>      0xAC after ready a little, this fixes the few remaining reports of:
>      abituguru: error: CMD reg doesnot hold 0xAC after ready command
>     version 1.1.0:
>     -One test-user with an AN7 is still reporting the following error:
>      abituguru: error: timeout exceeded waiting for more input state (ban=
k: 32)
>      Even with ridiciously high timeout (number of polls really) values t=
his
>      still happens occasionally. Here is a table of number of polls and
>      occurence frequency of the error:
>      polls:	error frequency:
>      250	6 / min (1 / 10 sec)
>      500	6 / min (1 / 10 sec)
>      5000	3 / min
>      50000	1 / min
>      As if this version of the uGuru does something internally every 10 s=
econds
>      which makes it unreachable for a while from the outside, making the
>      timeout longer makes the chance smaller that our try to reach it win=
dow
>      fully overlaps with its busy window. I've also had a report of this =
from
>      another test-user but with a much lower frequency.
>      All the changes below are mainly to cope with this behaviour of the =
uGuru.
>     -Add a retries parameter to abituguru_send_address and abituguru_read=
. With
>      this parameter the number of retries to try the send adres step caus=
ing
>      the problem can be specified, send_address will sleep before retryin=
g.
>     -Try reading of a value in abituguru_update_device once and if it tim=
es out
>      just keep the old value, instead of generating an error.
>     -Try all other reads and all writes multiple times.
>     -Count the number of timedout updates in abituguru_update_device, if =
this
>      passes a certain treshold only then make it an error.
>     -Don't update all the settings everytime in abituguru_update_device,
>      instead just read them once in our probe function, the used part of =
the
>      settings won't change unless we write them, in which case we know wh=
at
>      we've just written, so we still won't need to read them. This way we=
 know
>      we will always have a valid in memory copy of the settings, even tho=
ugh
>      abituguru_update_device no longer logs every read timeout as an erro=
r.
>      Note: This does mean that we do not have uptodate flags info in our =
in
>      memory copy of the settings, this is not a problem since the flags p=
art
>      of the settings are only used by abituguru_detect_sensor_type, which
>      does a read of the settings itself. BEWARE though, if we want to use=
 the
>      flags parts in the future in other places!
>      As a nice side effect this makes abituguru_update_device much faster
>      and generate a lot less ISA-IO cycles.
>     -I've also received one report of:
>      abituguru: error: state !=3D more input after ready command.
>      Change the code to wait a while for DATA reg to hold 0x08 instead of
>      reading and testing it only once as an attempt to fix this.
>     version 1.1.1:
>     -Show voltages ona 0-3493 mV scale instead of as a registervalue mult=
iplied
>      by 1000.
>     -Change all the sysfs stuff from struct sensor_device_attribute to
>      sensor_device_atribute_2 make settings array 2 dimensional as it oug=
ht to
>      be and use index and nr to address the settings array. Remove all the
>      glue functions for mask stuff and use attr->nr as mask.
>     -Split alarms_in in alarms_in_low and alarms_in_high, same
>      for alarms_mask_in.
>     -Undo 1.1.0 change of not reading the settings in abituguru_update for
>      bank1 settings, as the settings are needed to differentiate between =
low
>      and high alarms.
>     -Rename pwm sysfs files to match sysfs-interface file from the kernel
>      Documentation, rename mask files to match sysfs-interface-proposal.
> */

Kernel folks do not like this kind of history in the file because it tends =
to be outdated.
Maybe we can put it into a docs for a record?


> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/pci.h>
> #include <linux/jiffies.h>
> #include <linux/i2c.h>
> #include <linux/i2c-isa.h>
> #include <linux/hwmon.h>
> #include <linux/hwmon-sysfs.h>
> #include <linux/init.h>
> #include <asm/io.h>
>=20
> /* This is needed untill this gets merged upstream */
> #ifndef __SENSOR_DEVICE_ATTR2
> #define __SENSOR_DEVICE_ATTR2(_name,_mode,_show,_store,_index,_nr)	\
> {	.dev_attr =3D	__ATTR(_name,_mode,_show,_store),		\
> 	.index =3D	_index,						\
> 	.nr =3D		_nr						\
> }
> #endif
I think this is already there

> /* Debugging output level:
>    0 no debug output
>    1 log errors with printk
>    2 also log sensors type probing info
>    3 log retryable errors
>    This is at 2 for now, since this driver is still in the testing fase */
> #define ABIT_UGURU_DEBUG_LEVEL	2
> /* Banks */
> #define ABIT_UGURU_ALARM_BANK	0x20 /* 3 bytes, 2 bytes bank1, 1 byte bank=
2 */
> #define ABIT_UGURU_SENSOR_BANK1	0x21 /* volt and temp */
> #define ABIT_UGURU_FAN_PWM	0x24 /* 3x 5 bytes */
> #define ABIT_UGURU_SENSOR_BANK2	0x26 /* fans */
> /* uGuru sensor bank 1 flags */			     /* Alarm if: */
> #define ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE	0x01 /*  temp over warn */
> #define ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE	0x02 /*  volt over max */
> #define ABIT_UGURU_VOLT_LOW_ALARM_ENABLE	0x04 /*  volt under min */
> #define ABIT_UGURU_TEMP_HIGH_ALARM_FLAG		0x10 /* temp is over warn */
> #define ABIT_UGURU_VOLT_HIGH_ALARM_FLAG		0x20 /* volt is over max */
> #define ABIT_UGURU_VOLT_LOW_ALARM_FLAG		0x40 /* volt is under min */
> /* uGuru sensor bank 2 flags */			     /* Alarm if: */
> #define ABIT_UGURU_FAN_LOW_ALARM_ENABLE		0x01 /*   fan under min */
> /* uGuru sensor bank common flags */
> #define ABIT_UGURU_BEEP_ENABLE			0x08 /* beep if alarm */
> #define ABIT_UGURU_SHUTDOWN_ENABLE		0x80 /* shutdown if alarm */
> /* uGuru fan PWM (speed control) flags */
> #define ABIT_UGURU_FAN_PWM_ENABLE		0x80 /* enable speed control */
> /* Values used for conversion */
> #define ABIT_UGURU_FAN_MAX	15300 /* RPM */
> /* Bank1 sensor types */
> #define ABIT_UGURU_IN_SENSOR	0
> #define ABIT_UGURU_TEMP_SENSOR	1
> #define ABIT_UGURU_NC		2

I hope this are aligned to same tab.

> /* Timeouts / Retries, if these turn out to need a lot of fiddling we cou=
ld
>    convert them to params. */
> /* 250 was determined by trial and error, 200 works most of the time, but=
 not
>    always. I assume this is cpu-speed independent, since the ISA-bus and =
not
>    the CPU should be the bottleneck. Note that 250 sometimes is still not
>    enough (only reported on AN7 mb) this is handled by a higher layer. */
> #define ABIT_UGURU_WAIT_TIMEOUT 250
> /* Normally all expected status in abituguru_ready, are reported after the
>    first read, but sometimes not and we need to poll, 5 polls was not eno=
ugh
>    50 sofar is. */
> #define ABIT_UGURU_READY_TIMEOUT 50
> /* Maximum 3 retries on timedout reads/writes, delay 200 ms before retryi=
ng */
> #define ABIT_UGURU_MAX_RETRIES 3
> #define ABIT_UGURU_RETRY_DELAY (HZ/5)
> /* Maximum 2 timeouts in abituguru_update_device, iow 3 in a row is a err=
or */
> #define ABIT_UGURU_MAX_TIMEOUTS 2
>=20
> /* All the variables below are named identical to the oguru and oguru2 pr=
ograms
>    reverse engineered by Olle Sandberg, hence the names might not be 100%
>    logical. I could come up with better names, but I prefer keeping the n=
ames
>    identical so that this driver can be compared with his work more easil=
y. */
> /* Two i/o-ports are used by uGuru */
> #define ABIT_UGURU_BASE		0x00E0
> #define ABIT_UGURU_CMD		0x00 /* Used to tell uGuru what to read and to re=
ad the actual data */
> #define ABIT_UGURU_DATA		0x04 /* Mostly used to check if uGuru is busy */
> /* uGuru status' */
> #define ABIT_UGURU_STATUS_WRITE	0x00 /* Ready to be written */
> #define ABIT_UGURU_STATUS_READ	0x01 /* Ready to be read */
> #define ABIT_UGURU_STATUS_INPUT	0x08 /* More input */
> #define ABIT_UGURU_STATUS_READY	0x09 /* Ready to be written */
>=20
> /* Constants */
> /* in (Volt) sensors go up to 3494 mV, temp to 255000 milli degrees celci=
us */
> const int abituguru_bank1_max_value[2] =3D { 3494, 255000 };
> /* Register 0 is a bitfield, 1 and 2 are pwm settings (255 =3D 100%), 3 a=
nd 4
>    are temperature trip points. */
> const int abituguru_pwm_settings_multiplier[5] =3D { 0, 1, 1, 1000, 1000 =
};
>=20
> /* Insmod parameters */
> static int force;
> module_param(force, bool, 0);
> MODULE_PARM_DESC(force, "Set to one to force detection.");
>=20
> /* For the Abit uGuru, we need to keep some data in memory.
>    The structure is dynamically allocated, at the same time when a new
>    abituguru client is allocated. */
> struct abituguru_data {
> 	struct i2c_client client;
> 	struct class_device *class_dev;
> 	struct semaphore update_lock;

Recently was semaphore converted to Mutexes please can you do that too?

> 	char uguru_ready;	/* is the uguru in ready state? */
Why char? we have u8 u16... or enum...

> 	unsigned long last_updated;	/* In jiffies */
> 	char update_timeouts;	/* number of update timeouts since last
> 				   successfull update. */
here too..
> 	/* Bank 1 data */
> 	u8 bank1_sensors[2];	/* number of [0] in, [1] temp sensors */

It makes code quite hard to read with so many referencies. Why not a struct=
ure with two fields? Or some other construct
that has a name?

> 	u8 bank1_address[2][16];/* addresses of [0] in, [1] temp sensors */

Same here  bank1_addr[16].vaddr .taddr?

> 	u8 bank1_value[16];
> 	/* This array holds 16 x 3 entries for all the bank 1 sensor settings
> 	   (flags,min,max for voltage / flags,warn,shutdown for temp). */
> 	u8 bank1_settings[16][3];

Hmm why not the names?

> 	/* The sysfs attr for the bank1 sensors are generated automaticly */
> 	struct sensor_device_attribute_2 bank1_attr[16*3];
> 	/* Maximum value for each sensor used for scaling in mV/milli degrees
> 	   Celcius. */
> 	int bank1_max_value[16];
>=20
> 	/* Bank 2 data, the highest number of fans currently know to be
> 	   attached is 6, thus 6 entries for bank2 */
> 	u8 bank2_value[6];
> 	u8 bank2_settings[6][2]; /* flags, min */

Similar here

> 	/* Alarms 2 bytes for bank1, 1 byte for bank2 */
> 	u8 alarms[3];
> =09
> 	/* Fan PWM (speed control) 3x5 bytes */
> 	u8 pwm_settings[3][5];
> };
>=20
> static int abituguru_detect(struct i2c_adapter *adapter);
> static int abituguru_detach_client(struct i2c_client *client);
> static struct abituguru_data *abituguru_update_device(struct device *dev);
>=20
> /* wait till the uguru is in the specified state */
> static int abituguru_wait(struct i2c_client *client, u8 state)
> {
> 	int timeout =3D ABIT_UGURU_WAIT_TIMEOUT;
>=20
> 	while (inb_p(client->addr + ABIT_UGURU_DATA) !=3D state)

Even short udelay(10) is not needed here?

> 	{
> 		timeout--;
> 		if (timeout =3D 0)
> 			return -EBUSY;
> 	}
> 	return 0;
> }
>=20
> /* Put the uguru in ready for input state, this code assumes that
>    the uguru is not already in this state.
>    It is the callers responsibility to make sure it isn't! */
> static int abituguru_ready(struct i2c_client *client)
> {
> 	struct abituguru_data *data =3D i2c_get_clientdata(client);
> 	int timeout =3D ABIT_UGURU_READY_TIMEOUT;
>=20
> 	/* Reset? / Prepare for next read/write cycle */
> 	outb(0x00, client->addr + ABIT_UGURU_DATA);
>=20
> 	/* Wait till the uguru is ready */
> 	if (abituguru_wait(client, ABIT_UGURU_STATUS_READY)) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 		printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for ready=
 state\n");
Have you considered dev_dbg?
> #endif
> 		return -EIO;
> 	}
>=20
> 	/* Cmd port MUST be read now and should contain 0xAC */
> 	while (inb_p(client->addr + ABIT_UGURU_CMD) !=3D 0xAC) {
> 		timeout--;
> 		if (timeout =3D 0) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 			printk(KERN_DEBUG "abituguru: error: CMD reg doesnot hold 0xAC after r=
eady command\n");
does not (plus dev_dbg)
> #endif
> 			return -EIO;
> 		}
> 	}
>=20
> 	/* After this the ABIT_UGURU_DATA port should contain
> 	   ABIT_UGURU_STATUS_INPUT */
> 	while(inb_p(client->addr+ABIT_UGURU_DATA) !=3D ABIT_UGURU_STATUS_INPUT){
> 		timeout--;
> 		if (timeout =3D 0) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 			printk(KERN_DEBUG "abituguru: error: state !=3D more input after ready=
 command\n");
> #endif=09
dev_dbg
> 			return -EIO;
> 		}
> 	}
> =09

This three loops leads me to idea that perhaps some send_io_wait func could=
 be created, this is just an idea...

> 	data->uguru_ready =3D 1;
> 	return 0;
> }
>=20
> static int abituguru_send_address(struct i2c_client *client,
> 	u8 bank_addr, u8 sensor_addr, int retries)
> {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 	/* asume caller does errorhandling itself if it has not requested any
> 	   retries, and thus be quiet. */
> 	int report_errors =3D retries;
> #endif

hmm I dont like this

> 	struct abituguru_data *data =3D i2c_get_clientdata(client);
>=20
> 	for (;;) {
> 		/* The first try the uguru normally will be ready for the first
> 		   input and thus in ABIT_UGURU_STATUS_INPUT state. If however
> 		   something went wrong previously it might not be, so then we
> 		   try to force it into ready state.
> 		   If/when the uguru is ready we send the bank address,
> 		   after this the uguru is no longer "ready". */
> 		if (!data->uguru_ready && (abituguru_ready(client) !=3D 0))
> 			return -EIO;
> 		outb(bank_addr, client->addr + ABIT_UGURU_DATA);
> 		data->uguru_ready =3D 0;
>=20
> 		/* Wait till the uguru is ABIT_UGURU_STATUS_INPUT state again
> 		   and send the sensor addr */
> 		if (abituguru_wait(client, ABIT_UGURU_STATUS_INPUT)) {
> 			if (retries) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 3
> 				printk(KERN_DEBUG "abituguru: timeout exceeded waiting for more input=
 state, %d tries remaining\n", retries);
> #endif
> 				set_current_state(TASK_UNINTERRUPTIBLE);
> 				schedule_timeout(ABIT_UGURU_RETRY_DELAY);
> 				retries--;
> 				continue;
> 			} else {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 				if (report_errors)
> 					printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for mo=
re input state (bank: %d)\n", (int)bank_addr);
> #endif
> 				return -EBUSY;
> 			}
> 		}

What about to put the abitguru_wait to while cycle and get rid of the infin=
ite loop for?
Also maybe dev_dbg may be good.
> 		outb(sensor_addr, client->addr + ABIT_UGURU_CMD);
> 		return 0;
> 	}
> }
>=20
> static int abituguru_read(struct i2c_client *client,
> 	u8 bank_addr, u8 sensor_addr, u8 *buf, int count, int retries)
> {
> 	int err, bytes_read =3D 0;
> =09
> 	/* Send the address */
> 	err =3D abituguru_send_address(client, bank_addr, sensor_addr, retries);
> 	if (err)
> 		return err;
> =09
> 	/* And read the data */
> 	while(bytes_read < count) {
> 		if (abituguru_wait(client, ABIT_UGURU_STATUS_READ)) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 			printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for read=
 state (bank: %d, sensor: %d)\n", (int)bank_addr, (int)sensor_addr);
dev_dbg
> #endif
> 			break;
> 		}
> 		buf[bytes_read] =3D inb(client->addr + ABIT_UGURU_CMD);
> 		bytes_read++;
WHy not for cycle?
> 	}
>=20
> 	/* Last put the chip back in ready state */
> 	abituguru_ready(client);
>=20
> 	return bytes_read;
> }
>=20
> static int abituguru_write(struct i2c_client *client,
> 	u8 bank_addr, u8 sensor_addr, u8 *buf, int count)
> {
> 	int err, bytes_written =3D 0;
>=20
> 	/* Send the address */
> 	err =3D abituguru_send_address(client, bank_addr, sensor_addr,
> 		ABIT_UGURU_MAX_RETRIES);
> 	if (err)
> 		return err;
>=20
> 	/* And write the data */
> 	while(bytes_written < count) {
> 		if (abituguru_wait(client, ABIT_UGURU_STATUS_WRITE)) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 			printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for writ=
e state (bank: %d, sensor: %d)\n", (int)bank_addr, (int)sensor_addr);
dev_dbg
> #endif
> 			break;
> 		}
> 		outb(buf[bytes_written], client->addr + ABIT_UGURU_CMD);
> 		bytes_written++;
Well same here, I cannot see anything wrong why not to use for cycle
> 	}
> =09
> 	/* Now we need to wait till the chip is ready to be read again,
> 	   don't ask why */
> 	if (abituguru_wait(client, ABIT_UGURU_STATUS_READ)) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 		printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for read =
state after write (bank: %d, sensor: %d)\n", (int)bank_addr, (int)sensor_ad=
dr);
dev_dbg
> #endif
> 		return -EIO;
> 	}
> =09
> 	/* Cmd port MUST be read now and should contain 0xAC */
> 	if (inb_p(client->addr + ABIT_UGURU_CMD) !=3D 0xAC) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 		printk(KERN_DEBUG "abituguru: error: CMD reg doesnot hold 0xAC after wr=
ite (bank: %d, sensor: %d)\n", (int)bank_addr, (int)sensor_addr);
dev_dbg
> #endif
> 		return -EIO;
> 	}
> =09
> 	/* Last put the chip back in ready state */
> 	abituguru_ready(client);
>=20
> 	return bytes_written;
> }
>=20
> /* Detect sensor type. Temp and Volt sensors are enabled with
>    different masks and will ignore enable masks not meant for them.
>    This enables us to test what kindoff sensor we're dealing with.
>    By setting the alarm treshholds so that we will always get an
>    alarm for sensor type X and then enabling the sensor as sensor type
>    X, if we then get an alarm it is a sensor of type X. */
> static int abituguru_detect_sensor_type(struct i2c_client *client,
> 	u8 sensor_addr)
> {
> 	u8 buf[3];
> 	u8 val;
> 	int ret =3D ABIT_UGURU_NC;
> 	struct abituguru_data *data =3D i2c_get_clientdata(client);
> =09
> 	/* First read the sensor and the current settings */
> 	if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1, sensor_addr, &val,
> 	    1, ABIT_UGURU_MAX_RETRIES) !=3D 1)
		return -EIO;
The return must be on new line, on the other hand I'm not sure how to align=
 best the previous line,
Please check the CodingStyle

> =09
> 	/* Test val is sane / usable for sensor type detection. */
> 	if ((val < 10u) || (val > 240u)) {

Any strong reason why this needs to be in dec and not hex?

> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 		printk(KERN_DEBUG "abituguru: error: sensor: %d reading (%d) too close =
to limits to be able to determine sensor type\n", (int)sensor_addr, (int)va=
l);
dev_dbg
> #endif
> 		return -ERANGE;
> 	}
> 	=09
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 2
> 	printk(KERN_DEBUG "abituguru: testing bank1 sensor %d\n", sensor_addr);
dev_dbg
> #endif
> =09
> 	/* Volt sensor test, enable volt low alarm, set min value ridicously
> 	   high. If its a volt sensor this should always give us an alarm. */
> 	buf[0]=ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
> 	buf[1]$5;
> 	buf[2]%0;
> 	if (abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
> 		buf,3) !=3D 3)=09
		return -EIO;

> 	/* Now we need 20 ms to give the uguru time to read the sensors
> 	   and raise the alarm */
> 	set_current_state(TASK_UNINTERRUPTIBLE);
> 	schedule_timeout(HZ/50);

I think precise timeout is not possible with this. What about msleep? Maybe=
 you should also lock access (mutex
or semaphore, see Linux device drivers third edition as pdf) to the chip in=
 _read _write functions so no other
concurrect access to achip from different part of driver  could occur.

> 	/* Check for alarm and check the alarm is a volt low alarm. */
> 	if (abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0, buf, 3,
> 			ABIT_UGURU_MAX_RETRIES) !=3D 3)=09
		return -EIO;

> 	if (buf[sensor_addr/8] & (0x01<<(sensor_addr%8)) ) {
 Missing spaces buf[sensor_addr >> 3] & (1 << (sensor_addr & 0x7 )) should =
work without division

> 		if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1+1,
> 				sensor_addr,buf,3,ABIT_UGURU_MAX_RETRIES) !=3D 3)
> 			return -EIO;

Yes like this it could be ;)

> 		if (buf[0] & ABIT_UGURU_VOLT_LOW_ALARM_FLAG) {
> 			/* Restore original settings */
> 			if (abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2,
> 				sensor_addr, data->bank1_settings[sensor_addr],
> 				3) !=3D 3)	return -EIO;

indent
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 2
> 			printk(KERN_DEBUG "abituguru:  found volt sensor\n");
> 			return ABIT_UGURU_IN_SENSOR;
> 		} else
> 			printk(KERN_DEBUG "abituguru:  alarm raised during volt sensor test, b=
ut volt low flag not set\n");
> 	} else
> 		printk(KERN_DEBUG "abituguru:  alarm not raised during volt sensor test=
\n");
> #else
> 			return ABIT_UGURU_IN_SENSOR;
> 		}
> 	}
> #endif
>

Please remove this #if it makes code hard to read


> 	/* Temp sensor test, enable sensor as a temp sensor, set beep value
> 	   ridicously low (but not too low, otherwise uguru ignores it).
> 	   If its a temp sensor this should always give us an alarm. */
> 	buf[0]=ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE;
> 	buf[1]=3D5;
> 	buf[2]=10;
> 	if (abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
> 		buf,3) !=3D 3)=09
		return -EIO;

> 	/* Now we need 20 ms to give the uguru time to read the sensors
> 	   and raise the alarm */
> 	set_current_state(TASK_UNINTERRUPTIBLE);
> 	schedule_timeout(HZ/50);
same here
> 	/* Check for alarm and check the alarm is a temp high alarm. */
> 	if (abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0, buf, 3,
> 		ABIT_UGURU_MAX_RETRIES) !=3D 3)	return -EIO;
> 	if (buf[sensor_addr/8] & (0x01<<(sensor_addr%8)) ) {
this code can be laso changed but definetely there must be spaces

> 		if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1+1,
> 				sensor_addr,buf,3,ABIT_UGURU_MAX_RETRIES) !=3D 3)
> 			return -EIO;
> 		if (buf[0] & ABIT_UGURU_TEMP_HIGH_ALARM_FLAG) {
> 			ret =3D ABIT_UGURU_TEMP_SENSOR;
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 2
> 			printk(KERN_DEBUG "abituguru:  found temp sensor\n");
> 		} else
> 			printk(KERN_DEBUG "abituguru:  alarm raised during temp sensor test, b=
ut temp high flag not set\n");
> 	} else
> 		printk(KERN_DEBUG "abituguru:  alarm not raised during temp sensor test=
\n");
> #else
> 		}
> 	}
> #endif=09
here too
> 	/* Restore original settings */
> 	if (abituguru_write(client, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
> 		data->bank1_settings[sensor_addr], 3) !=3D 3)	return -EIO;
> =09
> 	return ret;
> }

My question is: Does it really work? If yes then wow :) If you change limit=
 will guru do something bad
to motherboard? Like cutting powerlines/CPU? Perhaps no...

> /* following are the sysfs callback functions */
> static ssize_t show_bank1_value(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D abituguru_update_device(dev);
> 	if (!data)
> 		return -EIO;
> 	return sprintf(buf, "%d\n", (data->bank1_value[attr->index]*
>                 data->bank1_max_value[attr->index] + 128) / 255);

/255 -> >>8

> }
>=20
> static ssize_t show_bank1_setting(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	return sprintf(buf,"%d\n",(data->bank1_settings[attr->index][attr->nr]*
> 		data->bank1_max_value[attr->index] + 128) / 255);
> }

> static ssize_t show_bank2_value(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D abituguru_update_device(dev);
> 	if (!data)
> 		return -EIO;
> 	return sprintf(buf, "%d\n",  (data->bank2_value[attr->index]*
> 		ABIT_UGURU_FAN_MAX + 128) / 255);
> }
>=20
> static ssize_t show_bank2_setting(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	return sprintf(buf,"%d\n",(data->bank2_settings[attr->index][attr->nr]*
> 		ABIT_UGURU_FAN_MAX + 128) / 255);
> }

Maybe some macro for repeated + 128 /255 ?

> static ssize_t store_bank1_setting(struct device *dev, struct device_attr=
ibute
> 	*devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	u8 val =3D (simple_strtoul(buf, NULL, 10)*255 +

 * 255 must be with spaces, also shifting 8 bits left should work too

> 		data->bank1_max_value[attr->index]/2) /
> 		data->bank1_max_value[attr->index];

Seems like scaling but quite confusing  /2

> 	ssize_t ret =3D count;
>=20
> 	down(&data->update_lock);
> 	if (data->bank1_settings[attr->index][attr->nr] !=3D val) {
> 		u8 orig_val =3D data->bank1_settings[attr->index][attr->nr];
> 		data->bank1_settings[attr->index][attr->nr] =3D val;
> 		if (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK1+2,
> 				attr->index, data->bank1_settings[attr->index],
> 				3) <=3D attr->nr) {
> 			data->bank1_settings[attr->index][attr->nr] =3D orig_val;
> 			ret =3D -EIO;
> 		}
> 	}=09
> 	up(&data->update_lock);

The data are preserved by the lock, so maybe you dont need the orig_val ?

> 	return ret;
> }
>=20
> static ssize_t store_bank2_setting(struct device *dev, struct device_attr=
ibute
> 	*devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	u8 val =3D (simple_strtoul(buf, NULL, 10)*255 + ABIT_UGURU_FAN_MAX/2) /
> 		ABIT_UGURU_FAN_MAX;
> 	ssize_t ret =3D count;
>=20
> 	down(&data->update_lock);
> 	if (data->bank2_settings[attr->index][attr->nr] !=3D val) {
> 		u8 orig_val =3D data->bank2_settings[attr->index][attr->nr];
> 		data->bank2_settings[attr->index][attr->nr] =3D val;
> 		if (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK2+2,
> 				attr->index, data->bank2_settings[attr->index],
> 				2) <=3D attr->nr) {
> 			data->bank2_settings[attr->index][attr->nr] =3D orig_val;
> 			ret =3D -EIO;
> 		}
> 	}
> 	up(&data->update_lock);
> 	return ret;
> }
>=20
> static ssize_t show_bank1_alarms(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D abituguru_update_device(dev);
> 	int i, alarms =3D 0;
> 	if (!data)
> 		return -EIO;
> 	for (i=3D0; i<data->bank1_sensors[attr->index]; i++) {

there should be always spaces between some operators, please consult the Co=
dingStyle file in kernel.

> 		u8 address =3D data->bank1_address[attr->index][i];
> 		if ( (data->alarms[address/8] & (0x01<<(address%8))) &&

1 << is enough. I think I commented already this kind of thing.

> 		     (data->bank1_settings[address][0] & attr->nr) )
> 			alarms |=3D 0x01 << i;
> 	}
> 	return sprintf(buf, "%d\n", alarms);
> }
>=20

This is hard to understand without addtional comments


> static ssize_t show_bank2_alarms(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct abituguru_data *data =3D abituguru_update_device(dev);
> 	if (!data)
> 		return -EIO;
> 	return sprintf(buf, "%d\n", (int)data->alarms[2]);
> }

Is this cast neccessary?

> static ssize_t show_bank1_mask(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int i, mask =3D 0;
> 	for (i=3D0; i<data->bank1_sensors[attr->index]; i++) {
> 		u8 address =3D data->bank1_address[attr->index][i];
> 		if (data->bank1_settings[address][0] & attr->nr)
> 			mask |=3D 0x01 << i;
1<< i
Maybe it should be unsigned?

> 	}
> 	return sprintf(buf, "%d\n", mask);
Maybe it should be unsigned?
> }
>=20
> static ssize_t show_bank2_mask(struct device *dev,
> 	struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int i, mask =3D 0;
> 	for (i=3D0; i<6; i++) {
> 		if (data->bank2_settings[i][0] & attr->nr)
> 			mask |=3D 0x01 << i;
> 	}
> 	return sprintf(buf, "%d\n", mask);
> }
>=20


Same here

> static ssize_t store_bank1_mask(struct device *dev,
> 	struct device_attribute *devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int i, mask =3D simple_strtoul(buf, NULL, 10);
> 	ssize_t ret =3D count;
>=20
> 	down(&data->update_lock);
> 	for (i=3D0; i<data->bank1_sensors[attr->index]; i++) {
> 		u8 address =3D data->bank1_address[attr->index][i];=20
> 		u8 orig_val =3D data->bank1_settings[address][0];
> 		if (mask&(0x01<<i))
> 			data->bank1_settings[address][0] |=3D attr->nr;
> 		else
> 			data->bank1_settings[address][0] &=3D ~attr->nr;
> 		if ( (data->bank1_settings[address][0] !=3D orig_val) &&
> 		     (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK1+2,
> 				address,data->bank1_settings[address],3)<1) ) {

Is this same value test everywhere?

> 			data->bank1_settings[address][0] =3D orig_val;
> 			ret =3D -EIO;
> 			break;
> 		}
> 	}
> 	up(&data->update_lock);
> 	return ret;
> }
>=20
> static ssize_t store_bank2_mask(struct device *dev,
> 	struct device_attribute *devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int i, mask =3D simple_strtoul(buf, NULL, 10);
> 	ssize_t ret =3D count;
>=20
> 	down(&data->update_lock);
> 	for (i=3D0; i<6; i++) {

maybe 6 should be #defined

> 		u8 orig_val =3D data->bank2_settings[i][0];
> 		if (mask&(0x01<<i))
> 			data->bank2_settings[i][0] |=3D attr->nr;
> 		else
> 			data->bank2_settings[i][0] &=3D ~attr->nr;
> 		if ( (data->bank2_settings[i][0] !=3D orig_val) &&
> 		     (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK2+2,
> 				i, data->bank2_settings[i], 2) < 1) ) {
> 			data->bank2_settings[i][0] =3D orig_val;
> 			ret =3D -EIO;
> 			break;
> 		}
> 	}
> 	up(&data->update_lock);
> 	return ret;
> }
>=20
> /* Fan PWM (speed control) */
> static ssize_t show_pwm_reg(struct device *dev,
>         struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	return sprintf(buf, "%d\n", data->pwm_settings[attr->index][attr->nr] *
> 		abituguru_pwm_settings_multiplier[attr->nr]);
> }
>        =20
> static ssize_t store_pwm_reg(struct device *dev, struct device_attribute
> 	*devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int val =3D (simple_strtoul(buf, NULL, 10) +
> 		abituguru_pwm_settings_multiplier[attr->nr]/2) /
> 		abituguru_pwm_settings_multiplier[attr->nr];

cannot be this scaling hidden is some macro that it will explain what is ha=
ppenning?

int val =3D SCALE_USER_INPUT(simple ... );

> 	ssize_t ret =3D count;
>=20
> 	down(&data->update_lock);
> 	if (data->pwm_settings[attr->index][attr->nr] !=3D val) {
> 		u8 orig_val =3D data->pwm_settings[attr->index][attr->nr];
> 		data->pwm_settings[attr->index][attr->nr] =3D val;
> 		if (abituguru_write(&data->client, ABIT_UGURU_FAN_PWM+1,
> 				attr->index, data->pwm_settings[attr->index],
> 				5) <=3D attr->nr) {
> 			data->pwm_settings[attr->index][attr->nr] > 				orig_val;
> 			ret =3D -EIO;
> 		}
> 	}=09
> 	up(&data->update_lock);
> 	return ret;
> }
>=20
> static ssize_t show_pwm_sensor(struct device *dev,
>         struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int i;
> 	/* We need to walk to the temp sensor addresses to find what
> 	   the userspace id of the configured temp sensor is. */
> 	for (i=3D0; i<data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR]; i++)
> 		if (data->bank1_address[ABIT_UGURU_TEMP_SENSOR][i] =3D
> 		    (data->pwm_settings[attr->index][0] & 0x0F))
> 			return sprintf(buf, "%d\n", i+1);
> 		=09
> 	return -ENXIO;
> }
>        =20
> static ssize_t store_pwm_sensor(struct device *dev, struct device_attribu=
te
> 	*devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	unsigned long val =3D simple_strtoul(buf, NULL, 10) - 1;
> 	ssize_t ret =3D count;
> =09
> 	down(&data->update_lock);
> 	if (val < data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR]) {
> 		u8 orig_val =3D data->pwm_settings[attr->index][0];
> 		u8 address =3D data->bank1_address[ABIT_UGURU_TEMP_SENSOR][val];
> 		data->pwm_settings[attr->index][0] &=3D 0xF0;
> 		data->pwm_settings[attr->index][0] |=3D address;
> 		if (data->pwm_settings[attr->index][0] !=3D orig_val) {
> 			if (abituguru_write(&data->client,ABIT_UGURU_FAN_PWM+1,
> 					attr->index,
> 					data->pwm_settings[attr->index], 5) <
> 					1) {
> 				data->pwm_settings[attr->index][0] =3D orig_val;
> 				ret =3D -EIO;
> 			}
> 		}
> 	}
> 	else
> 		ret =3D -EINVAL;
> 	up(&data->update_lock);
> 	return ret;
> }
>=20
> static ssize_t show_pwm_enable(struct device *dev,
>         struct device_attribute *devattr, char *buf)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	int res =3D 0;
> 	if (data->pwm_settings[attr->index][0] & ABIT_UGURU_FAN_PWM_ENABLE)
> 		res =3D 2;
> 	return sprintf(buf, "%d\n", res);
> }
>        =20
> static ssize_t store_pwm_enable(struct device *dev, struct device_attribu=
te
> 	*devattr, const char *buf, size_t count)
> {
> 	struct sensor_device_attribute_2 *attr =3D to_sensor_dev_attr_2(devattr);
> 	struct abituguru_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> 	u8 orig_val, user_val =3D simple_strtoul(buf, NULL, 10);
> 	ssize_t ret =3D count;
>=20
> 	down(&data->update_lock);
> 	orig_val =3D data->pwm_settings[attr->index][0];
> 	switch(user_val) {
> 		case 0:
> 			data->pwm_settings[attr->index][0] &>                                 =
~ABIT_UGURU_FAN_PWM_ENABLE; break;
> 		case 2:
> 			data->pwm_settings[attr->index][0] |>                                 =
ABIT_UGURU_FAN_PWM_ENABLE; break;
> 		default:
> 			ret =3D -EINVAL;
> 	}
> 	if ( (data->pwm_settings[attr->index][0] !=3D orig_val) &&
> 	     (abituguru_write(&data->client, ABIT_UGURU_FAN_PWM+1, attr->index,
> 			data->pwm_settings[attr->index], 5) < 1) ) {
> 		data->pwm_settings[attr->index][0] =3D orig_val;
> 		ret =3D -EIO;
> 	}
> 	up(&data->update_lock);
> 	return ret;
> }
>=20
> /* Sysfs attr, the entries for the temp and in sensors are missing, these=
 are
>    generated automaticly, because we don't know how many temp and in sens=
ors
>    there are in bank1, luckily we can probe the uguru to find out if a se=
nsor
>    is not connected, temp or in. */
> static struct sensor_device_attribute_2 abituguru_sysfs_attr[] =3D {
> 	__SENSOR_DEVICE_ATTR2(fan1_input, 0444, show_bank2_value, NULL, 0, 0),
> 	__SENSOR_DEVICE_ATTR2(fan2_input, 0444, show_bank2_value, NULL, 1, 0),
> 	__SENSOR_DEVICE_ATTR2(fan3_input, 0444, show_bank2_value, NULL, 2, 0),
> 	__SENSOR_DEVICE_ATTR2(fan4_input, 0444, show_bank2_value, NULL, 3, 0),
> 	__SENSOR_DEVICE_ATTR2(fan5_input, 0444, show_bank2_value, NULL, 4, 0),
> 	__SENSOR_DEVICE_ATTR2(fan6_input, 0444, show_bank2_value, NULL, 5, 0),
> 	__SENSOR_DEVICE_ATTR2(fan1_min,    0644, show_bank2_setting,
> 		store_bank2_setting, 0, 1),
> 	__SENSOR_DEVICE_ATTR2(fan2_min,    0644, show_bank2_setting,
> 		store_bank2_setting, 1, 1),
> 	__SENSOR_DEVICE_ATTR2(fan3_min,    0644, show_bank2_setting,
> 		store_bank2_setting, 2, 1),
> 	__SENSOR_DEVICE_ATTR2(fan4_min,    0644, show_bank2_setting,
> 		store_bank2_setting, 3, 1),
> 	__SENSOR_DEVICE_ATTR2(fan5_min,    0644, show_bank2_setting,
> 		store_bank2_setting, 4, 1),
> 	__SENSOR_DEVICE_ATTR2(fan6_min,    0644, show_bank2_setting,
> 		store_bank2_setting, 5, 1),
> 	__SENSOR_DEVICE_ATTR2(pwm1_enable             ,0644, show_pwm_enable,
> 		store_pwm_enable, 0, 0),
> 	__SENSOR_DEVICE_ATTR2(pwm2_enable             ,0644, show_pwm_enable,
> 		store_pwm_enable, 1, 0),
> 	__SENSOR_DEVICE_ATTR2(pwm3_enable             ,0644, show_pwm_enable,
> 		store_pwm_enable, 2, 0),
> 	__SENSOR_DEVICE_ATTR2(pwm1_auto_channels_temp ,0644, show_pwm_sensor,
> 		store_pwm_sensor, 0, 0),
> 	__SENSOR_DEVICE_ATTR2(pwm2_auto_channels_temp ,0644, show_pwm_sensor,
> 		store_pwm_sensor, 1, 0),
> 	__SENSOR_DEVICE_ATTR2(pwm3_auto_channels_temp ,0644, show_pwm_sensor,
> 		store_pwm_sensor, 2, 0),
> 	__SENSOR_DEVICE_ATTR2(pwm1_auto_point1_pwm,    0644, show_pwm_reg,
> 		store_pwm_reg, 0, 1),
> 	__SENSOR_DEVICE_ATTR2(pwm2_auto_point1_pwm,    0644, show_pwm_reg,
> 		store_pwm_reg, 1, 1),
> 	__SENSOR_DEVICE_ATTR2(pwm3_auto_point1_pwm,    0644, show_pwm_reg,
> 		store_pwm_reg, 2, 1),
> 	__SENSOR_DEVICE_ATTR2(pwm1_auto_point2_pwm,    0644, show_pwm_reg,
> 		store_pwm_reg, 0, 2),
> 	__SENSOR_DEVICE_ATTR2(pwm2_auto_point2_pwm,    0644, show_pwm_reg,
> 		store_pwm_reg, 1, 2),
> 	__SENSOR_DEVICE_ATTR2(pwm3_auto_point2_pwm,    0644, show_pwm_reg,
> 		store_pwm_reg, 2, 2),
> 	__SENSOR_DEVICE_ATTR2(pwm1_auto_point1_temp,   0644, show_pwm_reg,
> 		store_pwm_reg, 0, 3),
> 	__SENSOR_DEVICE_ATTR2(pwm2_auto_point1_temp,   0644, show_pwm_reg,
> 		store_pwm_reg, 1, 3),
> 	__SENSOR_DEVICE_ATTR2(pwm3_auto_point1_temp,   0644, show_pwm_reg,
> 		store_pwm_reg, 2, 3),
> 	__SENSOR_DEVICE_ATTR2(pwm1_auto_point2_temp,   0644, show_pwm_reg,
> 		store_pwm_reg, 0, 4),
> 	__SENSOR_DEVICE_ATTR2(pwm2_auto_point2_temp,   0644, show_pwm_reg,
> 		store_pwm_reg, 1, 4),
> 	__SENSOR_DEVICE_ATTR2(pwm3_auto_point2_temp,   0644, show_pwm_reg,
> 		store_pwm_reg, 2, 4),
> 	__SENSOR_DEVICE_ATTR2(alarms_in_low,  0444, show_bank1_alarms, NULL,
> 		ABIT_UGURU_IN_SENSOR,   ABIT_UGURU_VOLT_LOW_ALARM_FLAG),
> 	__SENSOR_DEVICE_ATTR2(alarms_in_high, 0444, show_bank1_alarms, NULL,
> 		ABIT_UGURU_IN_SENSOR,   ABIT_UGURU_VOLT_HIGH_ALARM_FLAG),
> 	__SENSOR_DEVICE_ATTR2(alarms_temp,    0444, show_bank1_alarms, NULL,
> 		ABIT_UGURU_TEMP_SENSOR, ABIT_UGURU_TEMP_HIGH_ALARM_FLAG),
> 	__SENSOR_DEVICE_ATTR2(alarms_fan,     0444, show_bank2_alarms,NULL,0,0),
> 	__SENSOR_DEVICE_ATTR2(alarms_mask_in_low,  0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_IN_SENSOR,
> 		ABIT_UGURU_VOLT_LOW_ALARM_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(alarms_mask_in_high, 0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_IN_SENSOR,
> 		ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(alarms_mask_temp,    0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_TEMP_SENSOR,
> 		ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(alarms_mask_fan,     0644, show_bank2_mask,
> 		store_bank2_mask, 0, ABIT_UGURU_FAN_LOW_ALARM_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(beep_mask_in,  0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_IN_SENSOR,
> 		ABIT_UGURU_BEEP_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(beep_mask_temp, 0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_TEMP_SENSOR,
> 		ABIT_UGURU_BEEP_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(beep_mask_fan,    0644, show_bank2_mask,
> 		store_bank2_mask, 0, ABIT_UGURU_BEEP_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(shutdown_mask_in,  0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_IN_SENSOR,
> 		ABIT_UGURU_SHUTDOWN_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(shutdown_mask_temp, 0644, show_bank1_mask,
> 		store_bank1_mask, ABIT_UGURU_TEMP_SENSOR,
> 		ABIT_UGURU_SHUTDOWN_ENABLE),
> 	__SENSOR_DEVICE_ATTR2(shutdown_mask_fan,    0644, show_bank2_mask,
> 		store_bank2_mask, 0, ABIT_UGURU_SHUTDOWN_ENABLE),
> };
>=20
> /* Const names for use in the dynamicly genererated in and temp sysfs att=
r,
>    16 is a bit over kill since there are know known mainboards with 16 in
>    or temp sensors, but better safe then sorry. */
> static const char * const abituguru_bank1_name[2][3*16] =3D { {
> 	"in0_input",	"in0_min",	"in0_max",
> 	"in1_input",	"in1_min",	"in1_max",
> 	"in2_input",	"in2_min",	"in2_max",
> 	"in3_input",	"in3_min",	"in3_max",
> 	"in4_input",	"in4_min",	"in4_max",
> 	"in5_input",	"in5_min",	"in5_max",
> 	"in6_input",	"in6_min",	"in6_max",
> 	"in7_input",	"in7_min",	"in7_max",
> 	"in8_input",	"in8_min",	"in8_max",
> 	"in9_input",	"in9_min",	"in9_max",
> 	"in10_input",	"in10_min",	"in10_max",
> 	"in11_input",	"in11_min",	"in11_max",
> 	"in12_input",	"in12_min",	"in12_max",
> 	"in13_input",	"in13_min",	"in13_max",
> 	"in14_input",	"in14_min",	"in14_max",
> 	"in15_input",	"in15_min",	"in15_max" }, {
> 	"temp1_input",	"temp1_max",	"temp1_max_hyst",
> 	"temp2_input",	"temp2_max",	"temp2_max_hyst",
> 	"temp3_input",	"temp3_max",	"temp3_max_hyst",
> 	"temp4_input",	"temp4_max",	"temp4_max_hyst",
> 	"temp5_input",	"temp5_max",	"temp5_max_hyst",
> 	"temp6_input",	"temp6_max",	"temp6_max_hyst",
> 	"temp7_input",	"temp7_max",	"temp7_max_hyst",
> 	"temp8_input",	"temp8_max",	"temp8_max_hyst",
> 	"temp9_input",	"temp9_max",	"temp9_max_hyst",
> 	"temp10_input",	"temp10_max",	"temp10_max_hyst",
> 	"temp11_input",	"temp11_max",	"temp11_max_hyst",
> 	"temp12_input",	"temp12_max",	"temp12_max_hyst",
> 	"temp13_input",	"temp13_max",	"temp13_max_hyst",
> 	"temp14_input",	"temp14_max",	"temp14_max_hyst",
> 	"temp15_input",	"temp15_max",	"temp15_max_hyst",
> 	"temp16_input",	"temp16_max",	"temp16_max_hyst" }
> };
>=20
>=20
> /* The driver. I choose to use type i2c_driver, as at is identical to both
>    smbus_driver and isa_driver, and clients could be of either kind */
> static struct i2c_driver abituguru_driver =3D {
> 	.owner		=3D THIS_MODULE,
> 	.name		=3D "abituguru",
> 	.id		=3D 0, /* This is optional */
> 	.flags		=3D I2C_DF_NOTIFY,
> 	.attach_adapter	=3D abituguru_detect,
> 	.detach_client	=3D abituguru_detach_client,
> };
>=20
> /* This is called when the module is loaded */
> static int abituguru_detect(struct i2c_adapter *adapter)
> {
> 	struct i2c_client *new_client;
> 	struct abituguru_data *data;
> 	int i,j,res,err =3D 0;
> 	const char client_name[] =3D "abituguru";
> 	/* El weirdo probe order, to keep the sysfs order identical to the
> 	   BIOS and window-appliction listing order. */
> 	const u8 probe_order[16] =3D { 0x00,0x01,0x03,0x04,0x0A,0x08,0x0E,0x02,
> 		0x09,0x06,0x05,0x0B,0x0F,0x0D,0x07,0x0C };
> 	u8 data_val, cmd_val;
>=20
> 	/* Make sure we are probing the ISA bus!!  */
> 	if (!i2c_is_isa_adapter(adapter)) {
> 		dev_err(&adapter->dev,
> 		"abituguru_detect called for an I2C bus adapter?!?\n");
> 		err =3D -ENODEV;
> 		goto ERROR0;
> 	}
>=20
> 	/* Reserve our 2 ISA addresses */
> 	if (!request_region(ABIT_UGURU_BASE+ABIT_UGURU_CMD, 1,
> 		abituguru_driver.name)) {
> 		dev_err(&adapter->dev, "ISA-address %x already in use!\n",
> 			ABIT_UGURU_BASE + ABIT_UGURU_CMD);
> 		err =3D -EBUSY;
> 		goto ERROR0;
> 	}
> 	if (!request_region(ABIT_UGURU_BASE+ABIT_UGURU_DATA, 1,
> 		abituguru_driver.name)) {
> 		dev_err(&adapter->dev, "ISA-address %x already in use!\n",
> 			ABIT_UGURU_BASE + ABIT_UGURU_DATA);
> 		err =3D -EBUSY;
> 		goto ERROR1;

Hmm why not to reserve all 0xe0 to 0xe4 ? when it decodes this two...

> 	}
>=20
> 	/* Malloc our data and initialise the static parts. */
> 	if (!(data =3D kmalloc(sizeof(struct abituguru_data), GFP_KERNEL))) {
> 		err =3D -ENOMEM;
> 		goto ERROR2;
> 	}
> 	memset(data, 0, sizeof(struct abituguru_data));
> 	new_client =3D &data->client;
> 	i2c_set_clientdata(new_client, data);
> 	new_client->addr =3D ABIT_UGURU_BASE;
> 	new_client->adapter =3D adapter;
> 	new_client->driver =3D &abituguru_driver;
> 	new_client->flags =3D 0;
> 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
> 	init_MUTEX(&data->update_lock);
>=20
> 	/* See if there is an uguru there. After a reboot uGuru will hold 0x00
> 	   at DATA and 0xAC, when this driver has already been loaded once
> 	   DATA will hold 0x08. For most uGuru's CMD will hold 0xAC in either
> 	   scenario but some will hold 0x00.
> 	   Some uGuru's initally hold 0x09 at DATA and will only hold 0x08
> 	   after reading CMD first, so CMD must be read first! */
> 	cmd_val  =3D inb_p(ABIT_UGURU_BASE + ABIT_UGURU_CMD);
> 	data_val =3D inb_p(ABIT_UGURU_BASE + ABIT_UGURU_DATA);
> 	if ( ((data_val =3D 0x00) || (data_val =3D 0x08)) &&
> 	     ((cmd_val  =3D 0x00) || (cmd_val  =3D 0xAC)) ) {
> 	     	/* Probably found uGuru, see if its ready */
> 		if (data_val =3D ABIT_UGURU_STATUS_INPUT)
> 			data->uguru_ready =3D 1;
> 	} else {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 2
> 		printk(KERN_DEBUG "abituguru: no Abit uGuru found, data =3D 0x%02X, cmd=
 =3D 0x%02X\n",
> 			(unsigned int)data_val, (unsigned int)cmd_val);
dev_dbg
> #endif
> 		if (!force) {
> 			/* No uGuru found */
> 			err =3D -ENODEV;
> 			goto ERROR3;
> 		} else
> 			printk(KERN_WARNING "abituguru: asuming Abit uGuru is present because =
of \"force\" parameter\n");
> 	}
> =09
> 	/* Completly read the uGuru this has 2 purposes:
> 	   -testread / see if one really is there.
> 	   -make an in memory copy of all the uguru settings for future use. */
> 	if (abituguru_read(new_client, ABIT_UGURU_ALARM_BANK, 0,
> 			data->alarms, 3, ABIT_UGURU_MAX_RETRIES) !=3D 3) {
> 		err =3D -ENODEV;
> 		goto ERROR3;
> 	}
> 	for (i =3D 0; i < 16; i++) {
> 		if (abituguru_read(new_client, ABIT_UGURU_SENSOR_BANK1, i,
> 				&data->bank1_value[i], 1,
> 				ABIT_UGURU_MAX_RETRIES) !=3D 1) {
> 			err =3D -ENODEV;
> 			goto ERROR3;
> 		}
> 		if (abituguru_read(new_client, ABIT_UGURU_SENSOR_BANK1+1, i,
> 				data->bank1_settings[i], 3,
> 				ABIT_UGURU_MAX_RETRIES) !=3D 3) {
> 			err =3D -ENODEV;
> 			goto ERROR3;
> 		}
> 	}
> 	for (i =3D 0; i < 6; i++) {
> 		if (abituguru_read(new_client, ABIT_UGURU_SENSOR_BANK2, i,
> 				&data->bank2_value[i], 1,
> 				ABIT_UGURU_MAX_RETRIES) !=3D 1) {
> 			err =3D -ENODEV;
> 			goto ERROR3;
> 		}
> 		if (abituguru_read(new_client, ABIT_UGURU_SENSOR_BANK2+1, i,
> 				data->bank2_settings[i], 2,
> 				ABIT_UGURU_MAX_RETRIES) !=3D 2) {
> 			err =3D -ENODEV;
> 			goto ERROR3;
> 		}
> 	}
> 	for (i =3D 0; i < 3; i++) {
> 		if (abituguru_read(new_client, ABIT_UGURU_FAN_PWM, i,
> 				data->pwm_settings[i], 5,
> 				ABIT_UGURU_MAX_RETRIES) !=3D 5) {
> 			err =3D -ENODEV;
> 			goto ERROR3;
> 		}
> 	}
> 	data->last_updated =3D jiffies;
> =09
> 	/* Detect sensor types for bank1 */
> 	for (i=3D0; i<16; i++) {
> 		data->bank1_attr[i*3   ].dev_attr.attr.mode  =3D 0444;
> 		data->bank1_attr[i*3   ].dev_attr.attr.owner =3D THIS_MODULE;
> 		data->bank1_attr[i*3   ].dev_attr.show  =3D show_bank1_value;
> 		data->bank1_attr[i*3   ].dev_attr.store =3D NULL;
> 		data->bank1_attr[i*3   ].index =3D probe_order[i];
> 		data->bank1_attr[i*3 +1].dev_attr.attr.mode  =3D 0644;
> 		data->bank1_attr[i*3 +1].dev_attr.attr.owner =3D THIS_MODULE;
> 		data->bank1_attr[i*3 +1].dev_attr.show  =3D show_bank1_setting;
> 		data->bank1_attr[i*3 +1].dev_attr.store =3D store_bank1_setting;
> 		data->bank1_attr[i*3 +1].index =3D probe_order[i];
> 		data->bank1_attr[i*3 +1].nr =3D 1;
> 		data->bank1_attr[i*3 +2].dev_attr.attr.mode  =3D 0644;
> 		data->bank1_attr[i*3 +2].dev_attr.attr.owner =3D THIS_MODULE;
> 		data->bank1_attr[i*3 +2].dev_attr.show  =3D show_bank1_setting;
> 		data->bank1_attr[i*3 +2].dev_attr.store =3D store_bank1_setting;
> 		data->bank1_attr[i*3 +2].index =3D probe_order[i];
> 		data->bank1_attr[i*3 +2].nr =3D 2;
> 	=09
> 		res =3D abituguru_detect_sensor_type(new_client, probe_order[i]);
> 		if (res < 0) {
> 			if (res =3D -ERANGE) {
> 				printk(KERN_WARNING "abituguru: couldnot determine sensor type for se=
nsorbank1 sensor %d, skipping sensor\n", probe_order[i]);
> 				continue;
> 			} else {
> 				err =3D -ENODEV;
> 				goto ERROR3;
> 			}
> 		}
> 		if (res !=3D ABIT_UGURU_NC) {
> 			for (j=3D0;j<3;j++)
> 				data->bank1_attr[i*3+j].dev_attr.attr.name > 					abituguru_bank1_nam=
e[res][
> 						data->bank1_sensors[res]*3+j];
> 			data->bank1_max_value[probe_order[i]] > 				abituguru_bank1_max_value[=
res];
> 			data->bank1_address[res][data->bank1_sensors[res]] > 				probe_order[i=
];
> 			data->bank1_sensors[res]++;
> 		}
> 	}
> 	printk(KERN_INFO "abituguru: found Abit uGuru\n");
>=20
> 	/* Tell the I2C layer a new client has arrived */
> 	if ((err =3D i2c_attach_client(new_client)))
> 		goto ERROR3;
>=20
> 	/* Register sysfs hooks */
> 	data->class_dev =3D hwmon_device_register(&new_client->dev);
> 	if (IS_ERR(data->class_dev)) {
> 		err =3D PTR_ERR(data->class_dev);
> 		goto ERROR4;
> 	}
> 	/* Sysfs hooks for bank1 */
> 	for (i=3D0; i<16; i++)
> 		if (data->bank1_attr[i*3].dev_attr.attr.name)
> 			for (j=3D0;j<3;j++)
> 				device_create_file(&new_client->dev,
> 					&data->bank1_attr[i*3+j].dev_attr);
> 	/* Fan,PWM and misc hooks */
> 	for (i=3D0; i<44; i++)
> 		device_create_file(&new_client->dev,
> 			&abituguru_sysfs_attr[i].dev_attr);
>=20
> 	return 0;
>=20
> ERROR4:
> 	if (i2c_detach_client(new_client))
> 		dev_err(&new_client->dev,
> 		"Client deregistration failed, client not detached.\n");
> ERROR3:
> 	kfree(data);
> ERROR2:
> 	release_region(ABIT_UGURU_BASE + ABIT_UGURU_DATA, 1);
> ERROR1:
> 	release_region(ABIT_UGURU_BASE + ABIT_UGURU_CMD, 1);
> ERROR0:
> 	return err;
> }
>=20
> static int abituguru_detach_client(struct i2c_client *client)
> {
> 	int err;
> 	struct abituguru_data *data =3D i2c_get_clientdata(client);
>=20
> 	hwmon_device_unregister(data->class_dev);
>=20
> 	if ((err =3D i2c_detach_client(client))) {
> 		dev_err(&client->dev,
> 		"Client deregistration failed, client not detached.\n");
> 		return err;
> 	}
>=20
> 	release_region(client->addr + ABIT_UGURU_DATA, 1);
> 	release_region(client->addr + ABIT_UGURU_CMD, 1);
> 	kfree(data);
>=20
> 	return 0;
> }
>=20
> static struct abituguru_data *abituguru_update_device(struct device *dev)
> {
> 	struct i2c_client *client =3D to_i2c_client(dev);
> 	struct abituguru_data *data =3D i2c_get_clientdata(client);
> 	int i, res=3D1; /* fake a successfull read if no update nescesarry. */
>=20
> 	down(&data->update_lock);
> 	if (time_after(jiffies, data->last_updated + HZ)) {
> 		data->last_updated =3D jiffies;
> 		if ((res =3D abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0,
> 				data->alarms, 3, 0)) !=3D 3)
> 			goto LEAVE_UPDATE;
> 		for (i =3D 0; i < 16; i++) {
> 			if ((res =3D abituguru_read(client,
> 					ABIT_UGURU_SENSOR_BANK1, i,
> 					&data->bank1_value[i], 1, 0)) !=3D 1)
> 				goto LEAVE_UPDATE;
> 			if ((res =3D abituguru_read(client,
> 					ABIT_UGURU_SENSOR_BANK1 + 1, i,
> 					data->bank1_settings[i],3,0)) !=3D 3)
> 				goto LEAVE_UPDATE;
> 		}
> 		for (i =3D 0; i < 6; i++)
> 			if ((res =3D abituguru_read(client,
> 					ABIT_UGURU_SENSOR_BANK2, i,
> 					&data->bank2_value[i], 1, 0)) !=3D 1)
> 				goto LEAVE_UPDATE;
> 		/* success! */
> 		data->update_timeouts =3D 0;
> 	}
> LEAVE_UPDATE:
> 	/* handle timeout condition */
> 	if (res =3D -EBUSY) {
> 		data->update_timeouts++;
> 		if (data->update_timeouts <=3D ABIT_UGURU_MAX_TIMEOUTS) {
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 3
> 			printk(KERN_DEBUG "abituguru: warning: timeout exceeded, will try agai=
n next update\n");
> #endif
> 			/* Just a timeout, fake a successfull read */
> 			res =3D 1;
> 		}
> #if ABIT_UGURU_DEBUG_LEVEL >=3D 1
> 		else
> 			printk(KERN_DEBUG "abituguru: error: timeout exceeded %d times waiting=
 for more input state\n", data->update_timeouts);
> #endif
> 	}
> 	up(&data->update_lock);
> 	if (res !=3D 1) {
> 		/* force the next update */
> 		data->last_updated =3D jiffies - (unsigned long)HZ;
> 		return NULL;
> 	} else
> 		return data;
> }
>=20
> static int __init sm_abituguru_init(void)
> {
> 	return i2c_isa_add_driver(&abituguru_driver);
> }
>=20
> static void __exit sm_abituguru_exit(void)
> {
> 	i2c_isa_del_driver(&abituguru_driver);
> }
>=20
> MODULE_AUTHOR("Hans de Goede <j.w.r.degoede at hhs.nl>");
> MODULE_DESCRIPTION("Abit uGuru Sensor device");
> MODULE_LICENSE("GPL");
>=20
> module_init(sm_abituguru_init);
> module_exit(sm_abituguru_exit);
>=20
>=20
> ------------------------------------------------------------------------
>=20
> --- lm_sensors2/etc/sensors.conf.eg.uguru	2005-12-12 23:24:27.000000000 +=
0100
> +++ lm_sensors2/etc/sensors.conf.eg	2005-12-19 16:47:11.000000000 +0100
> @@ -2524,3 +2524,116 @@
>     #set temp2_hyst  48
>     #set temp3_max   50
>     #set temp3_hyst  48
> +
> +
> +# Abit Uguru sensor part configuration.
> +# The Abit Uguru is relativly straight forward to configure.
> +# label statements:
> +# The voltage (in) temp and fan sensors are usualy in the same order as =
listed
> +# in the BIOS, but not always!
> +# compute statements:
> +# The temp and fan sensors don't need any compute statements. Most volta=
ge
> +# inputs are directly connected to the IC and thus don't need an compute=
 line
> +# because the 0-3494 mV voltage given by the kernel driver is correct. T=
he sen-
> +# sors for higher voltages however are connect through a divider and mea=
sure
> +# ranges of: 0-4361mV, 0-6248mV or 0-14510mV. Thus the measured voltages=
 must
> +# be multiplied by resp. 1.248, 1.788 or 4.153. 3.3 volt sources use the=
 1.248
> +# mutiplier, 5 volt the 1.788 and 12 volt the 4.153.
> +# set statements:
> +# The Abit BIOS sets reasonable treshholds and allows changing them, thus
> +# set statements may be ommited. The abituguru kernel driver does support
> +# them if you want to add them.
> +
> +# This part is common for all Abit uGuru motherboads currently known:
> +chip "abituguru-*"
> +
> +   label in0 "CPU Core Voltage"
> +   label in1 "DDR Voltage"
> +   label in2 "DDR VTT Voltage"
> +   label temp1 "CPU Temperature"
> +   label temp2 "SYS Temperature"
> +   label fan1 "CPU FAN Speed"
> +   label fan3 "SYS FAN Speed"
> +
> +# For Kv8Pro and AV8, this is enabled by default as this driver is
> +# developed and tested on a Kv8Pro, comment this if you don't have
> +# a Kv8Pro or AV8.
> +   label in3 "NB Voltage"
> +   label in4 "SB Voltage"
> +   label in5 "HyperTransport Voltage"
> +   label in6 "AGP VDDQ Voltage"
> +   label in7 "ATX +5V"
> +   compute in7 @*1.788 , @/1.788
> +   label in8 "ATX +3.3V"
> +   compute in8 @*1.248 , @/1.248
> +   label in9 "Standby Voltage (+5V)"
> +   compute in9 @*1.788 , @/1.788
> +   label in10 "3VDual Voltage"
> +   compute in10 @*1.248 , @/1.248
> +   label temp3 "PWM Temperature"
> +   ignore temp4
> +   label fan2 "NB FAN Speed"
> +   label fan4 "AUX1 FAN Speed"
> +   label fan5 "AUX2 FAN Speed"
> +   ignore fan6
> +
> +# For Aa7-Max and Ag7 uncomment this if you have one of these boards.
> +#   label in3 "ATX +12V"
> +#   compute in3 @*4.153 , @/4.153
> +#   label in4 "FSB VTT Voltage"
> +#   label in5 "NB Voltage"
> +#   label in6 "NB 2.5V Voltage"
> +#   label in7 "ATX +5V Voltage"
> +#   compute in7 @*1.788 , @/1.788
> +#   label in8 "ATX +3.3V Voltage"
> +#   compute in8 @*1.248 , @/1.248
> +#   label in9 "5VDual Voltage"
> +#   compute in9 @*1.788 , @/1.788
> +#   ignore in10
> +#   label temp3 "PWM1 Temperature"
> +#   label temp4 "PWM2 Temperature"
> +#   label fan2 "NB FAN Speed"
> +#   label fan4 "AUX1 FAN Speed"
> +#   label fan5 "AUX2 FAN Speed"
> +#   ignore fan6
> +
> +
> +# For AN8-SLI uncomment this if you have one of these boards.
> +#   label in3 "nForce4 Standby Voltage"
> +#   label in4 "CPU VDDA 2.5V Voltage"
> +#   label in5 "HyperTransport Voltage"
> +#   label in6 "nForce4 Voltage"
> +#   label in7 "ATX +5V"
> +#   compute in7 @*1.788 , @/1.788
> +#   label in8 "ATX +3.3V"
> +#   compute in8 @*1.248 , @/1.248
> +#   label in9 "ATX 5VSB Voltage"
> +#   compute in9 @*1.788 , @/1.788
> +#   label in10 "ATX +12V"
> +#   compute in10 @*4.153 , @/4.153
> +#   label temp3 "PWM Temperature"
> +#   ignore temp4
> +#   label fan2 "NF4 FAN Speed"
> +#   label fan4 "OTES1 FAN Speed"
> +#   label fan5 "OTES2 FAN Speed"
> +#   label fan6 "AUX FAN Speed"
> +
> +# For AX8 uncomment this if you have one of these boards.
> +#   label in3 "NB Voltage"
> +#   label in4 "SB Voltage"
> +#   label in5 "HyperTransport Voltage"
> +#   label in6 "ATX +5V"
> +#   compute in6 @*1.788 , @/1.788
> +#   label in7 "ATX +3.3V"
> +#   compute in7 @*1.248 , @/1.248
> +#   label in8 "Standby Voltage (+5V)"
> +#   compute in8 @*1.788 , @/1.788
> +#   label in9 "ATX +12V"
> +#   compute in9 @*4.153 , @/4.153
> +#   ignore in10
> +#   label temp3 "PWM Temperature"
> +#   ignore temp4
> +#   label fan2 "NB FAN Speed"
> +#   label fan4 "AUX FAN Speed"
> +#   ignore fan5
> +#   ignore fan6
> --- lm_sensors2/prog/sensors/chips.h.uguru	2005-12-12 23:24:27.000000000 =
+0100
> +++ lm_sensors2/prog/sensors/chips.h	2005-12-19 16:44:56.000000000 +0100
> @@ -71,5 +71,6 @@
>  extern void print_adm1031(const sensors_chip_name *name);
>  extern void print_smsc47b397(const sensors_chip_name *name);
>  extern void print_f71805f(const sensors_chip_name *name);
> +extern void print_abituguru(const sensors_chip_name *name);
> =20
>  #endif /* def PROG_SENSORS_CHIPS_H */
> --- lm_sensors2/prog/sensors/chips.c.uguru	2005-12-12 23:24:27.000000000 =
+0100
> +++ lm_sensors2/prog/sensors/chips.c	2005-12-19 16:44:56.000000000 +0100
> @@ -5838,6 +5838,139 @@
>    }
>  }
> =20
> +/* print_abituguru_in()
> + *   where in, in_min, and in_max are sensors feature IDs
> + */
> +static void print_abituguru_in(const sensors_chip_name *name, int alarm_=
low,
> +  int alarm_high, int in, int in_min, int in_max)
> +{
> +  char *label =3D NULL;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name,in,&label,&valid))
> +  {
> +    if (valid) {
> +      double cur, min, max;
> +      if (!sensors_get_feature(*name,in,&cur) &&
> +          !sensors_get_feature(*name,in_min,&min) &&
> +          !sensors_get_feature(*name,in_max,&max)) {
> +        print_label(label,23);
> +        printf("%+6.2f V (min %+6.2f V, max %+6.2f V)",
> +           cur, min, max);
> +        if (alarm_low || alarm_high) {
> +          printf(" ALARM (");
> +          if (alarm_low)
> +            printf("LOW");
> +          if (alarm_high)
> +            printf("%sHIGH",(alarm_low)?",":"");
> +          printf(")");
> +        }
> +        printf("\n");
> +      } else
> +        printf("ERROR: Can't get IN data! (0x%04x)\n", in);
> +    }
> +    free(label);
> +  }
> +}
> +
> +/* print_abituguru_temp()
> + * where temp, temp_max, and temp_hyst are sensors feature IDs
> + */
> +static void print_abituguru_temp(const sensors_chip_name *name, int alar=
m,
> +	int temp, int temp_max, int temp_hyst)
> +{
> +  char *label =3D NULL;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name,temp,&label,&valid)) {
> +    if (valid) {
> +      double cur, max, hyst;
> +      if (!sensors_get_feature(*name,temp,&cur) &&
> +          !sensors_get_feature(*name,temp_max,&max) &&
> +          !sensors_get_feature(*name,temp_hyst,&hyst)) {
> +        if (fahrenheit) {
> +          cur  =3D deg_ctof(cur);
> +          max  =3D deg_ctof(max);
> +          hyst =3D deg_ctof(hyst);
> +        }
> +        print_label(label,23);
> +	printf("%+6.0f%s (high %+5.0f%s, hyst %+5.0f%s) %s\n",
> +	    cur, degstr, max, degstr, hyst, degstr, alarm ? " ALARM" : "");
> +      } else
> +        printf("ERROR: Can't get TEMP data! (0x%04x)\n", temp);
> +    }
> +    free(label);
> +  }
> +}
> +
> +/* print_abituguru_fan()
> + *   where fan and fan_min are sensors feature IDs
> + */
> +static void print_abituguru_fan(const sensors_chip_name *name, int alarm,
> +	int fan, int fan_min)
> +{
> +  char *label =3D NULL;
> +  double cur, min;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name,fan,&label,&valid)) {
> +    if (valid) {
> +      if (!sensors_get_feature(*name,fan,&cur) &&
> +          !sensors_get_feature(*name,fan_min,&min)) {
> +        print_label(label,23);
> +        printf("%4.0f RPM (min %4.0f RPM)               %s\n",
> +          cur, min, alarm ? "ALARM" : "");
> +      } else
> +        printf("ERROR: Can't get FAN data! (0x%04x)\n", fan);
> +    }
> +    free(label);
> +  }
> +}
> +
> +void print_abituguru(const sensors_chip_name *name)
> +{
> +  int i, alarms_low =3D 0, alarms_high =3D 0;
> +  double cur;
> +
> +  if (!sensors_get_feature(*name,SENSORS_ABITUGURU_ALARMS_IN_LOW,&cur)) =

> +    alarms_low =3D cur + 0.5;
> +  else
> +    printf("ERROR: Can't get alarms_in_low data!\n");
> +
> +  if (!sensors_get_feature(*name,SENSORS_ABITUGURU_ALARMS_IN_HIGH,&cur))=
=20
> +    alarms_high =3D cur + 0.5;
> +  else
> +    printf("ERROR: Can't get alarms_in_high data!\n");
> +
> +  for (i=3D0;i<11;i++)
> +    print_abituguru_in(name, alarms_low & (1 << i), alarms_high & (1 << =
i),
> +      SENSORS_ABITUGURU_IN0 + i, SENSORS_ABITUGURU_IN0_MIN + i,
> +      SENSORS_ABITUGURU_IN0_MAX + i);
> +
> +  if (!sensors_get_feature(*name,SENSORS_ABITUGURU_ALARMS_TEMP,&cur))=20
> +    alarms_high =3D cur + 0.5;
> +  else {
> +    printf("ERROR: Can't get alarms_temp data!\n");
> +    alarms_high =3D 0;
> +  }
> +
> +  for (i=3D0;i<4;i++)
> +    print_abituguru_temp(name, alarms_high & (1 << i),
> +      SENSORS_ABITUGURU_TEMP1 + i, SENSORS_ABITUGURU_TEMP1_MAX + i,
> +      SENSORS_ABITUGURU_TEMP1_MAX_HYST + i);
> +
> +  if (!sensors_get_feature(*name,SENSORS_ABITUGURU_ALARMS_FAN,&cur))=20
> +    alarms_low =3D cur + 0.5;
> +  else {
> +    printf("ERROR: Can't get alarms_fan data!\n");
> +    alarms_low =3D 0;
> +  }
> +
> +  for (i=3D0;i<6;i++)
> +    print_abituguru_fan(name, alarms_low & (1<<i), SENSORS_ABITUGURU_FAN=
1 + i,
> +      SENSORS_ABITUGURU_FAN1_MIN + i);
> +}
> +
>  void print_unknown_chip(const sensors_chip_name *name)
>  {
>    int a,b,valid;
> --- lm_sensors2/prog/sensors/main.c.uguru	2005-12-12 23:24:27.000000000 +=
0100
> +++ lm_sensors2/prog/sensors/main.c	2005-12-19 16:44:56.000000000 +0100
> @@ -413,6 +413,7 @@
>  	{ "lm93", print_lm93 },
>  	{ "smsc47b397", print_smsc47b397 },
>  	{ "f71805f", print_f71805f },
> + 	{ "abituguru", print_abituguru },
>  	{ NULL, NULL }
>  };
> =20
> --- lm_sensors2/lib/chips.h.uguru	2005-12-12 23:24:27.000000000 +0100
> +++ lm_sensors2/lib/chips.h	2005-12-19 16:44:56.000000000 +0100
> @@ -2104,4 +2104,69 @@
>  #define SENSORS_F71805F_ALARMS_FAN	201
>  #define SENSORS_F71805F_ALARMS_TEMP	202
> =20
> +/* Abit uGuru chip */
> +#define SENSORS_ABITUGURU_PREFIX "abituguru"
> +
> +#define SENSORS_ABITUGURU_IN0			 1 /* R */
> +#define SENSORS_ABITUGURU_IN1			 2 /* R */
> +#define SENSORS_ABITUGURU_IN2			 3 /* R */
> +#define SENSORS_ABITUGURU_IN3			 4 /* R */
> +#define SENSORS_ABITUGURU_IN4			 5 /* R */
> +#define SENSORS_ABITUGURU_IN5			 6 /* R */
> +#define SENSORS_ABITUGURU_IN6			 7 /* R */
> +#define SENSORS_ABITUGURU_IN7			 8 /* R */
> +#define SENSORS_ABITUGURU_IN8			 9 /* R */
> +#define SENSORS_ABITUGURU_IN9			10 /* R */
> +#define SENSORS_ABITUGURU_IN10			11 /* R */
> +#define SENSORS_ABITUGURU_IN0_MIN		12 /* RW */
> +#define SENSORS_ABITUGURU_IN1_MIN		13 /* RW */
> +#define SENSORS_ABITUGURU_IN2_MIN		14 /* RW */
> +#define SENSORS_ABITUGURU_IN3_MIN		15 /* RW */
> +#define SENSORS_ABITUGURU_IN4_MIN		16 /* RW */
> +#define SENSORS_ABITUGURU_IN5_MIN		17 /* RW */
> +#define SENSORS_ABITUGURU_IN6_MIN		18 /* RW */
> +#define SENSORS_ABITUGURU_IN7_MIN		19 /* RW */
> +#define SENSORS_ABITUGURU_IN8_MIN		20 /* RW */
> +#define SENSORS_ABITUGURU_IN9_MIN		21 /* RW */
> +#define SENSORS_ABITUGURU_IN10_MIN		22 /* RW */
> +#define SENSORS_ABITUGURU_IN0_MAX		23 /* RW */
> +#define SENSORS_ABITUGURU_IN1_MAX		24 /* RW */
> +#define SENSORS_ABITUGURU_IN2_MAX		25 /* RW */
> +#define SENSORS_ABITUGURU_IN3_MAX		26 /* RW */
> +#define SENSORS_ABITUGURU_IN4_MAX		27 /* RW */
> +#define SENSORS_ABITUGURU_IN5_MAX		28 /* RW */
> +#define SENSORS_ABITUGURU_IN6_MAX		29 /* RW */
> +#define SENSORS_ABITUGURU_IN7_MAX		30 /* RW */
> +#define SENSORS_ABITUGURU_IN8_MAX		31 /* RW */
> +#define SENSORS_ABITUGURU_IN9_MAX		32 /* RW */
> +#define SENSORS_ABITUGURU_IN10_MAX		33 /* RW */
> +#define SENSORS_ABITUGURU_TEMP1			34 /* R */
> +#define SENSORS_ABITUGURU_TEMP2			35 /* R */
> +#define SENSORS_ABITUGURU_TEMP3			36 /* R */
> +#define SENSORS_ABITUGURU_TEMP4			37 /* R */
> +#define SENSORS_ABITUGURU_TEMP1_MAX		38 /* RW */
> +#define SENSORS_ABITUGURU_TEMP2_MAX		39 /* RW */
> +#define SENSORS_ABITUGURU_TEMP3_MAX		40 /* RW */
> +#define SENSORS_ABITUGURU_TEMP4_MAX		41 /* RW */
> +#define SENSORS_ABITUGURU_TEMP1_MAX_HYST	42 /* RW */
> +#define SENSORS_ABITUGURU_TEMP2_MAX_HYST	43 /* RW */
> +#define SENSORS_ABITUGURU_TEMP3_MAX_HYST	44 /* RW */
> +#define SENSORS_ABITUGURU_TEMP4_MAX_HYST	45 /* RW */
> +#define SENSORS_ABITUGURU_FAN1			46 /* R */
> +#define SENSORS_ABITUGURU_FAN2			47 /* R */
> +#define SENSORS_ABITUGURU_FAN3			48 /* R */
> +#define SENSORS_ABITUGURU_FAN4			49 /* R */
> +#define SENSORS_ABITUGURU_FAN5			50 /* R */
> +#define SENSORS_ABITUGURU_FAN6			51 /* R */
> +#define SENSORS_ABITUGURU_FAN1_MIN		52 /* RW */
> +#define SENSORS_ABITUGURU_FAN2_MIN		53 /* RW */
> +#define SENSORS_ABITUGURU_FAN3_MIN		54 /* RW */
> +#define SENSORS_ABITUGURU_FAN4_MIN		55 /* RW */
> +#define SENSORS_ABITUGURU_FAN5_MIN		56 /* RW */
> +#define SENSORS_ABITUGURU_FAN6_MIN		57 /* RW */
> +#define SENSORS_ABITUGURU_ALARMS_IN_LOW		58 /* R */
> +#define SENSORS_ABITUGURU_ALARMS_IN_HIGH	59 /* R */
> +#define SENSORS_ABITUGURU_ALARMS_TEMP		60 /* R */
> +#define SENSORS_ABITUGURU_ALARMS_FAN		61 /* R */
> +
>  #endif /* def LIB_SENSORS_CHIPS_H */
> --- lm_sensors2/lib/chips.c.uguru	2005-12-12 23:24:27.000000000 +0100
> +++ lm_sensors2/lib/chips.c	2005-12-19 16:44:56.000000000 +0100
> @@ -5549,6 +5549,68 @@
>  	{ 0 }
>  };
> =20
> +#define SENSORS_ABITUGURU_IN(nr) \
> +	{ SENSORS_ABITUGURU_IN##nr, "in" #nr, NOMAP, NOMAP, R, 0, \
> +		VALUE(3), 3 }, \
> +	{ SENSORS_ABITUGURU_IN##nr##_MIN, "in" #nr "_min", \
> +		SENSORS_ABITUGURU_IN##nr, SENSORS_ABITUGURU_IN##nr, RW, 0, \
> +		VALUE(1), 3 }, \
> +	{ SENSORS_ABITUGURU_IN##nr##_MAX, "in" #nr "_max", \
> +		SENSORS_ABITUGURU_IN##nr, SENSORS_ABITUGURU_IN##nr, RW, 0, \
> +		VALUE(2), 3 }
> +
> +#define SENSORS_ABITUGURU_TEMP(nr) \
> +	{ SENSORS_ABITUGURU_TEMP##nr, "temp" #nr, NOMAP, NOMAP, R, 0, \
> +		VALUE(3), 3 }, \
> +	{ SENSORS_ABITUGURU_TEMP##nr##_MAX, "temp" #nr "_max", \
> +		SENSORS_ABITUGURU_TEMP##nr, SENSORS_ABITUGURU_TEMP##nr, RW, 0, \
> +		VALUE(1), 3 }, \
> +	{ SENSORS_ABITUGURU_TEMP##nr##_MAX_HYST, "temp" #nr "_max_hyst", \
> +		SENSORS_ABITUGURU_TEMP##nr, SENSORS_ABITUGURU_TEMP##nr, RW, 0, \
> +		VALUE(2), 3 }
> +
> +#define SENSORS_ABITUGURU_FAN(nr) \
> +	{ SENSORS_ABITUGURU_FAN##nr, "fan" #nr, NOMAP, NOMAP, R, 0, \
> +		VALUE(2), 0 }, \
> +	{ SENSORS_ABITUGURU_FAN##nr##_MIN, "fan" #nr "_min", \
> +		SENSORS_ABITUGURU_FAN##nr, SENSORS_ABITUGURU_FAN##nr, RW, 0, \
> +		VALUE(1), 0 }
> +
> +static sensors_chip_feature abituguru_features[] > +{
> +	SENSORS_ABITUGURU_IN(0),
> +	SENSORS_ABITUGURU_IN(1),
> +	SENSORS_ABITUGURU_IN(2),
> +	SENSORS_ABITUGURU_IN(3),
> +	SENSORS_ABITUGURU_IN(4),
> +	SENSORS_ABITUGURU_IN(5),
> +	SENSORS_ABITUGURU_IN(6),
> +	SENSORS_ABITUGURU_IN(7),
> +	SENSORS_ABITUGURU_IN(8),
> +	SENSORS_ABITUGURU_IN(9),
> +	SENSORS_ABITUGURU_IN(10),
> +	SENSORS_ABITUGURU_TEMP(1),
> +	SENSORS_ABITUGURU_TEMP(2),
> +	SENSORS_ABITUGURU_TEMP(3),
> +	SENSORS_ABITUGURU_TEMP(4),
> +	SENSORS_ABITUGURU_FAN(1),
> +	SENSORS_ABITUGURU_FAN(2),
> +	SENSORS_ABITUGURU_FAN(3),
> +	SENSORS_ABITUGURU_FAN(4),
> +	SENSORS_ABITUGURU_FAN(5),
> +	SENSORS_ABITUGURU_FAN(6),
> +	{ SENSORS_ABITUGURU_ALARMS_IN_LOW,  "alarms_in_low",  NOMAP, NOMAP, R,
> +		0, VALUE(1), 0 },
> +	{ SENSORS_ABITUGURU_ALARMS_IN_HIGH, "alarms_in_high", NOMAP, NOMAP, R,
> +		0, VALUE(1), 0 },
> +	{ SENSORS_ABITUGURU_ALARMS_TEMP,    "alarms_temp",    NOMAP, NOMAP, R,
> +		0, VALUE(1), 0 },
> +	{ SENSORS_ABITUGURU_ALARMS_FAN,     "alarms_fan",     NOMAP, NOMAP, R,
> +		0, VALUE(1), 0 },
> +	{ 0 }
> +};
> +
> +
>  sensors_chip_features sensors_chip_features_list[] >  {
>   { SENSORS_LM78_PREFIX, lm78_features },
> @@ -5648,5 +5710,6 @@
>   { SENSORS_LM93_PREFIX, lm93_features },
>   { SENSORS_SMSC47B397_PREFIX, smsc47b397_features },
>   { SENSORS_F71805F_PREFIX, f71805f_features },
> + { SENSORS_ABITUGURU_PREFIX, abituguru_features },
>   { 0 }
>  };
>=20
>=20
> ------------------------------------------------------------------------
>=20
> Hi all,
>=20
> As you probably know I'm working on an Abit uGuru driver (nearly
> finished, just waiting on positive feedback on a fix for the last
> known bug).
>=20
> Since I want to submit the driver for review soon I took a look at
> linux-2.6.14//Documentation/hwmon/sysfs-interface, to make sure my driver
> fully follows the described interface. I noticed that some features my
> driver has aren't described and a couple of problems with described
> features. First there is the way alarms are supposed to be interfaced:
>=20
> ---
>=20
> alarms		Alarm bitmask.
> 		Read only.
> 		Integer representation of one to four bytes.
> 		A '1' bit means an alarm.
> 		Chips should be programmed for 'comparator' mode so that
> 		the alarm will 'come back' after you read the register
> 		if it is still valid.
> 		Generally a direct representation of a chip's internal
> 		alarm registers; there is no standard for the position
> 		of individual bits.
> 		Bits are defined in kernel/include/sensors.h.
>=20
> ---
>=20
> There are 2 problems with this:
> 1) kernel/include/sensors.h is generated from the 2.4 drivers, and
>    my uGuru driver is 2.6 only.
> 2) Its just plain ugly / wrong, userspace needing to know the masks
>    per chip is not nescesarry at all.
>=20
> I would like to propose the following interface instead, which
> uses an alarms file per sensor type with bit0 for the first sensor, bit1
> for the second sensor etc, that way all chips can be accessed
> consistently by userspace, without the need for any chip specific
> knowledge in userspace.
>=20
> ---
>=20
> alarms_in	In/Voltage Alarm bitmask.
> 		Read only.
> 		Integer representation of one to four bytes.
> 		A '1' bit means an alarm for the corresponding In/Voltage
> 		sensor. Bit 0 corresponds to in0, bit 1 to in1, etc.
> 		Chips should be programmed for 'comparator' mode so that
> 		the alarm will 'come back' after you read the register
> 		if it is still valid.
>=20
> alarms_in_low	Like alarms_in, but for chips which have seperate alarms
> alarms_in_high	for low Voltage and high Voltage conditions. Note that
> 		a chip can have either alarms_in or both alarms_in_low and
> 		alarms_in_high, but not all three.
>=20
> alarms_temp	Like alarms_in, but for Temp sensors, bit 0
> 		corresponds to temp1, bit 1 to temp2, etc.
>=20
> alarms_fan	Like alarms_in, but for Fan sensors, bit 0
> 		corresponds to fan1, bit 1 to fan2, etc.
>=20
>

Yes this seems good to me too. At least I cannot see any obstacle on first =
shot.

 ---
>=20
> The idea is to keep the old alarms file for older drivers for now,
> make libsensors work with both and then slowly convert all the chips
> drivers to the new sysfs-interface.
>=20
> Another problem of the current interface is the way in which it supports
> enabling / disabling beeping on alarm on a per sensor basis, this has the
> same problems as alarms:
>=20
> ---
>=20
> beep_mask	Bitmask for beep.
> 		Same format as 'alarms' with the same bit locations.
> 		Read/Write
>=20
> ---
>=20
> A shortcomming of the current sysfs-interface is that it does not support
> completly disabling alarms per sensor (so that they won't even show up in
> the alarms file) and enabling / disabling system shutdown on an alarm.
> Which are both features which are found in the uGuru and probably other
> chips. To correct this I would like to propose the following interface
> for per sensor settings like alarm-enable, beep on alarm and shutdown
> on alarm:
>=20
> ---
>=20
> alarms_mask_in	In/Voltage alarm enable bitmask.
> 		Read / Write.
> 		Integer representation of one to four bytes.
> 		A '1' bit means enable the alarm for the corresponding In/
> 		Voltage sensor. Bit0 corresponds to in0, bit1 to in1, etc.
>=20
> alarms_mask_in_low	Like alarms_mask_in, but for chips which have=20
> alarms_mask_in_high	seperately enableable alarms for low Voltage and
> 		high Voltage conditions. Note that a chip can have either
> 		alarms_mask_in or both alarms_mask_in_low and
> 		alarms_mask_in_high, but not all three.
>=20
> alarms_mask_temp	Like alarms_mask_in, but for Temp sensors, bit 0
> 		corresponds to temp1, bit 1 to temp2, etc.
>=20
> alarms_mask_fan	Like alarms_mask_in, but for Fan sensors, bit 0
> 		corresponds to fan1, bit 1 to fan2, etc.
>=20
>=20
> beep_mask_in	Enable Beep on In/Voltage alarm bitmask.
> 		Read / Write.
> 		Integer representation of one to four bytes.
> 		A '1' bit means enable beeping for the corresponding In/
> 		Voltage alarm. Bit0 corresponds to in0, bit1 to in1, etc.
>=20
> beep_mask_temp	Like beep_mask_in, but for Temp sensors, bit 0
> 		corresponds to temp1, bit 1 to temp2, etc.
>=20
> beep_mask_fan	Like beep_mask_in, but for Fan sensors, bit 0
> 		corresponds to fan1, bit 1 to fan2, etc.
>=20
>=20
> shutdown_mask_in	Enable Systemshutdown on In/Voltage alarm bitmask.
> 		Read / Write.
> 		Integer representation of one to four bytes.
> 		A '1' bit means enable shutdown for the corresponding In/
> 		Voltage alarm. Bit0 corresponds to in0, bit1 to in1, etc.
>=20
> shutdown_mask_temp	Like shutdown_mask_in, but for Temp sensors, bit 0
> 		corresponds to temp1, bit 1 to temp2, etc.
>=20
> shutdown_mask_fan	Like shutdown_mask_in, but for Fan sensors, bit 0
> 		corresponds to fan1, bit 1 to fan2, etc.
>=20

If #1 is OK then this should be OK too.



> ---
>=20
> The above is formulated as generic as possible, but is also based on a few
> Abit uGuru derived assumptions:
>=20
> -It is assumed that even if a chip has seperate in low/high alarms and
>  seperate enables for low/high alarm, that it has only one beep and
>  shutdown enable bit for both the low and high alarm at the same time.
> -It is assumed that chips can have seperate volt low/high alarms, but
>  that there are no chips with seperate temp high and temp critical alarms.

About the 2nd Jean should know better.


> Both assumptions can be "fixed" easily by following the alarms_in versus
> alarms_in_low/high way of doing thing.
>=20
> I hope that the above proposal after discussion and nescesarry
> modifications can be made the new sysfs interface with regards to alarms.

