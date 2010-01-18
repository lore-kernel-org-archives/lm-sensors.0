From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jan 2010 13:35:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add driver for ADT7411
Message-Id: <20100118143522.4c288265@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1263817501-25333-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfram,

On Mon, 18 Jan 2010 13:25:01 +0100, Wolfram Sang wrote:
> Add initial support for the ADT7411. Reads out all conversion results (via I2C,
> SPI is still missing) and allows some on-the-fly configuration. Tested with a
> custom board.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> 
> I polished up an older driver from us. Hope I didn't overlook some issues...

Review:

> 
>  Documentation/hwmon/adt7411 |   43 +++++
>  drivers/hwmon/Kconfig       |   10 ++
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/adt7411.c     |  368 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 422 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/adt7411
>  create mode 100644 drivers/hwmon/adt7411.c
> 
> diff --git a/Documentation/hwmon/adt7411 b/Documentation/hwmon/adt7411
> new file mode 100644
> index 0000000..5eb7d1b
> --- /dev/null
> +++ b/Documentation/hwmon/adt7411
> @@ -0,0 +1,43 @@
> +Kernel driver adt7411
> +==========> +
> +Supported chips:
> +  * Analog Devices ADT7411
> +    Prefix: 'adt7411'
> +    Addresses scanned: none
> +    Datasheet: Publicly available at the Analog Devices website
> +
> +Author: Wolfram Sang (based on adt7470 by Darrick J. Wong)
> +
> +Description
> +-----------
> +
> +This driver implements support for the Analog Devices ADT7411 chip. There may
> +be other chips that implement this interface.
> +
> +The ADT7411 can use an I2C/SMBus compatible 2-wire interface or an
> +SPI-compatible 4-wire interface. It provides 10-bit analog to digital
> +converters which measure 1 temperature, vdd and 8 input voltages.

I think there is a single ADC physically, so I wouldn't use the plural.

Maybe you could mention that 2 of the voltage input pins can
alternatively be used to connect an external thermal sensor? Even if
the driver doesn't support that yet. You could also mention the high
and low limit registers, again even if the driver doesn't support them.
Support might be added later.

> +
> +Check the datasheet for details.
> +
> +sysfs-Interface
> +---------------
> +
> +in0_input	- vdd voltage input
> +in[1-8]_input	- analog 1-8 input
> +temp_input	- temperature input

This needs to be temp1_input, to comply with
Documentation/hwmon/sysfs-interface. Didn't you test your driver with
libsensors?

> +
> +Besides standard interfaces, this driver adds (0 = off, 1 = on):
> +
> +  adc_ref_vdd	- Use vdd as reference instead of 2.25 V
> +  fast_sampling	- Sample at 22.5 kHz instead of 1.4 kHz, but drop filters
> +  no_average	- Turn of averaging over 16 samples

Spelling: off.

> +
> +Notes
> +-----
> +
> +The chips latches msb-registers when reading lsb-registers. So, to always get
> +the correct values, the driver uses a lock to read a 10-bit value.
> +
> +SPI is not supported yet.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68cf877..6e7f559 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -170,6 +170,16 @@ config SENSORS_ADM9240
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm9240.
>  
> +config SENSORS_ADT7411
> +	tristate "Analog Devices ADT7411"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  ADT7411 voltage & temperature monitoring chip.

& -> and

> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called adt7411.
> +
>  config SENSORS_ADT7462
>  	tristate "Analog Devices ADT7462"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4bc215c..5fe67bf 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
>  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
>  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
> +obj-$(CONFIG_SENSORS_ADT7411)	+= adt7411.o
>  obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
>  obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
>  obj-$(CONFIG_SENSORS_ADT7473)	+= adt7473.o
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> new file mode 100644
> index 0000000..d90ae10
> --- /dev/null
> +++ b/drivers/hwmon/adt7411.c
> @@ -0,0 +1,368 @@
> +/*
> + *  adt7411.c
> + *
> + *  Driver for the ADT7411 (I2C/SPI 8 channel 10 bit ADC & temperature-sensor).
> + *
> + *  Copyright (C) 2008, 2010 Pengutronix
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  TODO: SPI, support for external temperature sensor
> + * 	  use power-down mode for suspend?, interrupt handling?
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon-sysfs.h>

You also need <linux/hwmon.h>.

> +#include <linux/mutex.h>
> +
> +#define ADT7411_REG_ISR1			0x0

I would recommend "0x00", and the same for all register until 0xf. This
is what most drivers, and the datasheet for this chip, do. It makes it
immediately visible that the register addresses are 8-bit values.

> +#define ADT7411_REG_ISR2			0x1
> +/* 0x2 reserved */

