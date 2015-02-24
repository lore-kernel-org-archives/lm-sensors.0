From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 17:56:18 +0000
Subject: Re: [lm-sensors] [PATCH] Add Nuvoton NCT7904 hwmon driver
Message-Id: <20150224175618.GA13000@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424794188.8163.13.camel@vvlasov.dev.rtsoft.ru>
In-Reply-To: <1424794188.8163.13.camel@vvlasov.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 24, 2015 at 07:09:48PM +0300, Vadim V. Vlasov wrote:
> Tested on Kontron COMe-cSE6 board
> 
> Signed-off-by: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>

Hi Vadim,

Unfortunately, your patch is corrupted.

Please run the patch through checkpatch --strict (that also tells
you where it is corrupted) and fix what it complains about.
Additional (preliminary) review comments below.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/nct7904.c | 551
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 562 insertions(+)
>  create mode 100644 drivers/hwmon/nct7904.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 110fade..d0d5988 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1145,6 +1145,16 @@ config SENSORS_NCT7802
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called nct7802.
>  
> +config SENSORS_NCT7904
> +	tristate "Nuvoton NCT7904"
> +	depends on X86 && I2C
> +	help
> +	  If you say yes here you get support for the Nuvoton NCT7904
> +	  hardware monitoring chip, including manual fan speed control.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called nct7904.
> +
>  config SENSORS_PCF8591
>  	tristate "Philips PCF8591 ADC/DAC"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 6c94147..b4a40f1 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -120,6 +120,7 @@ obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) +> menf21bmc_hwmon.o
>  obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
>  obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>  obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
> +obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
>  obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> new file mode 100644
> index 0000000..84e524b
> --- /dev/null
> +++ b/drivers/hwmon/nct7904.c
> @@ -0,0 +1,551 @@
> +/*
> + * nct7904.c - driver for Nuvoton NCT7904D.
> + *
> + * Copyright (c) 2015 Kontron
> + * Author: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +
> +#define VENDOR_ID_REG		0x7A	/* Any bank */
> +#define NUVOTON_ID		0x50
> +#define CHIP_ID_REG		0x7B	/* Any bank */
> +#define NCT7904_ID		0xC5
> +#define VERSION_ID_REG		0x7C	/* Any bank */
> +
> +#define BANK_SEL_REG		0xFF
> +#define BANK_0			0x00
> +#define BANK_1			0x01
> +#define BANK_2			0x02
> +#define BANK_3			0x03
> +#define BANK_4			0x04
> +#define BANK_MAX		0x04
> +
> +#define FANIN_MAX		12	/* Counted from 1 */
> +#define VSEN_MAX		21	/* VSEN1..14, 3VDD, VBAT, V3VSB,
> +					   LTD (not a voltage), VSEN17..19 */
> +#define FANCTL_MAX		4	/* Counted from 1 */
> +#define TCPU_MAX		8	/* Counted from 1 */
> +#define TEMP_MAX		4	/* Counted from 1 */
> +
> +#define VT_ADC_CTRL0_REG	0x20	/* Bank 0 */
> +#define VT_ADC_CTRL1_REG	0x21	/* Bank 0 */
> +#define VT_ADC_CTRL2_REG	0x22	/* Bank 0 */
> +#define FANIN_CTRL0_REG		0x24
> +#define FANIN_CTRL1_REG		0x25
> +#define DTS_T_CTRL0_REG		0x26
> +#define DTS_T_CTRL1_REG		0x27
> +#define VT_ADC_MD_REG		0x2E
> +
> +#define VSEN1_HV_REG		0x40	/* Bank 0; 2 regs (HV/LV) per sensor */
> +#define TEMP_CH1_HV_REG		0x42	/* Bank 0; same as VSEN2_HV */
> +#define FANIN1_HV_REG		0x80	/* Bank 0; 2 regs (HV/LV) per sensor */
> +#define T_CPU1_HV_REG		0xA0	/* Bank 0; 2 regs (HV/LV) per sensor */
> +
> +#define PRTS_REG		0x03	/* Bank 2 */
> +#define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
> +#define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
> +
> +
> +const unsigned short normal_i2c[] = {
> +	0x2d, 0x2e, I2C_CLIENT_END
> +};
> +
> +
> +struct nct7904_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +	struct mutex lock;
> +	int bank_sel;
> +};
> +
> +/*
> + * Implemented features:
> + * - Fan inputs (rpm)
> + * - Voltage sensors (mV)
> + * - DTS/TSI and local temperature sensors (degree Celsius)
> + * - Fan PWM control
> + * - Setting Fan to manual mode
> + *
> + * Not implemented features:
> + * - SmartFan control
> + * - Watchdog
> + * - GPIO
> + * - external temperature sensors
> + * - SMI
> + * - min/max values
> + * - many other...
> + */
> +
> +/* Access functions */
> +/* Read 1-byte register. Returns unsigned reg or -ERRNO on error. */
> +static int nct7904_read_reg(struct nct7904_data *data,
> +	unsigned bank, unsigned reg)

