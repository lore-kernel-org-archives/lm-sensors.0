From: andrei@mart.ck.ua (Andrei N.Sobchuck)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Request for driver
Message-Id: <400BE3AE.70300@mart.ck.ua>
List-Id: <lm-sensors.vger.kernel.org>
References: <4006AFFA.80500@mart.ck.ua>
In-Reply-To: <4006AFFA.80500@mart.ck.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>I've got the Elitgroup 865G-M motherboard.
>>sensors-detect shows that it use Winbond W83637HF Super IO Sensors.
>>But seems, at now there is no plan to support it yet.
>=20
>=20
> No plan yet, as you guessed. But a data sheet is available from Winbond
> [1] and the chip doesn't seem to be too different from the W83627HF, so
> it should be possible to either write a new driver using w83627hf as a
> template, or even add support for the W83637HF chip to the existing
> driver.
>=20
> Let us know if you start something, so that we can add it on our page
> and give you the contact information of a potential tester.

I'm sorry but I'm not a system programmer. I even not a C programmer.
I've done few modification of w83627hf.c file (see attacment). So,
at now, I can load w83627hf.o module. I even see some "files" under=20
/proc/.../sensors/:
# ls /proc/sys/dev/sensors/w83637hf-isa-0290/
alarms  fan1  fan3     in0  in2  in4  in6  in8   pwm2     sensor2  temp1=20
  temp3  vrm
beep    fan2  fan_div  in1  in3  in5  in7  pwm1  sensor1  sensor3  temp2=20
  vid

But I see no output from "sensors" command (I've copied a section in
sensors.conf from w83627hf section) and "sensors -s" produces errors:
# sensors
w83637hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
# sensors -s
Error: Line 1862: Unknown feature name
..

So, I can be helpful only as a tester.

> [1] http://www.winbond.com/e-winbondhtm/partner/PDFresult.asp?Pname=886

Thank you for the answer.

--=20
Andrei N.Sobchuck
JabberID: andreis@jabber.ru. ICQ UIN: 46466235.
-------------- next part --------------
/*
    w83627hf.c - Part of lm_sensors, Linux kernel modules for hardware
                monitoring
    Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
    Philip Edelbrock <phil@netroedge.com>,
    and Mark Studebaker <mdsxyz123@yahoo.com>

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
    Supports following chips:

    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
    w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
    w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)

    For other winbond chips, and for i2c support in the above chips,
    use w83781d.c.

    Note: automatic ("cruise") fan control for 697 & 627thf not supported y=
et.
*/

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/proc_fs.h>
#include <linux/ioport.h>
#include <linux/sysctl.h>
#include <linux/types.h>
#include <linux/i2c.h>
#include <linux/i2c-proc.h>
#include <linux/init.h>
#include <asm/errno.h>
#include <asm/io.h>
#include "version.h"
#include "sensors_vid.h"
#include "lm75.h"

static int force_addr;
MODULE_PARM(force_addr, "i");
MODULE_PARM_DESC(force_addr,
		 "Initialize the base address of the sensors");
static int force_i2c =3D 0x1f;
MODULE_PARM(force_i2c, "i");
MODULE_PARM_DESC(force_i2c,
		 "Initialize the i2c address of the sensors");

/* Addresses to scan */
static unsigned short normal_i2c[] =3D { SENSORS_I2C_END };
static unsigned short normal_i2c_range[] =3D { SENSORS_I2C_END };
static unsigned int normal_isa[] =3D { 0, SENSORS_ISA_END };
static unsigned int normal_isa_range[] =3D { SENSORS_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_4(w83627hf, w83627thf, w83697hf,w83637hf);

static int init =3D 1;
MODULE_PARM(init, "i");
MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");

/* modified from kernel/include/traps.c */
#define	REG	0x2e	/* The register to read/write */
#define	DEV	0x07	/* Register: Logical device select */
#define	VAL	0x2f	/* The value to read/write */

/* logical device numbers for superio_select (below) */
#define W83627HF_LD_FDC		0x00
#define W83627HF_LD_PRT		0x01
#define W83627HF_LD_UART1	0x02
#define W83627HF_LD_UART2	0x03
#define W83627HF_LD_KBC		0x05
#define W83627HF_LD_CIR		0x06 /* w83627hf only */
#define W83627HF_LD_GAME	0x07
#define W83627HF_LD_MIDI	0x07
#define W83627HF_LD_GPIO1	0x07
#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
#define W83627HF_LD_GPIO2	0x08
#define W83627HF_LD_GPIO3	0x09
#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
#define W83627HF_LD_ACPI	0x0a
#define W83627HF_LD_HWM		0x0b

#define	DEVID	0x20	/* Register: Device ID */

#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
#define W83627THF_GPIO5_INVR	0xf5 /* w83627thf only */

static inline void
superio_outb(int reg, int val)
{
	outb(reg, REG);
	outb(val, VAL);
}

static inline int
superio_inb(int reg)
{
	outb(reg, REG);
	return inb(VAL);
}

static inline void
superio_select(int ld)
{
	outb(DEV, REG);
	outb(ld, VAL);
}

static inline void
superio_enter(void)
{
	outb(0x87, REG);
	outb(0x87, REG);
}

static inline void
superio_exit(void)
{
	outb(0xAA, REG);
}

#define W627_DEVID 0x52
#define W637_DEVID 0x70
#define W627THF_DEVID 0x82
#define W697_DEVID 0x60
#define WINB_ACT_REG 0x30
#define WINB_BASE_REG 0x60
/* Constants specified below */

/* Length of ISA address segment */
#define WINB_EXTENT 8

/* Where are the ISA address/data registers relative to the base address */
#define W83781D_ADDR_REG_OFFSET 5
#define W83781D_DATA_REG_OFFSET 6

/* The W83781D registers */
/* The W83782D registers for nr=3D7,8 are in bank 5 */
#define W83781D_REG_IN_MAX(nr) ((nr < 7) ? (0x2b + (nr) * 2) : \
					   (0x554 + (((nr) - 7) * 2)))