I don't think it makes a lot of sense to document nonexistent registers.

> +#define ADT7411_REG_INT_TEMP_VDD_LSB		0x3
> +#define ADT7411_REG_EXT_TEMP_AIN14_LSB		0x4
> +#define ADT7411_REG_AIN58_LSB			0x5
> +#define ADT7411_REG_VDD_MSB			0x6
> +#define ADT7411_REG_INT_TEMP_MSB		0x7
> +#define ADT7411_REG_EXT_TEMP_AIN1_MSB		0x8
> +#define ADT7411_REG_AIN2_MSB			0x9
> +#define ADT7411_REG_AIN3_MSB			0xa
> +#define ADT7411_REG_AIN4_MSB			0xb
> +#define ADT7411_REG_AIN5_MSB			0xc
> +#define ADT7411_REG_AIN6_MSB			0xd
> +#define ADT7411_REG_AIN7_MSB			0xe
> +#define ADT7411_REG_AIN8_MSB			0xf

This is crying to be an array or macro. As a matter of fact, you only
use ADT7411_REG_EXT_TEMP_AIN1_MSB in your code.

> +/* 0x10-0x17 reserved */
> +#define ADT7411_REG_CFG1			0x18
> +#define ADT7411_CFG1_START_MONITOR		(1 << 0)
> +/* if bit1=1 result is undefined */
> +#define ADT7411_CFG1_AIN12			(0 << 2)
> +#define ADT7411_CFG1_EXT_TEMP			(1 << 2)
> +#define ADT7411_CFG1_RESERVED1			(1 << 3)
> +#define ADT7411_CFG1_DISABLE_INT		(1 << 5)
> +#define ADT7411_CFG1_INT_ACT_HIGH		(1 << 6)
> +#define ADT7411_CFG1_POWER_DOWN			(1 << 7)
> +
> +#define ADT7411_REG_CFG2			0x19
> +#define ADT7411_CFG2_SELECT_CHANNEL(x)		((x) & 0xf)
> +#define ADT7411_CFG2_SINGLE_CHANNEL		(1 << 4)
> +#define ADT7411_CFG2_DISABLE_AVG		(1 << 5)
> +#define ADT7411_CFG2_ENABLE_SMBUS_TO		(1 << 6)
> +#define ADT7411_CFG2_RESET			(1 << 7)
> +
> +#define ADT7411_REG_CFG3			0x1a
> +#define ADT7411_CFG3_ADC_CLK_225		(1 << 0)
> +#define ADT7411_CFG3_RESERVED1			(1 << 3)
> +#define ADT7411_CFG3_REF_VDD			(1 << 4)
> +/* 0x1b-0x1c reserved */
> +#define ADT7411_REG_IMR1			0x1d
> +#define ADT7411_IMR1_INT_T_HIGH			(1 << 0)
> +#define ADT7411_IMR1_INT_T_LOW			(1 << 1)
> +#define ADT7411_IMR1_EXT_T_HIGH			(1 << 2)
> +#define ADT7411_IMR1_EXT_T_LOW			(1 << 3)
> +#define ADT7411_IMR1_EXT_FAULT			(1 << 4)
> +
> +#define ADT7411_REG_IMR2			0x1e
> +#define ADT7411_REG_INT_TEMP_OFFSET		0x1f
> +#define ADT7411_REG_EXT_TEMP_OFFSET		0x20
> +/* 0x21-0x22 reserved */
> +#define ADT7411_REG_VDD_HI_LIMIT		0x23
> +#define ADT7411_REG_VDD_LO_LIMIT		0x24
> +#define ADT7411_REG_INT_TEMP_HI_LIMIT		0x25
> +#define ADT7411_REG_INT_TEMP_LO_LIMIT		0x26
> +#define ADT7411_REG_EXT_TEMP_AIN1_HI_LIMIT	0x27
> +#define ADT7411_REG_EXT_TEMP_AIN1_LO_LIMIT	0x28
> +/* 0x29-0x2a reserved */
> +#define ADT7411_REG_AIN2_HI_LIMIT		0x2b
> +#define ADT7411_REG_AIN2_LO_LIMIT		0x2c
> +#define ADT7411_REG_AIN3_HI_LIMIT		0x2d
> +#define ADT7411_REG_AIN3_LO_LIMIT		0x2e
> +#define ADT7411_REG_AIN4_HI_LIMIT		0x2f
> +#define ADT7411_REG_AIN4_LO_LIMIT		0x30
> +#define ADT7411_REG_AIN5_HI_LIMIT		0x31
> +#define ADT7411_REG_AIN5_LO_LIMIT		0x32
> +#define ADT7411_REG_AIN6_HI_LIMIT		0x33
> +#define ADT7411_REG_AIN6_LO_LIMIT		0x34
> +#define ADT7411_REG_AIN7_HI_LIMIT		0x35
> +#define ADT7411_REG_AIN7_LO_LIMIT		0x36
> +#define ADT7411_REG_AIN8_HI_LIMIT		0x37
> +#define ADT7411_REG_AIN8_LO_LIMIT		0x38
> +/* 0x39-0x4c reserved */
> +#define ADT7411_REG_DEVICE_ID			0x4d
> +#define ADT7411_REG_MANUFACTURE_ID		0x4e
> +#define ADT7411_REG_SILICON_REVISION		0x4f
> +/* 0x50-0x7e reserved */
> +#define ADT7411_SPI_LOCK_STATUS			0x7f
> +/* 0x80-0xff reserved */

