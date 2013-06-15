From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Jun 2013 18:25:00 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <20130615182500.GA32205@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87li6bmjwi.fsf@natisbad.org>
In-Reply-To: <87li6bmjwi.fsf-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Olivier Mouchet <olivier.mouchet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Simon Guinot <simon.guinot-jKBdWWKqtFpg9hUCZPvPmw@public.gmane.org>

On Sat, Jun 15, 2013 at 06:13:49PM +0200, Arnaud Ebalard wrote:
> 
> GMT G762/763 fan speed PWM controller is connected directly to a fan
> and performs closed-loop or open-loop control of the fan speed. Two
> modes - PWM or DC - are supported by the chip. Introduced driver
> provides various knobs to control the operations of the chip (via
> sysfs interface). Specific characteristics of the system can be passed
> either using board init code or via DT. Documentation for both the
> driver and DT bindings are also provided.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> 
> Guenter, do not hesitate to tell me if changes associated with the
> switch from a simple property DT for clock frequency to a fixed
> clock require some additional work. History of changes is below.
> 
> Changes since v4:
>     Fixed issue reported by Simon (open-loop not working when set_cnt is 255)
>     replaced ref_clk property by a required reference to a clock in .dts
>     now use a fixed clock in DT instead of a simple property
>     Replace fan_pulses property in DT in favour of a sysfs attribute
>     s/pwm_freq/clk_freq/g and fixed associated comments
>     removed whole G762_VAL_TEST_BIT hack
>     merged all three patches into one
>     removed useless settings of data->valid to false
>     do not hide original return code in g762_one_prop_commit()
>     Removed unused defines
>     fixed various comments
>     fixed comment for get/set_pwm_enable() (still not supporting 0 for pwm1_enable)
>     fixed comment for get/set_pwm()
>     fixed reversed polarity setter logic
>     simplified do_set_pwm()
> 
> Changes since v3:
>     set is against current head of Linus tree
>     removed dev_err() calls when i2c_smbus_read/write_byte_data() fails
>     pwm1 sets SET_OUT reg, fan1_target sets SET_CNT reg, both unconditionally
>     removed all DT and platform_data knobs available via sysfs
>     updated documentation files to reflect two previous changes
> 
> Changes since v2:
>     set ref_clk value to 32768 if not overloaded
>     fixed multi-line comment format in g762.h
>     removed static const G762_DEFAULT_PDATA in g762.h for a function
>     CodingStyle: add spaces between operatoirs when missing
>     check return value of i2c_smbus_{read,write}_byte_data()
>     remove { } is not needed in single-statement conditionals
>     introduced G762_ATTR_VAL() to allow sparse init of platform_data struc
>     changed missed reference to linear mode for DC mode
> 
> Changes since v1
>     Changed author
>     removed bad tabs
>     Provide datasheet link w/o fud in g762 documentation
>     removed documentation for removed fan_gear_mode sysfs entry
>     removed tested-by from patch
>     removed FSF address in header file
>     removed useless include of <linux/slab.h>
>     removed useless parenthesis against HZ in define
>     use spaces around binary operators
>     use i2c_smbus_{read,write}_byte_data() instead of g762_{read,write}_value()
>     use return value of i2c_smbus_write_byte_data()
>     use true for initializing boolean
>     removed useless blank lines
>     do not enforce single return point rule where less readable
>     use dev_err() and dev_dbg() instead of dev_info() when it makes sense
>     remove leading '&' for function passed as pointers
>     allow passing parameter via platform_data struct for non-DT enabled boards
>     set data->valid to false when config is modified
>     s/linear/DC/ for mode (g762 datasheet uses linear)
>     more tests on rpm_from_cnt() and cnt_from_rpm() formula
>     dont overload
> 
> Changes since v0
>     removed forward declaration
>     use bool for valid field instead of bit field.
>     protect macro args
>     fixed typo in subject line
>     Added mention for G763 support in Kconfig
>     fixed typo in driver name in Kconfig
>     do not use DRVNAME in i2c_device_id g762_id[] 

Trailing whitespace above

