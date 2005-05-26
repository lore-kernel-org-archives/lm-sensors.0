From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 26 May 2005 19:25:09 +0000
Subject: [lm-sensors] W83792 review
Message-Id: <429605CE.5060009@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I reviewed your driver. Please check my comments.
I'm inviting other developers to check my objections I need to develop "review skill". - Thanks

>(1) We misunderstand the meaning of temperature low limit, this bug also
>exists in the 792 driver for linux-2.4 and our 792 Windows driver.

Please can you fix this ASAP so we can send it to kernel folks?

>(2) I have not implemented the 0.5 degree to temperature2 and temperature3,
>while the driver for linux-2.4 implemented this.

That is the reason temp1 has separate handling and variable? If so, please add the code.
or better would be to fix existing code so it does not look so strange.

>(3) The 792 driver for linux-2.4 can adjust the fan divisor automatically,
>while I have not implemented it in this 2.6 one.

This would be nice but better to put there some driver instead of none...
I think this can wait but it is good to have it soon.

Also we will need similar documentation to driver similar what 2.4 driver has.

You can find some inspiration on style of document here: http://ssh.cz/~ruik/chips_doc13
Please document there the extra /sys entries for your driver.
And as last thing that we will need is KConfig & Makefile entry for the driver.

I know that you are short with time so I'm offering help with documentation and KConfig and Makefile.
On the other hand I'm expecting that you will fix other stuff in reasonable time :)

Regards

Rudolf


> /*
>     w83792d.c - Part of lm_sensors, Linux kernel modules for hardware
>                 monitoring
>     Copyright (C) 2004, 2005 Winbond Electronics Corp.
>                         Chunhao Huang <huang0@winbond.com.tw>
> 
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
>     the Free Software Foundation; either version 2 of the License, or
>     (at your option) any later version.
> 
>     This program is distributed in the hope that it will be useful,
>     but WITHOUT ANY WARRANTY; without even the implied warranty of
>     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>     GNU General Public License for more details.
> 
>     You should have received a copy of the GNU General Public License
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> 
>     Note:
>     1. This driver is only for 2.6 kernel, 2.4 kernel need a different driver.
>     2. This driver is only for Winbond W83792D C version device, there
>        are also some motherboards with B version W83792D device. The 
>        calculation method to in6-in7(measured value, limits) is a little
>        different between C and B version. C or B version can be identified
>        by CR[0x49h].
> */
> 
> /*
>     Supports following chips:
> 
>     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
>     w83792d	9	7	7	3	0x7a	0x5ca3	yes	no
> */
> 
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/slab.h>
> #include <linux/i2c.h>
> #include <linux/i2c-sensor.h>
> #include <linux/i2c-vid.h>
> #include <asm/io.h>
Do you really need this header?

> /* #include "lm75.h" */
 Please remove this.

> 
> 
> /* Addresses to scan */
> static unsigned short normal_i2c[] = { 0x2c, 0x2f, I2C_CLIENT_END };
> static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
> 
> /* Insmod parameters */
> SENSORS_INSMOD_1(w83792d);
> I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
> 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
>
> static int init;
> module_param(init, bool, 0);
> MODULE_PARM_DESC(init, "Set to one for chip initialization");

Maybe better "Set to one to force chip initialization"

> 
> /* show/display the debug message */
> #define W83792D_DEBUG 1

There is some global #define for debugging called DEBUG it seems, so maybe it would be good
to remove  this and use DEBUG later.

> /* The W83792D registers */
> static const u8 W83792D_REG_IN[9] = {
> 	0x20,	/* Vcore A in DataSheet */
> 	0x21,	/* Vcore B in DataSheet */
> 	0x22,	/* VIN0 in DataSheet */
> 	0x23,	/* VIN1 in DataSheet */
> 	0x24,	/* VIN2 in DataSheet */
> 	0x25,	/* VIN3 in DataSheet */
> 	0x26,	/* 5VCC in DataSheet */
> 	0xB0,	/* 5VSB in DataSheet */
> 	0xB1	/* VBAT in DataSheet */
> };
> #define W83792D_REG_LOW_BITS1 0x3E  /* Low Bits I in DataSheet */
> #define W83792D_REG_LOW_BITS2 0x3F  /* Low Bits II in DataSheet */
> static const u8 W83792D_REG_IN_MAX[9] = {
> 	0x2B,	/* Vcore A High Limit in DataSheet */
> 	0x2D,	/* Vcore B High Limit in DataSheet */
> 	0x2F,	/* VIN0 High Limit in DataSheet */
> 	0x31,	/* VIN1 High Limit in DataSheet */
> 	0x33,	/* VIN2 High Limit in DataSheet */
> 	0x35,	/* VIN3 High Limit in DataSheet */
> 	0x37,	/* 5VCC High Limit in DataSheet */
> 	0xB4,	/* 5VSB High Limit in DataSheet */
> 	0xB6	/* VBAT High Limit in DataSheet */
> };
> static const u8 W83792D_REG_IN_MIN[9] = {
> 	0x2C,	/* Vcore A Low Limit in DataSheet */
> 	0x2E,	/* Vcore B Low Limit in DataSheet */
> 	0x30,	/* VIN0 Low Limit in DataSheet */
> 	0x32,	/* VIN1 Low Limit in DataSheet */
> 	0x34,	/* VIN2 Low Limit in DataSheet */
> 	0x36,	/* VIN3 Low Limit in DataSheet */
> 	0x38,	/* 5VCC Low Limit in DataSheet */
> 	0xB5,	/* 5VSB Low Limit in DataSheet */
> 	0xB7	/* VBAT Low Limit in DataSheet */
> };
> static const u8 W83792D_REG_FAN[7] = {
> 	0x28,	/* FAN 1 Count in DataSheet */
> 	0x29,	/* FAN 2 Count in DataSheet */
> 	0x2A,	/* FAN 3 Count in DataSheet */
> 	0xB8,	/* FAN 4 Count in DataSheet */
> 	0xB9,	/* FAN 5 Count in DataSheet */
> 	0xBA,	/* FAN 6 Count in DataSheet */
> 	0xBE	/* FAN 7 Count in DataSheet */
> };
> static const u8 W83792D_REG_FAN_MIN[7] = {
> 	0x3B,	/* FAN 1 Count Low Limit in DataSheet */
> 	0x3C,	/* FAN 2 Count Low Limit in DataSheet */
> 	0x3D,	/* FAN 3 Count Low Limit in DataSheet */
> 	0xBB,	/* FAN 4 Count Low Limit in DataSheet */
> 	0xBC,	/* FAN 5 Count Low Limit in DataSheet */
> 	0xBD,	/* FAN 6 Count Low Limit in DataSheet */
> 	0xBF	/* FAN 7 Count Low Limit in DataSheet */
> };
> #define W83792D_REG_FAN_CFG 0x84    /* FAN Configuration in DataSheet */
> static const u8 W83792D_REG_FAN_DIV[4] = {
> 	0x47,	/* contains FAN2 and FAN1 Divisor */
> 	0x5B,	/* contains FAN4 and FAN3 Divisor */
> 	0x5C,	/* contains FAN6 and FAN5 Divisor */
> 	0x9E	/* contains FAN7 Divisor. */
> };
> static const u8 W83792D_REG_PWM[7] = {
> 	0x81,	/* FAN 1 Duty Cycle, be used to control */
> 	0x83,	/* FAN 2 Duty Cycle, be used to control */
> 	0x94,	/* FAN 3 Duty Cycle, be used to control */
> 	0xA3,	/* FAN 4 Duty Cycle, be used to control */
> 	0xA4,	/* FAN 5 Duty Cycle, be used to control */
> 	0xA5,	/* FAN 6 Duty Cycle, be used to control */
> 	0xA6	/* FAN 7 Duty Cycle, be used to control */
> };
> #define W83792D_REG_BANK		0x4E
> #define W83792D_REG_TEMP2_CONFIG	0xC2
> #define W83792D_REG_TEMP3_CONFIG	0xCA
> 
> static const u8 W83792D_REG_TEMP[3] = {
> 	0x27,	/* TEMP 1 in DataSheet */
> 	0xC0,	/* TEMP 2 in DataSheet */
> 	0xC8	/* TEMP 3 in DataSheet */
> };
> static const u8 W83792D_REG_TEMP_HYST[3] = {
> 	0x3A,	/* TEMP 1 Hyst in DataSheet */
> 	0xC3,	/* TEMP 2 Hyst in DataSheet */
> 	0xCB	/* TEMP 3 Hyst in DataSheet */
> };
> static const u8 W83792D_REG_TEMP_OVER[3] = {
> 	0x39,	/* TEMP 1 Over in DataSheet */
> 	0xC5,	/* TEMP 2 Over in DataSheet */
> 	0xCD	/* TEMP 3 Over in DataSheet */
> };
> 
> static const u8 W83792D_REG_THERMAL[3] = {
> 	0x85,	/* SmartFanI: Fan1 target value */
> 	0x86,	/* SmartFanI: Fan2 target value */
> 	0x96	/* SmartFanI: Fan3 target value */
> };
> 
> static const u8 W83792D_REG_TOLERANCE[3] = {
> 	0x87,	/* (bit3-0)SmartFan Fan1 tolerance */
> 	0x87,	/* (bit7-4)SmartFan Fan2 tolerance */
> 	0x97	/* (bit3-0)SmartFan Fan3 tolerance */
> };
> 
> static const u8 W83792D_REG_POINTS[3][4] = {
> 	{ 0x85,		/* SmartFanII: Fan1 temp point 1 */
> 	  0xE3,		/* SmartFanII: Fan1 temp point 2 */
> 	  0xE4,		/* SmartFanII: Fan1 temp point 3 */
> 	  0xE5 },	/* SmartFanII: Fan1 temp point 4 */
> 	{ 0x86,		/* SmartFanII: Fan2 temp point 1 */
> 	  0xE6,		/* SmartFanII: Fan2 temp point 2 */
> 	  0xE7,		/* SmartFanII: Fan2 temp point 3 */
> 	  0xE8 },	/* SmartFanII: Fan2 temp point 4 */
> 	{ 0x96,		/* SmartFanII: Fan3 temp point 1 */
> 	  0xE9,		/* SmartFanII: Fan3 temp point 2 */
> 	  0xEA,		/* SmartFanII: Fan3 temp point 3 */
> 	  0xEB }	/* SmartFanII: Fan3 temp point 4 */
> };
> 
> static const u8 W83792D_REG_LEVELS[3][4] = {
> 	{ 0x88,		/* (bit3-0) SmartFanII: Fan1 Non-Stop */
> 	  0x88,		/* (bit7-4) SmartFanII: Fan1 Level 1 */
> 	  0xE0,		/* (bit7-4) SmartFanII: Fan1 Level 2 */
> 	  0xE0 },	/* (bit3-0) SmartFanII: Fan1 Level 3 */
> 	{ 0x89,		/* (bit3-0) SmartFanII: Fan2 Non-Stop */
> 	  0x89,		/* (bit7-4) SmartFanII: Fan2 Level 1 */
> 	  0xE1,		/* (bit7-4) SmartFanII: Fan2 Level 2 */
> 	  0xE1 },	/* (bit3-0) SmartFanII: Fan2 Level 3 */
> 	{ 0x98,		/* (bit3-0) SmartFanII: Fan3 Non-Stop */
> 	  0x98,		/* (bit7-4) SmartFanII: Fan3 Level 1 */
> 	  0xE2,		/* (bit7-4) SmartFanII: Fan3 Level 2 */
> 	  0xE2 }	/* (bit3-0) SmartFanII: Fan3 Level 3 */
> };
> 
> #define W83792D_REG_CONFIG		0x40
> #define W83792D_REG_IRQ			0x4C
> #define W83792D_REG_VID_FANDIV		0x47
> #define W83792D_REG_CHIPID		0x49
> #define W83792D_REG_WCHIPID		0x58
> #define W83792D_REG_CHIPMAN		0x4F
> #define W83792D_REG_PIN			0x4B
> #define W83792D_REG_I2C_SUBADDR		0x4A
> 
> #define W83792D_REG_CHASSIS 0x42	/* Bit 5: Case Open status bit */
> #define W83792D_REG_CHASSIS_CLR 0x44	/* Bit 7: Case Open CLR_CHS/Reset bit */
> 
> /* ctroll in0/in1 's limit modifiability */
perhap a typo ?