#define W83781D_REG_IN_MIN(nr) ((nr < 7) ? (0x2c + (nr) * 2) : \
					   (0x555 + (((nr) - 7) * 2)))
#define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
					   (0x550 + (nr) - 7))

#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
#define W83781D_REG_FAN(nr) (0x27 + (nr))

#define W83781D_REG_TEMP2 0x0150
#define W83781D_REG_TEMP3 0x0250
#define W83781D_REG_TEMP2_HYST 0x153
#define W83781D_REG_TEMP3_HYST 0x253
#define W83781D_REG_TEMP2_CONFIG 0x152
#define W83781D_REG_TEMP3_CONFIG 0x252
#define W83781D_REG_TEMP2_OVER 0x155
#define W83781D_REG_TEMP3_OVER 0x255

#define W83781D_REG_TEMP 0x27
#define W83781D_REG_TEMP_OVER 0x39
#define W83781D_REG_TEMP_HYST 0x3A
#define W83781D_REG_BANK 0x4E

#define W83781D_REG_CONFIG 0x40
#define W83781D_REG_ALARM1 0x41
#define W83781D_REG_ALARM2 0x42
#define W83781D_REG_ALARM3 0x450

#define W83781D_REG_IRQ 0x4C
#define W83781D_REG_BEEP_CONFIG 0x4D
#define W83781D_REG_BEEP_INTS1 0x56
#define W83781D_REG_BEEP_INTS2 0x57
#define W83781D_REG_BEEP_INTS3 0x453

#define W83781D_REG_VID_FANDIV 0x47

#define W83781D_REG_CHIPID 0x49
#define W83781D_REG_WCHIPID 0x58
#define W83781D_REG_CHIPMAN 0x4F
#define W83781D_REG_PIN 0x4B

#define W83781D_REG_VBAT 0x5D

#define W83781D_REG_PWM1 0x5B	/* 782d and 783s/627hf datasheets disagree */
				/* on which is which; */
#define W83781D_REG_PWM2 0x5A	/* We follow the 782d convention here, */
				/* However 782d is probably wrong. */
#define W83781D_REG_PWMCLK12 0x5C

#define W83697HF_REG_PWMCLK1		0x00
#define W83627THF_REG_PWM1		0x01	/* 697HF too */
#define W83697HF_REG_PWMCLK2		0x02
#define W83627THF_REG_PWM2		0x03	/* 697HF too */
#define W83627THF_REG_PWM3		0x11
#define W83627HF_REG_VRM_OVT_CFG 	0x18	/* w83627thf only */

static const u8 regpwm[] =3D { W83781D_REG_PWM1, W83781D_REG_PWM2 };
static const u8 regpwm_thf[] =3D { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
                                 W83627THF_REG_PWM3 };
#define W836X7HF_REG_PWM(type, nr) (((type) =3D w83627hf) ? \
                                     regpwm[(nr) - 1] : regpwm_thf[(nr) - 1=
])

#define W83781D_REG_I2C_ADDR 0x48
#define W83781D_REG_I2C_SUBADDR 0x4A

/* The following are undocumented in the data sheets however we
   received the information in an email from Winbond tech support */
/* Sensor selection - not on 781d */
#define W83781D_REG_SCFG1 0x5D
static const u8 BIT_SCFG1[] =3D { 0x02, 0x04, 0x08 };
#define W83781D_REG_SCFG2 0x59
static const u8 BIT_SCFG2[] =3D { 0x10, 0x20, 0x40 };
#define W83781D_DEFAULT_BETA 3435

/* Conversions. Limit checking is only done on the TO_REG
   variants. Note that you should be a bit careful with which arguments
   these macros are called: arguments may be evaluated more than once.
   Fixing this is just not worth it. */
#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
#define IN_FROM_REG(val) (((val) * 16 + 5) / 10)

static inline u8 FAN_TO_REG(long rpm, int div)
{
	if (rpm =3D 0)
		return 255;
	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);
	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
			     254);
}

#define TEMP_MIN (-1280)
#define TEMP_MAX ( 1270)

/* TEMP: 1/10 degrees C (-128C to +127C)
   REG: 1C/bit, two's complement */
static u8 TEMP_TO_REG(int temp)
{
        int ntemp =3D SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
        ntemp +=3D (ntemp<0 ? -5 : 5);
        return (u8)(ntemp / 10);
}
                                                                           =
    =20
static int TEMP_FROM_REG(u8 reg)
{
        return (s8)reg * 10;
}

#define FAN_FROM_REG(val,div) ((val)=3D0?-1:(val)=3D255?0:1350000/((val)*(d=
iv)))

#define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
#define BEEPS_TO_REG(val) ((val) & 0xffffff)

#define BEEP_ENABLE_TO_REG(val)   ((val)?1:0)
#define BEEP_ENABLE_FROM_REG(val) ((val)?1:0)

#define DIV_FROM_REG(val) (1 << (val))

static inline u8 DIV_TO_REG(long val)
{
	int i;
	val =3D SENSORS_LIMIT(val, 1, 128) >> 1;
	for (i =3D 0; i < 6; i++) {
		if (val =3D 0)
			break;
		val >>=3D 1;
	}
	return ((u8) i);
}

/* There are some complications in a module like this. First off, W83781D c=
hips
   may be both present on the SMBus and the ISA bus, and we have to handle
   those cases separately at some places. Second, there might be several
   W83781D chips available (well, actually, that is probably never done; but
   it is a clean illustration of how to handle a case like that). Finally,
   a specific chip may be attached to *both* ISA and SMBus, and we would
   not like to detect it double. Fortunately, in the case of the W83781D at
   least, a register tells us what SMBus address we are on, so that helps
   a bit - except if there could be more than one SMBus. Groan. No solution
   for this yet. */