It seems to me that you are only using a small subset of the registers
defined above. I suggest not defining registers you don't use, as it
only makes the code bigger with no benefit. The datasheet of this chip
is publicly available, if anybody needs a reference.

> +
> +#define ADT7411_DEVICE_ID			0x2
> +#define ADT7411_MANUFACTURE_ID			0x41

That would rather be named ADT7411_MANUFACTURER_ID.

> +
> +struct adt7411_data {
> +	struct mutex lsb_msb_lock;	/* Protects the lsb/msb-get sequence */
> +	u8 config[3];
> +};
> +
> +/*
> + * When reading a register containing (up to 4) lsb, all associated
> + * msb-registers get locked by the hardware. After _one_ of those msb is read,
> + * _all_ are unlocked. In order to use this locking correctly, reading lsb/msb
> + * is protected here with a mutex, too.
> + */
> +static int adt7411_read_10_bit(struct i2c_client *client, u8 lsb_reg,
> +				u8 msb_reg, u8 lsb_shift)
> +{
> +	struct adt7411_data *data = i2c_get_clientdata(client);
> +	int lsbtries, msbtries;
> +	int ret, val;
> +
> +	mutex_lock(&data->lsb_msb_lock);
> +
> +	msbtries = 3;
> +	do {
> +		lsbtries = 3;
> +		do {
> +			ret = i2c_smbus_read_byte_data(client, lsb_reg);
> +		} while (ret < 0 && --lsbtries);
> +
> +		if (ret < 0)
> +			goto exit_unlock;
> +
> +		val = (ret >> lsb_shift) & 3;
> +
> +		ret = i2c_smbus_read_byte_data(client, msb_reg);
> +
> +		/*
> +		 * when reading the MSB failed, restart with LSB,
> +		 * because the LSB-locking state is unknown

I think you mean MSB-locking.

> +		 */
> +
> +	} while (ret < 0 && --msbtries);
> +
> +	if (ret >= 0)
> +		ret = val | (ret << 2);
> +
> + exit_unlock:
> +	mutex_unlock(&data->lsb_msb_lock);
> +
> +	return ret;
> +}

Logic seems overly complex. Do you have such an unreliable I2C bus that
transient failures are frequent?

