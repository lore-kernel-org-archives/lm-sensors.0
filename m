From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 29 Jul 2005 14:40:17 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <42EA1D45.6010405@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Eric J. Bowersox wrote:
> Well, after my *last* bout with new hardware that resulted in me dipping
> my toe into chip driver hacking, we decided to start shipping
> motherboards with yet *another* monitoring chip for which the driver
> wasn't in the kernel.  This time, it was the Supermicro X6DHP
> motherboard, which uses the National Semiconductor LM93...and this time,
> I couldn't find a 2.6 port in work, so I had to do it myself.

Hehe well done :)

> 
> After consulting with Mark Hoffman, the maintainer of the current LM93
> driver (who confirmed that he had no 2.6 port in work and none planned),
> I'm submitting this to the list for general review.  The patch is
> against kernel 2.6.12.2.  Perhaps it can be passed along up the line
> once it has been adequately vetted.

We will need the patch againts at least 2.6.13rc3

Things that changed:

1) sysfs callback attribute
2) hwmon subdirectory in kernel
3) hwmon class registration
4) ISA removal

In addion we will need lm93 documentation port from lm-sensors.

Ad 1) sysfs attributes. You can use them to pass sensor number, like if it is temp1 or in2 etc... You can get rid of that stupid function, that just adds sensor number.
Moreover you can also remove the min/max temp macros. You can either use 2D array and index temp# with first and 0 1 2 value, min,max with second.
I added such attribute not so long ago. http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013104.html
Alternative is to use 1D array and put there vals min and max in a row.

Here is some thread about it.
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012265.html

Ad 2) You need to re-locate the driver as well as redo Kconfig and makefile
Ad 3) this is quite easy http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013105.html
Ad 4) Even more easy. If it is smbus only you will just remove ISA_ADDRESS stuff. I'm not sure about isa bus adr checks. Perhaps Khali can throw some light.

I hope this helps,
Regards

Rudolf



Here are some random comments on the code. Today was so hot so I cant assure I did not miss anything important. The places with no comments at all needs further review,
but I will leave for quite long time so perhaps the other people can do it.

We have a policy not to touch configuration of the chip (as opposed of 2.4 that was too bit agresive) So please redo the configuration to optional and not mandatory.

> 
> diff -Naur linux-2.6.12.2.original/drivers/i2c/chips/Kconfig linux-2.6.12.2/drivers/i2c/chips/Kconfig
> --- linux-2.6.12.2.original/drivers/i2c/chips/Kconfig	2005-06-29 23:00:53.000000000 +0000
> +++ linux-2.6.12.2/drivers/i2c/chips/Kconfig	2005-07-14 21:51:15.000000000 +0000

Please note that driver should reside in drivers/hwmon

> @@ -250,6 +250,17 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm92.
>  
> +config SENSORS_LM93
> +	tristate "National Semiconductor LM93 and compatibles"
> +	depends on I2C && EXPERIMENTAL

Also it depends on HWMON

> +	select I2C_SENSOR
> +	help
> +	  If you say yes here you get support for National Semiconductor LM93
> +	  sensor chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called lm93.
> +
>  config SENSORS_MAX1619
>  	tristate "Maxim MAX1619 sensor chip"
>  	depends on I2C && EXPERIMENTAL
> diff -Naur linux-2.6.12.2.original/drivers/i2c/chips/Makefile linux-2.6.12.2/drivers/i2c/chips/Makefile
> --- linux-2.6.12.2.original/drivers/i2c/chips/Makefile	2005-06-29 23:00:53.000000000 +0000
> +++ linux-2.6.12.2/drivers/i2c/chips/Makefile	2005-07-14 21:50:02.000000000 +0000
> @@ -29,6 +29,7 @@
>  obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
>  obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
>  obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
> +obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
>  obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
>  obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
> diff -Naur linux-2.6.12.2.original/drivers/i2c/chips/lm93.c linux-2.6.12.2/drivers/i2c/chips/lm93.c
> --- linux-2.6.12.2.original/drivers/i2c/chips/lm93.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.12.2/drivers/i2c/chips/lm93.c	2005-07-14 22:35:24.000000000 +0000
> @@ -0,0 +1,2381 @@
> +/*
> +    lm93.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
> +
> +    Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
> +	Copyright (c) 2004 Utilitek Systems, Inc.
> +
> +    derived in part from lm78.c:
> +	Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
> +
> +    derived in part from lm85.c:
> +	Copyright (c) 2002, 2003 Philip Pokorny <ppokorny@penguincomputing.com>
> +	Copyright (c) 2003       Margit Schubert-While <margitsw@t-online.de>
> +
> +    derived in part from w83l785ts.c:
> +	Copyright (c) 2003-2004 Jean Delvare <khali@linux-fr.org>
> +
> +    Ported to Linux 2.6 by Eric J. Bowersox <ericb@aspsys.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*/
> +
> +#define DEBUG 1

Debug is defined globaly via .config (menuconfig) the symbol name is same

> +
> +#include <linux/config.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-sensor.h>
> +#include <linux/i2c-vid.h>
> +
> +/* BEGIN - definitions originally from lm93.h */
> +/* LM93 REGISTER ADDRESSES */
> +
> +/* miscellaneous */
> +#define LM93_REG_MFR_ID			0x3e
> +#define LM93_REG_VER			0x3f
> +#define LM93_REG_STATUS_CONTROL		0xe2
> +#define LM93_REG_CONFIG			0xe3
> +#define LM93_REG_SLEEP_CONTROL		0xe4
> +
> +/* alarm values start here */
> +#define LM93_REG_HOST_ERROR_1		0x48
> +
> +/* voltage inputs: in1-in16 (nr => 0-15) */
> +#define LM93_REG_IN(nr)			(0x56 + (nr))
> +#define LM93_REG_IN_MIN(nr)		(0x90 + (nr) * 2)
> +#define LM93_REG_IN_MAX(nr)		(0x91 + (nr) * 2)
> +
> +/* temperature inputs: temp1-temp4 (nr => 0-3) */
> +#define LM93_REG_TEMP(nr)		(0x50 + (nr))
> +#define LM93_REG_TEMP_MIN(nr)		(0x78 + (nr) * 2)
> +#define LM93_REG_TEMP_MAX(nr)		(0x79 + (nr) * 2)
> +
> +/* temp[1-4]_auto_boost (nr => 0-3) */
> +#define LM93_REG_BOOST(nr)		(0x80 + (nr))
> +
> +/* #PROCHOT inputs: prochot1-prochot2 (nr => 0-1) */
> +#define LM93_REG_PROCHOT_CUR(nr)	(0x67 + (nr) * 2)
> +#define LM93_REG_PROCHOT_AVG(nr)	(0x68 + (nr) * 2)
> +#define LM93_REG_PROCHOT_MAX(nr)	(0xb0 + (nr))
> +
> +/* fan tach inputs: fan1-fan4 (nr => 0-3) */
> +#define LM93_REG_FAN(nr)		(0x6e + (nr) * 2)
> +#define LM93_REG_FAN_MIN(nr)		(0xb4 + (nr) * 2)
> +
> +/* pwm outputs: pwm1-pwm2 (nr => 0-1, reg => 0-3) */
> +#define LM93_REG_PWM_CTL(nr,reg)	(0xc8 + (reg) + (nr) * 4)
> +#define LM93_PWM_CTL1	0
> +#define LM93_PWM_CTL2	1
> +#define LM93_PWM_CTL3	2
> +#define LM93_PWM_CTL4	31
> +

Hum why not in hex?

> +/* GPIO input state */
> +#define LM93_REG_GPI			0x6b
> +
> +/* vid inputs: vid1-vid2 (nr => 0-1) */
> +#define LM93_REG_VID(nr)		(0x6c + (nr))
> +
> +/* vccp1 & vccp2: VID relative inputs (nr => 0-1) */
> +#define LM93_REG_VCCP_LIMIT_OFF(nr)	(0xb2 + (nr))
> +
> +/* temp[1-4]_auto_boost_hyst */
> +#define LM93_REG_BOOST_HYST_12		0xc0
> +#define LM93_REG_BOOST_HYST_34		0xc1
> +#define LM93_REG_BOOST_HYST(nr)		(0xc0 + (nr)/2)
> +
> +/* temp[1-4]_auto_pwm_[min|hyst] */
> +#define LM93_REG_PWM_MIN_HYST_12	0xc3
> +#define LM93_REG_PWM_MIN_HYST_34	0xc4
> +#define LM93_REG_PWM_MIN_HYST(nr)	(0xc3 + (nr)/2)
> +
> +/* prochot_override & prochot_interval */
> +#define LM93_REG_PROCHOT_OVERRIDE	0xc6
> +#define LM93_REG_PROCHOT_INTERVAL	0xc7
> +
> +/* temp[1-4]_auto_base (nr => 0-3) */
> +#define LM93_REG_TEMP_BASE(nr)		(0xd0 + (nr))
> +
> +/* temp[1-4]_auto_offsets (step => 0-11) */
> +#define LM93_REG_TEMP_OFFSET(step)	(0xd4 + (step))
> +
> +/* #PROCHOT & #VRDHOT PWM ramp control */
> +#define LM93_REG_PWM_RAMP_CTL		0xbf
> +
> +/* miscellaneous */
> +#define LM93_REG_SFC1		0xbc
> +#define LM93_REG_SFC2		0xbd
> +#define LM93_REG_GPI_VID_CTL	0xbe
> +#define LM93_REG_SF_TACH_TO_PWM	0xe0
> +
> +/* error masks */
> +#define LM93_REG_GPI_ERR_MASK	0xec
> +#define LM93_REG_MISC_ERR_MASK	0xed
> +
> +/* LM93 REGISTER VALUES */
> +#define LM93_MFR_ID		0x73
> +#define LM93_MFR_ID_PROTOTYPE	0x72
> +/* END - definitions originally from lm93.h */
> +
> +/* SMBus capabilities */
> +#define LM93_SMBUS_FUNC_FULL (I2C_FUNC_SMBUS_BYTE_DATA | \
> +		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA)
> +#define LM93_SMBUS_FUNC_MIN  (I2C_FUNC_SMBUS_BYTE_DATA | \
> +		I2C_FUNC_SMBUS_WORD_DATA)
> +
> +#ifndef I2C_DRIVERID_LM93
> +#define I2C_DRIVERID_LM93 1049
> +#endif
> +
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
> +static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };

This line is to be removed due to ISA/I2C separation proces (see gregkh tree for this)

> +/* Insmod parameters */
> +SENSORS_INSMOD_1(lm93);
> +
> +static int disable_block = 0;
> +module_param(disable_block, bool, 0);
> +MODULE_PARM_DESC(disable_block,
> +	"Set to non-zero to disable SMBus block data transactions.");
> +
> +static int init = 1;

I think our policy is not to init the chip

> +module_param(init, bool, 0);
> +MODULE_PARM_DESC(init, "Set to zero to bypass most chip initialization");

So this should be vice-versa

> +static int vccp_limit_type[2] = {0,0};
> +module_param_array(vccp_limit_type, int, NULL, 0);
> +MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes");

Why this way? sysfs file not enough?

