From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Apr 2007 14:43:57 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new driver for SMSC
Message-Id: <20070412164357.5d67a658@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
In-Reply-To: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 22 Mar 2007 09:46:11 -0700, Juerg Haefliger wrote:
> Applied changes based on Hans de Goede's review.
> 
> ---
> This patch adds support for the hardware monitoring and fan control
> capabilities of the SMSC DME1737 and ASUS A8000 Super-I/O chips.
> 
> The hardware monitoring logic of this chip is similar to the LM85 but
> has some additional features that this driver supports. Even though
> it's a Super-I/O chip, the hardware monitoring logic can only be
> accessed via SMBus.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> 
> diff -uprN -X linux-2.6.21-rc1/Documentation/dontdiff -x MAINTAINERS -x Documentation linux-2.6.21-rc1.orig/drivers/hwmon/dme1737.c linux-2.6.21-rc1/drivers/hwmon/dme1737.c
> --- linux-2.6.21-rc1.orig/drivers/hwmon/dme1737.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.21-rc1/drivers/hwmon/dme1737.c	2007-03-20 10:04:48.000000000 -0700
> @@ -0,0 +1,1392 @@
> +/*
> + * dme1737.c - driver for the SMSC DME1737 and ASUS A8000 Super-I/O chips
> + *             integrated hardware monitoring features.
> + * Copyright (c) 2007 Juerg Haeflier <juergh@gmail.com>

Typo in your name.

> + *
> + * This driver is based on the LM85 driver. The hardware monitoring
> + * capabilities of the DME1737 are very similar to the LM85 with some
> + * additional features. Even though the DME1737 is a Super-I/O chip, the
> + * hardware monitoring registers are only accessible via SMBus.
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
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon-vid.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +
> +static int force_start;
> +module_param(force_start, bool, 0);
> +MODULE_PARM_DESC(force_start,
> +		 "Force the chip to start monitoring inputs");
> +
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_1(dme1737);
> +
> +/* ---------------------------------------------------------------------
> + * Registers
> + *
> + * The sensors are defined as follows:
> + *
> + * Voltages                          Temperatures
> + * --------                          ------------
> + * in0   +5VTR (+5V stdby)           temp1   Remote diode 1
> + * in1   Vccp  (proc core)           temp2   Internal temp
> + * in2   VCC   (internal +3.3V)      temp3   Remote diode 2
> + * in3   +5V
> + * in4   +12V
> + * in5   VTR   (+3.3V stby)
> + * in6   Vbat
> + *
> + * --------------------------------------------------------------------- */
> +
> +/* Voltages (in) numbered 0-6 (ix) */
> +#define	DME1737_REG_IN(ix)		((ix) < 5 ? 0x20 + (ix) \
> +						  : 0x94 + (ix))
> +#define	DME1737_REG_IN_MIN(ix)		((ix) < 5 ? 0x44 + (ix) * 2 \
> +						  : 0x91 + (ix) * 2)
> +#define	DME1737_REG_IN_MAX(ix)		((ix) < 5 ? 0x45 + (ix) * 2 \
> +						  : 0x92 + (ix) * 2)
> +static u8 DME1737_REG_IN_LSB[] = {0x87, 0x88, 0x88, 0x87, 0x86, 0x84, 0x84};
> +static u8 DME1737_REG_IN_LSB_SHR[] = {0, 0, 4, 4, 4, 4, 0};

These could be made const.

This approach doesn't seem very efficient to me. You'll end up reading
registers 0x84-0x88 twice on every refresh cycle. Given that SMBus
reads aren't exactly fast and cheap, I'd rather avoid extra reads. I
suggest that you read the values from these 5 registers in a temporary
array in the update function, and change DME1737_REG_IN_LSB and
DME1737_REG_TEMP_LSB to list offsets in this array, rather than
absolute register addresses. That way, you read each register only once.

> +
> +/* Temperatures (temp) numbered 0-2 (ix) */
> +#define DME1737_REG_TEMP(ix)		(0x25 + (ix))
> +#define DME1737_REG_TEMP_MIN(ix)	(0x4e + (ix) * 2)
> +#define DME1737_REG_TEMP_MAX(ix)	(0x4f + (ix) * 2)
> +#define DME1737_REG_TEMP_OFFSET(ix)	((ix) = 0 ? 0x1f \
> +						   : 0x1c + (ix))

The SMSC engineers have been brilliant on this one :(

> +static u8 DME1737_REG_TEMP_LSB[] = {0x85, 0x86, 0x85};
> +static u8 DME1737_REG_TEMP_LSB_SHR[] = {0, 0, 4};
> +
> +/* Fans numbered 0-5 (ix) */
> +#define DME1737_REG_FAN(ix)		((ix) < 4 ? 0x28 + (ix) * 2 \
> +						  : 0xa1 + (ix) * 2)
> +#define DME1737_REG_FAN_MIN(ix)		((ix) < 4 ? 0x54 + (ix) * 2 \
> +						  : 0xa5 + (ix) * 2)
> +#define DME1737_REG_FAN_OPT(ix)		((ix) < 4 ? 0x90 + (ix) \
> +						  : 0xb2 + (ix))
> +#define DME1737_REG_FAN_MAX(ix)		(0xb4 + (ix))

This last macro appears to be valid only for ix in 4-5? This could be
documented.

> +
> +/* PWMs numbered 0-2, 4-5 (ix) */
> +#define DME1737_REG_PWM(ix)		((ix) < 3 ? 0x30 + (ix) \
> +						  : 0xa1 + (ix))
> +#define DME1737_REG_PWM_CONFIG(ix)	(0x5c + (ix))
> +#define DME1737_REG_PWM_MIN(ix)		(0x64 + (ix))

These two only valid for ix in 0-2?

> +#define DME1737_REG_PWM_FREQ(ix)	((ix) < 3 ? 0x5f + (ix) \
> +						  : 0xa3 + (ix))
> +#define DME1737_REG_PWM_RR(ix)		(0x62 + (ix))

The register mapping for this one is quite different from the rest, it
is kinda error-prone to present is as if it were similar.

> +
> +/* Thermal zones */

ix in 0-2

> +#define DME1737_REG_ZONE_LOW(ix)	(0x67 + (ix))
> +#define DME1737_REG_ZONE_ABS(ix)	(0x6a + (ix))
> +#define DME1737_REG_ZONE_HYST(ix)	(0x6d + (ix))

Again this one is mapped differently, this deserves a comment.

> +
> +/* Miscellaneous registers */
> +#define DME1737_REG_COMPANY		0x3e
> +#define DME1737_REG_VERSTEP		0x3f
> +#define DME1737_REG_CONFIG		0x40
> +#define DME1737_REG_CONFIG2		0x7f
> +#define DME1737_REG_VID			0x43
> +#define DME1737_REG_TACH_PWM		0x81
> +
> +/* Alarm registers and bit mapping
> + * The 3 8-bit alarm registers will be concatenated to a single 32-bit
> + * alarm value [0, ALARM3, ALARM2, ALARM1]. */
> +#define DME1737_REG_ALARM1		0x41
> +#define DME1737_REG_ALARM2		0x42
> +#define DME1737_REG_ALARM3		0x83
> +static const u8 BIT_ALARM_IN[]   = {0, 1, 2, 3, 8, 16, 17};
> +static const u8 BIT_ALARM_TEMP[] = {4, 5, 6};
> +static const u8 BIT_ALARM_FAN[]  = {10, 11, 12, 13, 22, 23};
> +
> +/* ---------------------------------------------------------------------
> + * Super-I/O constants
> + * --------------------------------------------------------------------- */
> +
> +#define DME1737_COMPANY_SMSC	0x5c
> +#define DME1737_VERSTEP		0x88
> +#define DME1737_VERSTEP_MASK	0xf8

