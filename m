From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Mar 2007 20:10:06 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070315211006.1de981b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

On Tue, 13 Mar 2007 14:25:10 +0100, Hans-J?rgen Koch wrote:
> Here it is: The driver creates only standard sysfs files now. I left the 
> module insmod parameters in place, though. This allows users to initialize 
> ALL registers if their BIOS doesn't do so. I hope you do not object.

Well, if the same can be achieved in a standard way using the sysfs
files, I don't quite see the point. It adds to confusion more than it
helps, given that they don't follow the same conventions. And it makes
the driver bigger at that. So please get rid of mode and counttime.

About module parameters: please don't initialize them to -1 if you
don't need to. The compiler can optimize static globals which default
to zero nicely.

> sysfs files follow the specification as close as possible. I used 
> pwm1_enable=3 for "fan off". There is no other possibility to switch the fan 
> off, setting pwm1_enable to 1 and fan1_target to 0 doesn't turn it off 
> completely.

I don't understand. For one thing, if you know how to turn the fan off,
then you could do it when fan1_target is set to 0, it's just a matter
of adding a few more lines of code. For another, fan1_target is related
to the closed loop mode (pwm1_enable=2) while the fan off mode would
generally be implemented as part of the open loop mode: pwm1_enable=1
and pwm1=0. But I see that you don't have a pwm1 file, so... How does
the open loop mode work at all?

> You mentioned problems compiling my code. Sorry, I can't reproduce this here. 
> It compiles without any warnings. If you still notice problems, please tell 
> me.

The problem is still there, and I explained why. Quoting myself:

> > I guess you didn't try with debug enabled...

The driver compiles fine with CONFIG_HWMON_DEBUG_CHIP=n, but fails to
compile with CONFIG_HWMON_DEBUG_CHIP=y. Try it yourself. It's probably
trivial to fix, too.

I see that you still did not fix the problems Corentin Labbe reported
after his second review [1]. Please do. When someone takes the time to
review your code - and it's not exactly a fun job - the least you can
do is take his/her findings into account for the next iteration of the
driver.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019017.html

Code review:

> Index: linux-2.6.20-cpx/Documentation/hwmon/max6650
> =================================> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.20-cpx/Documentation/hwmon/max6650	2007-03-13 12:46:07.000000000 +0100
> ...)
> +voltage_12V: 0=5V fan, 1V fan, -1=don't change

This is no longer true as you changed the convention.

