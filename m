From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Jan 2015 17:05:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) implement update_interval attribute for ina226
Message-Id: <20150108170519.GA30248@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420734313-24546-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1420734313-24546-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, Jan 08, 2015 at 05:25:13PM +0100, Bartosz Golaszewski wrote:
> This attribute allows to configure the update interval of ina226. Although
> the bus and shunt voltage conversion times remain hardcoded to 1.1 ms, we can
> now modify said interval by changing the averaging rate.
> 
> While we're at it - add an additional variable to ina2xx_data, which holds
> the current configuration settings - this way we'll be able to restore the
> configuration in case of an unexpected chip reset.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/hwmon/ina2xx |   3 +
>  drivers/hwmon/ina2xx.c     | 133 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 132 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> index 320dd69..f4f2696 100644
> --- a/Documentation/hwmon/ina2xx
> +++ b/Documentation/hwmon/ina2xx
> @@ -48,3 +48,6 @@ The shunt value in micro-ohms can be set via platform data or device tree at
>  compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>  refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
>  if the device tree is used.
> +
> +Additionally ina226 supports update_interval attribute as described in
> +Documentation/hwmon/sysfs-interface.

Hi Bartosz,

A more detailed explanation, describing how the update interval translates to
the number of averages, would be helpful.

> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 49537ea..048c229 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -68,6 +68,21 @@
>  
>  #define INA2XX_RSHUNT_DEFAULT		10000
>  
> +/* bit mask for reading the averaging setting in the configuration register */
> +#define INA226_AVG_RD_MASK		0x0E00
> +
> +#define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
> +#define INA226_SHIFT_AVG(val)		((val) << 9)
> +
> +/* common attrs, ina226 attrs and NULL */
> +#define INA2XX_MAX_ATTRIBUTE_GROUPS	3
> +
> +/*
> + * Both bus voltage and shunt voltage conversion times for ina226 are set
> + * to 0b0100 on POR, which translates to 1100 microseconds.
> + */
> +#define INA226_CONV_TIME_DEFAULT	1100
> +
>  enum ina2xx_ids { ina219, ina226 };
>  
>  struct ina2xx_config {
> @@ -85,12 +100,14 @@ struct ina2xx_data {
>  	const struct ina2xx_config *config;
>  
>  	long rshunt;
> +	u16 curr_config;
>  
>  	struct mutex update_lock;
>  	bool valid;
>  	unsigned long last_updated;
>  
>  	int kind;
> +	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>  	u16 regs[INA2XX_MAX_REGISTERS];
>  };
>  
> @@ -115,6 +132,48 @@ static const struct ina2xx_config ina2xx_config[] = {
>  	},
>  };
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
> +static int ina226_reg_to_interval(u16 config)
> +{
> +	int avg = ina226_avg_tab[INA226_READ_AVG(config)];
> +
> +	/*
> +	 * Add bus and shunt voltage conversion times and multiple them
> +	 * by the averaging rate. Return the result in milliseconds.
> +	 */
> +	return (avg * 2 * INA226_CONV_TIME_DEFAULT) / 1000;

What is the purpose of multiplying the calculated average by 2 ?

Using DIV_ROUND_CLOSEST() might be a better choice to reduce rounding errors.

> +}
> +
> +static u16 ina226_interval_to_reg(int interval, u16 config)
> +{
> +	int avg, avg_bits;
> +
> +	avg = (interval * 1000) / (2 * INA226_CONV_TIME_DEFAULT);

Another multiplication by 2 without explanation.

Using DIV_ROUND_CLOSEST() might be a better choice.

You should use the actual update interval in ina2xx_update_device(),
since it no longer makes sense to use the static 'HZ / INA2XX_CONVERSION_RATE'.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
