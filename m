From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Apr 2010 14:17:49 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100421161749.26826ab9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Wed, 14 Apr 2010 13:52:08 +0100, Alan Cox wrote:
> From: Kalhan Trisal <kalhan.trisal at intel.com>
> 
> Provides support for the emc1403 thermal sensor. Only reporting of values
> is supported. The various Moorestown specific extras to do with thermal
> alerts and the like are not in this version of the driver.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal at intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Quick review follows. There's quite some cleanup work left before this
driver can make it upstream.

> ---
> 
>  drivers/hwmon/Kconfig   |   10 +
>  drivers/hwmon/Makefile  |    1 
>  drivers/hwmon/emc1403.c |  437 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/emc1403.c
> 
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 6868b9d..34ee302 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1112,6 +1112,16 @@ config SENSORS_LIS331DL
>  	  Device can be configured using sysfs.
>  	  x y Z data can be   accessible via sysfs.
>  
> +config SENSORS_EMC1403
> +	tristate "SMSC EMC1403 thermal sensor"

Please group with the other SMSC entries.

> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the SMSC Devices
> +	  EMC1403 temperature monitoring chip.

"SMSC EMC1403" is enough, "Devices" can be removed IMHO.

> +
> +	  Threshold values can be configured using sysfs.
> +	  Data from the different diode are accessible via sysfs.

Spelling: diodes.

> +
>  if ACPI
>  
>  comment "ACPI drivers"
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index ebeb2a2..a7332ce 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
>  obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
> +obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
>  obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
>  obj-$(CONFIG_SENSORS_F71882FG)	+= f71882fg.o
>  obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> new file mode 100644
> index 0000000..b71cfa1
> --- /dev/null
> +++ b/drivers/hwmon/emc1403.c
> @@ -0,0 +1,437 @@
> +/*
> + * emc1403.c - SMSC Thermal Driver
> + *
> + * Copyright (C) 2008 Intel Corp
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon-vid.h>

I pretty much doubt you need <linux/hwmon-vid.h> for a thermal sensor
driver.

> +#include <linux/interrupt.h>

Not used.

> +#include <linux/workqueue.h>

Not really used (see below).

> +#include <linux/err.h>
> +#include <linux/delay.h>

Not used.

> +#include <linux/mutex.h>

Not used.

> +#include <linux/sysfs.h>
> +
> +
> +/* Limit status reg Therm/High/Low/Fault*/
> +static const u8 THM_STAT_REG_TEMP[] = { 0x37, 0x35, 0x36, 0x1B, 0x02};

Missing space before closing curly brace. This array isn't used by the
driver anyway...

> +
> +/* Channel  diode temp set */
> +static const u8 THM_CHAN_TEMP[] = { 0x10, 0x08, 0x04, 0x02, 0x01 };

Not used either.

> +
> +/* Therm Limit reg store values */
> +static const u8 THM_LIMIT_REG_TEMP[] = { 0x05, 0x06, 0x07, 0x08, 0x15, 0x16,
> +						0x19, 0x1A, 0x20, 0x21 };
> +
> +/* DATA REGISTERS */
> +static const u8 THM_REG_CURR_TEMP[] = { 0x00, 0x01, 0x23 };

The names are slightly inconsistent (place of "_REG_".)

> +
> +#define THERMAL_PID_REG		0xfd
> +#define THERMAL_SMSC_ID_REG	0xfe
> +#define THERMAL_REVISION_REG	0xff
> +#define THERMAL_ADC_UPDATE_BUSY	0x80

Not used.

> +#define I2C_THERMAL_SLAVE_ADDR	0x4C

Not used.

> +#define TEMP1			1
> +#define TEMP2			2
> +#define TEMP3			4

These names are pretty vague, aren't they? And you don't even use these
defines consistently.

> +#define IRQ_TYPE_MASK		(1 << 15)

Not used.

> +#define HIGH_EVENT		1
> +#define LOW_EVENT		2
> +#define THERM_EVENT		3
> +#define FAULT_EVENT		4
> +#define ALERT_EVENT		1

None of these is used.

> +
> +struct thermal_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +	int therm_irq;
> +	int alert_irq;
> +	struct work_struct therm_handler;
> +	struct work_struct alert_handler;
> +};

The last 4 members of this structure aren't used anywhere in the driver.