> #define W83792D_REG_VID_IN_B		0x17
> 
> #define W83792D_REG_VBAT		0x5D
> #define W83792D_REG_I2C_ADDR		0x48
> 
> /* Conversions. Rounding and limit checking is only done on the TO_REG
>    variants. Note that you should be a bit careful with which arguments
>    these macros are called: arguments may be evaluated more than once.
>    Fixing this is just not worth it. */
> #define IN_FROM_REG(nr,val) (((nr)<=1)?(val*2): \
> 			     ((((nr)=6)||((nr)=7))?(val*6):(val*4)))
> #define IN_TO_REG(nr,val) (((nr)<=1)?(val/2): \
> 			   ((((nr)=6)||((nr)=7))?(val/6):(val/4)))
> 
> static inline u8
> FAN_TO_REG(long rpm, int div)
> {

I'm not sure, but I think it should be like

static inline u8 FAN_TO_REG(long rpm, int div)
{


> 	if (rpm = 0)
> 		return 255;
> 	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
> 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
> }
> 
> #define FAN_FROM_REG(val,div)		((val) = 0   ? -1 : \
> 					((val) = 255 ? 0 : \
> 							1350000 / ((val) * (div))))
> 
> #define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
> 						: (val)) / 1000, 0, 0xff))
> #define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
> 
> #define PWM_FROM_REG(val)		(val)
> #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
> #define DIV_FROM_REG(val)		(1 << (val))
> 
> static inline u8
> DIV_TO_REG(long val)
> {

Same here?

> 	int i;
> 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
> 	for (i = 0; i < 6; i++) {
> 		if (val = 0)
> 			break;
> 		val >>= 1;
> 	}
> 	return ((u8) i);
> }
> 
> struct w83792d_data {
> 	struct i2c_client client;
> 	struct semaphore lock;
> 	enum chips type;
> 
> 	struct semaphore update_lock;
> 	char valid;		/* !=0 if following fields are valid */
> 	unsigned long last_updated;	/* In jiffies */
> 
> 	/* array of 2 pointers to subclients */
> 	struct i2c_client *lm75[2];

The subclients are lm75 compatible? (I think so), but I'm not sure about the name...

> 	u8 in[9];		/* Register value */
> 	u8 in_max[9];		/* Register value */
> 	u8 in_min[9];		/* Register value */
> 	u8 low_bits[2];		/* Register value */

Please comment that lowbits belong to IN, or choose better name for the variable

> 	u8 fan[7];		/* Register value */
> 	u8 fan_min[7];		/* Register value */
> 	u8 temp;
> 	u8 temp_max;		/* Register value */
> 	u8 temp_max_hyst;	/* Register value */
> 	u8 temp_add[2];	/* Register value */

Please align comment with tab to same col as above.

Also why is temp1 separated? why there is not temps[3] instead?


> 	u8 temp_max_add[2];	/* Register value */
> 	u8 temp_max_hyst_add[2];	/* Register value */

Big I and align too please

> 	u8 fan_div[7];		/* Register encoding, shifted right */
> 	u8 pwm[7];		/* We only consider the first 3 set of pwm,
> 				   although 792 chip has 7 set of pwm. */
> 	u8 pwmenable[3];
> 	u8 pwm_mode[7];	/* indicates PWM or DC mode: 1->PWM; 0->DC */
> 	u8 chassis;		/* Chassis status */
> 	u8 chassis_clear;	/* CLR_CHS, clear chassis intrusion detection */
> 	u8 thermal_cruise[3];	/* Smart FanI: Fan1,2,3 target value */
> 	u8 tolerance[3];	/* Fan1,2,3 tolerance(Smart Fan I/II) */
> 	u8 sf2_points[3][4];	/* Smart FanII: Fan1,2,3 temperature points */
> 	u8 sf2_levels[3][4];	/* Smart FanII: Fan1,2,3 duty cycle levels */
> };
> 
> static int w83792d_attach_adapter(struct i2c_adapter *adapter);
> static int w83792d_detect(struct i2c_adapter *adapter, int address, int kind);
> static int w83792d_detach_client(struct i2c_client *client);
> 
> static int w83792d_read_value(struct i2c_client *client, u8 register);
> static int w83792d_write_value(struct i2c_client *client, u8 register,
> 			       u8 value);
> static struct w83792d_data *w83792d_update_device(struct device *dev);
> 
> #ifdef W83792D_DEBUG
> static void w83792d_print_debug(struct w83792d_data *data);
> #endif

I think you can change it to:  #ifdef DEBUG