> +static int vid_agtl = 0;
> +module_param(vid_agtl, int, 0);
> +MODULE_PARM_DESC(vid_agtl, "Configures VID pin input thresholds");

Why this way? sysfs file not enough?

> +/* Function prototypes */
> +static u8 lm93_read_byte(struct i2c_client *client, u8 reg);
> +static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value);
> +static u16 lm93_read_word(struct i2c_client *client, u8 reg);
> +static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value);
> +static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values);
> +static struct lm93_data *lm93_update_device(struct device *dev);
> +static void lm93_update_client_common(struct lm93_data *data,
> +				      struct i2c_client *client);
> +static void lm93_update_client_full(struct lm93_data *data,
> +				    struct i2c_client *client);
> +static void lm93_update_client_min(struct lm93_data *data,
> +				   struct i2c_client *client);
> +static void lm93_init_client(struct i2c_client *client);
> +static int lm93_detect(struct i2c_adapter *adapter, int address, int kind);
> +static int lm93_attach_adapter(struct i2c_adapter *adapter);
> +static int lm93_detach_client(struct i2c_client *client);
> +
> +/* Driver data */
> +static struct i2c_driver lm93_driver = {
> +	.owner          = THIS_MODULE,

use tabs please

> +	.name		= "lm93",
> +	.id		= I2C_DRIVERID_LM93,
> +	.flags		= I2C_DF_NOTIFY,
> +	.attach_adapter	= lm93_attach_adapter,
> +	.detach_client	= lm93_detach_client,
> +};
> +
> +/* LM93 BLOCK READ COMMANDS */
> +static const struct { u8 cmd; u8 len; } lm93_block_read_cmds[12] = {
> +	{ 0xf2,  8 },
> +	{ 0xf3,  8 },
> +	{ 0xf4,  6 },
> +	{ 0xf5, 16 },
> +	{ 0xf6,  4 },
> +	{ 0xf7,  8 },
> +	{ 0xf8, 12 },
> +	{ 0xf9, 32 },
> +	{ 0xfa,  8 },
> +	{ 0xfb,  8 },
> +	{ 0xfc, 16 },
> +	{ 0xfd,  9 },
> +};
> +
> +/* ALARMS: SYSCTL format described further below
> +   REG: 64 bits in 8 registers, as immediately below */
> +struct block1_t {
> +	u8 host_status_1;
> +	u8 host_status_2;
> +	u8 host_status_3;
> +	u8 host_status_4;
> +	u8 p1_prochot_status;
> +	u8 p2_prochot_status;
> +	u8 gpi_status;
> +	u8 fan_status;
> +};
> +
> +/* For each registered client, we need to keep some data in memory. That
> +   data is pointed to by client->data. The structure itself is dynamically
> +   allocated, at the same time the client itself is allocated. */
> +struct lm93_data {
> +	struct semaphore lock;

Somewhere here will be the hwmon class struct

> +	enum chips type;
> +
> +	struct semaphore update_lock;
> +	unsigned long last_updated;	/* In jiffies */
> +
> +	/* client update function */
> +	void (*update)(struct lm93_data *, struct i2c_client *);
> +
> +	char valid; /* !=0 if following fields are valid */
> +
> +	/* register values, arranged by block read groups */
> +	struct block1_t block1;
> +
> +	/* temp1 - temp4: unfiltered readings
> +	   temp1 - temp2: filtered readings */
> +	u8 block2[6];
> +
> +	/* vin1 - vin16: readings */
> +	u8 block3[16];
> +
> +	/* prochot1 - prochot2: readings */
> +	struct { u8 cur; u8 avg; } block4[2];

Is this allowed by codingstyle?

> +
> +	/* fan counts 1-4 => 14-bits, LE, *left* justified */
> +	u16 block5[4];
> +
> +	/* block6 has a lot of data we don't need */
> +	struct { u8 min; u8 max; } temp_lim[3];
> +
> +	/* vin1 - vin16: low and high limits */
> +	struct { u8 min; u8 max; } block7[16];

same here

> +	/* fan count limits 1-4 => same format as block5 */
> +	u16 block8[4];
> +
> +	/* pwm control registers (2 pwms, 4 regs) */
> +	u8 block9[2][4];
> +
> +	/* auto/pwm base temp and offset temp registers */
> +	struct { u8 base[4]; u8 offset[12]; } block10;
> +
> +	/* master config register */
> +	u8 config;
> +
> +	/* VID1 & VID2 => register format, 6-bits, right justified */
> +	u8 vid[2];
> +
> +	/* prochot1 - prochot2: limits */
> +	u8 prochot_max[2];
> +
> +	/* vccp1 & vccp2 (in7 & in8): VID relative limits (register format) */
> +	u8 vccp_limits[2];
> +
> +	/* GPIO input state (register format, i.e. inverted) */
> +	u8 gpi;
> +
> +	/* #PROCHOT override (register format) */
> +	u8 prochot_override;
> +
> +	/* #PROCHOT intervals (register format) */
> +	u8 prochot_interval;
> +
> +	/* Fan Boost Temperatures (register format) */
> +	u8 boost[4];
> +
> +	/* Fan Boost Hysteresis (register format) */
> +	u8 boost_hyst[2];
> +
> +	/* Temperature Zone Min. PWM & Hysteresis (register format) */
> +	u8 auto_pwm_min_hyst[2];
> +
> +	/* #PROCHOT & #VRDHOT PWM Ramp Control */
> +	u8 pwm_ramp_ctl;
> +
> +	/* miscellaneous setup regs */
> +	u8 sfc1;
> +	u8 sfc2;
> +	u8 sf_tach_to_pwm;
> +
> +	/* The two PWM CTL2  registers can read something other than what was
> +	   last written for the OVR_DC field (duty cycle override).  So, we
> +	   save the user-commanded value here. */
> +	u8 pwm_override[2];
> +};
> +
> +/* VID:	mV
> +   REG: 6-bits, right justified, *always* using Intel VRM/VRD 10 */
> +static int LM93_VID_FROM_REG(u8 reg)
> +{
> +	return vid_from_reg((reg & 0x3f), 100);
> +}

Is there a reason not to rely on autodetection?