> +
> +static int calculate_offset(int type, int temp_ofs)
> +{
> +	int offset = 0;
> +
> +	switch (type) {
> +	case TEMP1:
> +		if (temp_ofs = 0)
> +			offset = 1;
> +		else if (temp_ofs = 1)
> +			offset = 0;
> +		else if (temp_ofs = 2)
> +			offset = 8;
> +		break;
> +	case TEMP2:
> +		if (temp_ofs = 0)
> +			offset = 3;
> +		else if (temp_ofs = 1)
> +			offset = 2;
> +		else if (temp_ofs = 2)
> +			offset = 6;
> +		break;
> +	case TEMP3:
> +		if (temp_ofs = 0)
> +			offset = 5;
> +		else if (temp_ofs = 1)
> +			offset = 4;
> +		else if (temp_ofs = 2)
> +			offset = 7;
> +		break;
> +	default:
> +		offset = -1;
> +		break;
> +	}
> +	return offset;

This function is horrible. This is all crying for a small look-up
table, isn't it?

> +

Stray blank line.

> +}
> +
> +
> +static ssize_t show_temp_auto_offset(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute_2 *s_attr = to_sensor_dev_attr_2(attr);
> +	int temp_index = s_attr->index;
> +	int temp_ofs = s_attr->nr;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret_val;
> +	int ret_offset;
> +
> +	ret_offset = calculate_offset(temp_index, temp_ofs);
> +	if (ret_offset = -1)
> +		return -EINVAL;

Wouldn't this be an internal driver error? -EINVAL doesn't seem right.

> +	ret_val = i2c_smbus_read_byte_data(client,
> +				THM_LIMIT_REG_TEMP[ret_offset]);

Missing error handling. Same is true throughout the whole driver.

> +	return sprintf(buf, "%d\n", ret_val);
> +}
> +
> +static ssize_t store_temp_auto_offset(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute_2 *s_attr = to_sensor_dev_attr_2(attr);
> +	int temp_index = s_attr->index;
> +	int temp_ofs = s_attr->nr;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned long val;
> +	int ret_offset;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +	ret_offset = calculate_offset(temp_index, temp_ofs);
> +	if (ret_offset = -1)
> +		return -EINVAL;
> +
> +	i2c_smbus_write_byte_data(client, THM_LIMIT_REG_TEMP[ret_offset], val);
> +	return count;
> +}
> +
> +static ssize_t show_temp_hyst(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	return sprintf(buf, "%d\n",
> +		i2c_smbus_read_byte_data(client, THM_LIMIT_REG_TEMP[9]));
> +}
> +
> +static ssize_t store_temp_hyst(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned long val;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +	i2c_smbus_write_byte_data(client, THM_LIMIT_REG_TEMP[9], val);
> +	return count;
> +}

That's not OK. The value in register 0x21 is a relative one, that
applies to all limits. The standard hwmon interface (see
Documentation/hwmon/sysfs-interface) says that hysteresis temperatures
must always be exported as absolute values. This means you must do some
computations in the driver, and you must export one hyst file for every
affected temperature limit.

> +
> +static ssize_t show_temp1_curr_temp(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret_val;
> +
> +	ret_val = i2c_smbus_read_byte_data(client, THM_REG_CURR_TEMP[0]);
> +	return sprintf(buf, "%d\n", ret_val);
> +}
> +
> +static ssize_t show_temp2_curr_temp(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret_val;
> +
> +	ret_val = i2c_smbus_read_byte_data(client, THM_REG_CURR_TEMP[1]);
> +	return sprintf(buf, "%d\n", ret_val);
> +}
> +
> +static ssize_t show_temp3_curr_temp(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret_val;
> +
> +	ret_val = i2c_smbus_read_byte_data(client, THM_REG_CURR_TEMP[2]);
> +	return sprintf(buf, "%d\n", ret_val);
> +}

3 times the same function. Please use attribute parameters.

> +
> +static ssize_t show_status_reg(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int r1, r2, r3, r4;
> +
> +	r1 = i2c_smbus_read_byte_data(client, 0x1F);
> +	r2 = i2c_smbus_read_byte_data(client, 0x35);
> +	r3 = i2c_smbus_read_byte_data(client, 0x36);
> +	r4 = i2c_smbus_read_byte_data(client, 0x37);
> +	return sprintf(buf, "alarm=%x,High=%x,Low=%x,Therm=%x \n",
> +				r1, r2, r3, r4);
> +}