> static void w83792d_init_client(struct i2c_client *client);
> 
> static struct i2c_driver w83792d_driver = {
> 	.owner = THIS_MODULE,
> 	.name = "w83792d",
> 	.flags = I2C_DF_NOTIFY,
> 	.attach_adapter = w83792d_attach_adapter,
> 	.detach_client = w83792d_detach_client,
> };
> 
> static long in_count_from_reg(int nr, struct w83792d_data *data)
> {
> 	u16 vol_count = data->in[nr];
> 	u16 low_bits = 0;
> 	vol_count = (vol_count << 2);
> 	switch (nr)
> 	{
> 	case 0:  /* vin0 */
> 		low_bits = (data->low_bits[0]) & 0x03;
> 		break;
> 	case 1:  /* vin1 */
> 		low_bits = ((data->low_bits[0]) & 0x0c) >> 2;
> 		break;
> 	case 2:  /* vin2 */
> 		low_bits = ((data->low_bits[0]) & 0x30) >> 4;
> 		break;
> 	case 3:  /* vin3 */
> 		low_bits = ((data->low_bits[0]) & 0xc0) >> 6;
> 		break;
> 	case 4:  /* vin4 */
> 		low_bits = (data->low_bits[1]) & 0x03;
> 		break;
> 	case 5:  /* vin5 */
> 		low_bits = ((data->low_bits[1]) & 0x0c) >> 2;
> 		break;
> 	case 6:  /* vin6 */
> 		low_bits = ((data->low_bits[1]) & 0x30) >> 4;
> 	default:
> 		break;
> 	}
> 	vol_count = vol_count | low_bits;
> 	return vol_count;
> }
> 
> /* following are the sysfs callback functions */
> static ssize_t show_in(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf,"%ld\n", IN_FROM_REG(nr,(in_count_from_reg(nr, data))));
> }
> 
> #define show_in_reg(reg) \
> static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> { \
> 	struct w83792d_data *data = w83792d_update_device(dev); \
> 	return sprintf(buf,"%ld\n", (long)(IN_FROM_REG(nr, (data->reg[nr])*4))); \
> }
> 
> show_in_reg(in_min);
> show_in_reg(in_max);
> 
> #define store_in_reg(REG, reg) \
> static ssize_t store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
> { \
> 	struct i2c_client *client = to_i2c_client(dev); \
> 	struct w83792d_data *data = i2c_get_clientdata(client); \
> 	u32 val; \
> 	 \
> 	val = simple_strtoul(buf, NULL, 10); \
> 	data->in_##reg[nr] = SENSORS_LIMIT(IN_TO_REG(nr, val)/4, 0, 255); \
> 	w83792d_write_value(client, W83792D_REG_IN_##REG[nr], data->in_##reg[nr]); \
> 	 \
> 	return count; \
> }
> store_in_reg(MIN, min);
> store_in_reg(MAX, max);
> 
> #define sysfs_in_offset(offset) \
> static ssize_t \
> show_regs_in_##offset (struct device *dev, char *buf) \
> { \
> 	return show_in(dev, buf, offset); \
> } \
> static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
> 
> #define sysfs_in_reg_offset(reg, offset) \
> static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
> { \
> 	return show_in_##reg (dev, buf, offset); \
> } \
> static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count) \
> { \
> 	return store_in_##reg (dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset);
> 
> #define sysfs_in_offsets(offset) \
> sysfs_in_offset(offset); \
> sysfs_in_reg_offset(min, offset); \
> sysfs_in_reg_offset(max, offset);
> 
> sysfs_in_offsets(0);
> sysfs_in_offsets(1);
> sysfs_in_offsets(2);
> sysfs_in_offsets(3);
> sysfs_in_offsets(4);
> sysfs_in_offsets(5);
> sysfs_in_offsets(6);
> sysfs_in_offsets(7);
> sysfs_in_offsets(8);
> 
> #define device_create_file_in(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> } while (0)
> 
> #define show_fan_reg(reg) \
> static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> { \
> 	struct w83792d_data *data = w83792d_update_device(dev); \
> 	return sprintf(buf,"%ld\n", \
> 		FAN_FROM_REG(data->reg[nr-1], (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
> }
> show_fan_reg(fan);
> show_fan_reg(fan_min);
> 
> static ssize_t
> store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 	data->fan_min[nr - 1] > 	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));

Please use second tab instead of 4 spaces

> 	w83792d_write_value(client, W83792D_REG_FAN_MIN[nr-1],
> 			    data->fan_min[nr - 1]);
> 
> 	return count;
> }
> 
> #define sysfs_fan_offset(offset) \
> static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
> { \
> 	return show_fan(dev, buf, offset); \
> } \
> static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
> 
> #define sysfs_fan_min_offset(offset) \
> static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
> { \
> 	return show_fan_min(dev, buf, offset); \
> } \
> static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
> { \
> 	return store_fan_min(dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset);
> 
> sysfs_fan_offset(1);
> sysfs_fan_min_offset(1);
> sysfs_fan_offset(2);
> sysfs_fan_min_offset(2);
> sysfs_fan_offset(3);
> sysfs_fan_min_offset(3);
> sysfs_fan_offset(4);
> sysfs_fan_min_offset(4);
> sysfs_fan_offset(5);
> sysfs_fan_min_offset(5);
> sysfs_fan_offset(6);
> sysfs_fan_min_offset(6);
> sysfs_fan_offset(7);
> sysfs_fan_min_offset(7);
> 
> #define device_create_file_fan(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
> device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
> } while (0)
> 
> #define show_temp_reg(reg) \
> static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> { \
> 	struct w83792d_data *data = w83792d_update_device(dev); \
> 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
> 		return sprintf(buf,"%ld\n", \
> 			(long)TEMP_FROM_REG(data->reg##_add[nr-2])); \
> 	} else {	/* TEMP1 */ \
> 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
> 	} \
> }

Same question related here? Why temp1 separate?


> show_temp_reg(temp);
> show_temp_reg(temp_max);
> show_temp_reg(temp_max_hyst);
> 
> #define store_temp_reg(REG, reg) \
> static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
> { \
> 	struct i2c_client *client = to_i2c_client(dev); \
> 	struct w83792d_data *data = i2c_get_clientdata(client); \
> 	s32 val; \
> 	 \
> 	val = simple_strtol(buf, NULL, 10); \
> 	 \
> 	if (nr >= 2) { \
> 		data->temp_##reg##_add[nr-2] = TEMP_TO_REG(val); \
> 		w83792d_write_value(client, W83792D_REG_TEMP_##REG[nr-1], \
> 				data->temp_##reg##_add[nr-2]); \
> 	} else { \
> 		data->temp_##reg = TEMP_TO_REG(val); \
> 		w83792d_write_value(client, W83792D_REG_TEMP_##REG[nr-1], \
> 			data->temp_##reg); \
> 	} \
> 	 \
> 	return count; \
> }

Same question related here? Why temp1 separate?

> store_temp_reg(OVER, max);
> store_temp_reg(HYST, max_hyst);
> 
> #define sysfs_temp_offset(offset) \
> static ssize_t \
> show_regs_temp_##offset (struct device *dev, char *buf) \
> { \
> 	return show_temp(dev, buf, offset); \
> } \
> static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
> 
> #define sysfs_temp_reg_offset(reg, offset) \
> static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
> { \
> 	return show_temp_##reg (dev, buf, offset); \
> } \
> static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count) \
> { \
> 	return store_temp_##reg (dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
> 
> #define sysfs_temp_offsets(offset) \
> sysfs_temp_offset(offset); \
> sysfs_temp_reg_offset(max, offset); \
> sysfs_temp_reg_offset(max_hyst, offset);
> 
> sysfs_temp_offsets(1);
> sysfs_temp_offsets(2);
> sysfs_temp_offsets(3);
> 
> #define device_create_file_temp(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
> device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
> device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
> } while (0)
> 
> static ssize_t
> show_fan_div_reg(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n",
> 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
> }
> 
> /* Note: we save and restore the fan minimum here, because its value is
>    determined in part by the fan divisor.  This follows the principle of
>    least suprise; the user doesn't expect the fan minimum to change just
>    because the divisor changed. */
> static ssize_t
> store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	unsigned long min;
> 	/*u8 reg;*/

Please remove

> 	u8 fan_div_reg=0; u8 tmp_fan_div;

Please separate them on two lines.

> 	/* Save fan_min */
> 	min = FAN_FROM_REG(data->fan_min[nr],
> 			   DIV_FROM_REG(data->fan_div[nr]));
> 
> 	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
> 
> 	fan_div_reg = w83792d_read_value(client, W83792D_REG_FAN_DIV[nr/2]);

	nr/2 could be [nr >> 1]

> 	fan_div_reg &= (nr%2 = 0) ? 0xf8 : 0x8f;

	and here

fan_div_reg &= (nr & 1) ? 0x8f : 0xf8;

> 	tmp_fan_div = (nr%2 = 0) ? ((data->fan_div[nr])&0x07)
> 					: (((data->fan_div[nr])<<4)&0x70);

This needs definetly spaces between operators but it can be also done this way:

 	tmp_fan_div = (nr & 1) ? ((data->fan_div[nr] << 4) & 0x70)
					: data->fan_div[nr] & 0x07;

	

> 	w83792d_write_value(client, W83792D_REG_FAN_DIV[nr/2],

 nr >> 1
> 					fan_div_reg|tmp_fan_div);
> 
> 	/* Restore fan_min */
> 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
> 	w83792d_write_value(client, W83792D_REG_FAN_MIN[nr], data->fan_min[nr]);
> 
> 	return count;
> }
> 
> #define sysfs_fan_div(offset) \
> static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
> { \
> 	return show_fan_div_reg(dev, buf, offset); \
> } \
> static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
> { \
> 	return store_fan_div_reg(dev, buf, count, offset - 1); \
> } \
> static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset);
> 
> sysfs_fan_div(1);
> sysfs_fan_div(2);
> sysfs_fan_div(3);
> sysfs_fan_div(4);
> sysfs_fan_div(5);
> sysfs_fan_div(6);
> sysfs_fan_div(7);
> 
> #define device_create_file_fan_div(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
> } while (0)
> 
> static ssize_t
> show_pwm_reg(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr-1]));
> }
> 
> static ssize_t
> show_pwmenable_reg(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	long pwm_enable_tmp = 1;

Should be u32 instead?

> 	if (data->pwmenable[nr-1] = 0) {
> 		pwm_enable_tmp = 1; /* manual mode */
> 	} else if (data->pwmenable[nr-1] = 1) {
> 		pwm_enable_tmp = 3; /* thermal cruise/Smart Fan I */
> 	} else if (data->pwmenable[nr-1] = 2) {
> 		pwm_enable_tmp = 2; /* Smart Fan II */
> 	}
> 	return sprintf(buf, "%ld\n", pwm_enable_tmp);
> }
> 
> static ssize_t
> store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	data->pwm[nr-1] = PWM_TO_REG(val);
> 	w83792d_write_value(client, W83792D_REG_PWM[nr-1], data->pwm[nr-1]);
> 
> 	return count;
> }
> 
> static ssize_t
> store_pwmenable_reg(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 fan_cfg_tmp, cfg1_tmp, cfg2_tmp, cfg3_tmp, cfg4_tmp;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	switch (val) {
> 	case 1:
> 		data->pwmenable[nr-1] = 0; /* manual mode */
> 		break;
> 	case 2:
> 		data->pwmenable[nr-1] = 2; /* Smart Fan II */
> 		break;
> 	case 3:
> 		data->pwmenable[nr-1] = 1; /* thermal cruise/Smart Fan I */
> 		break;
> 	default:
> 		return -EINVAL;
> 	}
> 	cfg1_tmp = data->pwmenable[0];
> 	cfg2_tmp = (data->pwmenable[1]) << 2;
> 	cfg3_tmp = (data->pwmenable[2]) << 4;
> 	cfg4_tmp = w83792d_read_value(client,W83792D_REG_FAN_CFG) & 0xc0;
> 	fan_cfg_tmp = ((cfg4_tmp|cfg3_tmp)|cfg2_tmp)|cfg1_tmp;

Missing spaces
fan_cfg_tmp = ((cfg4_tmp | cfg3_tmp) | cfg2_tmp) | cfg1_tmp;

> 	w83792d_write_value(client,W83792D_REG_FAN_CFG,fan_cfg_tmp);
> 
> 	return count;
> }
> 
> #define sysfs_pwm(offset) \
> static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
> { \
> 	return show_pwm_reg(dev, buf, offset); \
> } \
> static ssize_t store_regs_pwm_##offset (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_pwm_reg(dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
> 		show_regs_pwm_##offset, store_regs_pwm_##offset);
> 
> #define sysfs_pwmenable(offset) \
> static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
> { \
> 	return show_pwmenable_reg(dev, buf, offset); \
> } \
> static ssize_t store_regs_pwmenable_##offset (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_pwmenable_reg(dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, \
> 		show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
> 
> sysfs_pwm(1);
> sysfs_pwm(2);
> sysfs_pwm(3);
> sysfs_pwmenable(1);
> sysfs_pwmenable(2);
> sysfs_pwmenable(3);
> 
> #define device_create_file_pwm(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_pwm##offset); \
> } while (0)
> 
> #define device_create_file_pwmenable(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
> } while (0)
> 
> 
> static ssize_t
> show_pwm_mode_reg(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)data->pwm_mode[nr-1]);
> }
> 
> static ssize_t
> store_pwm_mode_reg(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 pwm_mode_mask = 0;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 	data->pwm_mode[nr-1] = SENSORS_LIMIT(val, 0, 1);
> 	pwm_mode_mask = w83792d_read_value(client,
> 		W83792D_REG_PWM[nr-1]) & 0x7f;
> 	w83792d_write_value(client, W83792D_REG_PWM[nr-1],
> 		((data->pwm_mode[nr-1])<<7)|pwm_mode_mask);
> 
> 	return count;
> }
> 
> #define sysfs_pwm_mode(offset) \
> static ssize_t show_regs_pwm_mode_##offset (struct device *dev, char *buf) \
> { \
> 	return show_pwm_mode_reg(dev, buf, offset); \
> } \
> static ssize_t store_regs_pwm_mode_##offset (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_pwm_mode_reg(dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(pwm##offset##_mode, S_IRUGO | S_IWUSR, \
> 		show_regs_pwm_mode_##offset, store_regs_pwm_mode_##offset);
> 
> sysfs_pwm_mode(1);
> sysfs_pwm_mode(2);
> sysfs_pwm_mode(3);
> 
> #define device_create_file_pwm_mode(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_pwm##offset##_mode); \
> } while (0)
> 
> 
> static ssize_t
> show_chassis_reg(struct device *dev, char *buf)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)data->chassis);
> }
> 
> static ssize_t show_regs_chassis (struct device *dev, char *buf)
> {
> 	return show_chassis_reg(dev, buf);
> }
> 
> static DEVICE_ATTR(chassis, S_IRUGO, show_regs_chassis, NULL);
> 
> #define device_create_file_chassis(client) \
> do { \
> device_create_file(&client->dev, &dev_attr_chassis); \
> } while (0)
> 
> 
> static ssize_t
> show_chassis_clear_reg(struct device *dev, char *buf)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)data->chassis_clear);
> }
> 
> static ssize_t
> store_chassis_clear_reg(struct device *dev, const char *buf, size_t count)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 temp1 = 0, temp2 = 0;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	data->chassis_clear = SENSORS_LIMIT(val, 0 ,1);
> 	temp1 = ((data->chassis_clear) << 7) & 0x80;
> 	temp2 = w83792d_read_value(client,
> 		W83792D_REG_CHASSIS_CLR) & 0x7f;
> 	w83792d_write_value(client, W83792D_REG_CHASSIS_CLR, temp1|temp2);

