From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Jan 2015 13:22:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ina2xx: allow to change the averaging rate at run-time
Message-Id: <54AD3325.6030301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420634769-11246-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1420634769-11246-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On 01/07/2015 04:46 AM, Bartosz Golaszewski wrote:
> The averaging rate of ina226 is hardcoded to 16 in the driver. Make it
> modifiable at run-time via a new sysfs attribute.
>
> While we're at it - add an additional variable to ina2xx_data, which holds
> the current configuration settings - this way we'll be able to restore the
> configuration in case of an unexpected chip reset.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   Documentation/hwmon/ina2xx |   4 ++
>   drivers/hwmon/ina2xx.c     | 110 +++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 110 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> index 320dd69..4b7fb47 100644
> --- a/Documentation/hwmon/ina2xx
> +++ b/Documentation/hwmon/ina2xx
> @@ -48,3 +48,7 @@ The shunt value in micro-ohms can be set via platform data or device tree at
>   compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>   refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
>   if the device tree is used.
> +
> +The averaging rate of INA226 and INA230 can be changed via the avg_rate sysfs
> +attribute. The available rates are: 1, 4, 16, 64, 128, 256, 512 and 1024. Other
> +inputs will be rounded to the nearest value in the above list.
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 49537ea..868fd5c 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -68,6 +68,16 @@
>
>   #define INA2XX_RSHUNT_DEFAULT		10000
>
> +/* bit masks for the averaging setting in the configuration register */
> +#define INA226_AVG_RD_MASK		0x0E00
> +#define INA226_AVG_WR_MASK		~INA226_AVG_RD_MASK

I meant just define INA226_AVG_MASK and use ~INA226_AVG_MASK directly.

> +
> +#define INA226_READ_AVG(reg) ((reg & INA226_AVG_RD_MASK) >> 9)

		(reg)

> +#define INA226_SHIFT_AVG(val) (val << 9)

		(val)

This is to avoid situations where 'reg' and 'val' are expressions,
which may cause bad results.

> +
> +/* common attrs, ina226 attrs and NULL */
> +#define INA2XX_MAX_ATTRIBUTE_GROUPS	3
> +
>   enum ina2xx_ids { ina219, ina226 };
>
>   struct ina2xx_config {
> @@ -85,12 +95,14 @@ struct ina2xx_data {
>   	const struct ina2xx_config *config;
>
>   	long rshunt;
> +	u16 curr_config;
>
>   	struct mutex update_lock;
>   	bool valid;
>   	unsigned long last_updated;
>
>   	int kind;
> +	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>   	u16 regs[INA2XX_MAX_REGISTERS];
>   };
>
> @@ -115,6 +127,27 @@ static const struct ina2xx_config ina2xx_config[] = {
>   	},
>   };
>
> +/*
> + * Available averaging rates for ina226. The indices correspond with
> + * the bit values expected by the chip (according to the ina226 datasheet,
> + * table 3 AVG bit settings, found at
> + * http://www.ti.com/lit/ds/symlink/ina226.pdf.
> + */
> +static const int ina226_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
> +
> +static int ina226_avg_bits(int avg)
> +{
> +	int i;
> +
> +	/* Get the closest average from the tab. */
> +	for (i = 0; i < ARRAY_SIZE(ina226_avg_tab) - 1; i++) {
> +		if (avg <= (ina226_avg_tab[i] + ina226_avg_tab[i + 1]) / 2)
> +			break;
> +	}
> +
> +	return i; /* Return 0b0111 for values greater than 1024. */
> +}
> +
>   static int ina2xx_calibrate(struct ina2xx_data *data)
>   {
>   	return i2c_smbus_write_word_swapped(data->client, INA2XX_CALIBRATION,
> @@ -131,7 +164,7 @@ static int ina2xx_init(struct ina2xx_data *data)
>
>   	/* device configuration */
>   	ret = i2c_smbus_write_word_swapped(client, INA2XX_CONFIG,
> -					   data->config->config_default);
> +					   data->curr_config);
>   	if (ret < 0)
>   		return ret;
>
> @@ -292,6 +325,54 @@ static ssize_t ina2xx_set_shunt(struct device *dev,
>   	return count;
>   }
>
> +static ssize_t ina226_show_avg(struct device *dev,
> +			       struct device_attribute *da, char *buf)
> +{
> +	struct ina2xx_data *data = ina2xx_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +			ina226_avg_tab[INA226_READ_AVG(
> +				       data->regs[INA2XX_CONFIG])]);

This is where an interim variable comes handy; avoids the line splits.
Not necessary, but I would suggest it.

> +}
> +
> +static ssize_t ina226_set_avg(struct device *dev,
> +			      struct device_attribute *da,
> +			      const char *buf, size_t count)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int status, avg;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	status = kstrtoul(buf, 10, &val);
> +	if (status < 0)
> +		return status;
> +
> +	if (val > INT_MAX || val = 0)
> +		return -EINVAL;
> +
> +	avg = ina226_avg_bits(val);
> +
> +	mutex_lock(&data->update_lock);
> +	data->curr_config = (data->regs[INA2XX_CONFIG] &
> +			     INA226_AVG_WR_MASK) | INA226_SHIFT_AVG(avg);
> +	status = i2c_smbus_write_word_swapped(data->client,
> +					      INA2XX_CONFIG,
> +					      data->curr_config);
> +	/* Make sure the next access re-reads all registers. */
> +	data->valid = 0;
> +	mutex_unlock(&data->update_lock);
> +	if (status < 0)
> +		return status;
> +
> +	return count;
> +}
> +
>   /* shunt voltage */
>   static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
>   			  INA2XX_SHUNT_VOLTAGE);
> @@ -313,6 +394,10 @@ static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
>   			  ina2xx_show_value, ina2xx_set_shunt,
>   			  INA2XX_CALIBRATION);
>
> +/* averaging rate */
> +static SENSOR_DEVICE_ATTR(avg_rate, S_IRUGO | S_IWUSR,
> +			  ina226_show_avg, ina226_set_avg, 0);
> +

I think I know what to do here. Can you look into the ina209 driver ?
It uses update_interval and calculates the number of samples to use from it.
The ina226 datasheet suggests that we can do the same, combined with the
conversion time configuration. We would have to use the default conversion
time of 1.1ms for that to make sense, but that is what it is today,
so it would be ok. This way we are in line with the ABI and can still
configure the number of averages.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