> +/* min, max, and nominal register values, per channel (u8) */
> +static const u8 lm93_vin_reg_min[16] = {
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xae, 

extra spaces at the end.

> +};
> +static const u8 lm93_vin_reg_max[16] = {
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 
> +	0xff, 0xfa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xd1, 

extra spaces at the end.

> +};
> +/*
> +static const u8 lm93_vin_reg_nom[16] = {
> +	0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0,
> +	0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x40, 0xc0,
> +};
> +*/
> +
> +/* min, max, and nominal voltage readings, per channel (mV)*/
> +static const unsigned long lm93_vin_val_min[16] = {
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 3000,
> +};
> +static const unsigned long lm93_vin_val_max[16] = {
> +	1236, 1236, 1236, 1600, 2000, 2000, 1600, 1600,
> +	4400, 6500, 3333, 2625, 1312, 1312, 1236, 3600,
> +};
> +/*
> +static const unsigned long lm93_vin_val_nom[16] = {
> +	 927,  927,  927, 1200, 1500, 1500, 1200, 1200,
> +	3300, 5000, 2500, 1969,  984,  984,  309, 3300,
> +};
> +*/
> +
> +static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
> +{
> +	const long uV_max = lm93_vin_val_max[nr] * 1000;
> +	const long uV_min = lm93_vin_val_min[nr] * 1000;
> +
> +	const long slope = (uV_max - uV_min) /
> +		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
> +	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
> +
> +	return (slope * reg + intercept + 500) / 1000;
> +}
> +
> +/* IN: mV, limits determined by channel nr
> +   REG: scaling determined by channel nr */
> +static u8 LM93_IN_TO_REG(int nr, unsigned val)
> +{
> +	/* range limit */
> +	const long mV = SENSORS_LIMIT(val, 

extra spaces

> +		lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
> +
> +	/* try not to lose too much precision here */
> +	const long uV = mV * 1000;
> +	const long uV_max = lm93_vin_val_max[nr] * 1000;
> +	const long uV_min = lm93_vin_val_min[nr] * 1000;
> +
> +	/* convert */
> +	const long slope = (uV_max - uV_min) / 

extra spaces

> +		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
> +	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
> +
> +	u8 result = ((uV - intercept + (slope/2)) / slope);
> +	result = SENSORS_LIMIT(result, 

extra spaces

> +			lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
> +	return result;
> +}
> +
> +/* vid in mV, upper = 0 indicates low limit, otherwise upper limit */
> +static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
> +{
> +	const long uV_offset = upper ? (((reg >> 4 & 0x0f) + 1) * 12500) :
> +				(((reg >> 0 & 0x0f) + 1) * -25000);
> +	const long uV_vid = vid * 1000;
> +	return (uV_vid + uV_offset + 5000) / 10000;
> +}
> +
> +#define LM93_IN_MIN_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,0,vid)
> +#define LM93_IN_MAX_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,1,vid)
> +
> +/* vid in mV , upper = 0 indicates low limit, otherwise upper limit 
> +   upper also determines which nibble of the register is returned
> +   (the other nibble will be 0x0) */
> +static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
> +{
> +	long uV_offset = vid * 1000 - val * 10000;
> +	if (upper) {
> +		uV_offset = SENSORS_LIMIT(uV_offset, 12500, 200000);
> +		return (u8)((uV_offset /  12500 - 1) << 4);
> +	} else {
> +		uV_offset = SENSORS_LIMIT(uV_offset, -400000, -25000);
> +		return (u8)((uV_offset / -25000 - 1) << 0);
> +	}
> +}
> +
> +/* TEMP: 1/1000 degrees C (-128C to +127C)
> +   REG: 1C/bit, two's complement */
> +static int LM93_TEMP_FROM_REG(u8 reg)
> +{
> +	return (s8)reg * 1000;
> +}
> +
> +#define LM93_TEMP_MIN (-128000)
> +#define LM93_TEMP_MAX ( 127000)
> +
> +/* TEMP: 1/1000 degrees C (-128C to +127C)
> +   REG: 1C/bit, two's complement */
> +static u8 LM93_TEMP_TO_REG(int temp)
> +{
> +	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
> +	ntemp += (ntemp<0 ? -500 : 500);
> +	return (u8)(ntemp / 1000);
> +}
> +
> +/* Determine 4-bit temperature offset resolution */
> +static int LM93_TEMP_OFFSET_MODE_FROM_REG(u8 sfc2, int nr)
> +{
> +	/* mode: 0 => 1C/bit, nonzero => 0.5C/bit */
> +	return sfc2 & (nr < 2 ? 0x10 : 0x20);
> +}
> +
> +/* This function is common to all 4-bit temperature offsets
> +   reg is 4 bits right justified
> +   mode 0 => 1C/bit, mode !0 => 0.5C/bit */
> +static int LM93_TEMP_OFFSET_FROM_REG(u8 reg, int mode)
> +{
> +	return (reg & 0x0f) * (mode ? 5 : 10);
> +}
> +
> +#define LM93_TEMP_OFFSET_MIN  (  0)
> +#define LM93_TEMP_OFFSET_MAX0 (150)
> +#define LM93_TEMP_OFFSET_MAX1 ( 75)
> +
> +/* This function is common to all 4-bit temperature offsets
> +   returns 4 bits right justified
> +   mode 0 => 1C/bit, mode !0 => 0.5C/bit */
> +static u8 LM93_TEMP_OFFSET_TO_REG(int off, int mode)
> +{
> +	int factor = mode ? 5 : 10;
> +
> +	off = SENSORS_LIMIT(off, LM93_TEMP_OFFSET_MIN,
> +		mode ? LM93_TEMP_OFFSET_MAX1 : LM93_TEMP_OFFSET_MAX0);
> +	return (u8)((off + factor/2) / factor);
> +}
> +
> +/* 0 <= nr <= 3 */
> +static int LM93_TEMP_AUTO_OFFSET_FROM_REG(u8 reg, int nr, int mode)
> +{
> +	/* temp1-temp2 (nr=0,1) use lower nibble */
> +	if (nr < 2)
> +		return LM93_TEMP_OFFSET_FROM_REG(reg & 0x0f, mode);
> +
> +	/* temp3-temp4 (nr=2,3) use upper nibble */
> +	else
> +		return LM93_TEMP_OFFSET_FROM_REG(reg >> 4 & 0x0f, mode);
> +}
> +
> +/* TEMP: 1/10 degrees C (0C to +15C (mode 0) or +7.5C (mode non-zero))
> +   REG: 1.0C/bit (mode 0) or 0.5C/bit (mode non-zero)
> +   0 <= nr <= 3 */
> +static u8 LM93_TEMP_AUTO_OFFSET_TO_REG(u8 old, int off, int nr, int mode)
> +{
> +	u8 new = LM93_TEMP_OFFSET_TO_REG(off, mode);
> +
> +	/* temp1-temp2 (nr=0,1) use lower nibble */
> +	if (nr < 2)
> +		return (old & 0xf0) | (new & 0x0f);
> +
> +	/* temp3-temp4 (nr=2,3) use upper nibble */
> +	else
> +		return (new << 4 & 0xf0) | (old & 0x0f);
> +}
> +
> +static int LM93_AUTO_BOOST_HYST_FROM_REGS(struct lm93_data *data, int nr,
> +		int mode)
> +{
> +	u8 reg;
> +
> +	switch (nr) {
> +	case 0:
> +		reg = data->boost_hyst[0] & 0x0f;
> +		break;
> +	case 1:
> +		reg = data->boost_hyst[0] >> 4 & 0x0f;
> +		break;
> +	case 2:
> +		reg = data->boost_hyst[1] & 0x0f;
> +		break;
> +	case 3:
> +	default:
> +		reg = data->boost_hyst[1] >> 4 & 0x0f;
> +		break;
> +	}
> +
> +	return LM93_TEMP_FROM_REG(data->boost[nr]) -
> +			LM93_TEMP_OFFSET_FROM_REG(reg, mode);
> +}
> +
> +static u8 LM93_AUTO_BOOST_HYST_TO_REG(struct lm93_data *data, long hyst,
> +		int nr, int mode)
> +{
> +	u8 reg = LM93_TEMP_OFFSET_TO_REG(
> +			(LM93_TEMP_FROM_REG(data->boost[nr]) - hyst), mode);
> +
> +	switch (nr) {
> +	case 0:
> +		reg = (data->boost_hyst[0] & 0xf0) | (reg & 0x0f);
> +		break;
> +	case 1:
> +		reg = (reg << 4 & 0xf0) | (data->boost_hyst[0] & 0x0f);
> +		break;
> +	case 2:
> +		reg = (data->boost_hyst[1] & 0xf0) | (reg & 0x0f);
> +		break;
> +	case 3:
> +	default:
> +		reg = (reg << 4 & 0xf0) | (data->boost_hyst[1] & 0x0f);
> +		break;
> +	}
> +
> +	return reg;
> +}
> +
> +/* PWM: 0-255 per sensors documentation
> +   REG: 0-13 as mapped below... right justified */
> +typedef enum { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ } pwm_freq_t;
> +static int lm93_pwm_map[2][14] = {
> +	{
> +		0x00, /*   0.00% */ 0x40, /*  25.00% */
> +		0x50, /*  31.25% */ 0x60, /*  37.50% */
> +		0x70, /*  43.75% */ 0x80, /*  50.00% */
> +		0x90, /*  56.25% */ 0xa0, /*  62.50% */
> +		0xb0, /*  68.75% */ 0xc0, /*  75.00% */
> +		0xd0, /*  81.25% */ 0xe0, /*  87.50% */
> +		0xf0, /*  93.75% */ 0xff, /* 100.00% */
> +	},
> +	{
> +		0x00, /*   0.00% */ 0x40, /*  25.00% */
> +		0x49, /*  28.57% */ 0x52, /*  32.14% */
> +		0x5b, /*  35.71% */ 0x64, /*  39.29% */
> +		0x6d, /*  42.86% */ 0x76, /*  46.43% */
> +		0x80, /*  50.00% */ 0x89, /*  53.57% */
> +		0x92, /*  57.14% */ 0xb6, /*  71.43% */
> +		0xdb, /*  85.71% */ 0xff, /* 100.00% */
> +	},
> +};
> +
> +static int LM93_PWM_FROM_REG(u8 reg, pwm_freq_t freq)
> +{
> +	return lm93_pwm_map[freq][reg & 0x0f];
> +}
> +
> +/* round up to nearest match */
> +static u8 LM93_PWM_TO_REG(int pwm, pwm_freq_t freq)
> +{
> +	int i;
> +	for (i = 0; i < 13; i++)
> +		if (pwm <= lm93_pwm_map[freq][i])
> +			break;
> +
> +	/* can fall through with i=13 */
> +	return (u8)i;
> +}
> +
> +static int LM93_FAN_FROM_REG(u16 regs)
> +{
> +	const u16 count = le16_to_cpu(regs) >> 2;
> +	return count=0 ? -1 : count=0x3fff ? 0: 1350000 / count;
> +}
> +
> +static u16 LM93_FAN_TO_REG(long rpm)
> +{
> +	u16 count, regs;
> +
> +	if (rpm = 0) {
> +		count = 0x3fff;
> +	} else {
> +		rpm = SENSORS_LIMIT(rpm, 1, 1000000);
> +		count = SENSORS_LIMIT((1350000 + rpm) / rpm, 1, 0x3ffe);
> +	}
> +
> +	regs = count << 2;
> +	return cpu_to_le16(regs);
> +}
> +
> +/* PWM FREQ: HZ
> +   REG: 0-7 as mapped below */
> +static int lm93_pwm_freq_map[8] = {
> +	22500, 96, 84, 72, 60, 48, 36, 12
> +};
> +
> +static int LM93_PWM_FREQ_FROM_REG(u8 reg)
> +{
> +	return lm93_pwm_freq_map[reg & 0x07];
> +}
> +
> +/* round up to nearest match */
> +static u8 LM93_PWM_FREQ_TO_REG(int freq)
> +{
> +	int i;
> +	for (i = 7; i > 0; i--)
> +		if (freq <= lm93_pwm_freq_map[i])
> +			break;
> +
> +	/* can fall through with i=0 */
> +	return (u8)i;
> +}
> +
> +/* TIME: 1/100 seconds
> + * REG: 0-7 as mapped below */
> +static int lm93_spinup_time_map[8] = {
> +	0, 10, 25, 40, 70, 100, 200, 400,
> +};
> +
> +static int LM93_SPINUP_TIME_FROM_REG(u8 reg)
> +{
> +	return lm93_spinup_time_map[reg >> 5 & 0x07];
> +}
> +
> +/* round up to nearest match */
> +static u8 LM93_SPINUP_TIME_TO_REG(int time)
> +{
> +	int i;
> +	for (i = 0; i < 7; i++)
> +		if (time <= lm93_spinup_time_map[i])
> +			break;
> +
> +	/* can fall through with i=8 */
> +	return (u8)i;
> +}
> +
> +#define LM93_RAMP_MIN 0
> +#define LM93_RAMP_MAX 75
> +
> +static int LM93_RAMP_FROM_REG(u8 reg)
> +{
> +	return (reg & 0x0f) * 5;
> +}
> +	
> +/* RAMP: 1/100 seconds
> +   REG: 50mS/bit 4-bits right justified */
> +static u8 LM93_RAMP_TO_REG(int ramp)
> +{
> +	ramp = SENSORS_LIMIT(ramp, LM93_RAMP_MIN, LM93_RAMP_MAX);
> +	return (u8)((ramp + 2) / 5);
> +}
> +
> +/* PROCHOT: 0-255, 0 => 0%, 255 => > 96.6%
> + * REG: (same) */
> +static u8 LM93_PROCHOT_TO_REG(long prochot)
> +{
> +	prochot = SENSORS_LIMIT(prochot, 0, 255);
> +	return (u8)prochot;
> +}
> +
> +/* PROCHOT-INTERVAL: 73 - 37200 (1/100 seconds)
> + * REG: 0-9 as mapped below */
> +static int lm93_interval_map[10] = {
> +	73, 146, 290, 580, 1170, 2330, 4660, 9320, 18600, 37200,
> +};
> +
> +static int LM93_INTERVAL_FROM_REG(u8 reg)
> +{
> +	return lm93_interval_map[reg & 0x0f];
> +}
> +
> +/* round up to nearest match */
> +static u8 LM93_INTERVAL_TO_REG(long interval)
> +{
> +	int i;
> +	for (i = 0; i < 9; i++)
> +		if (interval <= lm93_interval_map[i])
> +			break;
> +
> +	/* can fall through with i=9 */
> +	return (u8)i;
> +}
> +
> +/* GPIO: 0-255, GPIO0 is LSB
> + * REG: inverted */
> +static unsigned LM93_GPI_FROM_REG(u8 reg)
> +{
> +	return ~reg & 0xff;
> +}
> +
> +/* alarm bitmask definitions
> +   The LM93 has nearly 64 bits of error status... I've pared that down to
> +   what I think is a useful subset in order to fit it into 32 bits.
> +
> +   Especially note that the #VRD_HOT alarms are missing because we provide
> +   that information as values in another /proc file.
> +
> +   If libsensors is extended to support 64 bit values, this could be revisited.
> +*/
> +#define LM93_ALARM_IN1		0x00000001
> +#define LM93_ALARM_IN2		0x00000002
> +#define LM93_ALARM_IN3		0x00000004
> +#define LM93_ALARM_IN4		0x00000008
> +#define LM93_ALARM_IN5		0x00000010
> +#define LM93_ALARM_IN6		0x00000020
> +#define LM93_ALARM_IN7		0x00000040
> +#define LM93_ALARM_IN8		0x00000080
> +#define LM93_ALARM_IN9		0x00000100
> +#define LM93_ALARM_IN10		0x00000200
> +#define LM93_ALARM_IN11		0x00000400
> +#define LM93_ALARM_IN12		0x00000800
> +#define LM93_ALARM_IN13		0x00001000
> +#define LM93_ALARM_IN14		0x00002000
> +#define LM93_ALARM_IN15		0x00004000
> +#define LM93_ALARM_IN16		0x00008000
> +#define LM93_ALARM_FAN1		0x00010000
> +#define LM93_ALARM_FAN2		0x00020000
> +#define LM93_ALARM_FAN3		0x00040000
> +#define LM93_ALARM_FAN4		0x00080000
> +#define LM93_ALARM_PH1_ERR	0x00100000
> +#define LM93_ALARM_PH2_ERR	0x00200000
> +#define LM93_ALARM_SCSI1_ERR	0x00400000
> +#define LM93_ALARM_SCSI2_ERR	0x00800000
> +#define LM93_ALARM_DVDDP1_ERR	0x01000000
> +#define LM93_ALARM_DVDDP2_ERR	0x02000000
> +#define LM93_ALARM_D1_ERR	0x04000000
> +#define LM93_ALARM_D2_ERR	0x08000000
> +#define LM93_ALARM_TEMP1	0x10000000
> +#define LM93_ALARM_TEMP2	0x20000000
> +#define LM93_ALARM_TEMP3	0x40000000
> +
> +static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
> +{
> +	unsigned result;
> +	result  = b1.host_status_2 & 0x3f;
> +
> +	if (vccp_limit_type[0])
> +		result |= (b1.host_status_4 & 0x10) << 2;
> +	else
> +		result |= b1.host_status_2 & 0x40;
> +
> +	if (vccp_limit_type[1])
> +		result |= (b1.host_status_4 & 0x20) << 2;
> +	else
> +		result |= b1.host_status_2 & 0x80;
> +
> +	result |= b1.host_status_3 << 8;
> +	result |= (b1.fan_status & 0x0f) << 16;
> +	result |= (b1.p1_prochot_status & 0x80) << 13;
> +	result |= (b1.p2_prochot_status & 0x80) << 14;
> +	result |= (b1.host_status_4 & 0xfc) << 20;
> +	result |= (b1.host_status_1 & 0x07) << 28;
> +	return result;
> +}
> +
> +/* following are the sysfs callback functions */
> +static ssize_t show_in (struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_IN_FROM_REG(nr, data->block3[nr]));
> +}
> +
> +#define show_in_reg(rop,ROP) \
> +static ssize_t show_in_##rop (struct device *dev, char *buf, int nr) \
> +{ \
> +	struct lm93_data *data = lm93_update_device(dev); \
> +	int vccp = nr - 6; \
> +	long rc; \
> +	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) { \
> +		long vid = LM93_VID_FROM_REG(data->vid[vccp]); \
> +		rc = LM93_IN_##ROP##_FROM_REG(data->vccp_limits[vccp],vid); \
> +	} else { \
> +		rc = LM93_IN_FROM_REG(nr,data->block7[nr].rop); \
> +	} \
> +	return sprintf(buf,"%ld\n",rc); \
> +}
> +show_in_reg(min,MIN);
> +show_in_reg(max,MAX);
> +
> +#define store_in_reg(rop,ROP,rmask,rndx) \
> +static ssize_t store_in_##rop (struct device *dev, const char *buf, \
> +				size_t count, int nr) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct lm93_data *data = i2c_get_clientdata(client); \
> +	u32 val = simple_strtoul(buf, NULL, 10); \
> +	int vccp = nr - 6; \
> +	down(&data->update_lock); \
> +	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) { \
> +		long vid = LM93_VID_FROM_REG(data->vid[vccp]); \
> +		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & rmask) | \
> +		  		   LM93_IN_REL_TO_REG(val, rndx, vid); \
> +		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp), \
> +				data->vccp_limits[vccp]); \
> +	} else { \
> +		data->block7[nr].rop = LM93_IN_TO_REG(nr,val); \
> +		lm93_write_byte(client, LM93_REG_IN_##ROP(nr), \
> +				data->block7[nr].rop); \
> +	} \
> +	up(&data->update_lock); \
> +	return count; \
> +}
> +store_in_reg(min,MIN,0xf0,0);
> +store_in_reg(max,MAX,0x0f,1);
> +
> +#define sysfs_in_offset(offset) \
> +static ssize_t \
> +show_regs_in_##offset (struct device *dev, char *buf) \
> +{ \
> +        return show_in(dev, buf, offset - 1); \
> +} \
> +static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL)
> +
> +#define sysfs_in_reg_offset(reg, offset) \
> +static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_in_##reg (dev, buf, offset - 1); \
> +} \
> +static ssize_t store_regs_in_##reg##offset (struct device *dev, \
> +					const char *buf, size_t count) \
> +{ \
> +	return store_in_##reg (dev, buf, count, offset - 1); \
> +} \
> +static DEVICE_ATTR(in##offset##_##reg, S_IRUGO|S_IWUSR, \
> +		show_regs_in_##reg##offset, store_regs_in_##reg##offset)
> +
> +#define sysfs_in_offsets(offset) \
> +sysfs_in_offset(offset); \
> +sysfs_in_reg_offset(min, offset); \
> +sysfs_in_reg_offset(max, offset);
> +
> +sysfs_in_offsets(1);
> +sysfs_in_offsets(2);
> +sysfs_in_offsets(3);
> +sysfs_in_offsets(4);
> +sysfs_in_offsets(5);
> +sysfs_in_offsets(6);
> +sysfs_in_offsets(7);
> +sysfs_in_offsets(8);
> +sysfs_in_offsets(9);
> +sysfs_in_offsets(10);
> +sysfs_in_offsets(11);
> +sysfs_in_offsets(12);
> +sysfs_in_offsets(13);
> +sysfs_in_offsets(14);
> +sysfs_in_offsets(15);
> +sysfs_in_offsets(16);

The dummy functions can be replaced using sysfsattribute.

> +#define device_create_file_in(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> +device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> +device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> +} while (0)
> +
> +static ssize_t show_temp (struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block2[nr]));
> +}
> +
> +#define show_temp_reg(rop) \
> +static ssize_t show_temp_##rop (struct device *dev, char *buf, int nr) \
> +{ \
> +	struct lm93_data *data = lm93_update_device(dev); \
> +	return sprintf(buf,"%d\n",\
> +			LM93_TEMP_FROM_REG(data->temp_lim[nr].rop)); \
> +}
> +show_temp_reg(min);
> +show_temp_reg(max);