In practice you never access a register without its page.
Consider merging <bank, register> into a 16-bit value
and decode it here.

This way a register define would automatically include the page,
which in turn would reduce the risk of accicdentially accessing
a register from the wrong page.

> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	if (bank > BANK_MAX || reg > 255)
> +		return -EINVAL;

Unnecessary check. You should trust your code. If the code is buggy, fix it.
Besides, it does not (and can not) validate that you are accsssing register on
the correct page, which is much more likely to be wrong.

> +	mutex_lock(&data->lock);
> +	if (data->bank_sel != bank) {
> +		ret = i2c_smbus_write_byte_data(client, BANK_SEL_REG, bank);
> +		if (ret < 0) {
> +			data->bank_sel = -1;
> +			goto out;
> +		}
> +		data->bank_sel = bank;
> +	}

Please factor out the function to select the bank; the code is
implemented three times.

> +	ret = i2c_smbus_read_byte_data(client, reg);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/* Read 2-byte register into the buffer. Returns 0 or -ERRNO on error.
> */
> +static int nct7904_read_reg16(struct nct7904_data *data,
> +	unsigned bank, unsigned reg, u8 *buf)

Please return the value itself as int, combined with the error code.
Given the oddity of high/low value calculation, consider adding the
number of valid bits (ie 3 or 11 for an 11-bit register, whatever
you prefer) as parameter.

> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	if (bank > BANK_MAX || reg > 254)
> +		return -EINVAL;

Same as above.