> Index: linux-2.6.20-cpx/drivers/hwmon/max6650.c
> =================================> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.20-cpx/drivers/hwmon/max6650.c	2007-03-13 12:36:44.000000000 +0100
> @@ -0,0 +1,746 @@
> +/*
> + * max6650.c - Part of lm_sensors, Linux kernel modules for hardware
> + *             monitoring.
> + *
> + * Author: John Morris <john.morris at spirentcom.com>
> + * Copyright (c) 2003 Spirent Communications
> + *
> + * This module has only been tested with the MAX6650 chip. It should
> + * also work with the MAX6651, though with reduced functionality. It
> + * does not distinguish max6650 and max6651 chips.
> + *
> + * Tha datasheet was last seen at:
> + *
> + *        http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
> + *
> + * Ported to Linux 2.6 by Claus Gindhart <claus.gindhart at kontron.com>
> + * Modifications (C)2007 by Hans J. Koch <hjk at linutronix.de>:
> + *   - added insmod parameters
> + *   - made sysfs interface compatible with hwmon specifications
> + *   - general cleanup
> + *   - updated documentation
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
> +#include <linux/err.h>
> +
> +/*
> + * Addresses to scan. There are four disjoint possibilities, by pin config.
> + */
> +
> +static unsigned short normal_i2c[] = {0x1b, 0x1f, 0x48, 0x4b, I2C_CLIENT_END};
> +
> +/*
> + * Insmod parameters
> + */
> +
> +/* fan_voltage: 5=5V fan, 12V fan, -1=don't change */
> +static int fan_voltage = -1;
> +/* prescaler: Possible values are 1,2,4,8,16, or -1 for don't change */
> +static int prescaler = -1;
> +/* clock: The clock frequency of the chip the driver should assume */
> +static int clock = 254000;
> +/* mode: 0=on, 1=off, 2=closed loop, 3=open loop, -1=don't change */
> +static int mode = -1;
> +/* counttime: 0=0.25s, 1=0.5s, 2=1.0s, 3=2.0s, -1=don't change */
> +static int counttime = -1;
> +
> +module_param(fan_voltage, int, S_IRUGO);
> +module_param(prescaler, int, S_IRUGO);
> +module_param(clock, int, S_IRUGO);
> +module_param(mode, int, S_IRUGO);
> +module_param(counttime, int, S_IRUGO);
> +
> +I2C_CLIENT_INSMOD_1(max6650);
> +
> +/*
> + * MAX 6650/6651 registers
> + */
> +
> +#define MAX6650_REG_SPEED       0x00
> +#define MAX6650_REG_CONFIG      0x02
> +#define MAX6650_REG_GPIO_DEF    0x04
> +#define MAX6650_REG_DAC         0x06
> +#define MAX6650_REG_ALARM_EN    0x08
> +#define MAX6650_REG_ALARM       0x0A
> +#define MAX6650_REG_TACH0       0x0C
> +#define MAX6650_REG_TACH1       0x0E
> +#define MAX6650_REG_TACH2       0x10
> +#define MAX6650_REG_TACH3       0x12
> +#define MAX6650_REG_GPIO_STAT   0x14
> +#define MAX6650_REG_COUNT       0x16
> +
> +/*
> + * Config register bits
> + */
> +
> +#define MAX6650_CFG_V12           	0x08
> +#define MAX6650_CFG_PRESCALER_MASK	0x07
> +#define MAX6650_CFG_PRESCALER_2		0x01
> +#define MAX6650_CFG_PRESCALER_4		0x02
> +#define MAX6650_CFG_PRESCALER_8		0x03
> +#define MAX6650_CFG_PRESCALER_16	0x04
> +#define MAX6650_CFG_MODE_MASK           0x30
> +#define MAX6650_CFG_MODE_ON             0x00
> +#define MAX6650_CFG_MODE_OFF            0x10
> +#define MAX6650_CFG_MODE_CLOSED_LOOP    0x20
> +#define MAX6650_CFG_MODE_OPEN_LOOP      0x30
> +#define MAX6650_COUNT_MASK		0x03
> +
> +/* Minimum and maximum values of the FAN-RPM */
> +#define FAN_RPM_MIN 240
> +#define FAN_RPM_MAX 30000
> +
> +#define DIV_FROM_REG(reg) (1 << (reg & 7))
> +
> +static int max6650_attach_adapter(struct i2c_adapter *adapter);
> +static int max6650_detect(struct i2c_adapter *adapter, int address, int kind);
> +static int max6650_init_client(struct i2c_client *client);
> +static int max6650_detach_client(struct i2c_client *client);
> +static struct max6650_data *max6650_update_device(struct device *dev);
> +
> +/*
> + * Driver data (common to all clients)
> + */
> +
> +static struct i2c_driver max6650_driver = {
> +	.driver = {
> +		.name	= "max6650",
> +	},
> +	.attach_adapter = max6650_attach_adapter,
> +	.detach_client  = max6650_detach_client

Please add a comma at the end of this line.

> +};
> +
> +/*
> + * Client data (each client gets its own)
> + */
> +
> +struct max6650_data
> +{
> +	struct i2c_client client;
> +	struct class_device *class_dev;
> +	struct mutex update_lock;
> +	char valid; /* zero until following fields are valid */
> +	unsigned long last_updated; /* in jiffies */
> +
> +	/* register values */
> +	u8 speed;
> +	u8 config;
> +	u8 tach[4];
> +	u8 count;
> +};
> +
> +static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
> +		       char *buf, int nr)
> +{
> +	struct max6650_data *data = max6650_update_device(dev);
> +
> +	/*
> +	* Calculation details:
> +	*
> +	* Each tachometer counts over an interval given by the "count"
> +	* register (0.25, 0.5, 1 or 2 seconds). This module assumes
> +	* that the fans produce two pulses per revolution (this seems
> +	* to be the most common).
> +	*/
> +
> +	int rpm = ((data->tach[nr] * 120) / DIV_FROM_REG(data->count));
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
> +static ssize_t get_fan1(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	return get_fan(dev,devattr,buf,0);
> +}
> +
> +static ssize_t get_fan2(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	return get_fan(dev,devattr,buf,1);
> +}
> +
> +static ssize_t get_fan3(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	return get_fan(dev,devattr,buf,2);
> +}
> +
> +static ssize_t get_fan4(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	return get_fan(dev,devattr,buf,3);
> +}
> +
> +/*
> + * Set the fan speed to the specified RPM (or read back the RPM setting).
> + *
> + * The MAX6650/1 will automatically control fan speed when in closed loop
> + * mode.
> + *
> + * Assumptions:
> + *
> + * 1) The MAX6650/1 is running from its internal 254kHz clock (perhaps
> + *    this should be made a module parameter).

Well, it is now.

> + *
> + * 2) The prescaler (low three bits of the config register) has already
> + *    been set to an appropriate value.
> + *
> + * The relevant equations are given on pages 21 and 22 of the datasheet.
> + *
> + * From the datasheet, the relevant equation when in regulation is:
> + *
> + *    [fCLK / (128 x (KTACH + 1))] = 2 x FanSpeed / KSCALE
> + *
> + * where:
> + *
> + *    fCLK is the oscillator frequency (either the 254kHz internal
> + *         oscillator or the externally applied clock)
> + *
> + *    KTACH is the value in the speed register
> + *
> + *    FanSpeed is the speed of the fan in rps
> + *
> + *    KSCALE is the prescaler value (1, 2, 4, 8, or 16)
> + *
> + * When reading, we need to solve for FanSpeed. When writing, we need to
> + * solve for KTACH.
> + *
> + * Note: this tachometer is completely separate from the tachometers
> + * used to measure the fan speeds. Only one fan's speed (fan1) is
> + * controlled.
> + */
> +
> +static ssize_t get_target(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	struct max6650_data *data = max6650_update_device(dev);
> +	int kscale, ktach, rpm;
> +
> +	/*
> +	* Use the datasheet equation:
> +	*
> +	*    FanSpeed = KSCALE x fCLK / [256 x (KTACH + 1)]
> +	*
> +	* then multiply by 60 to give rpm.
> +	*/
> +
> +	kscale = DIV_FROM_REG(data->config);
> +	ktach  = data->speed;
> +	rpm    = 60 * kscale * clock / (256 * (ktach + 1));
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
> +static ssize_t set_target(struct device *dev, struct device_attribute *devattr,
> +			 const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max6650_data *data = i2c_get_clientdata(client);
> +	int rpm = simple_strtoul(buf, NULL, 10);
> +	int kscale, ktach;
> +
> +	dev_dbg(dev, "%s called, rpm=%d\n", __FUNCTION__, rpm);

I read lately that the standard notation is __func__ not __FUNCTION.
Not that this debug line looks particularly interesting anyway.

> +
> +	mutex_lock(&data->update_lock);
> +
> +	rpm = SENSORS_LIMIT(rpm, FAN_RPM_MIN, FAN_RPM_MAX);

You don't need to hold the lock for this instruction.

> +
> +	/*
> +	* Divide the required speed by 60 to get from rpm to rps, then
> +	* use the datasheet equation:
> +	*
> +	*     KTACH = [(fCLK x KSCALE) / (256 x FanSpeed)] - 1
> +	*/
> +
> +	kscale = DIV_FROM_REG(data->config);
> +	ktach  = ((clock * kscale) / (256 * rpm / 60)) - 1;
> +	if (ktach < 0)
> +		ktach = 0;
> +	if (ktach > 255)
> +		ktach = 255;
> +	data->speed  = ktach;

Doubled space.

> +
> +	i2c_smbus_write_byte_data(client, MAX6650_REG_SPEED,  data->speed);

Doubled space.

> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/*
> + * Get/Set controller mode:
> + * Possible values:
> + * 0 = Fan always full on
> + * 1 = Open loop, Voltage is set according to speed, not regulated.
> + * 2 = Closed loop, RPM for all fans regulated by fan1 tachometer
> + * 3 = Fan always off
> + */
> +
> +static ssize_t get_enable(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max6650_data *data = i2c_get_clientdata(client);

You are supposed to call the update function here, otherwise
data->config may not be valid.

> +	int mode = (data->config & MAX6650_CFG_MODE_MASK) >> 4;
> +
> +	switch (mode) {
> +	case 1:
> +		mode = 3;
> +		break;
> +	case 3:
> +		mode = 1;
> +	}
> +
> +	return sprintf(buf, "%d\n", mode);
> +}
> +
> +static ssize_t set_enable(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max6650_data *data = i2c_get_clientdata(client);
> +	int mode = simple_strtoul(buf, NULL, 10);
> +
> +	if ((mode < 0)||(mode > 3))
> +		return count;
> +
> +	switch (mode) {
> +	case 1:
> +		mode = 3;
> +		break;
> +	case 3:
> +		mode = 1;
> +	}
> +
> +	data->config = (  (data->config & ~MAX6650_CFG_MODE_MASK)
> +			| (mode << 4) );
> +
> +	i2c_smbus_write_byte_data(client, MAX6650_REG_CONFIG, data->config);

You shouldn't touch data->config without holding data->update_lock.
Also, you should read the value of MAX6650_REG_CONFIG from the device
before changing it, as you are not writing all the bits.

> +
> +	return count;
> +}
> +
> +/*
> + * Read/write functions for fan1_div sysfs file. The MAX6650 has no such
> + * divider. We handle this by converting between divider and counttime:
> + *
> + * (counttime = k) <=> (divider = 2^k), k = 0, 1, 2, or 3
> + *
> + * Lower values of k allow to connect a faster fan without the risk of
> + * counter overflow. The price is lower resolution. You can also set counttime
> + * using the module parameter. Note that the module parameter "prescaler" also
> + * influences the behaviour. Unfortunately, there's no sysfs attribute
> + * defined for that. See the data sheet for details.
> + */
> +
> +static ssize_t get_div(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max6650_data *data = i2c_get_clientdata(client);

Here again you forgot to call the update function.

> +
> +	return sprintf(buf, "%d\n", 1 << data->count);

Why don't you use DIV_FROM_REG?

> +}
> +
> +static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max6650_data *data = i2c_get_clientdata(client);
> +	int div = simple_strtoul(buf, NULL, 10);
> +
> +	switch (div) {
> +	case 1:
> +		data->count = 0;
> +		break;
> +	case 2:
> +		data->count = 1;
> +		break;
> +	case 4:
> +		data->count = 2;
> +		break;
> +	case 8:
> +		data->count = 3;
> +		break;
> +	default:
> +		return count;

This returns with success, while you were not able to set the divider
the user requested! Better return an error (-EINVAL) possibly with a
message in the logs.

> +	}
> +
> +	i2c_smbus_write_byte_data(client, MAX6650_REG_COUNT, data->count);

Again the while section should be protected by taking the
data->update_lock mutex.

> +	return count;
> +}
> +
> +static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan1, NULL);
> +static DEVICE_ATTR(fan2_input, S_IRUGO, get_fan2, NULL);
> +static DEVICE_ATTR(fan3_input, S_IRUGO, get_fan3, NULL);
> +static DEVICE_ATTR(fan4_input, S_IRUGO, get_fan4, NULL);
> +static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO, get_target, set_target);
> +static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_enable, set_enable);
> +static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_div, set_div);
> +
> +static struct attribute *max6650_attrs[] = {
> +	&dev_attr_fan1_input.attr,
> +	&dev_attr_fan2_input.attr,
> +	&dev_attr_fan3_input.attr,
> +	&dev_attr_fan4_input.attr,
> +	&dev_attr_fan1_target.attr,
> +	&dev_attr_pwm1_enable.attr,
> +	&dev_attr_fan1_div.attr,
> +	NULL,

No comma at the end of this one - it cannot be extended by definition.

> +};
> +
> +static struct attribute_group max6650_attr_grp = {
> +	.attrs = max6650_attrs,
> +};
> +
> +/*
> + * Real code
> + */
> +
> +static int max6650_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	dev_dbg(adapter->dev, "max6650_attach_adapter called for %s\n",
> +		(char*)&adapter->name);