These are not Super-I/O constants, as you are comparing them with
values read from the SMBus registers.

> +
> +/* ---------------------------------------------------------------------
> + * Data structures and manipulation thereof
> + * --------------------------------------------------------------------- */
> +
> +struct dme1737_data {
> +	struct i2c_client client;
> +	struct class_device *class_dev;
> +
> +	struct mutex update_lock;
> +	int valid;			/* !=0 if following fields are valid */
> +	unsigned long last_update;	/* in jiffies */
> +	unsigned long last_vbat;	/* in jiffies */
> +
> +	/* Register values */
> +	u16 in[7];
> +	u8  in_min[7];
> +	u8  in_max[7];
> +	u16 temp[3];
> +	u8  temp_min[3];
> +	u8  temp_max[3];
> +	u8  temp_offset[3];

You should be able to simplify the code in TEMP_FROM_REG and
TEMP_TO_REG significantly by defining these temperature registers as
s16 and s8.

> +	u8  config;
> +	u8  vrm;

For what it's worth, vrm isn't actually a register value.

> +	u16 fan[6];
> +	u16 fan_min[6];
> +	u8  fan_max[2];
> +	u8  fan_opt[6];
> +	u8  pwm[6];
> +	u8  pwm_min[3];
> +	u8  pwm_config[3];
> +	u8  pwm_act[3];
> +	u8  pwm_freq[6];
> +	u8  pwm_rr[2];
> +	u8  zone_low[3];
> +	u8  zone_abs[3];
> +	u8  zone_hyst[2];
> +	u32 alarms;
> +	u8  vid;
> +};

You could move alarms either at the beginning or at the end of the
register list, to minimize holes in the structure.

> +
> +/* nominal voltage value */
> +static int IN_NOMINAL(int ix)
> +{
> +	int nom[] = {5000, 2250, 3300, 5000, 12000, 3300, 3300};

This array should be declared static const. Same for similar arrays in
the other conversion helpers. Alternatively, at least for this
function, you could define a global static array directly, without a
wrapper function, as the wrapper function doesn't add much.

> +	return nom[ix];
> +}


You really want to declare all these one- or two-line conversion
functions inline. This will make your code faster _and_ smaller.

> +
> +/* voltage input
> + * voltage inputs have 12bits resolution, limit values have 8bits
> + * resolution. */
> +static int IN_FROM_REG(int reg, int ix, int res)
> +{
> +	return (reg * IN_NOMINAL(ix) / (3 << (res - 2)));
> +}
> +
> +static int IN_TO_REG(int val, int ix, int res)
> +{
> +	return SENSORS_LIMIT(val * (3 << (res - 2)) / IN_NOMINAL(ix),
> +			     0, (1 << res) - 1);
> +}

Can you please add proper rounding to these voltage conversion
formulae? Also, the second function is only ever called with res = 8 so
you could simplify it a bit.

> +
> +/* temperature input 
> + * the register values represent temperatures in 2s complement notation from

2's

> + * -127C to +127C. temp inputs have 12bits resolution, limit values have

127 degrees C

> + * 8bits resolution. */
> +static int TEMP_FROM_REG(int reg, int res)
> +{
> +	return ((((reg & (1 << (res - 1))) ? reg - (1 << res) : reg) *
> +		 1000) >> (res - 8));
> +}
> +
> +static int TEMP_TO_REG(int val, int res)
> +{
> +	int temp = (val << (res - 8)) / 1000;
> +	return SENSORS_LIMIT((temp < 0) ? temp + (1 << res) : temp,
> +			     0, (1 << res) - 1 );
> +}

This one too is only ever called with res = 8, so it could be
simplified a bit.

> +
> +/* temperature range */
> +static int TEMP_RANGE_FROM_REG(int reg)
> +{
> +	int range[] = { 2000,  2500,  3333,  4000,  5000,  6666,  8000, 10000,
> +		       13333, 16000, 20000, 26666, 32000, 40000, 53333, 80000};
> +	return range[(reg >> 4) & 0x0f];
> +}

The "& 0x0f" doesn't appear to be needed.

> +
> +static int TEMP_RANGE_TO_REG(int val, int reg)
> +{
> +	int range = ((val > 66666) ? 15 : (val > 46666) ? 14 :
> +		     (val > 36000) ? 13 : (val > 29333) ? 12 :
> +		     (val > 23333) ? 11 : (val > 18000) ? 10 :
> +		     (val > 14666) ? 9 : (val > 11666) ? 8 :
> +		     (val > 9000) ? 7 : (val > 7333) ? 6 :
> +		     (val > 5833) ? 5 : (val > 4500) ? 4 :
> +		     (val > 3666) ? 3 : (val > 2917) ? 2 :
> +		     (val > 2250) ? 1 : 0);

This would be much nicer implemented as a loop iterating over a static
array.

> +	return ((reg & 0x0f) | (range << 4));
> +}
> +
> +/* temperature hysteresis
> + * register layout:
> + *    reg[0] = [H1-3,  H1-2,  H1-1,  H1-0, H2-3, H2-2, H2-1, H2-0]
> + *    reg[1] = [H3-3,  H3-2,  H3-1,  H3-0, xxxx, xxxx, xxxx, xxxx] */
> +static int TEMP_HYST_FROM_REG(int reg, int ix) {

Improperly placed opening curly brace.

> +	return ((((ix = 1) ? reg : reg >> 4) & 0x0f) * 1000);
> +}
> +
> +static int TEMP_HYST_TO_REG(int val, int ix, int reg)
> +{
> +	int hyst = SENSORS_LIMIT(val / 1000, 0, 15);
> +	return ((ix = 1) ? (reg & 0xf0) | hyst : (reg & 0x0f) | (hyst << 4)); 
> +}
> +
> +/* fan input rpm */
> +static int FAN_FROM_REG(int reg, int tpc)
> +{
> +	return ((reg = 0 || reg = 0xffff) ? 0 :
> +		(tpc = 0) ? 90000 * 60 / reg : tpc * reg);
> +}
> +
> +static int FAN_TO_REG(int val, int tpc)
> +{
> +	return SENSORS_LIMIT((tpc = 0) ? 90000 * 60 / val : val / tpc,
> +			     0, 65535);
> +}

It's a bit inconsistent to use 0xffff in one function and 65535 in the
other.

> +
> +/* fan tpc (tach pulse count)
> + * converts a register value to a tpc multiplier or returns 0 if the tachometer
> + * is configured in legacy (non-tpc) mode */
> +static int FAN_TPC_FROM_REG(int reg)
> +{
> +	return ((reg & 0x20) ? 0 : 60 >> (reg & 0x03));
> +}
> +
> +/* fan type */
> +static int FAN_TYPE_FROM_REG(int reg) {

Improperly placed opening curly brace.

> +	return ((1 << ((reg >> 1) & 0x03)) + 1);
> +}
> +
> +static int FAN_TYPE_TO_REG(int val, int reg)
> +{
> +	int div = ((val = 2) ? 0 : (val = 3) ? 1 : (val = 5) ? 2 : 3);
> +	return ((reg & 0xf9) | (div << 1));
> +}
> +
> +/* fan max rpm */
> +static int FAN_MAX_FROM_REG(int reg)
> +{
> +	return ((reg = 0x54) ? 1000 : (reg = 0x38) ? 1500 :
> +		(reg = 0x2a) ? 2000 : (reg = 0x21) ? 2500 :
> +		(reg = 0x1c) ? 3000 : (reg = 0x18) ? 3500 :
> +		(reg = 0x15) ? 4000 : (reg = 0x12) ? 4500 :
> +		(reg = 0x11) ? 5000 : (reg = 0x0f) ? 5500 : 6000);
> +}
> +
> +static int FAN_MAX_TO_REG(int val)
> +{
> +	return ((val > 5500) ? 0x0e : (val > 5000) ? 0x0f :
> +		(val > 4500) ? 0x11 : (val > 4000) ? 0x12 :
> +		(val > 3500) ? 0x15 : (val > 3000) ? 0x18 :
> +		(val > 2500) ? 0x1c : (val > 2000) ? 0x21 :
> +		(val > 1500) ? 0x2a : (val > 1000) ? 0x38 : 0x54);
> +}