> +	buf[0] = buf[1] = 0;
> +
> +	mutex_lock(&data->lock);
> +	if (data->bank_sel != bank) {
> +		ret = i2c_smbus_write_byte_data(client, BANK_SEL_REG, bank);
> +		if (ret < 0) {
> +			data->bank_sel = -1;
> +			goto out;
> +		}
> +		data->bank_sel = bank;
> +	}
> +	ret = i2c_smbus_read_byte_data(client, reg);
> +	if (ret >= 0) {
> +		buf[0] = ret;
> +		ret = i2c_smbus_read_byte_data(client, reg + 1);
> +		if (ret >= 0) {
> +			buf[1] = ret;
> +			ret = 0;
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/* Write 1-byte register. Returns 0 or -ERRNO on error. */
> +static int nct7904_write_reg(struct nct7904_data *data,
> +	unsigned bank, unsigned reg, u8 val)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	if (bank > BANK_MAX || reg > 255)
> +		return -EINVAL;

Same as above.

> +	mutex_lock(&data->lock);
> +	if (data->bank_sel != bank) {
> +		ret = i2c_smbus_write_byte_data(client, BANK_SEL_REG, bank);
> +		if (ret < 0) {
> +			data->bank_sel = -1;
> +			goto out;
> +		}
> +		data->bank_sel = bank;
> +	}
> +	ret = i2c_smbus_write_byte_data(client, reg, val);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/* FANIN ATTR */
> +static ssize_t
> +show_fan(struct device *dev,
> +	struct device_attribute *devattr, char *buf)

You are quite inconsistent with multi-line function declarations.
Above you use

static int func()

Please be consistent.

> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	u8 regs[2];
> +	unsigned cnt, rpm;
> +
> +	ret = nct7904_read_reg16(data, BANK_0, FANIN1_HV_REG + index * 2,
> regs);
> +	if (ret < 0)
> +		return ret;
> +	cnt = (regs[0] << 5) | (regs[1] & 0x1f);
> +	if (cnt = 0x1fff)
> +		rpm = 0;
> +	else
> +		rpm = 1350000 / cnt;
> +	return sprintf(buf, "%d\n", rpm);

rpm is unsigned. %u.

> +}
> +
> +#define FANIN_ATTR(i)	\
> +	SENSOR_ATTR(fan##i##_input, S_IRUGO, show_fan, NULL, i - 1)
> +
Please just add SENSOR_ATTR() below.

> +static struct sensor_device_attribute nct7904_fanin_attrs[] = {
> +	FANIN_ATTR(1),
> +	FANIN_ATTR(2),
> +	FANIN_ATTR(3),
> +	FANIN_ATTR(4),
> +	FANIN_ATTR(5),
> +	FANIN_ATTR(6),
> +	FANIN_ATTR(7),
> +	FANIN_ATTR(8),
> +	FANIN_ATTR(9),
> +	FANIN_ATTR(10),
> +	FANIN_ATTR(11),
> +	FANIN_ATTR(12),
> +};
> +
> +
> +/* VSEN ATTR */
> +static ssize_t
> +show_voltage(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	u8 regs[2];
> +	s8 t_hi;
> +	unsigned cnt;
> +	int volt;
> +
> +	ret = nct7904_read_reg16(data, BANK_0, VSEN1_HV_REG + index * 2,
> regs);
> +	if (ret < 0)
> +		return ret;
> +	cnt = (regs[0] << 3) | (regs[1] & 0x7);
> +	if (index < 14)
> +		volt = cnt * 2; /* 0.002V scale */
> +	else if (index = 17) {
> +		/* not a voltage but local temp (signed) */
> +		t_hi = regs[0];
> +		volt = ((t_hi << 3) | (regs[1] & 0x7)) * 125;

This should be a separate function. It doesn't make sense
to have it here just because it is in the same group of
registers.

> +	} else
> +		volt = cnt * 6; /* 0.006V scale */
> +
> +	return sprintf(buf, "%d\n", volt);
> +}
> +
> +#define VSEN_ATTR(i)	\
> +	SENSOR_ATTR(in##i##_input, S_IRUGO, show_voltage, NULL, i - 1)
> +
> +#define VSEN_ATTR_NAME(name, i)	\
> +	SENSOR_ATTR(name##_input, S_IRUGO, show_voltage, NULL, i - 1)
> +
Please open code all sensors declarations.

> +static struct sensor_device_attribute nct7904_vsen_attrs[] = {
> +	VSEN_ATTR(1),
> +	VSEN_ATTR(2),
> +	VSEN_ATTR(3),
> +	VSEN_ATTR(4),
> +	VSEN_ATTR(5),
> +	VSEN_ATTR(6),
> +	VSEN_ATTR(7),
> +	VSEN_ATTR(8),
> +	VSEN_ATTR(9),
> +	VSEN_ATTR(10),
> +	VSEN_ATTR(11),
> +	VSEN_ATTR(12),
> +	VSEN_ATTR(13),
> +	VSEN_ATTR(14),
> +	VSEN_ATTR(15),			/* 3VDD */
> +	VSEN_ATTR(16),			/* VBAT */
> +	VSEN_ATTR_NAME(in20, 17),	/* 3VSB */
> +	VSEN_ATTR_NAME(temp1, 18),	/* local temp */
> +	VSEN_ATTR_NAME(in17, 19),
> +	VSEN_ATTR_NAME(in18, 20),
> +	VSEN_ATTR_NAME(in19, 21),

Why the odd order ? I assume it has to do with the bit order in one
of the configuration registers, but you should explain that.

> +};
> +
> +/* CPU_TEMP ATTR */
> +static ssize_t
> +show_tcpu(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	s8 regs[2]; /* Signed! */

yes, but only one of the two registers, so this is a bit awkward.

If you have nct7904_read_reg16 return a 16-bit value, which would be unsigned,
you can use sign_extend32() to convert the result to a signed value.

> +	int temp;
> +
> +	ret = nct7904_read_reg16(data, BANK_0, T_CPU1_HV_REG + index * 2,
> regs);

Here is one corruption.

> +	if (ret < 0)
> +		return ret;
> +	temp = ((regs[0] << 3) | (regs[1] & 0x7)) * 125;
> +	return sprintf(buf, "%d\n", temp);
> +}
> +
> +/* "temp1_input" reserved for local temp */
> +#define T_CPU_ATTR(i)	\
> +	SENSOR_ATTR(temp##i##_input, S_IRUGO, show_tcpu, NULL, i - 2)
> +
> +static struct sensor_device_attribute nct7904_tcpu_attrs[] = {
> +	T_CPU_ATTR(2),
> +	T_CPU_ATTR(3),
> +	T_CPU_ATTR(4),
> +	T_CPU_ATTR(5),
> +	T_CPU_ATTR(6),
> +	T_CPU_ATTR(7),
> +	T_CPU_ATTR(8),
> +	T_CPU_ATTR(9),
> +};
> +
> +/************************PWM
> ATTR******************************************/
> +static ssize_t
> +store_pwm(struct device *dev,
> +	  struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val) < 0)
> +		return -EINVAL;
> +	if (val > 255)
> +		return -EINVAL;
> +
> +	ret = nct7904_write_reg(data, BANK_3, FANCTL1_OUT_REG + index, val);
> +
> +	return ret ? ret : count;
> +}
> +
> +static ssize_t
> +show_pwm(struct device *dev, struct device_attribute *devattr, char
> *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int val;
> +
> +	val = nct7904_read_reg(data, BANK_3, FANCTL1_OUT_REG + index);
> +	if (val < 0)
> +		return val;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t
> +store_mode(struct device *dev,
> +	  struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &val) < 0)
> +		return -EINVAL;
> +	switch (val) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 8:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = nct7904_write_reg(data, BANK_3, FANCTL1_FMR_REG + index, val);
> +
This is really combining two configurations into one, the fan control mode
(manual or automatic), and its association with a temperature source
as selected in bank 3 registers 0x09..0x0c. If you want to be able
to configure that, it will need to be two separate attributes, one for the
mode and one for the temperature source.

Configuring automatic mode without also providing the means to configure
registers 0x09..0x0c doesn't really make much sense.

> +	return ret ? ret : count;
> +}
> +
> +static ssize_t
> +show_mode(struct device *dev, struct device_attribute *devattr, char
> *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int val;
> +
> +	val = nct7904_read_reg(data, BANK_3, FANCTL1_FMR_REG + index);
> +	if (val < 0)
> +		return val;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +#define FANCTL_ATTRS(index)	\
> +	SENSOR_ATTR(fan##index##_pwm, S_IRUGO | S_IWUSR,	\
> +		show_pwm, store_pwm, index - 1),		\
> +	SENSOR_ATTR(fan##index##_mode, S_IRUGO | S_IWUSR,	\
> +		show_mode, store_mode, index - 1)
> +
> +/* 2 attributes per channel: pwm and mode */
> +static struct sensor_device_attribute nct7904_fanctl_attrs[] = {
> +	FANCTL_ATTRS(1),
> +	FANCTL_ATTRS(2),
> +	FANCTL_ATTRS(3),
> +	FANCTL_ATTRS(4),
> +};
> +
> +
> +static struct attribute *nct7904_attrs
> +	[FANIN_MAX + VSEN_MAX + 2*FANCTL_MAX + TCPU_MAX + TEMP_MAX + 1];
> +ATTRIBUTE_GROUPS(nct7904);
> +
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int
> +nct7904_detect(struct i2c_client *client, struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE)
> +	    && !i2c_check_functionality(adapter,
> +					I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> +		return -ENODEV;

You only need to call i2c_check_functionality once, with
	I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
as parameter.

> +
> +	/* Determine the chip type. */
> +	if (!(i2c_smbus_read_byte_data(client, VENDOR_ID_REG) = NUVOTON_ID)
> +	    || !(i2c_smbus_read_byte_data(client, CHIP_ID_REG) = NCT7904_ID))
> +		return -ENODEV;
> +
Please also check the upper 4 bit of the device ID register (named as
VERSION_ID_REG in your code), and that the upper 5 bit of the bank select
register are 0, to improve detection accuracy.

> +	strlcpy(info->type, "nct7904", I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static int
> +nct7904_probe(struct i2c_client *client, const struct i2c_device_id
> *id)
> +{
> +	struct nct7904_data *data;
> +	int ret;
> +	int i, j;
> +	u32 mask;
> +	u8 buf[2];
> +
> +	data = devm_kzalloc(&client->dev,
> +			sizeof(struct nct7904_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	mutex_init(&data->lock);
> +	data->bank_sel = -1;
> +	i2c_set_clientdata(client, data);

You don't read data from clientdata, so you don't need to save it there.

> +
> +	/* Setup attributes. (TODO: skip unused sensors) */

Is this still TODO ?

> +	/* FANIN attributes */
> +	ret = nct7904_read_reg16(data, BANK_0, FANIN_CTRL0_REG, buf);
> +	if (ret)
> +		goto err1;

Unnecessary goto.

> +	mask = buf[0] | (buf[1] << 8);
> +
> +	for (i = 0, j = 0; j < FANIN_MAX; j++) {
> +		if (mask & (1 << j))
> +			nct7904_attrs[i++] > +				&nct7904_fanin_attrs[j].dev_attr.attr;
> +	}
> +
> +	/* VSEN attributes */
> +	mask = 0;
> +	ret = nct7904_read_reg16(data, BANK_0, VT_ADC_CTRL0_REG, buf);
> +	if (ret = 0)
> +		mask = buf[0] | (buf[1] << 8);
> +	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
> +	if (ret >= 0)
> +		mask |= (ret << 16);
> +	for (j = 0; j < VSEN_MAX; j++) {
> +		if (mask & (1 << j))
> +			nct7904_attrs[i++] > +				&nct7904_vsen_attrs[j].dev_attr.attr;
> +	}

Please use is_visible() to determine if a sensor is configured or not,
and use the commonly used means to declare the list of sensors.
You might consider using separate groups for the different sensor types
to simplify that task.

> +
> +	/* CPU_TEMP attributes */
> +	ret = nct7904_read_reg16(data, BANK_0, DTS_T_CTRL0_REG, buf);
> +	if (ret)
> +		goto err1;

Unnecessary goto. Just return ret.

> +	mask = (buf[0] & 0xf) | (buf[1] << 4);
> +	for (j = 0; j < TCPU_MAX; j++) {
> +		if (mask & (1 << j))
> +			nct7904_attrs[i++] > +				&nct7904_tcpu_attrs[j].dev_attr.attr;
> +	}
> +
> +	/* Fan control */
> +	for (j = 0; j < FANCTL_MAX; j++) {
> +		nct7904_attrs[i++] = &nct7904_fanctl_attrs[2*j].dev_attr.attr;
> +		nct7904_attrs[i++] = &nct7904_fanctl_attrs[2*j+1].dev_attr.attr;
> +	}
> +
> +	data->hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +				client->name, data, nct7904_groups);

Storing this information in struct nct7904_data is unnecessary.
Please keep hwmon_dev local.

> +	if (IS_ERR(data->hwmon_dev)) {
> +		ret = PTR_ERR(data->hwmon_dev);
> +		goto err1;

This goto is unnecessary.

> +	}
> +
> +	dev_info(&client->dev, "NCT7904 chip version 0x%x\n",
> +		 nct7904_read_reg(data, 0, VERSION_ID_REG));

This is really the device ID register, and the version number is in
the lower 4 bits.

Either case, please consider removing this message. Ultimately it is
just noise and irrelevant for the user. Then you can just return
PTR_ERR_OR_ZERO(hwmon_dev), as many other drivers do.

> +
> +	return 0;
> +
> +err1:
> +	return ret;
> +}
> +
> +static int
> +nct7904_remove(struct i2c_client *client)
> +{
> +	return 0;
> +}

This function does not do anything and therefore is not necessary.

> +
> +
> +static const struct i2c_device_id nct7904_id[] = {
> +	{"nct7904", 0},
> +	{}
> +};
> +
> +static struct i2c_driver nct7904_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "nct7904",
> +	},
> +	.probe = nct7904_probe,
> +	.remove = nct7904_remove,
> +	.id_table = nct7904_id,
> +	.detect = nct7904_detect,
> +	.address_list = normal_i2c,
> +};
> +
> +static int __init
> +nct7904_init(void)
> +{
> +	return i2c_add_driver(&nct7904_driver);
> +}
> +
> +static void __exit
> +nct7904_exit(void)
> +{
> +	i2c_del_driver(&nct7904_driver);
> +}
> +
> +module_init(nct7904_init);
> +module_exit(nct7904_exit);
> +

Please use module_i2c_driver().

> +MODULE_AUTHOR("Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>");
> +MODULE_DESCRIPTION("Hwmon driver for NUVOTON NCT7904");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.3
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
