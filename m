From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 22 Jan 2013 22:15:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments INA209
Message-Id: <20130122221530.GF386@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 22, 2013 at 01:43:48PM -0800, Ira W. Snyder wrote:
> On Mon, Jan 14, 2013 at 10:04:28PM -0800, Guenter Roeck wrote:
> > On Mon, Jan 14, 2013 at 01:17:04PM -0800, Ira W. Snyder wrote:
> > > On Sat, Jan 12, 2013 at 04:16:04PM -0800, Guenter Roeck wrote:
> > > > Add support for the TI / Burr-Brown INA209 voltage / current / power
> > > > monitor.
> > > > 
> > > > Cc: Paul Hays <haysp@magma.net>
> > > > Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Hi Guenter,
> > > 
> > > I didn't notice any issues with a quick review. Thanks for pushing the
> > > driver to mainline.
> > > 
> > Hi Ira,
> > 
> > you are welcome. I actually had the code in my queue for a long time;
> > I just found some time last weekend to finally test it.
> > 
> > It would be great if you can do some testing and send me a Tested-by and/or
> > Acked-by feedback.
> > 
> 
> Hi Guenter,
> 
> I finally got around to testing this today. The driver works great.
> Please add my:
> 
> Tested-by: Ira W. Snyder <iws@ovro.caltech.edu>
> 

One minor suggestion below. Sorry that I didn't catch it earlier.

Ira