Here again, a loop iterating over a static array (shared between the two
functions) would be nicer IMHO.

> +
> +/* pwm enable */
> +static int PWM_EN_FROM_REG(int reg)
> +{
> +	int en[] = {2, 2, 2, 0, -1, 2, 2, 1};
> +	return en[(reg >> 5) & 0x07];
> +}

"-1" isn't a valid value according to our sysfs interface standard. A
stopped fan would be presented as pwmN_enable = 1 and pwmN = 0
according to our standard.

The masking doesn't appear to be needed.

> +static int PWM_EN_TO_REG(int val, int reg)
> +{
> +	int en = ((val = -1) ? 4 : (val = 1) ? 7 : 3);
> +	return ((reg & 0x1f) | ((en & 0x07) << 5));
> +}
> +
> +/* pwm auto channels temp */
> +static int PWM_ACT_FROM_REG(int reg)
> +{
> +	int act[] = {1, 2, 4, 0, 0, 6, 7, 0};
> +	return act[(reg >> 5) & 0x07];
> +}

Nor here.

> +static int PWM_ACT_TO_REG(int val, int reg)
> +{
> +	int act = ((val = 1) ? 0 : (val = 2) ? 1 :
> +		   (val = 4) ? 2 : val - 1);
> +	return ((reg & 0x1f) | ((act & 0x07) << 5));
> +}

Nor here.

> +
> +/* pwm frequency */
> +static int PWM_FREQ_FROM_REG(int reg)
> +{
> +	int freq[] = {11, 15, 22, 29, 35, 44, 59, 88,
> +		      15000, 20000, 30000, 25000, 0, 0, 0, 0};
> +	return freq[reg & 0x0f];
> +}

Again, what smart engineers we have here :( Unbelievable.

> +static int PWM_FREQ_TO_REG(int val, int reg)
> +{
> +	int freq = ((val > 27500) ? 10 : (val > 22500) ? 11 :
> +		    (val > 17500) ? 9 : (val >  7544) ? 8 :
> +		    (val > 64) ? 7 : (val > 52) ? 6 :
> +		    (val > 40) ? 5 : (val > 32) ? 4 :
> +		    (val > 26) ? 3 : (val > 19) ? 2 :
> +		    (val > 13) ? 1 : 0);
> +	return ((reg & 0xf0) | freq);
> +}
> +
> +/* pwm ramp rate
> + * register layout:
> + *    reg[0] = [xxxxx, xxxxx, xxxxx, xxxxx, RR1-E, RR1-2, RR1-1, RR1-0] 
> + *    reg[1] = [RR2-E, RR2-2, RR2-1, RR2-0, RR3-E, RR3-2, RR3-1, RR3-0] */
> +static int PWM_RR_FROM_REG(int reg, int ix)
> +{
> +	int rr[] = {206, 104, 69, 41, 26, 18, 10, 5};
> +	int val = ((ix = 1) ? reg >> 4 : reg);
> +	return ((val & 0x08) ? rr[val & 0x07] : 0);
> +}
> +
> +static int PWM_RR_TO_REG(int val, int ix, int reg)
> +{
> +	int rr = ((val > 155) ? 8 : (val > 86) ? 9 : 
> +		  (val > 55) ? 10 : (val > 33) ? 11 :
> +		  (val > 22) ? 12 : (val > 14) ? 13 :
> +		  (val > 14) ? 14 : (val > 0) ? 15 : 0);

Bug here, you're doing the same comparison twice. According to the
array above - which you could have reused) the second (val > 14) should
be (val > 7).

> +	return ((ix = 1) ? (reg & 0x0f) | (rr << 4) : (reg & 0xf0) | rr);
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Device I/O access
> + * --------------------------------------------------------------------- */
> +
> +static u8 dme1737_read(struct i2c_client *client, u8 reg)
> +{
> +	s32 val = i2c_smbus_read_byte_data(client, reg);
> +
> +	if (val < 0) {
> +		dev_warn(&client->dev, "Read from register 0x%02x failed! "
> +			 "Please report to the driver maintainer.\n", reg);
> +	}
> +
> +	return (u8)val;

Explicit cast not needed - what else could the compiler do?

> +}
> +
> +static s32 dme1737_write(struct i2c_client *client, u8 reg, u8 value)
> +{
> +	s32 res = i2c_smbus_write_byte_data(client, reg, value);
> +
> +	if (res < 0) {
> +		dev_warn(&client->dev, "Write to register 0x%02x failed! "
> +			 "Please report to the driver maintainer.\n", reg);
> +	}
> +
> +	return res;
> +}
> +
> +static struct dme1737_data *dme1737_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	int ix;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* enable a Vbat monitoring cycle every 30 secs */
> +	if (time_after(jiffies, data->last_vbat + 30 * HZ) || !data->valid) {
> +		dme1737_write(client, DME1737_REG_CONFIG, dme1737_read(client,
> +						DME1737_REG_CONFIG) | 0x10);
> +		data->last_vbat = jiffies;
> +	}

Do we really need a new battery reading every 30 seconds? I think I'd
go for a much larger interval to not draw too much power from the
battery.

> +
> +	/* sample register contents every 1 sec */
> +	if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
> +		data->config = dme1737_read(client, DME1737_REG_CONFIG);

You only use the value of this register at device initialization time,
so you don't need to refresh it. Make this a local variable in
dme1737_init_client(), it's sufficient.

> +		data->vid    = dme1737_read(client, DME1737_REG_VID) & 0x3f;

This kind of visual alignment is discouraged.

> +
> +		/* in (voltage) registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
> +			data->in[ix] = dme1737_read(client,
> +					DME1737_REG_IN(ix)) << 4;
> +			data->in[ix] |= (dme1737_read(client,
> +					DME1737_REG_IN_LSB[ix]) >>
> +					DME1737_REG_IN_LSB_SHR[ix]) & 0x0f;

I would welcome a comment explaining that it is important to read the
MSB first for integrity.

> +			data->in_min[ix] = dme1737_read(client,
> +					DME1737_REG_IN_MIN(ix));
> +			data->in_max[ix] = dme1737_read(client,
> +					DME1737_REG_IN_MAX(ix));
> +		}
> +
> +		/* temp registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->temp); ix++) {
> +			data->temp[ix] = dme1737_read(client,
> +					DME1737_REG_TEMP(ix)) << 4;
> +			data->temp[ix] |= (dme1737_read(client,
> +					DME1737_REG_TEMP_LSB[ix]) >>
> +					DME1737_REG_TEMP_LSB_SHR[ix]) & 0x0f;

Same here.

> +			data->temp_min[ix] = dme1737_read(client,
> +					DME1737_REG_TEMP_MIN(ix));
> +			data->temp_max[ix] = dme1737_read(client,
> +					DME1737_REG_TEMP_MAX(ix));
> +			data->temp_offset[ix] = dme1737_read(client,
> +					DME1737_REG_TEMP_OFFSET(ix));
> +		}
> +
> +		/* fan registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {

According to the datasheet, fans 5 and 6 (A and B in the datasheet)
share their pins with other functions, and are not even the default.
However you create the fan[5-6] and pwm[5-6] files unconditionally?
Ideally you should check run-time registers 0x43 to 0x46 and only create
the sysfs files (and read the registers) if the chip is configured that
way.

> +			data->fan[ix] = dme1737_read(client,
> +					DME1737_REG_FAN(ix));
> +			data->fan[ix] |= (dme1737_read(client,
> +					DME1737_REG_FAN(ix) + 1) << 8);

I would welcome a comment explaining that it is important to read the
LSB first for value integrity. Have you tested if the DME1737 supports
word reads on these registers? This would speed up the update a bit.

Outermost parentheses are not needed.

> +			data->fan_min[ix] = dme1737_read(client,
> +					DME1737_REG_FAN_MIN(ix));
> +			data->fan_min[ix] |= (dme1737_read(client,
> +					DME1737_REG_FAN_MIN(ix) + 1) << 8);

Ditto.

> +			data->fan_opt[ix] = dme1737_read(client,
> +					DME1737_REG_FAN_OPT(ix));
> +			if (ix > 4) {
> +				data->fan_max[ix - 5] = dme1737_read(client,
> +					DME1737_REG_FAN_MAX(ix));
> +			}

This looks broken to me. Given that ix is in range 0 to 5, shouldn't
this be "if (ix  >= 4)" and "data->fan_max[ix - 4]"?

> +		}
> +
> +		/* pwm registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->pwm); ix++) {
> +			if (ix = 3) {	/* pwm4 doesn't exist */
> +				continue;
> +			}
> +			data->pwm[ix] = dme1737_read(client,
> +					DME1737_REG_PWM(ix));
> +			data->pwm_freq[ix] = dme1737_read(client,
> +					DME1737_REG_PWM_FREQ(ix));
> +			if (ix < 3) {
> +				data->pwm_config[ix] = dme1737_read(client,
> +						DME1737_REG_PWM_CONFIG(ix));
> +				data->pwm_min[ix] = dme1737_read(client,
> +						DME1737_REG_PWM_MIN(ix));
> +			}
> +			if (ix < 2) {
> +				data->pwm_rr[ix] = dme1737_read(client,
> +						DME1737_REG_PWM_RR(ix));
> +			}

