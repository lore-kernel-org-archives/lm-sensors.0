From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Aug 2006 11:19:14 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <20060814131914.4b271eff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Better late than never...

> Hopefully this is it!
> - Shortened the code fences
> - Changed the default clause in the combined callbacks to call out an error
> - Changed the nr sensor-attr-2 field to a more meaningful name
> - Used static lookup tables where appropriate
> - Fixed a bug in the register mapping of the auto_point registers
> - Used ARRAY_SIZE macro instead of hardcoded values
> 
> This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite of the
> existing vt1211 driver (by Mark D. Studebaker and Lars Ekman) that has been
> around for a while but never made it into the main kernel tree.
>
> It is implemented as a platform driver and therefore requires the
> latest CVS version of lm_sensors to function properly.

This is good news, as i2c-isa is planned for removal by the end of the
year.

Here comes my review:

> --- linux-2.6.17-rc4-mm1-vanilla/drivers/hwmon/Kconfig	2006-05-17 21:11:46.000000000 +0000
> +++ linux-2.6.17-rc4-mm1/drivers/hwmon/Kconfig	2006-05-17 21:14:40.000000000 +0000
> @@ -397,6 +397,17 @@ config SENSORS_VT8231
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called vt8231.
>  
> +config SENSORS_VT1211
> +	tristate "Via VT1211"

VIA should always be spelled all in capitals.

> +	depends on HWMON && EXPERIMENTAL
> +	select HWMON_VID
> +	help
> +	  If you say yes here then you get support for hardware monitoring
> +	  features of the VIA VT1211 Super-I/O chip.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called vt1211.
> +

The logical order would suggest to put this entry before the VT8231
entry.

>  config SENSORS_W83781D
>  	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
>  	depends on HWMON && I2C
> diff -uprN -X linux-2.6.17-rc4-mm1-vanilla/Documentation/dontdiff -x Documentation -x usr -x dwarf2-defs.h linux-2.6.17-rc4-mm1-vanilla/drivers/hwmon/Makefile linux-2.6.17-rc4-mm1/drivers/hwmon/Makefile
> --- linux-2.6.17-rc4-mm1-vanilla/drivers/hwmon/Makefile	2006-05-17 21:11:46.000000000 +0000
> +++ linux-2.6.17-rc4-mm1/drivers/hwmon/Makefile	2006-05-17 21:14:40.000000000 +0000
> @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_VIA686A)	+= via686a
>  obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
>  obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
>  obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
> +obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o

In alphabetical order please.

>  
>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff -uprN -X linux-2.6.17-rc4-mm1-vanilla/Documentation/dontdiff -x Documentation -x usr -x dwarf2-defs.h linux-2.6.17-rc4-mm1-vanilla/drivers/hwmon/vt1211.c linux-2.6.17-rc4-mm1/drivers/hwmon/vt1211.c
> --- linux-2.6.17-rc4-mm1-vanilla/drivers/hwmon/vt1211.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17-rc4-mm1/drivers/hwmon/vt1211.c	2006-05-31 17:30:42.000000000 +0000
> @@ -0,0 +1,1103 @@
> +/*
> + * vt1211.c - driver for the VIA VT1211 Super-I/O chip integrated hardware
> + *            monitoring features
> + * Copyright (C) 2006 Juerg Haefliger <juergh at gmail.com>
> + * Copyright (C) 2004 Lars Ekman <emil71se at yahoo.com>
> + * Copyright (C) 2002 Mark D. Studebaker <mdsxyz123 at yahoo.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/platform_device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon-vid.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <asm/io.h>
> +
> +static int uch_config;
> +module_param(uch_config, int, -1);

I guess the intent was to initialize uch_config to -1? That's not what
the code is doing. The third parameter of module_param, if not 0, sets
the permissions of an attribute file for the driver in sysfs. With the
code above, if you look in /sys/bus/platform/drivers/vt1211, you'll
probably see an uch_config file with very strange permissions. So what
you really want is:

static int uch_config = -1;
module_param(uch_config, int, 0);

Strange that nobody noticed, because your driver currently forces
uch_config to 0 rather than preserving the chip defaults (possibly set
by the BIOS.)

> +MODULE_PARM_DESC(uch_config, "Initialize the universal channel configuration");

Do you know systems where this is actually needed? When porting the
vt8231 driver, we made the choice to always trust the BIOS. Nobody
complained about this. The right configuration depends on the hardware,
and the user is unlikely to know better than the BIOS.

> +
> +static struct platform_device *pdev;
> +
> +#define DRVNAME "vt1211"
> +
> +/* ---------------------------------------------------------------------
> + * Registers
> + *
> + * The sensors are defined as follows. Temp3 and temp1 are swapped to match
> + * the VT1211 driver for kernel 2.4.
> + *
> + * Sensor          Voltage Mode   Temp Mode   Notes (from the datasheet)
> + * --------        ------------   ---------   --------------------------
> + * Reading 1                      temp3       Intel thermal diode
> + * Reading 3                      temp1       Internal thermal diode
> + * UCH1/Reading2   in0            temp2       NTC type thermistor
> + * UCH2            in1            temp4       +2.5V
> + * UCH3            in2            temp5       VccP
> + * UCH4            in3            temp6       +5V
> + * UCH5            in4            temp7       +12V
> + * 3.3V            in5                        Internal VDD (+3.3V)
> + * -12V            in6                        Reserved

Has in6 been reported to work for anyone? The Linux 2.4 driver didn't
have it, I don't see it in the VT1211 datasheet, and I don't see any
pin for it on the VT1211 pin diagram. I suggest to drop it.

> + *
> + * --------------------------------------------------------------------- */
> +
> +/* Voltages (in) numbered 0-6 (ix) */
> +#define VT1211_REG_IN(ix)		(0x21 + (ix))
> +#define VT1211_REG_IN_MIN(ix)		((ix) = 0 ? 0x3e : 0x2a + 2 * (ix))
> +#define VT1211_REG_IN_MAX(ix)		((ix) = 0 ? 0x3d : 0x29 + 2 * (ix))
> +
> +static const u8 regtemp[]	= {0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25};
> +static const u8 regtempmax[]	= {0x1d, 0x3d, 0x39, 0x2b, 0x2d, 0x2f, 0x31};
> +static const u8 regtemphyst[]	= {0x1e, 0x3e, 0x3a, 0x2c, 0x2e, 0x30, 0x32};