Missing spaces between |

> 
> 	return count;
> }
> 
> static ssize_t show_regs_chassis_clear (struct device *dev, char *buf)
> {
> 	return show_chassis_clear_reg(dev, buf);
> }
> 
> static ssize_t store_regs_chassis_clear (struct device *dev,
> 		const char *buf, size_t count)
> {
> 	return store_chassis_clear_reg(dev, buf, count);
> }
> 
> static DEVICE_ATTR(chassis_clear, S_IRUGO | S_IWUSR,
> 		show_regs_chassis_clear, store_regs_chassis_clear);
> 
> #define device_create_file_chassis_clear(client) \
> do { \
> device_create_file(&client->dev, &dev_attr_chassis_clear); \
> } while (0)
> 
> 
> 
> /* For Smart Fan I / Thermal Cruise */
> static ssize_t
> show_thermal_cruise_reg(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)data->thermal_cruise[nr-1]);
> }
> 
> static ssize_t
> store_thermal_cruise_reg(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 target_tmp=0, target_mask=0;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	target_tmp = val;
> 	target_tmp = target_tmp & 0x7f;
> 	target_mask = w83792d_read_value(client, W83792D_REG_THERMAL[nr-1]) & 0x80;
> 	data->thermal_cruise[nr-1] = SENSORS_LIMIT(target_tmp, 0, 255);
> 	w83792d_write_value(client, W83792D_REG_THERMAL[nr-1],
> 		(data->thermal_cruise[nr-1])|target_mask);

Missing spaces between |

> 
> 	return count;
> }
> 
> #define sysfs_thermal_cruise(offset) \
> static ssize_t show_regs_thermal_cruise##offset (struct device *dev, char *buf) \
> { \
> 	return show_thermal_cruise_reg(dev, buf, offset); \
> } \
> static ssize_t store_regs_thermal_cruise##offset (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_thermal_cruise_reg(dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(thermal_cruise##offset, S_IRUGO | S_IWUSR, \
> 		show_regs_thermal_cruise##offset, store_regs_thermal_cruise##offset);
> 
> sysfs_thermal_cruise(1);
> sysfs_thermal_cruise(2);
> sysfs_thermal_cruise(3);
> 
> #define device_create_file_thermal_cruise(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_thermal_cruise##offset); \
> } while (0)
> 
> 
> /* For Smart Fan I/Thermal Cruise and Smart Fan II */
> static ssize_t
> show_tolerance_reg(struct device *dev, char *buf, int nr)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)data->tolerance[nr-1]);
> }
> 
> static ssize_t
> store_tolerance_reg(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 tol_tmp, tol_mask;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	tol_mask = w83792d_read_value(client,
> 		W83792D_REG_TOLERANCE[nr-1]) & ((nr=2)?0x0f:0xf0);

Missing spaces: ((nr = 2) ? 0x0f : 0xf0);

> 	tol_tmp = SENSORS_LIMIT(val, 0, 15);
> 	tol_tmp &= 0x0f;
> 	data->tolerance[nr-1] = tol_tmp;
> 	if (nr=2) {
> 		tol_tmp <<= 4;
> 	}
> 	w83792d_write_value(client, W83792D_REG_TOLERANCE[nr-1],
> 		tol_mask|tol_tmp);

Missing spaces between |

> 
> 	return count;
> }
> 
> #define sysfs_tolerance(offset) \
> static ssize_t show_regs_tolerance##offset (struct device *dev, char *buf) \
> { \
> 	return show_tolerance_reg(dev, buf, offset); \
> } \
> static ssize_t store_regs_tolerance##offset (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_tolerance_reg(dev, buf, count, offset); \
> } \
> static DEVICE_ATTR(tolerance##offset, S_IRUGO | S_IWUSR, \
> 		show_regs_tolerance##offset, store_regs_tolerance##offset);
> 
> sysfs_tolerance(1);
> sysfs_tolerance(2);
> sysfs_tolerance(3);
> 
> #define device_create_file_tolerance(client, offset) \
> do { \
> device_create_file(&client->dev, &dev_attr_tolerance##offset); \
> } while (0)
> 
> 
> /* For Smart Fan II */
> static ssize_t
> show_sf2_point_reg(struct device *dev, char *buf, int nr, int index)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)data->sf2_points[index-1][nr-1]);
> }
> 
> static ssize_t
> store_sf2_point_reg(struct device *dev, const char *buf, size_t count, int nr, int index)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 mask_tmp = 0;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	data->sf2_points[index-1][nr-1] = SENSORS_LIMIT(val, 0, 127);
> 	mask_tmp = w83792d_read_value(client,
> 		W83792D_REG_POINTS[index-1][nr-1]) & 0x80;
> 	w83792d_write_value(client, W83792D_REG_POINTS[index-1][nr-1],
> 		mask_tmp|data->sf2_points[index-1][nr-1]);
> 
> 	return count;
> }
> 
> #define sysfs_sf2_point(offset, index) \
> static ssize_t show_regs_sf2_point##offset##_fan##index (struct device *dev, char *buf) \
> { \
> 	return show_sf2_point_reg(dev, buf, offset, index); \
> } \
> static ssize_t store_regs_sf2_point##offset##_fan##index (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_sf2_point_reg(dev, buf, count, offset, index); \
> } \
> static DEVICE_ATTR(sf2_point##offset##_fan##index, S_IRUGO | S_IWUSR, \
> 		show_regs_sf2_point##offset##_fan##index, \
> 		store_regs_sf2_point##offset##_fan##index);
> 
> sysfs_sf2_point(1, 1);	/* Fan1 */
> sysfs_sf2_point(2, 1);	/* Fan1 */
> sysfs_sf2_point(3, 1);	/* Fan1 */
> sysfs_sf2_point(4, 1);	/* Fan1 */
> sysfs_sf2_point(1, 2);	/* Fan2 */
> sysfs_sf2_point(2, 2);	/* Fan2 */
> sysfs_sf2_point(3, 2);	/* Fan2 */
> sysfs_sf2_point(4, 2);	/* Fan2 */
> sysfs_sf2_point(1, 3);	/* Fan3 */
> sysfs_sf2_point(2, 3);	/* Fan3 */
> sysfs_sf2_point(3, 3);	/* Fan3 */
> sysfs_sf2_point(4, 3);	/* Fan3 */
> 
> #define device_create_file_sf2_point(client, offset, index) \
> do { \
> device_create_file(&client->dev, &dev_attr_sf2_point##offset##_fan##index); \
> } while (0)
> 
> 
> static ssize_t
> show_sf2_level_reg(struct device *dev, char *buf, int nr, int index)
> {
> 	struct w83792d_data *data = w83792d_update_device(dev);
> 	return sprintf(buf, "%ld\n", (long)(((data->sf2_levels[index-1][nr])*100)/15));

Missing spaces

> }
> 
> static ssize_t
> store_sf2_level_reg(struct device *dev, const char *buf, size_t count, int nr, int index)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	u32 val;
> 	u8 mask_tmp=0, level_tmp=0;
> 
> 	val = simple_strtoul(buf, NULL, 10);
> 
> 	data->sf2_levels[index-1][nr] > 		SENSORS_LIMIT((val*15)/100, 0, 15);

And here too it seems

> 	mask_tmp = w83792d_read_value(client, W83792D_REG_LEVELS[index-1][nr])
> 		& ((nr=3) ? 0xf0 : 0x0f);
> 	if (nr=3) {
> 		level_tmp = data->sf2_levels[index-1][nr];
> 	} else {
> 		level_tmp = data->sf2_levels[index-1][nr] << 4;
> 	}
> 	w83792d_write_value(client, W83792D_REG_LEVELS[index-1][nr], level_tmp | mask_tmp);
> 
> 	return count;
> }
> 
> #define sysfs_sf2_level(offset, index) \
> static ssize_t show_regs_sf2_level##offset##_fan##index (struct device *dev, char *buf) \
> { \
> 	return show_sf2_level_reg(dev, buf, offset, index); \
> } \
> static ssize_t store_regs_sf2_level##offset##_fan##index (struct device *dev, \
> 		const char *buf, size_t count) \
> { \
> 	return store_sf2_level_reg(dev, buf, count, offset, index); \
> } \
> static DEVICE_ATTR(sf2_level##offset##_fan##index, S_IRUGO | S_IWUSR, \
> 		show_regs_sf2_level##offset##_fan##index, \
> 		store_regs_sf2_level##offset##_fan##index);
> 
> 
> sysfs_sf2_level(1, 1);	/* Fan1 */
> sysfs_sf2_level(2, 1);	/* Fan1 */
> sysfs_sf2_level(3, 1);	/* Fan1 */
> sysfs_sf2_level(1, 2);	/* Fan2 */
> sysfs_sf2_level(2, 2);	/* Fan2 */
> sysfs_sf2_level(3, 2);	/* Fan2 */
> sysfs_sf2_level(1, 3);	/* Fan3 */
> sysfs_sf2_level(2, 3);	/* Fan3 */
> sysfs_sf2_level(3, 3);	/* Fan3 */
> 
> #define device_create_file_sf2_level(client, offset, index) \
> do { \
> device_create_file(&client->dev, &dev_attr_sf2_level##offset##_fan##index); \
> } while (0)
> 
> 
> /* This function is called when:
>      * w83792d_driver is inserted (when this module is loaded), for each
>        available adapter
>      * when a new adapter is inserted (and w83792d_driver is still present) */
> static int
> w83792d_attach_adapter(struct i2c_adapter *adapter)

I think static int and rest belong to one line

> {
> 	if (!(adapter->class & I2C_CLASS_HWMON))
> 		return 0;
> 	return i2c_detect(adapter, &addr_data, w83792d_detect);
> }
> 
> 
> static int
> w83792d_detect_subclients(struct i2c_adapter *adapter, int address, int kind,
> 		struct i2c_client *new_client)

and here too

> {
> 	int i, id, err;
> 	struct w83792d_data *data = i2c_get_clientdata(new_client);
> 
> 	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
> 	if (!(data->lm75[0])) {
> 		err = -ENOMEM;
> 		goto ERROR_SC_0;
> 	}
> 	memset(data->lm75[0], 0x00, sizeof(struct i2c_client));
> 
> 	data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
> 	if (!(data->lm75[1])) {
> 		err = -ENOMEM;
> 		goto ERROR_SC_1;
> 	}
> 	memset(data->lm75[1], 0x00, sizeof(struct i2c_client));
> 
> 	id = i2c_adapter_id(adapter);
> 
> 	if (force_subclients[0] = id && force_subclients[1] = address) {
> 		for (i = 2; i <= 3; i++) {
> 			if (force_subclients[i] < 0x48 ||
> 			    force_subclients[i] > 0x4f) {
> 				dev_err(&new_client->dev, "invalid subclient "
> 					"address %d; must be 0x48-0x4f\n",
> 					force_subclients[i]);
> 				err = -ENODEV;
> 				goto ERROR_SC_2;
> 			}
> 		}
> 		w83792d_write_value(new_client, W83792D_REG_I2C_SUBADDR,
> 					(force_subclients[2] & 0x03) |
> 					((force_subclients[3] & 0x03) <<4));
> 		data->lm75[0]->addr = force_subclients[2];
> 		data->lm75[1]->addr = force_subclients[3];
> 	} else {
> 		int val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);

This should be u8 val 
> 		data->lm75[0]->addr = 0x48 + (val & 0x07);
> 		data->lm75[1]->addr = 0x48 + ((val >> 4) & 0x07);
> 	}
> 
> 	if (data->lm75[0]->addr = data->lm75[1]->addr) {
> 		dev_err(&new_client->dev, "duplicate addresses 0x%x "
> 				"for subclients\n", data->lm75[0]->addr);
> 		err = -ENODEV;
> 		goto ERROR_SC_2;
> 	}
> 
> 	for (i = 0; i <= 1; i++) {
> 		i2c_set_clientdata(data->lm75[i], NULL);
> 		data->lm75[i]->adapter = adapter;
> 		data->lm75[i]->driver = &w83792d_driver;
> 		data->lm75[i]->flags = 0;
> 		strlcpy(data->lm75[i]->name, "w83792d subclient", I2C_NAME_SIZE);
> 	}
> 
> 	if ((err = i2c_attach_client(data->lm75[0]))) {
> 		dev_err(&new_client->dev, "subclient %d registration "
> 			"at address 0x%x failed.\n", i, data->lm75[0]->addr);
> 		goto ERROR_SC_2;
> 	}
> 
> 	if ((err = i2c_attach_client(data->lm75[1]))) {
> 		dev_err(&new_client->dev, "subclient %d registration "
> 			"at address 0x%x failed.\n", i, data->lm75[1]->addr);
> 		goto ERROR_SC_3;
> 	}
> 
> 	return 0;
> 
> /* Undo inits in case of errors */
> ERROR_SC_3:
> 	i2c_detach_client(data->lm75[0]);
> ERROR_SC_2:
> 	kfree(data->lm75[1]);
> ERROR_SC_1:
> 	kfree(data->lm75[0]);
> ERROR_SC_0:
> 	return err;
> }
> 
> 
> static int
> w83792d_detect(struct i2c_adapter *adapter, int address, int kind)
> {

Same line?

> 	int i = 0, val1 = 0, val2;
> 	struct i2c_client *new_client;
> 	struct w83792d_data *data;
> 	int err = 0;
> 	const char *client_name = "";
> 
> 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> 		goto ERROR0;
> 	}
> 
> 	/* OK. For now, we presume we have a valid client. We now create the
> 	   client structure, even though we cannot fill it completely yet.
> 	   But it allows us to access w83792d_{read,write}_value. */
> 
> 	if (!(data = kmalloc(sizeof(struct w83792d_data), GFP_KERNEL))) {
> 		err = -ENOMEM;
> 		goto ERROR0;
> 	}
> 	memset(data, 0, sizeof(struct w83792d_data));
> 
> 	new_client = &data->client;
> 	i2c_set_clientdata(new_client, data);
> 	new_client->addr = address;
> 	init_MUTEX(&data->lock);
> 	new_client->adapter = adapter;
> 	new_client->driver = &w83792d_driver;
> 	new_client->flags = 0;
> 
> 	/* Now, we do the remaining detection. */
> 
> 	/* The w8378?d may be stuck in some other bank than bank 0. This may

Bad chip name in comment

> 	   make reading other information impossible. Specify a force=... or
> 	   force_*=... parameter, and the Winbond will be reset to the right
> 	   bank. */
> 	if (kind < 0) {
> 		if (w83792d_read_value(new_client, W83792D_REG_CONFIG) & 0x80) {
> 			dev_warn(&new_client->dev, "Detection failed at step "
> 				"3\n");
> 			goto ERROR1;
> 		}
> 		val1 = w83792d_read_value(new_client, W83792D_REG_BANK);
> 		val2 = w83792d_read_value(new_client, W83792D_REG_CHIPMAN);
> 		/* Check for Winbond ID if in bank 0 */
> 		if (!(val1 & 0x07)) {  /* is Bank0 */
> 			if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
> 			     ((val1 & 0x80) && (val2 != 0x5c))) {
> 				goto ERROR1;
> 			}
> 		}
> 		/* If Winbond SMBus, check address at 0x48 */

better comment would be:

If Winbond chip, address of chip and W83792D_REG_I2C_ADDR should match.

> 		if (w83792d_read_value(new_client, W83792D_REG_I2C_ADDR) != address) {
> 			dev_warn(&new_client->dev, "Detection failed "
> 				"at step 5\n");
> 			goto ERROR1;
> 		}
> 	}
> 
> 	/* We have either had a force parameter, or we have already detected the
> 	   Winbond. Put it now into bank 0 and Vendor ID High Byte */