The "ix" in the last statement doesn't have the same meaning as in the
rest of the loop, that's a bit confusing. Would you mind moving this
last statement out of the loop?

> +		}
> +
> +		/* thermal zone registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->zone_low); ix++) {
> +			data->zone_low[ix] = dme1737_read(client,
> +					DME1737_REG_ZONE_LOW(ix));
> +			data->zone_abs[ix] = dme1737_read(client,
> +					DME1737_REG_ZONE_ABS(ix));
> +			if (ix < 2) {
> +				data->zone_hyst[ix] = dme1737_read(client,
> +						DME1737_REG_ZONE_HYST(ix));
> +			}

Same here.

> +		}
> +
> +		/* alarm registers */
> +		data->alarms = dme1737_read(client,
> +						DME1737_REG_ALARM1);

If I read the datasheet properly, you could check the value of bit 7
and skip the next two reads if it's clear.

> +		data->alarms |= dme1737_read(client,
> +						DME1737_REG_ALARM2) << 8;
> +		data->alarms |= dme1737_read(client,
> +						DME1737_REG_ALARM3) << 16;
> +
> +		data->last_update = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Voltage sysfs attributes
> + * ix = [0-5]
> + * --------------------------------------------------------------------- */
> +
> +#define SYS_IN_INPUT	0
> +#define SYS_IN_MIN	1
> +#define SYS_IN_MAX	2
> +#define SYS_IN_ALARM	3
> +
> +static ssize_t show_in(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +	struct sensor_device_attribute_2
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SYS_IN_INPUT:
> +		res = IN_FROM_REG(data->in[ix], ix, 12);
> +		break;
> +	case SYS_IN_MIN:
> +		res = IN_FROM_REG(data->in_min[ix], ix, 8);
> +		break;
> +	case SYS_IN_MAX:
> +		res = IN_FROM_REG(data->in_max[ix], ix, 8);
> +		break;
> +	case SYS_IN_ALARM:
> +		res = (data->alarms >> BIT_ALARM_IN[ix]) & 0x01;
> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_in(struct device *dev, struct device_attribute *attr,
> +		      const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute_2 
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SYS_IN_MIN:
> +		data->in_min[ix] = IN_TO_REG(val, ix, 8);
> +		dme1737_write(client, DME1737_REG_IN_MIN(ix),
> +			      data->in_min[ix]);
> +		break;
> +	case SYS_IN_MAX:
> +		data->in_max[ix] = IN_TO_REG(val, ix, 8);
> +		dme1737_write(client, DME1737_REG_IN_MAX(ix),
> +			      data->in_max[ix]);
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Temperature sysfs attributes
> + * ix = [0-2]
> + * --------------------------------------------------------------------- */
> +
> +#define SYS_TEMP_INPUT			0
> +#define SYS_TEMP_MIN			1
> +#define SYS_TEMP_MAX			2
> +#define SYS_TEMP_OFFSET			3
> +#define SYS_TEMP_ALARM			4
> +#define SYS_TEMP_FAULT			5
> +#define SYS_TEMP_AUTO_POINT1_TEMP	6
> +#define SYS_TEMP_AUTO_POINT2_TEMP	7
> +#define SYS_TEMP_AUTO_POINT1_TEMP_HYST	8
> +#define SYS_TEMP_AUTO_POINT2_TEMP_CRIT	9
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +	struct sensor_device_attribute_2
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SYS_TEMP_INPUT:
> +		res = TEMP_FROM_REG(data->temp[ix], 12);
> +		break;
> +	case SYS_TEMP_MIN:
> +		res = TEMP_FROM_REG(data->temp_min[ix], 8);
> +		break;
> +	case SYS_TEMP_MAX:
> +		res = TEMP_FROM_REG(data->temp_max[ix], 8);
> +		break;
> +	case SYS_TEMP_OFFSET:
> +		res = TEMP_FROM_REG(data->temp_offset[ix], 8);
> +		break;
> +	case SYS_TEMP_ALARM:
> +		res = (data->alarms >> BIT_ALARM_TEMP[ix]) & 0x01;
> +		break;
> +	case SYS_TEMP_FAULT:
> +		res = (data->temp[ix] = 0x0800);
> +		break;
> +	case SYS_TEMP_AUTO_POINT1_TEMP:
> +		res = TEMP_FROM_REG(data->zone_low[ix], 8);
> +		break;
> +	case SYS_TEMP_AUTO_POINT2_TEMP:
> +		/* pwm_freq holds the temp range bits in the upper nibble */
> +		res = TEMP_FROM_REG(data->zone_low[ix], 8) +
> +		      TEMP_RANGE_FROM_REG(data->pwm_freq[ix]);
> +		break;
> +	case SYS_TEMP_AUTO_POINT1_TEMP_HYST:
> +		res = TEMP_FROM_REG(data->zone_low[ix], 8) -
> +		      TEMP_HYST_FROM_REG(data->zone_hyst[ix = 2], ix);
> +		break;
> +	case SYS_TEMP_AUTO_POINT2_TEMP_CRIT:
> +		res = TEMP_FROM_REG(data->zone_abs[ix], 8);
> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute_2 
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SYS_TEMP_MIN:
> +		data->temp_min[ix] = TEMP_TO_REG(val, 8);
> +		dme1737_write(client, DME1737_REG_TEMP_MIN(ix),
> +			      data->temp_min[ix]);
> +		break;
> +	case SYS_TEMP_MAX:
> +		data->temp_max[ix] = TEMP_TO_REG(val, 8);
> +		dme1737_write(client, DME1737_REG_TEMP_MAX(ix),
> +			      data->temp_max[ix]);
> +		break;
> +	case SYS_TEMP_OFFSET:
> +		data->temp_offset[ix] = TEMP_TO_REG(val, 8);
> +		dme1737_write(client, DME1737_REG_TEMP_OFFSET(ix),
> +			      data->temp_offset[ix]);
> +		break;
> +	case SYS_TEMP_AUTO_POINT1_TEMP:
> +		data->zone_low[ix] = TEMP_TO_REG(val, 8);
> +		dme1737_write(client, DME1737_REG_ZONE_LOW(ix),
> +			      data->zone_low[ix]);
> +		break;
> +	case SYS_TEMP_AUTO_POINT2_TEMP:
> +		/* refresh the cache */
> +		data->zone_low[ix] = dme1737_read(client,
> +						  DME1737_REG_ZONE_LOW(ix));
> +		/* modify the temp range value (which is stored in the upper
> +		 * nibble of the pwm_freq register) */
> +		data->pwm_freq[ix] = TEMP_RANGE_TO_REG(val - 
> +					TEMP_FROM_REG(data->zone_low[ix], 8),
> +					dme1737_read(client,
> +					DME1737_REG_PWM_FREQ(ix)));
> +		dme1737_write(client, DME1737_REG_PWM_FREQ(ix),
> +			      data->pwm_freq[ix]);
> +		break;
> +	case SYS_TEMP_AUTO_POINT1_TEMP_HYST:
> +		/* refresh the cache */
> +		data->zone_low[ix] = dme1737_read(client,
> +						  DME1737_REG_ZONE_LOW(ix));
> +		/* modify the temp hyst value */
> +		data->zone_hyst[ix = 2] = TEMP_HYST_TO_REG(
> +					TEMP_FROM_REG(data->zone_low[ix], 8) -
> +					val, ix, dme1737_read(client,
> +					DME1737_REG_ZONE_HYST(ix = 2)));
> +		dme1737_write(client, DME1737_REG_ZONE_HYST(ix = 2),
> +			      data->zone_hyst[ix = 2]);
> +		break;
> +	case SYS_TEMP_AUTO_POINT2_TEMP_CRIT:
> +		data->zone_abs[ix] = TEMP_TO_REG(val, 8);
> +		dme1737_write(client, DME1737_REG_ZONE_ABS(ix),
> +			      data->zone_abs[ix]);
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Fan sysfs attributes
> + * ix = [0-5]
> + * --------------------------------------------------------------------- */
> +
> +#define SYS_FAN_INPUT	0
> +#define SYS_FAN_MIN	1
> +#define SYS_FAN_MAX	2
> +#define SYS_FAN_ALARM	3
> +#define SYS_FAN_TYPE	4
> +
> +static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +	struct sensor_device_attribute_2
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SYS_FAN_INPUT:
> +		res = FAN_FROM_REG(data->fan[ix],
> +				   ix < 4 ? 0 :
> +				   FAN_TPC_FROM_REG(data->fan_opt[ix]));
> +		break;
> +	case SYS_FAN_MIN:
> +		res = FAN_FROM_REG(data->fan_min[ix],
> +				   ix < 4 ? 0 :
> +				   FAN_TPC_FROM_REG(data->fan_opt[ix]));
> +		break;
> +	case SYS_FAN_MAX:
> +		/* only valid for fan[5-6] */
> +		res = FAN_MAX_FROM_REG(data->fan_max[ix - 5]);

Smells like an array overrun. Given that ix is a value between 0 and 5,
this should be "data->fan_max[ix - 4]", shouldn't it?

> +		break;
> +	case SYS_FAN_ALARM:
> +		res = (data->alarms >> BIT_ALARM_FAN[ix]) & 0x01;
> +		break;
> +	case SYS_FAN_TYPE:
> +		/* only falid for fan[1-4] */
> +		res = FAN_TYPE_FROM_REG(data->fan_opt[ix]);
> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute_2 
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SYS_FAN_MIN:
> +		if (ix < 4) {
> +			data->fan_min[ix] = FAN_TO_REG(val, 0);
> +		} else {
> +			/* refresh the cache */
> +			data->fan_opt[ix] = dme1737_read(client,
> +						DME1737_REG_FAN_OPT(ix));
> +			/* modify the fan min value */
> +			data->fan_min[ix] = FAN_TO_REG(val,
> +					FAN_TPC_FROM_REG(data->fan_opt[ix]));
> +		}
> +		dme1737_write(client, DME1737_REG_FAN_MIN(ix),
> +			      data->fan_min[ix]);

I suggest an explicit mask "& 0xff" here.

> +		dme1737_write(client, DME1737_REG_FAN_MIN(ix) + 1,
> +			      data->fan_min[ix] >> 8);
> +		break;
> +	case SYS_FAN_MAX:
> +		/* only valid for fan[5-6] */
> +		data->fan_max[ix - 5] = FAN_MAX_TO_REG(val);
> +		dme1737_write(client, DME1737_REG_FAN_MAX(ix),
> +			      data->fan_max[ix - 5]);

Again I believe these should be "[ix - 4]".

> +		break;
> +	case SYS_FAN_TYPE:
> +		/* only valid for fan[1-4] */
> +		if (!(val = 2 || val = 3 || val = 5 || val = 9)) {
> +			count = -EINVAL;
> +			dev_warn(&client->dev, "Fan type value %ld not "
> +				 "supported. Choose one of 2, 3, "
> +				 "5, or 9.\n", val);
> +			goto exit;
> +		}
> +		data->fan_opt[ix] = FAN_TYPE_TO_REG(val, dme1737_read(client,
> +					DME1737_REG_FAN_OPT(ix)));

This isn't very efficient. You are doing again the same comparisons in
FAN_TYPE_TO_REG() as you have been doing above. In general, when you
need to validate discrete values from user input, it's better to not
move the conversion to a separate function, so that you can do the
validation and the conversion in one pass. Look at set_fan_div() in the
fscher driver for example.

> +		dme1737_write(client, DME1737_REG_FAN_OPT(ix),
> +			      data->fan_opt[ix]);
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +exit:
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * PWM sysfs attributes
> + * ix = [0-4]
> + * --------------------------------------------------------------------- */
> +
> +#define SYS_PWM				0
> +#define SYS_PWM_FREQ			1
> +#define SYS_PWM_ENABLE			2
> +#define SYS_PWM_RAMP_RATE		3
> +#define SYS_PWM_AUTO_CHANNELS_TEMP	4
> +#define SYS_PWM_AUTO_POINT1_PWM		5
> +#define SYS_PWM_AUTO_POINT2_PWM		6
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +	struct sensor_device_attribute_2
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SYS_PWM:
> +		res = data->pwm[ix];
> +		break;
> +	case SYS_PWM_FREQ:
> +		res = PWM_FREQ_FROM_REG(data->pwm_freq[ix]);
> +		break;
> +	case SYS_PWM_ENABLE:
> +		res = (ix > 3 ? 1 : /* pwm[5-6] hard-wired to manual mode */
> +		       PWM_EN_FROM_REG(data->pwm_config[ix]));
> +		break;
> +	case SYS_PWM_RAMP_RATE:
> +		/* only valid for pwm[1-3] */
> +		res = PWM_RR_FROM_REG(data->pwm_rr[ix > 0], ix);
> +		break;
> +	case SYS_PWM_AUTO_CHANNELS_TEMP:
> +		/* only valid for pwm[1-3] */
> +		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
> +			res = PWM_ACT_FROM_REG(data->pwm_config[ix]);
> +		} else {
> +			res = data->pwm_act[ix];
> +		}
> +		break;
> +	case SYS_PWM_AUTO_POINT1_PWM:
> +		/* only valid for pwm[1-3] */
> +		res = data->pwm_min[ix];
> +		break;
> +	case SYS_PWM_AUTO_POINT2_PWM:
> +		/* only valid for pwm[1-3] */
> +		res = 255; /* hard-wired */
> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute_2 
> +		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SYS_PWM:
> +		/* refresh the cache */
> +		data->pwm_config[ix] = dme1737_read(client,
> +						DME1737_REG_PWM_CONFIG(ix));
> +		if (PWM_EN_FROM_REG(data->pwm_config[ix]) != 1) {
> +			count = -EPERM;
> +			dev_warn(&client->dev, "Attribute is read-only. "
> +				 "Pwm%d is not in manual mode\n", ix + 1);
> +			goto exit;
> +		}

What about actually turning the sysfs file read-only in this case? The
f71805f driver does this, I think it's more elegant. An application can
see that a file has been turned read-only, while an application won't
read the system log.

> +		data->pwm[ix] = SENSORS_LIMIT(val, 0, 255);
> +		dme1737_write(client, DME1737_REG_PWM(ix), data->pwm[ix]);
> +		break;
> +	case SYS_PWM_FREQ:
> +		data->pwm_freq[ix] = PWM_FREQ_TO_REG(val, dme1737_read(client,
> +						DME1737_REG_PWM_FREQ(ix)));
> +		dme1737_write(client, DME1737_REG_PWM_FREQ(ix),
> +			      data->pwm_freq[ix]);
> +		break;
> +	case SYS_PWM_ENABLE:
> +		/* only valid for pwm[1-3] */
> +		if (val < -1 || val > 2) {
> +			count = -EINVAL;
> +			dev_warn(&client->dev, "PWM enable %ld not "
> +				 "supported. Choose one of -1, 0, 1, or 2.\n",
> +				 val);
> +			goto exit;
> +		}

As said earlier, -1 isn't actually an acceptable value.

> +		/* refresh the cache */
> +		data->pwm_config[ix] = dme1737_read(client,
> +						DME1737_REG_PWM_CONFIG(ix));
> +		if (val = 2 &&
> +		    PWM_EN_FROM_REG(data->pwm_config[ix]) != 2) { 
> +			/* turn on auto mode using the saved temp channel
> +			 * assignment */
> +			data->pwm_config[ix] = PWM_ACT_TO_REG(
> +							data->pwm_act[ix],
> +							data->pwm_config[ix]);
> +			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
> +				      data->pwm_config[ix]);
> +		} else if (val != 2) {
> +			/* set manual mode */
> +			if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
> +				/* save the current temp channel assignment
> +				 * if we are currently in auto mode */
> +				data->pwm_act[ix] = PWM_ACT_FROM_REG(
> +							data->pwm_config[ix]);
> +			}
> +			data->pwm_config[ix] = PWM_EN_TO_REG(val,
> +							data->pwm_config[ix]);
> +			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
> +				      data->pwm_config[ix]);
> +		}