>     Following discussions, kept DEVICE_ATTR (i.e. no switch to SENSOR_DEVICE_ATTR)
>     removed useless casts when flipping bit values
>     Sanity check user input value (e.g. to prevent 256 to silenty become 0)
>     Added extra lines for multi line comments when needed
>     removed various testing knobs
>     make removed knobs available via DT
>     passed checkpatch script on the patch
>     removed useless lock protection againt clk setting
>     moved all setter at the beginning of the file
>     removed bad (u16) casts in g762_write_value() calls
> 
> 
> 
>  Documentation/devicetree/bindings/hwmon/g762.txt |   47 +
>  Documentation/hwmon/g762                         |   65 ++
>  drivers/hwmon/Kconfig                            |   10 +
>  drivers/hwmon/Makefile                           |    1 +
>  drivers/hwmon/g762.c                             | 1134 ++++++++++++++++++++++
>  include/linux/platform_data/g762.h               |   37 +
>  6 files changed, 1294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
>  create mode 100644 Documentation/hwmon/g762
>  create mode 100644 drivers/hwmon/g762.c
>  create mode 100644 include/linux/platform_data/g762.h
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
> new file mode 100644
> index 0000000..25cc6d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/g762.txt
> @@ -0,0 +1,47 @@
> +GMT G762/G763 PWM Fan controller
> +
> +Required node properties:
> +
> + - "compatible": must be either "gmt,g762" or "gmt,g763"
> + - "reg": I2C bus address of the device
> + - "clocks": a fixed clock providing input clock frequency
> +	     on CLK pin of the chip.
> +
> +Optional properties:
> +
> + - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
> +	       The higher the more.
> +
> + - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
> +	       and 1 (negative duty).
> +
> + - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
> +
> +If an optional property is not set in .dts file, then current value is kept
> +unmodified (e.g. u-boot installed value).
> +
> +Additional information on operational parameters for the device is available
> +in Documentation/hwmon/g762. A detailed datasheet for the device is available
> +at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> +
> +Example g762 node:
> +
> +   clocks {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	g762_clk: fixedclk {
> +		 compatible = "fixed-clock";
> +		 #clock-cells = <0>;
> +		 clock-frequency = <8192>;
> +	}
> +   }
> +
> +   g762: g762@3e {
> +	compatible = "gmt,g762";
> +	reg = <0x3e>;
> +	clocks = <&g762_clk>
> +	fan_gear_mode = <0>; /* chip default */
> +	fan_startv = <1>;    /* chip default */
> +	pwm_polarity = <0>;  /* chip default */
> +   };
> diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
> new file mode 100644
> index 0000000..923db9c
> --- /dev/null
> +++ b/Documentation/hwmon/g762
> @@ -0,0 +1,65 @@
> +Kernel driver g762
> +=========
> +
> +The GMT G762 Fan Speed PWM Controller is connected directly to a fan
> +and performs closed-loop or open-loop control of the fan speed. Two
> +modes - PWM or DC - are supported by the device.
> +
> +For additional information, a detailed datasheet is available at
> +http://natisbad.org/NAS/ref/GMT_EDS-762_763-080710-0.2.pdf. sysfs
> +bindings are described in Documentation/hwmon/sysfs-interface.
> +
> +The following entries are available to the user in a subdirectory of
> +/sys/bus/i2c/drivers/g762/ to control the operation of the device.
> +This can be done manually using the following entries but is usually
> +done via a userland daemon like fancontrol.
> +
> +Note that those entries do not provide ways to setup the specific
> +hardware characteristics of the system (reference clock, pulses per
> +fan revolution, ...); Those can be modified via devicetree bindings
> +documented in Documentation/devicetree/bindings/hwmon/g762.txt or
> +using a specific platform_data structure in board initialization
> +file (see include/linux/platform_data/g762.h).
> +
> +  fan1_target: set desired fan speed. This only makes sense in closed-loop
> +            fan speed control (i.e. when pwm1_enable is set to 2).
> +
> +  fan1_input: provide current fan rotation value in RPM as reported by
> +            the fan to the device.
> +
> +  fan1_div: fan clock divisor. Supported value are 1, 2, 4 and 8.
> +
> +  fan1_pulses: number of pulses per fan revolution. Supported values
> +            are 2 and 4.
> +
> +  fan1_fault: reports fan failure, i.e. no transition on fan gear pin for
> +            about 0.7s (if the fan is not voluntarily set off).
> +
> +  fan1_alarm: in closed-loop control mode, if fan RPM value is 25% out
> +            of the programmed value for over 6 seconds 'fan1_alarm' is
> +            set to 1.
> +
> +  pwm1_enable: set current fan speed control mode i.e. 1 for manual fan
> +            speed control (open-loop) via pwm1 described below, 2 for
> +            automatic fan speed control (closed-loop) via fan1_target
> +            above.
> +
> +  pwm1_mode: set or get fan driving mode: 1 for PWM mode, 0 for DC mode.
> +
> +  pwm1: get or set PWM fan control value in open-loop mode. This is an
> +            integer value between 0 and 255. 0 stops the fan, 255 makes
> +            it run at full speed.
> +
> +Both in PWM mode ('pwm1_mode' set to 1) and DC mode ('pwm1_mode' set to 0),
> +when current fan speed control mode is open-loop ('pwm1_enable' set to 1),
> +the fan speed is programmed by setting a value between 0 and 255 via 'pwm1'
> +entry (0 stops the fan, 255 makes it run at full speed). In closed-loop mode
> +('pwm1_enable' set to 2), the expected rotation speed in RPM can be passed to
> +the chip via 'fan1_target'. In closed-loop mode, the target speed is compared
> +with current speed (available via 'fan1_input') by the device and a feedback
> +is performed to match that target value. The fan speed value is computed
> +based on the parameters associated with the physical characteristics of the
> +system: a reference clock source frequency, a number of pulses per fan
> +revolution, etc.
> +
> +Note that the driver will update its values at most once per second.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 0428e8a..142bdf8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -456,6 +456,16 @@ config SENSORS_G760A
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called g760a.
>  
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
> index d17d3e6..4f0fb52 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
>  obj-$(CONFIG_SENSORS_FAM15H_POWER) += fam15h_power.o
>  obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
>  obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
> +obj-$(CONFIG_SENSORS_G762)	+= g762.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> new file mode 100644
> index 0000000..e9da8e7
> --- /dev/null
> +++ b/drivers/hwmon/g762.c
> @@ -0,0 +1,1134 @@
> +/*
> + * g762 - Driver for the Global Mixed-mode Technology Inc. fan speed
> + *        PWM controller chips from G762 family, i.e. G762 and G763
> + *
> + * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
> + *
> + * This work is based on a basic version for 2.6.31 kernel developed
> + * by Olivier Mouchet for LaCie. Updates and correction have been
> + * performed to run on recent kernels. Additional features, like the
> + * ability to configure various characteristics via .dts file or
> + * board init file have been added. Detailed datasheet on which this
> + * development is based is available here:
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
> + * Foundation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_data/g762.h>
> +
> +#define DRVNAME "g762"
> +
> +static const struct i2c_device_id g762_id[] = {
> +	{ "g762", 0 },
> +	{ "g763", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, g762_id);
> +
> +enum g762_regs {
> +	G762_REG_SET_CNT  = 0x00,
> +	G762_REG_ACT_CNT  = 0x01,
> +	G762_REG_FAN_STA  = 0x02,
> +	G762_REG_SET_OUT  = 0x03,
> +	G762_REG_FAN_CMD1 = 0x04,
> +	G762_REG_FAN_CMD2 = 0x05,
> +};
> +
> +/* Config register bits */
> +#define G762_REG_FAN_CMD1_DET_FAN_FAIL  0x80 /* enable fan_fail signal */
> +#define G762_REG_FAN_CMD1_DET_FAN_OOC   0x40 /* enable fan_out_of_control */
> +#define G762_REG_FAN_CMD1_OUT_MODE      0x20 /* out mode: PWM or DC */
> +#define G762_REG_FAN_CMD1_FAN_MODE      0x10 /* fan mode: closed/open-loop */
> +#define G762_REG_FAN_CMD1_CLK_DIV_ID1   0x08 /* clock divisor value */
> +#define G762_REG_FAN_CMD1_CLK_DIV_ID0   0x04
> +#define G762_REG_FAN_CMD1_PWM_POLARITY  0x02 /* PWM polarity */
> +#define G762_REG_FAN_CMD1_PULSE_PER_REV 0x01 /* pulse per fan revolution */
> +
> +#define G762_REG_FAN_CMD2_GEAR_MODE_1   0x08 /* fan gear mode */
> +#define G762_REG_FAN_CMD2_GEAR_MODE_0   0x04
> +#define G762_REG_FAN_CMD2_FAN_STARTV_1  0x02 /* fan startup voltage */
> +#define G762_REG_FAN_CMD2_FAN_STARTV_0  0x01
> +
> +#define G762_REG_FAN_STA_FAIL           0x02 /* fan fail */
> +#define G762_REG_FAN_STA_OOC            0x01 /* fan out of control */
> +
> +/* Config register values */
> +#define G762_OUT_MODE_PWM            1
> +#define G762_OUT_MODE_DC             0
> +
> +#define G762_FAN_MODE_CLOSED_LOOP    2
> +#define G762_FAN_MODE_OPEN_LOOP      1
> +
> +#define G762_PWM_POLARITY_NEGATIVE   1
> +#define G762_PWM_POLARITY_POSITIVE   0
> +
> +/* Register data is read (and cached) at most once per second. */
> +#define G762_UPDATE_INTERVAL    HZ
> +
> +/*
> + * Extract pulse count per fan revolution value (2 or 4) from given
> + * FAN_CMD1 register value.
> + */
> +#define G762_PULSE_FROM_REG(reg) \
> +	((((reg) & G762_REG_FAN_CMD1_PULSE_PER_REV) + 1) << 1)
> +
> +/*
> + * Extract fan clock divisor (1, 2, 4 or 8) from given FAN_CMD1
> + * register value.
> + */
> +#define G762_CLKDIV_FROM_REG(reg) \
> +	(1 << (((reg) & (G762_REG_FAN_CMD1_CLK_DIV_ID0 |	\
> +			 G762_REG_FAN_CMD1_CLK_DIV_ID1)) >> 2))
> +
> +/*
> + * Extract fan gear mode multiplier value (0, 2 or 4) from given
> + * FAN_CMD2 register value.
> + */
> +#define G762_GEARMULT_FROM_REG(reg) \
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
> +	u32 clk;
> +
> +	/* g762 register cache */
> +	bool valid;
> +	unsigned long last_updated; /* in jiffies */
> +
> +	u8 set_cnt;  /* controls fan rotation speed in closed-loop mode */
> +	u8 act_cnt;  /* provides access to current fan RPM value */
> +	u8 fan_sta;  /* bit 0: set when actual fan speed is more than
> +		      *        25% outside requested fan speed
> +		      * bit 1: set when no transition occurs on fan
> +		      *        pin for 0.7s
> +		      */
> +	u8 set_out;  /* controls fan rotation speed in open-loop mode */
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
> +		      *   4: FAN_MODE 1:closed-loop, 0:open-loop
> +		      *   5: OUT_MODE 1:PWM, 0:DC
> +		      *   6: DET_FAN_OOC enable "fan ooc" status
> +		      *   7: DET_FAN_FAIL enable "fan fail" status
> +		      */
> +	u8 fan_cmd2; /* 0,1: FAN_STARTV 0,1,2,3 -> 0,32,64,96 dac_code
> +		      * 2,3: FG_GEAR_MODE
> +		      *         00: multiplier = 1
> +		      *         01: multiplier = 2
> +		      *         10: multiplier = 4
> +		      *   4: Mask ALERT# (g763 only)
> +		      */
> +};
> +
> +/*
> + * Convert count value from fan controller register (FAN_SET_CNT) into fan
> + * speed RPM value. Note that the datasheet documents a basic formula;
> + * influence of additional parameters (fan clock divisor, fan gear mode)
> + * have been infered from examples in the datasheet and tests.
> + */
> +static inline unsigned int rpm_from_cnt(u8 cnt, u32 clk, u16 p,
> +					u8 clk_div, u8 gear_mult)
> +{
> +	if (cnt = 0xff)  /* cnt to 255 stops the fan */

				setting cnt ?

> +		return 0;
> +
> +	return (clk * 30 * gear_mult) / ((cnt ? cnt : 1) * p * clk_div);
> +}
> +
> +/*
> + * Convert fan RPM value from sysfs into count value for fan controller
> + * register (FAN_SET_CNT).
> + */
> +static inline unsigned char cnt_from_rpm(u32 rpm, u32 clk, u16 p,
> +					 u8 clk_div, u8 gear_mult)
> +{
> +	if (!rpm)         /* to stop the fan, set cnt to 255 */
> +		return 0xff;
> +
> +	return clamp_val(((clk * 30 * gear_mult) / (rpm * p * clk_div)),
> +			 0, 255);
> +}
> +
> +/* helper to grab and cache data, at most one time per second */
> +static struct g762_data *g762_update_client(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = i2c_get_clientdata(client);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	if (time_before(jiffies, data->last_updated + G762_UPDATE_INTERVAL) &&
> +	    likely(data->valid))
> +		goto out;
> +
> +	ret = i2c_smbus_read_byte_data(client, G762_REG_SET_CNT);
> +	if (ret < 0)
> +		goto out;
> +	data->set_cnt = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, G762_REG_ACT_CNT);
> +	if (ret < 0)
> +		goto out;
> +	data->act_cnt = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, G762_REG_FAN_STA);
> +	if (ret < 0)
> +		goto out;
> +	data->fan_sta = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, G762_REG_SET_OUT);
> +	if (ret < 0)
> +		goto out;
> +	data->set_out = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, G762_REG_FAN_CMD1);
> +	if (ret < 0)
> +		goto out;
> +	data->fan_cmd1 = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, G762_REG_FAN_CMD2);
> +	if (ret < 0)
> +		goto out;
> +	data->fan_cmd2 = ret;
> +
> +	data->last_updated = jiffies;
> +	data->valid = true;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	if (ret < 0) /* upon error, encode it in return value */
> +		data = ERR_PTR(ret);
> +
> +	return data;
> +}
> +
> +/* helpers for writing hardware parameters */
> +
> +/*
> + * Set input clock frequency received on CLK pin of the chip. Accepted values
> + * are between 0 and 0xffffff. If zero is given, then default frequency
> + * (32,768Hz) is used. Note that clock frequency is a characteristic of the
> + * system but an internal parameter, i.e. value is not passed to the device.
> + */
> +static int do_set_clk_freq(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = i2c_get_clientdata(client);
> +
> +	if (val > 0xffffff)
> +		return -EINVAL;
> +	if (!val)
> +		val = 32768;
> +
> +	data->clk = val;
> +
> +	return 0;
> +}
> +
> +/* Set pwm mode. Accepts either 0 (PWM mode) or 1 (DC mode) */
> +static int do_set_pwm_mode(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case G762_OUT_MODE_PWM:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_OUT_MODE;
> +		break;
> +	case G762_OUT_MODE_DC:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_OUT_MODE;
> +		break;
> +	default:
> +		goto out;

Given that this is the only place where you use the pre-initialized ret, it
would be better to set it here. Otherwise the initialization is just unnecessary
code.

> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan clock divisor. Accepts either 1, 2, 4 or 8. */
> +static int do_set_fan_div(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 1:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	case 2:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	case 4:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	case 8:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	default:
> +		goto out;

Same comment as above.

> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan gear mode. Accepts either 0, 1 or 2. */
> +static int do_set_fan_gear_mode(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 0:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_1;
> +		break;
> +	case 1:
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_GEAR_MODE_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_1;
> +		break;
> +	case 2:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_0;
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_GEAR_MODE_1;
> +		break;
> +	default:
> +		goto out;

Same comment as above.

> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD2,
> +					data->fan_cmd2);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set number of fan pulses per revolution. Accepts either 2 or 4. */
> +static int do_set_fan_pulses(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 2:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_PULSE_PER_REV;
> +		break;
> +	case 4:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_PULSE_PER_REV;
> +		break;
> +	default:
> +		goto out;

Same comment as above.

> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan mode. Accepts either 1 (open-loop) or 2 (closed-loop). */
> +static int do_set_pwm_enable(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case G762_FAN_MODE_OPEN_LOOP:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_FAN_MODE;
> +		/*
> +		 * BUG FIX: if SET_CNT register value is 255 then, for some
> +		 * unknown reason, fan will not rotate as expected, no matter
> +		 * the value of SET_OUT (to be specific, this seems to happen
> +		 * only in PWM mode). To workaround this bug, we give SET_CNT
> +		 * value of 254 if it is 255 when switching to open-loop.
> +		 */
> +		if (data->set_cnt = 0xff)
> +			i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
> +						  254);
> +		break;
> +	case G762_FAN_MODE_CLOSED_LOOP:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_FAN_MODE;
> +		break;

The extra space here doesn't improve visibility anymore, so you might as well
drop it.

> +	default:
> +		goto out;

and again.

> +	}
> +
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set PWM polarity. Accepts either 0 (positive duty) or 1 (negative duty) */
> +static int do_set_pwm_polarity(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case G762_PWM_POLARITY_POSITIVE:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_PWM_POLARITY;
> +		break;
> +	case G762_PWM_POLARITY_NEGATIVE:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_PWM_POLARITY;
> +		break;
> +	default:
> +		goto out;

Same comment as above.

> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Set pwm value. Accepts values between 0 (stops the fan) and
> + * 255 (full speed). This only makes sense in open-loop mode.
> + */
> +static int do_set_pwm(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (val > 255)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_SET_OUT, val);
> +	data->valid = false;
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan RPM value. This only makes sense in closed-loop mode. */

Not entirely true. One could set the RPM value first, then configure close-loop
mode.

> +static int do_set_fan_target(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	data->set_cnt = cnt_from_rpm(val, data->clk,
> +				     G762_PULSE_FROM_REG(data->fan_cmd1),
> +				     G762_CLKDIV_FROM_REG(data->fan_cmd1),
> +				     G762_GEARMULT_FROM_REG(data->fan_cmd2));
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
> +					data->set_cnt);
> +	data->valid = false;
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Enable/disable fan failure detection. Accepted values are 1 and 0. */
> +static int do_fan_failure_detection_toggle(struct device *dev,
> +					   unsigned long enable)

Wondering ... enable is really a boolean. Any reason for using unsigned long ?

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (enable) {
> +	case 0:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_DET_FAN_FAIL;
> +		break;
> +	case 1:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_DET_FAN_FAIL;
> +		break;
> +	default:
> +		goto out;

Same comment as earlier.

> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Enable/disable fan out of control detection. Accepted values are 1 and 0 */
> +static int do_fan_ooc_detection_toggle(struct device *dev, unsigned int enable)
> +{

Now here the parameter is unsigned int. Not very consistent.
If you use boolean, the switch error path goes away and the code is much simpler.

Anyway, since those functions are never really called with enable=0, you could
simplify the code further by just enabling the function.

You could actually merge several of the initialization functions into one and
call it g726_fan_init() or similar. Updating the same i2c register several times
just to update one bit seems a bit wasteful. With the slow speed of i2c, this
actually will impact boot time. Granted, not too much, but if everyone did it
your way ... Just something to consider, I'll accept your code anyway, but
it does seem to be more complicated than it has to be.

> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (enable) {
> +	case 0:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_DET_FAN_OOC;
> +		break;
> +	case 1:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_DET_FAN_OOC;
> +		break;
> +	default:
> +		goto out;
> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
> +					data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan startup voltage. Accepted values are either 0, 1, 2 or 3. */
> +static int do_set_fan_startv(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 0:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	case 1:
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	case 2:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	case 3:
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	default:
> +		goto out;
> +	}
> +	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD2,
> +					data->fan_cmd2);
> +	data->valid = false;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Helper to import hardware characteristics from .dts file and push
> + * those to the chip.
> + */
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id g762_dt_match[] = {
> +	{ .compatible = "gmt,g762" },
> +	{ .compatible = "gmt,g763" },
> +	{ },
> +};
> +
> +static int g762_of_prop_import_one(struct i2c_client *client,
> +				   const char *pname,
> +				   int (*psetter)(struct device *dev,
> +						  unsigned long val))
> +{
> +	const __be32 *prop;
> +	int len, ret = 0;
> +	u32 pval;
> +
> +	prop = of_get_property(client->dev.of_node, pname, &len);
> +	if (prop && len = sizeof(u32)) {
> +		pval = be32_to_cpu(prop[0]);
> +		dev_dbg(&client->dev, "found %s (%d)\n", pname, pval);
> +	} else {
> +		goto out;
> +	}

Please consider this instead:

	if (!prop || len != sizeof(u32))
		return 0;

	pval = be32_to_cpu(prop[0]);
	dev_dbg(&client->dev, "found %s (%d)\n", pname, pval);

and drop the out label. Then you don't have to initialize ret either.

In general, a goto to a return statement (if no specific error handling
is needed) should be avoided. It just complicates the code.

That applies to everywhere else in the code as well.

> +
> +	ret = (*psetter)(&client->dev, pval);
> +	if (ret)
> +		dev_err(&client->dev, "unable to set %s (%d)\n", pname, pval);
> +
> +out:
> +	return ret;
> +}
> +
> +static int g762_of_prop_import(struct i2c_client *client)
> +{
> +	unsigned long clk_freq;
> +	struct clk *clk;
> +	int ret = 0;
> +
> +	if (!client->dev.of_node)
> +		return ret;

Just return 0 here. Then you don't need to initialize ret (which is overwritten
most of the time anyway).

> +
> +	/* First, grab clock (a required property), enable it, get
> +	 * (fixed) clock frequency and store it */

Please follow multi-line comment style.

> +	clk = of_clk_get(client->dev.of_node, 0);
> +	if (IS_ERR(clk)) {
> +		dev_err(&client->dev, "failed to get clock\n");
> +		ret = PTR_ERR(clk);
> +		goto out;

Here is an example where the goto is even inconsistent with the direct retutn
above.
		return PTR_ERR(clk);
is much simpler.

> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable clock\n");
> +		goto out;

		return ret;

Same below.

> +	}
> +
> +	clk_freq = clk_get_rate(clk);
> +	ret = do_set_clk_freq(&client->dev, clk_freq);
> +	if (ret) {
> +		dev_err(&client->dev, "invalid clock freq %lu\n", clk_freq);
> +		goto out;
> +	}
> +
> +	/* Now import and commit optional properties */
> +	ret = g762_of_prop_import_one(client, "fan_gear_mode",
> +				      do_set_fan_gear_mode);
> +	if (ret)
> +		goto out;
> +
> +	ret = g762_of_prop_import_one(client, "pwm_polarity",
> +				      do_set_pwm_polarity);
> +	if (ret)
> +		goto out;
> +
> +	ret = g762_of_prop_import_one(client, "fan_startv",
> +				      do_set_fan_startv);
> +
> + out:
> +	return ret;
> +}
> +
> +#else
> +static int g762_of_prop_import(struct i2c_client *client,
> +			       struct g762_platform_data *pdata) { return 0 }

Please split this into multiple lines.

> +#endif
> +
> +/*
> + * Helper to import hardware characteristics from .dts file and push
> + * those to the chip.
> + */
> +
> +static int g762_pdata_prop_import(struct i2c_client *client)
> +{
> +	struct g762_platform_data *pdata = client->dev.platform_data;
> +	int ret;
> +
> +	if (!pdata)
> +		return 0;
> +
> +	ret = do_set_fan_gear_mode(&client->dev, pdata->fan_gear_mode);
> +	if (ret)
> +		goto out;

		return ret;

> +
> +	ret = do_set_pwm_polarity(&client->dev, pdata->pwm_polarity);
> +	if (ret)
> +		goto out;
> +
> +	ret = do_set_fan_startv(&client->dev, pdata->fan_startv);
> +	if (ret)
> +		goto out;
> +
> +	ret = do_set_fan_startv(&client->dev, pdata->fan_startv);
> +
> + out:
> +	return ret;
> +}
> +
> +/*
> + * sysfs attributes
> + */
> +
> +/*
> + * Read function for fan1_input sysfs file. Return current fan RPM value, or
> + * 0 if fan is out of control.
> + */
> +static ssize_t get_fan_rpm(struct device *dev, struct device_attribute *da,
> +			   char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +	unsigned int rpm = 0;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	/* reverse logic: fan out of control reporting is enabled low */
> +	if (data->fan_sta & G762_REG_FAN_STA_OOC) {
> +		rpm = rpm_from_cnt(data->act_cnt, data->clk,
> +				   G762_PULSE_FROM_REG(data->fan_cmd1),
> +				   G762_CLKDIV_FROM_REG(data->fan_cmd1),
> +				   G762_GEARMULT_FROM_REG(data->fan_cmd2));
> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return sprintf(buf, "%u\n", rpm);
> +}
> +
> +/*
> + * Read and write functions for pwm1_mode sysfs file. Get and set fan speed
> + * control mode i.e. PWM (1) or DC (0).
> + */
> +static ssize_t get_pwm_mode(struct device *dev, struct device_attribute *da,
> +			    char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n",
> +		       !!(data->fan_cmd1 & G762_REG_FAN_CMD1_OUT_MODE));
> +}
> +
> +static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *da,
> +			    const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	ret = do_set_pwm_mode(dev, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/*
> + * Read and write functions for fan1_div sysfs file. Get and set fan
> + * controller prescaler value
> + */
> +static ssize_t get_fan_div(struct device *dev,
> +			   struct device_attribute *da, char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n", G762_CLKDIV_FROM_REG(data->fan_cmd1));
> +}
> +
> +static ssize_t set_fan_div(struct device *dev,
> +			   struct device_attribute *da,
> +			   const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	ret = do_set_fan_div(dev, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/*
> + * Read and write functions for fan1_pulses sysfs file. Get and set number
> + * of tachometer pulses per fan revolution.
> + */
> +static ssize_t get_fan_pulses(struct device *dev,
> +			      struct device_attribute *da, char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n", G762_PULSE_FROM_REG(data->fan_cmd1));
> +}
> +
> +static ssize_t set_fan_pulses(struct device *dev,
> +			      struct device_attribute *da,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	ret = do_set_fan_pulses(dev, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/*
> + * Read and write functions for pwm1_enable. Get and set fan speed control mode
> + * (i.e. closed or open-loop).
> + *
> + * Following documentation about hwmon's sysfs interface, a pwm1_enable node
> + * should accept followings:
> + *
> + *  0 : no fan speed control (i.e. fan at full speed)
> + *  1 : manual fan speed control enabled (use pwm[1-*]) (open-loop)
> + *  2+: automatic fan speed control enabled (use fan[1-*]_target) (closed-loop)
> + *
> + * but we do not accept 0 as this mode is not natively supported by the chip
> + * and it is not emulated by g762 driver. -EINVAL is returned in this case.
> + */
> +static ssize_t get_pwm_enable(struct device *dev,
> +			      struct device_attribute *da, char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n",
> +		       (!!(data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE)) + 1);
> +}
> +
> +static ssize_t set_pwm_enable(struct device *dev,
> +			      struct device_attribute *da,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	ret = do_set_pwm_enable(dev, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/*
> + * Read and write functions for pwm1 sysfs file. Get and set pwm value
> + * (which affects fan speed) in open-loop mode. 0 stops the fan and 255
> + * makes it run at full speed.
> + */
> +static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
> +		       char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n", data->set_out);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
> +		       const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	ret = do_set_pwm(dev, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/*
> + * Read and write function for fan1_target sysfs file. Get/set the fan speed in
> + * closed-loop mode. Speed is given as a RPM value; then the chip will regulate
> + * the fan speed using pulses from fan tachometer.
> + *
> + * Refer to rpm_from_cnt() implementation above to get info about count number
> + * calculation.
> + *
> + * Also note that due to rounding errors it is possible that you don't read
> + * back exactly the value you have set.
> + */
> +static ssize_t get_fan_target(struct device *dev, struct device_attribute *da,
> +			      char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +	unsigned int rpm;
> +	ssize_t ret;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	mutex_lock(&data->update_lock);
> +	rpm = rpm_from_cnt(data->set_cnt, data->clk,
> +			   G762_PULSE_FROM_REG(data->fan_cmd1),
> +			   G762_CLKDIV_FROM_REG(data->fan_cmd1),
> +			   G762_GEARMULT_FROM_REG(data->fan_cmd2));
> +	ret = sprintf(buf, "%u\n", rpm);
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	ret = do_set_fan_target(dev, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/* read function for fan1_fault sysfs file. */
> +static ssize_t get_fan_failure(struct device *dev, struct device_attribute *da,
> +			       char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%u\n", !!(data->fan_sta & G762_REG_FAN_STA_FAIL));
> +}
> +
> +/*
> + * read function for fan1_alarm sysfs file. Note that OOC condition is
> + * enabled low
> + */
> +static ssize_t get_fan_ooc(struct device *dev, struct device_attribute *da,
> +			   char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%u\n", !(data->fan_sta & G762_REG_FAN_STA_OOC));
> +}
> +
> +static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
> +static DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, get_pwm_mode, set_pwm_mode);
> +static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
> +		   get_pwm_enable, set_pwm_enable);
> +static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_rpm, NULL);
> +static DEVICE_ATTR(fan1_alarm, S_IRUGO, get_fan_ooc, NULL);
> +static DEVICE_ATTR(fan1_fault, S_IRUGO, get_fan_failure, NULL);
> +static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO,
> +		   get_fan_target, set_fan_target);
> +static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_fan_div, set_fan_div);
> +static DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO,
> +		   get_fan_pulses, set_fan_pulses);
> +
> +/* Driver data */
> +static struct attribute *g762_attributes[] = {
> +	&dev_attr_fan1_input.attr,
> +	&dev_attr_fan1_alarm.attr,
> +	&dev_attr_fan1_fault.attr,
> +	&dev_attr_fan1_target.attr,
> +	&dev_attr_fan1_div.attr,
> +	&dev_attr_fan1_pulses.attr,
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_pwm1_mode.attr,
> +	&dev_attr_pwm1_enable.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group g762_group = {
> +	.attrs = g762_attributes,
> +};
> +
> +static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct g762_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct g762_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	data->client = client;
> +	mutex_init(&data->update_lock);
> +
> +	/* Enable fan protection and fan fail detection */
> +	do_fan_ooc_detection_toggle(&client->dev, 1);
> +	do_fan_failure_detection_toggle(&client->dev, 1);
> +
> +	/* Get configuration via DT xor platform_data */
> +	if (client->dev.of_node)
> +		ret = g762_of_prop_import(client);
> +	else
> +		ret = g762_pdata_prop_import(client);
> +	if (ret)
> +		goto out;
> +
		return ret;

> +	/* Register sysfs hooks */
> +	ret = sysfs_create_group(&client->dev.kobj, &g762_group);
> +	if (ret)
> +		goto out;
> +
		return ret;

> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		ret = PTR_ERR(data->hwmon_dev);
> +		goto sysfs_out;
> +	}
> +
> +	return 0;
> +
> + sysfs_out:
> +	sysfs_remove_group(&client->dev.kobj, &g762_group);
> + out:
> +	return ret;
> +}
> +
> +static int g762_remove(struct i2c_client *client)
> +{
> +	struct g762_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &g762_group);
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver g762_driver = {
> +	.driver = {
> +		.name = DRVNAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(g762_dt_match),
> +	},
> +	.probe	  = g762_probe,
> +	.remove	  = g762_remove,
> +	.id_table = g762_id,
> +};
> +
> +module_i2c_driver(g762_driver);
> +
> +MODULE_AUTHOR("Arnaud EBALARD <arno@natisbad.org>");
> +MODULE_DESCRIPTION("GMT G762/G763 driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/g762.h b/include/linux/platform_data/g762.h
> new file mode 100644
> index 0000000..d3c5128
> --- /dev/null
> +++ b/include/linux/platform_data/g762.h
> @@ -0,0 +1,37 @@
> +/*
> + * Platform data structure for g762 fan controller driver
> + *
> + * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#ifndef __LINUX_PLATFORM_DATA_G762_H__
> +#define __LINUX_PLATFORM_DATA_G762_H__
> +
> +/*
> + * Following structure can be used to set g762 driver platform specific data
> + * during board init. Note that passing a sparse structure is possible but
> + * will result in non-specified attributes to be set to default value, hence
> + * overloading those installed during boot (e.g. by u-boot).
> + */
> +
> +struct g762_platform_data {
> +	u32 fan_startv;
> +	u32 fan_gear_mode;
> +	u32 pwm_polarity;
> +	u32 clk_freq;
> +};
> +
> +#endif /* __LINUX_PLATFORM_DATA_G762_H__ */
> -- 
> 1.7.10.4
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