This is bogus.

> +
> +	if (!(adapter->class & I2C_CLASS_HWMON)) {
> +		dev_dbg(adapter->dev,
> +			"FATAL: max6650_attach_adapter class HWMON not set\n");
> +		return 0;
> +	}
> +
> +	return i2c_probe(adapter, &addr_data, max6650_detect);
> +}
> +
> +/*
> + * The following function does more than just detection. If detection
> + * succeeds, it also registers the new chip.
> + */
> +
> +static int max6650_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	struct i2c_client *new_client;

Please rename this to just "client". I know many other drivers do that,
but it sucks. It's pretty obvious that the client is new.

> +	struct max6650_data *data;
> +	int err = -ENODEV;
> +	const char *name = "";
> +
> +	dev_dbg(adapter->dev, "max6650_detect called, kind = %d\n",kind);

Missing space after comma.

> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_dbg(adapter->dev, "MAX6650: I2C bus doesn't support byte"

Missing space at the end of the first part of the string.

> +			"read mode, skipping.\n");
> +		return 0;
> +	}
> +
> +	if (!(data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL))) {
> +		printk("MAX6650: Out of memory in max6650_detect "

Please either switch to dev_err(&adapter->dev, ...) or at least add
KERN_ERR before the string.

> +			"(new_client).\n");

You are actually trying to allocate "data", not "new_client". But given
that there's a single allocation in the whole driver anyway...

> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * The common I2C client data is placed right before the
> +	 * max6650-specific data. The max6650-specific data is pointed to by
> +	 * the data field from the I2C client data.
> +	 */

Please rip off this useless comment.

> +
> +	new_client = &data->client;
> +	i2c_set_clientdata(new_client, data);
> +	new_client->addr = address;
> +	new_client->adapter = adapter;
> +	new_client->driver = &max6650_driver;
> +	new_client->flags = 0;

You can omit this one, the kzalloc above already set the flags to 0.

> +
> +	/*
> +	 * Now we do the remaining detection. A negative kind means that
> +	 * the driver was loaded with no force parameter (default), so we
> +	 * must both detect and identify the chip (actually there is only
> +	 * one possible kind of chip for now, max6650). A zero kind means that
> +	 * the driver was loaded with the force parameter, the detection
> +	 * step shall be skipped. A positive kind means that the driver
> +	 * was loaded with the force parameter and a given kind of chip is
> +	 * requested, so both the detection and the identification steps
> +	 * are skipped.
> +	 *
> +	 * Currently I can find no way to distinguish between a MAX6650 and
> +	 * a MAX6651. This driver has only been tried on the latter.
> +	 */

I thought it was on the former?

> +
> +	if ((kind < 0)&&
> +	   (  (i2c_smbus_read_byte_data(new_client,MAX6650_REG_CONFIG) & 0xC0)
> +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_GPIO_STAT)& 0xE0)
> +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_ALARM_EN) & 0xE0)
> +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_ALARM) & 0xE0)
> +	    ||(i2c_smbus_read_byte_data(new_client,MAX6650_REG_COUNT) & 0xFC)))
> +	{
> +		dev_dbg(adapter->dev, "max6650.o: max6650 detection failed"

Missing space at the end of the first half, and this is not max6650.o.
Please format all your debug messages the same way, it's confusing
otherwise.

> +			"at 0x%02x.\n", address);
> +
> +		goto err_free;
> +        }