> 	w83792d_write_value(new_client, W83792D_REG_BANK,
> 			    (w83792d_read_value(new_client,
> 						W83792D_REG_BANK) & 0x78) |
> 			    0x80);
> 

Maybe better indent?


> 	/* Determine the chip type. */
> 	if (kind <= 0) {
> 		/* get vendor ID */
> 		val2 = w83792d_read_value(new_client, W83792D_REG_CHIPMAN);
> 		if (val2 != 0x5c) {  /* the vendor is NOT Winbond */
> 			goto ERROR1;
> 		}
> 		val1 = w83792d_read_value(new_client, W83792D_REG_WCHIPID);
> 		if (val1 = 0x7a && address >= 0x2c) {
> 			kind = w83792d;
> 		} else {
> 			if (kind = 0)
> 				printk
> 				    (KERN_WARNING "w83792d: Ignoring 'force' parameter for unknown chip at"
> 				     "adapter %d, address 0x%02x\n",
> 				     i2c_adapter_id(adapter), address);
> 			goto ERROR1;
> 		}
> 	}
> 
> 	if (kind = w83792d) {
> 		client_name = "w83792d";
> 	} else {
> 		dev_warn(&new_client->dev, "w83792d: Internal error: unknown kind (%d)?!?",
> 		       kind);
> 		goto ERROR1;
> 	}
> 
> 	/* Fill in the remaining client fields and put into the global list */
> 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
> 	data->type = kind;
> 
> 	data->valid = 0;
> 	init_MUTEX(&data->update_lock);
> 
> 	/* Tell the I2C layer a new client has arrived */
> 	if ((err = i2c_attach_client(new_client)))
> 		goto ERROR1;
> 
> 	if ((err = w83792d_detect_subclients(adapter, address,
> 			kind, new_client)))
> 		goto ERROR2;
> 
> 	/* Initialize the chip */
> 	w83792d_init_client(new_client);
> 
> 	/* A few vars need to be filled upon startup */
> 	for (i = 1; i <= 7; i++) {
> 		data->fan_min[i - 1] = w83792d_read_value(new_client,
> 					W83792D_REG_FAN_MIN[i]);
> 	}

