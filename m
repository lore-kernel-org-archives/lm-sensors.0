From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 23 Oct 2015 16:52:35 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: ina2xx: port to using remap, improve bandwidth.
Message-Id: <562A65D3.8090306@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <56263973.300@roeck-us.net>
 <1445616800-21329-1-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1445616800-21329-1-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, bcousson@baylibre.com

On 10/23/2015 09:13 AM, Marc Titinger wrote:
> With the current implementation, the driver will prevent a readout at a
> pace faster than the default conversion time (2ms) times the averaging
> setting, min AVG being 1:1.
>
> Any sysfs "show" read access from the client app faster than 500 Hz will be

500 Hz ?

> 'cached' by the driver, but actually since do_update reads all 8 registers,
> the best achievable measurement rate is roughly 8*800 us (for the time
> spent in i2c-core) i.e. <= 156Hz with Beagle Bone Black.
>
> Registers are now accessed individually through the regmap facility.
> For four measurements the readout rate is now around
>   (1/(4*800us) = 312 Hz.

I'll need some time to go through the patch in detail Some quick comments below.

>
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>   drivers/hwmon/ina2xx.c | 359 ++++++++++++++++++++++---------------------------
>   1 file changed, 159 insertions(+), 200 deletions(-)
>
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 4d28150..e7c1aaa 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -37,6 +37,7 @@
>   #include <linux/of.h>
>   #include <linux/delay.h>
>   #include <linux/util_macros.h>
> +#include <linux/regmap.h>
>
>   #include <linux/platform_data/ina2xx.h>
>
> @@ -48,32 +49,25 @@
>   #define INA2XX_CURRENT			0x04 /* readonly */
>   #define INA2XX_CALIBRATION		0x05
>
> -/* INA226 register definitions */
> -#define INA226_MASK_ENABLE		0x06
> -#define INA226_ALERT_LIMIT		0x07
> -#define INA226_DIE_ID			0xFF
> -
> -/* register count */
> -#define INA219_REGISTERS		6
> -#define INA226_REGISTERS		8
> -
> -#define INA2XX_MAX_REGISTERS		8
> +/* CONFIG register fields */
> +#define INA2XX_AVG_MASK			0x0E00
> +#define INA2XX_AVG_SHFT			9
>
>   /* settings - depend on use case */
>   #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
>   #define INA226_CONFIG_DEFAULT		0x4527	/* averages */
>
>   /* worst case is 68.10 ms (~14.6Hz, ina219) */
> -#define INA2XX_CONVERSION_RATE		15
>   #define INA2XX_MAX_DELAY		69 /* worst case delay in ms */
>
>   #define INA2XX_RSHUNT_DEFAULT		10000
>
> -/* bit mask for reading the averaging setting in the configuration register */
> -#define INA226_AVG_RD_MASK		0x0E00
> -
> -#define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
> -#define INA226_SHIFT_AVG(val)		((val) << 9)
> +/* Currently only handling common register set */
> +static const struct regmap_config INA2XX_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = INA2XX_CALIBRATION,
> +};
>
>   /* common attrs, ina226 attrs and NULL */
>   #define INA2XX_MAX_ATTRIBUTE_GROUPS	3
> @@ -89,7 +83,6 @@ enum ina2xx_ids { ina219, ina226 };
>   struct ina2xx_config {
>   	u16 config_default;
>   	int calibration_factor;
> -	int registers;
>   	int shunt_div;
>   	int bus_voltage_shift;
>   	int bus_voltage_lsb;	/* uV */
> @@ -99,25 +92,16 @@ struct ina2xx_config {
>   struct ina2xx_data {
>   	struct i2c_client *client;
>   	const struct ina2xx_config *config;
> -
> +	struct regmap *regmap;
>   	long rshunt;
> -	u16 curr_config;
> -
> -	struct mutex update_lock;
> -	bool valid;
> -	unsigned long last_updated;
> -	int update_interval; /* in jiffies */
> -
> -	int kind;
> +	int valid;

bool, please. But then valid was supposed to be used to indicate
if the cache is valid, and should no longer be needed since there
is no more cache. I'll have to spend more time to understand if and
why it is still needed and how it is used.

>   	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
> -	u16 regs[INA2XX_MAX_REGISTERS];
>   };
>
>   static const struct ina2xx_config ina2xx_config[] = {
>   	[ina219] = {
>   		.config_default = INA219_CONFIG_DEFAULT,
>   		.calibration_factor = 40960000,
> -		.registers = INA219_REGISTERS,
>   		.shunt_div = 100,
>   		.bus_voltage_shift = 3,
>   		.bus_voltage_lsb = 4000,
> @@ -126,7 +110,6 @@ static const struct ina2xx_config ina2xx_config[] = {
>   	[ina226] = {
>   		.config_default = INA226_CONFIG_DEFAULT,
>   		.calibration_factor = 5120000,
> -		.registers = INA226_REGISTERS,
>   		.shunt_div = 400,
>   		.bus_voltage_shift = 0,
>   		.bus_voltage_lsb = 1250,
> @@ -142,9 +125,9 @@ static const struct ina2xx_config ina2xx_config[] = {
>    */
>   static const int ina226_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
>
> -static int ina226_reg_to_interval(u16 config)
> +static int ina226_field_to_interval(int field)
>   {
> -	int avg = ina226_avg_tab[INA226_READ_AVG(config)];
> +	int avg = ina226_avg_tab[field];
>
>   	/*
>   	 * Multiply the total conversion time by the number of averages.
> @@ -153,24 +136,11 @@ static int ina226_reg_to_interval(u16 config)
>   	return DIV_ROUND_CLOSEST(avg * INA226_TOTAL_CONV_TIME_DEFAULT, 1000);
>   }
>
> -static u16 ina226_interval_to_reg(int interval, u16 config)
> -{
> -	int avg, avg_bits;
> -
> -	avg = DIV_ROUND_CLOSEST(interval * 1000,
> -				INA226_TOTAL_CONV_TIME_DEFAULT);
> -	avg_bits = find_closest(avg, ina226_avg_tab,
> -				ARRAY_SIZE(ina226_avg_tab));
> -
> -	return (config & ~INA226_AVG_RD_MASK) | INA226_SHIFT_AVG(avg_bits);
> -}
> -
> -static void ina226_set_update_interval(struct ina2xx_data *data)
> +static int ina226_interval_to_field(int interval)
>   {
> -	int ms;
> -
> -	ms = ina226_reg_to_interval(data->curr_config);
> -	data->update_interval = msecs_to_jiffies(ms);
> +	int avg = DIV_ROUND_CLOSEST(interval * 1000,
> +				    INA226_TOTAL_CONV_TIME_DEFAULT);
> +	return find_closest(avg, ina226_avg_tab, ARRAY_SIZE(ina226_avg_tab));
>   }
>
>   static int ina2xx_calibrate(struct ina2xx_data *data)
> @@ -178,8 +148,7 @@ static int ina2xx_calibrate(struct ina2xx_data *data)
>   	u16 val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
>   				    data->rshunt);
>
> -	return i2c_smbus_write_word_swapped(data->client,
> -					    INA2XX_CALIBRATION, val);
> +	return regmap_write(data->regmap, INA2XX_CALIBRATION, val);
>   }
>
>   /*
> @@ -187,15 +156,10 @@ static int ina2xx_calibrate(struct ina2xx_data *data)
>    */
>   static int ina2xx_init(struct ina2xx_data *data)
>   {
> -	struct i2c_client *client = data->client;
> -	int ret;
> -
> -	/* device configuration */
> -	ret = i2c_smbus_write_word_swapped(client, INA2XX_CONFIG,
> -					   data->curr_config);
> -	if (ret < 0)
> +	int ret = regmap_write(data->regmap, INA2XX_CONFIG,
> +			       data->config->config_default);
> +	if (ret)
>   		return ret;
> -
>   	/*
>   	 * Set current LSB to 1mA, shunt is in uOhms
>   	 * (equation 13 in datasheet).
> @@ -203,22 +167,22 @@ static int ina2xx_init(struct ina2xx_data *data)
>   	return ina2xx_calibrate(data);
>   }
>
> -static int ina2xx_do_update(struct device *dev)
> +static int ina2xx_show_common(struct device *dev, int index, int *val)
>   {
>   	struct ina2xx_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int i, rv, retry;
> +	int err, retry;
>
> -	dev_dbg(&client->dev, "Starting ina2xx update\n");
> +	if (unlikely(!val))
> +		return -EINVAL;

Please no unnecessary parameter checks. If val is NULL here,
something is wrong with the implementation and needs to get fixed.

Besides, the return value is only negative on errors. There is no need
to pass an extra pointer to the value. Furthermore, regmap_read expects
a pointer to an unsigned int, not a pointer to an int.

Just return an error or the value returned by regmap. The calling code
can determine if there is an error by checking if the returned value is < 0.

>
>   	for (retry = 5; retry; retry--) {
> -		/* Read all registers */
> -		for (i = 0; i < data->config->registers; i++) {
> -			rv = i2c_smbus_read_word_swapped(client, i);
> -			if (rv < 0)
> -				return rv;
> -			data->regs[i] = rv;
> -		}
> +
> +		/* Check for remaining registers in mask. */
> +		err = regmap_read(data->regmap, index, val);
> +		if (err)
> +			return err;
> +
> +		dev_dbg(dev, "read %d, val = 0x%04x\n", index, *val);
>
>   		/*
>   		 * If the current value in the calibration register is 0, the
> @@ -226,24 +190,24 @@ static int ina2xx_do_update(struct device *dev)
>   		 * the chip has been reset let's check the calibration
>   		 * register and reinitialize if needed.
>   		 */
> -		if (data->regs[INA2XX_CALIBRATION] = 0) {
> -			dev_warn(dev, "chip not calibrated, reinitializing\n");
> -
> -			rv = ina2xx_init(data);
> -			if (rv < 0)
> -				return rv;
> +		if (!data->valid) {
> +			dev_warn(dev,
> +				 "chip needs calibration, reinitializing\n");
>
> +			err = ina2xx_calibrate(data);
> +			if (err)
> +				return err;

Ah, that is the context of "valid". I don't immediately see why moving its scope
out of this function, and setting it to false in the calling code, is beneficial here.

This also changes the dynamic of the driver. Previously it was specifically able
to detect if the chip was power cycled (for whatever reason) and it would re-initialize
itself. Now you use 'valid' and you defer (re-)initialization until chip registers
are read. I don't immediately see if and how this is beneficial.

>   			/*
>   			 * Let's make sure the power and current registers
>   			 * have been updated before trying again.
>   			 */
>   			msleep(INA2XX_MAX_DELAY);
> +
> +			/* data valid once we have a cal value. */
> +			regmap_read(data->regmap, INA2XX_CALIBRATION,
> +				    &data->valid);
>   			continue;
>   		}
> -
> -		data->last_updated = jiffies;
> -		data->valid = 1;
> -
>   		return 0;
>   	}
>
> @@ -256,86 +220,89 @@ static int ina2xx_do_update(struct device *dev)
>   	return -ENODEV;
>   }
>
> -static struct ina2xx_data *ina2xx_update_device(struct device *dev)
> +static ssize_t ina2xx_show_shunt(struct device *dev,
> +				 struct device_attribute *da, char *buf)
>   {
>   	struct ina2xx_data *data = dev_get_drvdata(dev);
> -	struct ina2xx_data *ret = data;
> -	unsigned long after;
> -	int rv;
> +	int val, err;
>
> -	mutex_lock(&data->update_lock);
> +	err = ina2xx_show_common(dev, INA2XX_SHUNT_VOLTAGE, &val);
> +	if (err)
> +		return err;
>
> -	after = data->last_updated + data->update_interval;
> -	if (time_after(jiffies, after) || !data->valid) {
> -		rv = ina2xx_do_update(dev);
> -		if (rv < 0)
> -			ret = ERR_PTR(rv);
> -	}
> +	val = DIV_ROUND_CLOSEST((s16) val, data->config->shunt_div);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t ina2xx_show_bus(struct device *dev,
> +			       struct device_attribute *da, char *buf)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	int val, err;
> +
> +	err = ina2xx_show_common(dev, INA2XX_BUS_VOLTAGE, &val);
> +	if (err)
> +		return err;
>
> -	mutex_unlock(&data->update_lock);
> -	return ret;
> +	val = (val >> data->config->bus_voltage_shift)
> +	    * data->config->bus_voltage_lsb;
> +	val = DIV_ROUND_CLOSEST(val, 1000);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>   }
>
> -static int ina2xx_get_value(struct ina2xx_data *data, u8 reg)
> +static ssize_t ina2xx_show_pow(struct device *dev,
> +			       struct device_attribute *da, char *buf)
>   {
> -	int val;
> -
> -	switch (reg) {
> -	case INA2XX_SHUNT_VOLTAGE:
> -		/* signed register */
> -		val = DIV_ROUND_CLOSEST((s16)data->regs[reg],
> -					data->config->shunt_div);
> -		break;
> -	case INA2XX_BUS_VOLTAGE:
> -		val = (data->regs[reg] >> data->config->bus_voltage_shift)
> -		  * data->config->bus_voltage_lsb;
> -		val = DIV_ROUND_CLOSEST(val, 1000);
> -		break;
> -	case INA2XX_POWER:
> -		val = data->regs[reg] * data->config->power_lsb;
> -		break;
> -	case INA2XX_CURRENT:
> -		/* signed register, LSB=1mA (selected), in mA */
> -		val = (s16)data->regs[reg];
> -		break;
> -	case INA2XX_CALIBRATION:
> -		val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
> -					data->regs[reg]);
> -		break;
> -	default:
> -		/* programmer goofed */
> -		WARN_ON_ONCE(1);
> -		val = 0;
> -		break;
> -	}
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	int val, err;
> +
> +	err = ina2xx_show_common(dev, INA2XX_POWER, &val);
> +	if (err)
> +		return err;
> +
> +	val *= data->config->power_lsb;
>
> -	return val;
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>   }
>
> -static ssize_t ina2xx_show_value(struct device *dev,
> -				 struct device_attribute *da, char *buf)
> +static ssize_t ina2xx_show_curr(struct device *dev,
> +				struct device_attribute *da, char *buf)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct ina2xx_data *data = ina2xx_update_device(dev);
> +	int val, err;
>
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	err = ina2xx_show_common(dev, INA2XX_CURRENT, &val);
> +	if (err)
> +		return err;
>
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -			ina2xx_get_value(data, attr->index));
> +	/* signed register, LSB=1mA (selected), in mA */
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t ina2xx_show_cal(struct device *dev,
> +			       struct device_attribute *da, char *buf)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	int val, err;
> +
> +	err = ina2xx_show_common(dev, INA2XX_CALIBRATION, &val);
> +	if (err)
> +		return err;
> +
> +	val = DIV_ROUND_CLOSEST(data->config->calibration_factor, val);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>   }
>
>   static ssize_t ina2xx_set_shunt(struct device *dev,
>   				struct device_attribute *da,
>   				const char *buf, size_t count)
>   {
> -	struct ina2xx_data *data = ina2xx_update_device(dev);
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +
>   	unsigned long val;
>   	int status;
>
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
>   	status = kstrtoul(buf, 10, &val);
>   	if (status < 0)
>   		return status;
> @@ -345,12 +312,8 @@ static ssize_t ina2xx_set_shunt(struct device *dev,
>   	    val > data->config->calibration_factor)
>   		return -EINVAL;
>
> -	mutex_lock(&data->update_lock);
>   	data->rshunt = val;
> -	status = ina2xx_calibrate(data);
> -	mutex_unlock(&data->update_lock);
> -	if (status < 0)
> -		return status;
> +	data->valid = 0;
>
>   	return count;
>   }
> @@ -370,65 +333,58 @@ static ssize_t ina226_set_interval(struct device *dev,
>   	if (val > INT_MAX || val = 0)
>   		return -EINVAL;
>
> -	mutex_lock(&data->update_lock);
> -	data->curr_config = ina226_interval_to_reg(val,
> -						   data->regs[INA2XX_CONFIG]);
> -	status = i2c_smbus_write_word_swapped(data->client,
> -					      INA2XX_CONFIG,
> -					      data->curr_config);
> +	val = ina226_interval_to_field(val);
>
> -	ina226_set_update_interval(data);
> -	/* Make sure the next access re-reads all registers. */
> -	data->valid = 0;
> -	mutex_unlock(&data->update_lock);
> +	status = regmap_update_bits(data->regmap, INA2XX_CONFIG,
> +				    INA2XX_AVG_MASK, (val << INA2XX_AVG_SHFT));
>   	if (status < 0)
>   		return status;
>
> +	data->valid = 0;
> +

This now causes re-calibration. Why ?

>   	return count;
>   }
>
>   static ssize_t ina226_show_interval(struct device *dev,
>   				    struct device_attribute *da, char *buf)
>   {
> -	struct ina2xx_data *data = ina2xx_update_device(dev);
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	int status, val;
>
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	status = regmap_read(data->regmap, INA2XX_CONFIG, &val);
> +	if (status)
> +		return status;
> +
> +	val = (val & INA2XX_AVG_MASK) >> INA2XX_AVG_SHFT;
> +	val = ina226_field_to_interval(val);
>
>   	/*
> -	 * We don't use data->update_interval here as we want to display
> -	 * the actual interval used by the chip and jiffies_to_msecs()
> -	 * doesn't seem to be accurate enough.
> +	 * We want to display the actual interval used by the chip.
>   	 */
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -			ina226_reg_to_interval(data->regs[INA2XX_CONFIG]));
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>   }
>
>   /* shunt voltage */
> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_shunt, NULL,
>   			  INA2XX_SHUNT_VOLTAGE);

If you no longer use the register parameter, there is no need to provide it.
But then I'll have to spend some time trying to understand _why_ you don't
use it anymore and why you introduced separate show functions.
Some explanation might help.

>
>   /* bus voltage */
> -static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_value, NULL,
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_bus, NULL,
>   			  INA2XX_BUS_VOLTAGE);
>
>   /* calculated current */
> -static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_value, NULL,
> +static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_curr, NULL,
>   			  INA2XX_CURRENT);
>
>   /* calculated power */
> -static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_value, NULL,
> +static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_pow, NULL,
>   			  INA2XX_POWER);
>
>   /* shunt resistance */
>   static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
> -			  ina2xx_show_value, ina2xx_set_shunt,
> +			  ina2xx_show_cal, ina2xx_set_shunt,
>   			  INA2XX_CALIBRATION);
>
> -/* update interval (ina226 only) */
> -static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
> -			  ina226_show_interval, ina226_set_interval, 0);
> -
>   /* pointers to created device attributes */
>   static struct attribute *ina2xx_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
> @@ -443,6 +399,10 @@ static const struct attribute_group ina2xx_group = {
>   	.attrs = ina2xx_attrs,
>   };
>
> +/* update interval (ina226 only) */
> +static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
> +			  ina226_show_interval, ina226_set_interval, 0);
> +