Please read Documentation/hwmon/sysfs-interface. We have standard
attribute names for alarm states, please use them.

> +
> +static ssize_t show_power_state(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret_val = i2c_smbus_read_byte_data(client, 0x03);
> +	return sprintf(buf, "%x", (ret_val >> 6) & 1);
> +}

Does this follow any standard? I wouldn't use hexadecimal here (even if
it makes no practical difference for a boolean.)

> +
> +static ssize_t store_power_state(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned long val;
> +	char curr_val;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	curr_val = i2c_smbus_read_byte_data(client, 0x03);
> +	if (val = 1)
> +		curr_val &= 0xBF;
> +	else if (val = 0)
> +		curr_val |= 0x40;
> +	else
> +		return -EINVAL;
> +	i2c_smbus_write_byte_data(client, 0x03, curr_val);
> +	return count;
> +}
> +
> +static ssize_t show_mode(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret_val = i2c_smbus_read_byte_data(client, 0x03);
> +	return sprintf(buf, "%x", (ret_val >> 7) & 1);

Again, no hexadecimal format please.

> +}
> +
> +static ssize_t store_mode(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned long val;
> +	int curr_val;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	curr_val = i2c_smbus_read_byte_data(client, 0x03);
> +	if (val = 1)
> +		curr_val &= 0x7F;
> +	else if (val = 0)
> +		curr_val |= 0x80;
> +	else
> +		return -EINVAL;
> +	i2c_smbus_write_byte_data(client, 0x03, curr_val);
> +	return count;
> +}

I am curious what this "mode" is all about. It's not a standard hwmon
attribute, and not documented in the driver.

> +
> +static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 0, 1);
> +static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 1, 1);
> +static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 2, 1);
> +static DEVICE_ATTR(temp1_curr, S_IRUGO, show_temp1_curr_temp, NULL);
> +
> +static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 0, 2);
> +static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 1, 2);
> +static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 2, 2);
> +static DEVICE_ATTR(temp2_curr, S_IRUGO, show_temp2_curr_temp, NULL);
> +
> +static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 0, 4);
> +static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 1, 4);
> +static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR,
> +	show_temp_auto_offset, store_temp_auto_offset, 2, 4);
> +static DEVICE_ATTR(temp3_curr, S_IRUGO, show_temp3_curr_temp, NULL);

I don't understand why you use 2-parameters attributes, given that, in
callback functions, you end up calling calculate_offset(), which
returns a single index into an array. You could pass that index
directly as the attribute parameter, or even pass the register value
directly, to save the look-up in THM_LIMIT_REG_TEMP.

> +
> +static DEVICE_ATTR(hyster, S_IRUGO | S_IWUSR, show_temp_hyst, store_temp_hyst);

As discussed above this attribute must be reworked.

> +static DEVICE_ATTR(status, S_IRUGO, show_status_reg, NULL);

And this one as well.

> +
> +static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> +	show_power_state, store_power_state);
> +static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, store_mode);
> +
> +static struct attribute *mid_att_thermal[] = {
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&dev_attr_temp1_curr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_crit.dev_attr.attr,
> +	&dev_attr_temp2_curr.attr,
> +	&sensor_dev_attr_temp3_min.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_crit.dev_attr.attr,
> +	&dev_attr_temp3_curr.attr,
> +	&dev_attr_hyster.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_power_state.attr,
> +	&dev_attr_mode.attr,
> +	NULL
> +};
> +
> +static struct attribute_group m_thermal_gr = {

Should be const.

> +	.name = "emc1403",

This will put the attributes in a subdirectory, where libsensors will
never look for them. You don't want to do this.

> +	.attrs = mid_att_thermal
> +};
> +
> +static void emc1403_set_default_config(struct i2c_client *client)
> +{
> +	i2c_smbus_write_byte_data(client, 0x03, 0x00);
> +	i2c_smbus_write_byte_data(client, 0x04, 0x02);
> +	i2c_smbus_write_byte_data(client, 0x22, 0x00);
> +}

This is horrible. Each initialization step should be documented and
justified. In many cases, the BIOS has already setup the thermal sensor
chip before the OS runs, and configuration should not be changed
arbitrarily.