hmm really? why not it init_client?

> 
> 	/* Register sysfs hooks */
> 	device_create_file_in(new_client, 0);
> 	device_create_file_in(new_client, 1);
> 	device_create_file_in(new_client, 2);
> 	device_create_file_in(new_client, 3);
> 	device_create_file_in(new_client, 4);
> 	device_create_file_in(new_client, 5);
> 	device_create_file_in(new_client, 6);
> 	device_create_file_in(new_client, 7);
> 	device_create_file_in(new_client, 8);
> 
> 	device_create_file_fan(new_client, 1);
> 	device_create_file_fan(new_client, 2);
> 	device_create_file_fan(new_client, 3);
> 	device_create_file_fan(new_client, 4);
> 	device_create_file_fan(new_client, 5);
> 	device_create_file_fan(new_client, 6);
> 	device_create_file_fan(new_client, 7);
> 
> 	device_create_file_temp(new_client, 1);
> 	device_create_file_temp(new_client, 2);
> 	device_create_file_temp(new_client, 3);
> 
> 	device_create_file_fan_div(new_client, 1);
> 	device_create_file_fan_div(new_client, 2);
> 	device_create_file_fan_div(new_client, 3);
> 	device_create_file_fan_div(new_client, 4);
> 	device_create_file_fan_div(new_client, 5);
> 	device_create_file_fan_div(new_client, 6);
> 	device_create_file_fan_div(new_client, 7);
> 
> 	device_create_file_pwm(new_client, 1);
> 	device_create_file_pwm(new_client, 2);
> 	device_create_file_pwm(new_client, 3);
> 
> 	device_create_file_pwmenable(new_client, 1);
> 	device_create_file_pwmenable(new_client, 2);
> 	device_create_file_pwmenable(new_client, 3);
> 
> 	device_create_file_pwm_mode(new_client, 1);
> 	device_create_file_pwm_mode(new_client, 2);
> 	device_create_file_pwm_mode(new_client, 3);
> 
> 	device_create_file_chassis(new_client);
> 	device_create_file_chassis_clear(new_client);
> 
> 	device_create_file_thermal_cruise(new_client, 1);
> 	device_create_file_thermal_cruise(new_client, 2);
> 	device_create_file_thermal_cruise(new_client, 3);
> 
> 	device_create_file_tolerance(new_client, 1);
> 	device_create_file_tolerance(new_client, 2);
> 	device_create_file_tolerance(new_client, 3);
> 
> 	device_create_file_sf2_point(new_client, 1, 1);	/* Fan1 */
> 	device_create_file_sf2_point(new_client, 2, 1);	/* Fan1 */
> 	device_create_file_sf2_point(new_client, 3, 1);	/* Fan1 */
> 	device_create_file_sf2_point(new_client, 4, 1);	/* Fan1 */
> 	device_create_file_sf2_point(new_client, 1, 2);	/* Fan2 */
> 	device_create_file_sf2_point(new_client, 2, 2);	/* Fan2 */
> 	device_create_file_sf2_point(new_client, 3, 2);	/* Fan2 */
> 	device_create_file_sf2_point(new_client, 4, 2);	/* Fan2 */
> 	device_create_file_sf2_point(new_client, 1, 3);	/* Fan3 */
> 	device_create_file_sf2_point(new_client, 2, 3);	/* Fan3 */
> 	device_create_file_sf2_point(new_client, 3, 3);	/* Fan3 */
> 	device_create_file_sf2_point(new_client, 4, 3);	/* Fan3 */
> 
> 	device_create_file_sf2_level(new_client, 1, 1);	/* Fan1 */
> 	device_create_file_sf2_level(new_client, 2, 1);	/* Fan1 */
> 	device_create_file_sf2_level(new_client, 3, 1);	/* Fan1 */
> 	device_create_file_sf2_level(new_client, 1, 2);	/* Fan2 */
> 	device_create_file_sf2_level(new_client, 2, 2);	/* Fan2 */
> 	device_create_file_sf2_level(new_client, 3, 2);	/* Fan2 */
> 	device_create_file_sf2_level(new_client, 1, 3);	/* Fan3 */
> 	device_create_file_sf2_level(new_client, 2, 3);	/* Fan3 */
> 	device_create_file_sf2_level(new_client, 3, 3);	/* Fan3 */
> 
> 	return 0;
> 
> ERROR2:
> 	i2c_detach_client(new_client);
> ERROR1:
> 	kfree(data);
> ERROR0:
> 	return err;
> }
> 
> static int
> w83792d_detach_client(struct i2c_client *client)