The Linux 2.4 driver has the limits of temp1 and temp3 swapped. I
assume this is a bug in the 2.4 driver, and yours is correct? If so, we
should fix the 2.4 driver.

> +
> +/* Temperatures (temp) numbered 0-6 (ix) */
> +#define VT1211_REG_TEMP(ix)		(regtemp[(ix)])
> +#define VT1211_REG_TEMP_MAX(ix)		(regtempmax[(ix)])
> +#define VT1211_REG_TEMP_HYST(ix)	(regtemphyst[(ix)])

Please access the arrays directly.

> +
> +/* Fans numbered 0-1 (ix) */
> +#define VT1211_REG_FAN(ix)		(0x29 + (ix))
> +#define VT1211_REG_FAN_MIN(ix)		(0x3b + (ix))
> +#define VT1211_REG_FAN_DIV	 	 0x47
> +
> +/* PWMs numbered 0-1 (ix) */
> +/* Auto points numbered 0-3 (ap) */
> +#define VT1211_REG_PWM(ix)		(0x60 + (ix))
> +#define VT1211_REG_PWM_CLK		 0x50
> +#define VT1211_REG_PWM_CTL		 0x51
> +#define VT1211_REG_PWM_AUTO_TEMP(ap)	(0x52 + (ap))
> +#define VT1211_REG_PWM_AUTO_PWM(ix, ap)	(0x55 + 2 * (ix) + ap)

Missing parentheses around "ap". I think I'd also prefer it written:
(0x56 + 2 * (ix) + ((ap) - 1))
Result is the same, but easier to match against the datasheet.

> +
> +/* Miscellaneous registers */
> +#define VT1211_REG_CONFIG		0x40
> +#define VT1211_REG_ALARM1		0x41
> +#define VT1211_REG_ALARM2		0x42
> +#define VT1211_REG_VID			0x45
> +#define VT1211_REG_UCH_CONFIG		0x4a
> +#define VT1211_REG_TEMP1_CONFIG		0x4b
> +#define VT1211_REG_TEMP2_CONFIG		0x4c
> +
> +static const u8 bitalarmin[] 	= {11,  0, 1, 3, 8, 2, 9};
> +static const u8 bitalarmtemp[]	= {15, 11, 4, 0, 1, 3, 8};
> +static const u8 bitalarmfan[]	= {6, 7};
> +
> +/* In, temp & fan alarm bits */
> +#define VT1211_BIT_ALARM_IN(ix)		(bitalarmin[ix])
> +#define VT1211_BIT_ALARM_TEMP(ix)	(bitalarmtemp[ix])
> +#define VT1211_BIT_ALARM_FAN(ix)	(bitalarmfan[ix])

Same here, please access the arrays directly.

> +
> +/* ---------------------------------------------------------------------
> + * Data structures and manipulation thereof
> + * --------------------------------------------------------------------- */
> +
> +struct vt1211_data {
> +	unsigned short addr;
> +	const char *name;
> +	struct mutex lock;

This lock isn't used anywhere, you can drop it.

> +	struct class_device *class_dev;
> +
> +	struct mutex update_lock;
> +	char valid;			/* !=0 if following fields are valid */
> +	unsigned long last_updated;	/* In jiffies */
> +
> +	/* Register values */
> +	u8  in[7];
> +	u8  in_max[7];
> +	u8  in_min[7];
> +	u8  temp[7];
> +	u8  temp_max[7];
> +	u8  temp_hyst[7];
> +	u8  fan[2];
> +	u8  fan_min[2];
> +	u8  fan_div[2];
> +	u8  fan_ctl;
> +	u8  pwm[2];
> +	u8  pwm_ctl[2];
> +	u8  pwm_clk;
> +	u8  pwm_auto_temp[4];
> +	u8  pwm_auto_pwm[2][4];
> +	u8  vid;		/* Read once at init time */
> +	u8  vrm;
> +	u8  uch_config;		/* Read once at init time */
> +	u16 alarms;
> +};
> +
> +/* ix = [0-6] */
> +#define ISVOLT(ix, uch_config)	((ix) > 4 ? 1 : \
> +				 !(((uch_config) >> ((ix) + 2)) & 1))
> +
> +/* ix = [0-6] */
> +#define ISTEMP(ix, uch_config)	((ix) = 0 ? 1 : \
> +				 (ix) = 2 ? 1 : \
> +				 (ix) = 1 ? ((uch_config) >> 2) & 1 : \
> +				 ((uch_config) >> (ix)) & 1)
> +
> +/* in5 (ix = 5) is special. It's the internal 3.3V so it's scaled in the
> +   driver according to the VT1211 BIOS porting guide */
> +#define IN_FROM_REG(ix, val)	((val) < 3 ? 0 : (ix) = 5 ? \
> +				 ((val) - 3) * 15882 / 958 : \
> +				 ((val) - 3) * 10000 / 958)
> +#define IN_TO_REG(ix, val)	((ix) = 5 ? \
> +			   	 SENSORS_LIMIT((((val) * 958 / 15882) + 3), \
> +					0, 255) : \
> +			   	 SENSORS_LIMIT((((val) * 958 / 10000) + 3), \
> +				   	0, 255))

Please add proper rounding.

> +
> +/* temp1 (ix = 0) is special. It's the internal temp diode so it's scaled in
> +   the driver according to some measurements that I took on my EPIA M10000 */
> +#define TEMP_FROM_REG(ix, val)	((ix) = 0 ? \
> +				 (val) < 51 ? 0 : ((val) - 51) * 1000 : \
> +				 (val) * 1000)
> +#define TEMP_TO_REG(ix, val)	((ix) = 0 ? \
> +				 SENSORS_LIMIT((((val) / 1000) + 51), \
> +				 	0, 255) : \
> +				 SENSORS_LIMIT(((val) / 1000), 0, 255))