> +
> +static ssize_t adt7411_show_vdd(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int val = adt7411_read_10_bit(client, ADT7411_REG_INT_TEMP_VDD_LSB,
> +			ADT7411_REG_VDD_MSB, 2);
> +	if (val < 0)
> +		return val;
> +
> +	return sprintf(buf, "%u\n", val * 7000 / 1024);
> +
> +}
> +static ssize_t adt7411_show_temp(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int val = adt7411_read_10_bit(client, ADT7411_REG_INT_TEMP_VDD_LSB,
> +			ADT7411_REG_INT_TEMP_MSB, 0);
> +	if (val < 0)
> +		return val;
> +
> +	val = val & 512 ? val - 1024 : val; /* 10 bit signed */

Hexadecimal constants would be easier to understand IMHO.

> +
> +	return sprintf(buf, "%d\n", val * 250);
> +}
> +
> +static ssize_t adt7411_show_input(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7411_data *data = i2c_get_clientdata(client);
> +	int v_ref, val;
> +	u8 lsb_reg = ADT7411_REG_EXT_TEMP_AIN14_LSB + (nr >> 2);
> +	u8 lsb_shift = (nr & 0x03) << 1;

"2 * (nr & 0x03)" would be easier to understand.

> +
> +	val = adt7411_read_10_bit(client, lsb_reg,
> +			ADT7411_REG_EXT_TEMP_AIN1_MSB + nr, lsb_shift);
> +	if (val < 0)
> +		return val;
> +
> +	if (data->config[2] & ADT7411_CFG3_REF_VDD) {
> +		v_ref = adt7411_read_10_bit(client, ADT7411_REG_INT_TEMP_VDD_LSB,
> +			ADT7411_REG_VDD_MSB, 2) * 7000 / 1024;

This is very costly when reading all voltage values at once (as
"sensors" would do). I would cache the value of v_ref for a second or
so. It isn't supposed to change anyway.

> +	} else {
> +		v_ref = 2250;
> +	}
> +	return sprintf(buf, "%u\n", val * v_ref / 1024);
> +}
> +
> +static ssize_t adt7411_show_bit(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7411_data *data = i2c_get_clientdata(client);
> +
> +	return sprintf(buf, "%u\n", !!(data->config[attr2->index] & attr2->nr));
> +}
> +
> +static ssize_t adt7411_set_bit(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute_2 *s_attr2 = to_sensor_dev_attr_2(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7411_data *data = i2c_get_clientdata(client);
> +	int reg, bit, ret;
> +	unsigned long val;
> +
> +	ret = strict_strtoul(buf, 0, &val);
> +
> +	if (ret || val > 1)
> +		return -EINVAL;
> +
> +	reg = s_attr2->index;
> +	bit = s_attr2->nr;
> +
> +	if (val)
> +		data->config[reg] |= bit;
> +	else
> +		data->config[reg] &= ~bit;
> +
> +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1 + reg,
> +		data->config[reg]);
> +	return count;
> +}