> > Thanks,
> > Guenter
> > 
> > > Ira
> > > 
> > > > ---
> > > >  Documentation/hwmon/ina209 |   93 +++++++
> > > >  drivers/hwmon/Kconfig      |   10 +
> > > >  drivers/hwmon/Makefile     |    1 +
> > > >  drivers/hwmon/ina209.c     |  635 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 739 insertions(+)
> > > >  create mode 100644 Documentation/hwmon/ina209
> > > >  create mode 100644 drivers/hwmon/ina209.c
> > > > 
> > > > diff --git a/Documentation/hwmon/ina209 b/Documentation/hwmon/ina209
> > > > new file mode 100644
> > > > index 0000000..2e11bbc
> > > > --- /dev/null
> > > > +++ b/Documentation/hwmon/ina209
> > > > @@ -0,0 +1,93 @@
> > > > +Kernel driver ina209
> > > > +==========> > > > +
> > > > +Supported chips:
> > > > +  * Burr-Brown / Texas Instruments INA209
> > > > +    Prefix: 'ina209'
> > > > +    Addresses scanned: -
> > > > +    Datasheet:
> > > > +        http://www.ti.com/lit/gpn/ina209
> > > > +
> > > > +Author: Paul Hays <haysp@magma.net>
> > > > +Author: Ira W. Snyder <iws@ovro.caltech.edu>
> > > > +Author: Guenter Roeck <linux@roeck-us.net>
> > > > +
> > > > +
> > > > +Description
> > > > +-----------
> > > > +
> > > > +The TI / Burr-Brown INA209 monitors voltage, current, and power on the high side
> > > > +of a D.C. power supply. It can perform measurements and calculations in the
> > > > +background to supply readings at any time. It includes a programmable
> > > > +calibration multiplier to scale the displayed current and power values.
> > > > +
> > > > +
> > > > +Sysfs entries
> > > > +-------------
> > > > +
> > > > +The INA209 chip is highly configurable both via hardwiring and via
> > > > +the I2C bus. See the datasheet for details.
> > > > +
> > > > +This tries to expose most monitoring features of the hardware via
> > > > +sysfs. It does not support every feature of this chip.
> > > > +
> > > > +
> > > > +in0_input		shunt voltage (mV)
> > > > +in0_input_highest	shunt voltage historical maximum reading (mV)
> > > > +in0_input_lowest	shunt voltage historical minimum reading (mV)
> > > > +in0_reset_history	reset shunt voltage history
> > > > +in0_max			shunt voltage max alarm limit (mV)
> > > > +in0_min			shunt voltage min alarm limit (mV)
> > > > +in0_crit_max		shunt voltage crit max alarm limit (mV)
> > > > +in0_crit_min		shunt voltage crit min alarm limit (mV)
> > > > +in0_max_alarm		shunt voltage max alarm limit exceeded
> > > > +in0_min_alarm		shunt voltage min alarm limit exceeded
> > > > +in0_crit_max_alarm	shunt voltage crit max alarm limit exceeded
> > > > +in0_crit_min_alarm	shunt voltage crit min alarm limit exceeded
> > > > +
> > > > +in1_input		bus voltage (mV)
> > > > +in1_input_highest	bus voltage historical maximum reading (mV)
> > > > +in1_input_lowest	bus voltage historical minimum reading (mV)
> > > > +in1_reset_history	reset bus voltage history
> > > > +in1_max			bus voltage max alarm limit (mV)
> > > > +in1_min			bus voltage min alarm limit (mV)
> > > > +in1_crit_max		bus voltage crit max alarm limit (mV)
> > > > +in1_crit_min		bus voltage crit min alarm limit (mV)
> > > > +in1_max_alarm		bus voltage max alarm limit exceeded
> > > > +in1_min_alarm		bus voltage min alarm limit exceeded
> > > > +in1_crit_max_alarm	bus voltage crit max alarm limit exceeded
> > > > +in1_crit_min_alarm	bus voltage crit min alarm limit exceeded
> > > > +
> > > > +power1_input		power measurement (uW)
> > > > +power1_input_highest	power historical maximum reading (uW)
> > > > +power1_reset_history	reset power history
> > > > +power1_max		power max alarm limit (uW)
> > > > +power1_crit		power crit alarm limit (uW)
> > > > +power1_max_alarm	power max alarm limit exceeded
> > > > +power1_crit_alarm	power crit alarm limit exceeded
> > > > +
> > > > +curr1_input		current measurement (mA)
> > > > +
> > > > +update_interval		data conversion time; affects number of samples used
> > > > +			to average results for shunt and bus voltages.
> > > > +
> > > > +General Remarks
> > > > +---------------
> > > > +
> > > > +The power and current registers in this chip require that the calibration
> > > > +register is programmed correctly before they are used. Normally this is expected
> > > > +to be done in the BIOS. In the absence of BIOS programming, the shunt resistor
> > > > +voltage can be provided using platform data. The driver uses platform data from
> > > > +the ina2xx driver for this purpose. If calibration register data is not provided
> > > > +via platform data, the driver checks if the calibration register has been
> > > > +programmed (ie has a value not equal to zero). If so, this value is retained.
> > > > +Otherwise, a default value reflecting a shunt resistor value of 10 mOhm is
> > > > +programmed into the calibration register.
> > > > +
> > > > +
> > > > +Output Pins
> > > > +-----------
> > > > +
> > > > +Output pin programming is a board feature which depends on the BIOS. It is
> > > > +outside the scope of a hardware monitoring driver to enable or disable output
> > > > +pins.
> > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > index ef57572..5dacd58 100644
> > > > --- a/drivers/hwmon/Kconfig
> > > > +++ b/drivers/hwmon/Kconfig
> > > > @@ -1156,6 +1156,16 @@ config SENSORS_AMC6821
> > > >  	  This driver can also be build as a module.  If so, the module
> > > >  	  will be called amc6821.
> > > >  
> > > > +config SENSORS_INA209
> > > > +	tristate "TI / Burr Brown INA209"
> > > > +	depends on I2C
> > > > +	help
> > > > +	  If you say yes here you get support for the TI / Burr Brown INA209
> > > > +	  voltage / current / power monitor I2C interface.
> > > > +
> > > > +	  This driver can also be built as a module. If so, the module will
> > > > +	  be called ina209.
> > > > +
> > > >  config SENSORS_INA2XX
> > > >  	tristate "Texas Instruments INA219 and compatibles"
> > > >  	depends on I2C
> > > > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > > > index a37a82c..8d6d97e 100644
> > > > --- a/drivers/hwmon/Makefile
> > > > +++ b/drivers/hwmon/Makefile
> > > > @@ -65,6 +65,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
> > > >  obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
> > > >  obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
> > > >  obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
> > > > +obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
> > > >  obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
> > > >  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
> > > >  obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
> > > > diff --git a/drivers/hwmon/ina209.c b/drivers/hwmon/ina209.c
> > > > new file mode 100644
> > > > index 0000000..1070611
> > > > --- /dev/null
> > > > +++ b/drivers/hwmon/ina209.c
> > > > @@ -0,0 +1,635 @@
> > > > +/*
> > > > + * Driver for the Texas Instruments / Burr Brown INA209
> > > > + * Bidirectional Current/Power Monitor
> > > > + *
> > > > + * Copyright (C) 2012 Guenter Roeck <linux@roeck-us.net>
> > > > + *
> > > > + * Derived from Ira W. Snyder's original driver submission
> > > > + *	Copyright (C) 2008 Paul Hays <haysp@magma.ca>
> > > > + *	Copyright (C) 2008-2009 Ira W. Snyder <iws@ovro.caltech.edu>
> > > > + *
> > > > + * Aligned with ina2xx driver
> > > > + *	Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
> > > > + *	Thanks to Jan Volkering
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License as published by
> > > > + * the Free Software Foundation; version 2 of the License.
> > > > + *
> > > > + * Datasheet:
> > > > + * http://www.ti.com/lit/gpn/ina209
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/bug.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/hwmon.h>
> > > > +#include <linux/hwmon-sysfs.h>
> > > > +
> > > > +#include <linux/platform_data/ina2xx.h>
> > > > +
> > > > +/* register definitions */
> > > > +#define INA209_CONFIGURATION		0x00
> > > > +#define INA209_STATUS			0x01
> > > > +#define INA209_STATUS_MASK		0x02
> > > > +#define INA209_SHUNT_VOLTAGE		0x03
> > > > +#define INA209_BUS_VOLTAGE		0x04
> > > > +#define INA209_POWER			0x05
> > > > +#define INA209_CURRENT			0x06
> > > > +#define INA209_SHUNT_VOLTAGE_POS_PEAK	0x07
> > > > +#define INA209_SHUNT_VOLTAGE_NEG_PEAK	0x08
> > > > +#define INA209_BUS_VOLTAGE_MAX_PEAK	0x09
> > > > +#define INA209_BUS_VOLTAGE_MIN_PEAK	0x0a
> > > > +#define INA209_POWER_PEAK		0x0b
> > > > +#define INA209_SHUNT_VOLTAGE_POS_WARN	0x0c
> > > > +#define INA209_SHUNT_VOLTAGE_NEG_WARN	0x0d
> > > > +#define INA209_POWER_WARN		0x0e
> > > > +#define INA209_BUS_VOLTAGE_OVER_WARN	0x0f
> > > > +#define INA209_BUS_VOLTAGE_UNDER_WARN	0x10
> > > > +#define INA209_POWER_OVER_LIMIT		0x11
> > > > +#define INA209_BUS_VOLTAGE_OVER_LIMIT	0x12
> > > > +#define INA209_BUS_VOLTAGE_UNDER_LIMIT	0x13
> > > > +#define INA209_CRITICAL_DAC_POS		0x14
> > > > +#define INA209_CRITICAL_DAC_NEG		0x15
> > > > +#define INA209_CALIBRATION		0x16
> > > > +
> > > > +#define INA209_REGISTERS		0x17
> > > > +
> > > > +#define INA209_CONFIG_DEFAULT		0x3c47	/* PGA=8, full range */
> > > > +#define INA209_SHUNT_DEFAULT		10000	/* uOhm */
> > > > +
> > > > +struct ina209_data {
> > > > +	struct device *hwmon_dev;
> > > > +
> > > > +	struct mutex update_lock;
> > > > +	bool valid;
> > > > +	unsigned long last_updated;	/* in jiffies */
> > > > +
> > > > +	u16 regs[INA209_REGISTERS];	/* All chip registers */
> > > > +
> > > > +	u16 config_orig;		/* Original configuration */
> > > > +	u16 calibration_orig;		/* Original calibration */
> > > > +	u16 update_interval;
> > > > +};
> > > > +
> > > > +static struct ina209_data *ina209_update_device(struct device *dev)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct ina209_data *data = i2c_get_clientdata(client);
> > > > +	struct ina209_data *ret = data;
> > > > +	s32 val;
> > > > +	int i;
> > > > +
> > > > +	mutex_lock(&data->update_lock);
> > > > +
> > > > +	if (!data->valid ||
> > > > +	    time_after(jiffies, data->last_updated + data->update_interval)) {
> > > > +		for (i = 0; i < ARRAY_SIZE(data->regs); i++) {
> > > > +			val = i2c_smbus_read_word_swapped(client, i);
> > > > +			if (val < 0) {
> > > > +				ret = ERR_PTR(val);
> > > > +				goto abort;
> > > > +			}
> > > > +			data->regs[i] = val;
> > > > +		}
> > > > +		data->last_updated = jiffies;
> > > > +		data->valid = true;
> > > > +	}
> > > > +abort:
> > > > +	mutex_unlock(&data->update_lock);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Read a value from a device register and convert it to the
> > > > + * appropriate sysfs units
> > > > + */
> > > > +static long ina209_from_reg(const u8 reg, const u16 val)
> > > > +{
> > > > +	switch (reg) {
> > > > +	case INA209_SHUNT_VOLTAGE:
> > > > +	case INA209_SHUNT_VOLTAGE_POS_PEAK:
> > > > +	case INA209_SHUNT_VOLTAGE_NEG_PEAK:
> > > > +	case INA209_SHUNT_VOLTAGE_POS_WARN:
> > > > +	case INA209_SHUNT_VOLTAGE_NEG_WARN:
> > > > +		/* LSB uV. Convert to mV. */
> > > > +		return DIV_ROUND_CLOSEST(val, 100);
> > > > +
> > > > +	case INA209_BUS_VOLTAGE:
> > > > +	case INA209_BUS_VOLTAGE_MAX_PEAK:
> > > > +	case INA209_BUS_VOLTAGE_MIN_PEAK:
> > > > +	case INA209_BUS_VOLTAGE_OVER_WARN:
> > > > +	case INA209_BUS_VOLTAGE_UNDER_WARN:
> > > > +	case INA209_BUS_VOLTAGE_OVER_LIMIT:
> > > > +	case INA209_BUS_VOLTAGE_UNDER_LIMIT:
> > > > +		/* LSB=4 mV, last 3 bits unused */
> > > > +		return (val >> 3) * 4;
> > > > +
> > > > +	case INA209_CRITICAL_DAC_POS:
> > > > +		/* LSB=1 mV, in the upper 8 bits */
> > > > +		return val >> 8;
> > > > +
> > > > +	case INA209_CRITICAL_DAC_NEG:
> > > > +		/* LSB=1 mV, in the upper 8 bits */
> > > > +		return -1 * (val >> 8);
> > > > +
> > > > +	case INA209_POWER:
> > > > +	case INA209_POWER_PEAK:
> > > > +	case INA209_POWER_WARN:
> > > > +	case INA209_POWER_OVER_LIMIT:
> > > > +		/* LSB  mW. Convert to uW */
> > > > +		return val * 20 * 1000L;
> > > > +
> > > > +	case INA209_CURRENT:
> > > > +		/* LSB=1 mA (selected). Is in mA */
> > > > +		return val;
> > > > +	}
> > > > +
> > > > +	/* programmer goofed */
> > > > +	WARN_ON_ONCE(1);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Take a value and convert it to register format, clamping the value
> > > > + * to the appropriate range.
> > > > + */
> > > > +static int ina209_to_reg(u8 reg, u16 old, long val)
> > > > +{
> > > > +	switch (reg) {
> > > > +	case INA209_SHUNT_VOLTAGE_POS_WARN:
> > > > +	case INA209_SHUNT_VOLTAGE_NEG_WARN:
> > > > +		/* Limit to +- 320 mV, 10 uV LSB */
> > > > +		return clamp_val(val, -320, 320) * 100;
> > > > +
> > > > +	case INA209_BUS_VOLTAGE_OVER_WARN:
> > > > +	case INA209_BUS_VOLTAGE_UNDER_WARN:
> > > > +	case INA209_BUS_VOLTAGE_OVER_LIMIT:
> > > > +	case INA209_BUS_VOLTAGE_UNDER_LIMIT:
> > > > +		/*
> > > > +		 * Limit to 0-32000 mV, 4 mV LSB
> > > > +		 *
> > > > +		 * The last three bits aren't part of the value, but we'll
> > > > +		 * preserve them in their original state.
> > > > +		 */
> > > > +		return (DIV_ROUND_CLOSEST(clamp_val(val, 0, 32000), 4) << 3)
> > > > +		  | (old & 0x7);
> > > > +
> > > > +	case INA209_CRITICAL_DAC_NEG:
> > > > +		/*
> > > > +		 * Limit to -255-0 mV, 1 mV LSB
> > > > +		 * Convert the value to a positive value for the register
> > > > +		 *
> > > > +		 * The value lives in the top 8 bits only, be careful
> > > > +		 * and keep original value of other bits.
> > > > +		 */
> > > > +		return (clamp_val(-val, 0, 255) << 8) | (old & 0xff);
> > > > +
> > > > +	case INA209_CRITICAL_DAC_POS:
> > > > +		/*
> > > > +		 * Limit to 0-255 mV, 1 mV LSB
> > > > +		 *
> > > > +		 * The value lives in the top 8 bits only, be careful
> > > > +		 * and keep original value of other bits.
> > > > +		 */
> > > > +		return (clamp_val(val, 0, 255) << 8) | (old & 0xff);
> > > > +
> > > > +	case INA209_POWER_WARN:
> > > > +	case INA209_POWER_OVER_LIMIT:
> > > > +		/* 20 mW LSB */
> > > > +		return DIV_ROUND_CLOSEST(val, 20 * 1000);
> > > > +	}
> > > > +
> > > > +	/* Other registers are read-only, return access error */
> > > > +	return -EACCES;
> > > > +}
> > > > +
> > > > +static int ina209_interval_from_reg(u16 reg)
> > > > +{
> > > > +	return 68 >> (15 - ((reg >> 3) & 0x0f));
> > > > +}
> > > > +
> > > > +static u16 ina209_reg_from_interval(u16 config, long interval)
> > > > +{
> > > > +	int i, adc;
> > > > +
> > > > +	if (interval <= 0) {
> > > > +		adc = 8;
> > > > +	} else {
> > > > +		adc = 15;
> > > > +		for (i = 34 + 34 / 2; i; i >>= 1) {
> > > > +			if (i < interval)
> > > > +				break;
> > > > +			adc--;
> > > > +		}
> > > > +	}
> > > > +	return (config & 0xf807) | (adc << 3) | (adc << 7);
> > > > +}
> > > > +
> > > > +static ssize_t ina209_set_interval(struct device *dev,
> > > > +				   struct device_attribute *da,
> > > > +				   const char *buf, size_t count)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct ina209_data *data = ina209_update_device(dev);
> > > > +	long val;
> > > > +	u16 regval;
> > > > +	int ret;
> > > > +
> > > > +	if (IS_ERR(data))
> > > > +		return PTR_ERR(data);
> > > > +
> > > > +	ret = kstrtol(buf, 10, &val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	mutex_lock(&data->update_lock);
> > > > +	regval = ina209_reg_from_interval(data->regs[INA209_CONFIGURATION],
> > > > +					  val);
> > > > +	i2c_smbus_write_word_swapped(client, INA209_CONFIGURATION, regval);
> > > > +	data->regs[INA209_CONFIGURATION] = regval;
> > > > +	data->update_interval = ina209_interval_from_reg(regval);
> > > > +	mutex_unlock(&data->update_lock);
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static ssize_t ina209_show_interval(struct device *dev,
> > > > +				    struct device_attribute *da, char *buf)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct ina209_data *data = i2c_get_clientdata(client);
> > > > +
> > > > +	return snprintf(buf, PAGE_SIZE, "%d\n", data->update_interval);
> > > > +}
> > > > +
> > > > +/*
> > > > + * History is reset by writing 1 into bit 0 of the respective peak register.
> > > > + * Since more than one peak register may be affected by the scope of a
> > > > + * reset_history attribute write, use a bit mask in attr->index to identify
> > > > + * which registers are affected.
> > > > + */
> > > > +static u16 ina209_reset_history_regs[] = {
> > > > +	INA209_SHUNT_VOLTAGE_POS_PEAK,
> > > > +	INA209_SHUNT_VOLTAGE_NEG_PEAK,
> > > > +	INA209_BUS_VOLTAGE_MAX_PEAK,
> > > > +	INA209_BUS_VOLTAGE_MIN_PEAK,
> > > > +	INA209_POWER_PEAK
> > > > +};
> > > > +
> > > > +static ssize_t ina209_reset_history(struct device *dev,
> > > > +				    struct device_attribute *da,
> > > > +				    const char *buf,
> > > > +				    size_t count)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct ina209_data *data = i2c_get_clientdata(client);
> > > > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > > > +	u32 mask = attr->index;
> > > > +	long val;
> > > > +	int i, ret;
> > > > +
> > > > +	ret = kstrtol(buf, 10, &val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	mutex_lock(&data->update_lock);
> > > > +	for (i = 0; i < ARRAY_SIZE(ina209_reset_history_regs); i++) {
> > > > +		if (mask & (1 << i))
> > > > +			i2c_smbus_write_word_swapped(client,
> > > > +					ina209_reset_history_regs[i], 1);
> > > > +	}
> > > > +	data->valid = false;
> > > > +	mutex_unlock(&data->update_lock);
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static ssize_t ina209_set_value(struct device *dev,
> > > > +				struct device_attribute *da,
> > > > +				const char *buf,
> > > > +				size_t count)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct ina209_data *data = ina209_update_device(dev);
> > > > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > > > +	int reg = attr->index;
> > > > +	long val;
> > > > +	int ret;
> > > > +
> > > > +	if (IS_ERR(data))
> > > > +		return PTR_ERR(data);
> > > > +
> > > > +	ret = kstrtol(buf, 10, &val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	mutex_lock(&data->update_lock);
> > > > +	ret = ina209_to_reg(reg, data->regs[reg], val);
> > > > +	if (ret < 0) {
> > > > +		count = ret;
> > > > +		goto abort;
> > > > +	}
> > > > +	i2c_smbus_write_word_swapped(client, reg, ret);
> > > > +	data->regs[reg] = ret;
> > > > +abort:
> > > > +	mutex_unlock(&data->update_lock);
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static ssize_t ina209_show_value(struct device *dev,
> > > > +				 struct device_attribute *da,
> > > > +				 char *buf)
> > > > +{
> > > > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > > > +	struct ina209_data *data = ina209_update_device(dev);
> > > > +	long val;
> > > > +
> > > > +	if (IS_ERR(data))
> > > > +		return PTR_ERR(data);
> > > > +
> > > > +	val = ina209_from_reg(attr->index, data->regs[attr->index]);
> > > > +	return snprintf(buf, PAGE_SIZE, "%ld\n", val);
> > > > +}
> > > > +
> > > > +static ssize_t ina209_show_alarm(struct device *dev,
> > > > +				 struct device_attribute *da,
> > > > +				 char *buf)
> > > > +{
> > > > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > > > +	struct ina209_data *data = ina209_update_device(dev);
> > > > +	const unsigned int mask = attr->index;
> > > > +	u16 status;
> > > > +
> > > > +	if (IS_ERR(data))
> > > > +		return PTR_ERR(data);
> > > > +
> > > > +	status = data->regs[INA209_STATUS];
> > > > +
> > > > +	/*
> > > > +	 * All alarms are in the INA209_STATUS register. To avoid a long
> > > > +	 * switch statement, the mask is passed in attr->index
> > > > +	 */
> > > > +	return snprintf(buf, PAGE_SIZE, "%u\n", !!(status & mask));
> > > > +}
> > > > +
> > > > +/* Shunt voltage, history, limits, alarms */
> > > > +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_SHUNT_VOLTAGE);
> > > > +static SENSOR_DEVICE_ATTR(in0_input_highest, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_SHUNT_VOLTAGE_POS_PEAK);
> > > > +static SENSOR_DEVICE_ATTR(in0_input_lowest, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_SHUNT_VOLTAGE_NEG_PEAK);
> > > > +static SENSOR_DEVICE_ATTR(in0_reset_history, S_IWUSR, NULL,
> > > > +			  ina209_reset_history, (1 << 0) | (1 << 1));
> > > > +static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_SHUNT_VOLTAGE_POS_WARN);
> > > > +static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_SHUNT_VOLTAGE_NEG_WARN);
> > > > +static SENSOR_DEVICE_ATTR(in0_crit_max, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_CRITICAL_DAC_POS);
> > > > +static SENSOR_DEVICE_ATTR(in0_crit_min, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_CRITICAL_DAC_NEG);
> > > > +
> > > > +static SENSOR_DEVICE_ATTR(in0_min_alarm,  S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 11);
> > > > +static SENSOR_DEVICE_ATTR(in0_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 12);
> > > > +static SENSOR_DEVICE_ATTR(in0_crit_min_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 6);
> > > > +static SENSOR_DEVICE_ATTR(in0_crit_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 7);
> > > > +
> > > > +/* Bus voltage, history, limits, alarms */
> > > > +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_BUS_VOLTAGE);
> > > > +static SENSOR_DEVICE_ATTR(in1_input_highest, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_BUS_VOLTAGE_MAX_PEAK);
> > > > +static SENSOR_DEVICE_ATTR(in1_input_lowest, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_BUS_VOLTAGE_MIN_PEAK);
> > > > +static SENSOR_DEVICE_ATTR(in1_reset_history, S_IWUSR, NULL,
> > > > +			  ina209_reset_history, (1 << 2) | (1 << 3));
> > > > +static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_BUS_VOLTAGE_OVER_WARN);
> > > > +static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_BUS_VOLTAGE_UNDER_WARN);
> > > > +static SENSOR_DEVICE_ATTR(in1_crit_max, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_BUS_VOLTAGE_OVER_LIMIT);
> > > > +static SENSOR_DEVICE_ATTR(in1_crit_min, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_BUS_VOLTAGE_UNDER_LIMIT);
> > > > +
> > > > +static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 14);
> > > > +static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 15);
> > > > +static SENSOR_DEVICE_ATTR(in1_crit_min_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 9);
> > > > +static SENSOR_DEVICE_ATTR(in1_crit_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 10);
> > > > +
> > > > +/* Power */
> > > > +static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_POWER);
> > > > +static SENSOR_DEVICE_ATTR(power1_input_highest, S_IRUGO, ina209_show_value,
> > > > +			  NULL, INA209_POWER_PEAK);
> > > > +static SENSOR_DEVICE_ATTR(power1_reset_history, S_IWUSR, NULL,
> > > > +			  ina209_reset_history, 1 << 4);
> > > > +static SENSOR_DEVICE_ATTR(power1_max, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_POWER_WARN);
> > > > +static SENSOR_DEVICE_ATTR(power1_crit, S_IRUGO | S_IWUSR, ina209_show_value,
> > > > +			  ina209_set_value, INA209_POWER_OVER_LIMIT);
> > > > +
> > > > +static SENSOR_DEVICE_ATTR(power1_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 13);
> > > > +static SENSOR_DEVICE_ATTR(power1_crit_alarm, S_IRUGO, ina209_show_alarm, NULL,
> > > > +			  1 << 8);
> > > > +
> > > > +/* Current */
> > > > +static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina209_show_value, NULL,
> > > > +			  INA209_CURRENT);
> > > > +
> > > > +static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
> > > > +			  ina209_show_interval, ina209_set_interval, 0);
> > > > +
> > > > +/*
> > > > + * Finally, construct an array of pointers to members of the above objects,
> > > > + * as required for sysfs_create_group()
> > > > + */
> > > > +static struct attribute *ina209_attributes[] = {
> > > > +	&sensor_dev_attr_in0_input.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_input_highest.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_input_lowest.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_reset_history.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_max.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_min.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_crit_max.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_crit_min.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_max_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_min_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_crit_max_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_in0_crit_min_alarm.dev_attr.attr,
> > > > +
> > > > +	&sensor_dev_attr_in1_input.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_input_highest.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_input_lowest.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_reset_history.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_max.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_min.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_crit_max.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_crit_min.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_crit_max_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_in1_crit_min_alarm.dev_attr.attr,
> > > > +
> > > > +	&sensor_dev_attr_power1_input.dev_attr.attr,
> > > > +	&sensor_dev_attr_power1_input_highest.dev_attr.attr,
> > > > +	&sensor_dev_attr_power1_reset_history.dev_attr.attr,
> > > > +	&sensor_dev_attr_power1_max.dev_attr.attr,
> > > > +	&sensor_dev_attr_power1_crit.dev_attr.attr,
> > > > +	&sensor_dev_attr_power1_max_alarm.dev_attr.attr,
> > > > +	&sensor_dev_attr_power1_crit_alarm.dev_attr.attr,
> > > > +
> > > > +	&sensor_dev_attr_curr1_input.dev_attr.attr,
> > > > +
> > > > +	&sensor_dev_attr_update_interval.dev_attr.attr,
> > > > +
> > > > +	NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group ina209_group = {
> > > > +	.attrs = ina209_attributes,
> > > > +};
> > > > +
> > > > +static void ina209_restore_conf(struct i2c_client *client,
> > > > +				struct ina209_data *data)
> > > > +{
> > > > +	/* Restore initial configuration */
> > > > +	i2c_smbus_write_word_swapped(client, INA209_CONFIGURATION,
> > > > +				     data->config_orig);
> > > > +	i2c_smbus_write_word_swapped(client, INA209_CALIBRATION,
> > > > +				     data->calibration_orig);
> > > > +}
> > > > +
> > > > +static int ina290_init_client(struct i2c_client *client,
> > > > +			      struct ina209_data *data)
> > > > +{
> > > > +	struct ina2xx_platform_data *pdata;

If you do this instead, it shouldn't wrap, and will make
the code below easier to read, IMO.

struct ina2xx_platform_data *pdata = dev_get_platdata(&client->dev);

> > > > +	long shunt;
> > > > +	int reg;
> > > > +
> > > > +	reg = i2c_smbus_read_word_swapped(client, INA209_CALIBRATION);
> > > > +	if (reg < 0)
> > > > +		return reg;
> > > > +	data->calibration_orig = reg;
> > > > +
> > > > +	reg = i2c_smbus_read_word_swapped(client, INA209_CONFIGURATION);
> > > > +	if (reg < 0)
> > > > +		return reg;
> > > > +	data->config_orig = reg;
> > > > +
> > > > +	if (client->dev.platform_data) {
> > > > +		pdata > > > > +		  (struct ina2xx_platform_data *)client->dev.platform_data;
> > > > +		shunt = pdata->shunt_uohms;
> > > > +		if (shunt <= 0)
> > > > +			return -ENODEV;

Then this part becomes:

if (pdata) {
	shunt = pdata->shunt_uohms;
	if (shunt <= 0)
		return -ENODEV;

Also, devicetree (OpenFirmware) support would be nice. I like it much
more than platform data on supported architectures (such as PowerPC,
which is what I use). This code is untested, but I think it should work.

#ifdef CONFIG_OF
} else if (!of_property_read_u32(client->dev.of_node, "ina209,shunt", &shunt) {
	/* no code needed */
#endif

But if you don't like OF for some reason, leave it out. I can change my
bootloader to write the INA209 calibration register appropriately.

Thanks,
Ira

> > > > +
> > > > +	} else {
> > > > +		shunt = data->calibration_orig ?
> > > > +		  40960000 / data->calibration_orig : INA209_SHUNT_DEFAULT;
> > > > +	}
> > > > +
> > > > +	i2c_smbus_write_word_swapped(client, INA209_CONFIGURATION,
> > > > +				     INA209_CONFIG_DEFAULT);
> > > > +	data->update_interval = ina209_interval_from_reg(INA209_CONFIG_DEFAULT);
> > > > +
> > > > +	/*
> > > > +	 * Calibrate current LSB to 1mA. Shunt is in uOhms.
> > > > +	 * See equation 13 in datasheet.
> > > > +	 */
> > > > +	i2c_smbus_write_word_swapped(client, INA209_CALIBRATION,
> > > > +				     clamp_val(40960000 / shunt, 1, 65535));
> > > > +
> > > > +	/* Clear status register */
> > > > +	i2c_smbus_read_word_swapped(client, INA209_STATUS);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ina209_probe(struct i2c_client *client,
> > > > +			const struct i2c_device_id *id)
> > > > +{
> > > > +	struct i2c_adapter *adapter = client->adapter;
> > > > +	struct ina209_data *data;
> > > > +	int ret;
> > > > +
> > > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
> > > > +		return -ENODEV;
> > > > +
> > > > +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> > > > +	if (!data)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	i2c_set_clientdata(client, data);
> > > > +	mutex_init(&data->update_lock);
> > > > +
> > > > +	ret = ina290_init_client(client, data);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Register sysfs hooks */
> > > > +	ret = sysfs_create_group(&client->dev.kobj, &ina209_group);
> > > > +	if (ret)
> > > > +		goto out_restore_conf;
> > > > +
> > > > +	data->hwmon_dev = hwmon_device_register(&client->dev);
> > > > +	if (IS_ERR(data->hwmon_dev)) {
> > > > +		ret = PTR_ERR(data->hwmon_dev);
> > > > +		goto out_hwmon_device_register;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +
> > > > +out_hwmon_device_register:
> > > > +	sysfs_remove_group(&client->dev.kobj, &ina209_group);
> > > > +out_restore_conf:
> > > > +	ina209_restore_conf(client, data);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int ina209_remove(struct i2c_client *client)
> > > > +{
> > > > +	struct ina209_data *data = i2c_get_clientdata(client);
> > > > +
> > > > +	hwmon_device_unregister(data->hwmon_dev);
> > > > +	sysfs_remove_group(&client->dev.kobj, &ina209_group);
> > > > +	ina209_restore_conf(client, data);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id ina209_id[] = {
> > > > +	{ "ina209", 0 },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, ina209_id);
> > > > +
> > > > +/* This is the driver that will be inserted */
> > > > +static struct i2c_driver ina209_driver = {
> > > > +	.class		= I2C_CLASS_HWMON,
> > > > +	.driver = {
> > > > +		.name	= "ina209",
> > > > +	},
> > > > +	.probe		= ina209_probe,
> > > > +	.remove		= ina209_remove,
> > > > +	.id_table	= ina209_id,
> > > > +};
> > > > +
> > > > +module_i2c_driver(ina209_driver);
> > > > +
> > > > +MODULE_AUTHOR("Ira W. Snyder <iws@ovro.caltech.edu>, Guenter Roeck <linux@roeck-us.net>");
> > > > +MODULE_DESCRIPTION("INA209 driver");
> > > > +MODULE_LICENSE("GPL");
> > > > -- 
> > > > 1.7.9.7
> > > > 
> > > 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