I don't really see the value of moving this code around.
Please no unnecessary changes.

>   static struct attribute *ina226_attrs[] = {
>   	&sensor_dev_attr_update_interval.dev_attr.attr,
>   	NULL,
> @@ -452,65 +412,65 @@ static const struct attribute_group ina226_group = {
>   	.attrs = ina226_attrs,
>   };
>
> +
>   static int ina2xx_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
> -	struct i2c_adapter *adapter = client->adapter;
>   	struct ina2xx_platform_data *pdata;
>   	struct device *dev = &client->dev;
>   	struct ina2xx_data *data;
>   	struct device *hwmon_dev;
> +	struct regmap *regmap;
>   	u32 val;
>   	int ret, group = 0;
>
> -	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
> -		return -ENODEV;
> +	/* Register regmap */
> +	regmap = devm_regmap_init_i2c(client, &INA2XX_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(regmap);
> +	}
>
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>
> -	if (dev_get_platdata(dev)) {
> -		pdata = dev_get_platdata(dev);
> -		data->rshunt = pdata->shunt_uohms;
> -	} else if (!of_property_read_u32(dev->of_node,
> -					 "shunt-resistor", &val)) {
> -		data->rshunt = val;
> -	} else {
> -		data->rshunt = INA2XX_RSHUNT_DEFAULT;
> -	}
> +	data->regmap = regmap;
>
> -	/* set the device type */
> -	data->kind = id->driver_data;
> -	data->config = &ina2xx_config[data->kind];
> -	data->curr_config = data->config->config_default;
> +	/* Set config according to device type. */
> +	data->config = &ina2xx_config[id->driver_data];
>   	data->client = client;
>
> -	/*
> -	 * Ina226 has a variable update_interval. For ina219 we
> -	 * use a constant value.
> +	/* Check for shunt resistor value.
> +	 * Give precedence to device tree over must-recompile.
>   	 */
> -	if (data->kind = ina226)
> -		ina226_set_update_interval(data);
> -	else
> -		data->update_interval = HZ / INA2XX_CONVERSION_RATE;
> +	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
> +		pdata = dev_get_platdata(dev);
> +		if (pdata)
> +			val = pdata->shunt_uohms;
> +		else
> +			val = INA2XX_RSHUNT_DEFAULT;
> +	}