No official formula for temp1? Indeed I can't find any in the datasheet
nor BIOS porting guide :( I think it's OK to "scale" temp1 inside the
driver, however the Linux 2.4 driver didn't, so if we want a common
configuration file we'll have to modify the Linux 2.4 driver. It would
also be nice to check on another system how accurate your empirical
formula is.

temp3 is scaled in userspace and it's OK as the diode model (and thus
characteristics) depends on the CPU.

For all other temperature channels, I'm not OK. These are
thermistor-based measurements with external resistors and thermistors,
so most scaling belongs to userspace. What we want to export here is
the voltage at the pins, in mV. This wasn't done correctly in the
Linux 2.4 driver, but in 2.6 we have a standard interface and we have
to respect it. This is exactly the same as for the VT8231 so the same
formula should work:

#define TEMP_FROM_REG(reg)		(((253 * 4 - (reg)) * 550 + 105) / 210)
#define TEMP_MAXMIN_FROM_REG(reg)	(((253 - (reg)) * 2200 + 105) / 210)
#define TEMP_MAXMIN_TO_REG(val)		(253 - ((val) * 210 + 1100) / 2200)

Of course we will have to change the configuration file to accomodate
the change, as we did for the vt8231 driver.

BTW, I see you don't export the additional precision bits for these
temperature channels. Any reason why? The original driver supported
them.

> +
> +#define DIV_FROM_REG(val) 	(1 << (val))
> +#define DIV_TO_REG(val)   	((val) = 8 ? 3 : \
> +			   	 (val) = 4 ? 2 : \
> +			   	 (val) = 1 ? 0 : 1)

We now try to return errors on invalid divider values, rather than
using a default value. This means that you should no more have a macro
for this, instead you should check for valid values in the set_fan
function directly (return -EINVAL on invalid values.) Take a look af
fscher.c:set_fan_div() for an example.

> +
> +#define PWM_FROM_REG(val) 	(val)

Useless macro, please drop.

> +#define PWM_TO_REG(val)   	SENSORS_LIMIT((val), 0, 255)

Here too, recent implementations tend to return an error on
out-of-range values.

> +
> +#define RPM_FROM_REG(val, div)	((val) <= 0   ? 0 : \
> +				 (val) >= 255 ? 0 : \
> +				 1310720 / (val) / DIV_FROM_REG(div))

val < 0 and val > 255 just can't happen ;)

> +#define RPM_TO_REG(rpm, div)	((rpm) = 0 ? 0 : \
> +				 SENSORS_LIMIT((1310720 / (rpm) / \
> +				 	DIV_FROM_REG(div)), 1, 255))

The datasheet suggests that 255 should be written to disable the alarm,
rather than 0. If so, the SENSORS_LIMIT should also be done with (...,
1, 254) as its parameters, i.e. pick the lowest possible limit rather
than 0 when a very low value is requested.

> +
> +static const u8 tempix2pwmctl[]	= {1, 2, 0, 3, 4, 5, 6};
> +static const u8 pwmctl2tempix[]	= {2, 0, 1, 3, 4, 5, 6, 2};
> +
> +#define TEMPIX_FROM_REG(val)	(pwmctl2tempix[val])
> +#define TEMPIX_TO_REG(ix)	(tempix2pwmctl[ix])

Same as above, please access the arrays directly.

> +
> +/* ---------------------------------------------------------------------
> + * Super-I/O constants and functions
> + * --------------------------------------------------------------------- */
> +
> +/* Configuration & data index port registers */
> +#define SIO_REG_CIP		0x2e
> +#define SIO_REG_DIP		0x2f
> +
> +/* Configuration registers */
> +#define SIO_VT1211_LDN		0x07	/* logical device number */
> +#define SIO_VT1211_DEVID	0x20	/* device ID */
> +#define SIO_VT1211_DEVREV	0x21	/* device revision */
> +#define SIO_VT1211_BADDR	0x60	/* base I/O address */
> +#define SIO_VT1211_BADDR_MASK	0xff80
> +
> +#define SIO_VT1211_ID		0x3c	/* VT1211 device ID */
> +
> +/* VT1211 logical device numbers */
> +#define SIO_VT1211_LDN_HWMON	0x0b	/* HW monitor */
> +
> +static inline void superio_outb(int reg, int val)
> +{
> +	outb(reg, SIO_REG_CIP);
> +	outb(val, SIO_REG_DIP);
> +}
> +
> +static inline int superio_inb(int reg)
> +{
> +	outb(reg, SIO_REG_CIP);
> +	return inb(SIO_REG_DIP);
> +}
> +
> +static inline void superio_select(int ldn)
> +{
> +	outb(SIO_VT1211_LDN, SIO_REG_CIP);
> +	outb(ldn, SIO_REG_DIP);
> +}
> +
> +static inline void superio_enter(void)
> +{
> +	outb(0x87, SIO_REG_CIP);
> +	outb(0x87, SIO_REG_CIP);
> +}
> +
> +static inline void superio_exit(void)
> +{
> +	outb(0xaa, SIO_REG_CIP);
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Device I/O access
> + * --------------------------------------------------------------------- */
> +
> +static u8 vt1211_read8(struct vt1211_data *data, u8 reg)
> +{
> +	return inb(data->addr + reg);
> +}
> +
> +static void vt1211_write8(struct vt1211_data *data, u8 reg, u8 val)
> +{
> +	outb(val, data->addr + reg);
> +}

These two should certainly be inlined for performance.

> +
> +static struct vt1211_data *vt1211_update_device(struct device *dev)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	int ix, val;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* registers cache is refreshed after 1 second */
> +	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> +
> +		/* voltage (in) registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
> +			if (ISVOLT(ix, data->uch_config)) {
> +				data->in[ix] = vt1211_read8(data,
> +						VT1211_REG_IN(ix));
> +				data->in_min[ix] = vt1211_read8(data,
> +						VT1211_REG_IN_MIN(ix));
> +				data->in_max[ix] = vt1211_read8(data,
> +						VT1211_REG_IN_MAX(ix));
> +			} else {
> +				data->in[ix] = 0;
> +				data->in_min[ix] = 0;
> +				data->in_max[ix] = 0;
> +			}
> +		}

This is inefficient. Given that uch_config never changes, you will end
up writing 0 to the same array locations over and over again. You
should do it once at device initialization time instead. And actually
you don't need to, because 0 is the default value (thanks to kzalloc).

> +
> +		/* temp registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->temp); ix++) {
> +			if (ISTEMP(ix, data->uch_config)) {
> +				data->temp[ix] = vt1211_read8(data,
> +						VT1211_REG_TEMP(ix));
> +				data->temp_max[ix] = vt1211_read8(data,
> +						VT1211_REG_TEMP_MAX(ix));
> +				data->temp_hyst[ix] = vt1211_read8(data,
> +						VT1211_REG_TEMP_HYST(ix));
> +			} else {
> +				data->temp[ix] = 0;
> +				data->temp_max[ix] = 0;
> +				data->temp_hyst[ix] = 0;
> +			}
> +		}
> +
> +		/* fan & pwm registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {
> +			data->fan[ix] = vt1211_read8(data,
> +						VT1211_REG_FAN(ix));
> +			data->fan_min[ix] = vt1211_read8(data,
> +						VT1211_REG_FAN_MIN(ix));
> +			data->pwm[ix] = vt1211_read8(data,
> +						VT1211_REG_PWM(ix));
> +		}
> +		val = vt1211_read8(data, VT1211_REG_FAN_DIV);
> +		data->fan_div[0] = (val >> 4) & 3;
> +		data->fan_div[1] = (val >> 6) & 3;
> +		data->fan_ctl = val & 0xf;
> +
> +		val = vt1211_read8(data, VT1211_REG_PWM_CTL);
> +		data->pwm_ctl[0] = val & 0xf;
> +		data->pwm_ctl[1] = (val >> 4) & 0xf;
> +
> +		data->pwm_clk = vt1211_read8(data, VT1211_REG_PWM_CLK);
> +
> +		/* pwm & temp auto point registers */
> +		data->pwm_auto_pwm[0][0] = 255;	/* hard wired */
> +		data->pwm_auto_pwm[0][1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(0, 1));
> +		data->pwm_auto_pwm[0][2] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(0, 2));
> +		data->pwm_auto_pwm[0][3] = 0;	/* hard wired */
> +		data->pwm_auto_pwm[1][0] = 255;	/* hard wired */
> +		data->pwm_auto_pwm[1][1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(1, 1));
> +		data->pwm_auto_pwm[1][2] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(1, 2));
> +		data->pwm_auto_pwm[1][3] = 0;	/* hard wired */