/* This module may seem overly long and complicated. In fact, it is not so
   bad. Quite a lot of bookkeeping is done. A real driver can often cut
   some corners. */

/* For each registered W83781D, we need to keep some data in memory. That
   data is pointed to by w83627hf_list[NR]->data. The structure itself is
   dynamically allocated, at the same time when a new w83627hf client is
   allocated. */
struct w83627hf_data {
	struct semaphore lock;
	int sysctl_id;
	enum chips type;

	struct semaphore update_lock;
	char valid;		/* !=3D0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */

	struct i2c_client *lm75;	/* for secondary I2C addresses */
	/* pointer to array of 2 subclients */

	u8 in[9];		/* Register value - 8 & 9 for 782D only */
	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */
	u8 in_min[9];		/* Register value - 8 & 9 for 782D only */
	u8 fan[3];		/* Register value */
	u8 fan_min[3];		/* Register value */
	u8 temp;
	u8 temp_over;		/* Register value */
	u8 temp_hyst;		/* Register value */
	u16 temp_add[2];	/* Register value */
	u16 temp_add_over[2];	/* Register value */
	u16 temp_add_hyst[2];	/* Register value */
	u8 fan_div[3];		/* Register encoding, shifted right */
	u8 vid;			/* Register encoding, combined */
	u32 alarms;		/* Register encoding, combined */
	u32 beeps;		/* Register encoding, combined */
	u8 beep_enable;		/* Boolean */
	u8 pwm[3];		/* Register value */
	u8 pwmenable[3];	/* bool */
	u16 sens[3];		/* 782D/783S only.
				   1 =3D pentium diode; 2 =3D 3904 diode;
				   3000-5000 =3D thermistor beta.
				   Default =3D 3435.=20
				   Other Betas unimplemented */
	u8 vrm;
};


static int w83627hf_attach_adapter(struct i2c_adapter *adapter);
static int w83627hf_detect(struct i2c_adapter *adapter, int address,
			  unsigned short flags, int kind);
static int w83627hf_detach_client(struct i2c_client *client);

static int w83627hf_read_value(struct i2c_client *client, u16 register);
static int w83627hf_write_value(struct i2c_client *client, u16 register,
			       u16 value);
static void w83627hf_update_client(struct i2c_client *client);
static void w83627hf_init_client(struct i2c_client *client);


static void w83627hf_in(struct i2c_client *client, int operation,
		       int ctl_name, int *nrels_mag, long *results);
static void w83627hf_fan(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void w83627hf_temp(struct i2c_client *client, int operation,
			 int ctl_name, int *nrels_mag, long *results);
static void w83627hf_temp_add(struct i2c_client *client, int operation,
			     int ctl_name, int *nrels_mag, long *results);
static void w83627hf_vid(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void w83627hf_vrm(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void w83627hf_alarms(struct i2c_client *client, int operation,
			   int ctl_name, int *nrels_mag, long *results);
static void w83627hf_beep(struct i2c_client *client, int operation,
			 int ctl_name, int *nrels_mag, long *results);
static void w83627hf_fan_div(struct i2c_client *client, int operation,
			    int ctl_name, int *nrels_mag, long *results);
static void w83627hf_pwm(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void w83627hf_sens(struct i2c_client *client, int operation,
			 int ctl_name, int *nrels_mag, long *results);

static int w83627hf_id =3D 0;

static struct i2c_driver w83627hf_driver =3D {
	.owner		=3D THIS_MODULE,
	.name		=3D "W83781D sensor driver",
	.id		=3D I2C_DRIVERID_W83627HF,
	.flags		=3D I2C_DF_NOTIFY,
	.attach_adapter	=3D w83627hf_attach_adapter,
	.detach_client	=3D w83627hf_detach_client,
};

/* The /proc/sys entries */
/* WARNING these are copied from w83781d.c and have not been renamed.
   Note that the 627hf and 697hf are supported by both drivers.
   Do not make incompatible changes here or we will have errors
   in the generated file ../include/sensors.h !!!
*/
/* -- SENSORS SYSCTL START -- */

#define W83781D_SYSCTL_IN0 1000	/* Volts * 100 */
#define W83781D_SYSCTL_IN1 1001
#define W83781D_SYSCTL_IN2 1002
#define W83781D_SYSCTL_IN3 1003
#define W83781D_SYSCTL_IN4 1004
#define W83781D_SYSCTL_IN5 1005
#define W83781D_SYSCTL_IN6 1006
#define W83781D_SYSCTL_IN7 1007
#define W83781D_SYSCTL_IN8 1008
#define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
#define W83781D_SYSCTL_FAN2 1102
#define W83781D_SYSCTL_FAN3 1103
#define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
#define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
#define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
#define W83781D_SYSCTL_VID 1300		/* Volts * 1000 */
#define W83781D_SYSCTL_VRM 1301
#define W83781D_SYSCTL_PWM1 1401
#define W83781D_SYSCTL_PWM2 1402
#define W83781D_SYSCTL_PWM3 1403
#define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
#define W83781D_SYSCTL_SENS2 1502
#define W83781D_SYSCTL_SENS3 1503
#define W83781D_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define W83781D_SYSCTL_ALARMS 2001	/* bitvector */
#define W83781D_SYSCTL_BEEP 2002	/* bitvector */

#define W83781D_ALARM_IN0 0x0001
#define W83781D_ALARM_IN1 0x0002
#define W83781D_ALARM_IN2 0x0004
#define W83781D_ALARM_IN3 0x0008
#define W83781D_ALARM_IN4 0x0100
#define W83781D_ALARM_IN5 0x0200
#define W83781D_ALARM_IN6 0x0400
#define W83782D_ALARM_IN7 0x10000
#define W83782D_ALARM_IN8 0x20000
#define W83781D_ALARM_FAN1 0x0040
#define W83781D_ALARM_FAN2 0x0080
#define W83781D_ALARM_FAN3 0x0800
#define W83781D_ALARM_TEMP1 0x0010
#define W83781D_ALARM_TEMP23 0x0020	/* 781D only */
#define W83781D_ALARM_TEMP2 0x0020	/* 782D/783S */
#define W83781D_ALARM_TEMP3 0x2000	/* 782D only */
#define W83781D_ALARM_CHAS 0x1000

/* -- SENSORS SYSCTL END -- */

/* These files are created for each detected chip. This is just a template;
   though at first sight, you might think we could use a statically
   allocated list, we need some way to get back to the parent - which
   is done through one of the 'extra' fields which are initialized=20
   when a new copy is allocated. */

/* without pwm3-4 */
static ctl_table w83627hf_dir_table_template[] =3D {
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp},
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp_add},
	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp_add},
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_vid},
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_vrm},
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan_div},
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_alarms},
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_beep},
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{0}
};