You should be able to optimize/clean up this a bit:
* Split the first test to two nested ifs, then you don't need to test
if "val != 2", a simple "else" will do.
* You can move the dme1737_write() call outside of the conditional
blocks, as it's common to both blocks (worst case, you write the same
value that was already there, which is OK.)

> +		break;
> +	case SYS_PWM_RAMP_RATE:
> +		/* only valid for pwm[1-3] */
> +		data->pwm_rr[ix > 0] = PWM_RR_TO_REG(val, ix,
> +						dme1737_read(client,
> +						DME1737_REG_PWM_RR(ix > 0)));
> +		dme1737_write(client, DME1737_REG_PWM_RR(ix > 0),
> +			      data->pwm_rr[ix > 0]);

The datasheet says that ramp rate should be disabled in manual mode,
but you driver doesn't do that?

> +		break;
> +	case SYS_PWM_AUTO_CHANNELS_TEMP:
> +		/* only valid for pwm[1-3] */
> +		if (!(val = 1 || val = 2 || val = 4 ||
> +		      val = 6 || val = 7)) {
> +			count = -EINVAL;
> +			dev_warn(&client->dev, "PWM auto channels temp %ld "
> +				 "not supported. Choose one of 1, 2, 4, 6, "
> +				 "or 7.\n", val);
> +			goto exit;
> +		}
> +		/* refresh the cache */
> +		data->pwm_config[ix] = dme1737_read(client,
> +						DME1737_REG_PWM_CONFIG(ix));
> +		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
> +			/* PWM is already in auto mode so update the temp
> +			 * channel assignment */
> +			data->pwm_config[ix] = PWM_ACT_TO_REG(val,
> +						data->pwm_config[ix]);
> +			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
> +				      data->pwm_config[ix]);
> +		} else {
> +			/* PWM is not in auto mode so we save the temp
> +			 * channel assignment for later use */
> +			data->pwm_act[ix] = val;
> +		}
> +		break;
> +	case SYS_PWM_AUTO_POINT1_PWM:
> +		/* only valid for pwm[1-3] */
> +		data->pwm_min[ix] = SENSORS_LIMIT(val, 0, 255);
> +		dme1737_write(client, DME1737_REG_PWM_MIN(ix),
> +			      data->pwm_min[ix]);
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +exit:
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Miscellaneous sysfs attributes
> + * --------------------------------------------------------------------- */
> +
> +static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +
> +	return sprintf(buf, "%d\n", data->vrm);
> +}
> +
> +static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	data->vrm = val;
> +	return count;
> +}
> +
> +static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
> +}
> +
> +static ssize_t show_alarms(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", data->alarms);
> +}