Again, the values which are hard-wired do not belong to this update
function, but to the device initialization.

> +		for (ix = 0; ix < ARRAY_SIZE(data->pwm_auto_temp); ix++) {
> +			data->pwm_auto_temp[ix] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_TEMP(ix));
> +		}
> +
> +		/* alarm registers */
> +		data->alarms = (vt1211_read8(data, VT1211_REG_ALARM2) << 8) |
> +				vt1211_read8(data, VT1211_REG_ALARM1);
> +
> +

One too many blank line.

> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Voltage sysfs interfaces
> + * ix = [0-6]
> + * --------------------------------------------------------------------- */
> +
> +#define SHOW_IN_INPUT	0
> +#define SHOW_SET_IN_MIN	1
> +#define SHOW_SET_IN_MAX	2
> +#define SHOW_IN_ALARM	3
> +
> +static ssize_t show_in(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res = 0;

Please add a blank line after variable declarations in all your
callback functions, it greatly increases the readability.

> +	switch (fn) {
> +	case SHOW_IN_INPUT:
> +		res = IN_FROM_REG(ix, data->in[ix]);
> +		break;
> +	case SHOW_SET_IN_MIN:
> +		res = IN_FROM_REG(ix, data->in_min[ix]);
> +		break;
> +	case SHOW_SET_IN_MAX:
> +		res = IN_FROM_REG(ix, data->in_max[ix]);
> +		break;
> +	case SHOW_IN_ALARM:
> +		res = ISVOLT(ix, data->uch_config) &
> +		      (data->alarms >> VT1211_BIT_ALARM_IN(ix)) & 1;
> +		break;
> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");

As I understand it, the default case can't happen unless the driver is
broken. Thus it would make sense to make this a debug message. Also,
please convert all these printk calls to dev_err, dev_dbg, etc. These
provide a uniform way to print device messages.

You can also move the initialization of res to 0 here, as other cases don't need it.

> +	}
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_in(struct device *dev, struct device_attribute *attr,
> +		      const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SHOW_SET_IN_MIN:
> +		data->in_min[ix] = IN_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_IN_MIN(ix), data->in_min[ix]);
> +		break;
> +	case SHOW_SET_IN_MAX:
> +		data->in_max[ix] = IN_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_IN_MAX(ix), data->in_max[ix]);
> +		break;
> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Temperature sysfs interfaces
> + * ix = [0-6]
> + * --------------------------------------------------------------------- */
> +
> +#define SHOW_TEMP_INPUT		0
> +#define SHOW_SET_TEMP_MAX	1
> +#define SHOW_SET_TEMP_MAX_HYST	2
> +#define SHOW_TEMP_ALARM		3
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res = 0;
> +	switch (fn) {
> +	case SHOW_TEMP_INPUT:
> +		res = TEMP_FROM_REG(ix, data->temp[ix]);
> +		break;
> +	case SHOW_SET_TEMP_MAX:
> +		res = TEMP_FROM_REG(ix, data->temp_max[ix]);
> +		break;
> +	case SHOW_SET_TEMP_MAX_HYST:
> +		res = TEMP_FROM_REG(ix, data->temp_hyst[ix]);
> +		break;
> +	case SHOW_TEMP_ALARM:
> +		res = ISTEMP(ix, data->uch_config) &
> +		      (data->alarms >> VT1211_BIT_ALARM_TEMP(ix)) & 1;
> +		break;
> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SHOW_SET_TEMP_MAX:
> +		data->temp_max[ix] = TEMP_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_TEMP_MAX(ix),
> +			      data->temp_max[ix]);
> +		break;
> +	case SHOW_SET_TEMP_MAX_HYST:
> +		data->temp_hyst[ix] = TEMP_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_TEMP_HYST(ix),
> +			      data->temp_hyst[ix]);
> +		break;
> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Fan sysfs interfaces
> + * ix = [0-1]
> + *  -------------------------------------------------------------------- */