> +
> +static int  emc1403_probe(struct i2c_client *new_client,

Please rename "new_client" to just "client". This is a remnant of old
lm-sensors drivers I'd like to finally get rid of.

> +			const struct i2c_device_id *id)
> +{
> +	int res = 0;
> +	struct thermal_data *data;
> +	u16 pid, smsc_id, revision;

u16 to store 8-bit register values? Please use either u8, or int so
that you can deal with I/O errors.

> +
> +	data = kzalloc(sizeof(struct thermal_data), GFP_KERNEL);
> +
> +	if (data = NULL) {

Style: no blank line between allocation and test.

> +		printk(KERN_WARNING "emc1403: out of memory");

Please use dev_warn (or even dev_err... as this is a fatal error.)

> +		return -ENOMEM;
> +	}
> +	data->client = new_client;

Set but never used.

> +	i2c_set_clientdata(new_client, data);
> +
> +	/* Check if thermal chip is SMSC and EMC1403 */
> +	smsc_id = i2c_smbus_read_byte_data(new_client,
> +					THERMAL_SMSC_ID_REG);
> +	if (smsc_id != 0x5d) {
> +		printk(KERN_WARNING "emc1403: vendor id mismatch\n");
> +		goto thermal_error1;
> +	}
> +	pid = i2c_smbus_read_byte_data(new_client, THERMAL_PID_REG);
> +	if (pid != 0x21)  {
> +		printk(KERN_WARNING "emc1403: product id mismatch\n");
> +		goto thermal_error1;
> +	}
> +	revision = i2c_smbus_read_byte_data(new_client,
> +				THERMAL_REVISION_REG);
> +	if (revision != 0x01) {
> +		printk(KERN_WARNING "emc1403: rev id mismatch (is %d)\n",
> +								revision);
> +		goto thermal_error1;
> +	}

This all should be moved to a .detect() driver function. Doing these
tests in .probe() shouldn't be needed (if you're there, you already
know that the right chip is present at the given address) and prevents
one from arbitrarily binding the driver to a known-compatible device.

> +	res = sysfs_create_group(&new_client->dev.kobj, &m_thermal_gr);
> +	if (res) {
> +		printk(KERN_WARNING "emc1403: create group failed\n");

dev_err()

> +		hwmon_device_unregister(data->hwmon_dev);
> +		goto thermal_error1;
> +	}
> +	data->hwmon_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		res = PTR_ERR(data->hwmon_dev);
> +		data->hwmon_dev = NULL;
> +		printk(KERN_WARNING "emc1403:Register hwmon dev failed\n");

dev_err()

> +		goto thermal_error2;
> +	}
> +	emc1403_set_default_config(new_client);
> +	dev_info(&new_client->dev, "%s EMC1403 Thermal chip found\n",
> +							new_client->name);
> +	return res;

Please add a blank line here.

> +thermal_error2:
> +	sysfs_remove_group(&new_client->dev.kobj, &m_thermal_gr);
> +thermal_error1:
> +	i2c_set_clientdata(new_client, NULL);

No longer needed (done by i2c-core).

> +	kfree(data);
> +	return res;
> +}
> +
> +static int emc1403_remove(struct i2c_client *client)
> +{
> +	struct thermal_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct i2c_device_id emc1403_idtable[] = {

const

> +	{ "i2c_thermal", 0 },

AH AH AH. You weren't serious, right?

> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
> +
> +static struct i2c_driver sensor_emc1403 = {
> +	.driver = {
> +		.name = "emc1403",
> +	},
> +	.probe = emc1403_probe,
> +	.remove = emc1403_remove,
> +	.id_table = emc1403_idtable,
> +};
> +
> +static int __init sensor_emc1403_init(void)
> +{
> +	return i2c_add_driver(&sensor_emc1403);
> +}
> +
> +static void  __exit sensor_emc1403_exit(void)
> +{
> +	i2c_del_driver(&sensor_emc1403);
> +}
> +
> +module_init(sensor_emc1403_init);
> +module_exit(sensor_emc1403_exit);
> +
> +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
> +MODULE_DESCRIPTION("emc1403 Thermal Driver");
> +MODULE_LICENSE("GPL v2");
> 

Can I get a dump of one of these chips (use i2cdump from the i2c-tools
package)? This would help me test the next iteration of the driver, and
add support to sensors-detect.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