We don't want such compound alarms file in the new drivers. We're
keeping them in older drivers only for backward compatibility purposes.

> +
> +
> +/* ---------------------------------------------------------------------
> + * Device attribute structs
> + * --------------------------------------------------------------------- */
> +
> +#define SENSOR_ATTR_IN(ix) \
> +	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
> +		show_in, NULL, SYS_IN_INPUT, ix), \
> +	SENSOR_ATTR_2(in##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SYS_IN_MIN, ix), \
> +	SENSOR_ATTR_2(in##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SYS_IN_MAX, ix), \
> +	SENSOR_ATTR_2(in##ix##_alarm, S_IRUGO, \
> +		show_in, NULL, SYS_IN_ALARM, ix)
> +
> +#define SENSOR_ATTR_TEMP(ix) \
> +	SENSOR_ATTR_2(temp##ix##_input, S_IRUGO, \
> +		show_temp, NULL, SYS_TEMP_INPUT, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SYS_TEMP_MIN, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SYS_TEMP_MAX, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_offset, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SYS_TEMP_OFFSET, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_alarm, S_IRUGO, \
> +		show_temp, NULL, SYS_TEMP_ALARM, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_fault, S_IRUGO, \
> +		show_temp, NULL, SYS_TEMP_FAULT, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_auto_point1_temp, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SYS_TEMP_AUTO_POINT1_TEMP, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_auto_point2_temp, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SYS_TEMP_AUTO_POINT2_TEMP, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_auto_point1_temp_hyst, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, \
> +		SYS_TEMP_AUTO_POINT1_TEMP_HYST, ix-1), \
> +	SENSOR_ATTR_2(temp##ix##_auto_point2_temp_crit, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, \
> +		SYS_TEMP_AUTO_POINT2_TEMP_CRIT, ix-1)

We don't have this in our standard interface. This would rather be
temp##ix##_auto_point3_temp, and pwm##ix##_auto_point3_pwm hard-coded
to 255. 

> +
> +#define SENSOR_ATTR_FAN(ix) \
> +	SENSOR_ATTR_2(fan##ix##_input, S_IRUGO, \
> +		show_fan, NULL, SYS_FAN_INPUT, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SYS_FAN_MIN, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_alarm, S_IRUGO, \
> +		show_fan, NULL, SYS_FAN_ALARM, ix-1)
> +
> +#define SENSOR_ATTR_FAN_1TO4(ix) \
> +	SENSOR_ATTR_FAN(ix), \
> +	SENSOR_ATTR_2(fan##ix##_type, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SYS_FAN_TYPE, ix-1)
> +
> +#define SENSOR_ATTR_FAN_5TO6(ix) \
> +	SENSOR_ATTR_FAN(ix), \
> +	SENSOR_ATTR_2(fan##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SYS_FAN_MAX, ix-1)
> +
> +#define SENSOR_ATTR_PWM(ix) \
> +	SENSOR_ATTR_2(pwm##ix, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SYS_PWM, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_freq, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SYS_PWM_FREQ, ix-1)
> +
> +#define SENSOR_ATTR_PWM_1TO3(ix) \
> +	SENSOR_ATTR_PWM(ix), \
> +	SENSOR_ATTR_2(pwm##ix##_enable, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SYS_PWM_ENABLE, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_ramp_rate, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SYS_PWM_RAMP_RATE, ix-1), \

I am curious, is this parameter really useful in practice?

> +	SENSOR_ATTR_2(pwm##ix##_auto_channels_temp, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SYS_PWM_AUTO_CHANNELS_TEMP, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point1_pwm, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SYS_PWM_AUTO_POINT1_PWM, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point2_pwm, S_IRUGO, \
> +		show_pwm, NULL, SYS_PWM_AUTO_POINT2_PWM, ix-1)
> +
> +#define SENSOR_ATTR_PWM_5TO6(ix) \
> +	SENSOR_ATTR_PWM(ix), \
> +	SENSOR_ATTR_2(pwm##ix##_enable, S_IRUGO, \
> +		show_pwm, NULL, SYS_PWM_ENABLE, ix-1)
> +
> +static struct sensor_device_attribute_2 dme1737_sysfs[] = {
> +	/* voltages */
> +	SENSOR_ATTR_IN(0),
> +	SENSOR_ATTR_IN(1),
> +	SENSOR_ATTR_IN(2),
> +	SENSOR_ATTR_IN(3),
> +	SENSOR_ATTR_IN(4),
> +	SENSOR_ATTR_IN(5),
> +	SENSOR_ATTR_IN(6),
> +	/* temperatures */
> +	SENSOR_ATTR_TEMP(1),
> +	SENSOR_ATTR_TEMP(2),
> +	SENSOR_ATTR_TEMP(3),
> +	/* fans */
> +	SENSOR_ATTR_FAN_1TO4(1),
> +	SENSOR_ATTR_FAN_1TO4(2),
> +	SENSOR_ATTR_FAN_1TO4(3),
> +	SENSOR_ATTR_FAN_1TO4(4),
> +	SENSOR_ATTR_FAN_5TO6(5),
> +	SENSOR_ATTR_FAN_5TO6(6),
> +	/* pwms */
> +	SENSOR_ATTR_PWM_1TO3(1),
> +	SENSOR_ATTR_PWM_1TO3(2),
> +	SENSOR_ATTR_PWM_1TO3(3),
> +	SENSOR_ATTR_PWM_5TO6(5),
> +	SENSOR_ATTR_PWM_5TO6(6),
> +};
> +
> +static struct device_attribute dme1737_sysfs_misc[] = {
> +	__ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm),
> +	__ATTR(cpu0_vid, S_IRUGO, show_vid, NULL),
> +	__ATTR(alarms, S_IRUGO, show_alarms, NULL),
> +};
> +
> +/* ---------------------------------------------------------------------
> + * Device detection, registration and initialization
> + * --------------------------------------------------------------------- */
> +
> +static struct i2c_driver dme1737_driver;
> +
> +static int dme1737_init_client(struct i2c_client *client)
> +{
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	int i;
> +	u8 reg;
> +
> +	/* force monitoring */
> +	if (force_start) {
> +		dme1737_write(client, DME1737_REG_CONFIG,
> +			dme1737_read(client, DME1737_REG_CONFIG) | 0x01);
> +	}
> +
> +	data->config = dme1737_read(client, DME1737_REG_CONFIG);
> +	/* inform if part is not monitoring/started */
> +	if (!(data->config & 0x01)) {
> +		dev_err(&client->dev, "Device is not monitoring. Use the "
> +			"force_start load parameter to override.\n");
> +		return -EFAULT;
> +	}

This construct is rather confusing. When force_start is set, you read
the configuration register twice, and you test a bit you just set
yourself. What about this instead:

	data->config = dme1737_read(client, DME1737_REG_CONFIG);
	/* inform if part is not monitoring/started */
	if (!(data->config & 0x01)) {
		if (!force_start) {
			dev_err(&client->dev, "Device is not monitoring. "
				"Use the force_start load parameter to "
				"override.\n");
			return -EFAULT;
		}

		/* force monitoring */
		data->config |= 0x01;
		dme1737_write(client, DME1737_REG_CONFIG, data->config);
	}

(Additionally data->config should be a local variable as noted earlier.)

> +
> +	/* inform if part is not ready or locked */
> +	if (!(data->config & 0x04)) {
> +		dev_err(&client->dev, "Device is not ready.\n");
> +		return -EFAULT;
> +	}
> +	if (data->config & 0x02) {
> +		dev_info(&client->dev, "Device is locked.\n");
> +	}

Shouldn't all sysfs files be switched to read-only in this case?

> +
> +	reg = dme1737_read(client, DME1737_REG_CONFIG2);
> +	/* inform if temp-to-zone mapping differs from the default */
> +	if (reg & 0x02) {
> +		dev_err(&client->dev, "Unsupported temp to zone mapping "
> +			"(temp1->zone1, temp3->zone2, temp3->zone3). Please "
> +			"report to the driver maintainer\n.");
> +		return -EFAULT;
> +	}
> +
> +	reg = dme1737_read(client, DME1737_REG_TACH_PWM);
> +	/* inform if fan-to-pwm mapping differs from the default */
> +	if (reg != 0xa4) {
> +		dev_err(&client->dev, "Unsupported fan to pwm mapping "
> +			"(fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
> +			"fan4->pwm%d). Please report to the driver "
> +			"maintainer.\n",
> +			(reg & 0x03) + 1, ((reg >> 4) & 0x03) + 1,
> +			((reg >> 8) & 0x03) + 1, ((reg >> 12) & 0x03) + 1);
> +		return -EFAULT;
> +	}

Why would this be a problem? I don't see where your driver is assuming
anything about this mapping. It might be a good thing to report the
mapping in the logs in any case, for the interested users. Or maybe we
need a new sysfs file for this...

> +
> +	/* enable the min PWM mode if it is currently disabled and set the
> +	 * min PWM value to 0 (which is identical to min PWM mode being
> +	 * disabled) */
> +        reg = dme1737_read(client, DME1737_REG_PWM_RR(0));

Bad indentation.

> +	for (i = 0; i < 3; i++) {
> +		if (!(reg & (1 << (i + 5)))) {
> +			dev_info(&client->dev, "Enabling PWM min mode for "
> +				 "pwm%d.\n", i + 1);
> +			reg |= (1 << (i + 5));
> +			dme1737_write(client, DME1737_REG_PWM_MIN(i), 0);
> +		}
> +	}
> +	dme1737_write(client, DME1737_REG_PWM_RR(0), reg);
> +
> +	/* initialize the default PWM auto temp channels (act) assignments */
> +	data->pwm_act[0] = 1;	/* pwm1 -> temp1 */
> +	data->pwm_act[1] = 2;	/* pwm2 -> temp2 */
> +	data->pwm_act[2] = 4;	/* pwm3 -> temp3 */
> +
> +	/* set VRM */
> +	data->vrm = vid_which_vrm();
> +
> +	return 0;
> +}
> +
> +static void dme1737_remove_files(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dme1737_sysfs); i++) {
> +		device_remove_file(dev, &dme1737_sysfs[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(dme1737_sysfs_misc); i++) {
> +		device_remove_file(dev, &dme1737_sysfs_misc[i]);
> +	}
> +}
> +
> +static int dme1737_detect(struct i2c_adapter *adapter, int address,
> +			  int kind)
> +{
> +	u8 company, verstep ;

Extra space.

> +	struct i2c_client *new_client = NULL;

Please rename this to just "client". You don't need to initialize it to
NULL, BTW.

> +	struct dme1737_data *data;
> +	int i, err = 0;
> +	const char *name;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		goto exit;
> +	}
> +
> +	/* For now, we assume we have a valid client. We now create the
> +	 * client structure, even though we cannot fill it completely yet. */

Meaningless legacy comment, please discard.

> +	if (!(data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	new_client = &data->client;
> +	i2c_set_clientdata(new_client, data);
> +	new_client->addr    = address;
> +	new_client->adapter = adapter;
> +	new_client->driver  = &dme1737_driver;
> +	new_client->flags   = 0;

No alignment here please. And flags is already set to 0 by kzalloc
above.

> +
> +	/* Now we do the real detection */
> +	company = dme1737_read(new_client, DME1737_REG_COMPANY);
> +	verstep = dme1737_read(new_client, DME1737_REG_VERSTEP);
> +
> +	if (!((company = DME1737_COMPANY_SMSC) &&
> +	      ((verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP))) {
> +		err = -ENODEV;
> +		goto exit_kfree;
> +	}

You could use a few more registers to make the detection more reliable,
as we did in sensors-detect.

Also, you should skip this detection step if kind >= 0 (user used a
force module parameter.)

> +
> +	kind = dme1737;
> +	name = "dme1737";
> +
> +	/* Fill in the remaining client fields and put it into the global 
> +	 * list */
> +	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> +	data->valid = 0;

This one too is already initialized by kzalloc.

> +	mutex_init(&data->update_lock);
> +
> +	/* Tell the I2C layer a new client has arrived */
> +	if ((err = i2c_attach_client(new_client))) {
> +		goto exit_kfree;
> +	}
> +
> +	/* Initialize the DME1737 chip */
> +	if ((err = dme1737_init_client(new_client))) {
> +		goto exit_detach;
> +	}
> +
> +	/* Create sysfs attributes */
> +	for (i = 0; i < ARRAY_SIZE(dme1737_sysfs); i++) {
> +		if ((err = device_create_file(&new_client->dev,
> +				&dme1737_sysfs[i].dev_attr))) {
> +			goto exit_remove;
> +		}
> +	}
> +	for (i = 0; i < ARRAY_SIZE(dme1737_sysfs_misc); i++) {
> +		if ((err = device_create_file(&new_client->dev,
> +				&dme1737_sysfs_misc[i]))) {
> +			goto exit_remove;
> +		}
> +	}

Why don't you use sysfs groups instead? sysfs_create_group() and
sysfs_remove_group() work well, and you can even put all the attributes
in one group.

> +
> +	/* Register device */
> +	data->class_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto exit_remove;
> +	}
> +
> +	dev_info(&adapter->dev, "Found a DME1737 chip at 0x%02x "
> +		 "(rev 0x%02x)\n", new_client->addr, verstep);
> +
> +	return 0;
> +
> +exit_remove:
> +	dme1737_remove_files(new_client);
> +exit_detach:
> +	i2c_detach_client(new_client);
> +exit_kfree:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int dme1737_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON)) {
> +		return 0;
> +	}
> +	return i2c_probe(adapter, &addr_data, dme1737_detect);
> +}
> +
> +static int dme1737_detach_client(struct i2c_client *client)
> +{
> +	struct dme1737_data *data = i2c_get_clientdata(client);
> +	int err;
> +
> +	hwmon_device_unregister(data->class_dev);
> +	dme1737_remove_files(client);
> +	if ((err = i2c_detach_client(client))) {
> +		return err;
> +	}
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct i2c_driver dme1737_driver = {
> +	.driver = {
> +		.name	= "dme1737",
> +	},
> +	.id		= I2C_DRIVERID_DME1737,

Not needed.

> +	.attach_adapter	= dme1737_attach_adapter,
> +	.detach_client	= dme1737_detach_client,
> +};
> +
> +static int __init dme1737_init(void)
> +{
> +	return i2c_add_driver(&dme1737_driver);
> +}
> +
> +static void __exit dme1737_exit(void)
> +{
> +	i2c_del_driver(&dme1737_driver);
> +}
> +
> +MODULE_AUTHOR("Juerg Haefliger <juergh@gmail.com>");
> +MODULE_DESCRIPTION("DME1737 sensors");
> +MODULE_LICENSE("GPL");
> +
> +module_init(dme1737_init);
> +module_exit(dme1737_exit);
> diff -uprN -X linux-2.6.21-rc1/Documentation/dontdiff -x MAINTAINERS -x Documentation linux-2.6.21-rc1.orig/drivers/hwmon/Kconfig linux-2.6.21-rc1/drivers/hwmon/Kconfig
> --- linux-2.6.21-rc1.orig/drivers/hwmon/Kconfig	2007-02-20 20:32:30.000000000 -0800
> +++ linux-2.6.21-rc1/drivers/hwmon/Kconfig	2007-02-22 12:05:08.000000000 -0800
> @@ -414,6 +414,18 @@ config SENSORS_SIS5595
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called sis5595.
>  
> +config SENSORS_DME1737
> +	tristate "SMSC DME1737 and compatibles"
> +	depends on HWMON && I2C && EXPERIMENTAL
> +	select HWMON_VID
> +	help
> +	  If you say yes here you get support for the hardware monitoring
> +	  and fan control features of the SMSC DME1737 and ASUS A8000
> +	  Super-I/O chips.

As far as I know, the SMSC SCH5027D is compatible as well. At least it
is listed as such on our Devices wiki page.

ASUS should be spelled Asus, it's not an acronym AFAIK.

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called dme1737.
> +
>  config SENSORS_SMSC47M1
>  	tristate "SMSC LPC47M10x and compatibles"
>  	depends on HWMON && I2C
> diff -uprN -X linux-2.6.21-rc1/Documentation/dontdiff -x MAINTAINERS -x Documentation linux-2.6.21-rc1.orig/drivers/hwmon/Makefile linux-2.6.21-rc1/drivers/hwmon/Makefile
> --- linux-2.6.21-rc1.orig/drivers/hwmon/Makefile	2007-02-20 20:32:30.000000000 -0800
> +++ linux-2.6.21-rc1/drivers/hwmon/Makefile	2007-02-22 14:19:14.000000000 -0800
> @@ -22,6 +22,7 @@ obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031
>  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
>  obj-$(CONFIG_SENSORS_AMS)	+= ams/
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
> +obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
>  obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
>  obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
>  obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
> diff -uprN -X linux-2.6.21-rc1/Documentation/dontdiff -x MAINTAINERS -x Documentation linux-2.6.21-rc1.orig/include/linux/i2c-id.h linux-2.6.21-rc1/include/linux/i2c-id.h
> --- linux-2.6.21-rc1.orig/include/linux/i2c-id.h	2007-02-20 20:32:30.000000000 -0800
> +++ linux-2.6.21-rc1/include/linux/i2c-id.h	2007-02-22 13:37:59.000000000 -0800
> @@ -159,6 +159,7 @@
>  #define I2C_DRIVERID_FSCHER 1046
>  #define I2C_DRIVERID_W83L785TS 1047
>  #define I2C_DRIVERID_OV7670 1048	/* Omnivision 7670 camera */
> +#define I2C_DRIVERID_DME1737 1049

You simply don't need this ID - they will all be removed soon anyway.
Leave it to 0 in the driver.

>  
>  /*
>   * ---- Adapter types ----------------------------------------------------

Nice driver overall, good job! Please provide an updated patch (or
incremental patch on top of this one, at your option) for upstream
inclusion.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