Missing dash ;)

> +
> +#define SHOW_FAN_INPUT		0
> +#define SHOW_SET_FAN_MIN	1
> +#define SHOW_SET_FAN_DIV	2
> +#define SHOW_FAN_ALARM		3
> +
> +static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res = 0;
> +	switch (fn) {
> +	case SHOW_FAN_INPUT:
> +		res = RPM_FROM_REG(data->fan[ix], data->fan_div[ix]);
> +		break;
> +	case SHOW_SET_FAN_MIN:
> +		res = RPM_FROM_REG(data->fan_min[ix], data->fan_div[ix]);
> +		break;
> +	case SHOW_SET_FAN_DIV:
> +		res = DIV_FROM_REG(data->fan_div[ix]);
> +		break;
> +	case SHOW_FAN_ALARM:
> +		res = (data->alarms >> VT1211_BIT_ALARM_FAN(ix)) & 1;
> +		break;
> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SHOW_SET_FAN_MIN:
> +		data->fan_min[ix] = RPM_TO_REG(val, data->fan_div[ix]);
> +		vt1211_write8(data, VT1211_REG_FAN_MIN(ix),
> +			      data->fan_min[ix]);
> +		break;
> +	case SHOW_SET_FAN_DIV:
> +		data->fan_div[ix] = DIV_TO_REG(val);
> +		vt1211_write8(data, VT1211_REG_FAN_DIV,
> +			      ((data->fan_div[1] << 6) |
> +			       (data->fan_div[0] << 4) |
> +				data->fan_ctl));
> +		break;

Not correct. You assume the data cache is in synch with register
VT1211_REG_FAN_DIV, while it may not be (e.g. if this function is
called before the update function ever is.) Please read the contents of
VT1211_REG_FAN_DIV so that you are sure you won't change bits in that
register.

> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * PWM sysfs interfaces
> + * ix = [0-1]
> + * --------------------------------------------------------------------- */

Was PWM tested on the VT1211? Both manual and automatic modes? I
remember we dropped it from the vt8231 driver because it didn't
actually work for anyone.

> +
> +#define SHOW_PWM			0
> +#define SHOW_SET_PWM_ENABLE		1
> +#define SHOW_SET_PWM_FREQUENCY		2
> +#define SHOW_SET_PWM_AUTO_CHANNELS_TEMP	3
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int en, sg;

What explicit variable names ;) Care to make them a bit longer, or at
least add a short comment for each?

> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res = 0;
> +	switch (fn) {
> +	case SHOW_PWM:
> +		res = PWM_FROM_REG(data->pwm[ix]);
> +		break;
> +	case SHOW_SET_PWM_ENABLE:
> +		en = (data->pwm_ctl[ix] >> 3) & 1;
> +		sg = data->fan_ctl & 1;
> +		res = (en && sg) ? 2 : en ? 1 : 0;

What does it mean when en = 0? Fan stopped, or fan at full speed? I
hope the latter.

> +		break;
> +	case SHOW_SET_PWM_FREQUENCY:
> +		res = 90000 >> (data->pwm_clk & 7);
> +		break;
> +	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> +		res = TEMPIX_FROM_REG(data->pwm_ctl[ix] & 7) + 1;
> +		break;
> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int tmp;
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SHOW_SET_PWM_ENABLE:
> +		/* fan[1-2] out enable bits */
> +		if (val) {
> +			data->pwm_ctl[ix] |= 8;
> +		} else {
> +			data->pwm_ctl[ix] &= 7;
> +		}
> +		/* SmartGuardian controller enable bit */
> +		if (val > 1) {
> +			data->fan_ctl |= 1;
> +		} else {
> +			data->fan_ctl &= 0xe;
> +		}
> +		vt1211_write8(data, VT1211_REG_PWM_CTL,
> +			      ((data->pwm_ctl[1] << 4) |
> +				data->pwm_ctl[0]));
> +		vt1211_write8(data, VT1211_REG_FAN_DIV,
> +			      ((data->fan_div[1] << 6) |
> +			       (data->fan_div[0] << 4) |
> +				data->fan_ctl));
> +		break;

Here again, you assume that your cached values are up-to-date. You must
instead read them from the chip. Same for all other similar cases.

I think I understand that setting one PWM channel in automatic mode
will set the other channel in automatic mode as well, right?

> +	case SHOW_SET_PWM_FREQUENCY:
> +		val = 135000/SENSORS_LIMIT(val, 135000>>7, 135000);
> +		/* calculate tmp = log2(val) */
> +		tmp = 0;
> +		for (val >>= 1; val > 0; val >>= 1) {
> +			tmp++;
> +		}

Wow, this is clever :)

> +		data->pwm_clk = (data->pwm_clk & 0xf8) | tmp;
> +		vt1211_write8(data, VT1211_REG_PWM_CLK, data->pwm_clk);
> +		break;
> +	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> +		tmp = TEMPIX_TO_REG(SENSORS_LIMIT(val, 1, 7) - 1);

You should make sure that this channel is actually a temperature
channel!

> +		data->pwm_ctl[ix] = (data->pwm[ix] & 8) | tmp;

Isn't it a wonderful typo I see here?

> +		vt1211_write8(data, VT1211_REG_PWM_CTL,
> +			      ((data->pwm_ctl[1] << 4) | data->pwm_ctl[0]));
> +		break;

Do we agree that changing the temperature channel may also change the
temperature points as a side effect? Don't we want to prevent that?

