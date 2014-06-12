From: Scott Kanowitz <skanowitz@echo360.com>
Date: Thu, 12 Jun 2014 03:16:20 +0000
Subject: Re: [lm-sensors] [PATCH] Added support for Lattice's POWR1220 power manager IC.
Message-Id: <fb546250f9ac4890b2b20fa4b203bc60@BN1PR05MB536.namprd05.prod.outlook.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <53965259.8020806@roeck-us.net>
In-Reply-To: <53965259.8020806@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

I'll update with your changes and resubmit the patch.

To answer your question:
	> Is the factor the same for both low and high range ? Shouldn't the factor be 6 for the high range ?
The factor is always 2 mV. The attenuator circuitry implements a divide by three before the ADC followed by a multiply by three. Therefore the step size is always 2 mV, you just lose resolution with the voltages in the higher range.

--Scott


-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Wednesday, June 11, 2014 6:26 PM
To: Scott Kanowitz
Cc: jdelvare@suse.de; lm-sensors@lm-sensors.org
Subject: Re: [PATCH] Added support for Lattice's POWR1220 power manager IC.

On 06/11/2014 01:35 PM, Scott Kanowitz wrote:
> This patch adds support for Lattice's POWR1220 power manager IC. Read 
> access to all the ADCs on the chip are supported through the hwmon 
> sysfs files.
>
> Signed-off-by: Scott Kanowitz <skanowitz@echo360.com>

Hi Scott,

that was a pretty quick turnaround for such a major rewrite.
See inline for comments.

Thanks,
Guenter

> ---
>   Documentation/hwmon/powr1220 |  45 +++++
>   drivers/hwmon/Kconfig        |  12 ++
>   drivers/hwmon/Makefile       |   1 +
>   drivers/hwmon/powr1220.c     | 416 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 474 insertions(+)
>   create mode 100644 Documentation/hwmon/powr1220
>   create mode 100644 drivers/hwmon/powr1220.c
>
> diff --git a/Documentation/hwmon/powr1220 
> b/Documentation/hwmon/powr1220 new file mode 100644 index 
> 0000000..21e44f7
> --- /dev/null
> +++ b/Documentation/hwmon/powr1220
> @@ -0,0 +1,45 @@
> +Kernel driver powr1220
> +=========
> +
> +Supported chips:
> +  * Lattice POWR1220AT8
> +    Prefix: 'powr1220'
> +    Addresses scanned: none
> +    Datasheet: Publicly available at the Lattice website
> +               http://www.latticesemi.com/
> +
> +Author: Scott Kanowitz <scott.kanowitz@gmail.com>
> +
> +Description
> +-----------
> +
> +This driver supports the Lattice POWR1220AT8 chip. The POWR1220 
> +includes voltage monitoring for 14 inputs as well as trim settings 
> +for output voltages and GPIOs. This driver implements the voltage 
> +monitoring portion of the chip.
> +
> +Voltages are sampled by a 12-bit ADC with a step size of 2 mV.
> +An in-line attenuator allows measurements from 0 to 6 V. The 
> +attenuator is enabled or disabled depending on the setting of the 
> +input's max value. The driver will enable the attenuator for any 
> +value over the low measurement range maximum of 2 V.
> +
> +The input naming convention is as follows:
> +
> +driver name    pin name
> +in0            VMON1
> +in1            VMON2
> +in2            VMON3
> +in2            VMON4
> +in4            VMON5
> +in5            VMON6
> +in6            VMON7
> +in7            VMON8
> +in8            VMON9
> +in9            VMON10
> +in10           VMON11
> +in11           VMON12
> +in12           VCCA
> +in13           VCCINP
> +
> +The ADC readings are updated on request with a minimum period of 1s.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig index 
> 4af0da9..fc4d7f1 100644
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
> file mode 100644 index 0000000..59e5ff8
> --- /dev/null
> +++ b/drivers/hwmon/powr1220.c
> @@ -0,0 +1,416 @@
> +/*
> + * powr1220.c - Driver for the Lattice POWR1220 programmable power 
> +supply
> + * and monitor. Users can read all ADC inputs along with their labels
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
Only one empty line please.

> +#define ADC_STEP_MV	2
> +#define ADC_MAX_LOW_MEASUREMENT_MV 2000 #define 
> +ADC_MAX_HIGH_MEASUREMENT_MV 6000

Please use a tab after _MV.

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
One empty line

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
> +
One empty line

> +struct powr1220_data {
> +	struct i2c_client *client;
> +	struct mutex update_lock;
> +	bool adc_valid[MAX_POWR1220_ADC_VALUES];
> +	 /* the next value is in jiffies */
> +	unsigned long adc_last_updated[MAX_POWR1220_ADC_VALUES];
> +
> +	/* values */
> +	int adc_maxes[MAX_POWR1220_ADC_VALUES];
> +	int adc_values[MAX_POWR1220_ADC_VALUES];
> +};
> +
> +
One empty line