/* similar to w83782d but no fan3, no vid */
static ctl_table w83697hf_dir_table_template[] =3D {
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	/* no in1 to maintain compatibility with 781d and 782d. */
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp},
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp_add},
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan_div},
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_alarms},
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_beep},
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{0}
};

/* no in5 and in6 */
static ctl_table w83627thf_dir_table_template[] =3D {
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_in},
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan},
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp},
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp_add},
	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_temp_add},
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_vid},
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_vrm},
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_fan_div},
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_alarms},
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_beep},
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_PWM3, "pwm3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &w83627hf_sens},
	{0}
};


/* This function is called when:
     * w83627hf_driver is inserted (when this module is loaded), for each
       available adapter
     * when a new adapter is inserted (and w83627hf_driver is still present=
) */
static int w83627hf_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, w83627hf_detect);
}

static int w83627hf_find(int *address)
{
	u16 val;

	superio_enter();
	val=3D superio_inb(DEVID);
	if(val !=3D W637_DEVID && val !=3D W627_DEVID && val !=3DW627THF_DEVID && =
val !=3D W697_DEVID) {
		superio_exit();
		return -ENODEV;
	}

	superio_select(W83627HF_LD_HWM);
	val =3D (superio_inb(WINB_BASE_REG) << 8) |
	       superio_inb(WINB_BASE_REG + 1);
	*address =3D val & ~(WINB_EXTENT - 1);
	if (*address =3D 0 && force_addr =3D 0) {
		printk("w83627hf.o: base address not set - use force_addr=3D0xaddr\n");
		superio_exit();
		return -ENODEV;
	}
	if (force_addr)
		*address =3D force_addr;	/* so detect will get called */

	superio_exit();
	return 0;
}

int w83627hf_detect(struct i2c_adapter *adapter, int address,
		   unsigned short flags, int kind)
{
	int i, val;
	struct i2c_client *new_client;
	struct w83627hf_data *data;
	int err =3D 0;
	const char *type_name =3D "";
	const char *client_name =3D "";

	if (!i2c_is_isa_adapter(adapter))
		return 0;

	if(force_addr)
		address =3D force_addr & ~(WINB_EXTENT - 1);
	if (check_region(address, WINB_EXTENT)) {
		printk("w83627hf.o: region 0x%x already in use!\n", address);
		return -ENODEV;
	}
	if(force_addr) {
		printk("w83627hf.o: forcing ISA address 0x%04X\n", address);
		superio_enter();
		superio_select(W83627HF_LD_HWM);
		superio_outb(WINB_BASE_REG, address >> 8);
		superio_outb(WINB_BASE_REG+1, address & 0xff);
		superio_exit();
	}

	superio_enter();
	val=3D superio_inb(DEVID);
	if(val =3D W627_DEVID)
		kind =3D w83627hf;
	else if(val =3D W697_DEVID)
		kind =3D w83697hf;
	else if(val =3D W627THF_DEVID)
		kind =3D w83627thf;
	else if(val =3D W637_DEVID)
		kind =3D w83637hf;
	=09
	superio_select(W83627HF_LD_HWM);
	if((val =3D 0x01 & superio_inb(WINB_ACT_REG)) =3D 0)
		superio_outb(WINB_ACT_REG, 1);
	superio_exit();

	/* OK. For now, we presume we have a valid client. We now create the
	   client structure, even though we cannot fill it completely yet.
	   But it allows us to access w83627hf_{read,write}_value. */

	if (!(new_client =3D kmalloc(sizeof(struct i2c_client) +
				   sizeof(struct w83627hf_data),
				   GFP_KERNEL))) {
		err =3D -ENOMEM;
		goto ERROR0;
	}

	data =3D (struct w83627hf_data *) (new_client + 1);
	new_client->addr =3D address;
	init_MUTEX(&data->lock);
	new_client->data =3D data;
	new_client->adapter =3D adapter;
	new_client->driver =3D &w83627hf_driver;
	new_client->flags =3D 0;


	if (kind =3D w83627hf) {
		type_name =3D "w83627hf";
		client_name =3D "W83627HF chip";
	} else if (kind =3D w83627thf) {
		type_name =3D "w83627thf";
		client_name =3D "W83627THF chip";
	} else if (kind =3D w83697hf) {
		type_name =3D "w83697hf";
		client_name =3D "W83697HF chip";
	} else if (kind =3D w83637hf) {
		type_name =3D "w83637hf";
		client_name =3D "W83637HF chip";
	} else {
		goto ERROR1;
	}

	request_region(address, WINB_EXTENT, type_name);

	/* Fill in the remaining client fields and put it into the global list */
	strcpy(new_client->name, client_name);
	data->type =3D kind;
	new_client->id =3D w83627hf_id++;
	data->valid =3D 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err =3D i2c_attach_client(new_client)))
		goto ERROR3;

	data->lm75 =3D NULL;

	/* Register a new directory entry with module sensors */
	if ((i =3D i2c_register_entry(new_client,
				type_name,
				(kind =3D w83697hf) ?
				   w83697hf_dir_table_template :
				(kind =3D w83627hf) ?
				   w83627hf_dir_table_template :
				(kind =3D w83637hf) ?
				   w83627hf_dir_table_template :
				   w83627thf_dir_table_template)) < 0) {
		err =3D i;
		goto ERROR7;
	}
	data->sysctl_id =3D i;

	/* Initialize the chip */
	w83627hf_init_client(new_client);
	return 0;