> +	default:
> +		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * PWM auto point definitions
> + * ix = [0-1]
> + * ap = [0-3]
> + * --------------------------------------------------------------------- */
> +
> +/*
> + * pwm[ix]_auto_point[ap]_temp mapping table:

Actually [ix+1].

> + * Note that there is only a single set of temp auto points that controls both
> + * PWM controllers. We still create 2 sets of sysfs files to make it look
> + * more consistent even though they map to the same registers.

The second set should be made read-only to help clear the confusion.

> + *
> + * ix ap : description
> + * -------------------
> + * 0  0  : pwm1/pwm2 full speed temperature (pwm_auto_temp[0])
> + * 0  1  : pwm1/pwm2 high speed temperature (pwm_auto_temp[1])
> + * 0  2  : pwm1/pwm2 low speed temperature (pwm_auto_temp[2])
> + * 0  3  : pwm1/pwm2 off temperature (pwm_auto_temp[3])

Iirk, you have it all reversed. point 0 should be fan off, point with
the higher number should be fan at full speed.

> + * 1  0  : pwm1/pwm2 full speed temperature (pwm_auto_temp[0])
> + * 1  1  : pwm1/pwm2 high speed temperature (pwm_auto_temp[1])
> + * 1  2  : pwm1/pwm2 low speed temperature (pwm_auto_temp[2])
> + * 1  3  : pwm1/pwm2 off temperature (pwm_auto_temp[3])
> + */
> +
> +static ssize_t show_pwm_auto_point_temp(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	int tmp = TEMPIX_FROM_REG(data->pwm_ctl[ix] & 7);
> +	return sprintf(buf, "%d\n",
> +		       TEMP_FROM_REG(tmp, data->pwm_auto_temp[ap]));
> +}
> +
> +static ssize_t set_pwm_auto_point_temp(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	int tmp = TEMPIX_FROM_REG(data->pwm_ctl[ix] & 7);
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	data->pwm_auto_temp[ap] = TEMP_TO_REG(tmp, val);
> +	vt1211_write8(data, VT1211_REG_PWM_AUTO_TEMP(ap),
> +		      data->pwm_auto_temp[ap]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/*
> + * pwm[ix]_auto_point[ap]_pwm mapping table:
> + * Note that the PWM auto points 0 & 3 are hard-wired in the VT1211 and can't
> + * be changed.
> + *
> + * ix ap : description
> + * -------------------
> + * 0  0  : pwm1 full speed duty cycle (pwm_auto_pwm[0][0], hard-wired to 255)
> + * 0  1  : pwm1 high speed duty cycle (pwm_auto_pwm[0][1])
> + * 0  2  : pwm1 low speed duty cycle (pwm_auto_pwm[0][2])
> + * 0  3  : pwm1 off (pwm_auto_pwm[0][3], hard-wired to 0)
> + * 1  0  : pwm2 full speed duty cycle (pwm_auto_pwm[1][0], hard-wired to 255)
> + * 1  1  : pwm2 high speed duty cycle (pwm_auto_pwm[1][1])
> + * 1  2  : pwm2 low speed duty cycle (pwm_auto_pwm[1][2])
> + * 1  3  : pwm2 off (pwm_auto_pwm[1][3], hard-wired to 0)
> +*/
> +
> +static ssize_t show_pwm_auto_point_pwm(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	return sprintf(buf, "%d\n",
> +		       PWM_FROM_REG(data->pwm_auto_pwm[ix][ap]));
> +}
> +
> +static ssize_t set_pwm_auto_point_pwm(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	if (ap = 1 || ap = 2) {

No, you want to set the sysfs files read-only for ap = 0 and ap = 3,
so this test is no more needed. It's better because then the user (or
user-space application) sees right away that these values can't be
changed.

> +		mutex_lock(&data->update_lock);
> +		data->pwm_auto_pwm[ix][ap] = PWM_TO_REG(val);
> +		vt1211_write8(data, VT1211_REG_PWM_AUTO_PWM(ix, ap),
> +			      data->pwm_auto_pwm[ix][ap]);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Miscellaneous sysfs interfaces (VRM, VID and name)
> + * --------------------------------------------------------------------- */
> +
> +static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);

No need to update! The vrm value is not read from the chip.

> +	return sprintf(buf, "%d\n", data->vrm);
> +}
> +
> +static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
> +	data->vrm = val;
> +	return count;
> +}
> +
> +static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);

Same here, the VID value is read at init time and not updated so this
call is not needed.

