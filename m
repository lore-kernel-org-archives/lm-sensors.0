From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 May 2010 08:12:23 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (ltc4245) read only one GPIO pin
Message-Id: <20100521101223.0533c2b2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-2-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-2-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

Sorry for the late answer.

On Tue, 13 Apr 2010 15:59:28 -0700, Ira W. Snyder wrote:
> Read only one of the GPIO pins as an analog voltage. The ADC can be
> switched to a different GPIO pin at runtime, but this is not supported.
> 
> Previously, this driver would report the analog voltage of the currently
> selected GPIO pin as all three GPIO voltages: in9_input, in10_input and
> in11_input.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Patch applied, thanks.

> ---
>  Documentation/hwmon/ltc4245 |    4 +---
>  drivers/hwmon/ltc4245.c     |   20 ++++++--------------
>  2 files changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
> index 02838a4..86b5880 100644
> --- a/Documentation/hwmon/ltc4245
> +++ b/Documentation/hwmon/ltc4245
> @@ -72,9 +72,7 @@ in6_min_alarm		5v  output undervoltage alarm
>  in7_min_alarm		3v  output undervoltage alarm
>  in8_min_alarm		Vee (-12v) output undervoltage alarm
>  
> -in9_input		GPIO #1 voltage data
> -in10_input		GPIO #2 voltage data
> -in11_input		GPIO #3 voltage data
> +in9_input		GPIO voltage data
>  
>  power1_input		12v power usage (mW)
>  power2_input		5v  power usage (mW)
> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
> index 65c232a..84e6f32 100644
> --- a/drivers/hwmon/ltc4245.c
> +++ b/drivers/hwmon/ltc4245.c
> @@ -45,9 +45,7 @@ enum ltc4245_cmd {
>  	LTC4245_VEEIN			= 0x19,
>  	LTC4245_VEESENSE		= 0x1a,
>  	LTC4245_VEEOUT			= 0x1b,
> -	LTC4245_GPIOADC1		= 0x1c,
> -	LTC4245_GPIOADC2		= 0x1d,
> -	LTC4245_GPIOADC3		= 0x1e,
> +	LTC4245_GPIOADC			= 0x1c,
>  };
>  
>  struct ltc4245_data {
> @@ -61,7 +59,7 @@ struct ltc4245_data {
>  	u8 cregs[0x08];
>  
>  	/* Voltage registers */
> -	u8 vregs[0x0f];
> +	u8 vregs[0x0d];
>  };
>  
>  static struct ltc4245_data *ltc4245_update_device(struct device *dev)
> @@ -86,9 +84,9 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
>  				data->cregs[i] = val;
>  		}
>  
> -		/* Read voltage registers -- 0x10 to 0x1f */
> +		/* Read voltage registers -- 0x10 to 0x1c */
>  		for (i = 0; i < ARRAY_SIZE(data->vregs); i++) {
> -			val = i2c_smbus_read_byte_data(client, i+0x10);
> +			val = i2c_smbus_read_byte_data(client, i + 0x10);

Note that I had to revert this coding style change. I want to send this
patch to stable, and coding style changes are frown upon there.

>  			if (unlikely(val < 0))
>  				data->vregs[i] = 0;
>  			else
> @@ -128,9 +126,7 @@ static int ltc4245_get_voltage(struct device *dev, u8 reg)
>  	case LTC4245_VEEOUT:
>  		voltage = regval * -55;
>  		break;
> -	case LTC4245_GPIOADC1:
> -	case LTC4245_GPIOADC2:
> -	case LTC4245_GPIOADC3:
> +	case LTC4245_GPIOADC:
>  		voltage = regval * 10;
>  		break;
>  	default:
> @@ -297,9 +293,7 @@ LTC4245_ALARM(in7_min_alarm,	(1 << 2),	LTC4245_FAULT2);
>  LTC4245_ALARM(in8_min_alarm,	(1 << 3),	LTC4245_FAULT2);
>  
>  /* GPIO voltages */
> -LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC1);
> -LTC4245_VOLTAGE(in10_input,			LTC4245_GPIOADC2);
> -LTC4245_VOLTAGE(in11_input,			LTC4245_GPIOADC3);
> +LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC);
>  
>  /* Power Consumption (virtual) */
>  LTC4245_POWER(power1_input,			LTC4245_12VSENSE);
> @@ -342,8 +336,6 @@ static struct attribute *ltc4245_attributes[] = {
>  	&sensor_dev_attr_in8_min_alarm.dev_attr.attr,
>  
>  	&sensor_dev_attr_in9_input.dev_attr.attr,
> -	&sensor_dev_attr_in10_input.dev_attr.attr,
> -	&sensor_dev_attr_in11_input.dev_attr.attr,
>  
>  	&sensor_dev_attr_power1_input.dev_attr.attr,
>  	&sensor_dev_attr_power2_input.dev_attr.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