> +static const char * const input_names[] = {
> +	[VMON1]    = "vmon1",
> +	[VMON2]    = "vmon2",
> +	[VMON3]    = "vmon3",
> +	[VMON4]    = "vmon4",
> +	[VMON5]    = "vmon5",
> +	[VMON6]    = "vmon6",
> +	[VMON7]    = "vmon7",
> +	[VMON8]    = "vmon8",
> +	[VMON9]    = "vmon9",
> +	[VMON10]   = "vmon10",
> +	[VMON11]   = "vmon11",
> +	[VMON12]   = "vmon12",
> +	[VCCA]     = "vcca",
> +	[VCCINP]   = "vccinp",
> +};
> +
> +
Single empty line

> +/* Reads the specified ADC channel */ static int 
> +powr1220_read_adc(struct device *dev, int ch_num) {
> +	struct powr1220_data *data = dev_get_drvdata(dev);
> +	unsigned char reg;
> +	int reading;
> +	unsigned char adc_range = 0;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->adc_last_updated[ch_num] + HZ) ||
> +			!data->adc_valid[ch_num]) {
> +		/* figure out if we need to use the attenuator for
> +		 * high inputs */

	/*
	 * Please follow coding style for multi-line comments
	 */

> +		if (data->adc_maxes[ch_num] > ADC_MAX_LOW_MEASUREMENT_MV)
> +			adc_range = 1;
> +
> +		/* set the attenuator and mux */
> +		reg = (adc_range << 4) | ch_num;

If you assign (1 << 4) to adc_range above, you don't need to shift here and make life a bit easier on the compiler.

> +		i2c_smbus_write_byte_data(data->client, ADC_MUX, reg);

error check ?

> +
> +		/* wait at least Tconvert time (200 us) for the
> +		 * conversion to complete */

multi-line comment

> +		udelay(200);
> +
> +		/* check if the done bit is set */
> +		reg = i2c_smbus_read_byte_data(data->client, ADC_VALUE_LOW);

error check ? (reg needs to be int for that to work)

> +		if (reg & 0x01) {

Datasheet says you don't need to check this bit after waiting for the maximum Tconvert.

> +			/* we have a valid conversion to read */
> +			reading = reg >> 4;
> +			reg = i2c_smbus_read_byte_data(data->client,
> +					ADC_VALUE_HIGH);

This can return an error (and is then negative). You should check for that condition and handle it. Since the function always returns values >= 0 if there is no error, you can return the negative error code and report it to the user.

> +			reading |= (unsigned int)reg << 4;

Unnecessary typecast.

> +
> +			/* now convert the reading to a voltage */
> +			data->adc_values[ch_num] = reading * ADC_STEP_MV;

Is the factor the same for both low and high range ? Shouldn't the factor be 6 for the high range ?

> +		}

else error (though the conditional should not be necessary per above) ?

> +
> +		data->adc_last_updated[ch_num] = jiffies;
> +		data->adc_valid[ch_num] = 1;

					= true;
and please move inside the if() statement. Otherwise the value is treated as updated even if it wasn't.

> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data->adc_values[ch_num];
> +}
> +
> +
Single empty line

> +/* Shows the voltage associated with the specified ADC channel */ 
> +static ssize_t powr1220_show_voltage(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	int adc_val = powr1220_read_adc(dev, attr->index);
> +
> +	return sprintf(buf, "%d\n", adc_val); }
> +
> +
> +/* Shows the maximum setting associated with the specified ADC 
> +channel */ static ssize_t powr1220_show_max(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", data->adc_maxes[attr->index]); }
> +
> +
Single empty line

> +/* Sets the maximum setting associated with the specified ADC channel 
> +*/ static ssize_t powr1220_set_max(struct device *dev,
> +	struct device_attribute *dev_attr, const char *buf, size_t count) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = dev_get_drvdata(dev);
> +	unsigned long max;
> +	int error;
> +
> +	error = kstrtol(buf, 10, &max);
> +	if (error)
> +		return error;
> +
> +	max = clamp_val(max, 0, ADC_MAX_HIGH_MEASUREMENT_MV);
> +
> +	data->adc_maxes[attr->index] = max;
> +
It might make sense to set adc_maxes[] to either ADC_MAX_LOW_MEASUREMENT_MV or ADC_MAX_HIGH_MEASUREMENT_MV depending on the entered value. Otherwise returns a pretty much random number which doesn't really make much sense.
If you set it to one of the two values, at least the user will have an idea if the value was too low.

Alternative (which I would prefer) would be to auto-configure the max value and get rid of the max attributes. This should be quite simple:
- start with the large range.
- if the reported voltage is below ADC_MAX_LOW_MEASUREMENT_MV,
   remember it and use the low range next time.
- if, with the range set to ADC_MAX_LOW_MEASUREMENT_MV, the reported value
   gets close to ADC_MAX_LOW_MEASUREMENT_MV, switch to the larger range.

> +	return count;
> +}
> +
> +
Single empty line

