From: Scott Kanowitz <skanowitz@echo360.com>
Date: Tue, 10 Jun 2014 14:25:05 +0000
Subject: Re: [lm-sensors] [PATCH] Added support for Lattice's POWR1220 power manager IC.
Message-Id: <e3d93e5b08ef4da493a4df412067ead9@BN1PR05MB536.namprd05.prod.outlook.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <53965259.8020806@roeck-us.net>
In-Reply-To: <53965259.8020806@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,

Thanks for the feedback. I'll update the driver and resubmit it.

--Scott

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Monday, June 09, 2014 8:33 PM
To: Scott Kanowitz; jdelvare@suse.de; LM Sensors
Subject: Re: [PATCH] Added support for Lattice's POWR1220 power manager IC.

On 06/09/2014 09:08 AM, Scott Kanowitz wrote:
> This patch adds support for Lattice's POWR1220 power manager IC. 
> Read/write access to all the registers and ADCs on the chip are 
> supported through the hwmon sysfs files.
>
> Signed-off-by: Scott Kanowitz <skanowitz@echo360.com>

Hi Scott,

please read and follow
	Documentation/hwmon/hwmon-kernel-api.txt
	Documentation/hwmon/sysfs-interface
	Documentation/hwmon/submitting-patches

Also please make sure that the mailing list is included in your patch submission.
This ensures that it is copied to patchwork and does not get lost.

> ---
>   drivers/hwmon/Kconfig    |  12 +
>   drivers/hwmon/Makefile   |   1 +
>   drivers/hwmon/powr1220.c | 624 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 637 insertions(+)
>   mode change 100644 => 100755 drivers/hwmon/Kconfig
>   create mode 100755 drivers/hwmon/powr1220.c

Configuration and source files are not executable. Please make sure that your patch passes checkpatch without errors and warnings.

I won't review in detail since literally none of your attributes follows the hwmon ABI. Some general comments, though.

- Attributes are displayed in decimal.
- There is no need to add blocking around a single i2c function call.
   The i2c subsystem does its own locking.
- Single assignments don't need locking either.
- GPIO attributes are not acceptable as hwmon attributes. Feel free to
   register GPIO attributes with the GPIO subsystem if you like. You can
   also write separate mfd and gpio drivers, but IMO that would be overkill.
- No forward declarations, please.
- Please use device managed functions where possible.
- Configuration parameters need to be set via platform data and/or
   devicetree data, not with sysfs attributes.
- Your driver does not use any smbus word access functions. Checking for
   I2C_FUNC_SMBUS_WORD_DATA seems quite unnecessary.
- At your choice you might want to consider using regmap for value caching
   instead of powr1220_update_device().

Thanks,
Guenter

