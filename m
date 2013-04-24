From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 24 Apr 2013 05:37:58 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130424053758.GC8710@lunn.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
In-Reply-To: <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
>=20
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> Tested-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  drivers/hwmon/Kconfig  |   10 +
>  drivers/hwmon/Makefile |    1 +
>  drivers/hwmon/g762.c   | 1058 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1069 insertions(+)
>  create mode 100644 drivers/hwmon/g762.c
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 89ac1cb..cb4879c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -423,6 +423,16 @@ config SENSORS_G760A
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called g760a.
> =20
> +config SENSORS_G762
> +	tristate "GMT G762 and G763"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Global Mixed-mode
> +	  Technology Inc G762 and G763 fan speed PWM controller chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called g762.
> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8d6d97e..4b49504 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+=3D f75375s.o
>  obj-$(CONFIG_SENSORS_FAM15H_POWER) +=3D fam15h_power.o
>  obj-$(CONFIG_SENSORS_FSCHMD)	+=3D fschmd.o
>  obj-$(CONFIG_SENSORS_G760A)	+=3D g760a.o
> +obj-$(CONFIG_SENSORS_G762)	+=3D g762.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+=3D gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+=3D gl520sm.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+=3D gpio-fan.o
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> new file mode 100644
> index 0000000..810b019
> --- /dev/null
> +++ b/drivers/hwmon/g762.c
> @@ -0,0 +1,1058 @@
> +/*
> + * g762 - Driver for the Global Mixed-mode Technology Inc. fan speed PWM
> + *        controller chips from G762 family, i.e. G762 and G763
> + *
> + * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
> + *
> + * This work is based on a basic version for 2.6.31 kernel developed
> + * by Olivier Mouchet for LaCie NAS. Updates have been performed to run
> + * on recent kernels. Additional features have been added. Ability to
> + * configure various characteristics via .dts file has been added.
> + * Detailed datasheet on which this development is based is available
> + * here:
> + *
> + *  http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf
> + *
> + * Headers from previous developments have been kept below:
> + *
> + * Copyright (c) 2009 LaCie
> + *
> + * Author: Olivier Mouchet <olivier.mouchet@gmail.com>
> + *
> + * based on g760a code written by Herbert Valerio Riedel <hvr@gnu.org>
> + * Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * g762: minimal datasheet available at:
> + *       http://www.gmt.com.tw/product/datasheet/EDS-762_3.pdf
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#define DRVNAME "g762"
> +
> +static const struct i2c_device_id g762_id[] =3D {
> +	{ "g762", 0 },
> +	{ "g763", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, g762_id);
> +
> +enum g762_regs {
> +	G762_REG_SET_CNT  =3D 0x00,
> +	G762_REG_ACT_CNT  =3D 0x01,
> +	G762_REG_FAN_STA  =3D 0x02,
> +	G762_REG_SET_OUT  =3D 0x03,
> +	G762_REG_FAN_CMD1 =3D 0x04,
> +	G762_REG_FAN_CMD2 =3D 0x05,
> +};
> +
> +/* Config register bits */
> +#define G762_REG_FAN_CMD1_DET_FAN_FAIL  0x80 /* enable fan_fail signal */
> +#define G762_REG_FAN_CMD1_DET_FAN_OOC   0x40 /* enable fan_out_of_contro=
l */
> +#define G762_REG_FAN_CMD1_OUT_MODE      0x20 /* out mode, pwm or dac */
> +#define G762_REG_FAN_CMD1_FAN_MODE      0x10 /* fan mode: close or open =
loop */
> +#define G762_REG_FAN_CMD1_CLK_DIV_ID1   0x08 /* clock divisor value */
> +#define G762_REG_FAN_CMD1_CLK_DIV_ID0   0x04
> +#define G762_REG_FAN_CMD1_PWM_POLARITY  0x02 /* pwm polarity */
> +#define G762_REG_FAN_CMD1_PULSE_PER_REV 0x01 /* pulse per fan revolution=
 */