Indentation problem, the line above uses spaces instead of a tabulation.

> +
> +	if (kind <= 0)
> +		kind = max6650;
> +
> +	if (kind = max6650) {
> +		name = "max6650";
> +		printk("MAX6650: Chip found at 0x%02x.\n", address);

Missing log level.

> +	}
> +	else {
> +		printk("MAX6650: Unsupported chip.\n");

Missing log level.

> +		goto err_free;
> +	}

Given that this just cannot happen, and your driver supports only one
kind anyway, you could simply hardcode the kind and name.

> +
> +	/*
> +	 * OK, we got a valid chip so we can fill in the remaining client
> +	 * fields.
> +	 */
> +
> +	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> +	data->valid = 0;

This one too can be omitted.

> +	mutex_init(&data->update_lock);
> +
> +	/*
> +	 * Tell the I2C layer a new client has arrived.
> +	 */
> +
> +	if ((err = i2c_attach_client(new_client))) {
> +		dev_dbg(adapter->dev, "max6650.o: Failed attaching client.\n");
> +		goto err_free;
> +	}
> +
> +	/*
> +	 * Initialize the max6650 chip
> +	 */
> +	if (max6650_init_client(new_client))
> +		goto err_detach;
> +
> +	/* Register sysfs hooks */
> +	data->class_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto err_detach;
> +	}