>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig old mode 
> 100644 new mode 100755 index 4af0da9..fc4d7f1
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -608,6 +608,18 @@ config SENSORS_JC42
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called jc42.
>
> +config SENSORS_POWR1220
> +	tristate "Lattice POWR1220 Power Monitoring"
> +	depends on I2C
> +	default n
> +	help
> +	  If you say yes here you get access to the hardware monitoring
> +	  functions of the Lattice POWR1220 isp Power Supply Monitoring,
> +	  Sequencing and Margining Controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called powr1220.
> +
>   config SENSORS_LINEAGE
>   	tristate "Lineage Compact Power Line Power Entry Module"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile index 
> c48f987..842e6b3 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -119,6 +119,7 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> +obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
>   obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
>   obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c new 
> file mode 100755 index 0000000..2452e29
> --- /dev/null
> +++ b/drivers/hwmon/powr1220.c
> @@ -0,0 +1,624 @@
> +/*
> + * powr1220.c - Driver for the Lattice POWR1220 programmable power 
> +supply
> + * and monitor. Users can read all the values from the device, reset
> + * the device, read all the ADC inputs and adjust the trim values
> + * using the sysfs nodes.
> + *
> + * Copyright (c) 2014 Echo360 http://www.echo360.com
> + * Scott Kanowitz <skanowitz@echo360.com> <scott.kanowitz@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or 
> +modify
> + * it under the terms of the GNU General Public License as published 
> +by
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
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +
> +
> +#define ADC_STEP_MV	2
> +
> +enum powr1220_regs {
> +	VMON_STATUS0,
> +	VMON_STATUS1,
> +	VMON_STATUS2,
> +	OUTPUT_STATUS0,
> +	OUTPUT_STATUS1,
> +	OUTPUT_STATUS2,
> +	INPUT_STATUS,
> +	ADC_VALUE_LOW,
> +	ADC_VALUE_HIGH,
> +	ADC_MUX,
> +	UES_BYTE0,
> +	UES_BYTE1,
> +	UES_BYTE2,
> +	UES_BYTE3,
> +	GP_OUTPUT1,
> +	GP_OUTPUT2,
> +	GP_OUTPUT3,
> +	INPUT_VALUE,
> +	RESET,
> +	TRIM1_TRIM,
> +	TRIM2_TRIM,
> +	TRIM3_TRIM,
> +	TRIM4_TRIM,
> +	TRIM5_TRIM,
> +	TRIM6_TRIM,
> +	TRIM7_TRIM,
> +	TRIM8_TRIM,
> +	MAX_POWR1220_REGS
> +};
> +
> +
> +enum powr1220_adc_values {
> +	VMON1,
> +	VMON2,
> +	VMON3,
> +	VMON4,
> +	VMON5,
> +	VMON6,
> +	VMON7,
> +	VMON8,
> +	VMON9,
> +	VMON10,
> +	VMON11,
> +	VMON12,
> +	VCCA,
> +	VCCINP,
> +	MAX_POWR1220_ADC_VALUES
> +};
> +
> +struct powr1220_data {
> +		struct device *hwmon_dev;
> +		struct mutex update_lock;
> +		bool valid;
> +		bool adc_valid[MAX_POWR1220_ADC_VALUES];
> +		 /* the next two values are in jiffies */
> +		unsigned long last_updated;
> +		unsigned long adc_last_updated[MAX_POWR1220_ADC_VALUES];
> +
> +		/* values */
> +		unsigned char adc_range;
> +		int adc_values[MAX_POWR1220_ADC_VALUES];
> +		int vmon_status[3];
> +		int input_status;
> +		int input_value;
> +		int hvout;
> +		int output_status;
> +		int gp_output;
> +		int ues;
> +		int trim[8];
> +};
> +
> +
> +static struct powr1220_data *powr1220_update_device(struct device 
> +*dev); static int powr1220_read_adc(struct device *dev, int ch_num); 
> +static int powr1220_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id);
> +static int powr1220_remove(struct i2c_client *client);
> +
> +
> +/* Resets the device with a write to the reset register */ static 
> +ssize_t powr1220_reset(struct device *dev,
> +	struct device_attribute *dev_attr, const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +	i2c_smbus_write_byte_data(client, RESET, 1);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +
> +/* Shows the voltage associated with the specified ADC channel */ 
> +static ssize_t powr1220_show_voltage(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	int adc_val = powr1220_read_adc(dev, attr->index);
> +
> +	return sprintf(buf, "%04d\n", adc_val); }
> +
> +
> +/* Shows the status associated with the specified vmon register */ 
> +static ssize_t powr1220_show_vmon_status(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%02X\n", data->vmon_status[attr->index]); }
> +
> +
> +/* Shows the value of the input status register */ static ssize_t 
> +powr1220_show_input_status(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%02X\n", data->input_status); }
> +
> +
> +/* Shows the value of the input value register */ static ssize_t 
> +powr1220_show_input_value(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%02X\n", data->input_value); }
> +
> +
> +/* Sets the value of the input_value register. Input value is always 
> +hex */ static ssize_t powr1220_set_input_value(struct device *dev,
> +	struct device_attribute *dev_attr, const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +	unsigned long value;
> +	int error;
> +
> +	error = kstrtol(buf, 16, &value);
> +	if (error)
> +		return error;
> +
> +	value &= 0xFE;
> +
> +	mutex_lock(&data->update_lock);
> +	i2c_smbus_write_byte_data(client, INPUT_VALUE, (u8)value);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +
> +/* Shows the value of the output status */ static ssize_t 
> +powr1220_show_output_status(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%06X\n", data->output_status); }
> +
> +
> +/* Shows the value of the gp output */ static ssize_t 
> +powr1220_show_gp_output(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%06X\n", data->gp_output); }
> +
> +
> +/* Sets the value of the gp_output registers. Input value is always 
> +hex */ static ssize_t powr1220_set_gp_output(struct device *dev,
> +	struct device_attribute *dev_attr, const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +	unsigned long value;
> +	int error;
> +	unsigned char regs[3];
> +
> +	error = kstrtol(buf, 16, &value);
> +	if (error)
> +		return error;
> +
> +	regs[0] = value & 0x0000FF;
> +	regs[1] = (value & 0x00FF00) >> 8;
> +	regs[2] = (value & 0x0F0000) >> 16;
> +
> +	mutex_lock(&data->update_lock);
> +	i2c_smbus_write_byte_data(client, GP_OUTPUT1, regs[0]);
> +	i2c_smbus_write_byte_data(client, GP_OUTPUT2, regs[1]);
> +	i2c_smbus_write_byte_data(client, GP_OUTPUT3, regs[2]);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +
> +/* Shows the value of the hvout */
> +static ssize_t powr1220_show_hvout(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%02X\n", data->hvout); }
> +
> +
> +/* Shows the value of ues */
> +static ssize_t powr1220_show_ues(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%08X\n", data->ues); }
> +
> +
> +/* Shows the value of the specified trim value */ static ssize_t 
> +powr1220_show_trim(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "0x%02X\n", data->trim[attr->index]); }
> +
> +
> +/* Sets the value of the specified trim register. Input value is 
> +always hex */ static ssize_t powr1220_set_trim(struct device *dev,
> +	struct device_attribute *dev_attr, const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +	unsigned long value;
> +	int error;
> +
> +	error = kstrtol(buf, 16, &value);
> +	if (error)
> +		return error;
> +
> +	mutex_lock(&data->update_lock);
> +	i2c_smbus_write_byte_data(client, TRIM1_TRIM + attr->index, (u8)value);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +
> +/* Shows the value of the adc range (0 or 1) */ static ssize_t 
> +powr1220_show_adc_range(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct powr1220_data *data = powr1220_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", (data->adc_range ? 1 : 0)); }
> +
> +
> +/* Sets the value of the adc range (0 or 1) */ static ssize_t 
> +powr1220_set_adc_range(struct device *dev,
> +	struct device_attribute *dev_attr, const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +	unsigned long range;
> +	int error;
> +
> +	error = kstrtol(buf, 10, &range);
> +	if (error)
> +		return error;
> +
> +	mutex_lock(&data->update_lock);
> +	data->adc_range = (range ? 1 : 0);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +
> +
> +/* Reads the specified ADC channel */ static int 
> +powr1220_read_adc(struct device *dev, int ch_num) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +	unsigned char reg;
> +	int reading;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->adc_last_updated[ch_num] + HZ) ||
> +			!data->adc_valid[ch_num]) {
> +		/* set the attenuator and mux */
> +		reg = ((data->adc_range & 1) << 4) | ch_num;
> +		i2c_smbus_write_byte_data(client, ADC_MUX, reg);
> +
> +		/* wait at least Tconvert time (200 us) for the
> +		 * conversion to complete */
> +		udelay(200);
> +
> +		/* check if the done bit is set */
> +		reg = i2c_smbus_read_byte_data(client, ADC_VALUE_LOW);
> +		if (reg & 0x01) {
> +			/* we have a valid conversion to read */
> +			reading = reg >> 4;
> +			reg = i2c_smbus_read_byte_data(client, ADC_VALUE_HIGH);
> +			reading |= (unsigned int)reg << 4;
> +
> +			/* now convert the reading to a voltage */
> +			data->adc_values[ch_num] = reading * ADC_STEP_MV;
> +		}
> +
> +		data->adc_last_updated[ch_num] = jiffies;
> +		data->adc_valid[ch_num] = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data->adc_values[ch_num];
> +}
> +
> +
> +/* Reads from the device and updates the local data if after the 
> +timeout */ static struct powr1220_data *powr1220_update_device(struct 
> +device *dev) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +	unsigned char regs[MAX_POWR1220_REGS];
> +	int i;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> +		/* read the full register bank */
> +		for (i = 0; i < MAX_POWR1220_REGS; i++)
> +			regs[i] = i2c_smbus_read_byte_data(client, i);
> +
> +		/* get the values of vmon A and B */
> +		for (i = 0; i < ARRAY_SIZE(data->vmon_status); i++)
> +			data->vmon_status[i] = regs[VMON_STATUS0 + i];
> +
> +		/* get the input status and value */
> +		data->input_status = regs[INPUT_STATUS] & 0x3F;
> +		data->input_value = regs[INPUT_VALUE] & 0x3E;
> +
> +		/* get the output status */
> +		data->hvout = regs[OUTPUT_STATUS0] & 0x0F;
> +		data->output_status = (regs[OUTPUT_STATUS0] >> 4) |
> +				((int)regs[OUTPUT_STATUS1] << 4) |
> +				((int)regs[OUTPUT_STATUS2] << 12);
> +
> +		/* get the output */
> +		data->gp_output = regs[GP_OUTPUT1] |
> +				((int)regs[GP_OUTPUT2] << 8) |
> +				((int)(regs[GP_OUTPUT3] & 0x0F) << 16);
> +
> +		/* get the user signature*/
> +		data->ues = regs[UES_BYTE0] |
> +			 ((int)regs[UES_BYTE1] << 8) |
> +			 ((int)regs[UES_BYTE2] << 16) |
> +			 ((int)regs[UES_BYTE3] << 24);
> +
> +		/* get the trim values */
> +		for (i = 0; i < ARRAY_SIZE(data->trim); i++)
> +			data->trim[i] = regs[TRIM1_TRIM + i];
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +
> +
> +static SENSOR_DEVICE_ATTR(vmon1, S_IRUGO, powr1220_show_voltage, 
> +NULL, VMON1); static SENSOR_DEVICE_ATTR(vmon2, S_IRUGO, 
> +powr1220_show_voltage, NULL, VMON2); static SENSOR_DEVICE_ATTR(vmon3, 
> +S_IRUGO, powr1220_show_voltage, NULL, VMON3); static 
> +SENSOR_DEVICE_ATTR(vmon4, S_IRUGO, powr1220_show_voltage, NULL, 
> +VMON4); static SENSOR_DEVICE_ATTR(vmon5, S_IRUGO, 
> +powr1220_show_voltage, NULL, VMON5); static SENSOR_DEVICE_ATTR(vmon6, 
> +S_IRUGO, powr1220_show_voltage, NULL, VMON6); static 
> +SENSOR_DEVICE_ATTR(vmon7, S_IRUGO, powr1220_show_voltage, NULL, 
> +VMON7); static SENSOR_DEVICE_ATTR(vmon8, S_IRUGO, powr1220_show_voltage, NULL, VMON8); static SENSOR_DEVICE_ATTR(vmon9, S_IRUGO, powr1220_show_voltage, NULL, VMON9); static SENSOR_DEVICE_ATTR(vmon10, S_IRUGO, powr1220_show_voltage, NULL,
> +		VMON10);
> +static SENSOR_DEVICE_ATTR(vmon11, S_IRUGO, powr1220_show_voltage, NULL,
> +		VMON11);
> +static SENSOR_DEVICE_ATTR(vmon12, S_IRUGO, powr1220_show_voltage, NULL,
> +		VMON12);
> +static SENSOR_DEVICE_ATTR(vcca, S_IRUGO, powr1220_show_voltage, NULL, 
> +VCCA); static SENSOR_DEVICE_ATTR(vccinp, S_IRUGO, powr1220_show_voltage, NULL,
> +		VCCINP);
> +
> +static SENSOR_DEVICE_ATTR(reset, S_IWUSR, NULL, powr1220_reset, 0);
> +
> +static SENSOR_DEVICE_ATTR(vmon_status0, S_IRUGO, powr1220_show_vmon_status,
> +		NULL, 0);
> +static SENSOR_DEVICE_ATTR(vmon_status1, S_IRUGO, powr1220_show_vmon_status,
> +		NULL, 1);
> +static SENSOR_DEVICE_ATTR(vmon_status2, S_IRUGO, powr1220_show_vmon_status,
> +		NULL, 2);
> +
> +static SENSOR_DEVICE_ATTR(input_status, S_IRUGO, powr1220_show_input_status,
> +		NULL, 0);
> +static SENSOR_DEVICE_ATTR(input_value, S_IWUSR | S_IRUGO,
> +		powr1220_show_input_value, powr1220_set_input_value, 0); static 
> +SENSOR_DEVICE_ATTR(output_status, S_IRUGO, powr1220_show_output_status,
> +		NULL, 0);
> +static SENSOR_DEVICE_ATTR(gp_output, S_IWUSR | S_IRUGO,
> +		powr1220_show_gp_output, powr1220_set_gp_output, 0); static 
> +SENSOR_DEVICE_ATTR(hvout, S_IRUGO, powr1220_show_hvout,
> +		NULL, 0);
> +static SENSOR_DEVICE_ATTR(ues, S_IRUGO, powr1220_show_ues, NULL, 0);
> +
> +static SENSOR_DEVICE_ATTR(trim1, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 0);
> +static SENSOR_DEVICE_ATTR(trim2, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 1);
> +static SENSOR_DEVICE_ATTR(trim3, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 2);
> +static SENSOR_DEVICE_ATTR(trim4, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 3);
> +static SENSOR_DEVICE_ATTR(trim5, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 4);
> +static SENSOR_DEVICE_ATTR(trim6, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 5);
> +static SENSOR_DEVICE_ATTR(trim7, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 6);
> +static SENSOR_DEVICE_ATTR(trim8, S_IWUSR | S_IRUGO, powr1220_show_trim,
> +		powr1220_set_trim, 7);
> +
> +static SENSOR_DEVICE_ATTR(adc_range, S_IWUSR | S_IRUGO,
> +		powr1220_show_adc_range, powr1220_set_adc_range, 0);
> +
> +
> +
> +static struct attribute *powr1220_attributes[] = {
> +	&sensor_dev_attr_vmon1.dev_attr.attr,
> +	&sensor_dev_attr_vmon2.dev_attr.attr,
> +	&sensor_dev_attr_vmon3.dev_attr.attr,
> +	&sensor_dev_attr_vmon4.dev_attr.attr,
> +	&sensor_dev_attr_vmon5.dev_attr.attr,
> +	&sensor_dev_attr_vmon6.dev_attr.attr,
> +	&sensor_dev_attr_vmon7.dev_attr.attr,
> +	&sensor_dev_attr_vmon8.dev_attr.attr,
> +	&sensor_dev_attr_vmon9.dev_attr.attr,
> +	&sensor_dev_attr_vmon10.dev_attr.attr,
> +	&sensor_dev_attr_vmon11.dev_attr.attr,
> +	&sensor_dev_attr_vmon12.dev_attr.attr,
> +	&sensor_dev_attr_vcca.dev_attr.attr,
> +	&sensor_dev_attr_vccinp.dev_attr.attr,
> +
> +	&sensor_dev_attr_reset.dev_attr.attr,
> +
> +	&sensor_dev_attr_vmon_status0.dev_attr.attr,
> +	&sensor_dev_attr_vmon_status1.dev_attr.attr,
> +	&sensor_dev_attr_vmon_status2.dev_attr.attr,
> +
> +	&sensor_dev_attr_input_status.dev_attr.attr,
> +	&sensor_dev_attr_input_value.dev_attr.attr,
> +	&sensor_dev_attr_output_status.dev_attr.attr,
> +	&sensor_dev_attr_gp_output.dev_attr.attr,
> +	&sensor_dev_attr_hvout.dev_attr.attr,
> +	&sensor_dev_attr_ues.dev_attr.attr,
> +
> +	&sensor_dev_attr_trim1.dev_attr.attr,
> +	&sensor_dev_attr_trim2.dev_attr.attr,
> +	&sensor_dev_attr_trim3.dev_attr.attr,
> +	&sensor_dev_attr_trim4.dev_attr.attr,
> +	&sensor_dev_attr_trim5.dev_attr.attr,
> +	&sensor_dev_attr_trim6.dev_attr.attr,
> +	&sensor_dev_attr_trim7.dev_attr.attr,
> +	&sensor_dev_attr_trim8.dev_attr.attr,
> +
> +	&sensor_dev_attr_adc_range.dev_attr.attr,
> +
> +	NULL
> +};
> +
> +static const struct attribute_group powr1220_group = {
> +	.attrs = powr1220_attributes,
> +};
> +
> +
> +static int powr1220_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct powr1220_data *data;
> +	int status;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EIO;
> +
> +	data = kzalloc(sizeof(struct powr1220_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +
> +	status = sysfs_create_group(&client->dev.kobj, &powr1220_group);
> +	if (status)
> +		goto exit_free;
> +
> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		status = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove_files;
> +	}
> +
> +	dev_info(&client->dev, "initialized\n");
> +
> +	return 0;
> +
> +exit_remove_files:
> +	sysfs_remove_group(&client->dev.kobj, &powr1220_group);
> +exit_free:
> +	kfree(data);
> +	return status;
> +}
> +
> +
> +static int powr1220_remove(struct i2c_client *client) {
> +	struct powr1220_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &powr1220_group);
> +	kfree(data);
> +	return 0;
> +}
> +
> +
> +
> +static const struct i2c_device_id powr1220_ids[] = {
> +	{ "powr1220", 0, },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, powr1220_ids);
> +
> +static struct i2c_driver powr1220_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "powr1220",
> +	},
> +	.probe		= powr1220_probe,
> +	.remove		= powr1220_remove,
> +	.id_table	= powr1220_ids,
> +};
> +
> +
> +static int __init powr1220_init(void) {
> +	return i2c_add_driver(&powr1220_driver); }
> +
> +static void __exit powr1220_exit(void) {
> +	i2c_del_driver(&powr1220_driver);
> +}
> +
> +
> +module_init(powr1220_init);
> +module_exit(powr1220_exit);
> +
> +MODULE_AUTHOR("Scott Kanowitz");
> +MODULE_DESCRIPTION("POWR1220 driver"); MODULE_LICENSE("GPL");
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