/* OK, this is not exactly good programming practice, usually. But it is
   very code-efficient in this case. */

      ERROR7:
	i2c_detach_client(new_client);
      ERROR3:
	release_region(address, WINB_EXTENT);
      ERROR1:
	kfree(new_client);
      ERROR0:
	return err;
}

static int w83627hf_detach_client(struct i2c_client *client)
{
	int err;

	i2c_deregister_entry(((struct w83627hf_data *) (client->data))->
				 sysctl_id);

	if ((err =3D i2c_detach_client(client))) {
		printk
		    (KERN_ERR "w83627hf.o: Client deregistration failed, client not detac=
hed.\n");
		return err;
	}

	release_region(client->addr, WINB_EXTENT);
	kfree(client);

	return 0;
}


/*
   ISA access must always be locked explicitly!=20
   We ignore the W83781D BUSY flag at this moment - it could lead to deadlo=
cks,
   would slow down the W83781D access and should not be necessary.=20
   There are some ugly typecasts here, but the good news is - they should
   nowhere else be necessary! */
static int w83627hf_read_value(struct i2c_client *client, u16 reg)
{
	int res, word_sized;

	down(&(((struct w83627hf_data *) (client->data))->lock));
	word_sized =3D (((reg & 0xff00) =3D 0x100)
		      || ((reg & 0xff00) =3D 0x200))
	    && (((reg & 0x00ff) =3D 0x50)
		|| ((reg & 0x00ff) =3D 0x53)
		|| ((reg & 0x00ff) =3D 0x55));
	if (reg & 0xff00) {
		outb_p(W83781D_REG_BANK,
		       client->addr + W83781D_ADDR_REG_OFFSET);
		outb_p(reg >> 8,
		       client->addr + W83781D_DATA_REG_OFFSET);
	}
	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
	res =3D inb_p(client->addr + W83781D_DATA_REG_OFFSET);
	if (word_sized) {
		outb_p((reg & 0xff) + 1,
		       client->addr + W83781D_ADDR_REG_OFFSET);
		res 		    (res << 8) + inb_p(client->addr +
				       W83781D_DATA_REG_OFFSET);
	}
	if (reg & 0xff00) {
		outb_p(W83781D_REG_BANK,
		       client->addr + W83781D_ADDR_REG_OFFSET);
		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
	}
	up(&(((struct w83627hf_data *) (client->data))->lock));
	return res;
}

static int w83627thf_read_gpio5(struct i2c_client *client)
{
	int res, inv;

	down(&(((struct w83627hf_data *) (client->data))->lock));
	superio_enter();
	superio_select(W83627HF_LD_GPIO5);
	res =3D superio_inb(W83627THF_GPIO5_DR);
	inv =3D superio_inb(W83627THF_GPIO5_INVR);
	superio_exit();
	up(&(((struct w83627hf_data *) (client->data))->lock));
	return res;
}

static int w83627hf_write_value(struct i2c_client *client, u16 reg, u16 val=
ue)
{
	int word_sized;

	down(&(((struct w83627hf_data *) (client->data))->lock));
	word_sized =3D (((reg & 0xff00) =3D 0x100)
		      || ((reg & 0xff00) =3D 0x200))
	    && (((reg & 0x00ff) =3D 0x53)
		|| ((reg & 0x00ff) =3D 0x55));
	if (reg & 0xff00) {
		outb_p(W83781D_REG_BANK,
		       client->addr + W83781D_ADDR_REG_OFFSET);
		outb_p(reg >> 8,
		       client->addr + W83781D_DATA_REG_OFFSET);
	}
	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
	if (word_sized) {
		outb_p(value >> 8,
		       client->addr + W83781D_DATA_REG_OFFSET);
		outb_p((reg & 0xff) + 1,
		       client->addr + W83781D_ADDR_REG_OFFSET);
	}
	outb_p(value & 0xff,
	       client->addr + W83781D_DATA_REG_OFFSET);
	if (reg & 0xff00) {
		outb_p(W83781D_REG_BANK,
		       client->addr + W83781D_ADDR_REG_OFFSET);
		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
	}
	up(&(((struct w83627hf_data *) (client->data))->lock));
	return 0;
}

/* Called when we have found a new W83781D. It should set limits, etc. */
static void w83627hf_init_client(struct i2c_client *client)
{
	struct w83627hf_data *data =3D client->data;
	int vid =3D 0, i;
	int type =3D data->type;
	u8 tmp;

	if(init) {
		/* save this register */
		i =3D w83627hf_read_value(client, W83781D_REG_BEEP_CONFIG);
		/* Reset all except Watchdog values and last conversion values
		   This sets fan-divs to 2, among others */
		w83627hf_write_value(client, W83781D_REG_CONFIG, 0x80);
		/* Restore the register and disable power-on abnormal beep.
		   This saves FAN 1/2/3 input/output values set by BIOS. */
		w83627hf_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
		/* Disable master beep-enable (reset turns it on).
		   Individual beeps should be reset to off but for some reason
		   disabling this bit helps some people not get beeped */
		w83627hf_write_value(client, W83781D_REG_BEEP_INTS2, 0);
	}

	/* Minimize conflicts with other winbond i2c-only clients...  */
	/* disable i2c subclients... how to disable main i2c client?? */
	/* force i2c address to relatively uncommon address */
	w83627hf_write_value(client, W83781D_REG_I2C_SUBADDR, 0x89);
	w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);

	/* Read VID only once */
	if (w83627hf =3D data->type || w83637hf =3D data->type) {
		int lo =3D w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
		int hi =3D w83627hf_read_value(client, W83781D_REG_CHIPID);
		data->vid =3D (lo & 0x0f) | ((hi & 0x01) << 4);
	} else if (w83627thf =3D data->type) {
		data->vid =3D w83627thf_read_gpio5(client) & 0x1f;
	}

	/* Convert VID to voltage based on default VRM */
	data->vrm =3D DEFAULT_VRM;
	if (type !=3D w83697hf)
		vid =3D vid_from_reg(vid, data->vrm);

	tmp =3D w83627hf_read_value(client, W83781D_REG_SCFG1);
	for (i =3D 1; i <=3D 3; i++) {
		if (!(tmp & BIT_SCFG1[i - 1])) {
			data->sens[i - 1] =3D W83781D_DEFAULT_BETA;
		} else {
			if (w83627hf_read_value
			    (client,
			     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])
				data->sens[i - 1] =3D 1;
			else
				data->sens[i - 1] =3D 2;
		}
		if ((type =3D w83697hf) && (i =3D 2))
			break;
	}

	data->pwmenable[0] =3D 1;
	data->pwmenable[1] =3D 1;
	data->pwmenable[2] =3D 1;

	if(init) {
		if (type !=3D w83697hf) {
			/* enable PWM2 control (can't hurt since PWM reg
		           should have been reset to 0xff) */
			w83627hf_write_value(client, W83781D_REG_PWMCLK12, 0x19);
		}
		/* enable comparator mode for temp2 and temp3 so
	           alarm indication will work correctly */
		w83627hf_write_value(client, W83781D_REG_IRQ, 0x41);
	}

	/* Start monitoring */
	w83627hf_write_value(client, W83781D_REG_CONFIG,
			    (w83627hf_read_value(client,
						W83781D_REG_CONFIG) & 0xf7)
			    | 0x01);
}