This assumes that nobody else ever changes the configuration registers.
That's an unsafe assumption... Not only external users of the chip
could (think multi-master I2C setups) but even concurrent users of your
own driver could! So you want to read the register value instead of
relying on a cached value. And if you want to keep a cache (which
doesn't seem terribly needed to me),you also want to protect the
read-modify-write operation with a mutex.

> +
> +#define ADT7411_BIT_ATTR(__name, __reg, __bit) \
> +	SENSOR_DEVICE_ATTR_2(__name, S_IRUGO | S_IWUSR, adt7411_show_bit, \
> +	adt7411_set_bit, __bit, __reg - ADT7411_REG_CFG1)
> +
> +static DEVICE_ATTR(temp_input, S_IRUGO, adt7411_show_temp, NULL);
> +static DEVICE_ATTR(in0_input, S_IRUGO, adt7411_show_vdd, NULL);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, adt7411_show_input, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, adt7411_show_input, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, adt7411_show_input, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, adt7411_show_input, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, adt7411_show_input, NULL, 4);
> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, adt7411_show_input, NULL, 5);
> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, adt7411_show_input, NULL, 6);
> +static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, adt7411_show_input, NULL, 7);
> +static ADT7411_BIT_ATTR(no_average, ADT7411_REG_CFG2, ADT7411_CFG2_DISABLE_AVG);
> +static ADT7411_BIT_ATTR(adc_ref_vdd, ADT7411_REG_CFG3, ADT7411_CFG3_REF_VDD);
> +static ADT7411_BIT_ATTR(fast_sampling, ADT7411_REG_CFG3, ADT7411_CFG3_ADC_CLK_225);
> +
> +static struct attribute *adt7411_attrs[] = {
> +	&dev_attr_temp_input.attr,
> +	&dev_attr_in0_input.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_in8_input.dev_attr.attr,
> +	&sensor_dev_attr_no_average.dev_attr.attr,
> +	&sensor_dev_attr_adc_ref_vdd.dev_attr.attr,
> +	&sensor_dev_attr_fast_sampling.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group adt7411_attr_grp = {

Please make this const.

> +	.attrs = adt7411_attrs,
> +};
> +
> +static int __devinit adt7411_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	int val;
> +	struct adt7411_data *data;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	val = i2c_smbus_read_byte_data(client, ADT7411_REG_MANUFACTURE_ID);
> +	if (val < 0 || val != ADT7411_MANUFACTURE_ID) {
> +		dev_err(&client->dev, "Wrong manufacturer ID. Got %d, "
> +			"expected %d\n", val, ADT7411_MANUFACTURE_ID);
> +		return -ENODEV;
> +	}
> +
> +	val = i2c_smbus_read_byte_data(client, ADT7411_REG_DEVICE_ID);
> +	if (val < 0 || val != ADT7411_DEVICE_ID) {
> +		dev_err(&client->dev, "Wrong device ID. Got %d, "
> +			"expected %d\n", val, ADT7411_DEVICE_ID);
> +		return -ENODEV;
> +	}

This is the wrong place for this check. Device identification goes into
a .detect() function. By the time .probe() is called, you already know
what device is there.

> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lsb_msb_lock);
> +
> +	data->config[0] = ADT7411_CFG1_START_MONITOR | ADT7411_CFG1_RESERVED1;
> +	data->config[1] = ADT7411_CFG2_ENABLE_SMBUS_TO;
> +	data->config[2] = ADT7411_CFG3_RESERVED1 | ADT7411_CFG3_REF_VDD;
> +
> +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG2, ADT7411_CFG2_RESET);
> +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG2, data->config[1]);
> +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG3, data->config[2]);
> +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1, data->config[0]);

This is bad practice. The BIOS/firmware might have setup the chip
already. Resetting and then overwriting this configuration is bad. If
you want to enforce a specific setup, this is a platform decision and
you should provide the initialization data as platform data.

> +
> +	i2c_set_clientdata(client, data);
> +	dev_info(&client->dev, "detected\n");

This is cheap. Either print a more verbose and useful message (that is,
include the chip name, configuration information etc. or don't print
anything.

> +	return sysfs_create_group(&client->dev.kobj, &adt7411_attr_grp);

Error handling is wrong. If this function fails then the allocated
memory is never freed.

You also forgot to call hwmon_device_register(dev), which makes your
driver essentially useless for anyone using standard (libsensors-based)
monitoring tools.

> +}
> +
> +static int __devexit adt7411_remove(struct i2c_client *client)
> +{
> +	struct adt7411_data *data = i2c_get_clientdata(client);
> +
> +	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
> +
> +	/* Stop measuring and go to power down mode */
> +	i2c_smbus_write_byte_data(client, ADT7411_REG_CFG1,
> +		ADT7411_CFG1_POWER_DOWN | ADT7411_CFG1_RESERVED1);

Not necessarily a good idea. The device might be responsible for
thermal management of the system, and it may have been setup before
your driver was loaded. If you want to do something when the driver is
removed, that would be restoring the state of the chip to what it was
when you found it.

> +
> +	kfree(data);

Please call i2c_set_clientdata(client, NULL) first, we don't want to
leave dangling pointers behind.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id adt7411_id[] = {
> +	{ "adt7411", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver adt7411_driver = {
> +	.driver		= {
> +		.name		= "adt7411",
> +	},
> +	.probe  = adt7411_probe,
> +	.remove	= __devexit_p(adt7411_remove),
> +	.id_table = adt7411_id,
> +};
> +
> +static int __init sensors_adt7411_init(void)
> +{
> +	return i2c_add_driver(&adt7411_driver);
> +}
> +module_init(sensors_adt7411_init)
> +
> +static void __exit sensors_adt7411_exit(void)
> +{
> +	i2c_del_driver(&adt7411_driver);
> +}
> +module_exit(sensors_adt7411_exit)
> +
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de> and "
> +	"Wolfram Sang <w.sang@pengutronix.de>");
> +MODULE_DESCRIPTION("ADT7411 driver");
> +MODULE_LICENSE("GPL v2");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