Please create the files first, and register the class only after that.

> +
> +	err = sysfs_create_group(&new_client->dev.kobj, &max6650_attr_grp);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(&new_client->dev, "error creating sysfs files (%d)\n", err);
> +	hwmon_device_unregister(data->class_dev);
> +err_detach:
> +	i2c_detach_client(new_client);
> +err_free:
> +	kfree(data);
> +	return err;
> +}
> +
> +static int max6650_detach_client(struct i2c_client *client)
> +{
> +	struct max6650_data *data = i2c_get_clientdata(client);
> +	int err;
> +
> +	hwmon_device_unregister(data->class_dev);
> +	err = i2c_detach_client(client);
> +	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);

You should remove the files before detaching the client.

> +	kfree(data);

Do not free the memory if you failed to detach the client!

> +	return err;
> +}
> +
> +static int max6650_init_client(struct i2c_client *client)
> +{
> +	struct max6650_data *data = i2c_get_clientdata(client);
> +	const char* mode_strings[4] = {"full-on", "always-off",
> +					"closed-loop", "open-loop"};
> +	int config, countreg;
> +	int err = -ENODEV;

The only errors that can happen here are I/O errors, so that would be
-EIO.

> +
> +	mutex_lock(&data->update_lock);

You don't really need to take the mutex here - there's nobody else who
can access your data at this point.

> +	config = i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG);
> +
> +	if (config < 0) {
> +		dev_err(&client->dev, "Error reading config, aborting.\n");
> +		goto out;
> +	}
> +
> +	switch (fan_voltage) {
> +		case -1:
> +			break;
> +		case  5:
> +			config &= ~MAX6650_CFG_V12;
> +			break;
> +		case 12:
> +			config |= MAX6650_CFG_V12;
> +			break;
> +		default:
> +			dev_err(&client->dev,
> +				"illegal value for fan_voltage (%d)\n",
> +				fan_voltage);
> +	}
> +
> +	dev_info(&client->dev, "Fan voltage is set to %dV.\n",
> +		 (config & MAX6650_CFG_V12) ? 12 : 5);
> +
> +	switch (prescaler) {
> +		case -1:
> +			break;
> +		case  1:
> +			config &= ~MAX6650_CFG_PRESCALER_MASK;
> +			break;
> +		case  2:
> +			config = ( (config & ~MAX6650_CFG_PRESCALER_MASK)
> +				  | MAX6650_CFG_PRESCALER_2 );
> +			break;
> +		case  4:
> +			config = ( (config & ~MAX6650_CFG_PRESCALER_MASK)
> +				  | MAX6650_CFG_PRESCALER_4 );
> +			break;
> +		case  8:
> +			config = ( (config & ~MAX6650_CFG_PRESCALER_MASK)
> +				  | MAX6650_CFG_PRESCALER_8 );
> +			break;
> +		case 16:
> +			config = ( (config & ~MAX6650_CFG_PRESCALER_MASK)
> +				  | MAX6650_CFG_PRESCALER_16 );
> +			break;
> +		default:
> +			dev_err(&client->dev,
> +				"illegal value for prescaler (%d)\n",
> +				prescaler);
> +	}
> +
> +	dev_info(&client->dev, "Prescaler is set to %d.\n",
> +		 DIV_FROM_REG(config) );