static void w83627hf_update_client(struct i2c_client *client)
{
	struct w83627hf_data *data =3D client->data;
	int i;

	down(&data->update_lock);

	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
	    (jiffies < data->last_updated) || !data->valid) {
		for (i =3D 0; i <=3D 8; i++) {
			/* skip missing sensors */
			if (((data->type =3D w83697hf) && (i =3D 1)) ||
			    ((data->type =3D w83627thf) && ((i =3D 4) || (i =3D 5))))
				continue;
			data->in[i] 			    w83627hf_read_value(client, W83781D_REG_IN(i));
			data->in_min[i] 			    w83627hf_read_value(client,
					       W83781D_REG_IN_MIN(i));
			data->in_max[i] 			    w83627hf_read_value(client,
					       W83781D_REG_IN_MAX(i));
		}
		for (i =3D 1; i <=3D 3; i++) {
			data->fan[i - 1] 			    w83627hf_read_value(client, W83781D_REG_FAN(i));
			data->fan_min[i - 1] 			    w83627hf_read_value(client,
					       W83781D_REG_FAN_MIN(i));
		}
		for (i =3D 1; i <=3D 3; i++) {
			data->pwm[i - 1] 			    w83627hf_read_value(client,
					       W836X7HF_REG_PWM(data->type, i));
			if(i =3D 2 && data->type !=3D w83627thf)
				break;
		}

		data->temp =3D w83627hf_read_value(client, W83781D_REG_TEMP);
		data->temp_over 		    w83627hf_read_value(client, W83781D_REG_TEMP_OVER);
		data->temp_hyst 		    w83627hf_read_value(client, W83781D_REG_TEMP_HYST);
		data->temp_add[0] 		    w83627hf_read_value(client, W83781D_REG_TEMP2);
		data->temp_add_over[0] 		    w83627hf_read_value(client, W83781D_REG_TEMP=
2_OVER);
		data->temp_add_hyst[0] 		    w83627hf_read_value(client, W83781D_REG_TEMP=
2_HYST);
		if (data->type !=3D w83697hf) {
			data->temp_add[1] 			    w83627hf_read_value(client, W83781D_REG_TEMP3);
			data->temp_add_over[1] 			    w83627hf_read_value(client, W83781D_REG_TE=
MP3_OVER);
			data->temp_add_hyst[1] 			    w83627hf_read_value(client, W83781D_REG_TE=
MP3_HYST);
		}

		i =3D w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
		data->fan_div[0] =3D (i >> 4) & 0x03;
		data->fan_div[1] =3D (i >> 6) & 0x03;
		if (data->type !=3D w83697hf) {
			data->fan_div[2] =3D (w83627hf_read_value(client,
					       W83781D_REG_PIN) >> 6) & 0x03;
		}
		i =3D w83627hf_read_value(client, W83781D_REG_VBAT);
		data->fan_div[0] |=3D (i >> 3) & 0x04;
		data->fan_div[1] |=3D (i >> 4) & 0x04;
		if (data->type !=3D w83697hf)
			data->fan_div[2] |=3D (i >> 5) & 0x04;
		data->alarms 		    w83627hf_read_value(client, W83781D_REG_ALARM1) |
		    (w83627hf_read_value(client, W83781D_REG_ALARM2) << 8) |
		    (w83627hf_read_value(client, W83781D_REG_ALARM3) << 16);
		i =3D w83627hf_read_value(client, W83781D_REG_BEEP_INTS2);
		data->beep_enable =3D i >> 7;
		data->beeps =3D ((i & 0x7f) << 8) |
		    w83627hf_read_value(client, W83781D_REG_BEEP_INTS1) |
		    w83627hf_read_value(client, W83781D_REG_BEEP_INTS3) << 16;
		data->last_updated =3D jiffies;
		data->valid =3D 1;
	}

	up(&data->update_lock);
}