The min/max stuff as well as in other cases can be replaced with 2D variables (so two attributes) or use one array that maps
to low part the temps min next and max on the top.

> +#define store_temp_reg(rop,ROP) \
> +static ssize_t store_temp_##rop (struct device *dev, const char *buf, \
> +				size_t count, int nr) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct lm93_data *data = i2c_get_clientdata(client); \
> +	u32 val = simple_strtoul(buf, NULL, 10); \
> +	down(&data->update_lock); \
> +	data->temp_lim[nr].rop = LM93_TEMP_TO_REG(val); \
> +	lm93_write_byte(client, LM93_REG_TEMP_##ROP(nr),\
> +			data->temp_lim[nr].rop); \
> +	up(&data->update_lock); \
> +	return count; \
> +}
> +store_temp_reg(min,MIN);
> +store_temp_reg(max,MAX);
> +
> +static ssize_t show_temp_auto_base(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block10.base[nr]));
> +}
> +
> +static ssize_t store_temp_auto_base(struct device *dev, const char *buf,
> +				    size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	data->block10.base[nr] = LM93_TEMP_TO_REG(val);
> +	lm93_write_byte(client, LM93_REG_TEMP_BASE(nr),
> +			data->block10.base[nr]);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_temp_auto_offset(struct device *dev, char *buf,
> +				     int nr, int ofs)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
> +	return sprintf(buf,"%d\n",
> +	       LM93_TEMP_AUTO_OFFSET_FROM_REG(data->block10.offset[ofs],
> +					      nr,mode));
> +}
> +
> +static ssize_t store_temp_auto_offset (struct device *dev, const char *buf,
> +				       size_t count, int nr, int ofs)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +
> +	/* force 0.5C/bit mode */
> +	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
> +	data->sfc2 |= ((nr < 2) ? 0x10 : 0x20);
> +	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
> +
> +	data->block10.offset[ofs] = LM93_TEMP_AUTO_OFFSET_TO_REG(
> +			data->block10.offset[ofs], val, nr, 1);
> +	lm93_write_byte(client, LM93_REG_TEMP_OFFSET(ofs),
> +			data->block10.offset[ofs]);
> +
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_temp_auto_offset(ndx) \
> +static ssize_t \
> +show_temp_auto_offset##ndx (struct device *dev, char *buf, int nr) \
> +{ \
> +	return show_temp_auto_offset (dev, buf, nr, ndx - 1); \
> +} \
> +static ssize_t \
> +store_temp_auto_offset##ndx (struct device *dev, const char *buf, \
> +					size_t count, int nr) \
> +{ \
> +	return store_temp_auto_offset (dev, buf, count, nr, ndx - 1); \
> +}
> +sysfs_temp_auto_offset(1);
> +sysfs_temp_auto_offset(2);
> +sysfs_temp_auto_offset(3);
> +sysfs_temp_auto_offset(4);
> +sysfs_temp_auto_offset(5);
> +sysfs_temp_auto_offset(6);
> +sysfs_temp_auto_offset(7);
> +sysfs_temp_auto_offset(8);
> +sysfs_temp_auto_offset(9);
> +sysfs_temp_auto_offset(10);
> +sysfs_temp_auto_offset(11);
> +sysfs_temp_auto_offset(12);
> +
> +static ssize_t show_temp_auto_boost(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->boost[nr]));
> +}
> +
> +static ssize_t store_temp_auto_boost(struct device *dev, const char *buf,
> +				     size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	data->boost[nr] = LM93_TEMP_TO_REG(val);
> +	lm93_write_byte(client, LM93_REG_BOOST(nr), data->boost[nr]);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_temp_auto_boost_hyst(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
> +	return sprintf(buf,"%d\n",
> +		       LM93_AUTO_BOOST_HYST_FROM_REGS(data, nr, mode));
> +}
> +
> +static ssize_t store_temp_auto_boost_hyst(struct device *dev, const char *buf,
> +					  size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +
> +	/* force 0.5C/bit mode */
> +	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
> +	data->sfc2 |= ((nr < 2) ? 0x10 : 0x20);
> +	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
> +
> +	data->boost_hyst[nr/2] = LM93_AUTO_BOOST_HYST_TO_REG(data, val, nr, 1);
> +	lm93_write_byte(client, LM93_REG_BOOST_HYST(nr),
> +			data->boost_hyst[nr/2]);
> +
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_temp_auto_pwm_min(struct device *dev, char *buf, int nr)
> +{
> +	u8 reg, ctl4;
> +	struct lm93_data *data = lm93_update_device(dev);
> +	reg = data->auto_pwm_min_hyst[nr/2] >> 4 & 0x0f;
> +	ctl4 = data->block9[nr][LM93_PWM_CTL4];
> +	return sprintf(buf,"%d\n",LM93_PWM_FROM_REG(reg, (ctl4 & 0x07) ?
> +				LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
> +}
> +
> +static ssize_t store_temp_auto_pwm_min(struct device *dev, const char *buf,
> +				       size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 reg, ctl4;
> +
> +	down(&data->update_lock);
> +	reg = lm93_read_byte(client, LM93_REG_PWM_MIN_HYST(nr));
> +	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
> +	reg = (reg & 0x0f) | 
> +		LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
> +				LM93_PWM_MAP_LO_FREQ :
> +				LM93_PWM_MAP_HI_FREQ) << 4;
> +	data->auto_pwm_min_hyst[nr/2] = reg;
> +	lm93_write_byte(client, LM93_REG_PWM_MIN_HYST(nr), reg);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_temp_auto_offset_hyst(struct device *dev, char *buf,
> +					  int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
> +	return sprintf(buf,"%d\n",LM93_TEMP_OFFSET_FROM_REG(
> +					data->auto_pwm_min_hyst[nr/2], mode));
> +}
> +
> +static ssize_t store_temp_auto_offset_hyst(struct device *dev, const char *buf,
> +					   size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 reg;
> +
> +	down(&data->update_lock);
> +
> +	/* force 0.5C/bit mode */
> +	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
> +	data->sfc2 |= ((nr < 2) ? 0x10 : 0x20);
> +	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
> +
> +	reg = data->auto_pwm_min_hyst[nr/2];
> +	reg = (reg & 0xf0) | (LM93_TEMP_OFFSET_TO_REG(val, 1) & 0x0f);
> +
> +	data->auto_pwm_min_hyst[nr/2] = reg;
> +	lm93_write_byte(client, LM93_REG_PWM_MIN_HYST(nr), reg);
> +
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_temp_offset(offset) \
> +static ssize_t \
> +show_regs_temp_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_temp(dev, buf, offset - 1); \
> +} \
> +static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
> +			show_regs_temp_##offset, NULL)
> +
> +#define sysfs_temp_reg_offset(rop,offset) \
> +static ssize_t \
> +show_regs_temp_##rop##_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_temp_##rop (dev, buf, offset - 1); \
> +} \
> +static ssize_t \
> +store_regs_temp_##rop##_##offset (struct device *dev, const char *buf, \
> +					size_t count) \
> +{ \
> +	return store_temp_##rop (dev, buf, count, offset - 1); \
> +} \
> +static DEVICE_ATTR(temp##offset##_##rop, S_IRUGO|S_IWUSR, \
> +			show_regs_temp_##rop##_##offset, \
> +			store_regs_temp_##rop##_##offset)
> +
> +#define sysfs_temp_offsets(offset) \
> +sysfs_temp_offset(offset); \
> +sysfs_temp_reg_offset(max, offset); \
> +sysfs_temp_reg_offset(min, offset); \
> +sysfs_temp_reg_offset(auto_base, offset); \
> +sysfs_temp_reg_offset(auto_offset1, offset); \
> +sysfs_temp_reg_offset(auto_offset2, offset); \
> +sysfs_temp_reg_offset(auto_offset3, offset); \
> +sysfs_temp_reg_offset(auto_offset4, offset); \
> +sysfs_temp_reg_offset(auto_offset5, offset); \
> +sysfs_temp_reg_offset(auto_offset6, offset); \
> +sysfs_temp_reg_offset(auto_offset7, offset); \
> +sysfs_temp_reg_offset(auto_offset8, offset); \
> +sysfs_temp_reg_offset(auto_offset9, offset); \
> +sysfs_temp_reg_offset(auto_offset10, offset); \
> +sysfs_temp_reg_offset(auto_offset11, offset); \
> +sysfs_temp_reg_offset(auto_offset12, offset); \
> +sysfs_temp_reg_offset(auto_boost, offset); \
> +sysfs_temp_reg_offset(auto_boost_hyst, offset); \
> +sysfs_temp_reg_offset(auto_pwm_min, offset); \
> +sysfs_temp_reg_offset(auto_offset_hyst, offset);
> +
> +sysfs_temp_offsets(1);
> +sysfs_temp_offsets(2);
> +sysfs_temp_offsets(3);
> +
> +#define device_create_file_temp(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_min); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_base); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset1); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset2); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset3); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset4); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset5); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset6); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset7); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset8); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset9); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset10); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset11); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset12); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_boost); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_boost_hyst); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_pwm_min); \
> +device_create_file(&client->dev, &dev_attr_temp##offset##_auto_offset_hyst); \
> +} while (0)
> +
> +#define show_fan_reg(rop,bk) \
> +static ssize_t show_fan_##rop (struct device *dev, char *buf, int nr) \
> +{ \
> +	struct lm93_data *data = lm93_update_device(dev); \
> +	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block##bk [nr])); \
> +}
> +show_fan_reg(input,5);
> +show_fan_reg(min,8);
> +
> +static ssize_t store_fan_min(struct device *dev, const char *buf,
> +			     size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	data->block8[nr] = LM93_FAN_TO_REG(val);
> +	lm93_write_word(client,LM93_REG_FAN_MIN(nr),data->block8[nr]);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +/* some tedious bit-twiddling here to deal with the register format:
> +
> +	data->sf_tach_to_pwm: (tach to pwm mapping bits)
> +
> +		bit |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0
> +		     T4:P2 T4:P1 T3:P2 T3:P1 T2:P2 T2:P1 T1:P2 T1:P1
> +
> +	data->sfc2: (enable bits)
> +
> +		bit |  3  |  2  |  1  |  0
> +		       T4    T3    T2    T1
> +*/
> +
> +static ssize_t show_fan_smart_tach (struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	long rc = 0;
> +	int mapping;
> +
> +	/* extract the relevant mapping */
> +	mapping = (data->sf_tach_to_pwm >> (nr * 2)) & 0x03;
> +
> +	/* if there's a mapping and it's enabled */
> +	if (mapping && ((data->sfc2 >> nr) & 0x01))
> +		rc = mapping;
> +	return sprintf(buf,"%ld\n",rc);
> +}
> +
> +/* helper function - must grab data->update_lock before calling
> +   fan is 0-3, indicating fan1-fan4 */
> +static void lm93_write_fan_smart_tach(struct i2c_client *client,
> +	struct lm93_data *data, int fan, long value)
> +{
> +	/* insert the new mapping and write it out */
> +	data->sf_tach_to_pwm = lm93_read_byte(client, LM93_REG_SF_TACH_TO_PWM);
> +	data->sf_tach_to_pwm &= ~(0x3 << fan * 2);
> +	data->sf_tach_to_pwm |= value << fan * 2;
> +	lm93_write_byte(client, LM93_REG_SF_TACH_TO_PWM, data->sf_tach_to_pwm);
> +
> +	/* insert the enable bit and write it out */
> +	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
> +	if (value)
> +		data->sfc2 |= 1 << fan;
> +	else
> +		data->sfc2 &= ~(1 << fan);
> +	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
> +}
> +
> +static ssize_t store_fan_smart_tach(struct device *dev, const char *buf,
> +				    size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +
> +	/* sanity test, ignore the write otherwise */
> +	if (0 <= val && val <= 2) {
> +		/* can't enable if pwm freq is 22.5KHz */
> +		if (val) {
> +			u8 ctl4 = lm93_read_byte(client,
> +				LM93_REG_PWM_CTL(val-1,LM93_PWM_CTL4));
> +			if ((ctl4 & 0x07) = 0)
> +				val = 0;
> +		}
> +
> +		lm93_write_fan_smart_tach(client, data, nr, val);
> +	}
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_fan_offset(offset) \
> +static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_fan_input(dev, buf, offset - 1); \
> +} \
> +static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL)
> +
> +#define sysfs_fan_reg_offset(rop,offset) \
> +static ssize_t show_regs_fan_##offset##_##rop (struct device *dev, char *buf) \
> +{ \
> +	return show_fan_##rop(dev, buf, offset - 1); \
> +} \
> +static ssize_t store_regs_fan_##offset##_##rop (struct device *dev, \
> +					const char *buf, size_t count) \
> +{ \
> +	return store_fan_##rop(dev, buf, count, offset - 1); \
> +} \
> +static DEVICE_ATTR(fan##offset##_##rop, S_IRUGO|S_IWUSR, \
> +			show_regs_fan_##offset##_##rop, \
> +			store_regs_fan_##offset##_##rop)
> +
> +#define sysfs_fan_offsets(offset) \
> +sysfs_fan_offset(offset); \
> +sysfs_fan_reg_offset(min, offset); \
> +sysfs_fan_reg_offset(smart_tach, offset);
> +
> +sysfs_fan_offsets(1);
> +sysfs_fan_offsets(2);
> +sysfs_fan_offsets(3);
> +sysfs_fan_offsets(4);
> +
> +#define device_create_file_fan(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
> +device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
> +device_create_file(&client->dev, &dev_attr_fan##offset##_smart_tach); \
> +} while (0)
> +
> +static ssize_t show_pwm(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	u8 ctl2, ctl4;
> +	int flag;
> +	long rc;
> +
> +	ctl2 = data->block9[nr][LM93_PWM_CTL2];
> +	ctl4 = data->block9[nr][LM93_PWM_CTL4];
> +	flag = (ctl2 & 0x01) ? 1 : 0;
> +	ctl2 = ctl2 >> 4 & 0x0f;
> +	if (flag) /* show user commanded value if enabled */
> +		rc = data->pwm_override[nr];
> +	else /* show present h/w value if manual pwm disabled */
> +		rc = LM93_PWM_FROM_REG(ctl2, (ctl4 & 0x07) ?
> +			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ);
> +	return sprintf(buf,"%ld\n",rc);
> +}
> +
> +static ssize_t store_pwm(struct device *dev, const char *buf,
> +			 size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ctl2, ctl4;
> +
> +	down(&data->update_lock);
> +	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
> +	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
> +	ctl2 = (ctl2 & 0x0f) | LM93_PWM_TO_REG(val,(ctl4 & 0x07) ?
> +			LM93_PWM_MAP_LO_FREQ :
> +			LM93_PWM_MAP_HI_FREQ) << 4;
> +
> +	/* save user commanded value */
> +	data->pwm_override[nr] = LM93_PWM_FROM_REG(ctl2 >> 4 & 0x0f,
> +			(ctl4 & 0x07) ?  LM93_PWM_MAP_LO_FREQ :
> +			LM93_PWM_MAP_HI_FREQ);
> +	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
> +
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_pwm_override(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	u8 ctl2;
> +
> +	ctl2 = data->block9[nr][LM93_PWM_CTL2];
> +	return sprintf(buf,"%d\n",(ctl2 & 0x01) ? 1 : 0);
> +}
> +
> +static ssize_t store_pwm_override(struct device *dev, const char *buf,
> +				  size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ctl2;
> +
> +	down(&data->update_lock);
> +	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
> +	if (val)
> +		ctl2 |= 0x01;
> +	else
> +		ctl2 &= ~0x01;
> +	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_pwm_freq(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	u8 ctl4;
> +
> +	ctl4 = data->block9[nr][LM93_PWM_CTL4];
> +	return sprintf(buf,"%d\n",LM93_PWM_FREQ_FROM_REG(ctl4));
> +}
> +
> +/* helper function - must grab data->update_lock before calling
> +   pwm is 0-1, indicating pwm1-pwm2
> +   this disables smart tach for all tach channels bound to the given pwm */
> +static void lm93_disable_fan_smart_tach(struct i2c_client *client,
> +	struct lm93_data *data, int pwm)
> +{
> +	int mapping = lm93_read_byte(client, LM93_REG_SF_TACH_TO_PWM);
> +	int mask;
> +
> +	/* collapse the mapping into a mask of enable bits */
> +	mapping = (mapping >> pwm) & 0x55;
> +	mask = mapping & 0x01;
> +	mask |= (mapping & 0x04) >> 1;
> +	mask |= (mapping & 0x10) >> 2;
> +	mask |= (mapping & 0x40) >> 3;
> +
> +	/* disable smart tach according to the mask */
> +	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
> +	data->sfc2 &= ~mask;
> +	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
> +}
> +
> +static ssize_t store_pwm_freq(struct device *dev, const char *buf,
> +			      size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ctl4;
> +
> +	down(&data->update_lock);
> +	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
> +	ctl4 = (ctl4 & 0xf8) | LM93_PWM_FREQ_TO_REG(val);
> +	data->block9[nr][LM93_PWM_CTL4] = ctl4;
> +
> +	/* ctl4 = 0 -> 22.5KHz -> disable smart tach */
> +	if (!ctl4)
> +		lm93_disable_fan_smart_tach(client, data, nr);
> +
> +	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4), ctl4);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_channels(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",data->block9[nr][LM93_PWM_CTL1]);
> +}
> +
> +static ssize_t store_pwm_auto_channels(struct device *dev, const char *buf,
> +				       size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	data->block9[nr][LM93_PWM_CTL1] = SENSORS_LIMIT(val, 0, 255);
> +	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL1),
> +				data->block9[nr][LM93_PWM_CTL1]);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_spinup_min(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	u8 ctl3, ctl4;
> +
> +	ctl3 = data->block9[nr][LM93_PWM_CTL3];
> +	ctl4 = data->block9[nr][LM93_PWM_CTL4];
> +	return sprintf(buf,"%d\n",
> +		       LM93_PWM_FROM_REG(ctl3 & 0x0f, (ctl4 & 0x07) ?
> +			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
> +}
> +
> +static ssize_t store_pwm_auto_spinup_min(struct device *dev, const char *buf,
> +					 size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ctl3, ctl4;
> +
> +	down(&data->update_lock);
> +	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
> +	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
> +	ctl3 = (ctl3 & 0xf0) | 	LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
> +			LM93_PWM_MAP_LO_FREQ :
> +			LM93_PWM_MAP_HI_FREQ);
> +	data->block9[nr][LM93_PWM_CTL3] = ctl3;
> +	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_spinup_time(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_SPINUP_TIME_FROM_REG(
> +				data->block9[nr][LM93_PWM_CTL3]));
> +}
> +
> +static ssize_t store_pwm_auto_spinup_time(struct device *dev, const char *buf,
> +					  size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ctl3;
> +
> +	down(&data->update_lock);
> +	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
> +	ctl3 = (ctl3 & 0x1f) | (LM93_SPINUP_TIME_TO_REG(val) << 5 & 0xe0);
> +	data->block9[nr][LM93_PWM_CTL3] = ctl3;
> +	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_pwm_offset(offset) \
> +static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_pwm(dev, buf, offset - 1); \
> +} \
> +static ssize_t store_regs_pwm_##offset (struct device *dev, const char *buf, \
> +					size_t count) \
> +{ \
> +	return store_pwm(dev, buf, count, offset - 1); \
> +} \
> +static DEVICE_ATTR(pwm##offset, S_IRUGO|S_IWUSR, show_regs_pwm_##offset, \
> +			store_regs_pwm_##offset)
> +
> +#define sysfs_pwm_reg_offset(rop, offset) \
> +static ssize_t show_regs_pwm_##offset##_##rop (struct device *dev, char *buf) \
> +{ \
> +	return show_pwm_##rop(dev, buf, offset - 1); \
> +} \
> +static ssize_t store_regs_pwm_##offset##_##rop (struct device *dev, \
> +					const char *buf, size_t count) \
> +{ \
> +	return store_pwm_##rop(dev, buf, count, offset - 1); \
> +} \
> +static DEVICE_ATTR(pwm##offset##_##rop, S_IRUGO|S_IWUSR, \
> +			show_regs_pwm_##offset##_##rop, \
> +			store_regs_pwm_##offset##_##rop)
> +
> +#define sysfs_pwm_offsets(offset) \
> +sysfs_pwm_offset(offset); \
> +sysfs_pwm_reg_offset(override, offset); \
> +sysfs_pwm_reg_offset(freq, offset); \
> +sysfs_pwm_reg_offset(auto_channels, offset); \
> +sysfs_pwm_reg_offset(auto_spinup_min, offset); \
> +sysfs_pwm_reg_offset(auto_spinup_time, offset);
> +
> +sysfs_pwm_offsets(1);
> +sysfs_pwm_offsets(2);
> +
> +#define device_create_file_pwm(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_pwm##offset); \
> +device_create_file(&client->dev, &dev_attr_pwm##offset##_override); \
> +device_create_file(&client->dev, &dev_attr_pwm##offset##_freq); \
> +device_create_file(&client->dev, &dev_attr_pwm##offset##_auto_channels); \
> +device_create_file(&client->dev, &dev_attr_pwm##offset##_auto_spinup_min); \
> +device_create_file(&client->dev, &dev_attr_pwm##offset##_auto_spinup_time); \
> +} while (0)
> +
> +static ssize_t show_pwm_auto_prochot_ramp(struct device *dev, char *buf)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",
> +		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl >> 4 & 0x0f));
> +}
> +
> +static ssize_t store_pwm_auto_prochot_ramp(struct device *dev, const char *buf,
> +					   size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ramp;
> +
> +	down(&data->update_lock);
> +	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
> +	ramp = (ramp & 0x0f) | (LM93_RAMP_TO_REG(val) << 4 & 0xf0);
> +	lm93_write_byte(client, LM93_REG_PWM_RAMP_CTL, ramp);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(pwm_auto_prochot_ramp, S_IRUGO|S_IWUSR,
> +		   show_pwm_auto_prochot_ramp,
> +		   store_pwm_auto_prochot_ramp);
> +
> +static ssize_t show_pwm_auto_vrdhot_ramp(struct device *dev, char *buf)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",
> +		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl & 0x0f));
> +}
> +
> +static ssize_t store_pwm_auto_vrdhot_ramp(struct device *dev, const char *buf,
> +					  size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 ramp;
> +
> +	down(&data->update_lock);
> +	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
> +	ramp = (ramp & 0xf0) | (LM93_RAMP_TO_REG(val) & 0x0f);
> +	lm93_write_byte(client, LM93_REG_PWM_RAMP_CTL, ramp);
> +	up(&data->update_lock);
> +	return 0;
> +}
> +
> +static DEVICE_ATTR(pwm_auto_vrdhot_ramp, S_IRUGO|S_IWUSR,
> +		   show_pwm_auto_vrdhot_ramp,
> +		   store_pwm_auto_vrdhot_ramp);
> +
> +static ssize_t show_vid (struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_VID_FROM_REG(data->vid[nr]));
> +}
> +
> +#define sysfs_vid_offset(offset) \
> +static ssize_t show_regs_vid_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_vid (dev, buf, offset - 1); \
> +} \
> +static DEVICE_ATTR(vid##offset, S_IRUGO, show_regs_vid_##offset, NULL)
> +
> +sysfs_vid_offset(1);
> +sysfs_vid_offset(2);
> +
> +#define device_create_file_vid(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_vid##offset); \
> +} while (0)
> +
> +static ssize_t show_prochot(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",data->block4[nr].avg);
> +}
> +
> +static ssize_t show_prochot_max(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",data->prochot_max[nr]);
> +}
> +
> +static ssize_t store_prochot_max(struct device *dev, const char *buf,
> +				 size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	data->prochot_max[nr] = LM93_PROCHOT_TO_REG(val);
> +	lm93_write_byte(client, LM93_REG_PROCHOT_MAX(nr),
> +			data->prochot_max[nr]);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static const u8 prochot_override_mask[] = { 0x80, 0x40 };
> +
> +static ssize_t show_prochot_override(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",
> +		(data->prochot_override & prochot_override_mask[nr]) ? 1 : 0);
> +}
> +
> +static ssize_t store_prochot_override(struct device *dev, const char *buf,
> +				      size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	if (val)
> +		data->prochot_override |= prochot_override_mask[nr];
> +	else
> +		data->prochot_override &= (~prochot_override_mask[nr]);
> +	lm93_write_byte(client, LM93_REG_PROCHOT_OVERRIDE,
> +			data->prochot_override);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_prochot_interval(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	u8 tmp;
> +	if (nr=1)
> +		tmp = (data->prochot_interval & 0xf0) >> 4;
> +	else
> +		tmp = data->prochot_interval & 0x0f;
> +	return sprintf(buf,"%d\n",LM93_INTERVAL_FROM_REG(tmp));
> +}
> +
> +static ssize_t store_prochot_interval(struct device *dev, const char *buf,
> +				      size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +	u8 tmp;
> +
> +	down(&data->update_lock);
> +	tmp = lm93_read_byte(client, LM93_REG_PROCHOT_INTERVAL);
> +	if (nr=1)
> +		tmp = (tmp & 0x0f) | (LM93_INTERVAL_TO_REG(val) << 4);
> +	else
> +		tmp = (tmp & 0xf0) | LM93_INTERVAL_TO_REG(val);
> +	data->prochot_interval = tmp;
> +	lm93_write_byte(client, LM93_REG_PROCHOT_INTERVAL, tmp);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_prochot_offset(offset) \
> +static ssize_t show_regs_prochot_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_prochot(dev, buf, offset - 1); \
> +} \
> +static DEVICE_ATTR(prochot##offset,S_IRUGO,show_regs_prochot_##offset, NULL)
> +
> +#define sysfs_prochot_reg_offset(rop,offset) \
> +static ssize_t show_regs_prochot_##offset##_##rop (struct device *dev, \
> +							char *buf) \
> +{ \
> +	return show_prochot_##rop(dev, buf, offset - 1); \
> +} \
> +static ssize_t store_regs_prochot_##offset##_##rop (struct device *dev, \
> +					const char *buf, size_t count) \
> +{ \
> +	return store_prochot_##rop(dev, buf, count, offset - 1); \
> +} \

This can be eliminated when using sysfattr

> +static DEVICE_ATTR(prochot##offset##_##rop, S_IRUGO|S_IWUSR, \
> +			show_regs_prochot_##offset##_##rop, \
> +			store_regs_prochot_##offset##_##rop)
> +
> +#define sysfs_prochot_offsets(offset) \
> +sysfs_prochot_offset(offset); \
> +sysfs_prochot_reg_offset(max, offset); \
> +sysfs_prochot_reg_offset(override, offset); \
> +sysfs_prochot_reg_offset(interval, offset);
> +
> +sysfs_prochot_offsets(1);
> +sysfs_prochot_offsets(2);
> +
> +#define device_create_file_prochot(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_prochot##offset); \
> +device_create_file(&client->dev, &dev_attr_prochot##offset##_max); \
> +device_create_file(&client->dev, &dev_attr_prochot##offset##_override); \
> +device_create_file(&client->dev, &dev_attr_prochot##offset##_interval); \
> +} while (0)
> +
> +static ssize_t show_prochot_override_duty_cycle(struct device *dev, char *buf)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",data->prochot_override & 0x0f);
> +}
> +
> +static ssize_t store_prochot_override_duty_cycle(struct device *dev,
> +						 const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	data->prochot_override = (data->prochot_override & 0xf0) |
> +					SENSORS_LIMIT(val, 0, 15);
> +	lm93_write_byte(client, LM93_REG_PROCHOT_OVERRIDE,
> +			data->prochot_override);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(prochot_override_duty_cycle, S_IRUGO|S_IWUSR,
> +		   show_prochot_override_duty_cycle,
> +		   store_prochot_override_duty_cycle);
> +
> +static ssize_t show_prochot_short(struct device *dev, char *buf)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",(data->config & 0x10) ? 1 : 0);
> +}
> +
> +static ssize_t store_prochot_short(struct device *dev, const char *buf,
> +				   size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +	if (val)
> +		data->config |= 0x10;
> +	else
> +		data->config &= ~0x10;
> +	lm93_write_byte(client, LM93_REG_CONFIG, data->config);
> +	up(&data->update_lock);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(prochot_short, S_IRUGO|S_IWUSR, show_prochot_short,
> +		   store_prochot_short);
> +
> +static ssize_t show_vrdhot(struct device *dev, char *buf, int nr)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",
> +		       data->block1.host_status_1 & (1 << (nr+4)) ? 1 : 0);
> +}
> +
> +#define sysfs_vrdhot_offset(offset) \
> +static ssize_t show_regs_vrdhot_##offset (struct device *dev, char *buf) \
> +{ \
> +	return show_vrdhot(dev, buf, offset - 1); \

This could be eliminated using sysfs attributtes infrastructure

> +} \
> +static DEVICE_ATTR(vrdhot##offset, S_IRUGO, show_regs_vrdhot_##offset, NULL)
> +
> +sysfs_vrdhot_offset(1);
> +sysfs_vrdhot_offset(2);
> +#define device_create_file_vrdhot(client, offset) \
> +do { \
> +device_create_file(&client->dev, &dev_attr_vrdhot##offset); \
> +} while (0)
> +
> +static ssize_t show_gpio(struct device *dev, char *buf)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_GPI_FROM_REG(data->gpi));
> +}
> +
> +static DEVICE_ATTR(gpio, S_IRUGO, show_gpio, NULL);
> +
> +static ssize_t show_alarms(struct device *dev, char *buf)
> +{
> +	struct lm93_data *data = lm93_update_device(dev);
> +	return sprintf(buf,"%d\n",LM93_ALARMS_FROM_REG(data->block1));
> +}
> +
> +static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +
> +#define MAX_RETRIES 5
> +
> +static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> +{
> +	int value, i;
> +
> +	/* retry in case of read errors */
> +	for (i=1; i<=MAX_RETRIES; i++) {
> +		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
> +			return value;
> +		} else {
> +			dev_warn(&client->dev,"lm93: read byte data failed, "
> +				"address 0x%02x.\n", reg);
> +			mdelay(i + 3);
> +		}
> +
> +	}
> +
> +	/* <TODO> what to return in case of error? */

same as down. Return old value.

> +	dev_err(&client->dev,"lm93: All read byte retries failed!!\n");
> +	return 0;
> +}
> +
> +static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
> +{
> +	int result;
> +
> +	/* <TODO> how to handle write errors? */
> +	result = i2c_smbus_write_byte_data(client, reg, value);
> +
> +	if (result < 0)
> +		dev_warn(&client->dev,"lm93: write byte data failed, "
> +			 "0x%02x at address 0x%02x.\n", value, reg);
> +
> +	return result;
> +}
> +
> +static u16 lm93_read_word(struct i2c_client *client, u8 reg)
> +{
> +	int value, i;
> +
> +	/* retry in case of read errors */
> +	for (i=1; i<=MAX_RETRIES; i++) {
> +		if ((value = i2c_smbus_read_word_data(client, reg)) >= 0) {
> +			return value;
> +		} else {
> +			dev_warn(&client->dev,"lm93: read word data failed, "
> +				 "address 0x%02x.\n", reg);
> +			mdelay(i + 3);
> +		}
> +
> +	}
> +
> +	/* <TODO> what to return in case of error? */

You can supply to function as parameter old value and return it in case of read error.

> +	dev_err(&client->dev,"lm93: All read word retries failed!!\n");
> +	return 0;
> +}
> +
> +static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
> +{
> +	int result;
> +
> +	/* <TODO> how to handle write errors? */

Retry later?

> +	result = i2c_smbus_write_word_data(client, reg, value);
> +
> +	if (result < 0)
> +		dev_warn(&client->dev,"lm93: write word data failed, "
> +			 "0x%04x at address 0x%02x.\n", value, reg);
> +
> +	return result;
> +}
> +
> +static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
> +
> +/*
> +	read block data into values, retry if not expected length
> +	fbn => index to lm93_block_read_cmds table
> +		(Fixed Block Number - section 14.5.2 of LM93 datasheet)
> +*/
> +static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
> +{
> +	int i, result=0;
> +
> +	for (i = 1; i <= MAX_RETRIES; i++) {
> +		result = i2c_smbus_read_i2c_block_data(client, 
> +			lm93_block_read_cmds[fbn].cmd, lm93_block_buffer);
> +
> +		if (result = lm93_block_read_cmds[fbn].len) {
> +			break;
> +		} else {
> +			dev_warn(&client->dev,"lm93: block read data failed, "
> +				 "command 0x%02x.\n", 
> +				 lm93_block_read_cmds[fbn].cmd);
> +			mdelay(i + 3);
> +		}
> +	}
> +
> +	if (result = lm93_block_read_cmds[fbn].len) {
> +		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
> +	} else {
> +		/* <TODO> what to do in case of error? */

Issue a error message and use old values?

> +	}
> +}
> +
> +static struct lm93_data *lm93_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	const unsigned long interval = HZ + (HZ / 2);
> +
> +	down(&data->update_lock);
> +
> +	if (time_after(jiffies - data->last_updated, interval) ||
> +		time_before(jiffies, data->last_updated) || !data->valid) {
> +
> +		data->update(data, client);
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	up(&data->update_lock);
> +	return data;
> +}
> +
> +/* update routine for data that has no corresponding SMBus block command */
> +static void lm93_update_client_common(struct lm93_data *data,
> +				      struct i2c_client *client)
> +{
> +	int i;
> +	u8 *ptr;
> +
> +	/* temp1 - temp4: limits */
> +	for (i = 0; i < 4; i++) {
> +		data->temp_lim[i].min > +			lm93_read_byte(client, LM93_REG_TEMP_MIN(i));
> +		data->temp_lim[i].max > +			lm93_read_byte(client, LM93_REG_TEMP_MAX(i));
> +	}
> +
> +	/* config register */
> +	data->config = lm93_read_byte(client, LM93_REG_CONFIG);
> +
> +	/* vid1 - vid2: values */
> +	for (i = 0; i < 2; i++)
> +		data->vid[i] = lm93_read_byte(client, LM93_REG_VID(i));
> +
> +	/* prochot1 - prochot2: limits */
> +	for (i = 0; i < 2; i++)
> +		data->prochot_max[i] = lm93_read_byte(client,
> +				LM93_REG_PROCHOT_MAX(i));
> +
> +	/* vccp1 - vccp2: VID relative limits */
> +	for (i = 0; i < 2; i++)
> +		data->vccp_limits[i] = lm93_read_byte(client,
> +				LM93_REG_VCCP_LIMIT_OFF(i));
> +
> +	/* GPIO input state */
> +	data->gpi = lm93_read_byte(client, LM93_REG_GPI);
> +
> +	/* #PROCHOT override state */
> +	data->prochot_override = lm93_read_byte(client,
> +			LM93_REG_PROCHOT_OVERRIDE);
> +
> +	/* #PROCHOT intervals */
> +	data->prochot_interval = lm93_read_byte(client,
> +			LM93_REG_PROCHOT_INTERVAL);
> +
> +	/* Fan Boost Termperature registers */
> +	for (i = 0; i < 4; i++)
> +		data->boost[i] = lm93_read_byte(client, LM93_REG_BOOST(i));
> +
> +	/* Fan Boost Temperature Hyst. registers */
> +	data->boost_hyst[0] = lm93_read_byte(client, LM93_REG_BOOST_HYST_12);
> +	data->boost_hyst[1] = lm93_read_byte(client, LM93_REG_BOOST_HYST_34);
> +
> +	/* Temperature Zone Min. PWM & Hysteresis registers */
> +	data->auto_pwm_min_hyst[0] > +			lm93_read_byte(client, LM93_REG_PWM_MIN_HYST_12);
> +	data->auto_pwm_min_hyst[1] > +			lm93_read_byte(client, LM93_REG_PWM_MIN_HYST_34);
> +
> +	/* #PROCHOT & #VRDHOT PWM Ramp Control register */
> +	data->pwm_ramp_ctl = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
> +
> +	/* misc setup registers */
> +	data->sfc1 = lm93_read_byte(client, LM93_REG_SFC1);
> +	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
> +	data->sf_tach_to_pwm = lm93_read_byte(client,
> +			LM93_REG_SF_TACH_TO_PWM);
> +
> +	/* write back alarm values to clear */
> +	for (i = 0, ptr = (u8 *)(&data->block1); i < 8; i++)
> +		lm93_write_byte(client, LM93_REG_HOST_ERROR_1 + i, *(ptr + i));
> +}
> +
> +/* update routine which uses SMBus block data commands */
> +static void lm93_update_client_full(struct lm93_data *data,
> +				    struct i2c_client *client)
> +{
> +	dev_dbg(&client->dev,"lm93: starting device update "
> +				"(block data enabled)\n");
> +
> +	/* in1 - in16: values & limits */
> +	lm93_read_block(client, 3, (u8 *)(data->block3));
> +	lm93_read_block(client, 7, (u8 *)(data->block7));
> +
> +	/* temp1 - temp4: values */
> +	lm93_read_block(client, 2, (u8 *)(data->block2));
> +
> +	/* prochot1 - prochot2: values */
> +	lm93_read_block(client, 4, (u8 *)(data->block4));
> +
> +	/* fan1 - fan4: values & limits */
> +	lm93_read_block(client, 5, (u8 *)(data->block5));
> +	lm93_read_block(client, 8, (u8 *)(data->block8));
> +
> +	/* pmw control registers */
> +	lm93_read_block(client, 9, (u8 *)(data->block9));
> +
> +	/* alarm values */
> +	lm93_read_block(client, 1, (u8 *)(&data->block1));
> +
> +	/* auto/pwm registers */
> +	lm93_read_block(client, 10, (u8 *)(&data->block10));
> +
> +	lm93_update_client_common(data, client);
> +}
> +
> +/* update routine which uses SMBus byte/word data commands only */
> +static void lm93_update_client_min(struct lm93_data *data,
> +				   struct i2c_client *client)
> +{
> +	int i,j;
> +	u8 *ptr;
> +
> +	dev_dbg(&client->dev,"lm93: starting device update "
> +				"(block data disabled)\n");
> +
> +	/* in1 - in16: values & limits */
> +	for (i = 0; i < 16; i++) {
> +		data->block3[i] = 
> +			lm93_read_byte(client, LM93_REG_IN(i));
> +		data->block7[i].min > +			lm93_read_byte(client, LM93_REG_IN_MIN(i));
> +		data->block7[i].max > +			lm93_read_byte(client, LM93_REG_IN_MAX(i));
> +	}
> +
> +	/* temp1 - temp4: values */
> +	for (i = 0; i < 4; i++) {
> +		data->block2[i] > +			lm93_read_byte(client, LM93_REG_TEMP(i));
> +	}
> +
> +	/* prochot1 - prochot2: values */
> +	for (i = 0; i < 2; i++) {
> +		data->block4[i].cur > +			lm93_read_byte(client, LM93_REG_PROCHOT_CUR(i));
> +		data->block4[i].avg > +			lm93_read_byte(client, LM93_REG_PROCHOT_AVG(i));
> +	}
> +
> +	/* fan1 - fan4: values & limits */
> +	for (i = 0; i < 4; i++) {
> +		data->block5[i] > +			lm93_read_word(client, LM93_REG_FAN(i));
> +		data->block8[i] > +			lm93_read_word(client, LM93_REG_FAN_MIN(i));
> +	}
> +
> +	/* pwm control registers */
> +	for (i = 0; i < 2; i++) {
> +		for (j = 0; j < 4; j++) {
> +			data->block9[i][j] > +				lm93_read_byte(client, LM93_REG_PWM_CTL(i,j));
> +		}
> +	}
> +
> +	/* alarm values */
> +	for (i = 0, ptr = (u8 *)(&data->block1); i < 8; i++) {
> +		*(ptr + i) > +			lm93_read_byte(client, LM93_REG_HOST_ERROR_1 + i);
> +	}
> +
> +	/* auto/pwm (base temp) registers */
> +	for (i = 0; i < 4; i++) {
> +		data->block10.base[i] > +			lm93_read_byte(client, LM93_REG_TEMP_BASE(i));
> +	}
> +
> +	/* auto/pwm (offset temp) registers */
> +	for (i = 0; i < 12; i++) {
> +		data->block10.offset[i] > +			lm93_read_byte(client, LM93_REG_TEMP_OFFSET(i));
> +	}
> +
> +	lm93_update_client_common(data, client);
> +}
> +
> +static void lm93_init_client(struct i2c_client *client)
> +{
> +	int i;
> +	u8 reg;
> +
> +	/* configure VID pin input thresholds */
> +	reg = lm93_read_byte(client, LM93_REG_GPI_VID_CTL);
> +	lm93_write_byte(client, LM93_REG_GPI_VID_CTL,
> +			reg | (vid_agtl ? 0x03 : 0x00));

can you move this to init part? We assume mostly that bios did good job in most cases.

> +	if (init) {
> +		/* enable #ALERT pin */
> +		reg = lm93_read_byte(client, LM93_REG_CONFIG);
> +		lm93_write_byte(client, LM93_REG_CONFIG, reg | 0x08);
> +
> +		/* enable ASF mode for BMC status registers */
> +		reg = lm93_read_byte(client, LM93_REG_STATUS_CONTROL);
> +		lm93_write_byte(client, LM93_REG_STATUS_CONTROL, reg | 0x02);
> +
> +		/* set sleep state to S0 */
> +		lm93_write_byte(client, LM93_REG_SLEEP_CONTROL, 0);
> +
> +		/* unmask #VRDHOT and dynamic VCCP (if nec) error events */
> +		reg = lm93_read_byte(client, LM93_REG_MISC_ERR_MASK);
> +		reg &= ~0x03;
> +		reg &= ~(vccp_limit_type[0] ? 0x10 : 0);
> +		reg &= ~(vccp_limit_type[1] ? 0x20 : 0);
> +		lm93_write_byte(client, LM93_REG_MISC_ERR_MASK, reg);
> +	}
> +
> +	/* start monitoring */
> +	reg = lm93_read_byte(client, LM93_REG_CONFIG);
> +	lm93_write_byte(client, LM93_REG_CONFIG, reg | 0x01);
> +
> +	/* spin until ready */
> +	for (i=0; i<20; i++) {
> +		mdelay(10);
> +		if ((lm93_read_byte(client, LM93_REG_CONFIG) & 0x80) = 0x80)
> +			return;
> +	}
> +
> +	dev_warn(&client->dev,"lm93: timed out waiting for sensor "
> +		 "chip to signal ready!\n");
> +}
> +
> +static int lm93_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	struct lm93_data *data;
> +	struct i2c_client *client;
> +
> +	int err = 0, func;
> +	void (*update)(struct lm93_data *, struct i2c_client *);
> +
> +	/* lm93 is SMBus only */
> +	if (i2c_is_isa_adapter(adapter)) {
> +		dev_dbg(&adapter->dev,"lm93: detect failed, "
> +			"cannot attach to legacy adapter!\n");
> +		goto ERROR0;
> +	}
> +
> +	/* choose update routine based on bus capabilities */
> +	func = i2c_get_functionality(adapter);
> +	if ( ((LM93_SMBUS_FUNC_FULL & func) = LM93_SMBUS_FUNC_FULL) &&
> +			(!disable_block) ) {
> +		dev_dbg(&adapter->dev,"lm93: using SMBus block data "
> +			"transactions\n");
> +		update = lm93_update_client_full;
> +	} else if ((LM93_SMBUS_FUNC_MIN & func) = LM93_SMBUS_FUNC_MIN) {
> +		dev_dbg(&adapter->dev,"lm93: disabled SMBus block data "
> +			"transactions\n");
> +		update = lm93_update_client_min;
> +	} else {
> +		dev_dbg(&adapter->dev,"lm93: detect failed, "
> +			"smbus byte and/or word data not supported!\n");
> +		goto ERROR0;
> +	}
> +
> +	/* OK. For now, we presume we have a valid client. We now create the
> +	   client structure, even though we cannot fill it completely yet.
> +	   But it allows us to access lm78_{read,write}_value. */
> +
> +	if (!(client = kmalloc(sizeof(struct i2c_client) +
> +			       sizeof(struct lm93_data), GFP_KERNEL))) {
> +		dev_dbg(&adapter->dev,"lm93: out of memory!\n");
> +		err = -ENOMEM;
> +		goto ERROR0;
> +	}
> +
> +	memset(client, 0, sizeof(struct i2c_client) +
> +			  sizeof(struct lm93_data));
> +	data = (struct lm93_data *)(client + 1);
> +	i2c_set_clientdata(client, data);
> +	client->addr = address;
> +	client->adapter = adapter;
> +	client->driver = &lm93_driver;
> +	client->flags = 0;
> +	init_MUTEX(&data->lock);
> +
> +	/* detection */
> +	if (kind < 0) {
> +		int mfr = lm93_read_byte(client, LM93_REG_MFR_ID);
> +
> +		if (mfr != 0x01) {
> +			dev_dbg(&adapter->dev,"lm93: detect failed, "
> +				"bad manufacturer id 0x%02x!\n", mfr);
> +			goto ERROR1;
> +		}
> +	}
> +
> +	if (kind <= 0) {
> +		int ver = lm93_read_byte(client, LM93_REG_VER);
> +
> +		if ((ver = LM93_MFR_ID) || (ver = LM93_MFR_ID_PROTOTYPE)) {
> +			kind = lm93;
> +		} else {
> +			dev_dbg(&adapter->dev,"lm93: detect failed, "
> +				"bad version id 0x%02x!\n", ver);
> +			if (kind = 0)
> +				dev_dbg(&adapter->dev,"lm93: "
> +					"(ignored 'force' parameter)\n");
> +			goto ERROR1;
> +		}
> +	}
> +
> +	/* fill in remaining client fields */
> +	strlcpy(client->name, "lm93", I2C_NAME_SIZE);
> +	dev_dbg(&adapter->dev,"lm93: loading %s at %d,0x%02x\n",
> +		client->name, i2c_adapter_id(client->adapter),
> +		client->addr);
> +
> +	/* housekeeping */
> +	data->type = kind;
> +	data->valid = 0;
> +	data->update = update;
> +	init_MUTEX(&data->update_lock);
> +
> +	/* tell the I2C layer a new client has arrived */
> +	if ((err = i2c_attach_client(client)))
> +		goto ERROR1;
> +
> +	/* initialize the chip */
> +	lm93_init_client(client);
> +
> +	/* Register sysfs hooks */
> +	device_create_file_in(client, 1);
> +	device_create_file_in(client, 2);
> +	device_create_file_in(client, 3);
> +	device_create_file_in(client, 4);
> +	device_create_file_in(client, 5);
> +	device_create_file_in(client, 6);
> +	device_create_file_in(client, 7);
> +	device_create_file_in(client, 8);
> +	device_create_file_in(client, 9);
> +	device_create_file_in(client, 10);
> +	device_create_file_in(client, 11);
> +	device_create_file_in(client, 12);
> +	device_create_file_in(client, 13);
> +	device_create_file_in(client, 14);
> +	device_create_file_in(client, 15);
> +	device_create_file_in(client, 16);
> +
> +	device_create_file_temp(client, 1);
> +	device_create_file_temp(client, 2);
> +	device_create_file_temp(client, 3);
> +
> +	device_create_file_fan(client, 1);
> +	device_create_file_fan(client, 2);
> +	device_create_file_fan(client, 3);
> +	device_create_file_fan(client, 4);
> +
> +	device_create_file_pwm(client, 1);
> +	device_create_file_pwm(client, 2);
> +
> +	device_create_file(&client->dev, &dev_attr_pwm_auto_prochot_ramp);
> +	device_create_file(&client->dev, &dev_attr_pwm_auto_vrdhot_ramp);
> +
> +	device_create_file_vid(client, 1);
> +	device_create_file_vid(client, 2);
> +
> +	device_create_file_prochot(client, 1);
> +	device_create_file_prochot(client, 2);
> +
> +	device_create_file(&client->dev,
> +			   &dev_attr_prochot_override_duty_cycle);
> +	device_create_file(&client->dev, &dev_attr_prochot_short);
> +
> +	device_create_file_vrdhot(client, 1);
> +	device_create_file_vrdhot(client, 2);
> +
> +	device_create_file(&client->dev, &dev_attr_gpio);
> +	device_create_file(&client->dev, &dev_attr_alarms);
> +
> +	return 0;
> +
> +ERROR1:
> +	kfree(client);
> +ERROR0:
> +	return err;
> +}
> +
> +/* This function is called when:
> +     * lm93_driver is inserted (when this module is loaded), for each
> +       available adapter
> +     * when a new adapter is inserted (and lm93_driver is still present) */
> +static int lm93_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	return i2c_detect(adapter, &addr_data, lm93_detect);
> +}
> +
> +static int lm93_detach_client(struct i2c_client *client)
> +{
> +	if (i2c_detach_client(client)) {
> +		dev_err(&client->dev,"lm93: Client deregistration failed; "
> +			"client not detached.\n");
> +	}
> +
> +	kfree(client);
> +	return 0;
> +}
> +
> +static int __init lm93_init(void)
> +{
> +	return i2c_add_driver(&lm93_driver);
> +}
> +
> +static void __exit lm93_exit(void)
> +{
> +	i2c_del_driver(&lm93_driver);
> +}
> +
> +MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
> +MODULE_DESCRIPTION("LM93 driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(lm93_init);
> +module_exit(lm93_exit);
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