> +	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
> +}
> +
> +static ssize_t show_name(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Device attribute structs
> + * --------------------------------------------------------------------- */
> +
> +#define SENSOR_ATTR_IN(ix) \
> +	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_INPUT, ix), \
> +	SENSOR_ATTR_2(in##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MIN, ix), \
> +	SENSOR_ATTR_2(in##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MAX, ix), \
> +	SENSOR_ATTR_2(in##ix##_alarm, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_ALARM, ix)
> +
> +#define SENSOR_ATTR_TEMP(ix) \
> +	SENSOR_ATTR_2(temp##ix##_input, S_IRUGO, \
> +		show_temp, NULL, SHOW_TEMP_INPUT, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SHOW_SET_TEMP_MAX, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_max_hyst, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SHOW_SET_TEMP_MAX_HYST, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_alarm, S_IRUGO, \
> +		show_temp, NULL, SHOW_TEMP_ALARM, ix-1)
> +
> +#define SENSOR_ATTR_FAN(ix) \
> +	SENSOR_ATTR_2(fan##ix##_input, S_IRUGO, \
> +		show_fan, NULL, SHOW_FAN_INPUT, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SHOW_SET_FAN_MIN, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_div, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SHOW_SET_FAN_DIV, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_alarm, S_IRUGO, \
> +		show_fan, NULL, SHOW_FAN_ALARM, ix-1)
> +
> +#define SENSOR_ATTR_PWM(ix) \
> +	SENSOR_ATTR_2(pwm##ix, S_IRUGO, \
> +		show_pwm, NULL, SHOW_PWM, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_enable, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_ENABLE, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_frequency, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_FREQUENCY, ix-1), \

We don't have a standard sysfs name for this yet. I would suggest the
shorter pwmN_freq. Would you mind adding an entry in
Documentation/hwmon/sysfs-interface so that other drivers can follow it?

> +	SENSOR_ATTR_2(pwm##ix##_auto_channels_temp, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_AUTO_CHANNELS_TEMP, ix-1)
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT(ix, ap) \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_temp, S_IRUGO | S_IWUSR, \
> +		show_pwm_auto_point_temp, set_pwm_auto_point_temp, \
> +		ap-1, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_pwm, S_IRUGO | S_IWUSR, \
> +		show_pwm_auto_point_pwm, set_pwm_auto_point_pwm, \
> +		ap-1, ix-1)

This needs to be refined a bit to set some of these files read-only.

> +
> +static struct sensor_device_attribute_2 vt1211_sensor_attr_2[] = {
> +	SENSOR_ATTR_IN(0),
> +	SENSOR_ATTR_IN(1),
> +	SENSOR_ATTR_IN(2),
> +	SENSOR_ATTR_IN(3),
> +	SENSOR_ATTR_IN(4),
> +	SENSOR_ATTR_IN(5),
> +	SENSOR_ATTR_IN(6),
> +	SENSOR_ATTR_TEMP(1),
> +	SENSOR_ATTR_TEMP(2),
> +	SENSOR_ATTR_TEMP(3),
> +	SENSOR_ATTR_TEMP(4),
> +	SENSOR_ATTR_TEMP(5),
> +	SENSOR_ATTR_TEMP(6),
> +	SENSOR_ATTR_TEMP(7),
> +	SENSOR_ATTR_FAN(1),
> +	SENSOR_ATTR_FAN(2),
> +	SENSOR_ATTR_PWM(1),
> +	SENSOR_ATTR_PWM(2),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 4),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 4)
> +};

You are creating files even for functions which are not available! Not
OK. You must only enable one set of files for each UCH, either temp, of
voltage, but not both! This will make the code a bit more complex, I
concede, but this is the very fundamental idea behind the standard
interface: user-space must be able to guess the available features just
by scanning the available interface files.

Also, please always add a comma at the end of the last line of array
declarations. This makes appending lines later easier.

> +
> +static struct device_attribute vt1211_sensor_attr[] = {
> +	__ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm),
> +	__ATTR(cpu0_vid, S_IRUGO, show_vid, NULL),
> +	__ATTR(name, S_IRUGO, show_name, NULL)
> +};
> +
> +/* ---------------------------------------------------------------------
> + * Device registration and initialization
> + * --------------------------------------------------------------------- */
> +
> +static void __devinit vt1211_init_device(struct vt1211_data *data)
> +{
> +	/* Read VID */
> +	data->vid = vt1211_read8(data, VT1211_REG_VID) & 0x1f;
> +	data->vrm = vid_which_vrm();
> +
> +	/* Read (and initialize) UCH config */
> +	data->uch_config = vt1211_read8(data, VT1211_REG_UCH_CONFIG);
> +	if (uch_config > -1) {
> +		data->uch_config = (data->uch_config & 0x83) |
> +				   (uch_config & 0x7c);
> +		vt1211_write8(data, VT1211_REG_UCH_CONFIG, data->uch_config);
> +	}
> +
> +	/* The VT1211 implements 3 different modes for clearing interrupts:
> +	 * 1) Clear INT when temp falls below max limit.
> +	 * 2) Clear INT when status register is read. Regenerate INT as long
> +	 *    as temp stays above hysteresis limit.
> +	 * 3) Clear INT when status register is read. DON'T regenerate INT
> +	 *    until temp falls below hysteresis limit and exceeds hot limit
> +	 *    again.

It's a bit confusing that these values don't match the datasheet. The
three modes you describe are 2, 0 and 1 on the datasheet, respectively,
if I'm not mistaken.

> +	 *
> +	 * We make sure that we're using mode 2 which is not the default
> +	 * (at least not on an EPIA M10000) */
> +	vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0);
> +	vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0);
> +}

I don't much like drivers changing the interrupt modes. Interrupt lines
are physical and may be wired to any kind of system handling them, e.g.
shutting the system down or starting an emergency fan etc. Changing the
interrupt mode may cause great confusion in this case.

> +
> +static int __devinit vt1211_probe(struct platform_device *pdev)
> +{
> +	struct vt1211_data *data;
> +	struct resource *res;
> +	int i, err;
> +
> +	if (!(data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Out of memory\n");

dev_err()

> +		goto EXIT;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	data->addr = res->start;
> +	mutex_init(&data->lock);
> +	data->name = "vt1211";
> +	mutex_init(&data->update_lock);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->class_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +		goto EXIT_FREE;
> +	}

Class registration should be moved at the end - after creating the
sysfs files.

> +
> +	/* Initialize the VT1211 chip */
> +	vt1211_init_device(data);
> +
> +	/* Register sysfs interface files */
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sensor_attr_2); i++) {
> +		err = device_create_file(&pdev->dev,
> +					 &vt1211_sensor_attr_2[i].dev_attr);
> +		if (err) {
> +			goto EXIT_DEV_UNREGISTER;
> +		}
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sensor_attr); i++) {
> +		err = device_create_file(&pdev->dev, &vt1211_sensor_attr[i]);
> +		if (err) {
> +			goto EXIT_DEV_UNREGISTER;
> +		}
> +	}

You fail to delete all the files which were created if an error occurs.
Most other hardware monitoring drivers do as well, but we are currently
trying to get them fixed so it'd be nice if the vt1211 was OK right
away. Note that it's OK to delete a file which was never created, and
that makes the cleanup step much easier.

> +
> +	return 0;
> +
> +EXIT_DEV_UNREGISTER:
> +	dev_err(&pdev->dev, "Sysfs interface creation failed\n");
> +	hwmon_device_unregister(data->class_dev);
> +EXIT_FREE:

Missing platform_set_drvdata(pdev, NULL);

> +	kfree(data);
> +EXIT:
> +	return err;
> +}
> +
> +static int __devexit vt1211_remove(struct platform_device *pdev)
> +{
> +	struct vt1211_data *data = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	hwmon_device_unregister(data->class_dev);
> +	kfree(data);
> +
> +	return 0;
> +}

Here too you must delete all the files you created.

> +
> +static struct platform_driver vt1211_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name  = DRVNAME,
> +	},
> +	.probe  = vt1211_probe,
> +	.remove = __devexit_p(vt1211_remove),
> +};

Please align with tabs, not spaces.