void w83627hf_in(struct i2c_client *client, int operation, int ctl_name,
		int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int nr =3D ctl_name - W83781D_SYSCTL_IN0;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 2;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D IN_FROM_REG(data->in_min[nr]);
		results[1] =3D IN_FROM_REG(data->in_max[nr]);
		results[2] =3D IN_FROM_REG(data->in[nr]);
		*nrels_mag =3D 3;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1) {
			data->in_min[nr] =3D IN_TO_REG(results[0]);
			w83627hf_write_value(client, W83781D_REG_IN_MIN(nr),
					    data->in_min[nr]);
		}
		if (*nrels_mag >=3D 2) {
			data->in_max[nr] =3D IN_TO_REG(results[1]);
			w83627hf_write_value(client, W83781D_REG_IN_MAX(nr),
					    data->in_max[nr]);
		}
	}
}

void w83627hf_fan(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int nr =3D ctl_name - W83781D_SYSCTL_FAN1 + 1;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 0;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D FAN_FROM_REG(data->fan_min[nr - 1],
				  DIV_FROM_REG(data->fan_div[nr - 1]));
		results[1] =3D FAN_FROM_REG(data->fan[nr - 1],
			          DIV_FROM_REG(data->fan_div[nr - 1]));
		*nrels_mag =3D 2;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1) {
			data->fan_min[nr - 1] 			     FAN_TO_REG(results[0],
			            DIV_FROM_REG(data->fan_div[nr-1]));
			w83627hf_write_value(client,
					    W83781D_REG_FAN_MIN(nr),
					    data->fan_min[nr - 1]);
		}
	}
}

void w83627hf_temp(struct i2c_client *client, int operation, int ctl_name,
		  int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 1;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D TEMP_FROM_REG(data->temp_over);
		results[1] =3D TEMP_FROM_REG(data->temp_hyst);
		results[2] =3D TEMP_FROM_REG(data->temp);
		*nrels_mag =3D 3;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1) {
			data->temp_over =3D TEMP_TO_REG(results[0]);
			w83627hf_write_value(client, W83781D_REG_TEMP_OVER,
					    data->temp_over);
		}
		if (*nrels_mag >=3D 2) {
			data->temp_hyst =3D TEMP_TO_REG(results[1]);
			w83627hf_write_value(client, W83781D_REG_TEMP_HYST,
					    data->temp_hyst);
		}
	}
}

void w83627hf_temp_add(struct i2c_client *client, int operation,
		      int ctl_name, int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int nr =3D ctl_name - W83781D_SYSCTL_TEMP2;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 1;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
			results[0] 			    LM75_TEMP_FROM_REG(data->temp_add_over[nr]);
			results[1] 			    LM75_TEMP_FROM_REG(data->temp_add_hyst[nr]);
			results[2] =3D LM75_TEMP_FROM_REG(data->temp_add[nr]);
		*nrels_mag =3D 3;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1) {
				data->temp_add_over[nr] 				    LM75_TEMP_TO_REG(results[0]);
			w83627hf_write_value(client,
					    nr ? W83781D_REG_TEMP3_OVER :
					    W83781D_REG_TEMP2_OVER,
					    data->temp_add_over[nr]);
		}
		if (*nrels_mag >=3D 2) {
				data->temp_add_hyst[nr] 				    LM75_TEMP_TO_REG(results[1]);
			w83627hf_write_value(client,
					    nr ? W83781D_REG_TEMP3_HYST :
					    W83781D_REG_TEMP2_HYST,
					    data->temp_add_hyst[nr]);
		}
	}
}

void w83627hf_vid(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 3;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D vid_from_reg(data->vid, data->vrm);
		*nrels_mag =3D 1;
	}
}

void w83627hf_vrm(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 1;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		results[0] =3D data->vrm;
		*nrels_mag =3D 1;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1)
			data->vrm =3D results[0];
	}
}

void w83627hf_alarms(struct i2c_client *client, int operation, int ctl_name,
		    int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 0;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D data->alarms;
		*nrels_mag =3D 1;
	}
}

void w83627hf_beep(struct i2c_client *client, int operation, int ctl_name,
		  int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int val;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 0;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D BEEP_ENABLE_FROM_REG(data->beep_enable);
		results[1] =3D data->beeps;
		*nrels_mag =3D 2;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 2) {
			data->beeps =3D BEEPS_TO_REG(results[1]);
			w83627hf_write_value(client, W83781D_REG_BEEP_INTS1,
					    data->beeps & 0xff);
				w83627hf_write_value(client,
						    W83781D_REG_BEEP_INTS3,
						    ((data-> beeps) >> 16) &
						      0xff);
			val =3D (data->beeps >> 8) & 0x7f;
		} else if (*nrels_mag >=3D 1)
			val 			    w83627hf_read_value(client,
					       W83781D_REG_BEEP_INTS2) &
			    0x7f;
		if (*nrels_mag >=3D 1) {
			data->beep_enable =3D BEEP_ENABLE_TO_REG(results[0]);
			w83627hf_write_value(client, W83781D_REG_BEEP_INTS2,
					    val | data->beep_enable << 7);
		}
	}
}