I think one line too.

> {
> 	int err;
> 
> 	if ((err = i2c_detach_client(client))) {
> 		dev_err(&client->dev,
> 		       "Client deregistration failed, client not detached.\n");
> 		return err;
> 	}
> 
> 	if (i2c_get_clientdata(client)=NULL) {
> 		/* subclients */
> 		kfree(client);
> 	} else {
> 		/* main client */
> 		kfree(i2c_get_clientdata(client));
> 	}
> 
> 	return 0;
> }
> 
> /* The SMBus locks itself, usually, but nothing may access the Winbond between
>    bank switches. ISA access must always be locked explicitly! 
>    We ignore the W83792D BUSY flag at this moment - it could lead to deadlocks,
>    would slow down the W83792D access and should not be necessary. 
>    There are some ugly typecasts here, but the good news is - they should
>    nowhere else be necessary! */
> static int
> w83792d_read_value(struct i2c_client *client, u8 reg)

I think one line too.
> {
> 	int res=0;
> 	res = i2c_smbus_read_byte_data(client, reg);
> 
> 	return res;
> }
> 
> static int
> w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)

I think one line too.

> {
> 	i2c_smbus_write_byte_data(client, reg,  value);
> 	return 0;
> }
> 
> /* Called when we have found a new W83792D. It should set limits, etc. */
> static void
> w83792d_init_client(struct i2c_client *client)
> {
> 	int temp2_cfg, temp3_cfg, i=0;

should not be u8 ? (except of i)

> 	u8 vid_in_b;
> 
> 	if (init) {
> 		w83792d_write_value(client, W83792D_REG_CONFIG, 0x80);
> 	}
> 	/* Clear the bit6 of W83792D_REG_VID_IN_B(set it into 0):
> 	   W83792D_REG_VID_IN_B bit6 = 0: the high/low limit of
> 	     vin0/vin1 can be modified by user;
> 	   W83792D_REG_VID_IN_B bit6 = 1: the high/low limit of
> 	     vin0/vin1 auto-updated, can NOT be modified by user. */
> 	vid_in_b = w83792d_read_value(client, W83792D_REG_VID_IN_B);
> 	w83792d_write_value(client, W83792D_REG_VID_IN_B,
> 			    vid_in_b & 0xbf);
> 
> 	temp2_cfg = w83792d_read_value(client, W83792D_REG_TEMP2_CONFIG);
> 	temp3_cfg = w83792d_read_value(client, W83792D_REG_TEMP3_CONFIG);
> 	w83792d_write_value(client, W83792D_REG_TEMP2_CONFIG,
> 				temp2_cfg & 0xe6);
> 	w83792d_write_value(client, W83792D_REG_TEMP3_CONFIG,
> 				temp3_cfg & 0xe6);
> 
> 	/* enable comparator mode for temp2 and temp3 so
> 	   alarm indication will work correctly */
> 	i = w83792d_read_value(client, W83792D_REG_IRQ);
> 	if (!(i & 0x40)) {
> 		w83792d_write_value(client, W83792D_REG_IRQ,
> 				    i | 0x40);
> 	}
> 
> 	/* Start monitoring */
> 	w83792d_write_value(client, W83792D_REG_CONFIG,
> 			    (w83792d_read_value(client,
> 						W83792D_REG_CONFIG) & 0xf7)
> 			    | 0x01);
> }
> 
> static struct w83792d_data *w83792d_update_device(struct device *dev)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct w83792d_data *data = i2c_get_clientdata(client);
> 	int i, j;
> 	u8 reg_array_tmp[4], pwm_array_tmp[7], reg_tmp;
> 
> 	down(&data->update_lock);
> 
> 	if (time_after
> 	    (jiffies - data->last_updated, (unsigned long) (HZ * 3))
> 	    || time_before(jiffies, data->last_updated) || !data->valid) {
> 		dev_warn(dev, "Starting device update\n");
> 
> 		/* Update the voltages measured value and limits */
> 		for (i = 0; i < 9; i++) {
> 			data->in[i] = w83792d_read_value(client,
> 						W83792D_REG_IN[i]);
> 			data->in_max[i] = w83792d_read_value(client,
> 						W83792D_REG_IN_MAX[i]);
> 			data->in_min[i] = w83792d_read_value(client,
> 						W83792D_REG_IN_MIN[i]);
> 		}
> 		data->low_bits[0] = w83792d_read_value(client,
> 						W83792D_REG_LOW_BITS1);
> 		data->low_bits[1] = w83792d_read_value(client,
> 						W83792D_REG_LOW_BITS2);
> 		for (i = 0; i < 7; i++) {
> 			/* Update the Fan measured value and limits */
> 			data->fan[i] = w83792d_read_value(client,
> 						W83792D_REG_FAN[i]);
> 			data->fan_min[i] = w83792d_read_value(client,
> 						W83792D_REG_FAN_MIN[i]);
> 			/* Update the PWM/DC Value and PWM/DC flag */
> 			pwm_array_tmp[i] = w83792d_read_value(client,
> 						W83792D_REG_PWM[i]);
> 			data->pwm[i] = pwm_array_tmp[i] & 0x0f;
> 			data->pwm_mode[i] = (pwm_array_tmp[i] >> 7) & 0x01;
> 		}
> 
> 		reg_tmp = w83792d_read_value(client, W83792D_REG_FAN_CFG);
> 		data->pwmenable[0] = reg_tmp & 0x03;
> 		data->pwmenable[1] = (reg_tmp>>2) & 0x03;
> 		data->pwmenable[2] = (reg_tmp>>4) & 0x03;
> 
> 		data->temp = w83792d_read_value(client, W83792D_REG_TEMP[0]);
> 		data->temp_max > 		    w83792d_read_value(client, W83792D_REG_TEMP_OVER[0]);
> 		data->temp_max_hyst > 		    w83792d_read_value(client, W83792D_REG_TEMP_HYST[0]);
> 		data->temp_add[0] > 		    w83792d_read_value(client, W83792D_REG_TEMP[1]);
> 		data->temp_max_add[0] > 		    w83792d_read_value(client, W83792D_REG_TEMP_OVER[1]);
> 		data->temp_max_hyst_add[0] > 		    w83792d_read_value(client, W83792D_REG_TEMP_HYST[1]);
> 		data->temp_add[1] > 		    w83792d_read_value(client, W83792D_REG_TEMP[2]);
> 		data->temp_max_add[1] > 		    w83792d_read_value(client,
> 				       W83792D_REG_TEMP_OVER[2]);
> 		data->temp_max_hyst_add[1] > 		    w83792d_read_value(client,
> 				       W83792D_REG_TEMP_HYST[2]);
> 
> 		/* Update the Fan Divisor */
> 		for (i = 0; i < 4; i++) {
> 			reg_array_tmp[i] = w83792d_read_value(client, W83792D_REG_FAN_DIV[i]);
> 		}
> 		data->fan_div[0] = reg_array_tmp[0] & 0x07;
> 		data->fan_div[1] = (reg_array_tmp[0] >> 4) & 0x07;
> 		data->fan_div[2] = reg_array_tmp[1] & 0x07;
> 		data->fan_div[3] = (reg_array_tmp[1] >> 4) & 0x07;
> 		data->fan_div[4] = reg_array_tmp[2] & 0x07;
> 		data->fan_div[5] = (reg_array_tmp[2] >> 4) & 0x07;
> 		data->fan_div[6] = reg_array_tmp[3] & 0x07;
> 
> 		/* Update CaseOpen status and it's CLR_CHS. */
> 		data->chassis = (w83792d_read_value(client,
> 			W83792D_REG_CHASSIS) >> 5) & 0x01;
> 		data->chassis_clear = (w83792d_read_value(client,
> 			W83792D_REG_CHASSIS_CLR) >> 7) & 0x01;
> 
> 		/* Update Thermal Cruise/Smart Fan I target value */
> 		for (i = 0; i < 3; i++) {
> 			data->thermal_cruise[i] > 				w83792d_read_value(client,
> 				W83792D_REG_THERMAL[i]) & 0x7f;
> 		}
> 
> 		/* Update Smart Fan I/II tolerance */
> 		reg_tmp = w83792d_read_value(client, W83792D_REG_TOLERANCE[0]);
> 		data->tolerance[0] = reg_tmp & 0x0f;
> 		data->tolerance[1] = (reg_tmp >> 4) & 0x0f;
> 		data->tolerance[2] > 			w83792d_read_value(client, W83792D_REG_TOLERANCE[2]) & 0x0f;
> 
> 		/* Update Smart Fan II temperature points */
> 		for (i = 0; i < 3; i++) {
> 			for (j = 0; j < 4; j++) {
> 				data->sf2_points[i][j] = w83792d_read_value(
> 					client,W83792D_REG_POINTS[i][j]) & 0x7f;
> 			}
> 		}
> 
> 		/* Update Smart Fan II duty cycle levels */
> 		for (i = 0; i < 3; i++) {
> 			reg_tmp = w83792d_read_value(client,
> 						W83792D_REG_LEVELS[i][0]);
> 			data->sf2_levels[i][0] = reg_tmp & 0x0f;
> 			data->sf2_levels[i][1] = (reg_tmp >> 4) & 0x0f;
> 			reg_tmp = w83792d_read_value(client,
> 						W83792D_REG_LEVELS[i][2]);
> 			data->sf2_levels[i][2] = (reg_tmp >> 4) & 0x0f;
> 			data->sf2_levels[i][3] = reg_tmp & 0x0f;
> 		}
> 
> 		data->last_updated = jiffies;
> 		data->valid = 1;
> 	}
> 
> 	up(&data->update_lock);
> 
> #ifdef W83792D_DEBUG
> 	w83792d_print_debug(data);
> #endif