This changes priority from platform data first to devicetree configuration first.
As such, it is an unrelated change. If needed, split into a separate patch, and
explain the reasoning, please.

>
> -	if (data->rshunt <= 0 ||
> -	    data->rshunt > data->config->calibration_factor)
> +	if (val <= 0 || val > data->config->calibration_factor) {
> +		dev_err(dev, "Invalid shunt resistor value %li", val);
>   		return -ENODEV;
> +	}
> +	data->rshunt = val;
>
> +	/* Write config to chip, and calibrate */

That comment, if needed, would be more appropriate at the top of the called function.

>   	ret = ina2xx_init(data);
> -	if (ret < 0) {
> -		dev_err(dev, "error configuring the device: %d\n", ret);
> -		return -ENODEV;
> +	if (ret) {
> +		dev_err(dev, "error configuring the device.\n");
> +		return ret;

Please explain whuy this code is better than before. To me it looks like
personal preference, and I don't see the improvement.

>   	}
>
> -	mutex_init(&data->update_lock);
> -
> +	/* Set sensor group according to device type. */

Seems to be obvious to me.

>   	data->groups[group++] = &ina2xx_group;
> -	if (data->kind = ina226)
> +	if (ina226 = id->driver_data)

Not likely to accept Yoda programming I am.

>   		data->groups[group++] = &ina226_group;
>
> +	/* register to hwmon */

Isn't that obvious ? I don't see the value of this comment.

>   	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>   							   data, data->groups);
>   	if (IS_ERR(hwmon_dev))
> @@ -541,7 +501,6 @@ static struct i2c_driver ina2xx_driver = {
>   };
>
>   module_i2c_driver(ina2xx_driver);
> -

Does this change fix a checkpatch problem ? If so, please submit as separate patch.
If not, please no unnecessary whitespace changes.

>   MODULE_AUTHOR("Lothar Felten <l-felten@ti.com>");
>   MODULE_DESCRIPTION("ina2xx driver");
>   MODULE_LICENSE("GPL");
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