/* w83697hf only has two fans */
void w83627hf_fan_div(struct i2c_client *client, int operation,
		     int ctl_name, int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int old, old2, old3 =3D 0;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 0;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D DIV_FROM_REG(data->fan_div[0]);
		results[1] =3D DIV_FROM_REG(data->fan_div[1]);
		if (data->type =3D w83697hf) {
			*nrels_mag =3D 2;
		} else {
			results[2] =3D DIV_FROM_REG(data->fan_div[2]);
			*nrels_mag =3D 3;
		}
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		old =3D w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
		/* w83627hf doesn't have extended divisor bits */
			old3 			    w83627hf_read_value(client, W83781D_REG_VBAT);
		if (*nrels_mag >=3D 3 && data->type !=3D w83697hf) {
			data->fan_div[2] 			    DIV_TO_REG(results[2]);
			old2 =3D w83627hf_read_value(client, W83781D_REG_PIN);
			old2 			    (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
			w83627hf_write_value(client, W83781D_REG_PIN, old2);
				old3 				    (old3 & 0x7f) |
				    ((data->fan_div[2] & 0x04) << 5);
		}
		if (*nrels_mag >=3D 2) {
			data->fan_div[1] 			    DIV_TO_REG(results[1]);
			old 			    (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
				old3 				    (old3 & 0xbf) |
				    ((data->fan_div[1] & 0x04) << 4);
		}
		if (*nrels_mag >=3D 1) {
			data->fan_div[0] 			    DIV_TO_REG(results[0]);
			old 			    (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
			w83627hf_write_value(client, W83781D_REG_VID_FANDIV,
					    old);
				old3 				    (old3 & 0xdf) |
				    ((data->fan_div[0] & 0x04) << 3);
				w83627hf_write_value(client,
						    W83781D_REG_VBAT,
						    old3);
		}
	}
}

/* we do not currently support disabling PWM with 2nd argument;
  set first argument to 255 to disable */
void w83627hf_pwm(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int nr =3D 1 + ctl_name - W83781D_SYSCTL_PWM1;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 0;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		w83627hf_update_client(client);
		results[0] =3D data->pwm[nr - 1];
		results[1] =3D data->pwmenable[nr - 1];
		*nrels_mag =3D 2;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1) {
			data->pwm[nr - 1] =3D PWM_TO_REG(results[0]);
			w83627hf_write_value(client,
			                     W836X7HF_REG_PWM(data->type, nr),
					     data->pwm[nr - 1]);
		}
	}
}

void w83627hf_sens(struct i2c_client *client, int operation, int ctl_name,
		  int *nrels_mag, long *results)
{
	struct w83627hf_data *data =3D client->data;
	int nr =3D 1 + ctl_name - W83781D_SYSCTL_SENS1;
	u8 tmp;

	if (operation =3D SENSORS_PROC_REAL_INFO)
		*nrels_mag =3D 0;
	else if (operation =3D SENSORS_PROC_REAL_READ) {
		results[0] =3D data->sens[nr - 1];
		*nrels_mag =3D 1;
	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >=3D 1) {
			switch (results[0]) {
			case 1:	/* PII/Celeron diode */
				tmp =3D w83627hf_read_value(client,
						       W83781D_REG_SCFG1);
				w83627hf_write_value(client,
						    W83781D_REG_SCFG1,
						    tmp | BIT_SCFG1[nr -
								    1]);
				tmp =3D w83627hf_read_value(client,
						       W83781D_REG_SCFG2);
				w83627hf_write_value(client,
						    W83781D_REG_SCFG2,
						    tmp | BIT_SCFG2[nr -
								    1]);
				data->sens[nr - 1] =3D results[0];
				break;
			case 2:	/* 3904 */
				tmp =3D w83627hf_read_value(client,
						       W83781D_REG_SCFG1);
				w83627hf_write_value(client,
						    W83781D_REG_SCFG1,
						    tmp | BIT_SCFG1[nr -
								    1]);
				tmp =3D w83627hf_read_value(client,
						       W83781D_REG_SCFG2);
				w83627hf_write_value(client,
						    W83781D_REG_SCFG2,
						    tmp & ~BIT_SCFG2[nr -
								     1]);
				data->sens[nr - 1] =3D results[0];
				break;
			case W83781D_DEFAULT_BETA:	/* thermistor */
				tmp =3D w83627hf_read_value(client,
						       W83781D_REG_SCFG1);
				w83627hf_write_value(client,
						    W83781D_REG_SCFG1,
						    tmp & ~BIT_SCFG1[nr -
								     1]);
				data->sens[nr - 1] =3D results[0];
				break;
			default:
				printk
				    (KERN_ERR "w83627hf.o: Invalid sensor type %ld; must be 1, 2, or %d=
\n",
				     results[0], W83781D_DEFAULT_BETA);
				break;
			}
		}
	}
}

static int __init sm_w83627hf_init(void)
{
	int addr;

	printk(KERN_INFO "w83627hf.o version %s (%s)\n", LM_VERSION, LM_DATE);
	if (w83627hf_find(&addr)) {
		printk("w83627hf.o: W83627/697 not detected, module not inserted.\n");
		return -ENODEV;
	}
	normal_isa[0] =3D addr;

	return i2c_add_driver(&w83627hf_driver);
}

static void __exit sm_w83627hf_exit(void)
{
	i2c_del_driver(&w83627hf_driver);
}



MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
	      "Philip Edelbrock <phil@netroedge.com>, "
	      "and Mark Studebaker <mdsxyz123@yahoo.com>");
MODULE_DESCRIPTION("W83627HF driver");
MODULE_LICENSE("GPL");

module_init(sm_w83627hf_init);
module_exit(sm_w83627hf_exit);