> +
> +#define G762_REG_FAN_CMD2_GEAR_MODE_1   0x08 /* fan gear mode */
> +#define G762_REG_FAN_CMD2_GEAR_MODE_0   0x04
> +#define G762_REG_FAN_CMD2_FAN_STARTV_1  0x02 /* fan startup voltage */
> +#define G762_REG_FAN_CMD2_FAN_STARTV_0  0x01
> +
> +#define G762_REG_FAN_STA_FAIL           0x02 /* fan fail */
> +#define G762_REG_FAN_STA_OOC            0x01 /* fan out of control */
> +
> +/* config register values */
> +#define OUT_MODE_PWM            1
> +#define OUT_MODE_DAC            0
> +
> +#define FAN_MODE_CLOSED_LOOP    2
> +#define FAN_MODE_OPEN_LOOP      1
> +
> +/* register data is read (and cached) at most once per second */
> +#define G762_UPDATE_INTERVAL (HZ)
> +
> +/*
> + * extract pulse count per fan revolution value (2 or 4) from given
> + * FAN_CMD1 register value
> + */
> +#define PULSE_FROM_REG(reg) \
> +	((((reg) & G762_REG_FAN_CMD1_PULSE_PER_REV)+1) << 1)
> +
> +/*
> + * extract fan clock divisor (1, 2, 4 or 8) from given FAN_CMD1
> + * register value
> + */
> +#define CLKDIV_FROM_REG(reg) \
> +	(1 << (((reg) & (G762_REG_FAN_CMD1_CLK_DIV_ID0 |	\
> +			 G762_REG_FAN_CMD1_CLK_DIV_ID1)) >> 2))
> +
> +/*
> + * extract fan gear mode value (0, 1 or 2) from given FAN_CMD2
> + * register value
> + */
> +#define GEARMODE_FROM_REG(reg) \
> +	(1 << (((reg) & (G762_REG_FAN_CMD2_GEAR_MODE_0 |	\
> +			 G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
> +
> +struct g762_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +
> +	/* update mutex */
> +	struct mutex update_lock;
> +
> +	/* board specific parameters. */
> +	u32 clk; /* default 32kHz */
> +
> +	/* g762 register cache */
> +	bool valid;
> +	unsigned long last_updated; /* in jiffies */
> +
> +	u8 set_cnt;  /* RPM cmd in close loop control */
> +	u8 act_cnt;  /* formula: cnt =3D (CLK * 30)/(rpm * P) */
> +	u8 fan_sta;  /* bit 0: set when actual fan speed is more than
> +		      *        25% outside requested fan speed
> +		      * bit 1: set when no transition occurs on fan
> +		      *        pin for 0.7s
> +		      */
> +	u8 set_out;  /* output voltage/PWM duty in open loop control */
> +	u8 fan_cmd1; /*   0: FG_PLS_ID0 FG pulses count per revolution
> +		      *      0: 2 counts per revolution
> +		      *      1: 4 counts per revolution
> +		      *   1: PWM_POLARITY 1: negative_duty
> +		      *                   0: positive_duty
> +		      * 2,3: [FG_CLOCK_ID0, FG_CLK_ID1]
> +		      *         00: Divide fan clock by 1
> +		      *         01: Divide fan clock by 2
> +		      *         10: Divide fan clock by 4
> +		      *         11: Divide fan clock by 8
> +		      *   4: FAN_MODE 1:close-loop, 0:open-loop
> +		      *   5: OUT_MODE 1:PWM, 0:DAC
> +		      *   6: DET_FAN_OOC enable "fan ooc" status
> +		      *   7: DET_FAN_FAIL enable "fan fail" status
> +		      */
> +	u8 fan_cmd2; /* 0,1: FAN_STARTV 0,1,2,3 -> 0,32,64,96 dac_code
> +		      * 2,3: FG_GEAR_MODE
> +		      *         00: div =3D 1
> +		      *         01: div =3D 2
> +		      *         10: div =3D 4
> +		      *   4: Mask ALERT# (g763 only)
> +		      */

You could consider using regmap for holding this cache.

http://elceurope2012.sched.org/event/100619b669ce5767341624253aa03659?ifram=
e=3Dno&w=900&sidebar=3Dyes&bg=3Dno#.UXdspHLQ5jM

http://elinux.org/ELCE_Europe_2012_Presentations

Nice documentation by the way.

> +/*
> + * Helpers to import hardware characteristics from .dts file and overload
> + * default config values.
> + */
> +
> +#ifdef CONFIG_OF

Can the driver be used without device tree? Would it be simpler to
 just add depends OF in the Kconfig entry?

 Andrew

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