This is confusing, you're using DIV_FROM_REG for both the prescaler and
the counttime. It works more or less by accident...

> +
> +	switch (mode) {
> +		case -1:
> +			break;
> +		case  0:
> +		case  1:
> +		case  2:
> +		case  3:
> +			config = (  (config & ~MAX6650_CFG_MODE_MASK)
> +				  | (mode << 4) );
> +			break;
> +		default:
> +			dev_err(&client->dev,
> +				 "illegal value for mode (%d)\n", mode);
> +	}
> +
> +	dev_info(&client->dev, "Mode is set to %s.\n",
> +		mode_strings[(config & MAX6650_CFG_MODE_MASK) >> 4]);
> +
> +	if (i2c_smbus_write_byte_data(client, MAX6650_REG_CONFIG, config)) {
> +		dev_err(&client->dev, "Error writing config, aborting.\n");
> +		goto out;
> +	}
> +
> +	data->config = config;
> +
> +	countreg = i2c_smbus_read_byte_data(client, MAX6650_REG_COUNT);
> +

No blank line between instruction and test.

> +	if (countreg < 0) {
> +		dev_err(&client->dev, "Error reading count time, aborting.\n");
> +		goto out;
> +	}
> +
> +	countreg &= MAX6650_COUNT_MASK;
> +	data->count = countreg;
> +
> +	if ((counttime >= 0) && (counttime <= 3)) {
> +		if (i2c_smbus_write_byte_data(client, MAX6650_REG_COUNT,
> +					      counttime)) {
> +			dev_err(&client->dev,
> +				"Error writing counttime, aborting.\n");
> +			goto out;
> +		}
> +		data->count = counttime;
> +	}
> +	else {
> +		if (counttime != -1) {
> +			dev_err(&client->dev,
> +				"illegal value for counttime (%d)\n",
> +				counttime);
> +			goto out;
> +		}
> +	}
> +
> +	err = 0;
> +	dev_info(&client->dev, "Count time is set to %d (%d msec).\n",
> +		 data->count, (1 << data->count) * 250);
> +out:
> +	mutex_unlock(&data->update_lock);
> +	return err;
> +}
> +
> +static const u8 tach_reg[] > +{
> +	MAX6650_REG_TACH0,
> +	MAX6650_REG_TACH1,
> +	MAX6650_REG_TACH2,
> +	MAX6650_REG_TACH3,
> +};
> +
> +static struct max6650_data *max6650_update_device(struct device *dev)
> +{
> +	int i;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max6650_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> +		data->speed = i2c_smbus_read_byte_data(client,
> +			 			       MAX6650_REG_SPEED);
> +		data->config = i2c_smbus_read_byte_data(client,
> +							MAX6650_REG_CONFIG);
> +		for (i = 0; i < 4; i++) {
> +			data->tach[i] = i2c_smbus_read_byte_data(client,
> +								 tach_reg[i]);
> +		}
> +		data->count = i2c_smbus_read_byte_data (client,
> +							MAX6650_REG_COUNT);

Extra space before opening parenthesis.

> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static int __init sensors_max6650_init(void)
> +{
> +	return i2c_add_driver(&max6650_driver);
> +}
> +
> +static void __exit sensors_max6650_exit(void)
> +{
> +	i2c_del_driver(&max6650_driver);
> +}
> +
> +MODULE_AUTHOR("john.morris at spirentcom.com");

This is more or less your driver now... BTW (I can't remember if I told
you already) feel free to add yourself to MAINTAINERS as the maintainer
for this new driver.

> +MODULE_DESCRIPTION("max6650 sensor driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(sensors_max6650_init);
> +module_exit(sensors_max6650_exit);

Thanks,
-- 
Jean Delvare