> +/* Shows the label associated with the specified ADC channel */ 
> +static ssize_t powr1220_show_label(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf) {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +
> +	return sprintf(buf, "%s\n", input_names[attr->index]); }
> +
> +
Single empty line

> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON1);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON2);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON3);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON4);
> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON5);
> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON6);
> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON7);
> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON8);
> +static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON9);
> +static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON10);
> +static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON11);
> +static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VMON12);
> +static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VCCA);
> +static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, powr1220_show_voltage, NULL,
> +	VCCINP);
> +
> +static SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON1);
> +static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON2);
> +static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON3);
> +static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON4);
> +static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON5);
> +static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON6);
> +static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON7);
> +static SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON8);
> +static SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON9);
> +static SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON10);
> +static SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON11);
> +static SENSOR_DEVICE_ATTR(in11_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VMON12);
> +static SENSOR_DEVICE_ATTR(in12_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VCCA);
> +static SENSOR_DEVICE_ATTR(in13_max, S_IWUSR | S_IRUGO, powr1220_show_max,
> +	powr1220_set_max, VCCINP);
> +
> +static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON1);
> +static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON2);
> +static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON3);
> +static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON4);
> +static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON5);
> +static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON6);
> +static SENSOR_DEVICE_ATTR(in6_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON7);
> +static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON8);
> +static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON9);
> +static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON10);
> +static SENSOR_DEVICE_ATTR(in10_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON11);
> +static SENSOR_DEVICE_ATTR(in11_label, S_IRUGO, powr1220_show_label, NULL,
> +	VMON12);
> +static SENSOR_DEVICE_ATTR(in12_label, S_IRUGO, powr1220_show_label, NULL,
> +	VCCA);
> +static SENSOR_DEVICE_ATTR(in13_label, S_IRUGO, powr1220_show_label, NULL,
> +	VCCINP);
> +
> +
> +
Single empty line

> +static struct attribute *powr1220_attrs[] = {
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_in8_input.dev_attr.attr,
> +	&sensor_dev_attr_in9_input.dev_attr.attr,
> +	&sensor_dev_attr_in10_input.dev_attr.attr,
> +	&sensor_dev_attr_in11_input.dev_attr.attr,
> +	&sensor_dev_attr_in12_input.dev_attr.attr,
> +	&sensor_dev_attr_in13_input.dev_attr.attr,
> +
> +	&sensor_dev_attr_in0_max.dev_attr.attr,
> +	&sensor_dev_attr_in1_max.dev_attr.attr,
> +	&sensor_dev_attr_in2_max.dev_attr.attr,
> +	&sensor_dev_attr_in3_max.dev_attr.attr,
> +	&sensor_dev_attr_in4_max.dev_attr.attr,
> +	&sensor_dev_attr_in5_max.dev_attr.attr,
> +	&sensor_dev_attr_in6_max.dev_attr.attr,
> +	&sensor_dev_attr_in7_max.dev_attr.attr,
> +	&sensor_dev_attr_in8_max.dev_attr.attr,
> +	&sensor_dev_attr_in9_max.dev_attr.attr,
> +	&sensor_dev_attr_in10_max.dev_attr.attr,
> +	&sensor_dev_attr_in11_max.dev_attr.attr,
> +	&sensor_dev_attr_in12_max.dev_attr.attr,
> +	&sensor_dev_attr_in13_max.dev_attr.attr,
> +
> +	&sensor_dev_attr_in0_label.dev_attr.attr,
> +	&sensor_dev_attr_in1_label.dev_attr.attr,
> +	&sensor_dev_attr_in2_label.dev_attr.attr,
> +	&sensor_dev_attr_in3_label.dev_attr.attr,
> +	&sensor_dev_attr_in4_label.dev_attr.attr,
> +	&sensor_dev_attr_in5_label.dev_attr.attr,
> +	&sensor_dev_attr_in6_label.dev_attr.attr,
> +	&sensor_dev_attr_in7_label.dev_attr.attr,
> +	&sensor_dev_attr_in8_label.dev_attr.attr,
> +	&sensor_dev_attr_in9_label.dev_attr.attr,
> +	&sensor_dev_attr_in10_label.dev_attr.attr,
> +	&sensor_dev_attr_in11_label.dev_attr.attr,
> +	&sensor_dev_attr_in12_label.dev_attr.attr,
> +	&sensor_dev_attr_in13_label.dev_attr.attr,
> +
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(powr1220);
> +
> +
Single empty line

> +static int powr1220_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct powr1220_data *data;
> +	struct device *hwmon_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;

-ENODEV is commonly used here.

> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->update_lock);
> +	data->client = client;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +			client->name, data, powr1220_groups);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +
Single empty line.

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
Please use module_i2c_driver().

> +MODULE_AUTHOR("Scott Kanowitz");
> +MODULE_DESCRIPTION("POWR1220 driver"); MODULE_LICENSE("GPL");
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