Do not forget to change this too.

> 
> 	return data;
> }
> 
> #ifdef W83792D_DEBUG

and here :)

> static void w83792d_print_debug(struct w83792d_data *data)
> {
> 	int i=0;
> 	printk(KERN_DEBUG "=====The following is the debug message...====\n");
> 	printk(KERN_DEBUG "9 set of Voltages: ===>\n");
> 	for (i=0; i<=8; i++) {
> 		printk(KERN_DEBUG "vin[%d] is: 0x%x\n", i, data->in[i]);
> 		printk(KERN_DEBUG "vin[%d] max is: 0x%x\n", i, data->in_max[i]);
> 		printk(KERN_DEBUG "vin[%d] min is: 0x%x\n", i, data->in_min[i]);
> 	}
> 	printk(KERN_DEBUG "Low Bit1 is: 0x%x\n", data->low_bits[0]);
> 	printk(KERN_DEBUG "Low Bit2 is: 0x%x\n", data->low_bits[1]);
> 	printk(KERN_DEBUG "7 set of Fan Counts and Duty Cycles: ===>\n");
> /*	printk(KERN_DEBUG "fan_cfg is: 0x%x\n", data->fan_cfg); */
> 	for (i=0; i<=6; i++) {
> 		printk(KERN_DEBUG "fan[%d] is: 0x%x\n", i, data->fan[i]);
> 		printk(KERN_DEBUG "fan[%d] min is: 0x%x\n", i, data->fan_min[i]);
> 		printk(KERN_DEBUG "pwm[%d]     is: 0x%x\n", i, data->pwm[i]);
> 		printk(KERN_DEBUG "pwm_mode[%d] is: 0x%x\n", i, data->pwm_mode[i]);
> 	}
> 	printk(KERN_DEBUG "3 set of Temperatures: ===>\n");
> 	printk(KERN_DEBUG "temp1 is: 0x%x\n", data->temp);
> 	printk(KERN_DEBUG "temp1 high limit is: 0x%x\n", data->temp_max);
> 	printk(KERN_DEBUG "temp1 low limit is: 0x%x\n", data->temp_max_hyst);
> 
> 	printk(KERN_DEBUG "temp2 is: 0x%x\n", data->temp_add[0]);
> 	printk(KERN_DEBUG "temp2 high limit is: 0x%x\n", data->temp_max_add[0]);
> 	printk(KERN_DEBUG "temp2 low limit is: 0x%x\n", data->temp_max_hyst_add[0]);
> 
> 	printk(KERN_DEBUG "temp3 is: 0x%x\n", data->temp_add[1]);
> 	printk(KERN_DEBUG "temp3 high limit is: 0x%x\n", data->temp_max_add[1]);
> 	printk(KERN_DEBUG "temp3 low limit is: 0x%x\n", data->temp_max_hyst_add[1]);	
> 
> 	for (i=0; i<=6; i++) {
> 		printk(KERN_DEBUG "fan_div[%d] is: 0x%x\n", i, data->fan_div[i]);
> 	}
> 	printk(KERN_DEBUG "=====End of the debug message...=========\n");
> 	printk(KERN_DEBUG "\n");
> }
> #endif
> 
> static int __init
> sensors_w83792d_init(void)
> {
> 	return i2c_add_driver(&w83792d_driver);
> }
> 
> static void __exit
> sensors_w83792d_exit(void)
> {
> 	i2c_del_driver(&w83792d_driver);
> }
> 
> MODULE_AUTHOR("Chunhao Huang @ Winbond");

No email?

> MODULE_DESCRIPTION("W83792AD/D driver for linux-2.6");
> MODULE_LICENSE("GPL");
> 
> module_init(sensors_w83792d_init);
> module_exit(sensors_w83792d_exit);