> +
> +static int __init vt1211_device_add(unsigned short address)
> +{
> +	struct resource res = {
> +		.start	= address,
> +		.end	= address + 0x7f,
> +		.flags	= IORESOURCE_IO,
> +	};
> +	int err;
> +
> +	pdev = platform_device_alloc(DRVNAME, address);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto EXIT;
> +	}
> +
> +	res.name = pdev->name;
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device resource addition failed "
> +		       "(%d)\n", err);
> +		goto EXIT_DEV_PUT;
> +	}
> +
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> +		       err);
> +		goto EXIT_DEV_PUT;
> +	}
> +
> +	return 0;
> +
> +EXIT_DEV_PUT:
> +	platform_device_put(pdev);
> +EXIT:
> +	return err;
> +}
> +
> +static int __init vt1211_find(unsigned short *address)
> +{
> +	int err = -ENODEV;
> +	u16 val;
> +
> +	superio_enter();
> +
> +	val = superio_inb(SIO_VT1211_DEVID);
> +	if (val != SIO_VT1211_ID) {
> +		goto EXIT;
> +	}
> +
> +	superio_select(SIO_VT1211_LDN_HWMON);
> +
> +	val = ((superio_inb(SIO_VT1211_BADDR) << 8) |
> +	       (superio_inb(SIO_VT1211_BADDR + 1)));
> +	*address = val & SIO_VT1211_BADDR_MASK;

I see nothing in the datasheet justifying this masking.

> +	if (*address = 0) {
> +		printk(KERN_WARNING DRVNAME ": Base address not set, "
> +		       "skipping\n");
> +		goto EXIT;
> +	}

You should check the "Hardware Monitor Activate" register too (0x30).
If bit 0 isn't set, the device isn't activated so the driver won't work.

> +
> +	err = 0;
> +	printk(KERN_INFO DRVNAME ": Found VT1211 chip at %#x, revision %u\n",

Last time I checked, the %#x form wasn't properly supported by printk
and I had to revert it to 0x%x.

> +	       *address, superio_inb(SIO_VT1211_DEVREV));
> +
> +EXIT:
> +	superio_exit();
> +	return err;
> +}
> +
> +static int __init vt1211_init(void)
> +{
> +	int err;
> +	unsigned short address;
> +
> +	if (vt1211_find(&address)) {
> +		err = -ENODEV;
> +		goto EXIT;
> +	}

You could return the error from vt1211_find rather than hardcoding your
own. (Granted, it's the same value anyway.)

> +
> +	err = platform_driver_register(&vt1211_driver);
> +	if (err) {
> +		goto EXIT;
> +	}
> +
> +	/* Sets global pdev as a side effect */
> +	err = vt1211_device_add(address);
> +	if (err) {
> +		goto EXIT_DRV_UNREGISTER;
> +	}
> +
> +	return 0;
> +
> + EXIT_DRV_UNREGISTER:
> +	platform_driver_unregister(&vt1211_driver);
> + EXIT:
> +	return err;
> +}

No space before labels.

> +
> +static void __exit vt1211_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&vt1211_driver);
> +}
> +
> +MODULE_AUTHOR("Juerg Haefliger <juergh at gmail.com>, "
> +	      "Lars Ekman <emil71se at yahoo.com>, "
> +	      "Mark D. Studebaker <mdsxyz123 at yahoo.com>");

I think you can drop Mark from the list, this driver is pretty much a
rewrite and he didn't participate in it.

> +MODULE_DESCRIPTION("VT1211 sensors");
> +MODULE_LICENSE("GPL");
> +
> +module_init(vt1211_init);
> +module_exit(vt1211_exit);
> +
> +/* ---------------------------------------------------------------------
> + * End of file
> + * --------------------------------------------------------------------- */

Please drop this comment. Seriously, everybody sees that's the end of
the file, so what's the point?

> diff -uprN -X linux-2.6.17-rc4-mm1-vanilla/Documentation/dontdiff -x Documentation -x usr -x dwarf2-defs.h linux-2.6.17-rc4-mm1-vanilla/MAINTAINERS linux-2.6.17-rc4-mm1/MAINTAINERS
> --- linux-2.6.17-rc4-mm1-vanilla/MAINTAINERS	2006-05-17 21:11:54.000000000 +0000
> +++ linux-2.6.17-rc4-mm1/MAINTAINERS	2006-05-17 21:14:40.000000000 +0000
> @@ -3119,6 +3119,12 @@ W:	http://linuxtv.org
>  T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
>  S:	Maintained
>  
> +VT1211 HARDWARE MONITOR DRIVER
> +P:	Juerg Haefliger
> +M:	juergh at gmail.com
> +L:	lm-sensors at lm-sensors.org
> +S:	Maintained
> +
>  VT8231 HARDWARE MONITOR DRIVER
>  P:	Roger Lucas
>  M:	roger at planbit.co.uk

To more general comments now:

1* At first I didn't much like the switch/case approach you took.
There's not much point in putting all the code in the same function if
only one chunk is executed each time. It has a performance cost. It
also requires that you introduce arbitrary constants. Now I have to
admit it brings some order in the source file. I wonder if the benefit
is worth the drawbacks. But it's your driver anyway, I won't argue.

2* Your driver doesn't provide the old-style all-in-one alarms file. As
libsensors isn't aware of individual alarm files, this means alarms
won't be reported for now. I suggest that you add this file, it doesn't
cost much and guarantees backward compatibility for now.

3* I am worried about the automatic PWM mode. I understand that there's
only one set of temperature registers for both PWM outputs. However
both PWM outputs may be mapped to different temperature channels, and
these channels may measure the temperature in a different way. So the
single register set may lead to related, but different fan behaviors.
This will be very confusing for the user. Shouldn't we prevent the user
from using temperature channels of different types for PWM1 and PWM2?

OK, don't be frightened by the number of my comments, I am actually
quite happy with your code in general. I see you've been putting energy
in sticking to the coding style and the sysfs interface standard, and
you also took benefit of the latest technologies available (dynamic
sysfs callbacks, platform driver etc.) It's very nice.

Next steps:
* Process my complaints and submit a new driver.
* Test it again!
* User-space fixes and tests.
* 2.4 driver fixes (best effort).
* Documentation (I'll go read your doc patch now.)

Thanks! And sorry again for the delay.

-- 
Jean Delvare

